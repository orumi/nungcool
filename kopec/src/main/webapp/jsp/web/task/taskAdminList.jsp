<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    
    request.setCharacterEncoding("euc-kr");

	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		return;
	}
    
    
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	TaskAdmin util = new TaskAdmin();
	util.setProject(request, response);

	
	DataSet ds = (DataSet)request.getAttribute("ds");	//프로젝트 리스트

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">
		var prjList = new Array();

		function openDetail(pid) {
			var frmDetail = parent.detail.form1;
			
			if (frmDetail !=null) {
				frmDetail.pid.value=pid;
				frmDetail.mode.vlaue="G";
				frmDetail.submit();

//				alert(typeid);
				parent.dlist.form1.projectId.value=pid;
				parent.dlist.form1.submit();
			}
		}

		var refresh = false;

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
</script>
<body>
<div>
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr bgcolor="#D4DCF4">
	    <td align="center" width="200"><strong><font color="#003399">혁신전략</font></strong></td>
	    <td align="center" width=""><strong><font color="#003399">Sub 전략</font></strong></td>
	</tr>
</table>
</div>
<div style="overflow-y:auto;width:100%;height:170px;">
<table id='tbl0' width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<%
	if(ds != null){
		while(ds.next()) {
%>
	<tr bgcolor="#FFFFFF">
        <td width="200" align="center"><%=ds.getString("TYPENAME") %></td>
		<td><a href="javascript:openDetail('<%=ds.getString("PID")%>');" >
<% 
			if(ds.getString("NAME").length() > 25) 
				out.print(ds.getString("NAME").subSequence(0, 14)+"..."      );
			else
				out.print(ds.getString("NAME"));
%>
			</a>
		</td>
	</tr>
<%
		}
	}else{
%>
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="120"><strong><font size=3 color='#cc0000'>해당 혁신전략이 없습니다.</font></strong></td>
	</tr>
<% } %>
</table>
</div>
</body>
</html>
<SCRIPT>
<!--

	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>