<%@ page contentType="text/html; charset=euc-kr" language="java" errorPage="" %>

<%  String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
%>

<html>
<head>
<title>::: 평가결과 생성 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri%>/jsp/web/css/nungcool_bsc.css" rel="stylesheet" type="text/css">
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

<body background="<%=imgUri%>/jsp/web/images/page_bg.gif" leftmargin="5" topmargin="0" marginwidth="5" onLoad="">
<!--------//Page Layout Table //---------->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">
	<!-----//Box layout//----->
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="5"><img src="<%=imgUri%>/jsp/web/images/box_top_left.gif" width="5" height="44"></td>
          <td width="190" height="44" background="<%=imgUri%>/jsp/web/images/box_top_bg.gif"><img src="<%=imgUri%>/jsp/web/images/title_img_08_04.gif" width="190" height="44"></td>
          <td background="<%=imgUri%>/jsp/web/images/box_top_bg.gif">&nbsp;</td>
          <td width="5"><img src="<%=imgUri%>/jsp/web/images/box_top_right.gif" width="5" height="44"></td>
        </tr>
        <tr> 
          <td background="<%=imgUri%>/jsp/web/images/box_side_left.gif">&nbsp;</td>
          <td colspan="2" valign="top" bgcolor="#FFFFFF"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table> 
            <!---------///본문 컨텐츠 삽입영역 ///--------->
            <iframe frameborder="0" id="list" src="adminView.jsp" style="body" width="100%" height="100%">&nbsp;</iframe>
            <!-----//리스트 끝//---->
            <!---------///본문 컨텐츠 삽입영역  끝///--------->
          </td>
          <td background="<%=imgUri%>/jsp/web/images/box_side_right.gif">&nbsp;</td>
        </tr>
        <tr> 
          <td height="5"><img src="<%=imgUri%>/jsp/web/images/box_down_left.gif" width="5" height="5"></td>
          <td colspan="2" background="<%=imgUri%>/jsp/web/images/box_down_bg.gif"><img src="<%=imgUri%>/jsp/web/images/box_down_bg.gif" width="5" height="5"></td>
          <td><img src="<%=imgUri%>/jsp/web/images/box_down_right.gif" width="5" height="5"></td>
        </tr>
        <tr> 
          <td height="5" colspan="4"><img src="<%=imgUri%>/jsp/web/images/5px.gif" width="5" height="5"></td>
        </tr>
      </table>
	  <!-----//Box layout end//----->
	  
	  </td>
  </tr>
</table>
<!--------//Page Layout Table End//---------->
</body>
</html>
