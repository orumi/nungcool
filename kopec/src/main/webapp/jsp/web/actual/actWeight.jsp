<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	ActualUtil util = new ActualUtil();
	util.setDivision(request, response);

	String strId = (String)session.getAttribute("userId");


	if (strId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {
		String curDate= request.getParameter("year")!=null?request.getParameter("year")+Util.getToDay().substring(4,6):Util.getToDay().substring(0,6);
		DataSet ds = (DataSet) request.getAttribute("ds");
%>

<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
<script src="<%=imgUri%>/bootstrap/js/libs/jquery-2.1.1.min.js"></script>
<script src="<%=imgUri%>/bootstrap/js/libs/jquery-ui-1.10.3.min.js"></script>


<SCRIPT>
	var initCon = false;
    function actionPerformed(){
    	if(form1.secondPart.options[form1.secondPart.selectedIndex].value==""){
    		alert("두번째 부서를 선택하셔야 합니다");
    		initCon = false;
    		return false;
    	}
    	initCon = true;

    	$("#list").contents().find("input[name=sbuId]").val(form1.firstPart.options[form1.firstPart.selectedIndex].value);
    	$("#list").contents().find("input[name=bscId]").val(form1.secondPart.options[form1.secondPart.selectedIndex].value);
    	$("#list").contents().find("input[name=schDate]").val(form1.year.options[form1.year.selectedIndex].value);

    	$("#list").contents().find("form[name=listForm]").submit();

    	/* list.listForm.sbuId.value=form1.firstPart.options[form1.firstPart.selectedIndex].value;
		list.listForm.bscId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.schDate.value=form1.year.options[form1.year.selectedIndex].value; */
		//list.listForm.submit();
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
      this.form1.submit();
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
      detail.detailForm.contentId.value=id;
      detail.detailForm.schDate.value = form1.year.options[form1.year.selectedIndex].value;
      detail.detailForm.submit();
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

    }

    function closeList(){
    	document.getElementById("list").style.display = "none";

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
		<td width="14%" align="center" style="height:36px;font-size:13px;background-color:#f6f6f6;"><strong><font color="#333333">평가년도</font></strong></td>
		<td width="86%" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();" style="height: 24px;">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select>
                    년
             </td>
	</tr>
	<tr bgcolor="#DCEDF6">
		<td align="center" style="height:36px;font-size:13px;background-color:#f6f6f6;"><strong><font color="#333333">조직선택</font></strong></td>
		<td bgcolor="#FFFFFF"><select name="firstPart"  style="width:170;height: 24px;" onChange="javascript:chgOrg(1);closeList()">
        	<%=sbuBuf.toString()%>
        </select>
        <select name="secondPart" style="width:170;height: 24px;" onChange="javascript:closeList()">
        	<%=bscBuf.toString()%>
        </select> <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif"
			alt="확인" onClick="javascript:actionPerformed();funcDivVisible();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle"></td>
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
		<td>
			<iframe frameborder="0" id="list" src="actWeightList.jsp" style="body" width="100%" height="480">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>
