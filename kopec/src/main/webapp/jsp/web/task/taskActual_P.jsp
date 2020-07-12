<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 
>-------------- 수정 사항  --------------<
수정일 : 2007.07.05 수정자 : 조영훈 


 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.util.*"%>

<%

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	String typeid = request.getParameter("typeid");
	String detailid = request.getParameter("detailid");
	int curYear = Integer.parseInt(Util.getToDay().substring(0,4));
	String frmYear = request.getParameter("year")==null?String.valueOf(curYear):request.getParameter("year");
	String mode = request.getParameter("mode")==null?"":request.getParameter("mode");	//전략과제 진척도에서 넘어 오는 
	
	String imgUri = request.getRequestURI();
	StringBuffer year = new StringBuffer();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
	for(int i = Integer.parseInt(frmYear); i <= Integer.parseInt(frmYear)+5; i++)
	{
		if(Integer.parseInt(frmYear) == i)
		{
			year.append("<option value=" + i + " selected>" + i + "</option>");
		}
		else
		{
			year.append("<option value=" + i + " >" + i + "</option>");
		}
	}
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>계획 및 실적</title>

</head>
<script>
/*
    function openExecWord(tag, pid, did, sid) {

    	if (exeWin!=null) exeWin.close();


		if(parent.detail.form1.pid.value == "") {
		    alert('선택된 프로젝트가 없습니다');
		    return;
		} else {
//			  		 parent.detailDtl.form1.selYear.options[parent.detailDtl.form1.selYear.selectedIndex].value;
		var typeid = parent.detail.form1.selType.options[parent.detail.form1.selType.selectedIndex].value;
			var url = "taskAdmin_P.jsp?tag="+tag+"&pid="+pid+"&did="+did+"&sid="+sid+"&typeid="+typeid ;
		    exeWin = window.open(url, '실행과제추가', 'toolbar=no,Width=600px,Height=650px,scroll=yes,resizable=no,menubar:yes,help=no,status=yes');
		    
		    exeWin.focus();
		}
	}
*/
	function chCombo()
	{
		prcGrap.form1.drvgoal.text = "";
		prcGrap.form1.drvachv.text = "";
		prcGrap.form1.year.value = form1.selYear2.options[form1.selYear2.selectedIndex].value;
		prcGrap.form1.detailid.value = <%=detailid%>;
		prcGrap.form1.typeid.value = <%=typeid%>;
//		alert(prcGrap.form1.year.value);
		prcGrap.form1.submit();
		
	}
</script>
<body onload="chCombo()">

    <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
					계획 및 실적
                  	</strong>
                </td>
              </tr>
	</table>
<form name="form1" method="post">	
    <table width="98%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#A4CBE3">
              <tr>
                <td align="center" bgcolor="#DCEDF6" width="15%"><strong><font color="#006699">년도</font></strong>
                </td>
				<td bgcolor="#FFFFFF" width="84%">
                	<strong>
						<select name="selYear2" onchange="chCombo()">
							<%=year.toString() %>
						</select>
                  	</strong>
                </td>
              </tr>
	</table>
	<br>
   <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
            	<td bgcolor="#FFFFFF" width="84%" bgcolor="#FFFFFF">
					<iframe frameborder="0" id="prcGrap" src="taskActual_PDtl.jsp?mode=<%=mode %>&detailid=<%=detailid %>&typeid=<%=typeid %>" style="body" width="100%" height="90%" scrolling="auto" >&nbsp;</iframe>
                </td>
              </tr>
	</table>
</form>
</body>
</html>