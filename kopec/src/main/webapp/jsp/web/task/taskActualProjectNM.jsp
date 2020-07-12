<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
    request.setCharacterEncoding("euc-kr");
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

	TaskActualUtil tau = new TaskActualUtil();

	tau.setProject(request, response);
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

		function openDetail(pid,typeid) {
			parent.taskList.form1.pid.value=pid;
			parent.taskList.form1.submit();
			
			//parent.detailDtl.form1.typeid.value = typeid;
			//parent.detailDtl.form1.submit();
			
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
</script>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
<form name="form2" method="post" action="" >
</form>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#9DB5D7">
	<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#9DB5D7">
		<tr bgcolor="#FFFFFF">
			<td height="30" colspan="2"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				전략과제 리스트</strong></td>
		</tr>
	<tr bgcolor="#D4DCF4">
        <td width="120" align="center"><strong><font color="#003399">중점전략부문</font></strong></td>
        <td align="center"><strong><font color="#003399">전략 관제</font></strong></td>
	</tr>
	</table>
	<div style="overflow-y:auto;width:100%;height:120px;">
	<table id='tbl0' width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#9DB5D7">
<%
			if(ds != null)
				while(ds.next()) {
					String convStr = ds.getString("PNAME");
					if(convStr.length() > 25)
						convStr = convStr.substring(0, 12) + "...";
%>
               <tr bgcolor="#FFFFFF">
                <td width="120" align="center"><%=ds.getString("TYPENAME") %></td>
				<td title="<%=ds.getString("PNAME") %>">
					<a href="javascript:openDetail('<%=ds.getString("PID")%>');">
					<%=convStr %>
					</a>
				</td>
               </tr>
<%
				}
%>
	</table>
	</div>
</table>
</body>
</html>
<SCRIPT>
<!--

	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>