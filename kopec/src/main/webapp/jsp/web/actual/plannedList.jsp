<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*"%>
<%
	String schDate = (String) request.getAttribute("schDate");

	ActualUtil util = new ActualUtil();
	util.setMeasurePlanned(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");

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
<form name="listForm" method="post" >
<input type=hidden name=mode value="list">
<input type=hidden name=schDate >
<input type=hidden name=sbuId >
<input type=hidden name=bscId >
<input type=hidden name=defineId >
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> ������ǥ ����</strong></td>
	</tr>
</table>
<%
	if(ds != null){
%>
<!---------//����  KPI ���� ��û ����Ʈ//-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#D4DCF4">
		<td width="80"><strong><font color="#003399">����</font></strong></td>
		<td><strong><font color="#003399">������ǥ</font></strong></td>
		<td width="50"><strong><font color="#003399">�ֱ�</font></strong></td>
		<td width="60"><strong><font color="#003399">����</font></strong></td>
	</tr>
</table>
<div style="overflow-y:scroll;width:100%;height:420px;">
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<% int j=0;

    if(ds != null){

   		while (ds.next()) {
   			String sName = ((String)ds.getString("PNAME")).trim();
   			String mName = ((String)ds.getString("MNAME")).trim();

    %>
              <tr bgcolor="#FFFFFF">
                <td width="80" align="center" bgcolor="#F0F0F0">
                  <%=sName%>
                </td>
                <td id="cell<%=ds.getInt("MCID")%>">
                	<a style="cursor:hand;" onClick="javascript:funcSelectActual(<%=ds.getInt("MCID")%>);">
                	<font color="#0066FF"><%=mName%></font></a></td>
                <td width="50" align="center" id="cella<%=ds.getInt("MCID")%>"><font color="#333333"><%=ds.getString("FREQUENCY")%></font></td>
                <td width="43" align="center" id="cellb<%=ds.getInt("MCID")%>"><font color="#333333"><%=ds.getString("UNIT")%></font></td>
              </tr>
    <%
    	}
    	j++;	} %>
</table>
<%}else{ %>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="60"><strong><font color="#003399">����</font></strong></td>
		<td><strong><font color="#003399">������ǥ</font></strong></td>
		<td width="40"><strong><font color="#003399">�ֱ�</font></strong></td>
		<td width="50"><strong><font color="#003399">����</font></strong></td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="120"><strong><font size=3 color='#cc0000'>�ش� ������ ���� ���� �� Ȯ�ι�ư�� �����ʽÿ�.</font></strong></td>
	</tr>
	</table>
<%} %>
</form>



<!---------//����  KPI ���� ��û ����Ʈ ��//-------->
<SCRIPT>
<!--

	mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
