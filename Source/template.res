        ��  ��                  �  H   T X T _ S C R I P T   H T M L T E M P L A T E       0         ﻿<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>%%TITLE%%</title>
<style type="text/css">
html, body, div {
margin:0;
padding:0;
height:100%;
width:100%;
overflow:hidden;
}
</style>
</head>

<body>
<!-- Start of document code -->
<script type="text/javascript">
<!--

var requiredIEVersion="10";
var requiredFirefoxVersion="11";
var requiredOperaVersion="9";
var requiredSafariVersion="5.1.7"; // 6
var requiredChromeVersion="18";

var br=detectBrowser();
var browser=br[0];
var brversion = br[1];

var appVersion=navigator.appVersion.toLowerCase()
var isIE  = browser=="MSIE";
var isWin = (appVersion.indexOf("win") != -1) ? true : false;
var isMac = /mac/.test(appVersion);
var isSafari = browser=="Safari";
var isOpera = browser=="Opera";
 
function detectBrowser() {
	var ua = navigator.userAgent;
	var M=ua.match(/(edge)\/\s*([\d\.]+)/i);
	if (M!=null) return [M[1], M[2]];

	var tem,
	M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*([\d\.]+)/i) || [];
	if (/trident/i.test(M[1])) {
		tem = /\brv[ :]+(\d+(\.\d+)?)/g.exec(ua) || [];
		return ['MSIE',tem[1]];
	}
	M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion];
	if (!/chrome/i.test(M[0]) && (tem = ua.match(/version\/([\.\d]+)/i)) != null) M[1] = tem[1];
	return M;
}


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

function CompVersions(ver1,ver2)
{
	ver1=ver1.split(".");
	ver2=ver2.split(".");
	for (var i=0;i<Math.max(ver1.length,ver2.length);i++) {
 		if (i == 0) {
			var v1 = i<ver1.length ? parseInt(ver1[i]) : 0;
			var v2 = i<ver2.length ? parseInt(ver2[i]) : 0;
		}
		else {
			var v1 = i<ver1.length ? ver1[i] : "0";
			var v2 = i<ver2.length ? ver2[i] : "0";
		}
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

function GetHTMLDoc(movieName) {
    return document.getElementById(movieName).contentDocument;
}
// -->
</script>

<!-- Start of document placement code -->
<script type="text/javascript">
<!--
var width = "%%WIDTH%%"
var height = "%%HEIGHT%%"
var name = "Print2FlashDoc"
var htmldocurl ="%%HTMLDOCURL%%"
var htmlviewerurl = "%%HTMLVIEWERURL%%"

if (CheckBrowserVer()) {
    document.write("<iframe src='" + htmlviewerurl + "#" + htmldocurl + "' border='1' allowfullscreen webkitAllowFullScreen='yes'" +
                   " scrolling='no' style='min-width:"+width+";width:100px;height:"+ height + "' id='" + name + "'></iframe>");
} else {
	var BrowserUpgradePage = GetBrowserUpgradePage();
	document.write("This content is not supported by your browser. Please upgrade your browser" + (BrowserUpgradePage ? " by <a target='_parent' href='" + BrowserUpgradePage + "'>clicking here</a>" : ""));
}
//-->
</script>
<noscript>
     This content requires scripts to be enabled in your browser. Please enable scripts in your browser settings.
</noscript>
<!-- End of document placement code -->

<!-- End of document code -->

</body>
</html> �'  H   T X T _ S C R I P T   B O T H T E M P L A T E       0         ﻿<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>%%TITLE%%</title>
<style type="text/css">
html, body {
margin:0;
padding:0;
height:100%;
width:100%;
overflow:hidden;
}
</style>
</head>

<body>
<!-- Start of document code -->
<script type="text/javascript">
<!--

var requiredMajorVersion = %%FLASH_VERSION%%;
var requiredMinorVersion = %%FLASH_VERSION_MINOR%%;
var requiredRevision = %%FLASH_VERSION_REV%%;

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

function ControlVersion()
{
	var version = "";

	try {
		var axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");
		version = axo.GetVariable("$version");
	} catch (e) {
	}

	return version;
}

function GetSwfVer(){
    var flashVer = -1;

    if (navigator.plugins != null && navigator.plugins.length > 0) {
        if (navigator.plugins["Shockwave Flash 2.0"] || navigator.plugins["Shockwave Flash"]) {
            var swVer2 = navigator.plugins["Shockwave Flash 2.0"] ? " 2.0" : "";
            var flashDescription = navigator.plugins["Shockwave Flash" + swVer2].description;
            var descArray = flashDescription.split(" ");
            var tempArrayMajor = descArray[2].split(".");
            var versionMajor = tempArrayMajor[0];
            var versionMinor = tempArrayMajor[1];
            var versionRevision = descArray[3];
            if (versionRevision == "") {
                versionRevision = descArray[4];
            }
            if (versionRevision.substring(0, 1) == "d") {
                versionRevision = versionRevision.substring(1);
            } else if (versionRevision.substring(0, 1) == "r") {
                versionRevision = versionRevision.substring(1);
                if (versionRevision.indexOf("d") > 0) {
                    versionRevision = versionRevision.substring(0, versionRevision.indexOf("d"));
                }
            }
            var flashVer = versionMajor + "." + versionMinor + "." + versionRevision;
        }
    }
    else if (isIE && isWin && !isOpera) {
        flashVer = ControlVersion();
    }
    return flashVer;
}

function DetectFlashVer(reqMajorVer, reqMinorVer, reqRevision)
{
    versionStr = GetSwfVer();
	if (versionStr == -1) {
		return false;
	} else if (versionStr != 0) {
		if(isIE && isWin && !isOpera) {
			// Given "WIN 2,0,0,11"
			tempArray         = versionStr.split(" ");
			if (tempArray.length > 1) tempString = tempArray[1]; else tempString = tempArray[0];
			if (tempString.indexOf(",") != -1) versionArray = tempString.split(","); else versionArray = tempString.split(".");
		} else {
			versionArray      = versionStr.split(".");
		}
		var versionMajor      = versionArray[0];
		var versionMinor      = versionArray[1];
		var versionRevision   = versionArray[2];

		if (versionMajor > parseFloat(reqMajorVer)) {
			return true;
		} else if (versionMajor == parseFloat(reqMajorVer)) {
			if (versionMinor > parseFloat(reqMinorVer))
				return true;
			else if (versionMinor == parseFloat(reqMinorVer)) {
				if (versionRevision >= parseFloat(reqRevision))
					return true;
			}
		}
		return false;
	}
}

function detectBrowser() {
	var ua = navigator.userAgent;
	var M=ua.match(/(edge)\/\s*([\d\.]+)/i);
	if (M!=null) return [M[1], M[2]];

	var tem,
	M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*([\d\.]+)/i) || [];
	if (/trident/i.test(M[1])) {
		tem = /\brv[ :]+(\d+(\.\d+)?)/g.exec(ua) || [];
		return ['MSIE',tem[1]];
	}
	M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion];
	if (!/chrome/i.test(M[0]) && (tem = ua.match(/version\/([\.\d]+)/i)) != null) M[1] = tem[1];
	return M;
}

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

function CompVersions(ver1,ver2)
{
	ver1=ver1.split(".");
	ver2=ver2.split(".");
	for (var i=0;i<Math.max(ver1.length,ver2.length);i++) {
 		if (i == 0) {
			var v1 = i<ver1.length ? parseInt(ver1[i]) : 0;
			var v2 = i<ver2.length ? parseInt(ver2[i]) : 0;
		}
		else {
			var v1 = i<ver1.length ? ver1[i] : "0";
			var v2 = i<ver2.length ? ver2[i] : "0";
		}
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

function GetDoc(movieName) {
    var isIE = navigator.appName.indexOf("Microsoft") != -1;
    return (isIE) ? window[movieName] : document[movieName];
}

function GetHTMLDoc(movieName) {
    return document.getElementById(movieName).contentDocument;
}

var FlashDocs=new Array()
function AddFlashDoc(FlashDoc) {
    FlashDocs.push(FlashDoc);
}

var oldonmousewheel=document.onmousewheel
function mousewheel(event) {
    for (var i=0;i<FlashDocs.length;i++) {
	    if(event.target==FlashDocs[i]) {
		    var delta = 0;
		    if (event.wheelDelta) delta = event.wheelDelta / (isOpera ? 12 : 120);
		        else if (event.detail) delta = -event.detail;
		    if (event.preventDefault) event.preventDefault();
		    try {
		        FlashDocs[i].scrollLine(delta);
		    }
		    catch(e) {
		    }
		    return true;
	    }
	}
	return oldonmousewheel(event)
}

if(isMac || isWin && isSafari && CompVersions(brVersion,"4")<0) {
	if (typeof window.addEventListener != "undefined") window.addEventListener("DOMMouseScroll", mousewheel, false);
	window.onmousewheel = document.onmousewheel = mousewheel;
}
 // -->
</script>

<!-- Start of document placement code -->
<script type="text/javascript">
<!--
var name="Print2FlashDoc"
var FlashUpdatePage="http://get.adobe.com/flashplayer";
var width = "%%WIDTH%%"
var height = "%%HEIGHT%%"
var htmldocurl ="%%HTMLDOCURL%%"
var htmlviewerurl = "%%HTMLVIEWERURL%%"
var flashdocurl ="%%FLASHDOCURL%%"
var flashvars = "%%FLASHVARS%%"
var flashformat = "%%FLASHFORMAT%%"
var priority = "%%PRIORITY%%"

function PlaceFlash() {
	if (DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision))
	{
		if (flashformat != "pages") {
			var oeTags
			oeTags = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" '
				+ 'width="'+width+'" height="'+height+'" id="'+name+'"'
				+ 'codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=' + requiredMajorVersion + ',' + requiredMinorVersion + ',' + requiredRevision + ',0"'
				+ 'type="application/x-shockwave-flash" data="' + flashdocurl + '" >'
				+ '<param name="movie" value="' + flashdocurl + '" />'
				+ '<param name="quality" value="best" />'
				+ '<param name="allowFullScreen" value="true" />'
				+ '<param name="allowFullScreenInteractive" value="true" />'
				+ '<param name="allowScriptAccess" value="sameDomain" />'
				+ '<param name="FlashVars" value="extName='+name+flashvars+'" />'
				+ '<embed src="' + flashdocurl + '" quality="best" '
				+ 'width="' + width + '" height="' + height + '" name="' + name + '" '
				+ 'play="true" '
				+ 'loop="false" '
				+ 'quality="best" '
				+ 'allowScriptAccess="sameDomain" allowFullScreen="true" allowFullScreenInteractive="true"'
				+ 'type="application/x-shockwave-flash" '
				+ 'pluginspage="'+FlashUpdatePage+'" '
				+ 'FlashVars="extName=' + name + flashvars + '"> '
				+ '</embed>'
				+ '</object>'
			document.write(oeTags)
			AddFlashDoc(GetDoc(name))
		} else {
		    document.write("<iframe src='" +  flashdocurl + "' border='1'" +
                           " scrolling='no' style='min-width:" + width + ";width:100px;height:" + height + "'"+
                           " id='" + name + "'></iframe>")

		}
		return true
	}
	return false
}

function PlaceHTML5() {
	if (CheckBrowserVer()) {
	    document.write("<iframe src='" + htmlviewerurl + "#" + htmldocurl + "' border='1' allowfullscreen webkitAllowFullScreen='yes'"+
                       " scrolling='no' style='min-width:" + width + ";width:100px;height:" + height + "'"+
                       " id='" + name + "'></iframe>")
		return true
	}
	return false
}

function PlaceAlternateContent() {
	var BrowserUpgradePage=GetBrowserUpgradePage();
	document.write("This content is not supported by your browser. Please do one of the following:<UL>"+
	"<LI>Upgrade your browser"+(BrowserUpgradePage ? " by <a href='"+BrowserUpgradePage+"'>clicking here</a>" : "")+
	"<LI>Install the Adobe Flash Player by <a href='"+FlashUpdatePage+"'>clicking here</a></UL>");
}

if  (priority == "flash") {
	if (!PlaceFlash())
		if (!PlaceHTML5())
			 PlaceAlternateContent()
} else {
	if (!PlaceHTML5())
		if (!PlaceFlash())
			 PlaceAlternateContent()
}

//-->
</script>
<noscript>
	This content requires scripts to be enabled in your browser. Please enable scripts in your browser settings.
</noscript>
<!-- End of document placement code -->

<!-- End of document code -->

</body>
</html> 