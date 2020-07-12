<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.tree.*,
                 com.nc.xml.*" 
%>
<%

	
    AnalysisUtil util= new AnalysisUtil();
    util.setTaskActual(request, response);

    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("DETAILID")?"0":ds.getString("DETAILID"))+"|");
    		sb.append((ds.isEmpty("PID")?"":ds.getString("PID"))+"|");
    		sb.append((ds.isEmpty("EXECWORK")?"0":ds.getString("EXECWORK"))+"|");
    		sb.append((ds.isEmpty("NAME")?"0":ds.getString("NAME"))+"|");
    		sb.append((ds.isEmpty("TNAME")?"0":ds.getString("TNAME"))+"|");
    		sb.append((ds.isEmpty("FIELDNAME")?"0":ds.getString("FIELDNAME"))+"|");
    		sb.append((ds.isEmpty("PERIOD")?"0":ds.getString("PERIOD"))+"|");
    		sb.append((ds.isEmpty("GOAL1")?"0":ds.getString("GOAL1"))+"|");
    		sb.append((ds.isEmpty("ACHV1")?"0":ds.getString("ACHV1"))+"|");
    		sb.append((ds.isEmpty("R1")?"0":ds.getString("R1"))+"|");
    		sb.append((ds.isEmpty("GOAL2")?"0":ds.getString("GOAL2"))+"|");
    		sb.append((ds.isEmpty("ACHV2")?"0":ds.getString("ACHV2"))+"|");
    		sb.append((ds.isEmpty("R2")?"0":ds.getString("R2"))+"|");
    		sb.append((ds.isEmpty("GOAL3")?"0":ds.getString("GOAL3"))+"|");
    		sb.append((ds.isEmpty("ACHV3")?"0":ds.getString("ACHV3"))+"|");
    		sb.append((ds.isEmpty("R3")?"0":ds.getString("R3"))+"|");
    		sb.append((ds.isEmpty("GOAL4")?"0":ds.getString("GOAL4"))+"|");
    		sb.append((ds.isEmpty("ACHV4")?"0":ds.getString("ACHV4"))+"|");
    		sb.append((ds.isEmpty("R4")?"0":ds.getString("R4"))+"|");    		
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
