<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    EISUtil util = new EISUtil();
    util.getFinance(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append(ds.getString("PERIOD_NAME")+"|");
    		sb.append(ds.getString("SALES")+"|");
    		sb.append(ds.getString("매출총이익")+"|");
    		sb.append(ds.getString("영업이익")+"|");
    		sb.append(ds.getString("경상이익")+"|");
    		sb.append(ds.getString("매출총이익누적")+"|");
    		sb.append(ds.getString("영업이익누적")+"|");
    		sb.append(ds.getString("경상이익누적")+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>