<%@ page contentType="text/html; charset=euc-kr" %>
<%
  String imgUri = request.getRequestURI();
  imgUri = imgUri.substring(1);
  imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
%>

<SCRIPT>    
    function actionPerformed(){
       parent.parent.actionPerformed();
    }
    
    function init(){
      parent.parent.tableRefresh();
    }
</SCRIPT>
<html>
<head><title>Cool Package File Uploader</title></head>
<link href="<%=imgUri%>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:init();" bgcolor="#ffffff">
<table width = "100%" border=0 >
<form name="importFileForm" action="./upload.jsp" method="post" ENCTYPE="multipart/form-data">
<input type=hidden name=serviceName value='<%= (request.getParameter("serviceName")!= null)?request.getParameter("serviceName"):""%>'>
<tr><td><input name="file" type="file" class="input_box" size="33">
<img src="<%=imgUri%>/jsp/web/images/btn_file_upload.gif" onclick="javascript:actionPerformed();"  STYLE="cursor:hand" alt="파일올리기" width="65" height="20" border="0" align="absmiddle">
</td></tr>
</table>
</form>
</body>
</html>

