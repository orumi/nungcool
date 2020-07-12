<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	MeasReportUtil util = new MeasReportUtil();
    util.getMeasRank(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append(ds.getString("MNAME"      )+"|");		// 0
    		sb.append(ds.getString("MCID"       )+"|");		// 1   
    		sb.append(ds.getString("SID"        )+"|");		// 2   
    		sb.append(ds.getString("SNAME"      )+"|");   // 3   
    		sb.append(ds.getString("BID"        )+"|");		// 4   
    		sb.append(ds.getString("BNAME"      )+"|");		// 5   
    		sb.append(ds.getString("MWEIGHT"    )+"|");		// 6   
    		sb.append(ds.getString("PLANNED"    )+"|");		// 7   
    		sb.append(ds.getString("PLANNEDBASE")+"|");		// 8   
    		sb.append(ds.getString("BASE"       )+"|"); 	// 9   
    		sb.append(ds.getString("BASELIMIT"  )+"|"); 	// 10  
    		sb.append(ds.getString("LIMIT"      )+"|"); 	// 11  
    		sb.append(ds.getString("ACTUAL"     )+"|"); 	// 12  
    		sb.append(ds.getString("GRADE"      )+"|"); 	// 13  
    		sb.append(ds.getString("GRADE_SCORE")+"|");		// 14  
    		sb.append(ds.getString("SCORE"      )+"|");		// 15  
    		sb.append(ds.getString("RANK_SCORE" )+"|");		// 16  
    		sb.append(ds.getString("GRP_RANK"   )+"|"); 	// 17    		
    		sb.append(ds.getString("ALL_RANK"   )+"|"); 	// 18    		 
    		sb.append(ds.getString("GRP_AVG"   )+"|"); 	// 19    		
    		sb.append(ds.getString("ALL_AVG"   )+"|"); 	// 20  		    		
    		sb.append("\r\n");    		                       
   		} 
    }
    out.println(sb.toString());
%>