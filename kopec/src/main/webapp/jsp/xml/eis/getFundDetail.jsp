<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    EISUtil util = new EISUtil();
    util.getFundDetail(request, response);
	
    DataSet ds1 = (DataSet)request.getAttribute("ds1");
    StringBuffer sb = new StringBuffer();
    if (ds1!=null){
    	while(ds1.next()){ 
    		sb.append(ds1.getString("YEAR")+"|");
    		sb.append(ds1.getString("MONTH")+"|");
    		sb.append(ds1.getString("IN_REMAINDER")+"|");
    		sb.append(ds1.getString("IN_PLAN")+"|");
    		sb.append(ds1.getString("IN_ACTUAL")+"|");
    		sb.append(ds1.getString("OUT_PLAN")+"|");
    		sb.append(ds1.getString("OUT_ACTUAL")+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>