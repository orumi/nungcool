<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
					com.nc.eval.*,
					com.nc.util.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>

<%
	String schDate = (String) request.getAttribute("schDate");

	String cname = "";
	String sname = "";
	String bname = "";
	String avg_score = "";
	String meas_score = "";

	AdminValuate util = new AdminValuate();
	util.setEvalMeasure(request, response);

	EvalMeasureUtil meautil = (EvalMeasureUtil)request.getAttribute("meautil");

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

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
		<tr align="center" bgcolor="#375f9c" style="height:32px;">
			<td width="115" rowspan=2><strong><font color="#ffffff">지표</font></strong></td>
			<td width="65" rowspan=2><strong><font color="#ffffff">구분</font></strong></td>
			<td width="65" rowspan=2><strong><font color="#ffffff">조직명</font></strong></td>
			<td colspan=<%=username.length %>><strong><font color="#ffffff">평가단</font></strong></td>
			<td width="45" rowspan=2><strong><font color="#ffffff">평균<br>점수</font></strong></td>
			<td width="40" rowspan=2><strong><font color="#ffffff">평균<br>등급</font></strong></td>
			<td width="45" rowspan=2><strong><font color="#ffffff">득점 <br> </font></strong></td>
		</tr>
		<tr align="center" bgcolor="#375f9c">
		<%	for(int k=0;k<username.length;k++){ %>
<!--			<td ><strong><font color="#003399"><a href="javascript:openDetail('<%=userId[k]%>','<%=username[k] %>');"><%=username[k] %></a></font></strong></td>-->
			<td ><strong><font color="#ffffff"><%=username[k] %></a></font></strong></td>
		<% } %>
		</tr>

		<%
	    ArrayList meaList = meautil.meaList;
	   		for (int i=0;i<meaList.size();i++) {
	   			EvalMeasure mea = (EvalMeasure)meaList.get(i);
	    %>
	              <tr bgcolor="#FFFFFF">
	                <%-- <td bgcolor="#F0F0F0"><%=mea.belong%></td> --%>
	                <td><font color="#333333"><%=mea.sname!=null?mea.sname:""%></font></td>
	                <td><font color="#333333"><%=mea.pname!=null?mea.pname:""%></font></td>
	                <td><font color="#333333"><%=mea.name!=null?mea.name:""%></font></td>
				<%	for(int l=0;l<userId.length;l++){
						EvalDetail detail = mea.getActual(userId[l]);
						String score = (detail!=null)?String.valueOf(detail.evalScore):"";
				%>
					<td align="right"><font color="#333333"><%=score!=null?score:"" %></font></td>
				<% }

				if(userId.length == 0){
					%>
					<td align="right"><font color="#333333"></font></td>
				<%
				}

					int grade_score = 0;
		   			String grade = "";

		   			if((double)ServerStatic.UPPER <= mea.getAvg()){
		   				grade_score = ServerStatic.UPPER;
		   				//out.println("grade_score sss ======= "+grade_score);
		   				grade = "S";
		   			}else if((double)ServerStatic.HIGH <= mea.getAvg()){
		   				grade_score = ServerStatic.HIGH;
		   				//out.println("grade_score aaa ======= "+grade_score);
		   				grade = "A";
		   			}else if((double)ServerStatic.LOW <= mea.getAvg()){
		   				grade_score = ServerStatic.LOW;
		   				//out.println("grade_score bbb ======= "+grade_score);
		   				grade = "B";
		   			}else if((double)ServerStatic.LOWER <= mea.getAvg()){
		   				grade_score = ServerStatic.LOWER;
		   				//out.println("grade_score ccc ======= "+grade_score);
		   				grade = "C";
		   			}else if((double)ServerStatic.LOWER > mea.getAvg() && 0.0 < mea.getAvg()){
		   				grade_score = ServerStatic.LOWST;
		   				//out.println("grade_score ddd ======= "+grade_score);
		   				//out.println(" mea.getAvg() ddd ======= "+ mea.getAvg());
		   				grade = "D";
		   			}else {
		   				grade_score = 0;
		   				grade = "";
		   			}

				%>
	                <td align="right" ><font color="#333333"><%=mea.bname!=null?mea.bname:""%></font></td>
	                <td align="center" ><font color="#333333"><%=mea.belong!=null?mea.belong:""%></font></td>
	                <td align="right" ><font color="#333333"><%=mea.frequency!=null?mea.frequency:""%></font></td>
	              </tr>
	    <%	}	 %>
	</table>
<%
	} else { // 선택한 목록이 없을 경우
%>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#375f9c" style="height:32px;">
		<td width="110" rowspan=2><strong><font color="#ffffff">지표</font></strong></td>
		<td width="105" rowspan=2><strong><font color="#ffffff">구분</font></strong></td>
		<td width="105" rowspan=2><strong><font color="#ffffff">조직명</font></strong></td>
		<td colspan=4><strong><font color="#ffffff">평가단</font></strong></td>
		<td width="45" rowspan=2><strong><font color="#ffffff">평균<br>점수</font></strong></td>
		<td width="40" rowspan=2><strong><font color="#ffffff">평균<br>등급</font></strong></td>
		<td width="45" rowspan=2><strong><font color="#ffffff">득점 <br> </font></strong></td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="130"><strong><font size=3 color='#cc0000'>해당 연도와 그룹 선택 후 확인버튼을 누르십시요.</font></strong></td>
	</tr>
	</table>
<% } %>
</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	var WinDetail;
 	function openDetail(evalrId,evalrName){
		if (WinDetail!=null) WinDetail.close();
		var year  = parent.form1.year.options[parent.form1.year.selectedIndex].value;
		var month = parent.form1.month.options[parent.form1.month.selectedIndex].value;
		var grpId = parent.form1.firstPart.options[parent.form1.firstPart.selectedIndex].value;
		var url = "popDetail.jsp?year="+year+"&month="+month+"&evalrId="+evalrId+"&grpId="+grpId+"&evalrName="+evalrName;
		WinApp = window.open(url,"","toolbar=no,width=700,height=500,scrollbars=yes,resizable=yes,menubar=no,status=no" );
 	}

	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}


	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
