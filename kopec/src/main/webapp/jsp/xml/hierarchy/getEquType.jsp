<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");
    HierarchyUtil util= new HierarchyUtil();
    util.getEquType(request, response);
    
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("TYPE")?"":ds.getString("TYPE"))+"|");
    		sb.append((ds.isEmpty("UPPER")?"":ds.getString("UPPER"))+"|");
    		sb.append((ds.isEmpty("HIGH")?"":ds.getString("HIGH"))+"|");
    		sb.append((ds.isEmpty("LOW")?"":ds.getString("LOW"))+"|");
    		sb.append((ds.isEmpty("LOWER")?"":ds.getString("LOWER"))+"|");    		
    		sb.append((ds.isEmpty("TYPE_NM")?"":ds.getString("TYPE_NM"))+"|");
    		sb.append((ds.isEmpty("PLANNED")?"":ds.getString("PLANNED"))+"|");
    		sb.append((ds.isEmpty("PLANNEDBASE")?"":ds.getString("PLANNEDBASE"))+"|");
    		sb.append((ds.isEmpty("BASE")?"":ds.getString("BASE"))+"|");    
    		sb.append((ds.isEmpty("BASELIMIT")?"":ds.getString("BASELIMIT"))+"|");
    		sb.append((ds.isEmpty("LIMIT")?"":ds.getString("LIMIT"))+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
