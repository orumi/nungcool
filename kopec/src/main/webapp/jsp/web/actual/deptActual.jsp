<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.cool.*,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
//	String qtr    = Util.getPrevQty(null);	// �б�ó�� 
//	String qtr    = Util.getPrevMonth(null);
//	String year   = request.getParameter("year") !=null?request.getParameter("year"):qtr.substring(0,4);

	// �������.
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
			alert("�ٽ� �����Ͽ� �ֽʽÿ�");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {
		String curDate= request.getParameter("year")!=null?request.getParameter("year")+qtr.substring(4,6):qtr.substring(0,6);
		DataSet ds = (DataSet) request.getAttribute("ds");
%>
<SCRIPT>
	var initCon = false;
    function actionPerformed(){
    	if(form1.secondPart.options[form1.secondPart.selectedIndex].value==""){
    		alert("�ι�° �μ��� �����ϼž� �մϴ�");
    		initCon = false;
    		return false;
    	}
    	initCon = true;

		list.listForm.sbuId.value   = form1.firstPart.options[form1.firstPart.selectedIndex].value;
		list.listForm.bscId.value   = form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
    	list.listForm.year.value    = form1.year.options[form1.year.selectedIndex].value;
    	list.listForm.month.value   = form1.month.options[form1.month.selectedIndex].value;

		list.listForm.submit();
    }
    
    function leftReload(){
		list.listForm.sbuId.value   = form1.firstPart.options[form1.firstPart.selectedIndex].value;
		list.listForm.bscId.value   = form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
    	list.listForm.year.value    = form1.year.options[form1.year.selectedIndex].value;
    	list.listForm.month.value   = form1.month.options[form1.month.selectedIndex].value;
			
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
    	form1.month.options[0] = new Option("1/4�б�","03");
    	form1.month.options[1] = new Option("2/4�б�","06");
    	form1.month.options[2] = new Option("3/4�б�","09");
    	form1.month.options[3] = new Option("4/4�б�","12");
    	
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
    		form1.secondPart.options[form1.secondPart.length] = new Option(" ==== �� ü ====    ", "%");
    
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
      
      var if_list   = document.getElementById("list");
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

    	list.listForm.year.value    = form1.year.options[form1.year.selectedIndex].value;
    	list.listForm.month.value   = form1.month.options[form1.month.selectedIndex].value;
		list.listForm.schDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;

    	list.listForm.sbuId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.bscId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
   		list.listForm.submit();
    }
    
    function onChangeDate(){
      if (!initCon) {
      	return false;
      }
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
        
        alert("������ ��ϵǾ����ϴ�.");
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
    
    // ������ �ε��
    function init() {
   		form1.firstPart.length = 0;
   		form1.firstPart.options[0] = new Option("=== ��ü ===","%");
    }    
</SCRIPT>
<html>
<head>
<title>::: �������� :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" scroll="no" >

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
<!---------///���� ������ ���Կ��� ///--------->
<table width="98%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!------//��� �˻�//----->
<table width="98%" border="0" align="center" cellpadding="5"
	cellspacing="1" bgcolor="#A4CBE3">
	<form name="form1" method="post" action="">
	<input type='hidden' name='yyyy'>

	<tr bgcolor="#DCEDF6">
		<td width="14%" align="center"><strong><font color="#006699">�������</font></strong></td>
		<td width="86%" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select>
                    �� 
             <select name="month" onChange="onChangeDate()";>
	                <script> funcSetMonth(<%=curDate.substring(4,6)%>); </script>
             </select>&nbsp;&nbsp;&nbsp;
        </td>
	</tr>
	<tr bgcolor="#DCEDF6">
		<td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">��������</font></strong></td>
		<td bgcolor="#FFFFFF">
		<select name="firstPart"  style="width:170;x;" onChange="javascript:chgOrg(1);closeList()">
			<option value="%">=== ��ü ===</option>
        	<%=sbuBuf.toString()%>
        </select>
        <select name="secondPart" style="width:170;x;" onChange="javascript:changeBSC()">
			<option value="%">=== ��ü ===</option>        
        	<%=bscBuf.toString()%>
        </select> <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif"
			alt="Ȯ��" onClick="javascript:actionPerformed();funcDivVisible();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle"></td>
	</tr>
	</form>	
</table>
<!------//��� �˻� ��//----->
<table width="98%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td width="100%">
			<iframe frameborder="0" id="list" src="deptActList.jsp?mode=none" style="body" width="100%" height="440">&nbsp;</iframe>
			<iframe frameborder="0" id="detail" style="display:inline" src="deptActDetail.jsp?mode=none" style="body" width="0%" height="0%">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///���� ������ ���Կ���  ��///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>