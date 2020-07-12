<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");
    HierarchyUtil util= new HierarchyUtil();
    util.getUser(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("USERID")?"":ds.getString("USERID"))+"|");
    		sb.append((ds.isEmpty("USERNAME")?"":ds.getString("USERNAME"))+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
