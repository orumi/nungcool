<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.cool.PeriodUtil,	
				 com.nc.util.*"%>
<%

	ValuateUtil util = new ValuateUtil();
	util.setEvalMeasure(request, response);
	


	DataSet ds = (DataSet)request.getAttribute("ds");
	DataSet dsCnt = (DataSet)request.getAttribute("dsCnt");
	DataSet dsScr = (DataSet)request.getAttribute("dsScr");
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String grpId = request.getParameter("grpId");
	String measureId = request.getParameter("measureId");

	// 마감일정검사 시작 ===============================================================
	PeriodUtil periodutil = new PeriodUtil();
	String periodvalidate = null;
	String div_cd  = "B03";
	String message = "평가 등록기간이 아닙니다.";
	year =request.getParameter("year");
	
	//year = (year == null || "".equals(year)) ? Util.getToDay().substring(0,4) : year;
	periodvalidate = periodutil.validatePeriod(div_cd, year);
	periodvalidate = (periodvalidate == null || "".equals(periodvalidate)) ? "N" : periodvalidate;
	
	//System.out.println("year ===> " + year);
	//System.out.println("periodvalidate ===> " + periodvalidate);
	// 마감일정검사 끝 =================================================================		
			
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	int[] cn = new int[5];
	if (dsCnt!=null)while(dsCnt.next()){
		cn[0]=dsCnt.isEmpty("A")?0:dsCnt.getInt("A"); //S
		cn[1]=dsCnt.isEmpty("B")?0:dsCnt.getInt("B"); //A
		cn[2]=dsCnt.isEmpty("C")?0:dsCnt.getInt("C"); //B
		cn[3]=dsCnt.isEmpty("D")?0:dsCnt.getInt("D"); //C
		cn[4]=dsCnt.isEmpty("E")?0:dsCnt.getInt("E"); //D
	}
	
	double[] scr = new double[5];
	if (dsScr!=null)while(dsScr.next()){
		scr[0] = dsScr.getDouble("A"); //S
		scr[1] = dsScr.getDouble("B"); //A
		scr[2] = dsScr.getDouble("C"); //B
		scr[3] = dsScr.getDouble("D"); //C
		scr[4] = dsScr.getDouble("E"); //D
	}
	                       
%>
<SCRIPT>       
	var aRDO = new Array();
	
	var mcn = <%=(ds!=null)?ds.getRowCount():0%>;  // total measure count
	
	// selectable count 
	var cns = <%=cn[0]%>;          
	var cna = <%=cn[1]%>;  
	var cnb = <%=cn[2]%>;   
	var cnc = <%=cn[3]%>;  
	var cnd = <%=cn[4]%>;   
	
	// score of grade "S"
	var ss = "<%="S|"+scr[0]%>";          
	var sa = "<%="A|"+scr[1]%>";
	var sb = "<%="B|"+scr[2]%>";
	var sc = "<%="C|"+scr[3]%>";
	var sd = "<%="D|"+scr[4]%>";

	// current selected count
	var cs = 0;                                            
	var ca = 0;
	var cb = 0;
	var cc = 0;
	var cd = 0;
	
	function addRDO(obj){
		aRDO[aRDO.length]=obj;
	}                           
	function clkRDO(obj){
		
		var count=0;
		var k;
		var limit=0;
		var val = obj.value;
		if (ss==val){	
			k=0;
			limit=cns;
		} else if (sa==val){
			k=1;
			limit=cna;
		} else if (sb==val){
			k=2;
			limit=cnb;
		} else if (sc==val){
			k=3;
			limit=cnc;
		} else if (sd==val){
			k=4;
			limit=cnd;
		}

		for(i=0;i<aRDO.length;i++){
			if(document.getElementsByName(aRDO[i])[k].checked){
				count++;
			}
		}
		//if (count>limit){
		//	alert("다른 등급을 선택해 주십시오");
		//	obj.checked=false;
		//}
		setCount();
	}
	
	function setCount(){
		var cell = document.getElementById("ts");
		cs = getSelChk(0);
		cell.innerText = cs+"/"+cns;
		
		cell = document.getElementById("ta");
		
		ca = getSelChk(1);
		cell.innerText = ca+"/"+cna;
		
		cell = document.getElementById("tb");
		cb = getSelChk(2);
		cell.innerText = cb+"/"+cnb;
		
		cell = document.getElementById("tc");
		cc = getSelChk(3);
		cell.innerText = cc+"/"+cnc;
		
		cell = document.getElementById("td");
		cd = getSelChk(4);
		cell.innerText = cd+"/"+cnd;		
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
	
		if ("<%=periodvalidate%>" == "N") {	
				alert("평가 등록기간이 아닙니다.");
				return;
		}
			
		var frm = listForm;
		var pFrm = parent.form1;
		if ("I" == tag) {
			if ((cs+ca+cb+cc+cd)<(mcn)){
				alert('선택하지 않은 항목이 있습니다.');
			} else {
				frm.mode.value=tag;
					
				frm.year.value=pFrm.year.options[pFrm.year.selectedIndex].value;
				frm.month.value = pFrm.month.options[pFrm.month.selectedIndex].value;	
				frm.grpId.value = pFrm.firstPart.options[pFrm.firstPart.selectedIndex].value;
				frm.measureId.value = pFrm.secondPart.options[pFrm.secondPart.selectedIndex].value;	
				
				frm.submit();			
			}
		} else if ("D" == tag) {
			if (confirm('평가 점수를 삭제 하시겠습니까?')){
				frm.mode.value=tag;
				frm.year.value=pFrm.year.options[pFrm.year.selectedIndex].value;
				frm.month.value = pFrm.month.options[pFrm.month.selectedIndex].value;	
				frm.grpId.value = pFrm.firstPart.options[pFrm.firstPart.selectedIndex].value;
				frm.measureId.value = pFrm.secondPart.options[pFrm.secondPart.selectedIndex].value;					
				frm.submit();
			}
		}
	}	
	var openW;
	function openWin(pYear,pMid){
		var month = parent.form1.month.options[parent.form1.month.selectedIndex].value;
		var url = "viewActual.jsp?year="+pYear+"&mid="+pMid+"&month="+month;
		
		if(openW!=null){
			openW.close();
			openW = null;
		}

		openW = window.open(url,"","toolbar=no,Width=600px,Height=680px,scrollbars=yes,resizable=yes,menubar:yes,status=yes");
		
		if (openW!=null) openW.focus();
	
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
	
	function showOpn(mcid,bname,mode){
		
		detail.form1.year.value="<%=year%>";
		detail.form1.month.value="<%=month%>";
		detail.form1.grpId.value="<%=grpId%>";
		detail.form1.measureId.value="<%=measureId%>";
		detail.form1.mcId.value=mcid;
		detail.form1.bname.value=bname;
		detail.form1.mode.value=mode;
		detail.form1.submit();
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
<input type=hidden name=mode >
<input type=hidden name=year >
<input type=hidden name=month >
<input type=hidden name=grpId >
<input type=hidden name=measureId >
<input type=hidden name=tag >

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 비계량지표 평가</strong></td>
		<td align="right">
			<table align="right">
				<tr><td>
				    <a href="javascript:actionPerformed('I');"><img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0"></a>&nbsp;
					&nbsp;
					<a href="javascript:actionPerformed('D');"><img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0"></a>&nbsp;
					&nbsp;&nbsp;
				</td></tr>
			</table>
		</td>
	</tr>
</table>
<!---------//좌측  KPI 선택 전청 리스트//-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" >
	<tr align="center" bgcolor="#D4DCF4">
		<td width="220"><strong><font color="#003399">구분</font></strong></td>
		<td width="350"><strong><font color="#003399">조직명</font></strong></td>
		<td width="40"><strong><font color="#003399">S</font></strong></td>
		<td width="40"><strong><font color="#003399">A</font></strong></td>
		<td width="40"><strong><font color="#003399">B</font></strong></td>
		<td width="40"><strong><font color="#003399">C</font></strong></td>
		<td width="40"><strong><font color="#003399">D</font></strong></td>
		<td width="60"><strong><font color="#003399">실적<br>보기</font></strong></td>
		<td colspan=2><strong><font color="#003399">첨부</font></strong></td>
	</tr>
</table>
<div style="overflow-y:auto;width:100%;height:220px;">
<%
	String aMCID = "";
	String eGrade = "";
	if (ds!=null) { 
%>
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<% 
		while (ds.next()){
			aMCID += "|"+ds.getString("MCID");
			eGrade = ds.isEmpty("EVALGRADE")?"":ds.getString("EVALGRADE");
			
			String file = ds.isEmpty("FILEPATH")?"&nbsp;":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILENAME")+"','"+ds.getString("FILEPATH")+"');\">  </a>";
			String filePlan = ds.isEmpty("FILEPATH_PLAN")?"&nbsp;":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILENAME_PLAN")+"','"+ds.getString("FILEPATH_PLAN")+"');\">  </a>";
	%>
              <tr bgcolor="#FFFFFF"> 
                <td width="220" align="center" ><font color="#333333"><%=ds.getString("SNAME") %><font color="#333333"></td>
                <td width="350" align="center" ><a href="javascript:showOpn('<%=ds.getString("MCID") %>','<%=ds.getString("BNAME") %>','S');"><font color="#333333"><%=ds.getString("BNAME") %></font></a></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="S|"+scr[0]%>" <%=eGrade.equals("S")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="A|"+scr[1]%>" <%=eGrade.equals("A")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="B|"+scr[2]%>" <%=eGrade.equals("B")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="C|"+scr[3]%>" <%=eGrade.equals("C")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="D|"+scr[4]%>" <%=eGrade.equals("D")?"checked":"" %>></td>
                <td width="60" align="center" ><a href="javascript:openWin('<%=year %>','<%=ds.getString("MCID") %>')"><img src='<%=imgUri%>/jsp/web/images/btn_search_go.gif' width='21' height='20'></a></td>
                <td align="center" ><%=filePlan %></td>
                <td align="center" ><%=file %></td>
              </tr>
                <script>
                	addRDO("rdo<%=ds.getInt("MCID")%>");
                </script>              
	<% } 
	}else{ %>
	<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>              
              <tr bgcolor="#FFFFFF"> 
                <td colspan="9" align="center" height="195"></td>
              </tr>                                                                   
<% } %> 
			<tr bgcolor="#FFFFFF" style="display:none;"> 
                <td width="220" align="center" ><font color="#333333"></font></td>
                <td width="350" align="center" ><font color="#333333"></font></td>
                <td width="40" align="center" id="ts">&nbsp;</td>
                <td width="40" align="center" id="ta">&nbsp;</td>
                <td width="40" align="center" id="tb">&nbsp;</td>
                <td width="40" align="center" id="tc">&nbsp;</td>
                <td width="40" align="center" id="td">&nbsp;</td>
                <td width="60" align="center" ></td>
                <td align="center" ></td>
                <td align="center" ></td>
              </tr>                    
	<input type=hidden name=aMCID value=<%=aMCID %>>                                                   
</table>
</form>
</div>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"  id="tblList">
	<tr>
		<td><iframe frameborder="0" id="detail" src="doValuateOpnDetail.jsp" style="body" width="100%" height="250">&nbsp;</iframe></td>
	</tr>
</table>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
	<input type="hidden" name="filePath">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	function download(filename, filepath){
		downForm.fileName.value=filename;
		downForm.filePath.value=filepath;
		downForm.submit();
	}
	
	setCount();
<%if (ds!=null) { %>
	mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
<%}%>
//-->
</SCRIPT>
</body>
</html>
