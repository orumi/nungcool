<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.*"%>
<%@ page import="com.nc.util.StrConvert"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.lang.String"%>
<%

	StringBuffer optUser = new StringBuffer();
	StringBuffer deptC = new StringBuffer();

	String userId = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(userId.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	
	request.setCharacterEncoding("euc-kr");

	TaskAdmin ta = new TaskAdmin();

	ta.getDetailExe(request, response);
	
	
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	
	DataSet detail = (DataSet)request.getAttribute("ds");
    DataSet dsUser = (DataSet)request.getAttribute("dsUser");
    DataSet dept = (DataSet)request.getAttribute("dept");
    
    String execWork = "";
    String sYear = Util.getToDay().substring(0,4);
    String eYear = Util.getToDay().substring(0,4);
    String sQTR = "1";
    String eQTR = "4";
    String dName = "";
    String goalLev ="";
    String mainDesc = "";
    String drvMthd = "";
    String errcnsdr = "";
    String stepid="1";
    String mgr = "";
    
    
    
    String pid = request.getParameter("pid");
    String did = request.getParameter("did");
	
    String sid = request.getParameter("sid");
    String typeid = request.getParameter("typeid");
    String deptid = request.getParameter("deptid");
//    out.println(deptid);

    
    
    String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";

    if (detail!=null)
    	while(detail.next()){
    		execWork = detail.getString("EXECWORK");
    		sYear = detail.isEmpty("SYEAR")?"":detail.getString("SYEAR");
    		eYear = detail.isEmpty("EYEAR")?"":detail.getString("EYEAR");
    		sQTR = detail.isEmpty("SQTR")?"":detail.getString("SQTR");
    		eQTR = detail.isEmpty("EQTR")?"":detail.getString("EQTR");
    		dName = detail.isEmpty("DNAME")?"":detail.getString("DNAME");
    		goalLev = detail.isEmpty("GOALLEV")?"":detail.getString("GOALLEV");
    		mainDesc = detail.isEmpty("MAINDESC")?"":detail.getString("MAINDESC");
    		drvMthd = detail.isEmpty("DRVMTHD")?"":detail.getString("DRVMTHD");
    		errcnsdr = detail.isEmpty("ERRCNSDR")?"":detail.getString("ERRCNSDR");
    		stepid = detail.getString("STEPID");
    		mgr = detail.getString("MGRUSER");
    		
    	}
	if(dept != null)
	{
		deptC.append("<option value='-1' selected>부서선택</option>")	;
		while(dept.next())
		{
			deptC.append("<option value='"+dept.getString("id")+"'>"+dept.getString("name")+"</option>")	;
		}
	}
		

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<%if(typeid.equals("2")) {%>
<title>추진계획 상세정보</title>
<%}	else {
 
	out.print("<title>실행계획 상세정보</title>");
}
%>
</head>
<script>
	function addExecWork() 
	{
	
	
		if (form1.execWork.value==""){
			alert("실행계획명을 기술하십시오");
			return;
		}
		if (parseInt(form1.sYear.value) > parseInt(form1.eYear.value)) {
		 	alert("실행년도 시작년도가 끝나는 년도 보다 클수 없습니다.");
		 	return;
		}
		
		if(parseInt(form1.sYear.value) == parseInt(form1.eYear.value))  
		{
//		 	if(parseInt(form1.selsQtr.value) == parseInt(form1.seleQtr.value)) {
//		 		alert("같은 년도 안에서는 분기도 같을수는 없습니다.");
//		 		return;
//			}
		 	if(parseInt(form1.selsQtr.value) > parseInt(form1.seleQtr.value)) {
		 		alert("시작 분기가 클수는 없습니다.");
		 		return;
		 	}
		 }
		 
		 if (form1._mgrdept_I.value == ""){
		 	alert("주관부서를 선택하십시오");
		 	return;
		 }
			 var frm=opener.form5;
			 frm.mode.value = form1.mode.value;
			 frm.execWork.value = form1.execWork.value;
			 frm.pid.value=form1.pid.value;
			 frm.did.value=form1.did.value;
			 frm.sid.value=form1.selStep.options[form1.selStep.selectedIndex].value;
			 frm.sYear.value=form1.sYear.options[form1.sYear.selectedIndex].value;
			 frm.sQtr.value=form1.selsQtr.options[form1.selsQtr.selectedIndex].value;
			 frm.eYear.value=form1.eYear.options[form1.eYear.selectedIndex].value;
			 frm.eQtr.value=form1.seleQtr.options[form1.seleQtr.selectedIndex].value;
			 frm.mgr.value=form1.deptcd.value;
			 frm.goalLev.value = form1.goalLev.value;
			 frm.mainDesc.value = form1.mainDesc.value;
			 frm.drvMthd.value = form1.drvMthd.value;
			 frm.errcnsdr.value = form1.errcnsdr.value;
			 frm.typeid.value = <%=typeid%>;
			 
//			 alert(form1.deptcd.value);
			 
			 frm.submit();
			 window.close();
	}
	function changeStep()
	{
		    var step = form1.selStep.options[form1.selStep.selectedIndex].value;
		    var sYear=0;
		    var eYear=0;
		    if (step==1){
		    	sYear=2007;
		    	eYear=2011;
		    } else if (step==2){
		    	sYear=2012;
		    	eYear=2016;
		    } else if (step==3){
		    	sYear=2017;
		    	eYear=2020;
		    }
		    form1.sYear.length = 0;
		    form1.eYear.length = 0;
		    form1.selsQtr.value=1;
		    form1.seleQtr.value=1;
		    for ( i = sYear; i <= eYear; i++ ){
    			form1.sYear.options[form1.sYear.length] = new Option(i,i);
    			form1.eYear.options[form1.eYear.length] = new Option(i,i);
    		}
	}
	
	function changeDept()
	{
		
		form1._mgrdept_I.value = form1.dept.options[form1.dept.selectedIndex].text;
		form1.deptcd.value = form1.dept.options[form1.dept.selectedIndex].value;
	}

//    function openExecWord(did) 
//   {
//		if('<%=tag%>' == 'G')
//		{
//   		var exeWin;
//			var url = "taskAdmin_Pc.jsp?syear="+<%=sYear%>+"&eyear="+<%=eYear%>+"&did="+did+"&sqtr="+<%=sQTR%>+"&eqtr="+<%=eQTR%>;
//		    exeWin = window.open(url, '세부실행과제추가', 'toolbar=yes,Width=600px,Height=650px,scroll=yes,resizable=no,menubar=no,help=no,status=no');
//		    exeWin.focus();
//		}
//	}

</script>
<body>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">

            <!------//프로젝트 입력 //---->
            <form name="form1" method="post" action="">
            <input type="hidden" name="mode" value="<%=tag.equals("G")?"U":"C" %>">
            <input type="hidden" name="pid" value="<%=pid %>">
            <input type="hidden" name="did" value="<%=did %>">
            <input type="hidden" name="sid" value="<%=sid %>">
            <input type="hidden" name="deptcd" value="<%=deptid %>">
            
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
		                  실행계획(추진계획) 세부사항</strong></td>
              </tr>
            </table>
			<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">단계</font></strong></td>
                <td width="46%">
                    <select name="selStep" onchange="changeStep();">
                    	<option value=1 <%=(stepid.equals("1")?"selected":"") %>>1 단계</option>
                    	<option value=2 <%=(stepid.equals("2")?"selected":"") %>>2 단계</option>
                    	<option value=3 <%=(stepid.equals("3")?"selected":"") %>>3 단계</option>
                    </select>
                </td>
              </tr>			
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">실행계획</font></strong></td>
                <td width="46%">
                    <input name="execWork" type="text" class="input_box" size="60" value="<%=execWork%>">
                  <strong></strong></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진기간</font></strong></td>
                <td width="46%">
		            <select name="sYear" style="width:60px;"> 
<%						if(stepid.equals("1")) {
							for(int i = 2007; i <= 2011; i++) {
								if(sYear != null && sYear != "") {
									if(Integer.parseInt(sYear) == i) {
										out.println("<option value=" + i + " selected>" + i + "</option>");
									} else {
										out.println("<option value=" + i + ">" + i + "</option>");									
									}
								} else {
									out.println("<option value=" + i + ">" + i + "</option>");	
								}
							}
						} else if(stepid.equals("2")) {
							for(int i = 2012; i <= 2016; i++) {
								if(sYear != null && sYear != "") {
									if(Integer.parseInt(sYear) == i) {
										out.println("<option value=" + i + " selected>" + i + "</option>");
									} else {
										out.println("<option value=" + i + ">" + i + "</option>");									
									}
								} else {
									out.println("<option value=" + i + ">" + i + "</option>");	
								}
							}
						} else if(stepid.equals("3")) {
							for(int i = 2017; i <= 2020; i++) {
								if(sYear != null && sYear != "") {
									if(Integer.parseInt(sYear) == i) {
										out.println("<option value=" + i + " selected>" + i + "</option>");
									} else {
										out.println("<option value=" + i + ">" + i + "</option>");									
									}
								} else {
									out.println("<option value=" + i + ">" + i + "</option>");	
								}
							}
						}
%>
					</select>
  	     		    년&nbsp;&nbsp;
	     		    <select name="selsQtr" style="width:55px;">
<%
						if(sQTR != null && sQTR != "") {
							switch(Integer.parseInt(sQTR)) {
								case 1 : out.println("<option value='1' selected>1분기</option>");
									     out.println("<option value='2' >2분기</option>");
									     out.println("<option value='3' >3분기</option>");
									     out.println("<option value='4' >4분기</option>");
									     break;
								case 2 : out.println("<option value='1' >1분기</option>");
		  								 out.println("<option value='2' selected>2분기</option>");
		  								 out.println("<option value='3' >3분기</option>");
		  								 out.println("<option value='4' >4분기</option>");
		  								 break;

								case 3 : out.println("<option value='1' >1분기</option>");
		  								 out.println("<option value='2' >2분기</option>");
		  								 out.println("<option value='3' selected>3분기</option>");
		  								 out.println("<option value='4' >4분기</option>");
		  								 break;

								case 4 : out.println("<option value='1' >1분기</option>");
										 out.println("<option value='2' >2분기</option>");
										 out.println("<option value='3' >3분기</option>");
										 out.println("<option value='4' selected>4분기</option>");
										 break;
							}
						} else {
%>
	     		                        <option value="1">1분기</option>
	     		                        <option value="2">2분기</option>
	     		                        <option value="3">3분기</option>
	     		                        <option value="4">4분기</option>
<%
						}
%>
	     		      </select>
	     		      &nbsp;&nbsp; ~ &nbsp;&nbsp;
					<select name="eYear" style="width:60px;"> 
<%						if(stepid.equals("1")) {
							for(int i = 2007; i <= 2011; i++) {
								if(eYear != null && eYear != "") {
									if(Integer.parseInt(eYear) == i) {
										out.println("<option value=" + i + " selected>" + i + "</option>");
									} else {
										out.println("<option value=" + i + ">" + i + "</option>");									
									}
								} else {
									out.println("<option value=" + i + ">" + i + "</option>");	
								}
							}
						} else if(stepid.equals("2")) {
							for(int i = 2012; i <= 2016; i++) {
								if(eYear != null && eYear != "") {
									if(Integer.parseInt(eYear) == i) {
										out.println("<option value=" + i + " selected>" + i + "</option>");
									} else {
										out.println("<option value=" + i + ">" + i + "</option>");									
									}
								} else {
									out.println("<option value=" + i + ">" + i + "</option>");	
								}
							}
						} else if(stepid.equals("3")) {
							for(int i = 2017; i <= 2020; i++) {
								if(eYear != null && eYear != "") {
									if(Integer.parseInt(eYear) == i) {
										out.println("<option value=" + i + " selected>" + i + "</option>");
									} else {
										out.println("<option value=" + i + ">" + i + "</option>");									
									}
								} else {
									out.println("<option value=" + i + ">" + i + "</option>");	
								}
							}
						}
%>
					</select>
  	     		    년&nbsp;&nbsp;
	     		    <select name="seleQtr" style="width:55px;">
<%
						if(eQTR != null && eQTR != "") {
							switch(Integer.parseInt(eQTR)) {
								case 1 : out.println("<option value='1' selected>1분기</option>");
									     out.println("<option value='2' >2분기</option>");
									     out.println("<option value='3' >3분기</option>");
									     out.println("<option value='4' >4분기</option>");
									     break;
								case 2 : out.println("<option value='1' >1분기</option>");
		  								 out.println("<option value='2' selected>2분기</option>");
		  								 out.println("<option value='3' >3분기</option>");
		  								 out.println("<option value='4' >4분기</option>");
		  								 break;

								case 3 : out.println("<option value='1' >1분기</option>");
		  								 out.println("<option value='2' >2분기</option>");
		  								 out.println("<option value='3' selected>3분기</option>");
		  								 out.println("<option value='4' >4분기</option>");
		  								 break;

								case 4 : out.println("<option value='1' >1분기</option>");
										 out.println("<option value='2' >2분기</option>");
										 out.println("<option value='3' >3분기</option>");
										 out.println("<option value='4' selected>4분기</option>");
										 break;
							}
						} else {
%>
	     		                        <option value="1">1분기</option>
	     		                        <option value="2">2분기</option>
	     		                        <option value="3">3분기</option>
	     		                        <option value="4">4분기</option>
<%
						}
%>
	     		      </select>	     		      
                 </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주관부서</font></strong></td>
                <td width="46%">
                    <input type="text" name="_mgrdept_I" class="input_box" size="30" value="<%=dName %>" readonly="true">
                 		 <select name="dept" style="width:150px;" onChange="changeDept()">
	                     <%=deptC.toString() %>
	                     </select>
                 </td>
                 
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">목표수준</font></strong></td>
                <td width="46% colspan="3">
                    <textarea name="goalLev" cols="63" rows="3" class="textarea_box" disable="true"><%=goalLev%></textarea>
                 </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주요내용</font></strong></td>
                <td width="46% colspan="3">
                    <textarea name="mainDesc" cols="63" rows="5" class="textarea_box" disable="true"><%=mainDesc%></textarea>
                 </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진방안</font></strong></td>
                <td width="46% colspan="3">
                    <textarea name="drvMthd" cols="63" rows="15" class="textarea_box" disable="true"><%=drvMthd%></textarea>
                 </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">장애요인 또는 고려사항</font></strong></td>
                <td width="46% colspan="3">
                    <textarea name="errcnsdr" cols="63" rows="3" class="textarea_box" disable="true"><%=errcnsdr%></textarea>
                 </td>
              </tr>                                          
            </table>
            <table width="90%" border="0" align="center" cellpadding="5" cellspacing="1">
              <tr>
                <td align="right"><a href="javascript:addExecWork();"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;</td>
              </tr>
            </table>
            </form>
</body>
</html>