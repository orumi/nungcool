<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*,
				 com.nc.cool.*"%>				 
<%
	String schDate = (String) request.getAttribute("schDate");
	
	ActualUtil util = new ActualUtil();
	util.getOrgMeasure(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");

	// 마감체크	
	PeriodUtil periodutil = new PeriodUtil();                                          
	String div_cd     = "B02" ;                                                            
	String message = ": 마감되었습니다.";                          

	String year  = request.getParameter("year");
	String month = request.getParameter("month1");
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
    var selectRow1 = null; 
    var selectRow2 = null;
    function funcSelectActual(id, m_name){
      
      parent.openDetail(id, m_name);
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
<input type=hidden name=month1 >
<input type=hidden name=month2 >
<input type=hidden name=sbuId >
<input type=hidden name=bscId >
<input type=hidden name=defineId >
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 지표 선택</strong>&nbsp;&nbsp;&nbsp;
			<b><font color="red"><%=message %></font></b></td>
	</tr>
</table>
<%
	if(ds != null){
%>
<!---------//좌측  KPI 선택 전청 리스트//-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#D4DCF4">
		<td width="200"><strong><font color="#003399">지표</font></strong></td>
		<td ><strong><font color="#003399">주기</font></strong></td>
<!--		<td><strong><font color="#003399">구분</font></strong></td>-->
	</tr>
</table>
<div style="overflow-y:auto;width:100%;height:480px;">
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>	
	<% int j=0;
    
    if(ds != null){
        String tmpName = "";
   		while (ds.next()) {
   			String mName = ((String)ds.getString("MNAME")).trim();
   			if(!tmpName.equals(mName)){
   				String mChar = ds.getString("MEASCHAR").equals("I")?"고유지표":"공통지표";
   	 %>
              <tr bgcolor="#FFFFFF"> 
                <td  width="200" id="cell<%=ds.getInt("MSID")%>">
                	<a style="cursor:hand;" onClick="javascript:funcSelectActual(<%=ds.getInt("MSID")%>, '<%=mName %>');">
                	<font color="#0066FF"><%=mName%></font></a></td>
                <td align="center" id="cella<%=ds.getInt("MSID")%>"><font color="#333333"><%=ds.getString("FREQUENCY")%></font></td>
<!--                <td align="center" id="cella<%=ds.getInt("MSID")%>"><font color="#333333"><%=mChar %></font></td>-->
              </tr>
    <%
   			tmpName = mName;
   			}
    	}	
    	j++;	} %>
</table>
<%}else{ %>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="200"><strong><font color="#003399">지표</font></strong></td>
		<td ><strong><font color="#003399">주기</font></strong></td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="120"><strong><font size=3 color='#cc0000'>해당 년월과 조직 선택 후 확인버튼을 누르십시요.</font></strong></td>
	</tr>
	</table>
<%} %>
</form>
</body>
</html>
