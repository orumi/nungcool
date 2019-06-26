/**
 * ReportExpress PDF Viewer & Plugins
 */

var ver_ocx = "1,0,0,4";
var ver_manager = "1,0,0,1";
var ver_plugin = "2,5,0,0";

var rxpdfviewerCAB = "./cab/rxpdfviewerPlugin.cab";
var rxpdfviewerPRINTONLY = false;
var rxpdfviewerCLSID = '';
var strplugin = "";


function bw() {
	var agent = navigator.userAgent.toLowerCase();
	if ((agent.indexOf("msie") > -1) || agent.indexOf("trident") > -1) {
		return "ie";
	} else if (agent.indexOf("chrome") > -1) {
		return "chrome";
	} else if (agent.indexOf("safari") > -1) {
		return "safari";
	} else if ((agent.indexOf("opera") > -1) || (agent.indexOf("opr") > -1)) {
		return "opera";
	} else if (agent.indexOf("firefox") > -1) {
		return "firefox";
	} else {
		return "unknown";
	}
}


function init() {
	if (bw() == "ie") {
	    var objstr = '<OBJECT ID="RXPdfViewer"\n' +
        '     CLASSID="CLSID:0834B096-AC28-45E8-A343-B9E635C49BC8"\n' +
        '     style="DISPLAY:none">\n' +
        '</OBJECT>';
	    document.getElementById("viewer").innerHTML = objstr;
	} else {
	    var objstr = '<OBJECT ID="plugin"\n' +
        '     clsid="{7A2C1F1E-6117-4239-91C7-5D71C9F8A9B8}"\n' +
        '     type="application/x-cabsoft-plugins"\n' +
        '     progid="PdfPluginVersion.Version"\n' +
        '     >\n' +
        '</OBJECT>';
	    document.getElementById("viewer").innerHTML = objstr;
	}
}

// 설치 페이지에서 ie에서만 강제 설치
function initF() {
	if (bw() == "ie") {
	    var objstr = '<OBJECT ID="RXPdfViewer"\n' +
        '     CLASSID="CLSID:0834B096-AC28-45E8-A343-B9E635C49BC8"\n' +
        '     CODEBASE="'+rxpdfviewerCAB+'#version=2,0,0,0"\n' +
        '     style="DISPLAY:none">\n' +
        '</OBJECT>';
	    document.getElementById("viewer").innerHTML = objstr;
	} 
}

// 다른 PDF 뷰어 플러그인이 설치된 경우 체크 포함
function checkPlugins() {
	var check = false; //true,false: plugin 존재유무
	var plugin;
	try {
		/**
		 * 이미 다른 PDF 뷰어 플러그인이 설치된 경우
		 */
		if(RxAcrobatInfo(bw()).acrobat){
			check =true;
			strplugin = "acrobat";
		}else{
			// 캡소프트 플러그인 check
			check = checkPluginsF();
		}
	} catch (e) {
		//alert("PDF 뷰어 플러그인이 설치되어 있지않습니다.\n\n오류 내용: " + e.description);
		check = false;
	}

	return check;
}

function installedActiveX(){
	try{
		var obj = new ActiveXObject("PdfPluginVersion.Version");
		var ver_ocx = obj.VersionOcx();
		return true;
	}catch(e){
		return false;
	}
}

//eForm PDF 뷰어 프러그인만 체크
function checkPluginsF() {
	var check = false; //true,false: plugin 존재유무
	var plugin;
	try {
			/**
			 * eForm PDF 뷰어 프러그인 및 ActiveX 설치
			 */
			if (bw() == "ie") {
				plugin = new ActiveXObject("PdfPluginVersion.Version");
			} else{
				plugin = document.getElementById("plugin");
			}
	
			var new_ocx = ver_ocx.replace(/(\d*),(\d*),(\d*),(\d*)/, "$1$2$3$4");
			var new_manager = ver_manager.replace(/(\d*),(\d*),(\d*),(\d*)/, "$1$2$3$4");
			var new_plugin = ver_plugin.replace(/(\d*),(\d*),(\d*),(\d*)/, "$1$2$3$4");
	
			var ocx = plugin.VersionOcx().replace(/(\d*).(\d*).(\d*).(\d*)/, "$1$2$3$4");
			var manager = plugin.VersionManager().replace(/(\d*).(\d*).(\d*).(\d*)/, "$1$2$3$4");
			var pl = plugin.VersionPlugin().replace(/(\d*).(\d*).(\d*).(\d*)/, "$1$2$3$4");
	

//			alert("PDF Viewer & Plugin Version Check\n"
//					+ "\n=================================\n\n" + "OCX Version:\t"
//					+ ocx + "\n" + "Manager Version:\t" + manager + "\n" + "Plugin Version:\t" + pl
//					+ "\n=================================\n\n" + "New Version:\t"
//					+ new_ocx + "\n" + "Manager Version:\t" + new_manager + "\n" + "Plugin Version:\t" + new_plugin
//					);

			if ((parseInt(ocx) >= parseInt(new_ocx)) && (ocx.length >= new_ocx.length)) {
				if ((parseInt(manager) >= parseInt(new_manager)) && (manager.length >= new_manager.length)) {
					if ((parseInt(pl) >= parseInt(new_manager)) && (pl.length >= new_manager.length)) {
						check = true;
						strplugin = "cabsoft";
					}
				}
			}

	} catch (e) {
		//alert("PDF Viewer & Plugin이 설치되어 있지않습니다.\n\n오류 내용: " + e.description);
		check = false;
	}
	//alert("checkPluginsF:"+check);
	return check;
}

function getpluginname(){
	return strplugin;
}