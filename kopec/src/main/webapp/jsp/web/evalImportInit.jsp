<%@ page contentType="text/html; charset=euc-kr" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>::: 평가결과 생성 :::</title>
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
                <td><a href="8_02.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub2','','images/sumenu8_02_over.gif',1)"><img src="images/sumenu8_02_off.gif" alt="IMPORT" name="sub2" width="140" height="25" border="0"></a></td>
              </tr>
              <tr> 
                <td><a href="8_03.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub3','','images/sumenu8_03_over.gif',1)"><img src="images/sumenu8_03_over.gif" alt="평가결과 생성" name="sub3" width="140" height="25" border="0"></a></td>
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
          <td width="190" height="44" background="images/box_top_bg.gif"><img src="images/title_img_08_03.gif" width="190" height="44"></td>
          <td background="images/box_top_bg.gif">&nbsp;</td>
          <td width="5"><img src="images/box_top_right.gif" width="5" height="44"></td>
        </tr>
        <tr> 
          <td background="images/box_side_left.gif">&nbsp;</td>
          <td colspan="2" valign="top" bgcolor="#FFFFFF"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table> 
            <!---------///본문 컨텐츠 삽입영역 ///--------->
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="100%" valign="top"> 
            <!------//상단검색//----->
                  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
                    <form action="" method="post" enctype="multipart/form-data" name="form1">
                      <tr bgcolor="#DCEDF6"> 
                        <td width="14%" align="center"><strong><font color="#006699"> 
                          해당일자</font></strong></td>
                        <td width="86%" bgcolor="#FFFFFF"><select name="select">
                            <option value="2006">2006</option>
                          </select> <select name="select2">
                            <option value="상반기">상반기</option>
                            <option value="하반기">하반기</option>
                          </select> </td>
                      </tr>
                      <tr bgcolor="#DCEDF6"> 
                        <td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">부서선택</font></strong></td>
                        <td bgcolor="#FFFFFF">부서 청/국/실: 
                          <select name="select3">
                          </select>
                          과: 
                          <select name="select4">
                          </select> <a href="#"><img src="images/btn_ok.gif" alt="확인" width="50" height="20" border="0" align="absmiddle"></a></td>
                      </tr>
                      <tr bgcolor="#DCEDF6">
                        <td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">파일선택</font></strong></td>
                        <td bgcolor="#FFFFFF"><input name="file" type="file" class="input_box">
                          <a href="#"><img src="images/btn_file_upload.gif" alt="파일전송" width="65" height="20" border="0" align="absmiddle"></a></td>
                      </tr>
                    </form>
                  </table>
            <!-------//상단검색 끝//------->
          </td>
        </tr>
        <tr> 
          <td valign="top">&nbsp;</td>
        </tr>
      </table>
	  <!-----//리스트//---->
      <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
        <tr align="center" bgcolor="#D4DCF4"> 
          <td width="10%" rowspan="2"><strong><font color="#003399">관점</font></strong></td>
          <td width="32%" rowspan="2"><strong><font color="#003399">KPI 명</font></strong></td>
          <td width="6%" rowspan="2"><strong><font color="#003399">가중치</font></strong></td>
          <td width="9%" rowspan="2"><strong><font color="#003399">실적(BSC)</font></strong></td>
          <td width="8%" rowspan="2"><strong><font color="#003399">평가점수</font></strong></td>
          <td width="8%" rowspan="2"><strong><font color="#003399">환산점수</font></strong></td>
          <td width="10%"><strong><font color="#003399">목표의 타당성</font></strong></td>
          <td width="9%"><strong><font color="#003399">충실성</font></strong></td>
          <td width="8%"><strong><font color="#003399">진척도</font></strong></td>
        </tr>
        <tr bgcolor="#D4DCF4"> 
          <td align="center" bgcolor="#E6E6E6"><strong>10</strong></td>
          <td align="center" bgcolor="#E6E6E6"><strong>15</strong></td>
          <td align="center" bgcolor="#E6E6E6"><strong>50</strong></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td>이해관계자</td>
          <td><font color="#0000FF">고객만족도</font></td>
          <td align="center"><font color="#333333">10</font></td>
          <td align="center"><font color="#333333">100</font></td>
          <td align="center"><font color="#333333">100</font></td>
          <td align="center"><font color="#333333">10</font></td>
          <td align="center"><font color="#333333">10</font></td>
          <td align="center"><font color="#333333">20</font></td>
          <td align="center"><font color="#333333">100</font></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
	        <!-----//리스트 끝//---->
            <br>
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
