<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>

<%
		ValuateUtil util = new ValuateUtil();
		util.setEvalGroup2(request, response);

		
		//평가 그룹 지표명 가져 오기 
    DataSet ds = (DataSet)request.getAttribute("dsDtl");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
     		sb.append((ds.isEmpty("GRPID")?"":ds.getString("GRPID"))+"|");
     		sb.append((ds.isEmpty("GRPNM")?"":ds.getString("GRPNM"))+"|");
     		sb.append((ds.isEmpty("MEASUREID")?"0":ds.getString("MEASUREID"))+"|"); 
     		sb.append((ds.isEmpty("MNAME")?"":ds.getString("MNAME"))+"|");
     		sb.append("\r\n");    		
    		
    		
   		} 
    }
     out.println(sb.toString());
     
%>