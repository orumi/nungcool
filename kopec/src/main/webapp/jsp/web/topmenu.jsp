<%@ page
    contentType="text/html;charset=euc-kr"
%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

    String groupId   = (String) session.getAttribute("groupId");      // 사용자권한
	String userName  = (String) session.getAttribute("userName");
	String userId    = (String) session.getAttribute("userId");
	String appraiser = (String) session.getAttribute("appraiser");    // 평가자
	String auth01    = (String) session.getAttribute("auth01");       // 경영정보 관리자

	if (groupId == null) {
	%>
	<script>
		alert("잘못된 접속입니다.");
	  	top.location.href = "./loginProc.jsp";
	</script>
	<%
		return;
	}

	int group = new Integer(groupId).intValue();

	String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>Untitled Document</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr;
  for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++)	{
  	x.src=x.oSrc;
  }
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<script language="JavaScript" src="<%=imgUri %>/jsp/web/js/bsc.js"></script>
<script language="JavaScript" type="text/JavaScript"><!--


		function openEis(){
			parent.openMenu();
			parent.document.getElementById("contentFrm").rows = "0, *,0,0, 0,0,0, 0";
		}

		function openScorecard() {
			parent.openMenu();
	    	parent.document.getElementById("contentFrm").rows = "0, 0,*,0, 0,0,0, 0";
		}



		var analysis=false;
		function openAnalysis(){
			parent.openMenu();
			if (!analysis) {
				top.FrmAnalysis.location.href = "FrmAnalysis.jsp";
				analysis = true;
			}
			parent.document.getElementById("contentFrm").rows = "0, 0,0,*, 0,0,0, 0";
		}

		var actual=false;
		function openActual(){
			parent.openMenu();
			if (!actual) {
				top.FrmActual.location.href = "FrmActual.jsp";
				actual = true;
			}
			parent.document.getElementById("contentFrm").rows = "0, 0,0,0, *,0,0, 0";
		}

		var valuate=false;
		function openValuate(){
		<% if ("1".equals(appraiser)||group==1){ %>
			parent.openMenu();
			if (!valuate){
				top.FrmValuate.location.href = "FrmValuate.jsp";
				valuate = true;
			}
			parent.document.getElementById("contentFrm").rows = "0, 0,0,0, 0,*,0, 0";
		<% } else {%>
			alert("접근권한이 없습니다.");
		<% } %>
		}

		var boardTag = false;
		function openBoard() {
			parent.openMenu();
			//alert(boardTag);
			if (boardTag == true){
				top.FrmBoard.location.href="<%=imgUri%>/jsp/web/FrmBoard.jsp";
				boardTag = false;
			}
	    	parent.document.getElementById("contentFrm").rows = "0, 0,0,0, 0,0,*, 0";
		}


		function openQnA() {
			boardTag = true;

			parent.openMenu();
			top.FrmBoard.location.href="FrmQnA.jsp";
	    	parent.document.getElementById("contentFrm").rows = "0, 0,0,0, 0,0,*, 0";
		}


		var admin=false;
		function openAdmin(btn){
		<% if (group==1){ %>
			if (!admin){
				top.FrmAdmin.location.href = "FrmAdmin.jsp";
				admin = true;
			}
			parent.openMenu();
			//parent.document.all.mainFrm.document.all.contentFrm.rows = "0, 0,0,0, 0,0,0, *";
			parent.document.getElementById("contentFrm").rows = "0, 0,0,0, 0,0,0, *";
			holdButton(btn);
		<% } else {%>
			alert("접근권한이 없습니다.");
		<% } %>
		}
		var holdId = "0";
		var selectButton;

		function changeButtonImg(oImgButton, mode) {

	/* 		console.log("oImgButton : "+oImgButton);
			console.log("oImgButton.subid : "+oImgButton.getAttribute('subid'));

   */
		    if (holdId == oImgButton.getAttribute('subid'))
		        return ;
			var sUrl = oImgButton.src.substring(0, oImgButton.src.lastIndexOf("."));
			var sUrlx = oImgButton.src;
			if(sUrl == -1) alert("버튼 이미지명이 올바르지 않습니다...");
			if (mode.toUpperCase() == "ONMOUSEOVER" && sUrl != -1) {
				oImgButton.src = sUrl + "_over.jpg";
				oImgButton.style.cursor = "hand";
				return;
			}
		    if (mode.toUpperCase() == "ONMOUSEOUT" && sUrl != -1) {
				oImgButton.src = oImgButton.src.substring(0, oImgButton.src.lastIndexOf("_"));
				oImgButton.src = oImgButton.src + ".jpg";
				oImgButton.style.cursor = "auto";
				return;
			}
		}

		function holdButton(oImgButton) {
		    if (oImgButton != null) {
			    holdId = oImgButton.getAttribute('subid');
		    }
			if (selectButton != null){
				changeButtonImg(selectButton, "ONMOUSEOUT");
			} else {
				//changeButtonImg(eval("document.all.topmenu1"), "ONMOUSEOUT");
			}
			selectButton = oImgButton;
		}

		function clikScorecard(){
			changeButtonImg(eval("document.all.topmenu2"), "ONMOUSEOVER");
			holdButton(eval("document.all.topmenu2"));
		}

		function dblClickedButtonImgChange(changImgTag)	{
			if(changImgTag == "3")	{
				changeButtonImg(eval("document.all.topmenu3"), "ONMOUSEOVER");
				holdButton(eval("document.all.topmenu3"));
			}
		}

		function zoomp(){
			top.closeTopMenu();
		}

		function zoomm(){
			top.openTopMenu();
		}

		function openHome(){
			parent.location.href = "./main.jsp";
		}
		function openPop(){
			var url = "./login_admin.jsp";
	        parent.location.href=url;
		}



//-->
</script>
</head>
<body onLoad="MM_preloadImages('images/menu01_over.jpg','images/menu02_over.jpg','images/menu03_over.jpg','images/menu04_over.jpg','images/menu05_over.jpg','images/menu06_over.jpg')">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="2" align="center" valign="middle"><a href="main.html"></a><img src="images/blank.gif" width="1" height="8"></td>
      </tr>
      <tr>
        <td width="200" align="center" background="images/top_rightbg.jpg"><a href="javascript:openHome();"><img src="images/logo_re.jpg" width="130" height="36" border="0"></td>
        <td height="43" background="images/top_rightbg.jpg">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="15"><img src="images/topmenu_left.jpg" width="15" height="43" /></td>
            <td background="images/topmenu_bg.jpg">
			  <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="74"><IMG id="topmenu1" onmouseover="javascript:changeButtonImg(this,'onMouseOver');" onclick="holdButton(this);openEis();" onmouseout="changeButtonImg(this, 'onMouseOut');" alt="경영정보" src="images/menu01.jpg" border="0" subid="1" idx="1"></td>
                  <td width="74"><IMG id="topmenu2" onmouseover="javascript:changeButtonImg(this,'onMouseOver');" onclick="holdButton(this);openScorecard();" onmouseout="changeButtonImg(this, 'onMouseOut');" alt="성과조회" src="images/menu02.jpg" border="0" subid="2" idx="2"></td>
                  <td width="74"><IMG id="topmenu3" onmouseover="javascript:changeButtonImg(this,'onMouseOver');" onclick="holdButton(this);openAnalysis();" onmouseout="changeButtonImg(this, 'onMouseOut');" alt="성과분석" src="images/menu03.jpg" border="0" subid="3" idx="3"></td>
				  <%if(groupId.equals("1")||groupId.equals("3")){%>
                  <td width="74"><IMG id="topmenu4" onmouseover="javascript:changeButtonImg(this,'onMouseOver');" onclick="holdButton(this);openActual();" onmouseout="changeButtonImg(this, 'onMouseOut');" alt="계량실적" src="images/menu04.jpg" border="0" subid="4" idx="4"></td><%}%>
				  <%if(groupId.equals("1")||appraiser.equals("1")){%>
                  <td width="99"><IMG id="topmenu5" onmouseover="javascript:changeButtonImg(this,'onMouseOver');" onclick="holdButton(this);openValuate();" onmouseout="changeButtonImg(this, 'onMouseOut');" alt="비계량실적" src="images/menu05.jpg" border="0" subid="5" idx="5"></td>
                  <%}%>
                  <td width="74"><IMG id="topmenu6" onmouseover="javascript:changeButtonImg(this,'onMouseOver');" onclick="holdButton(this);openBoard();" onmouseout="changeButtonImg(this, 'onMouseOut');" alt="정보마당" src="images/menu07.jpg" border="0" subid="6" idx="6"></td>
                  <td width="74"><IMG id="topmenu8" onmouseover="javascript:changeButtonImg(this,'onMouseOver');" onclick="holdButton(this);openQnA();" onmouseout="changeButtonImg(this, 'onMouseOut');" alt="Q&A" src="images/menu08.jpg" border="0" subid="8" idx="8"></td>


				  <%if(groupId.equals("1") ){%>
                  <td width="74"><IMG id="topmenu7" onmouseover="javascript:changeButtonImg(this,'onMouseOver');" onclick="openAdmin(this);" onmouseout="changeButtonImg(this, 'onMouseOut');" alt="관리자" src="images/menu06.jpg" border="0" subid="7" idx="7"></td><%}%>
				</tr>
              </table>
			</td>
            <td width="40"><%if(groupId.equals("1") ){%><a href="javaScript:openPop();"border=0><%}%><img src="images/topmenu_right.jpg" BORDER="0" width="156" height="43" /></td>
          </tr>
        </table>
		</td>
      </tr>
    </table>
	</td>
  </tr>
</table>
</body>
</html>

