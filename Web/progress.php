<?php
try {
	@ob_start();
	require_once(dirname(__FILE__)."/config.php");
	require_once(dirname(__FILE__)."/onlineutils.php");

	$convid = GetVar('convid', null);
	if (!$convid) 
		do_jsonResult(array("result"=>false, "error"=>"ERROR !\$convid"));
	
	$row = select_row(
				"SELECT p2fconv.*, p2fconverror.error as `error` ".
				"FROM p2fconv LEFT JOIN p2fconverror ON p2fconverror.convid=p2fconv.id ".
				"WHERE p2fconv.id=:convid", 
				array(':convid'=>$convid));
	if (!$row)
		do_jsonResult(array("result"=>false, "error"=>"$convid not found."));
			
	if ($row['status'] == 'D'){
		do_jsonResult(array("result"=>"D", "url"=>'content/'.$row['id']));
	}
	else if ($row['status'] == 'E') {
		do_jsonResult(array("result"=>false, "error"=>$row["error"]));
	} else if ($row['status'] == 'C')
		do_jsonResult(array("result"=>"C"));
	else if ($row['status'] == 'U') {
		$r = select_row(
			'SELECT count(id) as count_u, sum(CASE WHEN time_converted<=:timeu THEN 1 ELSE 0 END) as count_m'.
			' FROM p2fconv WHERE `status`=\'U\'',
			array(':timeu'=>$row['time_converted']));
		$text = "Your document is in the conversion queue ($r[count_m] of $r[count_u]). Please wait...";
		do_jsonResult(array("result"=>"Q", "text"=> $text));
	} else
		do_jsonResult(array("result"=>false, "error"=>"ERROR\t!\$row[status]=$row[status]"));

} catch (Throwable $e) {
	do_jsonResult(array("result"=>false, "error"=>$e->getMessage()));
}
?>