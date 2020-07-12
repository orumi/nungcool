<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
				com.nc.totEval.*,
				com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	
	String userId = (String)session.getAttribute("userId");

	if (userId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<% 
		return;
	}

	ESTAdminUtil util = new ESTAdminUtil();
	util.setAdminBuzScore01(request, response);
	
	EstManager manager = (EstManager)request.getAttribute("manager");
	
	ArrayList meas = null;
	Division[] divs = null;
	int divCnt = 0;
	if (manager!=null) {
		meas = manager.measures;
		divs = manager.getDivisions();
		divCnt = divs.length;
	}


%>
<SCRIPT>                                  
    function actionPerformed(tag){
    	listFrm.mode.value=tag;
    	listFrm.year.value = parent.form1.year.options[parent.form1.year.selectedIndex].value;
    	
    	listFrm.submit();
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
<form name="listFrm" method="post">

<input type=hidden name=mode >
<input type=hidden name=year>


<!---------//좌측  KPI 선택 전청 리스트//-------->


<table width="950" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="100" rowspan=2><strong><font color="#003399">평가부문</font></strong></td>
		<td width="120" rowspan=2><strong><font color="#003399">지표명</font></strong></td>
		<td width="50" rowspan=2><strong><font color="#003399">배점</font></strong></td>
		<td width="70" rowspan=2><strong><font color="#003399">금년순위</font></strong></td>
		<td width="70" rowspan=2><strong><font color="#003399">평균순위</font></strong></td>
		<td width="70" rowspan=2><strong><font color="#003399">차이</font></strong></td>
		<td colspan=<%=divCnt %>><strong><font color="#003399">배분점수</font></strong></td>
	</tr>
	<%
	String pmMeas="";
	String pmDivs="";
	double totAllot=0;
	double sumAllot=0;
	if (divs!=null) { %> 
	<tr align="center" bgcolor="#D4DCF4">	
	<%	for(int d=0;d<divs.length;d++) { %>
		<td width="70" ><strong><font color="#003399"><%=divs[d].name %></font></strong></td>
		<% 
		pmDivs += "|"+divs[d].id;	
	} %>
	</tr>	
	<% } %>
	
	<% if (meas!=null) { 
		double avgRank = 3.5;
		
	%>		
	<% for (int m=0;m<meas.size();m++) { 
		EstMeasureDetail mea = (EstMeasureDetail)meas.get(m);
		sumAllot += mea.allot;
		pmMeas += "|"+mea.id;
		double rankDiff = avgRank-mea.rank;
	%>	
	<tr align="center" bgcolor="#FFFFFF">
		<td ><%=mea.section %></td>
		<td ><%=mea.name %></td>
		<td ><%=nf.format(mea.allot) %></td>
		<td ><%=nf.format(mea.rank) %></td>
		<td ><%=avgRank %></td>
		<td ><%=nf.format(rankDiff) %></td>
	
	<% 
		double sub = 0;
		if (divs!=null) { %> 
		<%	for(int d=0;d<divs.length;d++) { 
			EstDetail dtl = (EstDetail)mea.details.get(divs[d]);
			double scr = 0;
			if (dtl!=null){
				if (dtl.score!=0){
					scr = dtl.score;
				} else {
					scr = dtl.allot*rankDiff;
				}
			}
		%>
		<td><input type=text name="dtl|<%=mea.id %>|<%=divs[d].id %>" value="<%=scr!=0?String.valueOf(nf.format(scr)):""%>" style="width:60px;text-align:right"></td>
			<% 
			if (dtl!=null){
				sub+= dtl.allot;
				divs[d].totAllot += dtl.allot;
				totAllot += dtl.allot;
			}
		} %>
		<% } %>
	</tr>
		
		
	<% } %>	
	
	<% } %>
		
</table>
<table width=950>
	<tr><td align=right>
		<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" onClick="javascript:actionPerformed('A');" style="cursor:hand" width="50" height="20" border="0" align="absmiddle">
		<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" alt="초기화" onClick="javascript:actionPerformed('R');" style="cursor:hand" width="65" height="20" border="0" align="absmiddle">
	</td></tr>
</table>
	<input type=hidden name=pmMeas value="<%=pmMeas %>">
	<input type=hidden name=pmDivs value="<%=pmDivs %>"> 
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
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
