<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*,
				 com.nc.cool.*"%>
<%
	String schDate = (String) request.getAttribute("schDate");

	ValuateUtil util = new ValuateUtil();
	util.setMeasure(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");
	
	PeriodUtil periodutil = new PeriodUtil();                                          
	String div_cd  = "B02" ;                                                            
	String message = ": 마감되었습니다. 조회만 가능합니다.";                          
	String year  = request.getParameter("year");
	String month = request.getParameter("month");

	String mmclose_yn = periodutil.getCheckCloseMM(year, div_cd, month);  
	if(mmclose_yn.equalsIgnoreCase("N")) message = "";

%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
%>
<SCRIPT>                                  
    var selectRow = null; 
    var selectRow1=null; 
    var selectRow2=null; 
    var selectRow3=null; 
    function funcSelectActual(id){
    	parent.openDetail(id);
      /*
      if (selectRow != null) {
        selectRow.style.backgroundColor="F0F0F0";
        selectRow1.style.backgroundColor="F0F0F0";
        selectRow2.style.backgroundColor="F0F0F0";
        selectRow3.style.backgroundColor="F0F0F0";
      }
      var sRow = eval("this.cell"+id);
      var sRow1 = eval("this.cella"+id);
      var sRow2 = eval("this.cellb"+id);
      var sRow3 = eval("this.cellc"+id);

      selectRow = sRow; 
      selectRow1 = sRow1; 
      selectRow2 = sRow2; 
      selectRow3 = sRow3; 
      selectRow.style.backgroundColor = "C4EAF9";
      selectRow1.style.backgroundColor = "C4EAF9";
      selectRow2.style.backgroundColor = "C4EAF9";
      selectRow3.style.backgroundColor = "C4EAF9";
      
      */
    }

</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="5" topmargin="0" marginwidth="5">
<form name="listForm" method="post">
<input type=hidden name=mode value="list">
<input type=hidden name=schDate >
<input type=hidden name=year >
<input type=hidden name=month >
<input type=hidden name=sbuId >
<input type=hidden name=bscId >
<input type=hidden name=defineId >
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 성과지표 선택</strong>&nbsp;&nbsp;&nbsp;
			<b><font color="red"><%=message %></font></b></td>
	</tr>
</table>
<%
	if(ds != null){
%>
<!---------//좌측  KPI 선택 전청 리스트//-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#D4DCF4">
		<td width="100"><strong><font color="#003399">관점</font></strong></td>
		<td><strong><font color="#003399">성과지표</font></strong></td>
		<td width="50"><strong><font color="#003399">주기</font></strong></td>
		<td width="150"><strong><font color="#003399">실행계획</font></strong></td>
		<td width="150"><strong><font color="#003399">실행실적</font></strong></td>
		<td width="79"><strong><font color="#003399" colspan=2>첨부</font></strong></td>
	</tr>
</table>
<div style="overflow-y:scroll;width:100%;height:140px;">
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<% int j=0;
    
    if(ds != null){
        
   		while (ds.next()) {
   			String sName = ((String)ds.getString("PNAME")).trim();
   			String mName = ((String)ds.getString("MNAME")).trim();
   			String sPlanned = ds.isEmpty("PLANNED")?"":ds.getString("PLANNED");
   			String sDetail = ds.isEmpty("DETAIL")?"":ds.getString("DETAIL");
   			
   			if (sPlanned.length()>10) sPlanned=sPlanned.substring(0,10)+"...";
   			if (sDetail.length()>10) sDetail=sDetail.substring(0,10)+"...";
   			
   			String file     = ds.isEmpty("FILEPATH")?"":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILEPATH")+"','"+ds.getString("FILENAME")+"');\"> </a>";
   			String filePlan = ds.isEmpty("FILEPATH_PLAN")?"":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILEPATH_PLAN")+"','"+ds.getString("FILENAME_PLAN")+"');\"> </a>";
   			System.out.println("filePlan   ===>   "+filePlan);
    %>
              <tr bgcolor="#FFFFFF"> 
                <td width="100" align="center" bgcolor="#F0F0F0">
                  <%=sName%>
                </td>
                <td id="cell<%=ds.getInt("MCID")%>">
                	<a style="cursor:hand;" onClick="javascript:funcSelectActual(<%=ds.getInt("MCID")%>);">
                	<font color="#0066FF"><%=mName%></font></a></td>
                <td width="50" align="center" id="cella<%=ds.getInt("MCID")%>"><font color="#333333"><%=ds.getString("FREQUENCY")%></font></td>
                <td width="150" align="left" id="cellb<%=ds.getInt("MCID")%>"><font color="#333333"><%=sPlanned%></font></td>
                <td width="150" align="left" id="cellc<%=ds.getInt("MCID")%>"><font color="#333333"><%=sDetail%></font></td>
                <td width="25" align="center" id="celld<%=ds.getInt("MCID")%>"><%=filePlan %></td>
                <td width="25" align="center" id="celld<%=ds.getInt("MCID")%>"><%=file%></td>
              </tr>
    <%
    	}	
    	j++;	} %>
</table>
<%}else{ %>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="100"><strong><font color="#003399">관점</font></strong></td>
		<td><strong><font color="#003399">성과지표</font></strong></td>
		<td width="50"><strong><font color="#003399">주기</font></strong></td>
		<td width="150"><strong><font color="#003399">실행계획</font></strong></td>
		<td width="150"><strong><font color="#003399">실행실적</font></strong></td>
		<td width="50"><strong><font color="#003399" colspan=2>첨부</font></strong></td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="140"><strong><font size=4 color='#cc0000'>해당 연도,월과 조직 선택 후 확인버튼을 누르십시요. </font></strong></td>
	</tr>
	</table>
<%} %>
</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
	<input type="hidden" name="filePath">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	function download(filepath,filename){
		downForm.fileName.value=filename;
		downForm.filePath.value=filepath;
		downForm.submit();
	}
	
	
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	//mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
