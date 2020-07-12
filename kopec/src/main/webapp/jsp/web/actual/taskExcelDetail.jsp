<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*"%>
<%
	String year = (String) request.getParameter("year");
	String mode = (String) request.getParameter("mode");
	ActualUtil util = new ActualUtil();
	util.getOrgMeasure(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");
	DataSet dsItem = (DataSet)request.getAttribute("dsItem");
	DataSet dsItemAct = (DataSet)request.getAttribute("dsItemAct");
	
	int cnt = 0;
	if(dsItem != null)
		cnt = dsItem.getRowCount();

	int dsCnt = 0;
	if(ds != null)
		dsCnt = ds.getRowCount();

%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
%>
<SCRIPT>                                  
    var selectRow = null; 
    var selectRow1 = null; 
    var selectRow2 = null;
    function funcSelectActual(id){
      if (selectRow != null) {
        selectRow.style.backgroundColor="F0F0F0";
        selectRow1.style.backgroundColor="F0F0F0";
        selectRow2.style.backgroundColor="F0F0F0";        
      }
      var sRow = eval("this.cell"+id);
      var sRow1 = eval("this.cella"+id);
	  var sRow2 = eval("this.cellb"+id);
	  
	  	
      selectRow = sRow; 
      selectRow1 = sRow1; 
      selectRow2 = sRow2;
      
      selectRow.style.backgroundColor = "C4EAF9";
      selectRow1.style.backgroundColor = "C4EAF9";
      selectRow2.style.backgroundColor = "C4EAF9";
      
      parent.openDetail(id);
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
<form name="detailForm" method="get" >
<input type=hidden name=mode>
<input type=hidden name=year >
<input type=hidden name=month1 >
<input type=hidden name=month2 >
<input type=hidden name=sbuId >
<input type=hidden name=bscId >
<input type=hidden name=contentId >

<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 성과실적</strong></td>
	</tr>
</table>
<%
if(ds != null){
%>
<!---------//좌측  KPI 선택 전청 리스트//-------->
<table width="<%=675+(105*cnt) %>" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#D4DCF4">
		<td width="40" rowspan=2><strong><font color="#003399">년도</font></strong></td>
		<td width="50" rowspan=2><strong><font color="#003399">ETLKEY</font></strong></td>
		<td width="150" rowspan=2><strong><font color="#003399">지표</font></strong></td>
		<td width="120" rowspan=2><strong><font color="#003399">산식</font></strong></td>
		<td width="60" rowspan=2><strong><font color="#003399">실적<br>년월</font></strong></td>
		<td width="100" rowspan=2><strong><font color="#003399">구분</font></strong></td>
		<td width="120" rowspan=2><strong><font color="#003399">조직명</font></strong></td>
		<td colspan="<%=cnt %>"><strong><font color="#003399">항목</font></strong></td>
	</tr>
	<tr align="center" bgcolor="#D4DCF4">
	<%if(dsItem != null){
		while (dsItem.next()){
	%>
		<td width="100"><strong><font color="#003399"><%=dsItem.getString("Code")==null?"":dsItem.getString("Code") %>.<%=dsItem.getString("ITEMNAME")==null?"":dsItem.getString("ITEMNAME") %></font></strong></td>
	<% 	} 
	} %>
	</tr>
	<% 
	int i = 0;
	while (ds.next()){		
		String strDate = ds.getString("STRDATE")==null?"":ds.getString("STRDATE");
		strDate           = strDate.equals("")?"":strDate.substring(0,6);
		String strYM   = ds.getString("YM")==null?"":ds.getString("YM");
		
		//out.println("EQU:"+(String)ds.getString("MSID")+"/"+((String)ds.getString("DID"))+"<br>");
    %>
        <tr bgcolor="#FFFFFF">
          <td align="center" bgcolor="#F0F0F0"><%=year%></td>
          <td align="center" bgcolor="#F0F0F0"><%=((String)ds.getString("ETLKEY")).trim()==null?"":((String)ds.getString("ETLKEY")).trim()%></td>
          <td align="center" bgcolor="#F0F0F0"><%=((String)ds.getString("MNAME")).trim()==null?"":((String)ds.getString("MNAME")).trim()%></td>
          <td align="left" bgcolor="#F0F0F0"><%=((String)ds.getString("EQUATION")).trim()==null?"":((String)ds.getString("EQUATION")).trim()%></td>
          <td align="center" bgcolor="#F0F0F0"><%=strYM%></td>
          <td align="center" bgcolor="#F0F0F0"><%=((String)ds.getString("SNAME")).trim()==null?"":((String)ds.getString("SNAME")).trim()%></td>
          <td align="center" bgcolor="#F0F0F0"><%=((String)ds.getString("BNAME")).trim()==null?"":((String)ds.getString("BNAME")).trim()%></td>
        <% int z=0;
           if(dsItemAct != null ){
    			while(dsItemAct.next()){
    				if(z == cnt) {
    					dsItemAct.resetCursor();
    					break;
    				}
					//out.println(dsItemAct.getString("MEASUREID").trim()+"/"+ds.getString("DID").trim());
    				if(dsItemAct.getString("MEASUREID").trim().equals(ds.getString("DID").trim())){
    					if(strYM.equals(dsItemAct.getString("STRDATE").trim())){
        					//out.println("서로 같아서 :::" + z+"/"+cnt+"=="+dsItemAct.getString("STRDATE")+"/"+strYM+"---"+dsItemAct.getString("MEASUREID")+"/"+ds.getString("MCID")+ " : " + dsItemAct.getString("CODE") + " Actaul : "  + dsItemAct.getString("ACTUAL") +"<br>");
    						%>
   						<td width="100" align="center" bgcolor="#F0F0F0">&nbsp;<%=dsItemAct.getString("ACTUAL")==null?"":dsItemAct.getString("ACTUAL") %></td>
   					<% 		z++;
    					}
    				}
    			}
    			for(int x=z;x<cnt;x++){%>
    	          <td width="100" align="center" bgcolor="#F0F0F0">&nbsp;</td>
    	         <%  }
    			dsItemAct.resetCursor();
        	}else{
        		for(int x=z;x<cnt;x++){%>
    	          <td width="100" align="center" bgcolor="#F0F0F0">&nbsp;</td>
    	     <%  }
        	}
        	%>
        </tr>
    <%  i++;
    	}
    %>
</table>
<%}else{ %>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="40" rowspan=2><strong><font color="#003399">년도</font></strong></td>
		<td width="50" rowspan=2><strong><font color="#003399">ETLKEY</font></strong></td>
		<td width="90" rowspan=2><strong><font color="#003399">지표</font></strong></td>
		<td width="70" rowspan=2><strong><font color="#003399">산식</font></strong></td>
		<td width="50" rowspan=2><strong><font color="#003399">실적<br>년월</font></strong></td>
		<td width="70" rowspan=2><strong><font color="#003399">구분</font></strong></td>
		<td width="70" rowspan=2><strong><font color="#003399">조직명</font></strong></td>
		<td ><strong><font color="#003399">항목</font></strong></td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="120"><strong><font size=3 color='#cc0000'>좌측 지표를 선택하세요.</font></strong></td>
	</tr>
	</table>
<%} %>
</form>



<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
