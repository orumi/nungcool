<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.renov.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String did = request.getParameter("did");
	
	
	String sYear = request.getParameter("syear");
	String eYear = request.getParameter("eyear");
	String sQtr = request.getParameter("sqtr");
	String eQtr = request.getParameter("eqtr");
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script>
	var refresh = false;
	

</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>세부실행계획관리</title>
</head>
<body>
            <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="60%" align="left">
                	<!------//프로젝트//---->
                	<!-- 세부내역의 분기, 년도를 가지고 간다. -->
           			<iframe frameborder="0" id="dtl" src="taskAdmin_PDtl.jsp?sYear=<%=sYear %>&eYear=<%=eYear %>&sQtr=<%=sQtr %>&eQtr=<%=eQtr %>&did=<%=did %>" scrolling="auto" style="body" width="100%" height="95%" >&nbsp;</iframe>
            		<!------//프로젝트 끝//---->
            	</td>
             </tr>
             <tr>
            	<td align="center" height="40%">
					<!--------//리스트 //------->
					<!-- 세부내역의 상세세부내역리스트 조회를 위해서 detailid 를 가지고 간다. -->
					<iframe frameborder="0" id="list" src="taskAdmin_PList.jsp?did=<%=did %>" scrolling="auto" style="body" width="100%" height="80%" >&nbsp;</iframe>
					<!--------//리스트 끝 //------->
            	</td>
              </tr>
            </table>
</body>
</html>