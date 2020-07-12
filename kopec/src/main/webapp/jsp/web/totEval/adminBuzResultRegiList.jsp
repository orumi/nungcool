<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
				com.nc.totEval.*,
				com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(1);
	
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
	util.setAdminBuzResultRegi(request, response);
	
	EstScrManager manager = (EstScrManager)request.getAttribute("manager");
	Object[] years = (Object[]) request.getAttribute("years");
	
	ArrayList meas = null;
	EstCompany[] coms = null;
	int comCnt = 0;
	
	if (manager!=null) {
		meas = manager.measures;
		coms = manager.getCompanys();
		comCnt = coms.length;
	}

%>
<SCRIPT>                                  
    function actionPerformed(tag){
    	listFrm.mode.value=tag;
    	listFrm.year.value = parent.form1.year.options[parent.form1.year.selectedIndex].value;
    	
    	listFrm.submit();
    }
	function mergeCell(tbl, startRow, cNum, length, add) {
		var isAdd = false;
		if(tbl == null) return;
		if(startRow == null || startRow.length == 0) startRow = 1;
		if(cNum == null || cNum.length == 0) return ;
		if(add  == null || add.length == 0) {
			isAdd = false;
		} else {
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
			} else if(cnt > 0) {
				merge(tbl, startRow, cnt, cNum, length);
				startRow = endRow = 0;
				cnt = 0;
			} else {
			}
			tempVal = curVal;
		}
	
		if(cnt > 0) {
			merge(tbl, startRow, cnt, cNum, length);
		}
	}
	
	function merge(tbl, startRow, cnt, cellNum, length) {
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


<table width="1230" border="0" cellpadding="3" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="80" rowspan=2><strong><font color="#003399">평가부문</font></strong></td>
		<td width="120" rowspan=2><strong><font color="#003399">지표명</font></strong></td>
		<td width="40" rowspan=2><strong><font color="#003399">배점</font></strong></td>
		<td colspan=<%=comCnt+2 %>><strong><font color="#003399">득점</font></strong></td>
		<td colspan=6><strong><font color="#003399">순위</font></strong></td>
	</tr>
	<tr align="center" bgcolor="#D4DCF4">	
	<% 
	String pmMeas = "";
	String pmComs = "";

	if (coms!=null) { %>
	<% for(int c=0;c<coms.length;c++){ 
		EstCompany com = coms[c];
		pmComs += "|"+com.id;
	%>
		<td width="60" ><strong><font color="#003399"><%=com.name %></font></strong></td>
	<% } // end of for coms.length%>
	<% } // end of if coms is not null %>
		<td width="70" ><strong><font color="#003399">평균</font></strong></td>
		<td width="70" ><strong><font color="#003399">차이</font></strong></td>
		
		<td width="70" ><strong><font color="#003399"><%=years!=null?(String)years[0]:"" %></font></strong></td>
		<td width="70" ><strong><font color="#003399"><%=years!=null?(String)years[1]:"" %></font></strong></td>
		<td width="70" ><strong><font color="#003399"><%=years!=null?(String)years[2]:"" %></font></strong></td>
		<td width="70" ><strong><font color="#003399"><%=years!=null?(String)years[3]:"" %></font></strong></td>
		<td width="70" ><strong><font color="#003399">가중평균</font></strong></td>
		<td width="70" ><strong><font color="#003399">차이</font></strong></td>		
	</tr>
	<% if (meas!=null) { %>
	<% for (int i=0;i<meas.size();i++) { 
		EstMeasure mea = (EstMeasure)meas.get(i);
		pmMeas += "|"+mea.id;
	%>
	<tr align="center" bgcolor="#FFFFFF">
		<td ><%=mea.section %></td>
		<td ><%=mea.name %></td>
		<td ><%=mea.allot %></td>
	<% 
	double avg=0;
	double dif=0;
	int[] ranks = new int[4];
	double allotW = 0;
	double allotD = 0;
	if (coms!=null) { 
		for(int c=0;c<coms.length;c++){ 
			EstScore scr = mea.getEstScore(coms[c]);
			if((scr!=null)&&(scr.comId==1)){
				avg=scr.avg;
				dif=scr.diff;
				ranks[0]=scr.rankB;
				ranks[1]=scr.rankB1;
				ranks[2]=scr.rankB2;
				ranks[3]=scr.rankB3;
				allotW = scr.allotAvg!=0?scr.allotAvg:0.5*ranks[1]+0.3*ranks[2]+0.2*ranks[3];
				allotD = scr.allotDiff!=0?scr.allotDiff:allotW-ranks[0];
			}
	%>
		<td width="60" ><strong><font color="#003399"><input type=text name="scr|<%=mea.id %>|<%=coms[c].id %>" value="<%=scr!=null?String.valueOf(scr.score):"" %>" style="width:50px;"></font></strong></td>
	<% } // end of for coms.length%>
	<% } // end of if coms is not null %>
		<td><%=nf.format(avg) %></td>
		<td><%=nf.format(dif) %></td>
		<td><%=ranks[0] %></td>
		<td><%=ranks[1] %></td>
		<td><%=ranks[2] %></td>
		<td><%=ranks[3] %></td>
		<td><input type=text name=allotWeight<%=mea.id %> style="width:55px" value="<%=allotW %>"></td>
		<td><%=allotD %></td>
	</tr>
	<% } // end of for (meas.size) %>
	<% } //end of if (meas is not null)%>
</table>
	<input type=hidden name=pmMeas value="<%=pmMeas %>">
	<input type=hidden name=pmComs value="<%=pmComs %>"> 
<table width=1230>
	<tr><td align=right>
		<img src="<%=imgUri%>/jsp/web/images/btn_SaveScore.gif" alt="득점저장" onClick="javascript:actionPerformed('A');" style="cursor:hand" width="84" height="20" border="0" align="absmiddle">
		<img src="<%=imgUri%>/jsp/web/images/btn_delScore.gif" alt="득점삭제" onClick="javascript:actionPerformed('D');" style="cursor:hand" width="84" height="20" border="0" align="absmiddle">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<img src="<%=imgUri%>/jsp/web/images/btn_SaveAllot.gif" alt="가중평균저장" onClick="javascript:actionPerformed('WA');" style="cursor:hand" width="128" height="20" border="0" align="absmiddle">
		<img src="<%=imgUri%>/jsp/web/images/btn_delAllot.gif" alt="가중평균삭제" onClick="javascript:actionPerformed('WD');" style="cursor:hand" width="128" height="20" border="0" align="absmiddle">		
	</td></tr>
</table>
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
