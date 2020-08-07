<?php
$fs_site_root = dirname(__FILE__); 

define('INPUT_DIR', $fs_site_root."\\input");
define('OUTPUT_DIR', $fs_site_root."\\content");
define('DB_FILE', $fs_site_root."\\db\\p2fsdk2.db");
define('DB_SCHEMA', $fs_site_root."\\db\\schema.sql");

define('MAX_FILE_SIZE', 2*1024*1024);
define('BUSY_TIMEOUT', 15000);
$DB = null;
?>