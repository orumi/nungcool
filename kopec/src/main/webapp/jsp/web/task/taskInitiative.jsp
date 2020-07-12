<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%@ page import="com.nc.actual.*"%>
<%

    request.setCharacterEncoding("euc-kr");

	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		return;
		
	}
	
	
	//TaskInitiative util = new TaskInitiative();
	//util.setDivision(request, response);



	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	ActualUtil act = new ActualUtil();
	act.setDivision(request, response);
	DataSet dsDiv = (DataSet) request.getAttribute("ds");
	
	String curDate= request.getParameter("year")!=null?request.getParameter("year")+Util.getPrevMonth(null).substring(4,6):Util.getPrevMonth(null).substring(0,6);
	String firstPart= request.getParameter("firstPart");
	String secondPart= request.getParameter("secondPart");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
	<Script Language="javaScript">

	var arrOrg = new Array();

	function initrs(code,name,parent_code,levelgb,i) {
		var rslength = 0;
	       arrOrg[i] = new orgCD(code, name, parent_code, levelgb);
	}

	function orgCD(code, name, parent_cd, levelgb) {
		this.code = code;
		this.name = name;
		this.parent_cd = parent_cd;
		this.levelgb = levelgb;
	}


	function changePBSC() {
		form1.selBSC.length=0;
		form1.selBSC.options[form1.selBSC.length] = new Option('-',-1);
		var length = arrOrg.length;

		var pCode = form1.selPBSC.options[form1.selPBSC.selectedIndex].value;

		for (i=0;i<length;i++) {
			if (arrOrg[i].level==1) {
				if (arrOrg[i].parent==pCode) {
					form1.selBSC.options[form1.selBSC.length] = new Option(arrOrg[i].name,arrOrg[i].code);
				}
			}
		}
	}
	
	function funcSetDate(curYear) {
      for (i=0,j=curYear-2; i<=5;i++,j++) {
      	 form1.year.options[i] = new Option(j, j);
      }
      form1.year.options[2].selected=true;
      
    }
    
     function changeYear(){
      this.form1.yyyy.value= this.form1.year.value;
      this.form1.submit();    
    }
    
    var initCon = false;
	
    function actionPerformed(){
    	if(form1.secondPart.options[form1.secondPart.selectedIndex].value==""){
    		alert("두번째 부서를 선택하셔야 합니다");
    		initCon = false;
    		return false;
    	}
    	initCon = true;
		
		var frm = list.form1;
		
		//frm.sbuId.value = form1.firstPart.options[form1.firstPart.selectedIndex].value;
		frm.bscId.value = form1.secondPart.options[form1.secondPart.selectedIndex].value;
		frm.year.value = form1.year.options[form1.year.selectedIndex].value;
		frm.submit();
		
		detail.location="taskInitDetail.jsp";
    }
    
    function chgOrg(level){ 
    	var length = arrOrg.length;

    	if ( level == 1 ){ //change level 1
    		
    		var parentcode = form1.firstPart.options[form1.firstPart.selectedIndex].value;
    		
    		form1.secondPart.length = 0;
    		//form1.secondPart.options[form1.secondPart.length] = new Option("-- 선택 --", "");
    
    		for ( i = 0; i < length; i++ ){
    			if ( arrOrg[i].levelgb == '1'){
    				if ( arrOrg[i].parent_cd == parentcode ){
    					form1.secondPart.options[form1.secondPart.length] = new Option(arrOrg[i].name, arrOrg[i].code);
    				}
    			}
    		}
    	} 
    }
    
    function changeBSC() {
    	actionPerformed();
    }

//////////////////////////////////////////////////////////////////////////////////

	function openList() {
		form1.txtObj.value="";
		bscId = null;
		objId = null;

		list.form1.pBscId.value = form1.selPBSC.options[form1.selPBSC.selectedIndex].value;
		list.form1.bscId.value = form1.selBSC.options[form1.selBSC.selectedIndex].value;

		list.form1.submit();
	}

////////////////////////////////////////////////////////////////////////////////////


	var arrOrg1 = new Array();

	function initrs1(code,name,parent,level) {
		arrOrg1[arrOrg1.length] = new orgCD1(code,name,parent,level);
	}



	function orgCD1(code,name,parent,level) {
		this.code = code;
		this.name = name;
		this.parent = parent;
		this.level = level;
	}

	function changeType() {
		form1.selProj.length=0;
		var length = arrOrg1.length;
		var typeCode = form1.selType.options[form1.selType.selectedIndex].value;

		var j=0;
		var cid ;
		for(var i=0;i<length;i++){
			if (arrOrg1[i].level==1){
				if (arrOrg1[i].parent ==typeCode){
					form1.selProj.options[form1.selProj.length] = new Option(arrOrg1[i].name,arrOrg1[i].code);
					if(j==0){
						cid = arrOrg1[i].code;
						j++;
					}
				}
			}
		}

		form1.selField.length=0;

		for(var k=0;k<length;k++){
			if (arrOrg1[k].level==2){
				if (arrOrg1[k].parent == cid){
					form1.selField.options[form1.selField.length] = new Option(arrOrg1[k].name,arrOrg1[k].code);
				}
			}
		}

	}


	function changeProj() {
		form1.selField.length=0;
		var length = arrOrg1.length;

		var projCode = form1.selProj.options[form1.selProj.selectedIndex].value;

		for (i=0;i<length;i++) {
			if (arrOrg1[i].level==2) {
				if (arrOrg1[i].parent==projCode) {
					form1.selField.options[form1.selField.length] = new Option(arrOrg1[i].name,arrOrg1[i].code);
				}
			}
		}
	}


	var bscId;
	var objId;
	function getTaskList(){
		if (objId==null){
			alert("전략목표를 선택하십시오");
			return;
		}

		detail.form1.mode.value="G";
		detail.form1.pcId.value=form1.selProj.options[form1.selProj.selectedIndex].value;
		detail.form1.fId.value = form1.selField.options[form1.selField.selectedIndex].value;
		detail.form1.submit();


	}
	
	var refresh = false;
	
</Script>
<%
	StringBuffer sbuBuf = new StringBuffer();
	StringBuffer bscBuf = new StringBuffer();

	int firstCode = 0;
	int i = 0;
	int parent = 0;
	if (dsDiv!=null){
		while (dsDiv.next()) {
			
			if (firstCode != dsDiv.getInt("SID")){
				firstCode = dsDiv.getInt("SID");
				if (i==0) parent = firstCode;
				String name = dsDiv.getString("SNAME").trim();
				%>
					<script>
					initrs('<%=dsDiv.getInt("SID")%>','<%=name%>','<%=dsDiv.getInt("SPID")%>',0,<%=i++%>);
					</script>
				<%	
				sbuBuf.append("<option value='" + dsDiv.getInt("SID") + "'");
				sbuBuf.append(">");
				sbuBuf.append(name);
				sbuBuf.append("</option>");	
				
			}
			String bname = dsDiv.getString("BNAME").trim();
			%>
					<script>
					initrs('<%=dsDiv.getInt("BID")%>','<%=bname%>','<%=dsDiv.getInt("BPID")%>',1,<%=i++%>);
					</script>
			<%		
	
			if (parent == firstCode) {
				bscBuf.append("<option value='" + dsDiv.getInt("BID") + "'");
				bscBuf.append(">");
				bscBuf.append(bname);
				bscBuf.append("</option>");
			} 
		}
	}
%>
<body>
<form name="form1" method="post" action="">
	<input type='hidden' name='yyyy'>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
	<tr bgcolor="#D4DCF4">
	<td width="80" align="center"><strong><font color="#003399">연도</font></strong></td>
	<td align=left bgcolor="#FFFFFF">
		<select name="year" onChange="javascript:changeYear();">
           	<script> funcSetDate(<%=curDate.substring(0,4)%>); </script>
           </select>
               년 </td>
  </tr>
  <tr bgcolor="#D4DCF4">
     <td width="80" align="center"><strong><font color="#003399">부서</font></strong></td>
     <td align=left bgcolor="#FFFFFF">
        <select name="firstPart"  style="width:150;x;" onChange="javascript:chgOrg(1);">
        	<%=sbuBuf.toString()%>
        </select>
        <select name="secondPart" style="width:170;x;" onChange="javascript:changeBSC();">
        	<%=bscBuf.toString()%>
        </select> <img src="<%=imgUri%>/jsp/web/images/btn_ok.gif"
			alt="확인" onClick="javascript:actionPerformed();" style="cursor:hand" width="50" height="20" border="0" align="absmiddle">
	</td>
  </tr>
</table>
	<table width="98%" align="center" height="90%">
	<tr>
		<td valing="top" align="left" width="60%">
	 		<iframe frameborder="0" id="list" src="taskInitList.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
	 	</td>
		 <td valing="top" colspan="2" width="40%">
		 	<iframe frameborder="0" id="detail" src="taskInitDetail.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
		 </td>
	 </tr>
	</table>
</form>
</body>
</html>