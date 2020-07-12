<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
					com.nc.eval.*,
					com.nc.util.*"%>
<%
	String schDate = (String) request.getAttribute("schDate");
	
	AdminValuate util = new AdminValuate();
	util.setEvalMeasure(request, response);

	EvalMeasureUtil meautil = (EvalMeasureUtil)request.getAttribute("meautil");

%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
%>
<SCRIPT>                                  
    function funcSelectActual(id){
     // parent.openDetail(id);
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
<body leftmargin="8" topmargin="0" marginwidth="0">
<form name="listForm" method="post">
<input type=hidden name=mode>
<input type=hidden name=year >
<input type=hidden name=month >
<input type=hidden name=grpId >

<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 성과지표 선택</strong></td>
	</tr>
</table>
<%
	if(meautil != null){
			String[] username = meautil.getAppName();
			String[] userId = meautil.getAppUserId();
	%>

	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
		<tr align="center" bgcolor="#D4DCF4">
			<%-- <td align=center width="80" rowspan=1><strong><font color="#003399">지표구분</font></strong></td> --%>
			<td align=center rowspan=1><strong><font color="#003399">지표</font></strong></td>
			<td align=center width="170" rowspan=1><strong><font color="#003399">구분</font></strong></td>
			<td align=center width="190" rowspan=1><strong><font color="#003399">조직명</font></strong></td>
			<td align=center width="90" rowspan=1><strong><font color="#003399">평균점수</font></strong></td>
			<td align=center width="80" rowspan=1><strong><font color="#003399">평균등급</font></strong></td>
			<td align=center width="80" rowspan=1><strong><font color="#003399">가중치</font></strong></td>
			<td align=center width="90" rowspan=1><strong><font color="#003399">득점 </font></strong></td>				
		</tr>

		<% 
	    ArrayList meaList = meautil.meaList;
	   		for (int i=0;i<meaList.size();i++) {
	   			EvalMeasure mea = (EvalMeasure)meaList.get(i);
	   			int score = 0;
	   			String grade = "";
	   			if((double)ServerStatic.UPPER <= mea.getAvg()){
	   				score = ServerStatic.UPPER;
	   				grade = "S";
	   			}else if((double)ServerStatic.HIGH <= mea.getAvg()){
	   				score = ServerStatic.HIGH;
	   				grade = "A";
	   			}else if((double)ServerStatic.LOW <= mea.getAvg()){
	   				score = ServerStatic.LOW;
	   				grade = "B";
	   			}else if((double)ServerStatic.LOWER <= mea.getAvg()){
	   				score = ServerStatic.LOWER;
	   				grade = "C";
	   			}else if((double)ServerStatic.LOWER > mea.getAvg() && 0 < mea.getAvg()){
	   				score = ServerStatic.LOWST;
	   				grade = "D";
	   			}else {
	   				score = 0;
	   				grade = "";
	   			}
	   				
	    %>
	              <tr bgcolor="#FFFFFF">
	                <%--  <td width="80"><font color="#333333"><%=mea.belong%></font></td>  --%>
	              	<td bgcolor="#F0F0F0" ><font color="#333333"><%=mea.sname!=null?mea.sname:""%></font></td>
	              	<td width="150"><%=mea.pname!=null?mea.pname:""%></td>
	                <td width="150"><%=mea.name!=null?mea.name:""%></td>
	                <td width="70" align="right" ><font color="#333333"><%=mea.bname!=null?mea.bname:""%></font></td>
	                <td width="60" align="center" ><font color="#333333"><%=mea.belong!=null?mea.belong:""%></font></td>
					<td width="60" align="right" ><font color="#333333"><%=mea.weight %></font></td>
	                <td width="70" align="right" ><font color="#333333"><%=mea.frequency!=null?mea.frequency:""%></font></td>
	              </tr>
	              	                
	    <%	}	 %>
	</table>

<%	
	} else { // 선택한 목록이 없을 경우   
	
%>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<%-- <td align=center width="80" rowspan=1><strong><font color="#003399">지표구분</font></strong></td>  --%>
		<td align=center rowspan=1><strong><font color="#003399">지표</font></strong></td>
		<td align=center width="170" rowspan=1><strong><font color="#003399">구분</font></strong></td>
		<td align=center width="190" rowspan=1><strong><font color="#003399">조직명</font></strong></td>
		<td align=center width="90" rowspan=1><strong><font color="#003399">평균점수</font></strong></td>
		<td align=center width="80" rowspan=1><strong><font color="#003399">평균등급</font></strong></td>
		<td align=center width="80" rowspan=1><strong><font color="#003399">가중치</font></strong></td>
		<td align=center width="90" rowspan=1><strong><font color="#003399">득점 </font></strong></td>				
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="130"><strong><font size=3 color='#cc0000'>해당 연도와 그룹 선택 후 확인버튼을 누르십시요.</font></strong></td>
	</tr>
	</table>
<%} %>
</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	var WinDetail;
 	function openDetail(evalrId){
		if (WinDetail!=null) WinDetail.close();
		var year = parent.form1.year.options[parent.form1.year.selectedIndex].value;
		var grpId = parent.form1.firstPart.options[parent.form1.firstPart.selectedIndex].value;
		var url = "popDetail.jsp?year="+year+"&evalrId="+evalrId+"&grpId="+grpId;
		WinApp = window.open(url,"","toolbar=no,width=700,height=500,scrollbars=yes,resizable=yes,menubar=no,status=no" ); 	
 	}
	
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
