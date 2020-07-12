<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.nc.cool.PeriodUtil" %>
<%
  String imgUri = request.getRequestURI();
  imgUri = imgUri.substring(1);
  imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
  
  
	// 월마감 체크
	PeriodUtil periodutil = new PeriodUtil();
	String div_cd  = "B02";
	String year    = request.getParameter("year");
	String message2   = "마감되었습니다. 조회만 가능합니다.";                                   
	String month      = request.getParameter("month");
	String mmclose_yn = periodutil.getCheckCloseMM(year, div_cd, month);  
	if(mmclose_yn.equalsIgnoreCase("Y")){
		out.println("<script>");
		out.println("alert('"+message2+"');");
		out.println("window.close();");
		out.println("</script>");
	}
	
	// 마감일정검사 끝 ==================================================================
%>

<SCRIPT>    
    function actionPerformed(){
    	if(importFileForm.file.value ==""){
    		alert('파일을 선택하세요.');
    		return false;
    	}
    	if(importFileForm.file.value.substring(importFileForm.file.value.indexOf("."),importFileForm.file.value.length) != ".csv"){
    		alert('CSV형식의 파일을 올려주세요');
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
			height="15" align="absmiddle"> 실적엑셀등록</strong></td>
	</tr>
</table>
<table width="100%" border=0 cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">

	<input type=hidden name=serviceName value='<%= (request.getParameter("serviceName")!= null)?request.getParameter("serviceName"):""%>'>
	<tr>
		<td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">파일찾기</font></strong></td>
		<td bgcolor="#FFFFFF"><input name="file" type="file" class="input_box" size="33">
			<img src="<%=imgUri%>/jsp/web/images/btn_regi.gif" onclick="javascript:actionPerformed();"  STYLE="cursor:hand" alt="파일올리기" border="0" align="absmiddle">
		</td>
	</tr>

</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" align="left">   *.csv 파일변환 후 저장하세요. </td>
		<td height="25" align="right"><img src="<%=imgUri%>/jsp/web/images/btn_close.gif" onclick="javascript:self.close();"  STYLE="cursor:hand" alt="닫기" border="0" align="absmiddle"></td>
	</tr>
</table>
</form>
</body>
</html>

