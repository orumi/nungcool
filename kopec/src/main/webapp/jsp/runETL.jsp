<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.etl.*,
				 com.nc.util.*"%>
<%
	myETLTask run = new myETLTask();
	run.step=true;
	run.run(); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
  run etl  ....
</body>
</html>