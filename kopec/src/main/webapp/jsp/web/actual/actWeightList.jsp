<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*"%>
<%
	String schDate = (String) request.getAttribute("schDate");

	ActualUtil util = new ActualUtil();
	util.setActWeight(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");
%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
%>

<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
<script src="<%=imgUri%>/bootstrap/js/libs/jquery-2.1.1.min.js"></script>
<script src="<%=imgUri%>/bootstrap/js/libs/jquery-ui-1.10.3.min.js"></script>



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

    function saveWeight(){

    	var pids = "";
    	var pranks = "";
    	$("input[name=txtPid]").each(function(){
    		var inObj = $("this");

    		var pid =  $(this).attr("pid");
			var prank =  $(this).val();

			pids = pids+"|"+pid;
			pranks = pranks+"|"+ prank;

    	});

    	var oids = "";
    	var oranks = "";

    	$("input[name=txtOid]").each(function(){
    		var inObj = $("this");

    		var oid =  $(this).attr("oid");
			var orank =  $(this).val();

			oids = oids+"|"+oid;
			oranks = oranks+"|"+orank;

    	});


    	var w_data = "";
		var w_etlkey = "";
		var w_rank = "";
    	var w_id = "";
		var w_cid = "";
    	var w_sum = 0;
    	var cnt = listForm.dsCnt.value;
     	for(i=0;i<cnt;i++) {
     		w_sum = w_sum + parseFloat(eval("listForm.txtWeight"+i).value);
     		w_data = w_data + "/" + eval("listForm.txtWeight"+i).value;
			w_etlkey = w_etlkey + "/" + eval("listForm.txtEtlKey"+i).value;
			w_rank = w_rank + "/" + eval("listForm.txtMRank"+i).value;
     		w_id = w_id + "/" + eval("listForm.mID"+i).value;
			w_cid = w_cid + "/" + eval("listForm.mcID"+i).value;
     	}
     	listForm.txtWeightSum.value = w_sum;
     	if(w_sum != 100) {
     		alert('가중치 합은 100이여야 합니다. 다시 설정하시기 바랍니다.');
     		return false;
     	}

     	listForm.wData.value = w_data;
		listForm.wEtlkey.value = w_etlkey;
		listForm.wRank.value = w_rank;

     	listForm.wID.value = w_id;
		listForm.wcID.value = w_cid;
    	listForm.mode.value = "U";
    	listForm.sbuId.value = parent.form1.firstPart.options[parent.form1.firstPart.selectedIndex].value;
		listForm.bscId.value = parent.form1.secondPart.options[parent.form1.secondPart.selectedIndex].value;
    	listForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value;
    	listForm.pids.value = pids;
    	listForm.pranks.value = pranks;
    	listForm.oids.value = oids;
    	listForm.oranks.value = oranks;
    	listForm.submit();
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
<input type=hidden name=mode >
<input type=hidden name=schDate >
<input type=hidden name=sbuId >
<input type=hidden name=bscId >
<input type=hidden name=defineId >
<input type=hidden name=wData >
<input type=hidden name=wEtlkey >
<input type=hidden name=wRank >
<input type=hidden name=wID >
<input type=hidden name=wcID >
<input type=hidden name=pids >
<input type=hidden name=pranks >
<input type=hidden name=oids >
<input type=hidden name=oranks >


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 지표목록</strong>
		</td>
		<td align="right"><strong> 가중치 합: <input type="text" name="txtWeightSum" style="border:0;text-weight:bold;" size="5"></strong></td>
	</tr>
</table>
<%
	double wSum = 0.000;
	if(ds != null){
%>
<!---------//좌측  KPI 선택 전청 리스트//-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#D4DCF4">
		<td width="120"><strong><font color="#003399">관점 (가중치)</font></strong></td>
		<td width="80"><strong><font color="#003399">관점 순서</font></strong></td>
		<td width="180"><strong><font color="#003399">전략과제 (가중치)</font></strong></td>
		<td width="80"><strong><font color="#003399">과제 순서</font></strong></td>
		<td width=""><strong><font color="#003399">성과지표</font></strong></td>
		<td width="90"><strong><font color="#003399">KPI No</font></strong></td>
		<td width="90"><strong><font color="#003399">지표순서</font></strong></td>
		<td width="97"><strong><font color="#003399">가중치</font></strong></td>
	</tr>
</table>
<div style="overflow-y:scroll;width:100%;height:400px;">
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<% int j = 0;
    if(ds != null){

   		while (ds.next()) {
   			String sName = ((String)ds.getString("PNAME")).trim();
   			String mName = ((String)ds.getString("MNAME")).trim();
   			String oName = ((String)ds.getString("ONAME")).trim();
   			wSum = wSum + Double.parseDouble((ds.getString("MWEIGHT").trim()==null||ds.isEmpty("MWEIGHT")?"0":ds.getString("MWEIGHT").trim()));
    %>
         <tr bgcolor="#FFFFFF">
           <td width="120" align="center" bgcolor="#F0F0F0"><%=sName%> (<%=((String)ds.getString("PWEIGHT")).trim() %>)</td>
           <td width="80" align="center" bgcolor="#F0F0F0">
				<input type="text" id="txtPid" name="txtPid" size="5" style="text-align:right" value="<%=((String)ds.getString("PRANK")).trim()%>" pid="<%=((String)ds.getString("PID")).trim()%>" >
		   </td>
           <td width="180" id="cell<%=ds.getString("MID")%>"><font color="#0066FF"><%=oName%> (<%=((String)ds.getString("OWEIGHT")).trim() %>)</font></td>
           <td width="80" align="center">
				<input type="text" id="txtOid" name="txtOid" size="5" style="text-align:right" value="<%=((String)ds.getString("ORANK")).trim()%>" oid="<%=((String)ds.getString("OID")).trim()%>">
		   </td>
           <td width="" id="cella<%=ds.getString("MID")%>"> <font color="#333333"><%=mName%></font></td>
           <td width="90" align="center" id="cellb<%=ds.getString("MID")%>"><input name="txtEtlKey<%=j%>" size="12" style="text-align:right;" value="<%=(ds.getString("METLKEY").trim()==null||ds.isEmpty("METLKEY")?"":ds.getString("METLKEY").trim())%>" /></td>
           <td width="90" align="center" id="cellb<%=ds.getString("MID")%>"><input name="txtMRank<%=j%>" size="5" style="text-align:right;" value="<%=(ds.getString("MRANK").trim()==null||ds.isEmpty("MRANK")?"10":ds.getString("MRANK").trim())%>" /></td>
           <td width="80" align="center" id="cellb<%=ds.getString("MID")%>"><input name="txtWeight<%=j%>" size="5" style="text-align:right;" value="<%=(ds.getString("MWEIGHT").trim()==null||ds.isEmpty("MWEIGHT")?"0":ds.getString("MWEIGHT").trim())%>" /></td>
           <input type=hidden name="mID<%=j%>" value="<%=ds.getString("MID")%>" >
		   <input type=hidden name="mcID<%=j%>" value="<%=ds.getString("MCID")%>" >
         </tr>
    <%
    	j++; }
	%>
	<input type=hidden name=dsCnt value="<%=j%>" >
    <%} %>
</table>
<%}else{ %>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" >
	<tr align="center" bgcolor="#D4DCF4">
		<td width="120"><strong><font color="#003399">관점</font></strong></td>
		<td width="90"><strong><font color="#003399">관점순서</font></strong></td>
		<td width="180"><strong><font color="#003399">전략과제</font></strong></td>
		<td width="90"><strong><font color="#003399">과제순서</font></strong></td>
		<td width=""><strong><font color="#003399">성과지표</font></strong></td>
		<td width="90"><strong><font color="#003399">KPI No</font></strong></td>
		<td width="90"><strong><font color="#003399">지표순서</font></strong></td>
		<td width="90"><strong><font color="#003399">가중치</font></strong></td>
	</tr>
	</table>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr>
		<td colspan="2" align="center" bgcolor="#ffffff" height="150"><strong><font size=4 color='#cc0000'>평가년도와  조직 선택 후 확인버튼을 누르십시요. </font></strong></td>
	</tr>
	</table>
<%} %>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top:5px;">
	<tr>
  		<td align="right"><img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50"
			height="20" border="0" onClick="javascript:saveWeight();" style="cursor:hand"></td>
  	</tr>
</form>
</table>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	mergeCell(document.getElementById('tbl0'), '0', '4', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '2', '2','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '2','0');

	listForm.txtWeightSum.value = "<%=wSum%>";
//-->
</SCRIPT>
</body>
</html>
