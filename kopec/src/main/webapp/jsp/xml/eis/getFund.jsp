<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    EISUtil util = new EISUtil();
    util.getFund(request, response);
	
    DataSet ds1 = (DataSet)request.getAttribute("ds1");
    StringBuffer sb = new StringBuffer();
    if (ds1!=null){
    	while(ds1.next()){ 
    		sb.append(ds1.getString("YY")+"|");
    		sb.append(ds1.getString("QUARTER")+"|");
    		sb.append(ds1.getString("비용예산")+"|");
    		sb.append(ds1.getString("비용실적")+"|");
    		sb.append(ds1.getString("수익예산")+"|");
    		sb.append(ds1.getString("수익실적")+"|");
    		sb.append(ds1.getString("구매예산")+"|");
    		sb.append(ds1.getString("구매실적")+"|");
    		sb.append(ds1.getString("자본예산")+"|");
    		sb.append(ds1.getString("자본실적")+"|");
    		sb.append(ds1.getString("연예산")+"|");
    		sb.append(ds1.getString("연실적")+"|");
    		sb.append(ds1.getString("연예산집행률")+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>