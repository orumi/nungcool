<%@ page contentType="text/html; charset=euc-kr" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>::: Import :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/nungcool_bsc.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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
</head>

<body background="images/page_bg.gif" leftmargin="5" topmargin="0" marginwidth="5" onLoad="MM_preloadImages('images/sumenu8_01_over.gif','images/sumenu8_02_over.gif','images/sumenu8_03_over.gif','images/sumenu8_04_over.gif','images/sumenu8_05_over.gif')">
<!--------//Page Layout Table //---------->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="160" valign="top"> 
      <!----//관리자 서브메뉴//---->
      <table width="160" height="500" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="46"><img src="images/submenu_title_08.gif" width="160" height="46"></td>
        </tr>
        <tr> 
          <td valign="top" background="images/submenu_bg.gif"><table width="140" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><a href="8_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub1','','images/sumenu8_01_over.gif',1)"><img src="images/sumenu8_01_off.gif" alt="기초정보" name="sub1" width="140" height="25" border="0"></a></td>
              </tr>
              <tr> 
                <td><a href="8_02.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub2','','images/sumenu8_02_over.gif',1)"><img src="images/sumenu8_02_over.gif" alt="IMPORT" name="sub2" width="140" height="25" border="0"></a></td>
              </tr>
              <tr> 
                <td><a href="8_03.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub3','','images/sumenu8_03_over.gif',1)"><img src="images/sumenu8_03_off.gif" alt="평가결과 생성" name="sub3" width="140" height="25" border="0"></a></td>
              </tr>
              <tr> 
                <td><a href="8_04.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub4','','images/sumenu8_04_over.gif',1)"><img src="images/sumenu8_04_off.gif" alt="평가결과 실적관리" name="sub4" width="140" height="25" border="0"></a></td>
              </tr>
              <tr> 
                <td><a href="8_05.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub5','','images/sumenu8_05_over.gif',1)"><img src="images/sumenu8_05_off.gif" alt="사용자 관리" name="sub5" width="140" height="25" border="0"></a></td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table>
      <!----//관리자 서브메뉴 끝//---->
    </td>
    <td width="10">&nbsp;</td>
    <td valign="top">
	
	<!-----//Box layout//----->
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="5"><img src="images/box_top_left.gif" width="5" height="44"></td>
          <td width="190" height="44" background="images/box_top_bg.gif"><img src="images/title_img_08_02.gif" width="190" height="44"></td>
          <td background="images/box_top_bg.gif">&nbsp;</td>
          <td width="5"><img src="images/box_top_right.gif" width="5" height="44"></td>
        </tr>
        <tr> 
          <td background="images/box_side_left.gif">&nbsp;</td>
          <td colspan="2" valign="top" bgcolor="#FFFFFF"> 
            <!---------///본문 컨텐츠 삽입영역 ///--------->
            123456 
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
	  
	  </td>
  </tr>
</table>
<!--------//Page Layout Table End//---------->
</body>
</html>
