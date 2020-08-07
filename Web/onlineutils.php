<?php
function GetVar($name, $default)
{
	if (array_key_exists($name,$_GET)) {
		return $_GET[$name];
	} else if (array_key_exists($name,$_POST)) {
		return $_POST[$name];
	} else
		return $default;
}

function RandomStr($len=32)
{
	$chars = "abcdefghijklmnopqrstuvwxyz1234567890";
	$result = "";

	if (function_exists('openssl_random_pseudo_bytes')) {
		$chars_len = strlen($chars);
		$r = openssl_random_pseudo_bytes($len);
		for ($i=0; $i<$len; $i++) {
			$v = hexdec(bin2hex($r[$i]));
			$result .= $chars[$v % $chars_len];
		}
	} else {
		$chars_len = strlen($chars)-1;
		for ($i=0; $i<$len; $i++)
			$result .= $chars[mt_rand(0,$chars_len)];
	}
	return $result;
}

function do_jsonResult($result)
{
	while (ob_get_level() > 0)
		ob_end_clean();
	header("Content-type : application/json");
	die(json_encode($result));
}

function GetDB()
{
	global $DB;
	if (!$DB) {
		$DB = new SQLite3(DB_FILE);
		$DB->enableExceptions(true);
		$DB->busyTimeout(BUSY_TIMEOUT);
		$DB->exec('PRAGMA busy_timeout = '.BUSY_TIMEOUT.';');
	}
	return $DB;
}

function select_value($sql, $params=null) 
{
	$row = select_row($sql, $params);
	if (is_array($row))
		return $row[0];
	else
		return false;

}

function bind_params($stmt, $params = null)
{
	if (is_array($params)) {
		foreach ($params as $pname=>$pval) 
			$stmt->bindValue($pname, $pval);
	}
}

function select_row($sql, $params=null) 
{
	$stmt = GetDB()->prepare($sql);
	try{
		bind_params($stmt, $params);
		return $stmt->execute()->fetchArray();
	} finally{
		$stmt->close();
		unset($stmt);
	}
}

function exec_sql($sql)
{
	return exec_sql_params($sql, null);
}

function exec_sql_params($sql, $params)
{
	$stmt = GetDB()->prepare($sql);
	try{
		bind_params($stmt, $params);
		$stmt->execute();
	} finally{
		$stmt->close();
		unset($stmt);
	}
}
?>