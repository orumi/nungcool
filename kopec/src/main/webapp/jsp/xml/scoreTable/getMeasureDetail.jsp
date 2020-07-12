<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    ScoreTableUtil util= new ScoreTableUtil();
    util.setMeasureDetail(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("YEAR")?"":ds.getString("YEAR"))+"|");
    		sb.append((ds.isEmpty("MONTH")?"":ds.getString("MONTH"))+"|");
    		sb.append((ds.isEmpty("ACTUAL")?"":ds.getString("ACTUAL"))+"|");
    		sb.append((ds.isEmpty("PLANNED")?"":ds.getString("PLANNED"))+"|");
    		sb.append((ds.isEmpty("BASE")?"":ds.getString("BASE"))+"|");
    		sb.append((ds.isEmpty("LIMIT")?"":ds.getString("LIMIT"))+"|");
    		sb.append((ds.isEmpty("SCORE")?"":ds.getString("SCORE"))+"|");
    		sb.append((ds.isEmpty("PLANNEDBASE")?"":ds.getString("PLANNEDBASE"))+"|");
    		sb.append((ds.isEmpty("BASELIMIT")?"":ds.getString("BASELIMIT"))+"|");    		
    		sb.append((ds.isEmpty("GRADE")?"":ds.getString("GRADE"))+"|");    		
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
