<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");
	MeasReportUtil util = new MeasReportUtil();
    util.getOrgAddScore(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    System.out.println("comment:"+request.getParameter("scoreadd_cmt"));
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append(ds.getString("SID"              )+"|");		// 0   
    		sb.append(ds.getString("SNAME"        )+"|");   // 1   
    		sb.append(ds.getString("BID"               )+"|");		// 2   
    		sb.append(ds.getString("BNAME"         )+"|");		// 3   
    		sb.append(ds.isEmpty("MWEIGHT1")?""+"|":ds.getString("MWEIGHT1"    )+"|");		// 4   
    		sb.append(ds.isEmpty("MSCORE1")?""+"|":ds.getString("MSCORE1"    )+"|");		// 5   
    		sb.append(ds.isEmpty("MWEIGHT2")?""+"|":ds.getString("MWEIGHT2")+"|");		    // 6   
    		sb.append(ds.isEmpty("MSCORE2")?""+"|":ds.getString("MSCORE2"    )+"|");		// 7 
    		sb.append(ds.isEmpty("SCORESUM")?""+"|":ds.getString("SCORESUM"  )+"|"); 	    // 8  
    		sb.append(ds.isEmpty("SCOREADD")?""+"|":ds.getDouble("SCOREADD"  )+"|"); 	    // 9  
    		sb.append(ds.isEmpty("SCORETOT")?""+"|":ds.getString("SCORETOT"      )+"|"); 	// 10  
    		sb.append(ds.isEmpty("GRP_RANK")?""+"|":ds.getString("GRP_RANK"   )+"|"); 	    // 11	
    		sb.append(ds.getString("ADDSCR_CMT")==null?""+"|":ds.getString("ADDSCR_CMT"   )+"|"); 	// 12
    		sb.append(ds.isEmpty("SCID")?""+"|":ds.getString("SCID"   )+"|"); 	            // 13	
    		
    		sb.append(ds.isEmpty("INPUTSCR")?""+"|":ds.getString("INPUTSCR"   )+"|"); 	    // 14	
    		sb.append(ds.isEmpty("CALGRD")?""+"|":ds.getString("CALGRD"   )+"|"); 	        // 15	
    		sb.append(ds.isEmpty("CALGRDSCR")?""+"|":ds.getString("CALGRDSCR"   )+"|"); 	// 16	
    		
    		sb.append("\r\n");    		                       
   		} 
    }
    out.println(sb.toString());
%>