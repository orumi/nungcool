<%@ page contentType="text/html; charset=euc-kr" %>

<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));


    String groupId = (String) session.getAttribute("groupId");

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
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>:::  :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/bsc.css" rel="stylesheet" type="text/css">
<jsp:include page="js/js.jsp" flush="true"/>
</head>
<script>
	function openContents(tag){
		if ("1" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/renov/renovTask.jsp";
//			document.getElementById("page").src = "<%=imgUri%>/jsp/web/task/proceed.jsp";
			imgTitle.src="images/title_img8_01.gif";
		} else if ("2" == tag){
            document.getElementById("page").src = "<%=imgUri%>/jsp/web/renov/renovActual.jsp";
//			document.getElementById("page").src = "<%=imgUri%>/jsp/web/task/divisionTask.jsp";
			imgTitle.src="images/title_img8_02.gif";
		} else if ("3" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/renov/renovWork.jsp";
//			document.getElementById("page").src = "<%=imgUri%>/jsp/web/task/taskDetail.jsp";
			imgTitle.src="images/title_img8_03.gif";
		} else if ("4" == tag){
            document.getElementById("page").src = "<%=imgUri%>/jsp/web/renov/renovMgrUser.jsp";
//			document.getElementById("page").src = "<%=imgUri%>/jsp/web/task/taskActual.jsp";
			imgTitle.src="images/title_img8_04.gif";
		}
	}

</script>
<body background="images/page_bg.gif" leftmargin="0" topmargin="0"  >
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">

	<!-----// 우측 본문Box layout//----->
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td background="images/box_side_left.gif">&nbsp;</td>
          <td colspan="2" valign="top" bgcolor="#FFFFFF">
            <!---------///본문 컨텐츠 삽입영역 ///--------->
            <IFRAME id="page" name="contents" marginWidth="0" marginHeight="0" src="http://10.131.5.8:8889/Ninpool/code_ct_bsc.jsp" frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>
            <!---------///본문 컨텐츠 삽입영역  끝///--------->
          </td>
          <td background="images/box_side_right.gif">&nbsp;</td>
        </tr>
        <tr>
          <td height="5"><img src="images/box_down_left.gif" width="5" height="5"></td>
          <td colspan="2" background="images/box_down_bg.gif"><img src="images/box_down_bg.gif" width="5" height="5"></td>
          <td><img src="images/box_down_right.gif" width="5" height="5"></td>
        </tr>
        <tr>
          <td height="5" colspan="4"><img src="images/5px.gif" width="5" height="5"></td>
        </tr>
      </table>
	  </td>
  </tr>
</table>

</body>
</html>
