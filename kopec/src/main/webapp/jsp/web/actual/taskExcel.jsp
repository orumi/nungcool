<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*,
				 com.nc.cool.AppConfigUtil,
			 	 com.nc.cool.PeriodUtil"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	// 년월고정.
	AppConfigUtil app = new AppConfigUtil();
	String showym = app.getShowYM()!= null?app.getShowYM():Util.getPrevQty(null);
	String qtr    = showym.substring(0,6);
	String year   = request.getParameter("year") !=null?request.getParameter("year"):qtr.substring(0,4);

	String strId =(String)session.getAttribute("userId");

	if (strId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {

		String curDate= showym;

		// 마감일정검사 시작 ===============================================================
		PeriodUtil periodutil = new PeriodUtil();
		String periodvalidate = null;
		String div_cd = "B02";
		String message = "실적 등록기간이 아닙니다.";

		year = curDate.substring(0,4);
		periodvalidate = periodutil.validatePeriod(div_cd, year);
		periodvalidate = (periodvalidate == null || "".equals(periodvalidate)) ? "N" : periodvalidate;
		// 마감일정검사 끝 =================================================================

		DataSet ds = (DataSet) request.getAttribute("ds");
%>

<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
<script src="<%=imgUri%>/bootstrap/js/libs/jquery-2.1.1.min.js"></script>
<script src="<%=imgUri%>/bootstrap/js/libs/jquery-ui-1.10.3.min.js"></script>

<SCRIPT>
	var initCon = false;
    function actionPerformed(){
    	initCon = true;

    	$("#list").contents().find("input[name=year]").val(form1.year.options[form1.year.selectedIndex].value);
    	$("#list").contents().find("input[name=month1]").val(form1.start_month.options[form1.start_month.selectedIndex].value);
    	$("#list").contents().find("input[name=month2]").val(form1.start_month.options[form1.start_month.selectedIndex].value);

    	$("#list").contents().find("form[name=listForm]").submit();

		/* list.listForm.year.value  =form1.year.options[form1.year.selectedIndex].value;
		list.listForm.month1.value=form1.start_month.options[form1.start_month.selectedIndex].value;
		list.listForm.month2.value=form1.start_month.options[form1.start_month.selectedIndex].value;
		list.listForm.submit(); */
    }

    function leftReload(){
    	list.listForm.sbuId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.submit();
    }

    function funcSetDate(curYear) {
      for (i=0,j=curYear-2; i<=5;i++,j++) {
      	 form1.year.options[i] = new Option(j, j);
      }
      form1.year.options[2].selected=true;
      onChangeDate();
    }

    function changeYear(){
      this.form1.yyyy.value= this.form1.year.value;
      document.getElementById("list").style.display = "none";
      document.getElementById("detail").style.display="none";
      this.form1.submit();
    }

    function changefirstMonth(){

    }

    function changelastMonth(){

    }

    function chgOrg(level){
    	var length = arrayOrg.length;

    	if ( level == 1 ){ //change level 1

    		//var parentcode = form1.firstPart.options[form1.firstPart.selectedIndex].value;
    	}
    }

    function openDetail(id, m_name){

    	$("#detail").contents().find("input[name=contentId]").val(id);
    	$("#detail").contents().find("input[name=year]").val(form1.year.options[form1.year.selectedIndex].value);
    	$("#detail").contents().find("input[name=month1]").val(form1.start_month.options[form1.start_month.selectedIndex].value);
    	$("#detail").contents().find("input[name=month2]").val(form1.start_month.options[form1.start_month.selectedIndex].value);
    	$("#detail").contents().find("input[name=mode]").val("detail");

    	$("#detail").contents().find("form[name=detailForm]").submit();


     /*  detail.detailForm.contentId.value = id;
      detail.detailForm.year.value   = form1.year.options[form1.year.selectedIndex].value;
      detail.detailForm.month1.value = form1.start_month.options[form1.start_month.selectedIndex].value;
      detail.detailForm.month2.value = form1.start_month.options[form1.start_month.selectedIndex].value;
      detail.detailForm.mode.value = "detail";
      detail.detailForm.submit(); */

      document.getElementById("detail").style.display="inline";

      while(m_name.search(" ") > 0){
		m_name = m_name.replace(" ", "_");
	  }
      document.exl_form.contentId.value = id;
      document.exl_form.mname.value = m_name;
      //document.exl_form.sbuId.value = pid;
    }

    function funcDivVisible(){
    	document.getElementById("list").style.display="inline";
   		document.getElementById("detail").style.display="none";
    }

    function onChangeSelect(){
      if (!initCon) return false;

      if(form1.secondPart.options[form1.secondPart.selectedIndex].value==""){
    		return false;
    	}
    	document.getElementById("detail").style.display="none";
		list.listForm.sbuId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.submit();
    }


    function onChangeDate(){
      if (!initCon) return false;

      if(form1.secondPart.options[form1.secondPart.selectedIndex].value==""){
    		return false;
    	}

      list.listForm.sbuId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
      //list.listForm.bscId.value=form1.thirdPart.options[form1.thirdPart.selectedIndex].value;
      list.listForm.defineId.value = detail.detailForm.contentId.value;
    	list.listForm.submit();

    	if(document.getElementById("detail").style.display == "inline"){
          document.getElementById("detail").style.display = "none";
	    }
    }

    function funcStartSetMonth(curMonth) {
    	form1.start_month.options[0] = new Option("1/4분기","03");
    	form1.start_month.options[1] = new Option("2/4분기","06");
    	form1.start_month.options[2] = new Option("3/4분기","09");
    	form1.start_month.options[3] = new Option("4/4분기","12");

    	//form1.start_month.options[0].selected=true;
	    form1.start_month.options[(curMonth/3) - 1].selected=true;
    }

    function funcEndSetMonth(curMonth) {
    	form1.end_month.options[0] = new Option("1/4분기","03");
    	form1.end_month.options[1] = new Option("2/4분기","06");
    	form1.end_month.options[2] = new Option("3/4분기","09");
    	form1.end_month.options[3] = new Option("4/4분기","12");

    	form1.end_month.options[(curMonth/3) - 1].selected=true;
    }

    function closeList(){
    	document.getElementById("list").style.display = "none";
    	document.getElementById("detail").style.display = "none";
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

    function changeBSC() {
    	actionPerformed();
    	funcDivVisible();
    }

    function upLoadFile(){
    var year  = this.form1.year.value;
    var month = this.form1.start_month.value;

		if ("<%=periodvalidate%>" == "N") {
				alert("실적 등록기간이 아닙니다.");
				return;
		}

    	if(exl_form.contentId.value == ""){
    		alert('먼저 지표를 선택하세요.');
    		return;
    	}

    	window.open('<%=imgUri%>/jsp/web/import/taskImportExl.jsp?year='+year+'&month='+month,'','width=450,height=150');
    }

    function downLoadExl(){
    	if(exl_form.contentId.value == ""){
    		alert('먼저 지표를 선택하세요.');
    		return;
    	}
		exl_form.year.value = form1.year.options[form1.year.selectedIndex].value;
		exl_form.month1.value = form1.start_month.options[form1.start_month.selectedIndex].value;
		exl_form.month2.value = form1.start_month.options[form1.start_month.selectedIndex].value;
		exl_form.mode.value = "detail";
    	exl_form.submit();
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
		String bname = ds.getString("BNAME").trim();
		%>
				<script>
				initrs('<%=ds.getInt("BID")%>','<%=bname%>','<%=ds.getInt("BPID")%>',1,<%=i++%>);
				</script>
		<%

		if (parent == firstCode) {
			bscBuf.append("<option value='" + ds.getInt("BID") + "'");
			bscBuf.append(">");
			bscBuf.append(bname);
			bscBuf.append("</option>");
		}
	}

%>
<!------//Page Box//------>
<!---------///본문 컨텐츠 삽입영역 ///--------->
<table width="98%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!------//상단 검색//----->
<table width="98%" border="0" align="center" cellpadding="5"
	cellspacing="1" bgcolor="#c1c1c1">
	<form name="form1" method="post" action="">
	<input type='hidden' name='yyyy'>
	<tr bgcolor="#f6f6f6">
		<td width="14%" align="center" style="height:36px;font-size:13px;background-color:#f6f6f6;"><strong><font color="#333333"> 년 월</font></strong></td>
		<td width="56%" colspan="5" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();" style="height: 24px;">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select>년
			<select name="start_month" onChange="javascript:changefirstMonth();" style="height: 24px;">
	                <script> funcStartSetMonth(<%=curDate.substring(4,6)%>); </script>
             </select>
            <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif"
			alt="확인" onClick="javascript:changeBSC();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle">
        </td>
		<td width="14%" align="center"><strong><font color="#333333" style="height:36px;font-size:13px;background-color:#f6f6f6;"> 엑셀등록</font></strong></td>
        <td width="16%" bgcolor="#FFFFFF">
        <a href="javascript:downLoadExl();"><img src="<%=imgUri%>/jsp/web/images/btn_excel_save.gif" alt="엑셀저장" style="cursor:hand" border="0" align="absmiddle"></a>&nbsp
        <a href="javascript:upLoadFile();"><img src="<%=imgUri%>/jsp/web/images/btn_file_upload.gif" alt="검색" style="cursor:hand" border="0" align="absmiddle"></a>
        </td>
	</form>
	</tr>
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
		<td width="30%">
			<iframe frameborder="0" id="list" src="taskExcelList.jsp?mode=none" style="body" width="100%" height="550">&nbsp;</iframe>
		</td>
		<td>&nbsp;</td>
		<td width="70%">
			<iframe frameborder="0" id="detail" style="display:inline;overflow-x:scroll" src="taskExcelDetail.jsp" style="body" width="100%" height="550">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->
<form name="exl_form" method="get" target="frm_excel" action="<%=imgUri%>/jsp/web/import/taskExportExl.jsp">
	<input type="hidden" name="year">
	<input type="hidden" name="month1">
	<input type="hidden" name="month2">
	<input type="hidden" name="mode">
	<input type="hidden" name="sbuId">
	<input type="hidden" name="contentId">
	<input type="hidden" name="mname">
</form>
<iframe frameborder="0" id="frm_excel" style="display:;overflow-x:scroll" src="" width="100%" height="200"></iframe>
<!-----//Box layout end//----->
</body>
</html>
<% } %>
