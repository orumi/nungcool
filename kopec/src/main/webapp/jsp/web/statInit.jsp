<%@ page contentType="text/html; charset=euc-kr" language="java" import="java.sql.*" errorPage="" %>

<html>
<head>
<title>::: 통계자료 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/nungcool_bsc.css" rel="stylesheet" type="text/css">
</head>

<body background="images/page_bg.gif" leftmargin="5" topmargin="0" marginwidth="5">
<!-----//Box layout//----->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="5"><img src="images/box_top_left.gif" width="5" height="44"></td>
    <td width="190" height="44" background="images/box_top_bg.gif"><img src="images/title_img_05.gif" width="190" height="44"></td>
    <td background="images/box_top_bg.gif">&nbsp;</td>
    <td width="5"><img src="images/box_top_right.gif" width="5" height="44"></td>
  </tr>
  <tr> 
    <td background="images/box_side_left.gif">&nbsp;</td>
    <td colspan="2" valign="top" bgcolor="#FFFFFF">
	<!---------///본문 컨텐츠 삽입영역 ///--------->
		<iframe frameborder="0" id="adminContent" src="stat/statTotal.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
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
<!-----//Box layout end//----->
</body>
</html>
