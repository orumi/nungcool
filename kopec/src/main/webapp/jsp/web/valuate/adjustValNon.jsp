<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
					com.nc.eval.*,
					com.nc.util.*"%>
<%

	
	AdjustValuateUtil util = new AdjustValuateUtil();
	util.setEvalNonMeasure(request, response);

	
	
	DataSet ds = (DataSet) request.getAttribute("ds");
	
%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
%>
<SCRIPT>                                  
    function actionPerformed(tag){
      listForm.tag.value=tag;
      listForm.submit();
    }
    
    function docClose() {
    	self.close();
    }

</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="8" topmargin="0" marginwidth="0">
<form name="listForm" method="post">
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 성과지표 선택</strong></td>
	</tr>
</table>
<%
	if(ds != null){
%>
<!---------//좌측  KPI 선택 전청 리스트//-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="20%"><strong><font color="#003399">조직</font></strong></td>
		<td width="30%"><strong><font color="#003399">성과지표</font></strong></td>
		<td width="6%"><strong><font color="#003399">주기</font></strong></td>
		<td width="10%"><strong><font color="#003399">BSC실적</font></strong></td>
		<td width="10%"><strong><font color="#003399">평가평균</font></strong></td>
		<td width="10%"><strong><font color="#003399">평가인원</font></strong></td>
	</tr>
	<% 
	String amId = "";
   		while(ds.next()) {
    %>
    
              <tr bgcolor="#FFFFFF">
                <td align="center" bgcolor="#F0F0F0"><%=ds.getString("BNAME")%></td>
                <td><font color="#0066FF"><%=ds.getString("NAME")%></font></td>
                <td align="center" ><font color="#333333"><%=ds.getString("FREQUENCY")%></font></td>
                <td align="center" ><strong><font color="#333333"><%=ds.isEmpty("ACTUAL")?"":ds.getString("ACTUAL")%></font></strong></td>
                <td align="center" ><strong><font color="#333333"><%=ds.isEmpty("AVGSCR")?"":ds.getString("AVGSCR")%></font></strong></td>
                <td align="center" ><font color="#333333"><%=ds.isEmpty("CNT")?"":ds.getString("CNT")%></font></td>
              </tr>
    <%	}	 %>
    
</table>
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="72%" height="30">  &nbsp;
                <td width="28%" align="right">
                  <a href="#" onClick="javascript:docClose();"><img src="<%=imgUri %>/jsp/web/images/btn_close.gif" alt="적용하기" width="50" height="20" border="0" align="absmiddle"></a></td>  
              </tr>
            </table>

<%}else{ %>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="12%"><strong><font color="#003399">관점</font></strong></td>
		<td width="30%"><strong><font color="#003399">성과지표</font></strong></td>
		<td width="10%"><strong><font color="#003399">주기</font></strong></td>
		<td width="12%"><strong><font color="#003399">평균</font></strong></td>
		<td width="16%"><strong><font color="#003399">평가인원</font></strong></td>
	</tr>
	</table>
	<br>
<%	
  	out.println("해당일자와 부서 선택 후 확인버튼을 누르십시요.");
} 
%>
</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	var WinDetail;
 	function openDetail(mId,evalrId){
		if (WinDetail!=null) WinDetail.close();
		var yyyy = parent.form1.year.options[parent.form1.year.selectedIndex].value;
		var month = parent.form1.month.options[parent.form1.month.selectedIndex].value;
		var url = "adminValuateDetail.jsp?year="+yyyy+"&month="+month+"&evalrId="+evalrId+"&mId="+mId;
		WinApp = window.open(url,"","toolbar=no,width=700,height=500,scrollbars=yes,resizable=yes,menubar=no,status=no" ); 	
 	}
	
	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}
	
	
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	//mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
