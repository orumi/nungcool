<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.cool.AppConfigUtil,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	// �������.
	AppConfigUtil app = new AppConfigUtil();
	String showym = app.getShowYM()!= null?app.getShowYM():Util.getPrevQty(null);	
	String qtr    = showym.substring(0,6);
	String year   = request.getParameter("year") !=null?request.getParameter("year"):qtr.substring(0,4);
	String month  = request.getParameter("month")!=null?request.getParameter("month"):qtr.substring(4,6);
	
	String userId = (String)session.getAttribute("userId");
	
	if (userId == null){ %>
		<script>
			alert("�ٽ� �����Ͽ� �ֽʽÿ�");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<% return; 
	} else {
		String curDate= year + month;
		
		request.setAttribute("curDate",curDate);			
		AdminValuate util = new AdminValuate();
		util.setEvalGroup(request, response);
		
		DataSet dsGrp = (DataSet) request.getAttribute("dsGrp");
		DataSet dsDtl = (DataSet) request.getAttribute("dsDtl");
%>
<SCRIPT>
	var initCon = false;
    function actionPerformed(){
		list.listForm.grpId.value=form1.firstPart.options[form1.firstPart.selectedIndex].value;
		list.listForm.year.value = form1.year.options[form1.year.selectedIndex].value;
		list.listForm.month.value = form1.month.options[form1.month.selectedIndex].value;
		list.listForm.submit();
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
    	form1.month.options[0] = new Option("1/4�б�","03");
    	form1.month.options[1] = new Option("2/4�б�","06");
    	form1.month.options[2] = new Option("3/4�б�","09");
    	form1.month.options[3] = new Option("4/4�б�","12");
    	
    	form1.month.options[(curMonth/3) - 1].selected=true;
    }    
    
    function changeYear(){
      form1.submit();
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
</SCRIPT>
<html>
<head>
<title>::: �������� :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0">

<!------//Page Box//------>
<%
	StringBuffer grpBuf = new StringBuffer();
	
	int treeText = 0;
	int firstCode = 0;
	int i = 0;
	int parent = 0;
	if (dsGrp!=null)
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
			grpBuf.append(">");
			grpBuf.append(name);
			grpBuf.append("</option>");	
			
		}
	}

%>
<!------//Page Box//------>
<!---------///���� ������ ���Կ��� ///--------->
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!------//��� �˻�//----->
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
	<form name="form1" method="post" action="">
	<tr bgcolor="#DCEDF6">
		<td width="14%" align="center"><strong><font color="#006699"> �򰡳��</font></strong></td>
		<td width="86%" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select> ��
             <select name="month" onChange="getEvalDiv()";>
	                <script> funcSetMonth(<%=month%>); </script>
             </select>
        </td>
	</tr>
	<tr bgcolor="#DCEDF6">
		<td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">�׷켱��</font></strong></td>
		<td bgcolor="#FFFFFF">
		<select name="firstPart"  style="width:170;x;" onChange="javascript:closeList()">
        	<%=grpBuf.toString()%>
        </select>
        <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif" alt="Ȯ��" onClick="javascript:actionPerformed();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle"></td>
	</tr>
	</form>
</table>
<!------//��� �˻� ��//----->
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"  id="tblList">
	<tr>
		<td >
			<iframe frameborder="0" id="list" src="adjustValDetail.jsp?mode=none" style="body" width="100%" height="550">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///���� ������ ���Կ���  ��///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>
