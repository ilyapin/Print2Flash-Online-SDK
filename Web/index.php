<?php
require_once(dirname(__FILE__)."/config.php");
require_once(dirname(__FILE__).'/onlineutils.php');

function CheckConfig()
{
	set_error_handler(function($errno, $errstr, $errfile, $errline, $errcontext) {
	    throw new ErrorException($errstr, 0, $errno, $errfile, $errline);
	});
	try {
		return CheckConfig_impl();
	} finally {
		restore_error_handler();
	}
}

function CreateDB()
{
	$commands = [
		'DROP TABLE IF EXISTS `p2ffile`',
		'CREATE TABLE `p2ffile` ( `id` CHAR(32) NOT NULL, `origname` VARCHAR(128) NOT NULL, `origsize` INT NOT NULL DEFAULT "0", `origcontenttype` varchar(64) DEFAULT NULL, `ext` VARCHAR(8) NOT NULL, `ip` VARCHAR(24) DEFAULT NULL, `time_uploaded` INT NOT NULL, PRIMARY KEY (`id`) )',
		'DROP TABLE IF EXISTS `p2fconv`',
		'CREATE TABLE `p2fconv`( `id` CHAR(32) NOT NULL, `fileid` CHAR(32) NOT NULL, `status` CHAR(1) NOT NULL, `docformat` CHAR(1) NOT NULL DEFAULT "B", `time_converted` INT NOT NULL, PRIMARY KEY (`id`), FOREIGN KEY(fileid) REFERENCES `p2ffile`(id) ON UPDATE CASCADE ON DELETE CASCADE )',
		'CREATE INDEX `idxStatusTimeU` ON `p2fconv` ( `status`, `time_converted` )',
		'DROP TABLE IF EXISTS `p2fconverror`',
		'CREATE TABLE `p2fconverror`(`convid` CHAR(32) NOT NULL, `error` TEXT NOT NULL, PRIMARY KEY(convid), FOREIGN KEY(convid) REFERENCES `p2fconv`(id) ON UPDATE CASCADE ON DELETE CASCADE )'
	];
	foreach ($commands as $sql)
		exec_sql($sql);
}

function CheckConfig_impl()
{
	$result = array();
	// 1.1 Sqlite3 object
	$title = 'PHP Configuration - SQLite3';
	try{
		$ver = SQLite3::version();
		$result['SQLite3Object'] = 
			array(	'result'=>true, 'title'=>$title, 
			  		'successStr'=>"You have SQLite ver. $ver[versionString] installed.");
	} catch (Throwable $e) {
		$result['SQLite3Object'] = 
			array(	'result'=>false, 'title'=>$title, 
					'error'=>'Failed to create new SQLite3 object. Error:',
					'errorPRE'=>$e->getMessage(),
					'suggestion'=>'You may need to install or configure SQLite3 PHP extension. '.
								'See <a href="https://www.php.net/manual/en/sqlite.installation.php" target="_blank">SQLite3 Installing/Configuring</a> for details.'
				);
	}
	
	if ($result['SQLite3Object']['result'] === true)
	{ 
		// 1.2 Sqlite3 database
		$title = 'PHP Configuration - SQLite3 database';
		try{
			$count = select_value("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='p2fconv'");
			if ($count === 0)
				CreateDB();

			$result['SQLite3DB'] =
				array(	'result'=>true, 'title'=>$title, 
						'successStr'=>'Done! Database file: <b>'.DB_FILE.'</b>');
		} catch (Throwable $e) {
			$err = $e->getMessage();
			if (!file_exists(DB_FILE)) {
				$err .= "\nFile (".DB_FILE.") does not exist or can not be accessed. ";
				$result['SQLite3DB']['errorStr'] = $err;
			}
			$path = pathinfo(DB_FILE)['dirname'];
			$suggestion = 
				"<ul><li>Make sure that <b>$path</b> exists.</li> ".
				"<li>Grant Read and Write permissions to <b>$path</b> for the user under which PHP runs (<b>". get_current_user() ."</b>)</li></ul>"; 
			$result['SQLite3DB'] = 
				array(	'result'=>false, 'title'=>$title, 
						'error'=>'Failed to create/open database. Error: ',
						'errorPRE'=>$err, 
						'suggestion'=>$suggestion);
		}
	}
	
	// 1.3 INPUT_DIR check
	$title = 'PHP Configuration - Temp folder ';
	try{
		$tmpDir = INPUT_DIR.'/'.RandomStr(32).".dir";
		mkdir($tmpDir);
		@rmdir($tmpDir);
		$result['PHPInputDIR'] =
			array(	'result'=>true, 'title'=>$title, 
					'successStr'=>'Done! Temporary folder (<b>'.INPUT_DIR.'</b>) test completed.');
	} catch (Throwable $e) {
		$suggestion = 	"<ul><li>Make sure that <b>".INPUT_DIR."</b> exists.</li>".
						"<li>Grant Read and Write permissions to <b>".INPUT_DIR."</b> for the user under which PHP runs (<b>". get_current_user() ."</b>)</li></ul>"; 
		$result['PHPInputDIR'] = 
				array(	'result'=>false, 'title'=>$title, 
						'error'=>"Failed to create temporary folder: ",
						'errorPRE'=>$e->getMessage(),
						'suggestion'=>$suggestion);
	}

	// 1.4 CONVSRV
	$title = "CONVSRV Configuration";
	$suggestion = "";
	try{
		$error="Failed to get CONVSRV status ";
		$SrvStateFileName = INPUT_DIR.'/convsrv.txt';
		if (!file_exists($SrvStateFileName) )
			throw new Exception("$SrvStateFileName not found.");

		try {
			$jsonstr = trim(file_get_contents($SrvStateFileName));
			$convsrv = json_decode($jsonstr,true, 512, JSON_THROW_ON_ERROR);
		} catch (Throwable $e){
			throw new Exception("Failed to decode json ($jsonstr). ".$e->getMessage());
		}
		
		$error="CONVSRV error: ";
		$errtext = "";
		if ($convsrv["P2FError"]){
			$errtext .= "Print2Flash error : $convsrv[P2FError]\n";
			$suggestion .= "<li>Check if Print2Flash is registered in SERVER mode (trial period ended?).<br>".
						   "<a href=\"https://print2flash.com/register\" target=\"_blank\">Obtain a license.</a></li>";
		}
		if ($convsrv["FSError"])
			$errtext .= "File system error : $convsrv[FSError]\n";
		if ($convsrv["DBError"])
			$errtext .= "Database error : $convsrv[DBError]\n";
		$svrTime = $convsrv["UtcTime"];
		$svrTimeStr = date("Y-m-d H:i:s", $svrTime)." UTC";
		if ((time() - $svrTime) > 60 )
			$errtext .= "CONVSRV is not online. Last known online time: $svrTimeStr\n";
		if($errtext)		
			throw new \Exception($errtext);
		
		$result['SRVStatus'] =
			array(	'result'=>true, 'title'=>$title, 
					'successStr'=>"Done! CONVSRV up and running. Converted $convsrv[nConverted]/Errors $convsrv[nErrors]");
	} catch (Throwable $e) {
		$suggestion .= "<li>Make sure that <b>".INPUT_DIR."</b> exists.</li>".
			"<li>Check if <b>/bin/convsrv.exe</b> is running.</li>".
			"<li>Check <b>convsrv.exe</b> configuration : <b>/bin/convsrv.ini</b></li>"; 
		
		$result['SRVStatus'] = 
				array(	'result'=>false, 'title'=>$title, 
						'error'=>$error,
						'errorPRE'=>$e->getMessage(),
						'suggestion'=>'<ul>'.$suggestion.'</ul>');
	}
	return $result;
}

function OutputConfigStep($step) {
	$alert_class = ($step['result']===true)? "alert-success" : "alert-danger";
?>		
	<div class="alert <?=$alert_class?>" role="alert">
		<h6 class="alert-heading"><?=$step['title'] ?></h6>
<?php 
	if ($step['result'] === true) 
		echo $step['successStr']; 
	else { 
		if (array_key_exists('error',$step))
			echo $step['error'];
		if (array_key_exists('errorPRE',$step))
			echo '<pre>'.$step['errorPRE'].'</pre>';
		if (array_key_exists('suggestion',$step))
			echo $step['suggestion'];
	} 
?>			  
	</div>			
<?php } ?>
<!doctype html>
<html lang="en">
<head>
	<title>Print2Flash Online SDK</title>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"> </script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"> </script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"> </script>
</head>
<body>
	<div id="step1" class="card">
		<div class="card-header">Step 1 : Configuration</div>
		<div class="card-body">
<?php
$aConfig = CheckConfig();
$aSteps = array('SQLite3Object', 'SQLite3DB', 'PHPInputDIR', 'SRVStatus');
foreach($aSteps as $step)
	if (array_key_exists($step, $aConfig))
		OutputConfigStep($aConfig[$step]);
?>
		</div>
	</div>
	<div id="step2" class="card">
		<div class="card-header">Step 2 : Upload a document and start conversion</div>
		<div id="step2body" class="card-body">
			<form id="fileForm" method="POST" enctype="multipart/form-data">
			<fieldset>
				<div id="docinforow" class="form-group row" style="display:none">
					<input type="hidden" name="fileid">
					<input type="hidden" name="convid">
					<label for="docinfo" class="col-sm-4 col-form-label">Document to convert:</label>
					<div class="col-sm-6">
						<input id="docinfo" type="text" readonly class="form-control-plaintext">
					</div>
				</div>
				<div id="progressrow" class="form-group row" style="display:none">
					<label for="docinfo" class="col-sm-4 col-form-label">Upload progress:</label>
					<div class="col-sm-6">
						<div id="progress" class="progress">
							<div class="progress-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
					</div>
				</div>
				<div id="docfilerow" class="form-group row">
					<label for="doc" class="col-sm-4 col-form-label">Choose a document to convert:</label>
					<div class="col-sm-6">
						<input id="doc" class="form-control-file" type="file" name="doc" required>
						<div class="invalid-feedback"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="docformat" class="col-sm-4 col-form-label">Choose format:</label>
					<div class="col-sm-6">
						<select id="docformat" name="docformat" class="custom-select">>
							<option value="B" selected>Both HTML5/SVG and Flash/SWF</option>
							<option value="H">HTML5/SVG only</option>
							<option value="F">Flash/SWF only</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-4"></div>
					<div class="col-sm-6">
						<button type="submit" class="btn btn-primary">Convert</button>
						<button type="reset" class="btn btn-secondary">Reset</button>
					</div>
				</div>
			</fieldset>	
			</form>
		</div>
	</div>
	<div id="step3" class="card" style="display:none">
		<div class="card-header">Step 3 : Conversion progress</div>
		<div class="card-body">
			<div id="docLink" style="display:none"><b><a target="_blank" href="">View document</a></b></div>
			<div class="valid-feedback"></div>
			<div class="invalid-feedback"></div>
		</div> 
	</div>

<script>
var max_file_size=<?=MAX_FILE_SIZE?>;

function updateUploadCtrl(stage, text)
{
	if (stage=="reset") {
		$("#progressrow").hide();
		$("#docinforow").hide();
		$("#docfilerow").show();
		$("input[name=fileid]").val(null);
		updateInvalidFeedback(null);
	} else if (stage=="progress") {
		updateProgressBar(0);
		$("#progressrow").show();
		$("#docinforow").hide();
		updateInvalidFeedback(null);
	} else if (stage=="complete") {
		$("#progressrow").hide();
		$("#docinforow").show();
		$("#docinfo").val(text).show();
		$("#docfilerow").hide();
		updateInvalidFeedback(null);
	} else if (stage=="error") {
		$("#progressrow").hide();
		$("#docinforow").hide();
		$("#doc").val(null);
		updateInvalidFeedback(text);
	}
}

function updateInvalidFeedback(text)
{
	if (text !== null)
		$("#docfilerow div.invalid-feedback").text(text).show();
	else
		$("#docfilerow div.invalid-feedback").text("").hide();
}

function updateProgressBar(val)
{
	var percent = val.toFixed() + "%";
	$("#progress div")
		.text(percent)
		.css( "width", percent)
		.prop("aria-valuenow", percent);
}

$( "#doc" ).change(function () {
	try {
		var fn = $("#doc").val();
		if (fn.length <= 0)
			return;

		var file = $("#doc")[0].files[0];
		if (file.size >= max_file_size) {
			updateUploadCtrl("error", "File size exceeds " + Math.round(max_file_size/1024)+"KB");
			return;
		}

		var formdata = new FormData();
		formdata.append("doc", file);

		$.post({
			url: "upload.php",
			data: formdata,
			processData: false,
			contentType: false,
			dataType: "json",
			xhr: function () {
				try {
					var xhr = new XMLHttpRequest();
					xhr.upload.progress = function(evt) {
						if (evt.lengthComputable)
							updateProgressBar(100 * event.loaded / event.total);
					};
					updateUploadCtrl("progress");
					return xhr;
				} catch (e) {
					console.log(e);
					return null;
				}
			}
		})
		.done(function( resp ) {
			if (resp.result) {
				$("input[name=fileid]").val(resp.fileid);
				updateUploadCtrl("complete", resp.text);
			} else
				updateUploadCtrl("error", resp.error);
		})
		.fail(function(jqXHR, textStatus) {
			updateUploadCtrl("error", "Ajax request failed. " + textStatus);
		});
	} catch (e){
		updateInvalidFeedback(e.message);
	}
});

$("#fileForm").submit(function(event) {
	var fileid = $("input[name=fileid]").val();
	var docformat =  $("select[name=docformat]").val();
	if (fileid) {
		var formdata = {
			"fileid":fileid,
			"docformat":docformat
		};

		$.post("convert.php", formdata, null, "json")
		.done(function (resp) {
			step3(resp);
		})
		.fail(function(jqXHR, textStatus) {
			step3({"result":false, "error":textStatus});
		});
	} else 
		updateUploadCtrl("error", "Please select a document");

	event.preventDefault();
});

$("#fileForm").on("reset", function (event) {
	updateUploadCtrl("reset");
});

function step3(resp)
{
	$("#fileForm fieldset").prop("disabled", true);
	$("#step3").show();
	if (resp.result) {
		$("input[name=convid]").val(resp.convid);		
		update_step3_feedback(true, "Your document is being converted. Please wait...");
		setTimeout(conversion_progress, 500);
	} else {
		$("input[name=convid]").val(null);		
		update_step3_feedback(true, resp.error);
	}
}

function update_step3_feedback(bValid, text)
{
	if (bValid){
		$("#step3 div.valid-feedback").text(text).show();
		$("#step3 div.invalid-feedback").hide();
	} else {
		$("#step3 div.invalid-feedback").text(text).show();
		$("#step3 div.valid-feedback").hide();
	}
}

function conversion_progress()
{
	var convid = $("input[name=convid]").val();
	$.post("progress.php",{"convid":convid}, null, "json")
	.done(function(resp) {
		if (resp.result) {
			var text;
			if (resp.result == "Q")
				text = resp.text;
			else if (resp.result == "D"){
				text = "Your document has been converted.";
				$("#docLink a").prop('href', resp.url);
				$("#docLink").show();
			} else if (resp.result == "C"){
				text = "Your document is being converted. Please wait...";
			}
			update_step3_feedback(true, text);
			setTimeout(conversion_progress, 1500);
		} else {
			update_step3_feedback(false, resp.error);
		}
	})
	.fail(function() {
		update_step3_feedback(false, "Ajax request failed.");
	});
}
</script>
</body>
</html>