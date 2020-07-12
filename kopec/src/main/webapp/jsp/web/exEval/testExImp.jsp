<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.nc.util.Util"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%= Util.getToDay() %>
<table>
	<form name="form1" action="evalUpLoad.jsp" enctype="multipart/form-data" method="post">
		<input name="filename" type="file" class="input_box" style="width:60%">
		<input type=hidden name="command" value="upLoad">
		<input type=hidden name="schDate" value="200701">
		<input type=submit>
	</form>
</table>

</body>
</html>