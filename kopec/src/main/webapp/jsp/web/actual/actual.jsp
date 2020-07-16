<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
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
<script src="<%=imgUri %>/bootstrap/js/libs/jquery-2.1.1.min.js"></script>

<SCRIPT>
	var initCon = false;
    function actionPerformed(){
    	if(form1.secondPart.options[form1.secondPart.selectedIndex].value==""){
    		alert("두번째 부서를 선택하셔야 합니다");
    		initCon = false;
    		return false;
    	}
    	initCon = true;

    	document.getElementById('list').contentWindow.document.listForm.sbuId.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
    	document.getElementById('list').contentWindow.document.listForm.bscId.value = form1.secondPart.options[form1.secondPart.selectedIndex].value;
    	document.getElementById('list').contentWindow.document.listForm.schDate.value  = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
    	document.getElementById('list').contentWindow.document.listForm.submit();
    }

    function leftReload(){
    	document.getElementById('list').contentWindow.document.listForm.sbuId.value = form1.secondPart.options[form1.secondPart.selectedIndex].value;
    	document.getElementById('list').contentWindow.document.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
    	document.getElementById('list').contentWindow.document.listForm.submit();
    }

    function funcSetDate(curYear) {
      for (i=0,j=curYear-2; i<=5;i++,j++) {
      	 form1.year.options[i] = new Option(j, j);
      }
      form1.year.options[2].selected=true;
      onChangeDate();
    }

    function funcSetMonth(curMonth) {
    	/*
      	for (i=0; i<=11;i++) {
       		 if(i<10) dateCal = "0"+(i + 1);
			 else     dateCal = "" +(i + 1);
      		 form1.month.options[i] = new Option(i+1 , dateCal);
      	}
    	form1.month.options[curMonth - 1].selected=true;
    	*/
    	form1.month.options[0] = new Option("1/4분기","03");
    	form1.month.options[1] = new Option("2/4분기","06");
    	form1.month.options[2] = new Option("3/4분기","09");
    	form1.month.options[3] = new Option("4/4분기","12");

    	form1.month.options[(curMonth/3) - 1].selected=true;
    }


    function changeYear(){
      this.form1.yyyy.value= this.form1.year.value;
      document.getElementById("list").style.display = "none";
      document.getElementById("detail").style.display="none";
      this.form1.submit();
    }

    function changeBSC() {
    	actionPerformed();
    	funcDivVisible();
    }

    function chgOrg(level){
    	var length = arrayOrg.length;

    	if ( level == 1 ){ //change level 1

    		var parentcode = form1.firstPart.options[form1.firstPart.selectedIndex].value;

    		form1.secondPart.length = 0;
    		//form1.thirdPart.length = 0;
    		//form1.thirdPart.options[form1.thirdPart.length] = new Option(" ==== 전 체 ====    ", "");

    		for ( i = 0; i < length; i++ ){
    			if ( arrayOrg[i].levelgb == '1'){
    				if ( arrayOrg[i].parent_cd == parentcode ){
    					form1.secondPart.options[form1.secondPart.length] = new Option(arrayOrg[i].name, arrayOrg[i].code);
    				}
    			}
    		}
    	}
    }

    function openDetail(id){
      document.getElementById('detail').contentWindow.document.detailForm.contentId.value = id;
      document.getElementById('detail').contentWindow.document.detailForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
      document.getElementById('detail').contentWindow.document.detailForm.submit();

      document.getElementById("list").style.display="none";
 	  document.getElementById("detail").style.display="inline";

      var if_list = document.getElementById("list");
      var if_detail = document.getElementById("detail");

      if_detail.style.display="inline";

      if_list.width="0%";
      if_list.height="0%";

	  if_detail.width="100%";
	  if_detail.height="540";
    }

    function funcDivVisible(){
    	document.getElementById("list").style.display="inline";
   		document.getElementById("detail").style.display="none";

	      var if_list = document.getElementById("list");
	      var if_detail = document.getElementById("detail");

	      if_list.width="100%";
	      if_list.height="540";

		  if_detail.width="0%";
		  if_detail.height="0";
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

    function onChangeDate(){
      if (!initCon) return false;

      if(form1.secondPart.options[form1.secondPart.selectedIndex].value==""){
    		return false;
    	}

      changeBSC();
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
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#c1c1c1">
	<form name="form1" method="post" action="">
	<input type='hidden' name='yyyy'>
	<tr bgcolor="#DCEDF6">
		<td width="14%" align="center"><strong><font color="#006699">년월선택</font></strong></td>
		<td width="86%" bgcolor="#f6f6f6">
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select> 년
             <select name="month" onChange="onChangeDate()";>
	                <script> funcSetMonth(<%=curDate.substring(4,6)%>); </script>
             </select>
        </td>
	</tr>
	<tr bgcolor="#DCEDF6">
		<td align="center" bgcolor="#f6f6f6"><strong><font color="#006699">조직선택</font></strong></td>
		<td bgcolor="#FFFFFF">
		<select name="firstPart"  style="width:170;x;" onChange="javascript:chgOrg(1);closeList()">
        	<%=sbuBuf.toString()%>
        </select>
        <select name="secondPart" style="width:170;x;" onChange="javascript:changeBSC()">
        	<%=bscBuf.toString()%>
        </select> <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif"
			alt="확인" onClick="javascript:actionPerformed();funcDivVisible();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle"></td>
	</tr>
	</form>
</table>
<!------//상단 검색 끝//----->
<!-- <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table> -->

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td width="100%">
			<iframe frameborder="0" id="list" src="actList.jsp?mode=none" style="body" width="100%" height="540">&nbsp;</iframe>

			<iframe frameborder="0" id="detail" style="display:inline" src="actDetail.jsp?mode=none" style="body" width="0%" height="0%">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>
