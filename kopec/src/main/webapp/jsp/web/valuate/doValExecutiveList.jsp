<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>
    
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
	String userId = (String)session.getAttribute("userId");
	
	if (userId == null){ %>
	<script>
		alert("다시 접속하여 주십시오");
	  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
	</script>
	<% return; 
	}
	
	
	ValuateUtil util = new ValuateUtil();
	util.setEvalExecutive(request,response);
	
	DataSet ds = (DataSet) request.getAttribute("ds");
	DataSet dsCnt = (DataSet)request.getAttribute("dsCnt");
	DataSet dsScr = (DataSet)request.getAttribute("dsScr");

	String year = request.getParameter("year");
	
	int[] cn = new int[5];
	if (dsCnt!=null)while(dsCnt.next()){
		cn[0]=dsCnt.isEmpty("A")?0:dsCnt.getInt("A");
		cn[1]=dsCnt.isEmpty("B")?0:dsCnt.getInt("B");
		cn[2]=dsCnt.isEmpty("C")?0:dsCnt.getInt("C");
		cn[3]=dsCnt.isEmpty("D")?0:dsCnt.getInt("D");
		cn[4]=dsCnt.isEmpty("E")?0:dsCnt.getInt("E");
	}
	
	double[] scr = new double[5];
	if (dsScr!=null)while(dsScr.next()){
		scr[0] = dsScr.getDouble("A");
		scr[1] = dsScr.getDouble("B");
		scr[2] = dsScr.getDouble("C");
		scr[3] = dsScr.getDouble("D");
		scr[4] = dsScr.getDouble("E");
	}
	
%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<html>
<head>
<script>
	var aRDO = new Array();
	
	var mcn = <%=(ds!=null)?ds.getRowCount():0%>;  // total measure count
	
	// selectable count 
	var cna = <%=cn[0]%>;          
	var cnb = <%=cn[1]%>;  
	var cnc = <%=cn[2]%>;   
	var cnd = <%=cn[3]%>;  
	var cne = <%=cn[4]%>;   
	
	// score of grade "S"
	var sa = "<%="A|"+scr[0]%>";          
	var sb = "<%="B|"+scr[1]%>";
	var sc = "<%="C|"+scr[2]%>";
	var sd = "<%="D|"+scr[3]%>";
	var se = "<%="E|"+scr[4]%>";

	// current selected count
	var ca = 0;                                            
	var cb = 0;
	var cc = 0;
	var cd = 0;
	var ce = 0;
	
	function addRDO(obj){
		aRDO[aRDO.length]=obj;
	}                           
	function clkRDO(obj){
		var count=0;
		var k;
		var limit=0;
		var val = obj.value;
		if (sa==val){	
			k=0;
			limit=cna;
		} else if (sb==val){
			k=1;
			limit=cnb;
		} else if (sc==val){
			k=2;
			limit=cnc;
		} else if (sd==val){
			k=3;
			limit=cnd;
		} else if (se==val){
			k=4;
			limit=cne;
		}

		for(i=0;i<aRDO.length;i++){
			if(document.getElementsByName(aRDO[i])[k].checked){
				count++;
			}
		}
		if (count>limit){
			alert("다른 등급을 선택해 주십시오");
			obj.checked=false;
		}
		setCount();
	}
	
	function setCount(){
		var cell = document.getElementById("ta");
		ca = getSelChk(0);
		cell.innerText = ca+"/"+cna;
		
		cell = document.getElementById("tb");
		cb = getSelChk(1);
		cell.innerText = cb+"/"+cnb;
		
		cell = document.getElementById("tc");
		cc = getSelChk(2);
		cell.innerText = cc+"/"+cnc;
		
		cell = document.getElementById("td");
		cd = getSelChk(3);
		cell.innerText = cd+"/"+cnd;
		
		cell = document.getElementById("te");
		ce = getSelChk(4);
		cell.innerText = ce+"/"+cne;		
	}
	
	
	function getSelChk(idx){
		var rv=0;
		for(i=0;i<aRDO.length;i++){
			if(document.getElementsByName(aRDO[i])[idx].checked){
				rv++;
			}
		}
		return rv;
	}	
	function actionPerformed(tag){
		var frm = form1;
		var pFrm = parent.form1;
		if ("I" == tag) {
			if ((ca+cb+cc+cd+ce)<(mcn)){
				alert('선택하지 않은 항목이 있습니다.');
			} else {
				frm.mode.value=tag;
					
				frm.year.value=pFrm.year.options[pFrm.year.selectedIndex].value;
				frm.grpId.value = pFrm.firstPart.options[pFrm.firstPart.selectedIndex].value;
				
				frm.submit();			
			}
		} else if ("D" == tag) {
			if (confirm('평가 점수를 삭제 하시겠습니까?')){
				frm.mode.value=tag;
				frm.year.value=pFrm.year.options[pFrm.year.selectedIndex].value;
				frm.grpId.value = pFrm.firstPart.options[pFrm.firstPart.selectedIndex].value;
				frm.submit();
			}
		} else if ("A" == tag) {
			if ((ca+cb+cc+cd+ce)<(mcn)){
				alert('선택하지 않은 항목이 있습니다.');
			} else {
				frm.mode.value=tag;
					
				frm.year.value=pFrm.year.options[pFrm.year.selectedIndex].value;
				frm.grpId.value = pFrm.firstPart.options[pFrm.firstPart.selectedIndex].value;
				
				frm.submit();			
			}
		}
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
	var openW;
	function openWin(pYear,pMid){
		var url = "viewActual.jsp?year="+pYear+"&mid="+pMid;
		
		if(openW!=null){
			openW.close();
			openW = null;
		}
		
		openW = window.open(url,"","toolbar=no,Width=600px,Height=400px,scrollbars=yes,resizable=yes,menubar:yes,status=yes");
		
		if (openW!=null) openW.focus();
	
	}		
</script>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body leftmargin="8" topmargin="0" marginwidth="0">
			<form name="form1" method="post" action="">
			<input type="hidden" name="mode">
			<input type="hidden" name="year">
			<input type="hidden" name="grpId">
			<!---//해당년월 부서선택//----->
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong>
                	<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle"> 
                  		고유지표 목록</strong></td>
              </tr>
            </table>
            <table id="tbl0" width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				  <tr> 
				    <td width="15%" bgcolor="#D4DCF4">부서</td>
				    <td width="25%" bgcolor="#D4DCF4">지표</td>
				    <td width="7%" align=center bgcolor="#D4DCF4">A</td>
				    <td width="7%" align=center bgcolor="#D4DCF4">B</td>
				    <td width="7%" align=center bgcolor="#D4DCF4">C</td>
				    <td width="7%" align=center bgcolor="#D4DCF4">D</td>
				    <td width="7%" align=center bgcolor="#D4DCF4">E</td>
				    <td width="10%" align=center bgcolor="#D4DCF4">실적보기</td>
				    <td width="10%" align=center bgcolor="#D4DCF4">첨부</td>
				    <td width="20%" align=center bgcolor="#D4DCF4">평가점수</td>
				    <td width="10%" align=center bgcolor="#D4DCF4">BSC실적</td>
				  </tr>
			<% 
			
			String aMCID = "";
			String eGrade = "";
			if (ds!=null) while(ds.next()){ 
				aMCID += "|"+ds.getString("MCID");
				eGrade = ds.isEmpty("EVALGRADE")?"":ds.getString("EVALGRADE");		
				String file = ds.isEmpty("FILEPATH")?"&nbsp;":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILEPATH")+"');\">  </a>";
			%>
				  <tr bgcolor="#FFFFFF"> 
				    <td bgcolor="#EEEEEE"><%= ds.getString("NAME") %></td>
				    <td bgcolor="#EEEEEE"><%= ds.getString("MNAME")%></td>
	                <td align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="A|"+scr[0]%>" <%=eGrade.equals("A")?"checked":"" %>></td>
	                <td align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="B|"+scr[1]%>" <%=eGrade.equals("B")?"checked":"" %>></td>
	                <td align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="C|"+scr[2]%>" <%=eGrade.equals("C")?"checked":"" %>></td>
	                <td align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="D|"+scr[3]%>" <%=eGrade.equals("D")?"checked":"" %>></td>
	                <td align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="E|"+scr[4]%>" <%=eGrade.equals("E")?"checked":"" %>></td>
	                <td bgcolor="#FFFFFF" align="center" id="cellc"><a href="javascript:openWin('<%=year %>','<%=ds.getString("MCID") %>')"><img src='<%=imgUri%>/jsp/web/images/btn_search_go.gif' width='21' height='20'></a></td>
	                <td bgcolor="#FFFFFF" align="center" id="celld"><font color="#333333"><%=file %></font></td>
	                <td bgcolor="#FFFFFF" align="center" id="celld"><font color="#333333"><%=ds.getString("EVALSCORE") %></font></td>
	                <td bgcolor="#FFFFFF" align="center" id="celld"><font color="#333333"><%=ds.getString("ACTUAL") %></font></td>
                </tr>
                <script>
                	addRDO("rdo<%=ds.getString("MCID")%>");
                </script>                   
            <% } %>  
              <tr bgcolor="#FFFFFF"> 
                <td align="center" colspan=2><font color="#333333"></font></td>
                <td align="center" id="ta">&nbsp;</td>
                <td align="center" id="tb">&nbsp;</td>
                <td align="center" id="tc">&nbsp;</td>
                <td align="center" id="td">&nbsp;</td>
                <td align="center" id="te">&nbsp;</td>
                <td align="center" colspan=4></td>
              </tr>                                                                   
                    
              <input type=hidden name=aMCID value=<%=aMCID %>>                    				  
            </table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
              <tr bgcolor="#FFFFFF"> 
                  <td colspan="9" align="right"> 
                    <a href="javascript:actionPerformed('I');"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" align="absmiddle"></a> 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:actionPerformed('D');"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a> 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:actionPerformed('A');"><img src="<%=imgUri %>/jsp/web/images/btn_bscAdjust.gif" alt="BSC실적 바녕" width="104" height="20" border="0" align="absmiddle"></a> 
                  </td>
              </tr>
            </table>            
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
	
	setCount();
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>