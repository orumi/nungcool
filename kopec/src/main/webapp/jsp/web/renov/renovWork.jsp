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

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	String auth = (String)session.getAttribute("auth01")!=null?(String)session.getAttribute("auth01"):""; 
	if(id.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.')");
		out.print("top.location.href='../loginProc.jsp'");
		out.print("</script>");
	}
	
	
	RenovWorkMgr ta = new RenovWorkMgr();
	ta.setDivision(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");

	StringBuffer sbPBSC = new StringBuffer();
	StringBuffer sbBSC = new StringBuffer();
	StringBuffer years = new StringBuffer();
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

	
	String bscId = request.getParameter("bscId")!=null?request.getParameter("bscId"):"";
	String objId = request.getParameter("objId")!=null?request.getParameter("objId"):"";
	



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
//		form1.selBSC.options[form1.selBSC.length] = new Option('-',-1);
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

/*
	function resChange()	//coolChart
	{
		var tblRow = chartList.listTbl.rows.length-1;
		
		if(chartList.listTbl.rows.length != 0)
		{
			for(var i = tblRow; i >= 0; i--)
			{
				chartList.listTbl.deleteRow(i);
			}
		}
		
		if(chartList.titleTbl.rows.length != 0)
			chartList.titleTbl.deleteRow(0);
	}

*/
		function openDetail() 
		{

//			if(form1.selBSC.options[form1.selBSC.selectedIndex].text == '-')
//				alert('처 또는 실을 선택하세요.');

				list.form1.year.value = form1.curYear.options[form1.curYear.selectedIndex].value;
				list.form1.deptid.value = form1.selBSC.options[form1.selBSC.selectedIndex].value;
            	list.form1.submit();
		}
</Script>
<%
	int cnt = 0;
	int cId = -1;
//	sbBSC.append("<option value='-1'>-</option>");
	if (ds!=null) {
		while(ds.next()) {

			if (ds.isEmpty("PARENTID"))
			{
				if (cnt == 0){
					cId = ds.getInt("ID");
					cnt++;
				}
				sbPBSC.append("<option value='"+ds.getString("ID")+"'>"+ds.getString("NAME")+"</option>");
			}
			else 
			{
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
	                  <td width="80" align="center" bgcolor="#DCEDF6">
	                  	<strong>
		                  	<font color="#006699">해당년도
		                  	</font>
	                  	</strong>
	                  </td>
	                  <td width="80" align="center" bgcolor="#FFFFFF">
	                 	 <select name="curYear" style="width:100px;">
	                 	 <%=years.toString() %>
	                 	 </select>
	                  </td>
				</tr>
	              <tr>
	                  <td width="80" align="center" bgcolor="#DCEDF6">
	                  	<strong>
		                  	<font color="#006699">부서 선택
		                  	</font>
	                  	</strong>
	                  </td>
	                  <td bgcolor="#FFFFFF">
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
            
            <table width="100%" height="100%">
            	<tr>
            		<td  valign="top" height="50%">
            			<table vspace="4">
							<tr bgcolor="#FFFFFF">
	              				<td height="15" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
	               	 				혁신과제 리스트</strong>
	               	 			</td>
							</tr>
            			</table>
						<iframe frameborder="0" id="list" src="renovWorkList.jsp" scrolling="auto" style="body" width="100%" height="80%" >&nbsp;</iframe>
	            	</td>
	            	<td valign="top" height="50%">
            			<table vspace="4">
							<tr bgcolor="#FFFFFF">
								<td height="15" colspan="4" bgcolor="#FFFFFF"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				                  	혁신과제</strong>
				                </td>
							</tr>
            			</table>	            	
<!--            		<iframe frameborder="0" id="detail" src="taskAdminDetail.jsp" style="body" width="100%" height="80%" >&nbsp;</iframe> -->
						<iframe frameborder="0" id="detail" src="renovWorkDetail.jsp" style="body" width="100%" height="80%" >&nbsp;</iframe>
	            	</td>
	            </tr>
	            <tr>
	            	<td colspan="2">
            			<table vspace="4">
							<tr bgcolor="#FFFFFF">
				  				<td height="15" colspan="8" bgcolor="#FFFFFF"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				   	 			세부추진내용</strong>&nbsp;&nbsp;&nbsp;
				   	 			<a href="javascript:dlist.openExecWord('I',detail.form1.pid.value,'');"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" align="absmiddle" alt="실행과제추가" width="50" height="20" border="0"></a>
				   	 			</td>
							</tr>
            			</table>	            		            	
             		<iframe frameborder="0" id="dlist" src="renovWorkChild.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
	            	</td>
	           </tr>
            </table>
            
            
</body>
</html>