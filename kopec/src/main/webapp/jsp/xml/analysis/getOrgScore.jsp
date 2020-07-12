<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%

String mode		   = request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
String div_gn	   = request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();


System.out.println("Start GetOrgScore");

//------------------------------------------------------------------------------------------		
//		조회.
//------------------------------------------------------------------------------------------	
if(mode.equals("R"))	{
	
	//  조직별 성과조회(MAIN)
	if(div_gn.equals("getOrgScore"))	{		

			System.out.println("Start GetOrgScore");
		
			MeasReportUtil util = new MeasReportUtil();
		    util.getOrgScore(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append(ds.getString("BID"              )+"|");		// 0   
		    		sb.append(ds.getString("BCID"            )+"|");		// 1   
		    		sb.append(ds.getString("BLEVEL"        )+"|");		// 2   
		    		sb.append(ds.getString("BNAME"        )+"|");       // 3   
		    		sb.append(ds.getString("BWEIGHT"     )+"|");       // 4   
		    		
		    		sb.append(ds.getString("PID"               )+"|");		// 5  
		    		sb.append(ds.getString("PCID"            )+"|");		// 6       		
		    		sb.append(ds.getString("PLEVEL"        )+"|");		// 7   
		    		sb.append(ds.getString("PNAME"         )+"|");		// 8   
		    		sb.append(ds.getString("PWEIGHT"     )+"|");       // 9       		
		
		    		sb.append(ds.getString("OID"               )+"|");		// 10   
		    		sb.append(ds.getString("OCID"            )+"|");		// 11     		
		    		sb.append(ds.getString("OLEVEL"        )+"|");		// 12 
		    		sb.append(ds.getString("ONAME"         )+"|");		// 13   
		    		sb.append(ds.getString("OWEIGHT"     )+"|");       // 14       		
		
		    		sb.append(ds.getString("MID"               )+"|");		// 15   
		    		sb.append(ds.getString("MCID"            )+"|");		// 16     		
		    		sb.append(ds.getString("MLEVEL"        )+"|");		// 17 
		    		sb.append(ds.getString("MNAME"         )+"|");		// 18   
		    		sb.append(ds.getString("MWEIGHT"     )+"|");       // 19
		    		
		    		sb.append(ds.isEmpty("MEASUREMENT")?""+"|":ds.getString("MEASUREMENT"    )+"|");		// 20  
		    		sb.append(ds.isEmpty("FREQUENCY")?""+"|":ds.getString("FREQUENCY"    )+"|");		            // 21 
		    		sb.append(ds.isEmpty("TREND")?""+"|":ds.getString("TREND")+"|");		                 				// 22
		    		sb.append(ds.isEmpty("ETLKEY")?""+"|":ds.getString("ETLKEY")+"|");		                            // 23 
		    		sb.append(ds.isEmpty("UNIT")?""+"|":ds.getString("UNIT"    )+"|");		                                    // 24
		    		
		    		sb.append(ds.isEmpty("PLANNED")?""+"|":ds.getString("PLANNED"  )+"|"); 	                        // 25 
		    		sb.append(ds.isEmpty("PLANNEDBASE")?""+"|":ds.getString("PLANNEDBASE"  )+"|"); 	    // 26
		    		sb.append(ds.isEmpty("BASE")?""+"|":ds.getString("BASE"      )+"|"); 	                                // 27
		    		sb.append(ds.isEmpty("BASELIMIT")?""+"|":ds.getString("BASELIMIT"   )+"|"); 						// 28	
		    		sb.append(ds.isEmpty("LIMIT")?""+"|":ds.getString("LIMIT"   )+"|"); 										// 29	
		
		    		sb.append(ds.isEmpty("ACTUAL")?""+"|":ds.getString("ACTUAL"  )+"|"); 								// 30 
		    		sb.append(ds.isEmpty("GRADE")?""+"|":ds.getString("GRADE"  )+"|"); 								// 31  
		    		sb.append(ds.isEmpty("SCORE")?""+"|":ds.getString("SCORE"      )+"|"); 								// 32  
		    		sb.append(ds.isEmpty("GRADE_SCORE")?""+"|":ds.getString("GRADE_SCORE"   )+"|"); 		// 33
		    		sb.append(ds.isEmpty("COMMENTS")?""+"|":ds.getString("COMMENTS"   )+"|"); 	            	// 34
		    		
		    		sb.append(ds.isEmpty("BCSCORE")?""+"|":ds.getString("BCSCORE"   )+"|"); 	            	// 35
		    		sb.append(ds.isEmpty("PCSCORE")?""+"|":ds.getString("PCSCORE"   )+"|"); 	            	// 36
		    		sb.append(ds.isEmpty("OCSCORE")?""+"|":ds.getString("OCSCORE"   )+"|"); 	            	// 37
		    		sb.append(ds.isEmpty("MCSCORE")?""+"|":ds.getString("MCSCORE"   )+"|"); 	            	// 38		    		

		    		sb.append(ds.isEmpty("BCWEIGHT")?""+"|":ds.getString("BCWEIGHT"   )+"|"); 	            	// 39
		    		sb.append(ds.isEmpty("PCWEIGHT")?""+"|":ds.getString("PCWEIGHT"   )+"|"); 	            	// 40
		    		sb.append(ds.isEmpty("OCWEIGHT")?""+"|":ds.getString("OCWEIGHT"   )+"|"); 	            	// 41
		    		
		    		sb.append("\r\n");   
		    		
		   		} 
		    }
		
		    out.println(sb.toString());

	//  조직별 성과조회(관점별 성과)
	} else 	if(div_gn.equals("getOrgPstStatus"))	{		

		System.out.println("Start getOrgPstStatus");
	
		MeasReportUtil util = new MeasReportUtil();
	    util.getOrgPstStatus(request, response);
		
	    DataSet ds = (DataSet)request.getAttribute("ds");
	    
	    StringBuffer sb = new StringBuffer();
	    if (ds!=null){
	    	while(ds.next()){ 
    		
	    		sb.append(ds.getString("PID"              )+"|");		// 0  
	    		sb.append(ds.getString("PCID"            )+"|");		// 1      		
	    		sb.append(ds.getString("PNAME"         )+"|");		// 2   

	    		sb.append(ds.isEmpty("TOTAL")?""+"|":ds.getString("TOTAL"  )+"|"); 	                      
	    		sb.append(ds.isEmpty("GRADE_S")?""+"|":ds.getString("GRADE_S"  )+"|"); 	                      
	    		sb.append(ds.isEmpty("GRADE_A")?""+"|":ds.getString("GRADE_A"  )+"|"); 	                      
	    		sb.append(ds.isEmpty("GRADE_B")?""+"|":ds.getString("GRADE_B"  )+"|"); 	                      
	    		sb.append(ds.isEmpty("GRADE_C")?""+"|":ds.getString("GRADE_C"  )+"|"); 	                      
	    		sb.append(ds.isEmpty("GRADE_D")?""+"|":ds.getString("GRADE_D"  )+"|"); 	                      
	    		sb.append(ds.isEmpty("NOTINPUT")?""+"|":ds.getString("NOTINPUT"  )+"|"); 	                      
	    		
	    		sb.append("\r\n");   
	    		
	   		} 
	    }
	
	    out.println(sb.toString());
	}	
}


%>