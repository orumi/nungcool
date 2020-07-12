<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    ScoreTableUtil util= new ScoreTableUtil();
    util.setMeasureList(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("PID")?"":ds.getString("PID"))+"|");
    		sb.append((ds.isEmpty("PNAME")?"":ds.getString("PNAME"))+"|");
    		sb.append((ds.isEmpty("MID")?"":ds.getString("MID"))+"|");
    		sb.append((ds.isEmpty("MCID")?"":ds.getString("MCID"))+"|");
    		sb.append((ds.isEmpty("MWEIGHT")?"":ds.getString("MWEIGHT"))+"|");
    		sb.append((ds.isEmpty("MNAME")?"":ds.getString("MNAME"))+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
