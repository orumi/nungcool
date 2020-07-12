<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.tree.*,
                 com.nc.xml.*" 
%>
<%
    AnalysisUtil util= new AnalysisUtil();
	String mode = (request.getParameter("mode")==null?"":request.getParameter("mode"));
	
	if(mode.equals("G05")) {
			util.getGubun(request, response);
			DataSet ds = (DataSet)request.getAttribute("dsStat");
			StringBuffer sb = new StringBuffer();
			if (ds!=null) {
		    	while (ds.next()){
		    		sb.append((ds.isEmpty("SDIV_CD")?"":ds.getString("SDIV_CD"))+"|");
		    		sb.append((ds.isEmpty("DIV_NM")?"":ds.getString("DIV_NM"))+"|");
		    		sb.append("\r\n");
		    	}
		    }
			out.println(sb.toString());

	} else	{

		    util.getOrgMeasureStatus(request, response);			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		
		    		sb.append(ds.getString("SNAME"        )+"|");       // 1   
		    		sb.append(ds.getString("BNAME"         )+"|");		// 3   
		    		sb.append(ds.isEmpty("OBJ1")?""+"|":ds.getString("OBJ1"    )+"|");		// 4   
		    		sb.append(ds.isEmpty("OBJ2")?""+"|":ds.getString("OBJ2"    )+"|");		// 5   
		    		sb.append(ds.isEmpty("OBJ3")?""+"|":ds.getString("OBJ3"    )+"|");		// 6   
		    		sb.append(ds.isEmpty("OBJ4")?""+"|":ds.getString("OBJ4"    )+"|");		// 7 
		    		sb.append(ds.isEmpty("VAL1")?""+"|":ds.getString("VAL1"     )+"|"); 	// 8  
		    		sb.append(ds.isEmpty("VAL2")?""+"|":ds.getString("VAL2"     )+"|"); 	// 9  
		    		sb.append(ds.getString("SID"               )+"|");		// 0   
		    		sb.append(ds.getString("BID"               )+"|");		// 2   		    		
		    		sb.append("\r\n");    		                       
		   		} 
		    }
		    out.println(sb.toString());			
	} 
%>
