<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%

String mode		   = request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
String div_gn	   = request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();


System.out.println("Start GetOrgMeasReport : ");

//------------------------------------------------------------------------------------------		
//		조회.
//------------------------------------------------------------------------------------------	
if(mode.equals("R"))	{
	
	// 계량지표 항목 계획실적
	if(div_gn.equals("getOrgMeasItemActual"))	{		

			System.out.println("Start getOrgMeasItemActual");
		
			MeasReportUtil util = new MeasReportUtil();
		    util.getOrgMeasItemActual(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append(ds.getString("SID"              )+"|");		// 0   
		    		sb.append(ds.getString("SCID"            )+"|");		// 1   
		    		sb.append(ds.getString("SLEVEL"        )+"|");		// 2   
		    		sb.append(ds.getString("SNAME"        )+"|");       // 3   
		    		sb.append(ds.getString("SWEIGHT"     )+"|");       // 4   
		    		
		    		sb.append(ds.getString("BID"              )+"|");		// 5   
		    		sb.append(ds.getString("BCID"            )+"|");		// 6   
		    		sb.append(ds.getString("BLEVEL"        )+"|");		// 7   
		    		sb.append(ds.getString("BNAME"        )+"|");       // 8  
		    		sb.append(ds.getString("BWEIGHT"     )+"|");       // 9   
		    		
		    		sb.append(ds.getString("PID"               )+"|");		// 10  
		    		sb.append(ds.getString("PCID"            )+"|");		// 11     		
		    		sb.append(ds.getString("PLEVEL"        )+"|");		// 12 
		    		sb.append(ds.getString("PNAME"         )+"|");		// 13 
		    		sb.append(ds.getString("PWEIGHT"     )+"|");       // 14     		
		
		    		sb.append(ds.getString("OID"               )+"|");		// 15   
		    		sb.append(ds.getString("OCID"            )+"|");		// 16     		
		    		sb.append(ds.getString("OLEVEL"        )+"|");		// 17 
		    		sb.append(ds.getString("ONAME"         )+"|");		// 18   
		    		sb.append(ds.getString("OWEIGHT"     )+"|");       // 19       		
		
		    		sb.append(ds.getString("MID"               )+"|");		// 20   
		    		sb.append(ds.getString("MCID"            )+"|");		// 21     		
		    		sb.append(ds.getString("MLEVEL"        )+"|");		// 22 
		    		sb.append(ds.getString("MNAME"         )+"|");		// 23   
		    		sb.append(ds.getString("MWEIGHT"     )+"|");       // 24
		    		
		    		sb.append(ds.isEmpty("FREQUENCY")?""+"|":ds.getString("FREQUENCY"    )+"|");		    // 25
		    		sb.append(ds.isEmpty("ITEMCODE")?""+"|":ds.getString("ITEMCODE"    )+"|");		// 26
		    		sb.append(ds.isEmpty("ITEMNAME")?""+"|":ds.getString("ITEMNAME"    )+"|");		// 27
		    		sb.append(ds.isEmpty("ITEMFIXED")?""+"|":ds.getString("ITEMFIXED"    )+"|");		// 28

		    		sb.append(ds.isEmpty("MM03")?""+"|":ds.getString("MM03"    )+"|");		// 29		    		
		    		sb.append(ds.isEmpty("MM06")?""+"|":ds.getString("MM06"    )+"|");		// 30		    
		    		sb.append(ds.isEmpty("MM09")?""+"|":ds.getString("MM09"    )+"|");		// 31		    
		    		sb.append(ds.isEmpty("MM12")?""+"|":ds.getString("MM12"    )+"|");		// 32		    		    		

		    		sb.append(ds.getString("EMPNM"     )+"|");       // 33		    		
		    		sb.append(ds.getString("ITEMFIXED" )+"|");       // 34
		    		
		    		sb.append("\r\n");   
		    				    		
		   		} 
		    }
		
		    out.println(sb.toString());

	// 비계량지표 계획실적
	} else 	if(div_gn.equals("getOrgMeasEvalActual"))	{		

			System.out.println("Start getOrgMeasEvalActual");
		
			MeasReportUtil util = new MeasReportUtil();
		    util.getOrgMeasEvalActual(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
	    		
		    		sb.append(ds.getString("SID"              )+"|");		// 0   
		    		sb.append(ds.getString("SCID"            )+"|");		// 1   
		    		sb.append(ds.getString("SLEVEL"        )+"|");		// 2   
		    		sb.append(ds.getString("SNAME"        )+"|");       // 3   
		    		sb.append(ds.getString("SWEIGHT"     )+"|");       // 4   
		    		
		    		sb.append(ds.getString("BID"              )+"|");		// 5   
		    		sb.append(ds.getString("BCID"            )+"|");		// 6   
		    		sb.append(ds.getString("BLEVEL"        )+"|");		// 7   
		    		sb.append(ds.getString("BNAME"        )+"|");       // 8  
		    		sb.append(ds.getString("BWEIGHT"     )+"|");       // 9   
		    		
		    		sb.append(ds.getString("PID"               )+"|");		// 10  
		    		sb.append(ds.getString("PCID"            )+"|");		// 11     		
		    		sb.append(ds.getString("PLEVEL"        )+"|");		// 12 
		    		sb.append(ds.getString("PNAME"         )+"|");		// 13 
		    		sb.append(ds.getString("PWEIGHT"     )+"|");       // 14     		
		
		    		sb.append(ds.getString("OID"               )+"|");		// 15   
		    		sb.append(ds.getString("OCID"            )+"|");		// 16     		
		    		sb.append(ds.getString("OLEVEL"        )+"|");		// 17 
		    		sb.append(ds.getString("ONAME"         )+"|");		// 18   
		    		sb.append(ds.getString("OWEIGHT"     )+"|");       // 19       		
		
		    		sb.append(ds.getString("MID"               )+"|");		// 20   
		    		sb.append(ds.getString("MCID"            )+"|");		// 21     		
		    		sb.append(ds.getString("MLEVEL"        )+"|");		// 22 
		    		sb.append(ds.getString("MNAME"         )+"|");		// 23   
		    		sb.append(ds.getString("MWEIGHT"     )+"|");       // 24
		    		
		    		sb.append(ds.isEmpty("FREQUENCY")?""+"|":ds.getString("FREQUENCY"    )+"|");		    // 25
		    		sb.append(ds.isEmpty("YM")?""+"|":ds.getString("YM"    )+"|");		// 26
		    		sb.append(ds.isEmpty("EVALPLAN")?""+"|":Util.toText(ds.getString("EVALPLAN"    ))+"|");		// 27
		    		sb.append(ds.isEmpty("EVALACTUAL")?""+"|":Util.toText(ds.getString("EVALACTUAL"    ))+"|");		// 28
		    		sb.append(ds.isEmpty("EVALSELF")?""+"|":Util.toText(ds.getString("EVALSELF"    ))+"|");		// 29
		    		
		    		sb.append(ds.getString("EMPNM"     )+"|");       // 30		    			    		
		    		
		    		sb.append("^");   		    		
		   		} 
		    }	    
		    out.println(sb.toString());	    	

		    
	    // 비계량지표 평가의견	
	    } else 	if(div_gn.equals("getOrgMeasEvalComment"))	{		

			System.out.println("Start getOrgMeasEvalComment");
		
			MeasReportUtil util = new MeasReportUtil();
		    util.getOrgMeasEvalComment(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
	    		
		    		sb.append(ds.getString("SID"              )+"|");		// 0   
		    		sb.append(ds.getString("SCID"            )+"|");		// 1   
		    		sb.append(ds.getString("SLEVEL"        )+"|");		// 2   
		    		sb.append(ds.getString("SNAME"        )+"|");       // 3   
		    		sb.append(ds.getString("SWEIGHT"     )+"|");       // 4   
		    		
		    		sb.append(ds.getString("BID"              )+"|");		// 5   
		    		sb.append(ds.getString("BCID"            )+"|");		// 6   
		    		sb.append(ds.getString("BLEVEL"        )+"|");		// 7   
		    		sb.append(ds.getString("BNAME"        )+"|");       // 8  
		    		sb.append(ds.getString("BWEIGHT"     )+"|");       // 9   
		    		
		    		sb.append(ds.getString("PID"               )+"|");		// 10  
		    		sb.append(ds.getString("PCID"            )+"|");		// 11     		
		    		sb.append(ds.getString("PLEVEL"        )+"|");		// 12 
		    		sb.append(ds.getString("PNAME"         )+"|");		// 13 
		    		sb.append(ds.getString("PWEIGHT"     )+"|");       // 14     		
		
		    		sb.append(ds.getString("OID"               )+"|");		// 15   
		    		sb.append(ds.getString("OCID"            )+"|");		// 16     		
		    		sb.append(ds.getString("OLEVEL"        )+"|");		// 17 
		    		sb.append(ds.getString("ONAME"         )+"|");		// 18   
		    		sb.append(ds.getString("OWEIGHT"     )+"|");       // 19       		
		
		    		sb.append(ds.getString("MID"               )+"|");		// 20   
		    		sb.append(ds.getString("MCID"            )+"|");		// 21     		
		    		sb.append(ds.getString("MLEVEL"        )+"|");		// 22 
		    		sb.append(ds.getString("MNAME"         )+"|");		// 23   
		    		sb.append(ds.getString("MWEIGHT"     )+"|");       // 24
		    		
		    		sb.append(ds.isEmpty("FREQUENCY")?""+"|":ds.getString("FREQUENCY"    )+"|");		    // 25
		    		sb.append(ds.isEmpty("YM")?""+"|":ds.getString("YM"    )+"|");		// 26
		    		sb.append(ds.isEmpty("EVALCOMMENT")?""+"|":Util.toText(ds.getString("EVALCOMMENT"    ))+"|");		// 27
		    		
		    		sb.append("^");   
		    		
		   		} 
		    }
	//System.out.println(sb.toString());
	    out.println(sb.toString());
	    
	    //popRptOrgEvalCom // 비계량 평가의견 디테일
	}	else 	if(div_gn.equals("getOrg"))	{		

		System.out.println("Start getOrg");
	
		MeasReportUtil util = new MeasReportUtil();
	    util.getOrgMeasEvalComment1(request, response);
		
	    DataSet ds = (DataSet)request.getAttribute("ds");
	    
	    StringBuffer sb = new StringBuffer();
	    if (ds!=null){
	    	while(ds.next()){ 
    		
	    		sb.append(ds.getString("SID"              )+"|");		// 0   
	    		sb.append(ds.getString("SCID"            )+"|");		// 1   
	    		sb.append(ds.getString("SLEVEL"        )+"|");		// 2   
	    		sb.append(ds.getString("SNAME"        )+"|");       // 3   
	    		sb.append(ds.getString("SWEIGHT"     )+"|");       // 4   
	    		
	    		sb.append(ds.getString("BID"              )+"|");		// 5   
	    		sb.append(ds.getString("BCID"            )+"|");		// 6   
	    		sb.append(ds.getString("BLEVEL"        )+"|");		// 7   
	    		sb.append(ds.getString("BNAME"        )+"|");       // 8  
	    		sb.append(ds.getString("BWEIGHT"     )+"|");       // 9   
	    		
	    		sb.append(ds.getString("PID"               )+"|");		// 10  
	    		sb.append(ds.getString("PCID"            )+"|");		// 11     		
	    		sb.append(ds.getString("PLEVEL"        )+"|");		// 12 
	    		sb.append(ds.getString("PNAME"         )+"|");		// 13 
	    		sb.append(ds.getString("PWEIGHT"     )+"|");       // 14     		
	
	    		sb.append(ds.getString("OID"               )+"|");		// 15   
	    		sb.append(ds.getString("OCID"            )+"|");		// 16     		
	    		sb.append(ds.getString("OLEVEL"        )+"|");		// 17 
	    		sb.append(ds.getString("ONAME"         )+"|");		// 18   
	    		sb.append(ds.getString("OWEIGHT"     )+"|");       // 19       		
	
	    		sb.append(ds.getString("MID"               )+"|");		// 20   
	    		sb.append(ds.getString("MCID"            )+"|");		// 21     		
	    		sb.append(ds.getString("MLEVEL"        )+"|");		// 22 
	    		sb.append(ds.getString("MNAME"         )+"|");		// 23   
	    		sb.append(ds.getString("MWEIGHT"     )+"|");       // 24
	    		
	    		sb.append(ds.isEmpty("FREQUENCY")?""+"|":ds.getString("FREQUENCY"    )+"|");		    // 25
	    		sb.append(ds.isEmpty("YM")?""+"|":ds.getString("YM"    )+"|");		// 26
	    		sb.append(ds.isEmpty("EVALCOMMENT")?""+"|":ds.getString("EVALCOMMENT"    )+"|");		// 27 : 평가자의견
	    		
	    		sb.append((ds.isEmpty("EVALGRADE")?"-":ds.getString("EVALGRADE"     ))+"|");       // 28
	    		sb.append((ds.isEmpty("EVALRNM")?"":ds.getString("EVALRNM"     ))+"|");       // 29
	    		sb.append((ds.isEmpty("EVALPLAN")?"":ds.getString("EVALPLAN"     ))+"|");       // 30
	    		sb.append((ds.isEmpty("EVALDETAIL")?"":ds.getString("EVALDETAIL"     ))+"|");       // 31
	    		sb.append((ds.isEmpty("EVALESTIMATE")?"":ds.getString("EVALESTIMATE"     ))+"|");       // 32
	    		sb.append(ds.getString("MEAN"     )+"|");       // 33
	    		sb.append("^");   
	    		
	   		} 
	    }
//System.out.println(sb.toString());
    out.println(sb.toString());
}
	    
}


%>