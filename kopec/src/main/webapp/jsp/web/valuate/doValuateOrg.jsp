<%-- 
	// 2007년도 4/4분기 비계량 본부평가
--%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.cool.AppConfigUtil,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	// 년월고정.
	AppConfigUtil app = new AppConfigUtil();
	String showym = app.getShowYM()!= null?app.getShowYM():Util.getPrevQty(null);	
	String qtr    = showym.substring(0,6);
	String year   = request.getParameter("year") !=null?request.getParameter("year"):qtr.substring(0,4);
	String month  = request.getParameter("month")!=null?request.getParameter("month"):qtr.substring(4,6);	
	
	String userId = (String)session.getAttribute("userId");

	//System.out.println("QTR :" + qtr + ", YEAR : " + year);
	
	if (userId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {
		String curDate = year + month;

		request.setAttribute("curDate",curDate);			
		ValuateUtil util = new ValuateUtil();
		util.setEvalGroupOrg(request, response);
		
		System.out.println("month    ===>>   "+month);
		DataSet dsGrp = (DataSet) request.getAttribute("dsGrp");
		DataSet dsDtl = (DataSet) request.getAttribute("dsDtl");
		String  scid  = (String) request.getAttribute("scid");
%>
<SCRIPT>
	var initCon = false;
    function actionPerformed(){

    	if(form1.secondPart.length==0){
    		alert("지표를 선택하셔야 합니다.")
    		initCon = false;
    		return false;
    	}
    	initCon = true;

		var frm = list.listForm;
		frm.mode.value="G";
		frm.year.value= form1.year.options[form1.year.selectedIndex].value;
		frm.month.value= form1.month.options[form1.month.selectedIndex].value;
		frm.grpId.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
		frm.measureId.value = form1.secondPart.options[form1.secondPart.selectedIndex].value;
		frm.submit();

		showList();
    }

    function leftReload(){
    	list.listForm.sbuId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		list.listForm.submit();
    }

    function funcSetDate(curYear) {
      for (i=0,j=curYear-2; i<=5;i++,j++) {
      	 form1.year.options[i] = new Option(j, j);
      }
      form1.year.options[2].selected=true;
    }

    function funcSetMonth(curMonth) {
    	form1.month.options[0] = new Option("1/4분기","03");
    	form1.month.options[1] = new Option("2/4분기","06");
    	form1.month.options[2] = new Option("3/4분기","09");
    	form1.month.options[3] = new Option("4/4분기","12");
    	
    	form1.month.options[(curMonth/3) - 1].selected=true;    	
    }    

    function changeYear(){
      	form1.submit();
    }

    function changeMonth() {
      document.getElementById("list").style.display="none";
      form1.firstPart.length = 0;
      form1.secondPart.length = 0;
    }

    function chgOrg(level){
    	var length = arrayOrg.length;

    	if ( level == 1 ){ //change level 1
    		// 평가조직이 없으면
    		if (form1.firstPart.selectedIndex == -1) {
    			form1.secondPart.length = 0;
    		// 평가조직이 있으면
    		} else {
	    		var parentcode = form1.firstPart.options[form1.firstPart.selectedIndex].value;
	
	    		form1.secondPart.length = 0;
	
	    		for ( i = 0; i < length; i++ ){
	    			if ( arrayOrg[i].levelgb == '1'){
	    				if ( arrayOrg[i].parent_cd == parentcode ){
	    					form1.secondPart.options[form1.secondPart.length] = new Option(arrayOrg[i].name, arrayOrg[i].code);
	    				}
	    			} 
	    		}
			}
    	}
    			
		thisFormSubmit();
    }
    
    function thisFormSubmit() {
    	if (document.form1.firstPart.selectedIndex != -1) {
	    	document.form1.scid.value = form1.firstPart.options[document.form1.firstPart.selectedIndex].value;
	    	document.form1.submit();
	    }
    }

    function openDetail(id){
      document.getElementById("list").style.display="none";

      detail.form1.mId.value=id;
      detail.form1.year.value = form1.year.options[form1.year.selectedIndex].value;
      detail.form1.month.value = form1.month.options[form1.month.selectedIndex].value;

      detail.form1.submit();
    }

    function showList(){
      document.getElementById("list").style.display="inline";
    }

    function closeList(){
    	document.getElementById("list").style.display = "none";
    }

    function funcDivVisible(){
    	document.getElementById("list").style.display="inline";
    }

    function onChangeSelect(){
      if (!initCon) return false;

      if(form1.secondPart.options[form1.secondPart.selectedIndex].value==""){
    		return false;
    	}
    	document.getElementById("detail").style.display="none";
		list.listForm.sbuId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		list.listForm.submit();
    }

	function getEvalDiv(){
		form1.submit();
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
       this.levelgb   = levelgb;
   	}

    function chgMea(){
    	if(form1.secondPart.length==0){
    		return;
    	}

    	actionPerformed();
    }

    var refresh = false;

    function refreshList() {
    	if (refresh){
			actionPerformed();

			refresh = false;
    	}
    }
</SCRIPT>
<html>
<head>
<title>::: 실적관리 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0">

<!------//Page Box//------>
<%
	StringBuffer grpBuf = new StringBuffer();
	StringBuffer dtlBuf = new StringBuffer();

	int treeText = 0;
	int firstCode = 0;
	int i = 0;
	int parent = 0;
	int tempCnt = 0;	// 평가조직 유무
	
	if (dsGrp!=null) {

		while (dsGrp.next()) {
			if (firstCode != dsGrp.getInt("GRPID")){
				firstCode = dsGrp.getInt("GRPID");
				if (i==0) parent = firstCode;
				String name = dsGrp.getString("GRPNM").trim();
				%>
					<script>
					initrs('<%=dsGrp.getInt("GRPID")%>','<%=name%>',0,0,<%=i++%>);
					</script>
				<%
				grpBuf.append("<option value='" + dsGrp.getInt("GRPID") + "'");
				if (scid.equals(String.valueOf(dsGrp.getInt("GRPID")))) {
					grpBuf.append(" selected ");
				}
				grpBuf.append(">");
				grpBuf.append(name);
				grpBuf.append("</option>");
			}
			tempCnt++;
		}
	
		
		if (tempCnt != 0) {		// 평가조직이 하나라도 없으면 지표명 콤보박스에 데이터를 뿌리지 말라.
			if (dsDtl!=null) {
				while (dsDtl.next()) {
		
						%>
							<script>
							initrs('<%=dsDtl.getInt("MEASUREID")%>','<%=dsDtl.getString("MNAME")%>','<%=dsDtl.getInt("GRPID")%>',1,<%=i++%>);
							</script>
						<%
		
						//if (parent==dsDtl.getInt("GRPID")){
							dtlBuf.append("<option value='" + dsDtl.getInt("MEASUREID") + "'");
							dtlBuf.append(">");
							dtlBuf.append(dsDtl.getString("MNAME"));
							dtlBuf.append("</option>");
						//}
				}
			}
		}
	}
%>
<!------//Page Box//------>
<!---------///본문 컨텐츠 삽입영역 ///--------->

<!------//상단 검색//----->
<table width="98%" border="0" align="center" cellpadding="5"
	cellspacing="1" bgcolor="#A4CBE3">
	<form name="form1" method="post" action="">
	<input type="hidden" name="scid" />
	
	<tr bgcolor="#DCEDF6">
		<td width="14%" align="center"><strong><font color="#006699">평가년월</font></strong></td>
		<td width="86%" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select> 년
             <select  name="month" onChange="javascript:getEvalDiv();";>
	                <script> funcSetMonth(<%=month%>); </script>
             </select>
             <!-- img src="<%=imgUri%>/jsp/web/images/btn_ok.gif" alt="확인" onClick="javascript:getEvalDiv();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle" -->  
          </td>
	</tr>
	<tr bgcolor="#DCEDF6">
		<td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">조직선택</font></strong></td>
		<td bgcolor="#FFFFFF">평가조직 :
		<select name="firstPart"  style="width:170;x;" onChange="javascript:chgOrg(1);closeList()" align="absmiddle">
        	<%=grpBuf.toString()%>
        </select>
       	 지표명 :
        <select name="secondPart" onChange="javascript:closeList();chgMea();" align="absmiddle" style="width:180px;">
        	<%=dtlBuf.toString()%>
        </select>
        <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif" alt="확인" onClick="javascript:actionPerformed();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle"></td>
	</tr>
	</form>
</table>
<!------//상단 검색 끝//----->
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"  id="tblList">
	<tr>
		<td>
			<iframe frameborder="0" scrolling="no" id="list" src="doValuateOrgList.jsp" style="body" width="100%" height="540">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>
