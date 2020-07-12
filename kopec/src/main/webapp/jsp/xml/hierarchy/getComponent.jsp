<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    HierarchyUtil util= new HierarchyUtil();
    util.getComponent(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("KD")?"0":ds.getString("KD"))+"|");
    		sb.append((ds.isEmpty("ID")?"0":ds.getString("ID"))+"|");
    		sb.append((ds.isEmpty("NAME")?"":ds.getString("NAME"))+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
