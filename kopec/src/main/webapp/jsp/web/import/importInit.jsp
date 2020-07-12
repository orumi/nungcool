<%@ page contentType="text/html; charset=euc-kr" language="java" import="java.sql.*" errorPage="" %>

<%  String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
%>
<html>
<head>
<link href="<%=imgUri%>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
	var tag = false;
    function actionPerformed(actEvent) {
          detail.importFile.importFileForm.submit();
          tag = true;
    }
    
    function tableRefresh(){
      if (tag){
        detail.importDetailForm.submit();
        tag = false;
      }
    }


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

<body leftmargin="5" topmargin="0" marginwidth="5" onLoad="MM_preloadImages('<%=imgUri%>/jsp/web/images/sumenu8_01_over.gif','images/sumenu8_02_over.gif','images/sumenu8_03_over.gif','images/sumenu8_04_over.gif','images/sumenu8_05_over.gif')">
	<!-----//Box layout//----->
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">

        <tr> 
          <td colspan="2" valign="top" bgcolor="#FFFFFF"> <br>
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td>
		        <iframe frameborder="0" name="detail" id="detail" src="importDetail.jsp" style="body" width="100%" height="100%" scrolling="AUTO">&nbsp;</iframe>
            </td></tr>
            </table>
          </td>
        </tr>
    </table>
	  <!-----//Box layout end//----->
</body>
</html>
