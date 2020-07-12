<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
					com.nc.totEval.*,
					com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

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
	util.setAdminBuzMeaList(request, response);
	
	DataSet ds = (DataSet)request.getAttribute("ds");


%>
<SCRIPT>                                  
    function funcSelectActual(id){
    }

	function sendDetail(mid,year,sectionId,name,allot,bscId,factor,orderby){
		var frm = parent.detail.form1;
		frm.section.value=sectionId;
		parent.detail.chgOrg(1);
		
		frm.measure.value=mid;
		frm.year.value=year;
		frm.allot.value=allot;
		
		
		frm.bscId.value=bscId;
		frm.factor.value=factor;
		frm.orderby.value=orderby;
		
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

<input type=hidden name=mode>
<input type=hidden name=year>
<input type=hidden name=measure>
<input type=hidden name=name>
<input type=hidden name=allot>
<input type=hidden name=bscId>
<input type=hidden name=factor>
<input type=hidden name=orderby>

<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 경영지표 목록 </strong></td>
	</tr>
</table>

<!---------//좌측  KPI 선택 전청 리스트//-------->


<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="25%" ><strong><font color="#003399">평가부문</font></strong></td>
		<td width="35%" ><strong><font color="#003399">지표명</font></strong></td>
		<td width="15%" ><strong><font color="#003399">배점</font></strong></td>
		<td width="25%" ><strong><font color="#003399">주관부서</font></strong></td>
	</tr>
<% if (ds!=null) {
	double tot = 0;
	while(ds.next()) { %>

	<tr align="left" bgcolor="#FFFFFF">
		<td><%=ds.getString("SNAME") %></td>
		<td><a href="javascript:sendDetail('<%=ds.getString("MID")%>','<%=ds.getString("YEAR")%>','<%=ds.getString("SECTIONID")%>','<%=ds.getString("MNAME")%>','<%=ds.getString("ALLOT")%>','<%=ds.getString("BSCID")%>','<%=ds.getString("FACTOR")%>','<%=ds.getString("ORDERBY") %>');"><%=ds.getString("MNAME") %></a></td>
		<td align="right"><%=ds.getString("ALLOT") %></td>
		<td><%=ds.getString("BNAME") %></td>
	</tr>
<% 
	tot += ds.getDouble("ALLOT");
	}
%>
	<tr align="left" bgcolor="#FFFFFF">
		<td>합계</td>
		<td>&nbsp;</td>
		<td align="right"><%=tot %></td>
		<td>&nbsp;</td>
	</tr>
<%	} %>	
</table>

			<% if (ds==null){
			  	out.println("    <br><strong><font size=4 color='#cc0000'>해당일자를 선택한 후 확인버튼을 누르십시요. </font></strong>");
				
			} %>
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
