<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.cool.AppConfigUtil,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	//String qtr    = Util.getPrevQty(null);
	
	// 년월고정.
	AppConfigUtil app = new AppConfigUtil();
	String showym = app.getShowYM()!= null?app.getShowYM():Util.getPrevQty(null);	
	String qtr    = showym.substring(0,6);
	String year   = request.getParameter("year") !=null?request.getParameter("year"):qtr.substring(0,4);
	
	request.setAttribute("year",year);	
	ActualUtil util = new ActualUtil();
	util.setDivision(request, response);
	
	String strId = (String)session.getAttribute("userId");
	
	
	if (strId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {
		String curDate= request.getParameter("year")!=null?request.getParameter("year")+qtr.substring(4,6):qtr.substring(0,6);
		DataSet ds = (DataSet) request.getAttribute("ds");
%>
<SCRIPT>
	var initCon = false;
    function actionPerformed(){
    	
    	initCon = true;    	
    	
    	var state = "";
		if(form1.state_s.checked == true)
			state = state + form1.state_s.value + "|";
		if(form1.state_a.checked == true)
			state = state + form1.state_a.value + "|";
		if(form1.state_b.checked == true)
			state = state + form1.state_b.value + "|";
		if(form1.state_c.checked == true)
			state = state + form1.state_c.value + "|";
		if(form1.state_d.checked == true)
			state = state + form1.state_d.value + "|";

		list.detailForm.sbuid.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
		list.detailForm.year.value = form1.year.options[form1.year.selectedIndex].value;
		list.detailForm.ym.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		list.detailForm.sname.value = form1.firstPart.options[form1.firstPart.selectedIndex].text;
		list.detailForm.state.value = state;
		//alert(list.detailForm.sbuid.value+"/"+list.detailForm.year.value+"/"+list.detailForm.ym.value+"/"+list.detailForm.sName.value);
		list.detailForm.submit();
    }
    
    function leftReload(){
    	list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		list.listForm.submit();
    }

    function funcSetDate(curYear) {
      for (i=0,j=curYear-2; i<=5;i++,j++) {
      	 form1.year.options[i] = new Option(j, j);
      }
      form1.year.options[2].selected=true;
      onChangeDate();
    }

    function funcSetMonth(curMonth) {
    	form1.month.options[0] = new Option("1/4분기","03");
    	form1.month.options[1] = new Option("2/4분기","06");
    	form1.month.options[2] = new Option("3/4분기","09");
    	form1.month.options[3] = new Option("4/4분기","12");
    	
    	form1.month.options[(curMonth/3) - 1].selected=true;
    }    
    
    
    function changeYear(){
      this.form1.yyyy.value = this.form1.year.value;
      document.getElementById("list").style.display = "none";
      this.form1.submit();    
    }
    
    function onChangeSelect(){
      if (!initCon) return false;
      
      list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
	  list.listForm.submit();
    }
    
    function onChangeDate(){
      if (!initCon) return false;
    	
      changeBSC();
    }
    
    function closeList(){
    	document.getElementById("list").style.display = "none";
    	
    }
    
     function openList(){
    	document.getElementById("list").style.display = "";    	
    }
    
    function sendDetail(){
        detail.detailForm.submit();
        
        alert("실적이 등록되었습니다.");
        list.listForm.defineId.value=detail.detailForm.contentId.value;
        actionPerformed();
    }
    
    var arrayOrg = new Array();
  
	function initrs(code,name,parent_code,levelgb,i){
		   var rslength = 0;
	       arrayOrg[i] = new orgCD(code, name, parent_code, levelgb);
	}
	
	function orgCD(code, name, parent_cd, levelgb){
       this.code = code;
       this.name = name;
       this.parent_cd = parent_cd;
       this.levelgb = levelgb;
   	}
    
    
    var refresh = false;
    
    function refreshList() {
    	if (refresh){
			actionPerformed();
			
			refresh = false;  	
    	}
    }
    
    function printReport(){
    	//list.printReport();
    	//document.print.reportPrint();
    	var printwin; 
 		printwin = window.open("","prtWin","left=10px;top=10px;height=500,width=700,scrollbars=yes,toolbar=yes,menubar=yes"); 
 		
 		var state = "";
		if(form1.state_s.checked == true)
			state = state + form1.state_s.value + "|";
		if(form1.state_a.checked == true)
			state = state + form1.state_a.value + "|";
		if(form1.state_b.checked == true)
			state = state + form1.state_b.value + "|";
		if(form1.state_c.checked == true)
			state = state + form1.state_c.value + "|";
		if(form1.state_d.checked == true)
			state = state + form1.state_d.value + "|";
			
 		form1.sbuid.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
		form1.ym.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		form1.sname.value = form1.firstPart.options[form1.firstPart.selectedIndex].text;
		form1.state.value = state;
		
    	form1.target="prtWin";
    	form1.action="rptForCEOPrint.jsp";
    	form1.submit();
    	
 		printwin.focus();
    }
    
    function excelReport(){
    	var state = "";
		if(form1.state_s.checked == true)
			state = state + form1.state_s.value + "|";
		if(form1.state_a.checked == true)
			state = state + form1.state_a.value + "|";
		if(form1.state_b.checked == true)
			state = state + form1.state_b.value + "|";
		if(form1.state_c.checked == true)
			state = state + form1.state_c.value + "|";
		if(form1.state_d.checked == true)
			state = state + form1.state_d.value + "|";
			
 		form1.sbuid.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
		form1.ym.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		form1.sname.value = form1.firstPart.options[form1.firstPart.selectedIndex].text;
		form1.state.value = state;
		
		form1.target="_blank";
    	form1.action="rptForCEOExcel.jsp";
    	form1.submit();
    }
</SCRIPT>
<html>
<head>
<title>::: CEO Report :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0">

<!------//Page Box//------>
<%
	StringBuffer sbuBuf = new StringBuffer();
	StringBuffer bscBuf = new StringBuffer();
	
	int treeText = 0;
	int firstCode = 0;
	int i = 0;
	int parent = 0;
	if (ds!=null)
	while (ds.next()) {
		
		if (firstCode != ds.getInt("SID")){
			firstCode = ds.getInt("SID");
			if (i==0) parent = firstCode;
			String name = ds.getString("SNAME").trim();
			%>
				<script>
				initrs('<%=ds.getInt("SID")%>','<%=name%>','<%=ds.getInt("SPID")%>',0,<%=i++%>);
				</script>
			<%	
			sbuBuf.append("<option value='" + ds.getInt("SID") + "'");
			sbuBuf.append(">");
			sbuBuf.append(name);
			sbuBuf.append("</option>");	
			
		}
	}

%>
<!------//Page Box//------>
<!---------///본문 컨텐츠 삽입영역 ///--------->
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!------//상단 검색//----->
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
	<form name="form1" method="post" action="">
	<input type=hidden name=yyyy>
	<input type=hidden name=sbuid>
	<input type=hidden name=bcid>
	<input type=hidden name=ym>
	<input type=hidden name=sname>
	<input type=hidden name=state>
	<tr bgcolor="#DCEDF6">
		<td width="12%" align="center"><strong><font color="#006699"> 년월선택</font></strong></td>
		<td width="30%" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select>년 
             <select name="month" onChange="onChangeDate()";>
	                <script> funcSetMonth(<%=curDate.substring(4,6)%>); </script>
             </select>
        </td>
        <td width="58%" colspan="2" bgcolor="#FFFFFF" align="right">
			<img src="<%=imgUri%>/jsp/web/images/btn_print.gif" alt="출력" onClick="javascript:printReport();" style="cursor:hand" border="0" align="absmiddle">
			<img src="<%=imgUri%>/jsp/web/images/btn_excel_save.gif" alt="엑셀" onClick="javascript:excelReport();" style="cursor:hand" border="0" align="absmiddle">
		</td>
    </tr>
	<tr bgcolor="#DCEDF6">
		<td width="12%" align="center" bgcolor="#DCEDF6"><strong><font color="#006699">조직선택</font></strong></td>
		<td width="36%" bgcolor="#FFFFFF">
			<select name="firstPart"  style="width:150;x;" onChange="closeList()">
        	<%=sbuBuf.toString()%>
        	</select> <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif" alt="확인" onClick="javascript:actionPerformed();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle">
		</td>
		<td width="12%" align="center" bgcolor="#DCEDF6"><strong><font color="#006699">대상지표</font></strong></td>
		<td width="40%" bgcolor="#FFFFFF">
			<input type="checkbox" name="state_s" value="S">탁월
			<input type="checkbox" name="state_a" value="A">우수
			<input type="checkbox" name="state_b" value="B">보통
			<input type="checkbox" name="state_c" value="C" checked>미흡
			<input type="checkbox" name="state_d" value="D" checked>저조
		</td>	
	</tr>
	</form>
</table>
<!------//상단 검색 끝//----->
<table width="98%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td width="100%">
			<iframe frameborder="0" id="list" src="rptForCEODetail.jsp" style="body" width="100%" height="440" scroll="auto">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->

<!-----//Box layout end//----->
<iframe frameborder="0" id="print" name="print" src="" width="100%" height="0" scroll="yes"></iframe>
</body>
</html>
<% } %>
