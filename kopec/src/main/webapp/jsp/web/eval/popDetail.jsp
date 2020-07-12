<%@ page contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR" %>
<%@ page import="java.util.*,
					com.nc.eval.*,
					com.nc.util.*"%>
<%
	request.setCharacterEncoding("EUC-KR");
	String schDate   = (String) request.getAttribute("schDate");	
	String evalrName = request.getParameter("evalrName");
	evalrName = new String(evalrName.getBytes("8859_1"), "euc-kr");
	
	AdminValuate util = new AdminValuate();
	util.setPopDetail(request, response);

	DataSet ds    = (DataSet)request.getAttribute("ds");
	DataSet dsBW  = (DataSet)request.getAttribute("dsBW");
	DataSet dsDiv = (DataSet)request.getAttribute("dsDiv");
	
	String best = "";
	String worst = "";
	
	if (dsBW!=null) while(dsBW.next()){
		best = dsBW.getString("BEST").replaceAll("\r\n","<br>").replaceAll("\r","<br>");
		worst = dsBW.getString("WORST").replaceAll("\r\n","<br>").replaceAll("\r","<br>");
	}
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
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" >
		<tr align="center" bgcolor="#D4DCF4">
			<td align=center width="100"><strong><font color="#003399">평가자</font></strong></td>
			<td align=left bgcolor="#FFFFFF"><font color="#333333"><%=evalrName %></font></td>
		</tr>
		<tr align="center" bgcolor="#D4DCF4">
			<td align=center width="100"><strong><font color="#003399">평가 그룹</font></strong></td>
			<td align=left bgcolor="#FFFFFF"><font color="#333333">본사 조직구분</font></td>
		</tr>		
	</table>
	
	<br>

	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
		<tr align="center" bgcolor="#D4DCF4">
			<td align=center width="80" rowspan=2><strong><font color="#003399">지표구분</font></strong></td>
			<td align=center rowspan=2><strong><font color="#003399">지표</font></strong></td>
			<td align=center width="80" rowspan=2><strong><font color="#003399">부서</font></strong></td>
			<td align=center colspan=5><strong><font color="#003399">평가등급</font></strong></td>
			<td align=center width="60" rowspan=2><strong><font color="#003399">평가 점수</font></strong></td>
		</tr>
		<tr align="center" bgcolor="#D4DCF4">
			<td align=center ><strong><font color="#003399">S</font></strong></td>
			<td align=center ><strong><font color="#003399">A</font></strong></td>
			<td align=center ><strong><font color="#003399">B</font></strong></td>
			<td align=center ><strong><font color="#003399">C</font></strong></td>
			<td align=center ><strong><font color="#003399">D</font></strong></td>
		</tr>		
<% if(ds != null){
	   		while(ds.next()) {
 %>
	              <tr bgcolor="#FFFFFF">
	              	<td><font color="#333333"><%=ds.getString("MKIND") %></font></td>
	                <td bgcolor="#F0F0F0"><%=ds.getString("MNAME") %></td>
	                <td ><font color="#333333"><%=ds.getString("BNAME") %></font></td>
					<td align="center"><input type=radio name=grade<%=ds.getString("MCID")%> <%=ds.getString("EVALGRADE").equals("S")?"checked":"" %> ></td>
	                <td align="center"><input type=radio name=grade<%=ds.getString("MCID")%>  <%=ds.getString("EVALGRADE").equals("A")?"checked":"" %>></td>
	                <td align="center"><input type=radio name=grade<%=ds.getString("MCID")%>  <%=ds.getString("EVALGRADE").equals("B")?"checked":"" %>></td>
	                <td align="center"><input type=radio name=grade<%=ds.getString("MCID")%>  <%=ds.getString("EVALGRADE").equals("C")?"checked":"" %>></td>
	                <td align="center"><input type=radio name=grade<%=ds.getString("MCID")%>  <%=ds.getString("EVALGRADE").equals("D")?"checked":"" %>></td>
	                <td align="right" ><font color="#333333"><%=ds.getString("EVALSCORE") %></font></td>
	              </tr>
	    <%	}
		}%>
	</table>
	<br>
	<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 평가 의견서</strong></td>
	</tr>
	</table>
            <!-- table id="tbl0" width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				  <tr> 
				    <td width="15%" bgcolor="#D4DCF4">최상위 부서 의견</td>
				  </tr>
				  <tr bgcolor="#FFFFFF">
				  	<td><%=best %></td>
				  </tr>
				  <tr> 
				    <td width="15%" bgcolor="#D4DCF4">최하위 부서 의견</td>
				  </tr>
				  <tr bgcolor="#FFFFFF">
				  	<td><%=worst %></td>
				  </tr>			  							  	  				  			  				  				  				  				  		  
            </table>
	<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 평가 결과 요약표</strong></td>
	</tr>
	</table -->

            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<% if (dsDiv!=null) while (dsDiv.next()){  %>				  
				  <tr>
				  	<td width="30%" bgcolor="#D4DCF4"><%=dsDiv.getString("MNAME") %></td>
				    <td width="70%" bgcolor="#D4DCF4"><%=dsDiv.getString("BNAME") %></td>
				 <tr>
				 </tr>
				    <td width="100%" bgcolor="#FFFFFF" colspan="2"><%=dsDiv.isEmpty("EVALOPINION")?"&nbsp;":dsDiv.getString("EVALOPINION")==null?"&nbsp;":dsDiv.getString("EVALOPINION").replaceAll("\r\n","<br>").replaceAll("\r","<br>") %></td>
				  </tr>
    <% } %>				  							  	  				  			  				  				  				  				  		  
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
	
	
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
