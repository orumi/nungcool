<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    HierarchyUtil util= new HierarchyUtil();
    util.updateNode(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("ID")?"0":ds.getString("ID"))+"|");
    		sb.append((ds.isEmpty("NAME")?"":ds.getString("NAME"))+"|");
    		sb.append((ds.isEmpty("TREELEVEL")?"0":ds.getString("TREELEVEL"))+"|");
    		sb.append((ds.isEmpty("WEIGHT")?"0":ds.getString("WEIGHT"))+"|");
    		sb.append((ds.isEmpty("RANK")?"0":ds.getString("RANK"))+"|");
    		sb.append((ds.isEmpty("CONTENTID")?"0":ds.getString("CONTENTID"))+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
