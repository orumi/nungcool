<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 
>-------------- 수정 사항  --------------<
수정일 : 2007.07.05 수정자 : 조영훈 


 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.util.*"%>

<%
	String imgUri = request.getRequestURI();
	
	request.setCharacterEncoding("euc-kr");
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	
	
	TaskActualUtil tAc = new TaskActualUtil();
	tAc.taskAdminDtlPop(request, response);	//--원래는 실적 등록 하는 화면에 있던 거라 서비스 변경 안하고 그냥 함.
	String detailid = request.getParameter("detailid");
	String typeid = request.getParameter("typeid");

	String msg = "";
	String drvgoal = "";
	String drvachv = "";

	DataSet ds = (DataSet)request.getAttribute("ds2");
	if(ds != null)
	{
		while(ds.next())
		{
			drvgoal = ds.isEmpty("DRVGOAL")?" ":ds.getString("DRVGOAL");
			drvachv = ds.isEmpty("DRVACHV")?" ":ds.getString("DRVACHV");
		}
	}
	
	
	msg = (String)request.getAttribute("msg");
	if(msg != null)
	{
		out.println("<script>");
		out.println("alert('" + msg + "');");
		out.println("parent.window.close();");
		out.println("</script>");

	}
%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script>
	function actionPerformed()
	{
		form1.year.value = parent.form1.selYear2.options[parent.form1.selYear2.selectedIndex].value;
		form1.detailid.value=<%=detailid%>;
		form1.typeid.value=<%=typeid%>;
		form1.div.value='P';
		form1.submit();
	}
</script>
<body topmargin=0 leftmargin=3 marginwidth=0 marginheight=0>
<table width="98%" height="90%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
	<form name="form1" method="post" action="">
	   	<input type="hidden" name="selYear" value="">
	   	<input type="hidden" name="year" value="">
   		<input type="hidden" name="detailid" value="">
   		<input type="hidden" name="typeid" value="">
   		<input type="hidden" name="div" value="">
	<tr bgcolor="#DCEDF6">
		<td align="center" bgcolor="#DCEDF6" height="10%" width="100%"><strong><font color="#006699">연도별 계획</font></strong></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF" width="98%" height="90%" valign="top"><textarea name="drvgoal" rows="20" cols="59"><%=drvgoal %></textarea></td>
	</tr>
	<tr align="right" bgcolor="#FFFFFF">
		<td colspan="4">
			<a href="javascript:actionPerformed()"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" align="absmiddle"></a>
		</td>
	</tr>
	</form>
</table>
</body>
</html>