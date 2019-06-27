<%@ page language="java" contentType="text/html; charset=utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Language" content="ko" />
	<meta name="description" content="Download Rexpert Viewer, the cross-platform browser plug-in" />
	<title>REXPERT VIEWER</title>
	<link type="text/css" rel="stylesheet" href="screen.css" media="screen" charset="utf-8" />
	<script language="javascript">
		function fnOnLoad() {
			var sParam = window.location.search;
			sParam = sParam.substr(1).split("&");
			var aParam = sParam[0].split("=");
	
			if (aParam[1].search(/^\d*[\,|\d]*\d*$/gi) == 0) {
				document.getElementById("idVersion").innerText = aParam[1];
				if ((navigator.userAgent.toLowerCase() || "").indexOf("firefox") > -1) {
					document.getElementById("idVersion").textContent = aParam[1];
				}
			}
			if((sParam[1] != null ? (sParam[1].split("=")[1]) : "3") == "4") {
				document.getElementById("buttonDownload").href = "../CLIPreport40ViewerSetup.exe";
			} else {
			    document.getElementById("buttonDownload").href = "../rexpert30viewer.exe";
			}
		}
	</script>
</head>
<body onload="fnOnLoad()"
	style="margin: 0 0 0 0; width: 100%; height: 100%">
	<div id="layoutLogic" class="L0">
		<div id="L0C1" class="pod p0 columns-1-A-A">
			<div id="L0C1-body" class="pod-body">
				<h1 id="pageHeader" style="background: #0554a1;">REXPERT Viewer</h1>
				<form name="downloadForm" id="downloadForm" method="get">
					<div id="JSError" style="display: none;"></div>
					<div class="pullout-left left-125">
						<p class="pullout-item">
							<img src="REXPERT_BI_01.jpg" width="183" height="71" alt="REXPERT Viewer" />
						</p>
						<h2>REXPERT Viewer Install</h2>
						<div class="pullout-right right-wrap">
							<p>
								<strong>REXPERT Viewer Ver: <span id="idVersion" name="idVersion">1.0.0.0</span></strong>
							</p>
						</div>
						<p class="note">
							<br />
						</p>
						<div class="pullout-right right-wrap">
							<p class="pullout-item">
								<strong><br /> <span id="totalfilesize"></span></strong>
							</p>
							<div class="columns-2-Abb-A">
								<p><a class="download-button" id="buttonDownload" name="buttonDownload">Install</a></p>
								<p><strong>To apply you must rerun the web browser.</strong></p>
							</div>
						</div>
					</div>
					<input type="hidden" name="installer" id="installer" value="Rexpert Viewer" />
				</form>
				<br class="clear-both" />
			</div>
		</div>
		<br class="clear-both" />
	</div>
	<div id="globalfooter" style="background: #0554a1;">
		<p id="copyright">COPYRIGHT(C) 2005 <a href="http://www.clipsoft.co.kr" target="_new">CLIPSOFT.</a> ALL RIGHT RESERVED.</p>
	</div>
</body>
</html>