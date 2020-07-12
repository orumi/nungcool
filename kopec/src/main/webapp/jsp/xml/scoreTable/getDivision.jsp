<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    ScoreTableUtil util= new ScoreTableUtil();
    util.getDivision(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("SID")?"0":ds.getString("SID"))+"|");
    		sb.append((ds.isEmpty("SNAME")?"":ds.getString("SNAME"))+"|");
    		sb.append((ds.isEmpty("SCID")?"0":ds.getString("SCID"))+"|");
    		sb.append((ds.isEmpty("BID")?"0":ds.getString("BID"))+"|");
    		sb.append((ds.isEmpty("BNAME")?"":ds.getString("BNAME"))+"|");
    		sb.append((ds.isEmpty("BCID")?"0":ds.getString("BCID"))+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
