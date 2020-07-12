<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "com.nc.util.*" %> 
<%@ page import="com.nc.cool.*" %>
<%@ page import="java.util.*" %>
<%
	String find_pass = request.getParameter("find_pass");
	LoginUtil loginutil = new LoginUtil();
	System.out.println(""+find_pass);
	
	if (!(find_pass.equals(""))||find_pass!= null){
		
	loginutil.pass_find(request, response);
	%>
	<script type="text/javascript">
	alert("정상적으로 변경하였습니다.");
	window.close(); 
	</script>
    <%}
    	else{%>
	<script type="text/javascript">
	alert("아이디를 입력해주세요");
	
	</script>
	
	<% } %>