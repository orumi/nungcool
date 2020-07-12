<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    EISUtil util = new EISUtil();
    util.getCost(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append(ds.getString("YYYY")+"|");
    		sb.append(ds.getString("YY_QUA")+"|");
    		sb.append(ds.getString("L_MAT_COST")+"|");
    		sb.append(ds.getString("L_LABOR_COST")+"|");
    		sb.append(ds.getString("L_EXPEND_COST")+"|");
    		sb.append(ds.getString("H_MAT_COST")+"|");
    		sb.append(ds.getString("H_LABOR_COST")+"|");
    		sb.append(ds.getString("H_EXPEND_COST")+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>