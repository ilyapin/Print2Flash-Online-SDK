<?php
try
{
	@ob_start();
	require_once(dirname(__FILE__)."/config.php");
	require_once(dirname(__FILE__)."/onlineutils.php");

function SaveUploadedFile($name)
{
	$phpFileUploadErrors = array(
		0 => 'There is no error, the file uploaded with success',
		1 => 'The uploaded file exceeds the upload_max_filesize directive in php.ini',
		2 => 'The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form',
		3 => 'The uploaded file was only partially uploaded',
		4 => 'No file was uploaded',
		6 => 'Missing a temporary folder',
		7 => 'Failed to write file to disk.',
		8 => 'A PHP extension stopped the file upload.'
	);

	$result = array("result"=>false,"text"=>"");
	if (!array_key_exists($name,$_FILES)) {
		$result['error'] = $phpFileUploadErrors[4];
		return $result;
	}

	$fileName = $_FILES[$name]["name"]; // The file name
	$fileTmpLoc = $_FILES[$name]["tmp_name"]; // File in the PHP tmp folder
	$fileType = $_FILES[$name]["type"]; // The type of file it is
	$fileSize = $_FILES[$name]["size"]; // File size in bytes
	$fileErrorMsg = $_FILES[$name]["error"]; // 0 for false... and 1 for true
	if (!$fileTmpLoc) {
		// if file not chosen
		$result['error'] = $phpFileUploadErrors[4];
		return $result;
	}

	if ($fileErrorMsg != 0) {
		$result['error'] = $phpFileUploadErrors[$fileErrorMsg];
		return $result;
	}

	$path_parts = pathinfo($fileName);
	$ext = $path_parts["extension"];

	$foldername = RandomStr(32);
	$sql = "SELECT id FROM p2ffile where id='$foldername'";
	$val = select_value($sql);
	if ($val) {
		// can't really happen
		$result['error'] = "$foldername already exists";
		return $result;
	}

	$folderpath = INPUT_DIR. "\\" . $foldername;
	$bFolderExists = file_exists($folderpath) || file_exists(OUTPUT_DIR . "\\" . $foldername);
	if ($bFolderExists) {
		// can not really happen
		$result['error'] = "$foldername already exists";
		return $result;
	}

	if (!mkdir($folderpath)) {
		$result['error'] = 'mkdir failed';
		return $result;
	}

	if (!move_uploaded_file($fileTmpLoc, $folderpath . "\\doc.$ext")) {
		$result['error'] = 'move_uploaded_file failed';
		return $result;
	}

	$origname = $fileName;
	$origct = $fileType;
	$ip = $_SERVER['REMOTE_ADDR'];

	exec_sql_params(
		"INSERT INTO p2ffile(id, origname, origsize, ext, time_uploaded, origcontenttype, ip) "
		. "VALUES ( :id, :origname, :origsize, :ext, :time_uploaded, :origcontenttype, :ip)",
		array(
			":id"=>$foldername, 
			':origname'=>$origname,  
			':origsize'=>$fileSize, 
			':ext'=>$ext, 
			':time_uploaded'=>time(),
			':origcontenttype'=>$origct,
			':ip'=>$ip
		)
	);

	// success
	$result["result"] = true;
	$result["text"] = "$origname, $fileType, ".round($fileSize / 1024)."KB";
	$result["fileid"] = $foldername;
	return $result;
}

	do_jsonResult(SaveUploadedFile("doc"));

} catch (Throwable $e) {
	do_jsonResult(array("result"=>false,"error"=>$e->getMessage()));
}
?>