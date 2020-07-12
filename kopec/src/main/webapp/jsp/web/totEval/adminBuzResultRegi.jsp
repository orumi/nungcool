<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.totEval.*,
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
		
%>
<SCRIPT>
	var initCon = false;
    function actionPerformed(){
		list.listFrm.year.value = form1.year.options[form1.year.selectedIndex].value;
		list.listFrm.submit();
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
    	form1.month.options[0] = new Option("03","03");
    	form1.month.options[1] = new Option("06","06");
    	form1.month.options[2] = new Option("09","09");
    	form1.month.options[3] = new Option("12","12");
    	
    	form1.month.options[(curMonth/3) - 1].selected=true;
    }
    
    function changeYear(){

    }
    
    function changeMonth() {
      document.getElementById("list").style.display="none";
      form1.firstPart.length = 0;
      form1.secondPart.length = 0; 
    
    }
    
    function chgOrg(level){ 
    	var length = arrayOrg.length;

    	if ( level == 1 ){ //change level 1
    		
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
		list.listForm.sbuId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		list.listForm.submit();
    }
    
	function getEvalDiv(){
		this.form1.submit();
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
	<tr bgcolor="#DCEDF6">
		<td width="14%" align="center"><strong><font color="#006699"> 해당일자</font></strong></td>
		<td width="200" bgcolor="#FFFFFF">
			&nbsp;
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=year%>); </script>
            </select>
			년  &nbsp;&nbsp;
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
		<td width="100%">
			<iframe frameborder="0" id="list" src="adminBuzResultRegiList.jsp" style="body" width="100%" height="350">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>
