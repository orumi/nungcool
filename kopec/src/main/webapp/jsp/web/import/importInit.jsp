<%@ page contentType="text/html; charset=euc-kr" language="java" import="java.sql.*" errorPage="" %>

<%  String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
%>
<html>
<head>
<link href="<%=imgUri%>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
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


</script>
</head>

<body leftmargin="5" topmargin="0" marginwidth="5" >
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
