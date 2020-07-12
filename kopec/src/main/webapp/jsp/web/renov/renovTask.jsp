<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 
>-------------- 수정 사항  --------------<
수정일 : 2007.07.05 수정자: 조영훈 


 -->


<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.renov.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%@ page import="com.nc.util.DataSet"%>

<%
    request.setCharacterEncoding("euc-kr");
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

//	Taskdivision ta = new Taskdivision();
	RenovTask ta = new RenovTask();
	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	

	ta.setDivision(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");

	StringBuffer sbPBSC = new StringBuffer();
	StringBuffer sbBSC = new StringBuffer();
	
	StringBuffer years = new StringBuffer();

	String bscId = request.getParameter("bscId")!=null?request.getParameter("bscId"):"";
	String objId = request.getParameter("objId")!=null?request.getParameter("objId"):"";
	

	
	
	int currYear = Integer.parseInt(Util.getToDay().substring(0,4));

	for(int i = currYear-5; i <= currYear+5; i++)
	{
		if(i == currYear)
			years.append("<option value=" + i + " selected>" + i + "</option>");
		else
		{
			years.append("<option value=" + i + ">" + i + "</option>");
		}
	}
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

	function initrs(code,name,parent,level) {
		arrOrg[arrOrg.length] = new orgCD(code,name,parent,level);
	}



	function orgCD(code,name,parent,level) {
		this.code = code;
		this.name = name;
		this.parent = parent;
		this.level = level;
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


		function openDetail() {
            	prcGrap.form1.parentid.value = form1.selPBSC.options[form1.selPBSC.selectedIndex].value;
            	prcGrap.form1.mgrdept.value = form1.selBSC.options[form1.selBSC.selectedIndex].value;
            	prcGrap.form1.qtr.value = form1.qtr.options[form1.qtr.selectedIndex].value;
            	prcGrap.form1.year.value = form1.year.options[form1.year.selectedIndex].value;
            	prcGrap.form1.submit();
		}
	</Script>
<%
	int cnt = 0;
	int cId = -1;
	sbBSC.append("<option value='-1'>-</option>");
	if (ds!=null) {
		while(ds.next()) {

			if (ds.isEmpty("PARENTID")){
				if (cnt == 0){
					cId = ds.getInt("ID");
					cnt++;
				}
				sbPBSC.append("<option value='"+ds.getString("ID")+"'>"+ds.getString("NAME")+"</option>");
			} else {
				if ( cId == ds.getInt("PARENTID")){
					sbBSC.append("<option value='"+ds.getString("ID")+"'>"+ds.getString("NAME")+"</option>");
				}
				%>
				<script>
				initrs('<%=ds.getString("ID")%>','<%=ds.getString("NAME")%>','<%=ds.getString("PARENTID")%>','1');
				</script>
				<%
			}


		}
	}

%>

<body >

		<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
			<form name="form1" method="post" action="">
				<tr>
	                  <td width="10%" align="center" bgcolor="#DCEDF6">
	                  	<strong>
		                  	<font color="#006699">해당년도
		                  	</font>
	                  	</strong>
	                  </td>
	                  <td width="20%" align="left" bgcolor="#FFFFFF">
	                 	 <select name="year" style="width:100px;">
	                 	 <%=years.toString() %>
	                 	 </select>
	                  </td>
	                  <td width="10%" align="center" bgcolor="#DCEDF6">
	                  	<strong>
		                  	<font color="#006699">분기
		                  	</font>
	                  	</strong>
	                  </td>
	                  <td width="60%" align="left" bgcolor="#FFFFFF">
	                 	 <select name="qtr" style="width:100px;">
							<option value="1">1분기</option>
							<option value="2">2분기</option>
							<option value="3">3분기</option>
							<option value="4">4분기</option>
	                 	 </select>
	                  </td>
				</tr>
	              <tr>
	                  <td width="10%" align="center" bgcolor="#DCEDF6">
	                  	<strong>
		                  	<font color="#006699">부서 선택
		                  	</font>
	                  	</strong>
	                  </td width="90%">
	                  <td bgcolor="#FFFFFF" colspan="3">
	                  	<select name="selPBSC" style="width:200px;" onChange="javascript:changePBSC();">
							<%= sbPBSC.toString() %>
	                    </select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                  	<select name="selBSC" style="width:200px;">
							<%= sbBSC.toString() %>
	                    </select> &nbsp;&nbsp;
	                    	<a href="javascript:openDetail();" >
	                    		<img src="<%=imgUri %>/jsp/web/images/btn_ok.gif" alt="확인" width="50" height="20" border="0" align="absmiddle" >
	                    	</a>
	                  </td>
	                </tr>
				</form>
            </table>

			<!-------------->
            <iframe frameborder="0" id="prcGrap" src="./renovTaskDetail.jsp" style="body" width="100%" height="90%" scrolling="auto" >&nbsp;</iframe>
</body>
</html>