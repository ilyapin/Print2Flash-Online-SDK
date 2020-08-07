<?php
require_once(dirname(__FILE__)."/../config.php");
require_once(dirname(__FILE__)."/../onlineutils.php");

// required $foldername $docname $format
if( ! isset($foldername) ||  ! isset($docname) || ! isset($format)) {
	header("Status: 404 Not Found", true, 404);
	die();
}
if(  ! isset($fn_swf) ||  ! isset($fn_htm) || ! isset($fn_zip)) {
	header("Status: 404 Not Found", true, 404);
	die();
}

// format
if ('B'==$format) {
	$fmt = GetVar('fmt','H'); // html by default
	$fmt = strtoupper($fmt);
	if ('F' == $fmt)
		$fmt = 'F';
	else 
		$fmt = 'H';
} else if ('H'==$format) { 
	$fmt = 'H';
} else { // $format='F'
	$fmt = 'F';
}

$OutputDir = OUTPUT_DIR;
$mode = GetVar("mode", "normal");
$mode = strtolower($mode);
if($mode == "att"){
	if ('H' == $fmt) {
		$filename = "$OutputDir\\$foldername\\$fn_zip"; 
   		$SaveFileName = "$docname.zip";		
	} else { 
		$filename = "$OutputDir\\$foldername\\$fn_swf"; 
   		$SaveFileName = "$docname.swf";		
	}
	ReturnDocument($filename, true, $SaveFileName);
} else {
	// normal - return flash or html document
	if ('H' == $fmt) {
		$filename = "$OutputDir\\$foldername\\$fn_htm"; // doc.xml
	} else { 
		$filename = "$OutputDir\\$foldername\\$fn_swf"; // doc.swf
	}
	ReturnDocument($filename);
}

function ReturnDocument($filename, $bAttachment=false, $origFileName='')
{
	if( ! file_exists($filename))
	{
		header("Status: 404 Not Found", true, 404);
	   die();
	}
	$filesize = filesize($filename);
	
	if($bAttachment)
	{
	   $bUrlEncode = true;
	   if(array_key_exists("HTTP_USER_AGENT", $_SERVER))
	   {
	      $user_agent = $_SERVER["HTTP_USER_AGENT"];
	      if(strpos($user_agent, "Firefox") !== false)
	         $bUrlEncode = false;// "Firefox";
	   }
	   if($bUrlEncode)
	   {
	      $origFileName = urlencode($origFileName);
	      $origFileName = str_replace('+', '%20', $origFileName);
	   }
	   header("Content-Disposition: attachment; filename=\"$origFileName\"; size=$filesize;");
	}
	// content type from ext
	$ext = strtolower(substr(strrchr($filename, "."), 1));
	if ('xml' == $ext)
		$contenttype = 'text/xml';
	else if ('swf' == $ext) 
		$contenttype = 'application/x-shockwave-flash';
	else  if ('zip' == $ext)
		$contenttype = 'application/zip';
	else
		$contenttype = 'application/octet-stream';
	header("Content-Type: $contenttype");
	
	header("Content-Length: " . $filesize);
	session_cache_limiter("public");
	header("Expires: " . gmdate("D, d M Y H:i:s", time() + 86400 * 365) . " GMT");
	set_time_limit(16*60);
	readfile($filename);
	return true;
}
?>