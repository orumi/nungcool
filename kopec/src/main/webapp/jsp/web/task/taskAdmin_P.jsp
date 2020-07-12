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
	StringBuffer optDept = new StringBuffer();
	StringBuffer stopY = new StringBuffer();
	StringBuffer stopQ = new StringBuffer();
	StringBuffer stopDiv = new StringBuffer();

	String userId = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(userId.equals(""))
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		return;
	}

	TaskAdmin ta = new TaskAdmin();
	ta.getDetailExe(request, response);


	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));


	DataSet detail = (DataSet)request.getAttribute("ds");
    DataSet dsUser = (DataSet)request.getAttribute("dsUser");
    DataSet dept = (DataSet)request.getAttribute("dept");

	String curYear = Util.getToDay().substring(0,4);
	int curMonth = Integer.parseInt(Util.getToDay().substring(5,6));
	int curQtr;
	if(curMonth >= 1 && curMonth <= 3)
		curQtr = 1;
	else if(curMonth >= 4 && curMonth <= 6)
		curQtr = 2;
	else if(curMonth >= 7 && curMonth <= 9)
		curQtr = 3;
	else
		curQtr = 4;



    String execWork = "";
    String sYear = Util.getToDay().substring(0,4);
    String eYear = Util.getToDay().substring(0,4);
    String sQTR = "1";
    String eQTR = "4";
    String dName = "";
    String define ="";
    String drvgoal = "";
    String mgr = "";
    String budget = "";
    String manhour = "";
    String mng_no = "";
    String link = "";


    String pid = request.getParameter("projectId");
    String did = request.getParameter("detailId");

    String stopYear = "";
    String stopQtr = "";
    String stopYN = "";

    String tag = request.getParameter("tag")!=null?request.getParameter("tag"):"";

    if (detail!=null)
    	while(detail.next()){
    		execWork = detail.getString("EXECWORK");
    		sYear = detail.isEmpty("SYEAR")?"":detail.getString("SYEAR");
    		eYear = detail.isEmpty("EYEAR")?"":detail.getString("EYEAR");
    		sQTR = detail.isEmpty("SQTR")?"":detail.getString("SQTR");
    		eQTR = detail.isEmpty("EQTR")?"":detail.getString("EQTR");
    		dName = detail.isEmpty("DNAME")?"":detail.getString("DNAME");
    		mgr = detail.getString("MGRUSER");
			define = detail.isEmpty("DEFINE")?"":detail.getString("DEFINE");
			drvgoal = detail.isEmpty("DRVGOAL")?"":detail.getString("DRVGOAL");
			stopYN = detail.isEmpty("STOPYN")?"":detail.getString("STOPYN");
			
			budget = detail.isEmpty("BUDGET")?"":detail.getString("BUDGET");
			manhour = detail.isEmpty("MANHOUR")?"":detail.getString("MANHOUR");
			mng_no = detail.isEmpty("MNG_NO")?"":detail.getString("MNG_NO");
			link = detail.isEmpty("LINKURL")?"":(detail.getString("LINKURL")==null?"":detail.getString("LINKURL"));
			
			if(stopYN.equals("Y"))
			{
				stopDiv.append("<option value='Y' selected>중단</option>");
				stopDiv.append("<option value='N' >추진중</option>");
			}
			else
			{
				stopDiv.append("<option value='N' selected>추진중</option>");
				stopDiv.append("<option value='Y' >중단</option>");
			}
    	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>추진계획 상세정보</title>

</head>
<script>
	function addExecWork() {
		if (form1.execWork.value==""){
			alert("과제명을 기술하십시오");
			return;
		}
		if (parseInt(form1.sYear.value) > parseInt(form1.eYear.value)) {
		 	alert("추진년도 시작년도가 끝나는 년도 보다 클수 없습니다.");
		 	return;
		}
		if(parseInt(form1.sYear.value) == parseInt(form1.eYear.value))
		{
		 	if(parseInt(form1.selsQtr.value) > parseInt(form1.seleQtr.value)) {
		 		alert("시작 분기가 클수는 없습니다.");
		 		return;
		 	}
		 }

		 if (form1.selUser.selectedIndex==-1){
		 	alert("사용자를 선택하십시오");
		 	return;
		 }
			 var frm=opener.form1;
			 frm.mode.value = form1.mode.value;
			 frm.execWork.value = form1.execWork.value;
			 frm.projectId.value=form1.pid.value;
			 frm.detailId.value=form1.did.value;
			 frm.sYear.value=form1.sYear.options[form1.sYear.selectedIndex].value;
			 frm.sQtr.value=form1.selsQtr.options[form1.selsQtr.selectedIndex].value;
			 frm.eYear.value=form1.eYear.options[form1.eYear.selectedIndex].value;
			 frm.eQtr.value=form1.seleQtr.options[form1.seleQtr.selectedIndex].value;
			 frm.mgr.value=form1.selUser.options[form1.selUser.selectedIndex].value;
			 frm.dept.value=form1._mgrdept_I.options[form1._mgrdept_I.selectedIndex].value;
			 frm.define.value = form1.define.value;
			 frm.drvgoal.value = form1.drvgoal.value;
			 frm.budget.value = form1.budget.value;
			 frm.manhour.value = form1.manhour.value;
			 frm.mng_no.value = form1.mng_no.value;
			 frm.link.value = form1.link.value;

			 frm.submit();
			 //window.close();
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



    function openExecWord()
    {
		var detailid = <%=did%>;
		var url = "taskAdminAchv_P.jsp?detailid="+detailid+"&typeid=2";
	    exeWin = window.open(url, '계획등록', 'toolbar=yes,Width=400px,Height=500px,scroll=yes,resizable=no,menubar:yes,help=no,status=yes');
	    exeWin.focus();
	}

</script>
<body>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">

            <!------//프로젝트 입력 //---->
            <form name="form1" method="post" action="">
            <input type="hidden" name="mode" value="<%=tag.equals("G")?"U":"C" %>">
            <input type="hidden" name="pid" value="<%=pid %>">
            <input type="hidden" name="did" value="<%=did %>">


			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
		         	과제 등록</strong></td>
              </tr>
            </table>
			<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">

              <tr bgcolor="#FFFFFF">
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">과제명</font></strong></td>
                <td width="83%" colspan="3">
                    <input name="execWork" type="text" class="input_box" size="70" value="<%=execWork%>">
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진기간</font></strong></td>
                <td width="83%" colspan="3">
		            <select name="sYear" style="width:60px;">
<%
							for(int i = 2007; i <= 2015; i++) {
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
%>
					</select>
  	     		    년&nbsp;
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
<%						
							for(int i = 2007; i <= 2015; i++) {
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
%>
					</select>
  	     		    년&nbsp;
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
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">관리번호<br/>(연도)</font></strong></td>
                <td width="83%" colspan="3">
                    <input type="text" name="mng_no" class="input_box" size="30" value="<%=mng_no %>">
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
              	<td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주관부서</font></strong></td>
                <td width="33%">
                    <select name="_mgrdept_I" style="width:150px;" >
<%
      while(dept.next()) {
            if(dept.getString("ID").equals(dName)) {
                  optDept.append("<option value='" + dept.getString("ID") + "' selected>" +dept.getString("NAME")+"</option>" + "\n");
            } else  {
            	optDept.append("<option value='"+dept.getString("ID") +"'>"+dept.getString("NAME")+"</option>" + "\n");
            }
      }
%>
                        <%=optDept.toString()%>
                    </select>
                </td>
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">과제책임자</font></strong></td>
                <td width="33%">
                    <select name="selUser" style="width:150px;" >
<%
      while(dsUser.next()) {
            if(dsUser.getString("userid").equals(mgr)) {
                  optUser.append("<option value='" + dsUser.getString("userid") + "' selected>" +dsUser.getString("username")+"   ("+dsUser.getString("USERID")+")"+(dsUser.isEmpty("DNAME")?"":"  -"+dsUser.getString("DNAME")+"  ") + "</option>" + "\n");
            } else  {
                  optUser.append("<option value='"+dsUser.getString("userid")  +"'>"+dsUser.getString("username")+"   ("+dsUser.getString("USERID")+")"+(dsUser.isEmpty("DNAME")?"":"  -"+dsUser.getString("DNAME")+"  ") +"</option>" + "\n");
            }
      }
%>
                        <%=optUser.toString()%>
                    </select>
                 </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진 배경</font></strong></td>
                <td width="83%" colspan="3">
                    <textarea name="define" cols="72" rows="3" class="textarea_box" disable="true"><%=define%></textarea>
                 </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">과제 수행을 위한<br/> 선행 요건</font></strong></td>
                <td width="83%" colspan="3">
                    <textarea name="drvgoal" cols="72" rows="5" class="textarea_box" disable="true"><%=drvgoal%></textarea>
                 </td>
              </tr>
			  <tr bgcolor="#FFFFFF">
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">총 소요 예산</font></strong></td>
                <td width="36%">
                    <input type="text" name="budget" class="input_box" size="28" value="<%=budget %>">
                </td>
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">총 참여 인력</font></strong></td>
                <td width="33%">
                    <input type="text" name="manhour" class="input_box" size="25" value="<%=manhour %>">
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="17%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">LINK</font></strong></td>
                <td width="83%" colspan="3">
                    <input type="text" name="link" class="input_box" size="75" value="<%=link %>">
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