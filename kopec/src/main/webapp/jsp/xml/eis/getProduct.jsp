<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    EISUtil util = new EISUtil();
    util.getProduct(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    String daily = (String)request.getAttribute("daily");
    String daily1 = (String)request.getAttribute("daily1");
    
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append("P"+"|");								// 0 
    		sb.append(ds.getString("YYYY")+"|");			// 1 
    		sb.append(ds.getString("QUATER")+"|");			// 2
    		sb.append(ds.getString("L_T_PROD_FA")+"|");		// 3
    		sb.append(ds.getString("L_A_PROD_FA")+"|");     // 4
    		sb.append(ds.getString("H_T_PROD_TU")+"|");		// 5
    		sb.append(ds.getString("H_A_PROD_TU")+"|");		// 6
    		sb.append(ds.getString("L_T_DELI_FA")+"|");		// 7
    		sb.append(ds.getString("L_A_DELI_FA")+"|");		// 8
    		sb.append(ds.getString("H_T_DELI_TU")+"|");		// 9
    		sb.append(ds.getString("H_A_DELI_TU")+"|"); 	// 10
    		sb.append(ds.getString("L_T_PROD_TU")+"|"); 	// 11
    		sb.append(ds.getString("L_A_PROD_TU")+"|"); 	// 12
    		sb.append(ds.getString("H_T_PROD_FA")+"|"); 	// 13
    		sb.append(ds.getString("H_A_PROD_FA")+"|"); 	// 14
    		sb.append(ds.getString("L_T_DELI_TU")+"|");		// 15
    		sb.append(ds.getString("L_A_DELI_TU")+"|");		// 16
    		sb.append(ds.getString("H_T_DELI_FA")+"|");		// 17
    		sb.append(ds.getString("H_A_DELI_FA")+"|"); 	// 18    		
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
    out.println(daily+"\r\n");
    out.println(daily1+"\r\n");
%>