<%@ page contentType="text/tvs; charset=utf-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("utf-8");

	MapUtil util = new MapUtil();
	util.updateIcon(request, response);
	
	out.println("true");
%>