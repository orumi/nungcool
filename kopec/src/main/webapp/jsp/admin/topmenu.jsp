<%@ page
    contentType="text/html;charset=euc-kr"
%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"))+"/jsp";

    String userGroup = (String) session.getAttribute("userGroup");
	String userName = (String) session.getAttribute("userName");
	
	String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>BSC manager TOPMENU</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/nungcool_bsc.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript"><!--

		function openETL() {
		    parent.document.all.mainFrm.document.all.contentFrm.rows = "*,0";
		}
		
		var db=false;
		function openDB(){
			if (!db) {
				top.FrmDB.location.href = "FrmDB.jsp";
				db = true;
			}
			parent.document.all.mainFrm.document.all.contentFrm.rows = "0,*";
		}
		
				
		var holdId = "1";
		var selectButton;
		
		function changeButtonImg(oImgButton, mode) {
		    if (holdId == oImgButton.subid)
		        return ;
			var sUrl = oImgButton.src.substring(0, oImgButton.src.lastIndexOf("_"));
			if(sUrl == -1) alert("버튼 이미지명이 올바르지 않습니다...");
			if (mode.toUpperCase() == "ONMOUSEOVER" && sUrl != -1) {
				oImgButton.src = sUrl + "_over.gif";
				oImgButton.style.cursor = "hand";
				return;
			}
		    if (mode.toUpperCase() == "ONMOUSEOUT" && sUrl != -1) {
				oImgButton.src = sUrl + "_off.gif";
				oImgButton.style.cursor = "auto";
				return;
			}
		}
		
		function holdButton(oImgButton) {
		    if (oImgButton != null) {
			    holdId = oImgButton.subid;
		    }
			if (selectButton != null){
				changeButtonImg(selectButton, "ONMOUSEOUT");
			} else {
				changeButtonImg(eval("document.all.topmenu1"), "ONMOUSEOUT");
			}
			selectButton = oImgButton;
		}
		
		function clikScorecard(){
			changeButtonImg(eval("document.all.topmenu2"), "ONMOUSEOVER");
			holdButton(eval("document.all.topmenu2"));
		}
//--></script>
</head>

<body background="<%=imgUri%>/admin/images/top_page_bg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="<%=imgUri%>/admin/images/top_logo.gif">
  <tr> 
    <td width="223" rowspan="2"><img src="<%=imgUri%>/admin/images/top_logo.gif" width="223" height="55"></td>
    <td height="35" background="<%=imgUri%>/admin/images/top_logo.gif">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="75"><img src="images/topmenu_01_over.gif" id="topmenu1" idx="1" subid="1" alt="성과조회" width="75" height="35" border="0" onMouseOver="javascript:changeButtonImg(this,'onMouseOver');" onMouseOut="changeButtonImg(this, 'onMouseOut');" onclick="holdButton(this);openETL();"></td>
          <td width="75"><img src="images/topmenu_02_off.gif" id="topmenu2" idx="2" subid="2" alt="성과분석" width="75" height="35" border="0" onMouseOver="javascript:changeButtonImg(this,'onMouseOver');" onMouseOut="changeButtonImg(this, 'onMouseOut');" onclick="holdButton(this);openDB();"></td>
          <td>&nbsp;</td>
        </tr>
      	</table>
      </td>
  </tr>
  <tr> 
    <td height="20">&nbsp;</td>
  </tr>
</table>
</body>
</html>
