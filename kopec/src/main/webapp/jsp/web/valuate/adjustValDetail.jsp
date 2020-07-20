<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
				 com.nc.eval.*,
				 com.nc.util.*"%>
<%
	String schDate = (String) request.getAttribute("schDate");

	AdjustValuateUtil util = new AdjustValuateUtil();
	util.setEvalMeasure(request, response);

	EvalMeasureUtil meautil = (EvalMeasureUtil)request.getAttribute("meautil");

	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String grpId = request.getParameter("grpId");
	String flag = request.getAttribute("flag")==null?"":request.getAttribute("flag").toString();
	if(flag.equals("true")){
	%>
		<script>
			alert("����ó�� �Ǿ����ϴ�.");
		</script>
	<%

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


	function actionPerformed(){
		if (confirm("��跮 �򰡰���� ��ǥ������ ���� �Ͻðڽ��ϱ�?") == true) {
			var frm = this.listForm;
			frm.tag.value="A";
			frm.submit();
		}
	}

	// ���� �ʱ�ȭ
	function actualReset() {
		if (confirm("�򰡴� �Է½����� �ʱ�ȭ �Ͻðڽ��ϱ�?") == true) {
			var frm = this.listForm;
			frm.tag.value="R";
			frm.submit();
		}
	}

	// ���� �ʱ�ȭ
	function evalReset() {
		if (confirm("�򰡹ݿ� ������ �ʱ�ȭ �Ͻðڽ��ϱ�?") == true) {
			var frm = this.listForm;
			frm.tag.value="E";
			frm.submit();
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
<input type=hidden name=tag>
<input type=hidden name=year value="<%=year %>" >
<input type=hidden name=month value="<%=month %>" >
<input type=hidden name=grpId value="<%=grpId %>">

<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> ������ǥ ����</strong></td>
	</tr>
</table>
<%
	if(meautil != null){
			String[] username = meautil.getAppName();
			String[] userId = meautil.getAppUserId();
			String amId = "";
	%>

	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
		<tr align="center" bgcolor="#375f9c" style="height:32px;">
			<%-- <td align=center width="80" rowspan=1><strong><font color="#003399">��ǥ����</font></strong></td> --%>
			<td align=center  rowspan=1><strong><font color="#ffffff">��ǥ</font></strong></td>
			<td align=center width="150" rowspan=1><strong><font color="#ffffff">����</font></strong></td>
			<td align=center width="180" rowspan=1><strong><font color="#ffffff">������</font></strong></td>
			<td align=center width="90" rowspan=1><strong><font color="#ffffff">�������</font></strong></td>
			<td align=center width="80" rowspan=1><strong><font color="#ffffff">��յ��</font></strong></td>
			<td align=center width="80" rowspan=1><strong><font color="#ffffff">����ġ</font></strong></td>
			<td align=center width="90" rowspan=1><strong><font color="#ffffff">���� </font></strong></td>
		</tr>

		<%
	    ArrayList meaList = meautil.meaList;
	   		for (int i=0;i<meaList.size();i++) {
	   			EvalMeasure mea = (EvalMeasure)meaList.get(i);
	   			amId += "|"+mea.mId;

	   			int score = 0;
	   			String grade = "";
	   			if(100 <= mea.getAvg()){
	   				score = 100;
	   				grade = "S";
	   			}else if(95 <= mea.getAvg()){
	   				score = 95;
	   				grade = "A";
	   			}else if(90 <= mea.getAvg()){
	   				score = 90;
	   				grade = "B";
	   			}else if(85 <= mea.getAvg()){
	   				score = 85;
	   				grade = "C";
	   			}else if(80 > mea.getAvg() && 0.0 < mea.getAvg()){
	   				score = 80;
	   				grade = "D";
	   			}else {
	   				score = 0;
	   				grade = "";
	   			}
	    %>
	              <tr bgcolor="#FFFFFF">
	               <%--  <td><font color="#333333"><%=mea.belong%></font></td>
	                <td bgcolor="#F0F0F0"><font color="#333333"><%=mea.name%></font></td>
	                <td ><%=mea.sname%></td>
	                <td ><%=mea.bname%></td>
	                <td align="right" ><font color="#333333"><%=(double)((int)(mea.getAvg()*1000))/1000%></font></td>
	                <td align="center" ><font color="#333333"><%=grade %></font></td>
	                <td align="right" ><font color="#333333"><%=mea.weight%></font></td>
	                <td align="right" ><font color="#333333"><%=(double)((int)((((double)score*mea.weight/100)*1000)))/1000%></font></td>
	                --%>
	                <td bgcolor="#F0F0F0"><font color="#333333"><%=mea.sname!=null?mea.sname:""%></font></td>
	                <td ><%=mea.pname!=null?mea.pname:""%></td>
	                <td ><%=mea.name!=null?mea.name:""%></td>
	                <td align="right" ><font color="#333333"><%=mea.bname!=null?mea.bname:""%></font></td>
	                <td align="center" ><font color="#333333"><%=mea.belong!=null?mea.belong:""%></font></td>
	                <td align="right" ><font color="#333333"><%=mea.weight%></font></td>
	                <td align="right" ><font color="#333333"><%=mea.frequency!=null?mea.frequency:""%> </font></td>

	              </tr>
	              <input type=hidden name="avgact<%=mea.mId %>" value="<%=mea.bname!=null?mea.bname:""%>">
	              <input type=hidden name="avgscr<%=mea.mId %>" value="<%=mea.score%>">
	              <input type=hidden name="avggrd<%=mea.mId %>" value="<%=mea.belong!=null?mea.belong:""%>">

	             <%--  <input type=hidden name="avgact<%=mea.mId %>" value="<%=mea.getAvg()%>">
	              <input type=hidden name="avgscr<%=mea.mId %>" value="<%=score%>">
	              <input type=hidden name="avggrd<%=mea.mId %>" value="<%=grade%>"> --%>
	    <%	}	 %>
	    <input type=hidden name="amId" value="<%=amId %>">
	</table>
	<table width="98%" border="0" align="center" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
        <tr bgcolor="#FFFFFF">
            <td colspan="9" align="right">
              <a href="javascript:evalReset();"><img src="<%=imgUri %>/jsp/web/images/btn_reset_eval.gif" alt="���ʱ�ȭ" height="20" border="0" align="absmiddle"></a>
              <a href="javascript:actualReset();"><img src="<%=imgUri %>/jsp/web/images/btn_reset_actual.gif" alt="�����ʱ�ȭ" height="20" border="0" align="absmiddle"></a>
              <a href="javascript:actionPerformed();"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>
            </td>
        </tr>
    </table>
<%
	} else { // ������ ����� ���� ���

%>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<tr align="center" bgcolor="#375f9c" style="height:32px;">
			<%-- <td align=center width="80" rowspan=1><strong><font color="#003399">��ǥ����</font></strong></td> --%>
			<td align=center  rowspan=1><strong><font color="#ffffff">��ǥ</font></strong></td>
			<td align=center width="150" rowspan=1><strong><font color="#ffffff">����</font></strong></td>
			<td align=center width="180" rowspan=1><strong><font color="#ffffff">������</font></strong></td>
			<td align=center width="90" rowspan=1><strong><font color="#ffffff">�������</font></strong></td>
			<td align=center width="80" rowspan=1><strong><font color="#ffffff">��յ��</font></strong></td>
			<td align=center width="80" rowspan=1><strong><font color="#ffffff">����ġ</font></strong></td>
			<td align=center width="90" rowspan=1><strong><font color="#ffffff">���� </font></strong></td>
		</tr>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="130"><strong><font size=3 color='#cc0000'>�ش� ������ �׷� ���� �� Ȯ�ι�ư�� �����ʽÿ�.</font></strong></td>
	</tr>
	</table>
<% } %>
</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//����  KPI ���� ��û ����Ʈ ��//-------->
<SCRIPT>

	var WinDetail;
 	function openDetail(evalrId){
		if (WinDetail!=null) WinDetail.close();
		var year = parent.form1.year.options[parent.form1.year.selectedIndex].value;
		var grpId = parent.form1.firstPart.options[parent.form1.firstPart.selectedIndex].value;
		var url = "popDetail.jsp?year="+year+"&evalrId="+evalrId+"&grpId="+grpId;
		WinApp = window.open(url,"","toolbar=no,width=700,height=500,scrollbars=yes,resizable=yes,menubar=no,status=no" );
 	}

	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}

	/* mergeCell(document.getElementById('tbl0'), '0', '2', '1','1'); */
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
</SCRIPT>
</body>
</html>
