<%@ page language    = "java"
         contentType = "text/html; charset=euc-kr"
         import      = "java.util.*,
         				java.net.*,         				
         				java.io.*,
         				javax.sql.RowSet,
                        com.nc.cool.*,
                        com.nc.util.*"
%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String error_msg = "";
	Common_Data cd = new Common_Data();	
	String fileName=null;
	String filePath=null;
	try {
			
			String fullPath = "";
			fileName = Util.getEUCKR(request.getParameter("fileNm"));			
			filePath = Util.getEUCKR(request.getParameter("filePath"));			

	
					
} catch (Exception ex) {	
	error_msg = cd.Alert_Window(ex.toString(), 1, "");
	out.println(error_msg);		
} finally {
}
%>

<html>

<body leftmargin="8" topmargin="0" marginwidth="0" background="<%=imgUri %>/jsp/web/images/downloadback.gif">
<div id="Layer1" style="position:absolute; left:134px; top:86px; width:334px; height:34px; z-index:1">
	<%= fileName%>
</div>
<table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="<%=imgUri %>/jsp/web/images/downloadback.gif" width="466" height="168" border="0" usemap="#Map"></td>
  </tr>
</table>

<map name="Map">
  <area shape="rect" coords="133,125,228,145" href="javascript:fileLoad();">
  <area shape="rect" coords="260,125,319,144" href="javascript:close();">
</map>
</body>

<form action="<%=imgUri%>/jsp/flex/download.jsp" method="post" name="form1" target="_self">
	<input type="hidden" name="fileNm" value="">
	<input type="hidden" name="filePath" value="">
</form>

<script>

	function fileLoad(){
		form1.fileNm.value   = "<%=fileName%>";
		form1.filePath.value = "<%=filePath%>";
		form1.submit();
	}
	//alert(obj.fileNm);
</script>
</html>
