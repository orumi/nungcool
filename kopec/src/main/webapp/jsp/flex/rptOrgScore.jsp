<%@ page contentType="text/html; charset=euc-kr"%>

<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String realUrl = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();

	String did   = request.getParameter("did")==null?"":request.getParameter("did");
	String tid   = request.getParameter("tid")==null?"":request.getParameter("tid");
	String level = request.getParameter("level")==null?"":request.getParameter("level");
	String year  = request.getParameter("year")==null?"":request.getParameter("year");
	String month = request.getParameter("month")==null?"":request.getParameter("month");
	
	String resultStr = did+"|"+tid+"|"+level+"|"+year+"|"+month+"|";
	
	System.out.println("resultStr : " + resultStr);
%>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script src="AC_OETags.js" language="javascript"></script>
<style>
body { margin: 0px; overflow:hidden }
</style>
<script language="JavaScript" type="text/javascript">
<!--
// -----------------------------------------------------------------------------
// Globals
// Major version of Flash required
var requiredMajorVersion = 9;
// Minor version of Flash required
var requiredMinorVersion = 0;
// Minor version of Flash required
var requiredRevision = 0;
// -----------------------------------------------------------------------------

	function getURL() {
		return "<%=realUrl%>";
	}

	function getMyApp(appName){
		if (navigator.appName.indexOf("Microsoft")!=-1) {
			return window[appName];
		} else {
			return document[appName];
		}
	}

	function openScoreIcon() {	
		return "<%=resultStr%>";
	}			

	var urlDown = null;
	
	function getFileDown(obj){

		if (urlDown!=null){
			urlDown.close();
		}

		var url = "<%=imgUri%>/jsp/flex/downloadInit.jsp";
		var param1 = "fileNm="+obj.fileNm;
		var param2 = "filePath="+obj.filePath;

		url = url+"?"+param1+"&"+param2;

		var winL = (screen.width-466)/2;
		var winH = (screen.height-94)/2;
			
		urlDown = window.open(url,'urlDown','top='+winL+',left='+winH+',width=466,height=168,scrollbars=none,resizable=none,toolbar=none,menubar=none');


/*		
		form1.fileNm.value   = obj.fileNm;
		form1.filePath.value = obj.filePath;

		//alert(obj.fileNm);
		
		form1.submit();
*/		
	}

	

// -->
</script>
</head>

<body scroll="no">
<script language="JavaScript" type="text/javascript" src="./inc/ExcelExport.js"></script>
<script language="JavaScript" type="text/javascript" src="history.js"></script>
<script language="JavaScript" type="text/javascript">
<!--
// Version check for the Flash Player that has the ability to start Player Product Install (6.0r65)
var hasProductInstall = DetectFlashVer(6, 0, 65);

// Version check based upon the values defined in globals
var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);


// Check to see if a player with Flash Product Install is available and the version does not meet the requirements for playback
if ( hasProductInstall && !hasRequestedVersion ) {
	// MMdoctitle is the stored document.title value used by the installation process to close the window that started the process
	// This is necessary in order to close browser windows that are still utilizing the older version of the player after installation has completed
	// DO NOT MODIFY THE FOLLOWING FOUR LINES
	// Location visited after installation is complete if installation is required
	var MMPlayerType = (isIE == true) ? "ActiveX" : "PlugIn";
	var MMredirectURL = window.location;
    document.title = document.title.slice(0, 47) + " - Flash Player Installation";
    var MMdoctitle = document.title;

	AC_FL_RunContent(
		"src", "playerProductInstall",
		"FlashVars", "MMredirectURL="+MMredirectURL+'&MMplayerType='+MMPlayerType+'&MMdoctitle='+MMdoctitle+"",
		"width", "100%",
		"height", "100%",
		"align", "middle",
		"id", "rptOrgScore",
		"quality", "high",
		"bgcolor", "#869ca7",
		"name", "rptOrgScore",
		"allowScriptAccess","sameDomain",
		"type", "application/x-shockwave-flash",
		"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
} else if (hasRequestedVersion) {
	// if we've detected an acceptable version
	// embed the Flash Content SWF when all tests are passed
	AC_FL_RunContent(
			"src", "rptOrgScore",
			"width", "100%",
			"height", "100%",
			"align", "middle",
			"id", "rptOrgScore",
			"quality", "high",
			"bgcolor", "#869ca7",
			"name", "rptOrgScore",
			"flashvars",'historyUrl=history.htm%3F&lconid=' + lc_id + '',
			"allowScriptAccess","sameDomain",
			"type", "application/x-shockwave-flash",
			"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
  } else {  // flash is too old or we can't detect the plugin
    var alternateContent = 'Alternate HTML content should be placed here. '
  	+ 'This content requires the Adobe Flash Player. '
   	+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
    document.write(alternateContent);  // insert non-flash content
  }
// -->
</script>
<noscript>
  	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			id="rptOrgScore" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="rptOrgScore.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#869ca7" />
			<param name="allowScriptAccess" value="sameDomain" />
			<embed src="rptOrgScore.swf" quality="high" bgcolor="#869ca7"
				width="100%" height="100%" name="rptOrgScore" align="middle"
				play="true"
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</noscript>
<iframe name="_history" src="history.htm" frameborder="0" scrolling="no" width="22" height="0"></iframe>
<iframe name="_download" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

<form action="<%=imgUri%>/jsp/flex/downloadInit.jsp" method="post" name="form1" target="_blank">
	<input type="hidden" name="fileNm" value="">
	<input type="hidden" name="filePath" value="">
</form>


</body>
</html>

