<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%@ page import="java.util.*" %>
<%@ page import="com.nc.xml.*" %>
<%
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(1);
	
    String userId = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");

	if(userId.equals(""))  {
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		 
		return;
	}

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	TaskInitiative util = new TaskInitiative();
	util.setTaskObjective(request, response);
	
	ArrayList list = (ArrayList)request.getAttribute("list");
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">

		function actionPerformed(tag){
			
		}
		
		function sendDetail (projectId,detailId){
			var frm = parent.detail.form1;
			
			frm.projectId.value = projectId;
			frm.detailId.value = detailId;
			
			 frm.submit();
		}
		
	function mergeCell(tbl, startRow, cNum, length, add) {
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
	
</script>
<body >
		 	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
	                  	과제별 지표 목록</strong></td>
	              </tr>
	         </table>
			<table width="100%" border="0"  cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id="tbl0">
			<form name="form1" >
			<input type="hidden" name="mode">
			<input type="hidden" name="sbuId">
			<input type="hidden" name="bscId">
			<input type="hidden" name="schDate">
              <tr bgcolor="#D4DCF4">
                <td width=60 align="center"><strong><font color="#003399">관점</font></strong></td>
                <td width=80 align="center"><strong><font color="#003399">전략목표</font></strong></td>
                <td width=80 align="center"><strong><font color="#003399">지표</font></strong></td>
                <td width=60 align="center"><strong><font color="#003399">성과점수</font></strong></td>
                <td align="center"><strong><font color="#003399">(진척율) 과제명 [Sub 전략]</font></strong></td>
              </tr>
              <% if (list!=null)
            		for(int i=0;i<list.size();i++) {
            			AnalyObjective obj = (AnalyObjective)list.get(i);
            			
              %>
              <tr bgcolor="#FFFFFF">
                <td><%=obj.pname %></td>
                <td><%=obj.oname %></td>
                <td><%=obj.mname %></td>
                <td><%=obj.score!=-1?nf.format(obj.score):"" %></td>
                <td><%=obj.exec!=null?obj.exec:"" %></td>
              </tr>
              <%  }  // end of list for %>	
	        </form>
            </table>

</body>
</html>
<SCRIPT>
<!--

	
	mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>