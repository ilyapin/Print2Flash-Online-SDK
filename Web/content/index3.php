<?php
// required $foldername $docname $format
if( ! isset($foldername) ||  ! isset($docname) || ! isset($format))
{
	header("Status: 404 Not Found", true, 404);
	die();
}
// format
if ('B'==$format) {
	$bFlash = true;
	$bHTML5 = true;
} else if ('H'==$format) {
	$bHTML5 = true;
	$bFlash = false;
} else { // $format='F'
	$bFlash = true;
	$bHTML5 = false;
}

if(isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on')   
	$link = "https://";   
else  
	$link = "http://";   
// Append the host(domain name, ip) to the URL.   
$link.= $_SERVER['HTTP_HOST'];   
// Append the requested resource location to the URL   
$link.= $_SERVER['REQUEST_URI'];    

$minheight = 100;
?>
<!doctype html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<title>Print2Flash SDK - <?=htmlentities($docname,ENT_NOQUOTES,'UTF-8')?></title>
<script type="text/javascript">
function getAbsPosition(elem) {
	var pos={x:0,y:0};
	while (elem!=null) {
		pos.x += elem.offsetLeft;
		pos.y += elem.offsetTop;
		elem = elem.offsetParent;
	}
	return pos;
}
function _(el){
	return document.getElementById(el);
}
var obj_min_h = <?=$minheight ?>;
function BodyResize(){
	try{
		var cont = 	_("marker");
		var bottom = _("footer");
		var end = _("markerend");
		var pos = getAbsPosition(cont);
		var posbottom = getAbsPosition(bottom);
		var posend = getAbsPosition(end);
		var hw = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
		var width = marker.clientWidth + "px"
		var h = hw - pos.y;
		if (h < obj_min_h)
			h = obj_min_h;
		var obj = _("Print2FlashDoc");
		if (obj) {
			obj.style.height = h + "px";
			obj.style.width = width;
		}
		obj = _("Print2FlashDocembed");
		if (obj) {
			obj.style.height = h + "px";
			obj.style.width = width;
		}
	} catch(e){
		// ignore exceptions		
	}
}
</script>
<style type="text/css">
html, body {
	margin:0;
	padding:0;
	height:100%;
	min-width:300px;
	width:100%;
	overflow:hidden;
}
.doc {
	min-height:<?=$minheight ?>px;
}
</style>
</head>
<body onresize="BodyResize()" onload="BodyResize()">
<h2 style="text-align:center"><?=htmlentities($docname,ENT_NOQUOTES,'UTF-8')?></h2>
<div style="width:100%;text-align:center;padding-bottom:5px;">
Permanent link for this document: 
<b><a target="_blank" href="./"><?=$link?></a></b>
&nbsp;&bull;&nbsp;
<?php if ('B'==$format) {?>
<b>
<a href="doc.php?mode=att&fmt=H">Download Document</a> &nbsp;&bull;&nbsp;
<a href="doc.php?mode=att&fmt=F">Download Flash Document only</a>
<?php } else { ?>
<a href="doc.php?mode=att">Download Document</a>
<?php } ?>
&nbsp;&bull;&nbsp;<a href="../../">Convert Another Document</a>
</b>
</div>
<div id="marker" style="width:100%"></div>
<div>
<!-- Start of document code -->
<script>
<!--
var requiredIEVersion="10";
var requiredFirefoxVersion="11";
var requiredOperaVersion="9";
var requiredSafariVersion="5.1.7"; // 6
var requiredChromeVersion="18";

var br=detectBrowser();
var browser=br[0];
var brversion=br[1];

var appVersion=navigator.appVersion.toLowerCase()
var isIE  = browser=="MSIE";
var isWin = (appVersion.indexOf("win") != -1) ? true : false;
var isMac = /mac/.test(appVersion);
var isSafari = browser=="Safari";
var isOpera = browser=="Opera";
var isChrome = browser=="Chrome";

function detectBrowser() {
    var ua=navigator.userAgent, tem,
    M=ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*([\d\.]+)/i) || [];
    if(/trident/i.test(M[1])){
        tem=  /\brv[ :]+(\d+(\.\d+)?)/g.exec(ua) || [];
        return 'IE '+(tem[1] || '');
    }
    M= M[2]? [M[1], M[2]]:[navigator.appName, navigator.appVersion];
    if((tem= ua.match(/version\/([\.\d]+)/i))!= null) M[1]= tem[1];
    return M;
};

function CheckBrowserVer() {
	var reqVersion;
	if (isIE) reqVersion=requiredIEVersion;
		else if (isSafari) reqVersion=requiredSafariVersion;
			else if (isOpera) reqVersion=requiredOperaVersion;
				else if (browser=="Firefox") reqVersion=requiredFirefoxVersion;
					else if (browser=="Chrome") reqVersion=requiredChromeVersion;
						else return true;
	return CompVersions(brversion,reqVersion)>=0;
}

function CompVersions(ver1,ver2){
	ver1=ver1.split(".");
	ver2=ver2.split(".");
	for (var i=0;i<Math.max(ver1.length,ver2.length);i++) {
		var v1 = i<ver1.length ? parseInt(ver1[i]) : 0;
		var v2 = i<ver2.length ? parseInt(ver2[i]) : 0;
		if (v1<v2) return -1;
			else if (v1>v2) return 1;
	}
	return 0;
}

function GetBrowserUpgradePage(){
	if (isIE) return "http://windows.microsoft.com/en-US/internet-explorer/downloads/ie";
		else if (isSafari) return "https://www.apple.com/safari/";
			else if (isOpera) return "http://www.opera.com/browser/";
				else if (browser=="Firefox") return "http://www.mozilla.com/firefox/";
					else if (browser=="Chrome") return "http://www.google.com/chrome";
						else return "";
}
// -->
</script>

<!-- Start of document placement code -->
<script>
<!--
var name="Print2FlashDoc"

<?php if ($bFlash) { ?>

var FlashUpdatePage="http://get.adobe.com/flashplayer";
var flashdocurl ="doc.php?fmt=F";

function PlaceFlash(force) {
	var oeTags = 
		+ '<embed '
		+ 'style="min-height:' + obj_min_h + 'px" '
		+ 'id="'+name+'embed " '
		+ 'src="' + flashdocurl + '" '
		+ 'quality="best" '
		+ 'name="' + name + '" class="doc" '
		+ 'play="true" '
		+ 'loop="false" '
		+ 'quality="best" '
		+ 'allowScriptAccess="sameDomain" allowFullScreen="true" allowFullScreenInteractive="true" '
		+ 'type="application/x-shockwave-flash" '
		+ 'pluginspage="'+FlashUpdatePage+'" '
		+ 'FlashVars="extName=' + name + '">'
		+ '</embed>';
	document.write(oeTags);
	return true;
}
<?php } ?>
<?php if ($bHTML5) { ?>
var htmldocurl ="<?=$foldername?>/doc.php";
var htmlviewerurl = "../docviewer.html";

function PlaceHTML5() {
	if (CheckBrowserVer()) {
		document.write("<iframe class='doc' id='" + name + "' src='" + htmlviewerurl + "#" + htmldocurl +
						"' border='0' allowfullscreen webkitAllowFullScreen='yes'></iframe>")
		return true
	}
	return false
}
<?php } ?>
function PlaceAlternateContent() {
	var BrowserUpgradePage=GetBrowserUpgradePage();
	document.write("This content is not supported by your browser. Please do one of the following:<UL>"+
	"<LI>Upgrade your browser"+(BrowserUpgradePage ? " by <a href='"+BrowserUpgradePage+"'>clicking here</a>" : "")+
	"<LI>Install the Adobe Flash Player by <a href='"+FlashUpdatePage+"'>clicking here</a></UL>");
}
<?php if ('B'==$format) { ?>
	if (!PlaceHTML5())
		PlaceFlash();
<?php } else if ('F'==$format) { ?>
	PlaceFlash();
<?php } else { ?>
	if (!PlaceHTML5())
		 PlaceAlternateContent()
<?php } ?>
  BodyResize();
  //-->
 </script>
 <noscript>
     This content requires scripts to be enabled in your browser. Please enable scripts in your browser settings.
 </noscript>
 </div>
<!-- End of document placement code -->
<!-- End of document code -->
<div id="markerend"></div>
</body>
</html>