<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	HierarchyUtil util = new HierarchyUtil();
	util.setDeptMapping(request, response);
	
	DataSet dsMap = (DataSet)request.getAttribute("dsMap");
    DataSet dsDept = (DataSet)request.getAttribute("dsDept");
    String rslt = (String)request.getAttribute("rslt");
    String mode = request.getParameter("mode")==null?"":request.getParameter("mode");
    
    if(mode.equals("C")){
    	out.println(rslt+"|");
    }else{
	    StringBuffer sbDept = new StringBuffer();
	    if (dsDept!=null){
	    	sbDept = new StringBuffer();
	    	while(dsDept.next()){ 
	    		sbDept.append(dsDept.isEmpty("UDID")?""+"|":dsDept.getString("UDID")+"|");			// 0   
	    		sbDept.append(dsDept.isEmpty("UDNAME")?""+"|":(dsDept.getString("UDNAME")==null?""+"|":dsDept.getString("UDNAME")+"|"));   	// 1   
	    		sbDept.append(dsDept.isEmpty("DID")?""+"|":dsDept.getString("DID")+"|");			// 2   
	    		sbDept.append(dsDept.isEmpty("DNAME")?""+"|":dsDept.getString("DNAME")+"|");		// 3 
	    		sbDept.append(dsDept.isEmpty("USE_YN")?""+"|":dsDept.getString("USE_YN")+"|");		// 4 
	    		sbDept.append(dsDept.isEmpty("FINISHED_DT")?""+"|":dsDept.getString("FINISHED_DT")+"|");		// 5 
	    		sbDept.append("\r\n");    		                       
	   		}
	    	//out.println(sbDept.toString());
	    }
	    
	    StringBuffer sbMap = new StringBuffer();
	    if (dsMap!=null){
	    	sbMap = new StringBuffer();
	    	while(dsMap.next()){
	    		//System.out.println("map..."+dsMap.getString("UDID"));
	    		sbMap.append(dsMap.isEmpty("UDID")?""+"|":dsMap.getString("UDID")+"|");			// 0   
	    		sbMap.append(dsMap.isEmpty("UDNAME")?""+"|":(dsMap.getString("UDNAME")==null?""+"|":dsMap.getString("UDNAME")+"|"));   	// 1   
	    		sbMap.append(dsMap.isEmpty("DID")?""+"|":dsMap.getString("DID")+"|");			// 2   
	    		sbMap.append(dsMap.isEmpty("DNAME")?""+"|":dsMap.getString("DNAME")+"|");		// 3 
	    		sbMap.append(dsMap.isEmpty("USE_YN")?""+"|":dsMap.getString("USE_YN")+"|");		// 4 
	    		sbMap.append(dsMap.isEmpty("FINISHED_DT")?""+"|":dsMap.getString("FINISHED_DT")+"|");		// 5 
	    		sbMap.append("\r\n");    		                       
	   		}
	    	//out.println(sbMap.toString());
	    }
	    
	    out.println(sbMap.toString()+"++SPER++"+sbDept.toString()+"++SPER++"+rslt+"++SPER++");
    }
%>