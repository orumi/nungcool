<%@ page
    contentType="text/html;charset=euc-kr"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>::: 대쉬보드 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/nungcool_bsc.css" rel="stylesheet" type="text/css">
</head>

<body background="images/page_bg.gif" leftmargin="5" topmargin="0" marginwidth="5">
<!-----//Box layout//----->
<table width="910" height="600" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="5"><img src="images/box_top_left.gif" width="5" height="44"></td>
    <td width="190" height="44" background="images/box_top_bg.gif"><img src="images/title_img_01.gif" width="190" height="44"></td>
    <td background="images/box_top_bg.gif"> 
      <!--------//대쉬보드 선택//------->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <form name="form1" method="post" action="">
 
		<tr>
          <td><a href="#"><img src="images/btn_s_back.gif" width="18" height="20" border="0" align="absmiddle"></a> 
            <select name="select">
              <option value="2006">2006</option>
              <option value="2007">2007</option>
            </select>
            <select name="select2">
              <option value="01">01</option>
              <option value="02">02</option>
              <option value="03">03</option>
            </select> <a href="#"><img src="images/btn_s_next.gif" width="18" height="20" border="0" align="absmiddle"></a></td>
          <td><a href="#"><img src="images/btn_back.gif" alt="이전" width="39" height="20" border="0" align="absmiddle"></a>&nbsp;<a href="#"><img src="images/btn_next.gif" alt="다음" width="39" height="20" border="0" align="absmiddle"></a></td>
          <td><select name="select3">
              <option value="미션/비전">미션/비전</option>
              <option value="전략시나리오">전략시나리오</option>
            </select></td>
        </tr>
		     </form> 
      </table>
	  <!--------//대쉬보드 선택 끝//------->
	  </td>
    <td width="5"><img src="images/box_top_right.gif" width="5" height="44"></td>
  </tr>
  <tr> 
    <td background="images/box_side_left.gif">&nbsp;</td>
    <td height="600" colspan="2" valign="top" background="images/strategy_map.jpg" bgcolor="#FFFFFF"> 
      <!---------///본문 컨텐츠 삽입영역 ///--------->
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
