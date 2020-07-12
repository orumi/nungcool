<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*,
				 com.nc.cool.AppConfigUtil,				 
			 	 com.nc.cool.PeriodUtil;"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	String strId =(String)session.getAttribute("userId");	

	if (strId == null){ %>
		<script>
			alert("�ٽ� �����Ͽ� �ֽʽÿ�");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%
		return;
	} else {
		
		// �������.
		AppConfigUtil app = new AppConfigUtil();
		String showym = app.getShowYM()!= null?app.getShowYM():Util.getPrevQty(null);	
		String qtr    = showym.substring(0,6);
		String year   = request.getParameter("year") !=null?request.getParameter("year"):qtr.substring(0,4);
		
			
		
		String curDate= showym;
			
		// ���������˻� ���� ===============================================================
		PeriodUtil periodutil = new PeriodUtil();
		String periodvalidate = null;
		String div_cd = "B02";
		String message = "���� ��ϱⰣ�� �ƴմϴ�.";

		year = curDate.substring(0,4);
		periodvalidate = periodutil.validatePeriod(div_cd, year);
		periodvalidate = (periodvalidate == null || "".equals(periodvalidate)) ? "N" : periodvalidate;
		// ���������˻� �� =================================================================			
		
		request.setAttribute("year",year);		
		ActualUtil util = new ActualUtil();
		util.setDivision(request, response);
	
		DataSet ds = (DataSet) request.getAttribute("ds");
		
		
		
		
		
%>
<SCRIPT>
	var initCon = false;
    function actionPerformed(){
    	initCon = true;

    	
		list.listForm.sbuId.value=form1.firstPart.options[form1.firstPart.selectedIndex].value;
		list.listForm.bscId.value=form1.secondPart.options[form1.secondPart.selectedIndex].value;
		list.listForm.year.value  =form1.year.options[form1.year.selectedIndex].value;
		list.listForm.month1.value=form1.start_month.options[form1.start_month.selectedIndex].value;
		list.listForm.month2.value=form1.start_month.options[form1.start_month.selectedIndex].value;
		list.listForm.submit();

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

    function openDetail(id, m_name){
      detail.detailForm.contentId.value = id;
      //detail.detailForm.sbuId.value = pid;
      detail.detailForm.year.value   = form1.year.options[form1.year.selectedIndex].value;
      detail.detailForm.month1.value = form1.start_month.options[form1.start_month.selectedIndex].value;
      detail.detailForm.month2.value = form1.start_month.options[form1.start_month.selectedIndex].value;
      detail.detailForm.mode.value = "detail";
      detail.detailForm.submit();

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
    	form1.start_month.options[0] = new Option("1/4�б�","03");
    	form1.start_month.options[1] = new Option("2/4�б�","06");
    	form1.start_month.options[2] = new Option("3/4�б�","09");
    	form1.start_month.options[3] = new Option("4/4�б�","12");
    	
    	//form1.start_month.options[0].selected=true;   
	    form1.start_month.options[(curMonth/3) - 1].selected=true;       
    }     
    
    function funcEndSetMonth(curMonth) {
    	form1.end_month.options[0] = new Option("1/4�б�","03");
    	form1.end_month.options[1] = new Option("2/4�б�","06");
    	form1.end_month.options[2] = new Option("3/4�б�","09");
    	form1.end_month.options[3] = new Option("4/4�б�","12");
    	
    	form1.end_month.options[(curMonth/3) - 1].selected=true;   
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

    function changeBSC() {
    	actionPerformed();
    	funcDivVisible();
    }

    function upLoadFile(){
    var year  = this.form1.year.value;
    var month = this.form1.start_month.value;

		if ("<%=periodvalidate%>" == "N") {	
				alert("���� ��ϱⰣ�� �ƴմϴ�.");
				return;
		}    
    
    	if(exl_form.contentId.value == ""){
    		alert('���� ��ǥ�� �����ϼ���.');
    		return;
    	}

    	window.open('<%=imgUri%>/jsp/web/import/taskImportExl.jsp?year='+year+'&month='+month,'','width=450,height=150');
    }

    function downLoadExl(){
    	if(exl_form.contentId.value == ""){
    		alert('���� ��ǥ�� �����ϼ���.');
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
<title>::: �������� :::</title>
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
<!---------///���� ������ ���Կ��� ///--------->
<table width="98%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!------//��� �˻�//----->
	<form name="form1" method="post" action="" style="margin: 0px;">
	<input type='hidden' name='yyyy'>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
	<tr bgcolor="#DCEDF6">
		<td width="10%" align="center"><strong><font color="#006699"> �� ��</font></strong></td>
		<td width="40%" bgcolor="#FFFFFF">
			<select name="year" onChange="javascript:changeYear();">
                    <script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
            </select>�� 
			<select name="start_month" onChange="javascript:changefirstMonth();">
	                <script> funcStartSetMonth(<%=curDate.substring(4,6)%>); </script>
             </select>
        </td>
		<td width="10%" align="center"><strong><font color="#006699"> �������</font></strong></td>
        <td width="40%" bgcolor="#FFFFFF">
	        <a href="javascript:downLoadExl();"><img src="<%=imgUri%>/jsp/web/images/btn_excel_save.gif" alt="��������" style="cursor:hand" border="0" align="absmiddle"></a>&nbsp
	        <a href="javascript:upLoadFile();"><img src="<%=imgUri%>/jsp/web/images/btn_file_upload.gif" alt="��������" style="cursor:hand" border="0" align="absmiddle"></a>
        </td>
	</tr>
	<tr bgcolor="#DCEDF6">
		<td align="center" width="10%" bgcolor="#DCEDF6"><strong><font color="#006699">��������</font></strong></td>
		<td bgcolor="#FFFFFF"  colspan="3">
			<select name="firstPart"  style="width:170;" onChange="javascript:chgOrg(1);">
				<option value="%">=== ��ü ===</option>
	        	<%=sbuBuf.toString()%>
	        </select>
	        <select name="secondPart" style="width:170;" onChange="javascript:changeBSC()">
				<option value="%">=== ��ü ===</option>        
	        	<%=bscBuf.toString()%>
	        </select> <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif"
				alt="Ȯ��" onClick="javascript:changeBSC();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle">
		</td>	
	</tr>	
</table>
	</form>
<!------//��� �˻� ��//----->
<table width="98%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td width="30%">
			<iframe frameborder="0" id="list" src="taskExcelDivList.jsp?mode=none" style="body" width="100%" height="550">&nbsp;</iframe>
		</td>
		<td>&nbsp;</td>
		<td width="70%">
			<iframe frameborder="0" id="detail" style="display:inline;overflow-x:scroll" src="taskExcelDivDetail.jsp" style="body" width="100%" height="550">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///���� ������ ���Կ���  ��///--------->
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