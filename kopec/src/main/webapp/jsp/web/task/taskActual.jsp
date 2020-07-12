<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>

<%
	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		
		return;
	}

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script language="javaScript">

	function setYear(sYear,eYear,cYear){
		selYear.length=0;

		for(var i=sYear;i<=eYear;i++){
			selYear.options[selYear.length] = new Option(i,i);
		}

		selYear.value=cYear;
	}

	function changePBSC(typeid, year ){
		pdetail.form1.typeid.value=typeid;
		pdetail.form1.year.value = detailDtl.form1.selYear.options[detailDtl.form1.selYear.selectedIndex].value;
	}

</script>




<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<!-------------->

            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="200">
                	<!------//프로젝트//---->
             		<iframe frameborder="0" id="proList" SCROLLING="auto" src="./taskActualProjectNM.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
            		<!------//프로젝트 끝//---->
            	</td>
            	<td cellpadding="0" cellspacing="0" >
					<!--------//리스트 //------->
		             <iframe frameborder="0" id="taskList" SCROLLING="auto" src="./taskActualList.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
					<!--------//리스트 끝 //------->
            	</td>
              </tr>
              <tr>
             	<td colspan="2" height="120" valign="top">
					<iframe frameborder="0" id="detailDtl" SCROLLING="no" src="./taskActualYear.jsp" style="body" width="100%" height="90%" >&nbsp;</iframe>				    
              	</td>
              </tr>
              <tr><td colspan="2" valign="top" style="padding:0 0 0 0">
                    <iframe frameborder="0" id="pdetail" src="./taskActualAchvIns.jsp" SCROLLING="no" style="body" width="100%" height="150%" ></iframe>
              </td></tr>
            </table>
</body>
</html>