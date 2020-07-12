<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*,
				 com.nc.cool.*"%>
<%
	String schDate = (String) request.getAttribute("schDate");

	ActualUtil util = new ActualUtil();
	util.setAuthMeasure(request, response); 

	DataSet ds = (DataSet)request.getAttribute("ds");
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(1);
	
	PeriodUtil periodutil = new PeriodUtil();                                          
	String div_cd     = "B02" ;                                                            
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
      
      parent.openDetail(id);
    }

	function mergeCell(tbl, startRow, cNum, length, add)
	{
		var isAdd = false;
		if(tbl == null) return;
		if(startRow == null || startRow.length == 0) startRow = 1;
		if(cNum == null || cNum.length == 0) return ;
		if(add  == null || add.length == 0) {
			isAdd = false;
		}else {
			isAdd = true;
			add   = parseInt(add);
		}
		cNum   = parseInt(cNum);
		length = parseInt(length);
	
		rows   = tbl.rows;
		rowNum = rows.length;
	
		tempVal  = '';
		cnt      = 0;
		startRow = parseInt(startRow);
	
		for( i = startRow; i < rowNum; i++ ) { 
			curVal = rows[i].cells[cNum].innerHTML;
			if(isAdd) curVal += rows[i].cells[add].innerHTML;
			if( curVal == tempVal ) {
				if(cnt == 0) {
					cnt++;
					startRow = i - 1;
				}
				cnt++;
			}else if(cnt > 0) {
				merge(tbl, startRow, cnt, cNum, length);
				startRow = endRow = 0;
				cnt = 0;
			}else {
			}
			tempVal = curVal;
		}
	
		if(cnt > 0) {
			merge(tbl, startRow, cnt, cNum, length);
		}
	}
	
	function merge(tbl, startRow, cnt, cellNum, length)
	{
		rows = tbl.rows;
		row  = rows[startRow];
	
		for( i = startRow + 1; i < startRow + cnt; i++ ) {
			for( j = 0; j < length; j++) {
				rows[i].deleteCell(cellNum);
			}
		}
		for( j = 0; j < length; j++) {
			row.cells[cellNum + j].rowSpan = cnt;
		}
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
<form name="listForm" method="post" >
<input type=hidden name=mode value="list">
<input type=hidden name=year >
<input type=hidden name=month >
<input type=hidden name=schDate >
<input type=hidden name=sbuId >
<input type=hidden name=bscId >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="9" align="absmiddle"> 성과지표 선택</strong>&nbsp;&nbsp;&nbsp;
			<b><font color="red"><%=message %></font></b></td>
			
	</tr>
</table>
<%
	if(ds != null){
%>
<!---------//좌측  KPI 선택 전청 리스트//-------->
<table width="100%" border="0" cellpadding="6" cellspacing="1" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#D4DCF4">
		<td width="150"><strong><font color="#003399">조직명</font></strong></td>
		<td><strong><font color="#003399">성과지표</font></strong></td>
		<td width="50"><strong><font color="#003399">주기</font></strong></td>
		<td width="70"><strong><font color="#003399">가중치</font></strong></td>
		<td width="70"><strong><font color="#003399">등급</font></strong></td>
		<td width="70" bgcolor="#D4DCF4"><strong><font color="#003399">평가점수</font></strong></td>
		<td width="70" bgcolor="#D4DCF4"><strong><font color="#003399">득점</font></strong></td>
	</tr>
</table>
<div style="overflow-y:scroll;width:100%;height:385px;">
<table width="100%" border="0" cellpadding="6" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<% int j=0;
    
    if(ds != null){
        
   		while (ds.next()) {
   			String bName   = ((String)ds.getString("BNAME")).trim();
   			String mName   = ((String)ds.getString("MNAME")).trim();
   			String mWeight = ((String)ds.getString("MWEIGHT")).trim();
   			String sActual = ds.isEmpty("ACTUAL")?"":ds.getString("ACTUAL");
   			String sScore  = ds.isEmpty("SCORE")?"":ds.getString("SCORE");
   			String sGrade  = ds.isEmpty("GRADE")?"":ds.getString("GRADE");   			
   			String sGScore = ds.isEmpty("GRADE_SCORE")?"":ds.getString("GRADE_SCORE");
   			
   			String file = ds.isEmpty("FILENAME")?"":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILENAME")+"');\"> </a>";
    %>
              <tr bgcolor="#FFFFFF"> 
                <td width="150" align="center" bgcolor="#F0F0F0">
                  <%=bName%>
                </td>
                <td id="cell<%=ds.getInt("MCID")%>">
                	<a style="cursor:hand;" onClick="javascript:funcSelectActual(<%=ds.getInt("MCID")%>);">
                	<font color="#0066FF"><%=mName%></font></a></td>
                <td width="50" align="center" id="cella<%=ds.getInt("MCID")%>"><font color="#333333"><%=ds.getString("FREQUENCY")%></font></td>
                <td width="70" align="center" id="cellb<%=ds.getInt("MCID")%>"><font color="#333333"><%=mWeight%></font></td>
                <td width="70" align="center" id="cellc<%=ds.getInt("MCID")%>"><font color="#333333"><%=sGrade%></font></td>
                <td width="70" align="center" id="celld<%=ds.getInt("MCID")%>"><font color="#333333"><%=sScore%></font></td>
                <td width="53" align="center" id="celle<%=ds.getInt("MCID")%>"><font color="#333333"><%=sGScore%></font></td>
              </tr>
    <%
    	}	
    	j++;	} %>
</table>
<%}else{ %>
	<table width="100%" border="0" cellpadding="6" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="150"><strong><font color="#003399">조직명</font></strong></td>
		<td><strong><font color="#003399">성과지표</font></strong></td>
		<td width="50"><strong><font color="#003399">주기</font></strong></td>
		<td width="70"><strong><font color="#003399">가중치</font></strong></td>
		<td width="70"><strong><font color="#003399">등급</font></strong></td>
		<td width="70" bgcolor="#D4DCF4"><strong><font color="#003399">평가점수</font></strong></td>
		<td width="70" bgcolor="#D4DCF4"><strong><font color="#003399">득점</font></strong></td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="6" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="150"><strong><font size=4 color='#cc0000'>해당 연도와 월을  선택 후 확인버튼을 누르십시요. </font></strong></td>
	</tr>
	</table>
<%} %>
</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/actual/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}
	
	mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
