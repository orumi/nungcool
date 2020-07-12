<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    HierarchyUtil util= new HierarchyUtil();
    util.deleteNode(request, response);  
	 
    String result = (String) request.getAttribute("result");
    if ((result==null) || ("".equals(result))) result="false";
    out.println(result);
%>
