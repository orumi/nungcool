<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.nc.cool.PeriodUtil" %>
<%
  String imgUri = request.getRequestURI();
  imgUri = imgUri.substring(1);
  imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
  
  
	// ������ üũ
	PeriodUtil periodutil = new PeriodUtil();
	String div_cd  = "B02";
	String year    = request.getParameter("year");
	String message2   = "�����Ǿ����ϴ�. ��ȸ�� �����մϴ�.";                                   
	String month      = request.getParameter("month");
	String mmclose_yn = periodutil.getCheckCloseMM(year, div_cd, month);  
	if(mmclose_yn.equalsIgnoreCase("Y")){
		out.println("<script>");
		out.println("alert('"+message2+"');");
		out.println("window.close();");
		out.println("</script>");
	}
	
	// ���������˻� �� ==================================================================
%>

<SCRIPT>    
    function actionPerformed(){
    	if(importFileForm.file.value ==""){
    		alert('������ �����ϼ���.');
    		return false;
    	}
    	if(importFileForm.file.value.substring(importFileForm.file.value.indexOf("."),importFileForm.file.value.length) != ".csv"){
    		alert('CSV������ ������ �÷��ּ���');
    		return false;
    	}
		importFileForm.submit();
    }
</SCRIPT>
<html>
<head><title>Cool Package File Uploader</title></head>
<link href="<%=imgUri%>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#ffffff">
<form name="importFileForm" action="./taskImportExlProc.jsp" method="post" ENCTYPE="multipart/form-data">
<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> �����������</strong></td>
	</tr>
</table>
<table width="100%" border=0 cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">

	<input type=hidden name=serviceName value='<%= (request.getParameter("serviceName")!= null)?request.getParameter("serviceName"):""%>'>
	<tr>
		<td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">����ã��</font></strong></td>
		<td bgcolor="#FFFFFF"><input name="file" type="file" class="input_box" size="33">
			<img src="<%=imgUri%>/jsp/web/images/btn_regi.gif" onclick="javascript:actionPerformed();"  STYLE="cursor:hand" alt="���Ͽø���" border="0" align="absmiddle">
		</td>
	</tr>

</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" align="left">   *.csv ���Ϻ�ȯ �� �����ϼ���. </td>
		<td height="25" align="right"><img src="<%=imgUri%>/jsp/web/images/btn_close.gif" onclick="javascript:self.close();"  STYLE="cursor:hand" alt="�ݱ�" border="0" align="absmiddle"></td>
	</tr>
</table>
</form>
</body>
</html>

