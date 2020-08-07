<?php
try {
	@ob_start();
	require_once(dirname(__FILE__)."/config.php");
	require_once(dirname(__FILE__)."/onlineutils.php");

	$docformat = GetVar('docformat', 'B');
	$docformat = strtoupper($docformat);
	if (!$docformat)
		do_jsonResult(array("result"=>false, "error"=>"ERROR !\$docformat"));
	if (!in_array($docformat, array('F','H','B')))
		do_jsonResult(array("result"=>false, "error"=>"ERROR !in_array(\$docformat)"));

	$fileid = GetVar('fileid', null);
	if (!$fileid) 
		do_jsonResult(array("result"=>false, "error"=>"ERROR !\$fileid"));

	$convid = RandomStr(32);
	exec_sql_params(
		"INSERT INTO p2fconv(id, fileid, status, docformat, time_converted) ".
		"VALUES (:id, :fileid, 'U', :docformat, :time)",
		array(":id"=>$convid, ":fileid"=>$fileid, ":docformat"=>$docformat, ":time"=>time())
	);
	
	do_jsonResult(array("result"=>true, "convid"=>$convid));

} catch (Throwable $e) {
	do_jsonResult(array("result"=>false, "error"=>$e->getMessage()));
}
?>