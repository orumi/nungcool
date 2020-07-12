<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*"%>
<%
	String schDate = (String) request.getAttribute("schDate");
	
	ActualUtil util = new ActualUtil();
	util.setMeasure(request, response);
	DataSet ds = (DataSet)request.getAttribute("ds");
	
	util.setMeasurePlanned(request, response);
	DataSet ds1 = (DataSet)request.getAttribute("ds");

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
%>
<SCRIPT>                                  
    var selectRow=null; 
    var selectRow1=null; 
    var selectRow2=null; 
    var selectRow3=null; 
    var selectRow4=null;
    
    function funcSelectActual(id){
    	parent.openDetail(id);
    	
    	/*
      if (selectRow != null) {
        selectRow.style.backgroundColor="F0F0F0";
        selectRow1.style.backgroundColor="F0F0F0";
        selectRow2.style.backgroundColor="F0F0F0";
        selectRow3.style.backgroundColor="F0F0F0";
        selectRow4.style.backgroundColor="F0F0F0";
      }
      var sRow = eval("this.cell"+id);
      var sRow1 = eval("this.cella"+id);
      var sRow2 = eval("this.cellb"+id);
      var sRow3 = eval("this.cellc"+id);
	  var sRow4 = eval("this.celld"+id);
	  
      selectRow = sRow; 
      selectRow1 = sRow1; 
      selectRow2 = sRow2; 
      selectRow3 = sRow3; 
      selectRow4 = sRow4;
      
      selectRow.style.backgroundColor = "C4EAF9";
      selectRow1.style.backgroundColor = "C4EAF9";
      selectRow2.style.backgroundColor = "C4EAF9";
      selectRow3.style.backgroundColor = "C4EAF9";
      selectRow4.style.backgroundColor = "C4EAF9";
      */
      
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
<form name="detailForm" method="post" action="connectionTaskDetail.jsp">
<input type=hidden name=mode value="list">
<input type=hidden name=schDate >
<input type=hidden name=sbuId >
<input type=hidden name=bscId >
<input type=hidden name=defineId >
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="9" align="absmiddle"> 과제 리스트</strong></td>
	</tr>
</table>
<!---------//좌측  지표선택 시 지표와 연계된 과제 리스트//-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1"
	bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="20%"><strong><font color="#003399">유형</font></strong></td>
		<td width="45%"><strong><font color="#003399">명칭 </font></strong></td>
		<td width="20%"><strong><font color="#003399">분야</font></strong></td>
		<td width="15%"><strong><font color="#003399">주관부서</font></strong></td>
	</tr>
</table>
<%
	if(ds != null){
%>
<div style="overflow-y:scroll;width:100%;height:55px;">
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<% int j=0;
    
    if(ds != null){
   		while (ds.next()) {
   			String sName = ((String)ds.getString("PNAME")).trim();
   			String mName = ((String)ds.getString("MNAME")).trim();
   			String sActual = ds.isEmpty("ACTUAL")?"":ds.getString("ACTUAL");
   			String sScore = ds.isEmpty("SCORE")?"":ds.getString("SCORE");
   			String divName = ds.isEmpty("DIVNAME")?"":ds.getString("DIVNAME");
   			
   			String file = ds.isEmpty("FILENAME")?"":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILENAME")+"');\"> </a>";
    %>
              <tr bgcolor="#FFFFFF"> 
                <td align="center" bgcolor="#F0F0F0">
                  <%=sName%>
                </td>
                <td id="cell<%=ds.getInt("MCID")%>">
                	<a style="cursor:hand;" onClick="javascript:funcSelectActual(<%=ds.getInt("MCID")%>);">
                	<font color="#0066FF"><%=mName%></font></a></td>
                <td align="center" id="cellb<%=ds.getInt("MCID")%>"><font color="#333333"><%=ds.getString("FREQUENCY")%></font></td>
                <td align="center" id="cellc<%=ds.getInt("MCID")%>"><font color="#333333"><%=sActual%></font></td>
              </tr>
    <%
    	}	
    	j++;	} %>
<%}else{ %>
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr>
		<td colspan="4" align="center" bgcolor="#ffffff" height="55"><strong><font size=4 color='#cc0000'>좌측의 성과지표를 클릭 하세요. </font></strong></td>
	</tr>
<%} %>
</form>
</table>
</div>
<!---------//좌측  지표선택 시 지표와 연계된 과제 리스트 끝//-------->
<div>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="9" align="absmiddle"> 과제정보 </strong></td>
	</tr>
</table>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
   <tr bgcolor="#FFFFFF">
     <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">명칭</font></strong></td>
     <td width="85%" colspan="3"><strong><input name="projectNmText" type="text" class="input_box" size="80"></strong></td>
   </tr>
   <tr bgcolor="#FFFFFF">
     <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">유형</font></strong></td>
     <td width="40%"><select name="firstPart"  style="width:170;x;">
     	
     </select></td>
     <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">분야</font></strong></td>
     <td width="40%"><select name="firstPart"  style="width:170;x;">
     	
     </select></td>
   </tr>
   <tr bgcolor="#FFFFFF">
     <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">성과지표</font></strong></td>
     <td width="85%" colspan="3"><select name="firstPart"  style="width:170;x;">
     	
     </select></td>
   </tr>
   <tr bgcolor="#FFFFFF">
     <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">개요</font></strong></td>
     <td width="85%" colspan="3"><textarea name="projectNmText" class="input_box" cols="78" rows="4"></textarea></td>
   </tr>      
   <tr bgcolor="#FFFFFF">
     <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">목표</font></strong></td>
     <td width="85%" colspan="3"><textarea name="projectNmText" class="input_box" cols="78" rows="4"></textarea></td>
   </tr>
   <tr bgcolor="#FFFFFF">
     <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">LINK</font></strong></td>
     <td width="85%" colspan="3"><strong><input name="projectNmText" type="text" class="input_box" size="80" value=""></strong></td>
   </tr>
   <tr bgcolor="#FFFFFF">
     <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">파일첨부</font></strong></td>
     <td width="85%" colspan="3"><strong><input name="projectNmText" type="file" class="input_box" size="65" value=""></strong></td>
   </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top:5px;">
	<tr>
  		<td align="left"><a href="">과제세부내용</a>&nbsp;<a href="">과제실적등록</a></td>
  		<td align="right"><img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50"
			height="20" border="0" onClick="javascript:actionPerformed('U');" style="cursor:hand">
			<img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50"
			height="20" border="0" onClick="javascript:actionPerformed('D');" style="cursor:hand"></td>
  	</tr>
</table>
</div>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/actual/download.jsp">
	<input type="hidden" name="fileName">
</form>


<SCRIPT>
<!--

	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}
	
//-->
</SCRIPT>
</body>
</html>
