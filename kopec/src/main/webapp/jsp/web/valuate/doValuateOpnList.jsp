<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>
    
<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	
	ValuateUtil util = new ValuateUtil();
	util.setOpinionList(request,response);
	
	DataSet ds = (DataSet) request.getAttribute("ds");
	
	
%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<html>
<head>
<script>

	function actionPerformed(tag) {
	
		if (chkGrade == "") {
			alert("평가등급을 선택하십시오.");
			return;
		}
		parent.list.listForm.tag.value=tag;
		parent.list.listForm.evalGrade.value=chkGrade;
		parent.actionPerformed();
	}
	
	function clickGrade(val) {
		chkGrade=val;
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
	
	function openDetail01(){
		parent.openDetail01();
	}
	
	function openDetail02(){
		parent.openDetail02();
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body leftmargin="8" topmargin="0" marginwidth="0">
	<form name="form1" method="post" action="">
	<input type="hidden" name="year">
	<input type="hidden" name="grpId">
	<!---//해당년월 부서선택//----->
          <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="30" align="right">
              	<a href="javascript:openDetail01();"><img src="<%=imgUri %>/jsp/web/images/btn_opinion01.gif" width="114" height="20" align="absmiddle"></a> &nbsp;
              	<a href="javascript:openDetail02();"><img src="<%=imgUri %>/jsp/web/images/btn_opinion02.gif" width="114" height="20" align="absmiddle"></a> 
              </td>
            </tr>
          </table>
          <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
		  <tr> 
		    <td width="80" bgcolor="#D4DCF4">조직명</td>
		    <td width="30" bgcolor="#D4DCF4">점수</td>
		    <td width="30" align=center bgcolor="#D4DCF4">구분</td>
		    <td align=center bgcolor="#D4DCF4">지표명</td>
		    <td width="30" align=center bgcolor="#D4DCF4">득점</td>
		    <td width="50" align=center bgcolor="#D4DCF4">배점</td>
		  </tr>
		  </table>
		  <div style="overflow-y:scroll;width:99%;height:375px;padding-left:5px;">
		  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
<% if (ds!=null) while (ds.next()){ %>
		  <tr bgcolor="#FFFFFF"> 
		    <td width="80"><%=ds.getString("NAME") %></td>
		    <td width="30"><%=ds.getString("FSCORE") %></td>
		    <td width="30" align="center" ><%=ds.getString("MKIND") %></td>
		    <td ><%=ds.getString("MNAME") %></td>
			<td width="30" align="center"><%=ds.getString("EVALGRADE") %></td>
			<td width="33"><%=ds.getString("EVALSCORE") %></td>              				  
		  </tr>
<% } %>				  
		  </table>
  		  </div>
    </form>
 <!--------//성과지표 실적입력//-------->

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
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