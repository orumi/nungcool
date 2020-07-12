<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	String userId =(String)session.getAttribute("userId");
	
	
	if (userId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {
		String curDate= Util.getPrevMonth(null).substring(0,6);
%>
<SCRIPT>
	var initCon = false;
    function actionPerformed(){
    	list.listForm.year.value = form1.year.options[form1.year.selectedIndex].value;
    	list.listForm.month.value = form1.month.options[form1.month.selectedIndex].value;
    	
		list.listForm.submit();
		
		initCon = true;
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
      onChangeDate();
    }
    
    function changeYear(){
      this.form1.yyyy.value= this.form1.year.value;
      document.getElementById("list").style.display = "none";
      document.getElementById("detail").style.display="none";
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
      detail.detailForm.schDate.value=form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
      detail.detailForm.submit();
      
      document.getElementById("detail").style.display="inline";
      
      var if_list = document.getElementById("list");
      var if_detail = document.getElementById("detail");
      
      if_detail.style.display="inline";

      if_list.width="0%";
      if_list.height="0%";
      
	  if_detail.width="100%";
	  if_detail.height="440";
      
    }
    
    function funcDivVisible(){
    	document.getElementById("list").style.display="inline";
   		document.getElementById("detail").style.display="none";
	      
	      var if_list = document.getElementById("list");
	      var if_detail = document.getElementById("detail");
	      
	      if_list.width="100%";
	      if_list.height="440";
	      
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
      

    	
     	actionPerformed();
     	funcDivVisible();
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

<!---------///본문 컨텐츠 삽입영역 ///--------->
<table width="98%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!------//상단 검색//----->
<table width="98%" border="0" align="center" cellpadding="5"
	cellspacing="1" bgcolor="#A4CBE3">
	<form name="form1" method="post" action="">
	<input type='hidden' name='yyyy'>
	<tr bgcolor="#DCEDF6">
		<td width="14%" align="center"><strong><font color="#006699"> 연 도</font></strong></td>
		<td width="86%" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select>
                    년 
             <select name="month" onChange="onChangeDate()";>
               <%
					String selectHtml2 = "";
					int currMonth = Integer.parseInt(curDate.substring(4,6));
					String dateCal = "";
					for(int j=1;j<=12;j++){
						if(j==(currMonth)) selectHtml2 = "selected";
						else selectHtml2 ="";
						if(j<10) dateCal="0"+(j);
						else dateCal = ""+(j);
						out.println("<option value='"+dateCal+"' "+selectHtml2+">"+dateCal+"</option>");
					}
   				%>
   				<%= currMonth%>
             </select>
                    월 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="<%=imgUri%>/jsp/web/images/btn_ok.gif" alt="확인" onClick="javascript:actionPerformed();funcDivVisible();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle">                    
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
			<iframe frameborder="0" id="list" src="authList.jsp?mode=none" style="body" width="100%" height="440">&nbsp;</iframe>
			<iframe frameborder="0" id="detail" style="display:inline" src="authDetail.jsp?mode=none" style="body" width="0%" height="0%">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>
