<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    EISUtil util = new EISUtil();
    util.getMeasure(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append(ds.getString("CONTENTID")+"|");
    		sb.append(ds.getString("BNAME")+"|");
    		sb.append(ds.getString("PNAME")+"|");
    		sb.append(ds.getString("FREQUENCY")+"|");
    		sb.append(ds.getString("UNIT")+"|");
    		sb.append(ds.getString("EQUATIONDEFINE")+"|");
    		sb.append(ds.getString("MEASUREMENT")+"|");
    		sb.append(ds.getString("NAME")+"|");
    		sb.append(ds.getString("UNAME")+"|");
    		sb.append((ds.isEmpty("ACTUAL")?"":ds.getString("ACTUAL"))+"|");
    		sb.append((ds.isEmpty("PLANNED")?"":ds.getString("PLANNED"))+"|");
    		sb.append((ds.isEmpty("BASE")?"":ds.getString("BASE"))+"|");
    		sb.append((ds.isEmpty("LIMIT")?"":ds.getString("LIMIT"))+"|");
    		sb.append((ds.isEmpty("SCORE")?"":ds.getString("SCORE"))+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>