<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*,
				 com.nc.cool.*"%>
<%

	ValuateUtil util = new ValuateUtil();
	util.setEvalMeasureOrg(request, response);

	DataSet ds    = (DataSet)request.getAttribute("ds");
	//DataSet dsCnt = (DataSet)request.getAttribute("dsCnt");
	//DataSet dsScr = (DataSet)request.getAttribute("dsScr");
	
	String year  = request.getParameter("year");
	String month = request.getParameter("month");
	String grpId = request.getParameter("grpId");
	String measureId = request.getParameter("measureId");

	//----------------------------------------------------------------
	PeriodUtil periodutil = new PeriodUtil();                                          
	String div_cd  = "B03" ;                                                            
	String message = " 마감되었습니다. 조회만 가능합니다.";   

	String mmclose_yn = periodutil.getCheckCloseMM(year, div_cd, month);  
	if(mmclose_yn.equalsIgnoreCase("N")) message = "";
	//----------------------------------------------------------------

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	/*
	int[] cn = new int[5];
	if (dsCnt!=null)while(dsCnt.next()){
		cn[0]=dsCnt.isEmpty("A")?0:dsCnt.getInt("A"); //S
		cn[1]=dsCnt.isEmpty("B")?0:dsCnt.getInt("B"); //A
		cn[2]=dsCnt.isEmpty("C")?0:dsCnt.getInt("C"); //B
		cn[3]=dsCnt.isEmpty("D")?0:dsCnt.getInt("D"); //C
		cn[4]=dsCnt.isEmpty("E")?0:dsCnt.getInt("E"); //D
	}
	
	*/
	double[] scr = new double[9];
	scr[0] = 100; //S
	scr[1] = 95;  //A+
	scr[2] = 90;  //A
	scr[3] = 85;  //B+
	scr[4] = 80;  //B
	scr[5] = 75;  //C+
	scr[6] = 70;  //C
	scr[7] = 65;  //D+
	scr[8] = 60;  //D
	                       
%>
<SCRIPT>       
	var aRDO = new Array();
	
	var mcn = <%=(ds!=null)?ds.getRowCount():0%>;  // total measure count
	
	// selectable count 
  
	
	// score of grade "S"
	var ss  = "<%="S|"+scr[0]%>";          
	var sap = "<%="AP|"+scr[1]%>";
	var sa  = "<%="A|"+scr[2]%>";
	var sbp = "<%="BP|"+scr[3]%>";
	var sb  = "<%="B|"+scr[4]%>";
	var scp = "<%="CP|"+scr[5]%>";
	var sc  = "<%="C|"+scr[6]%>";
	var sdp = "<%="DP|"+scr[7]%>";
	var sd  = "<%="D|"+scr[8]%>";

	// current selected count
	var cs = 0;                                            
	var cap = 0;
	var ca = 0;
	var cbp = 0;
	var cb = 0;
	var ccp = 0;
	var cc = 0;
	var cdp = 0;
	var cd = 0;
	
	function addRDO(obj){
		aRDO[aRDO.length]=obj;
	}  
	
	
	function clkRDO(obj){
		setCount();
	}
	
	function setCount(){
		cs  = getSelChk(0);
		cap = getSelChk(1);
		ca  = getSelChk(2);
		cbp = getSelChk(3);
		cb  = getSelChk(4);
		ccp = getSelChk(5);
		cc  = getSelChk(6);
		cdp = getSelChk(7);
		cd  = getSelChk(8);
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
		var frm = listForm;
		var pFrm = parent.form1;
		
		// 마감되었슴
		if ("<%=mmclose_yn%>" == "Y") {	
				alert("<%=message%>");
				return;
		}				
		
		if ("I" == tag) {
			if ((cs+cap+ca+cbp+cb+ccp+cc+cdp+cd)<(mcn)){
				alert('선택하지 않은 항목이 있습니다.');
			} else {
				frm.mode.value=tag;
					
				frm.year.value  = pFrm.year.options[pFrm.year.selectedIndex].value;
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
	function openWin(pYear,pMonth,pMid){
		var url = "viewActual.jsp?year="+pYear+"&month="+pMonth+"&mid="+pMid;
		
		if(openW!=null){
			openW.close();
			openW = null;
		}
		
		openW = window.open(url,"","toolbar=no,Width=620px,Height=680px,scrollbars=yes,resizable=yes,menubar:yes,status=yes");
		
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
			height="15" align="absmiddle"> 비계량지표 평가</strong>&nbsp;&nbsp;&nbsp;
			<b><font color="red"><%=message %></font></b></td>
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
<div style="overflow-y:scroll;width:100%;height:40px;">
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" >
	<tr align="center" bgcolor="#D4DCF4">
		<td><strong><font color="#003399">구분</font></strong></td>
		<td width="100"><strong><font color="#003399">조직명</font></strong></td>
		<td width="40"><strong><font color="#003399">S<br>(100)</font></strong></td>
		<td width="40"><strong><font color="#003399">A+<br>(95)</font></strong></td>
		<td width="40"><strong><font color="#003399">A<br>(90)</font></strong></td>
		<td width="40"><strong><font color="#003399">B+<br>(85)</font></strong></td>
		<td width="40"><strong><font color="#003399">B<br>(80)</font></strong></td>
		<td width="40"><strong><font color="#003399">C+<br>(75)</font></strong></td>
		<td width="40"><strong><font color="#003399">C<br>(70)</font></strong></td>
		<td width="40"><strong><font color="#003399">D+<br>(65)</font></strong></td>
		<td width="40"><strong><font color="#003399">D<br>(60)</font></strong></td>
		<td width="60"><strong><font color="#003399">실적<br>보기</font></strong></td>
		<td width="50"><strong><font color="#003399">실적<br>미입력</font></strong></td>
		<td width="50"><strong><font color="#003399">첨부</font></strong></td>
	</tr>
</table>
</div>
<div style="overflow-y:scroll;width:100%;height:310px;">
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>

<%
	String aMCID = "";
	String eGrade = "";
	if (ds!=null) { 
%>

	<% 
	while (ds.next()){
			aMCID += "|"+ds.getString("MCID");
			eGrade = ds.isEmpty("EVALGRADE")?"":ds.getString("EVALGRADE");
			
			String file = ds.isEmpty("FILEPATH")?"&nbsp;":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILEPATH")+"','"+ds.getString("FILENAME")+"');\"> </a>";
	%>
              <tr bgcolor="#FFFFFF"> 
                <td align="center" ><font color="#333333"><%=ds.getString("SNAME") %><font color="#333333"></td>
                <td width="100" align="center" ><a href="javascript:showOpn('<%=ds.getString("MCID") %>','<%=ds.getString("BNAME") %>','S');"><font color="#333333"><%=ds.getString("BNAME") %></font></a></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="S|"+scr[0]%>" <%=eGrade.equals("S")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="AP|"+scr[1]%>" <%=eGrade.equals("AP")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="A|" +scr[2]%>" <%=eGrade.equals("A")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="BP|"+scr[3]%>" <%=eGrade.equals("BP")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="B|" +scr[4]%>" <%=eGrade.equals("B")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="CP|"+scr[5]%>" <%=eGrade.equals("CP")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="C|" +scr[6]%>" <%=eGrade.equals("C")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="DP|"+scr[7]%>" <%=eGrade.equals("DP")?"checked":"" %>></td>
                <td width="40" align="center" ><input type=radio name=rdo<%=ds.getString("MCID") %> onClick="javascript:clkRDO(this)" value="<%="D|" +scr[8]%>" <%=eGrade.equals("D")?"checked":"" %>></td>
                
                <td width="60" align="center" ><a href="javascript:openWin('<%=year %>','<%=month %>','<%=ds.getString("MCID") %>')"><img src='<%=imgUri%>/jsp/web/images/btn_search_go.gif' width='21' height='20'></a></td>
                <td width="50" align="center" ><% if(ds.getString("AMID") == null || "".equals(ds.getString("AMID"))) { %><font color="red">●</font><% } %></td>
                <td width="50" align="center" ><%=file %></td>
              </tr>
                <script>
                	addRDO("rdo<%=ds.getInt("MCID")%>");
                </script>              
	<% } 
	}else{ %>
              <tr bgcolor="#FFFFFF"> 
                <td colspan="9" align="center" height="195"></td>
              </tr>                                                                   
<% } %> 
			                 
	<input type=hidden name=aMCID value=<%=aMCID %>>                                                   
</table>
</form>
</div>

<!-- 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"  id="tblList">
	<tr>
		<td><iframe frameborder="0" id="detail" src="doValuateOpnDetail2007_1.jsp" style="body" width="100%" height="250">&nbsp;</iframe></td>
	</tr>
</table>
 -->
<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
	<input type="hidden" name="filePath">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	function download(filepath,filename){
		downForm.fileName.value=filename;
		downForm.filePath.value=filepath;
		downForm.submit();
	}
	
	setCount();
<%if (ds!=null) { %>
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
<%}%>
//-->
</SCRIPT>
</body>
</html>
