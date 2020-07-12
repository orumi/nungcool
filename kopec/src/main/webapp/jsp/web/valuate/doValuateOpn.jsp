<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
	
	String userId = (String)session.getAttribute("userId");
	
	
	if (userId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {
		
		ValuateUtil util = new ValuateUtil();
		util.setEvalGroup(request, response);
		
		DataSet dsGrp = (DataSet) request.getAttribute("dsGrp");
%>
<SCRIPT>
	var initCon = false;
    function actionPerformed(){
    	var frmList = list.form1;
    	frmList.grpId.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
    	frmList.year.value = form1.year.options[form1.year.selectedIndex].value;
    	frmList.submit(); 
    	
    	openDetail01();
    	
    	var frmDetail01 = detail01.form1;
    	frmDetail01.grpId.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
    	frmDetail01.year.value = form1.year.options[form1.year.selectedIndex].value;
    	frmDetail01.submit();
    	
    	var frmDetail02 = detail02.form1;
    	frmDetail02.grpId.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
    	frmDetail02.year.value = form1.year.options[form1.year.selectedIndex].value;
    	frmDetail02.submit();
    	
    }
    
    function changeGroup(){
    	actionPerformed();
    }
    
    function funcSetDate(curYear) {
      for (i=0,j=curYear-2; i<=5;i++,j++) {
      	 form1.year.options[i] = new Option(j, j);
      }
      form1.year.options[2].selected=true;
    }
    
    
    function changeYear(){
      form1.submit();
    }
    
    function openDetail(id){
    }
    
    function showList(){
      document.getElementById("detail01").style.display="inline";
    }
    
    function closeList(){
    }
    

    function onChangeSelect(){
      if (!initCon) return false;
      
		list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		list.listForm.submit();
    }
    
	function getEvalDiv(){
		this.form1.submit();
	}
    
    function sendDetail(){
        detail.detailForm.submit();
        
        alert("실적이 등록되었습니다.");
        list.listForm.defineId.value=detail01.detailForm.contentId.value;
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
    
    
    function openDetail01(){
    	var fList = document.getElementById("detail01");
    	fList.width="100%";
    	fList.height="450";
    	
    	var fDetail = document.getElementById("detail02");
    	fDetail.width="0";
    	fDetail.height="0";
    	
    }
    
    function openDetail02(){
    	var fList = document.getElementById("detail01");
    	fList.width="0";
    	fList.height="0";
    	
    	var fDetail = document.getElementById("detail02");
    	fDetail.width="100%";
    	fDetail.height="450";
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
	
	int firstCode = 0;
	int i = 0;
	if (dsGrp!=null)
	while (dsGrp.next()) {
		
		if (firstCode != dsGrp.getInt("GRPID")){
			firstCode = dsGrp.getInt("GRPID");
			String name = dsGrp.getString("GRPNM").trim();
			%>
				<script>
				initrs('<%=dsGrp.getInt("GRPID")%>','<%=name%>',0,0,<%=i++%>);
				</script>
			<%	
			grpBuf.append("<option value='" + dsGrp.getInt("GRPID") + "'");
			grpBuf.append(">");
			grpBuf.append(name);
			grpBuf.append("</option>");	
			
		}
	}


%>
<!------//Page Box//------>
<!---------///본문 컨텐츠 삽입영역 ///--------->
<table width="98%" border="0" align="center" cellpadding="5"
	cellspacing="1" bgcolor="#A4CBE3">
	<form name="form1" method="post" action="">
	<tr bgcolor="#DCEDF6">
		<td width="14%" align="center"><strong><font color="#006699"> 년도선택</font></strong></td>
		<td width="86%" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=year%>); </script>
            </select>
          </td>
	</tr>
	<tr bgcolor="#DCEDF6">
		<td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">평가 그룹</font></strong></td>
		<td bgcolor="#FFFFFF">
		<select name="firstPart"  style="width:170;x;" onChange="javascript:changeGroup()">
        	<%=grpBuf.toString()%>
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
		<td width="50%" valign="top">
			<iframe frameborder="0" id="list" src="doValuateOpnList.jsp" style="body" width="100%" height="450">&nbsp;</iframe>
		</td>
		<td>&nbsp;</td>
		<td width="48%" valign="top">			
			<iframe frameborder="0" id="detail01" src="doValuateOpnDetail01.jsp" style="body" width="100%" height="450">&nbsp;</iframe>
			<iframe frameborder="0" id="detail02" src="doValuateOpnDetail02.jsp" style="body" width="0" height="450">&nbsp;</iframe>
		</td>		
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>
