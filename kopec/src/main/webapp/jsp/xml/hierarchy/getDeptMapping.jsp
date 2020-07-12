<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	//System.out.println("go dept mapping...");
	HierarchyUtil util = new HierarchyUtil();
    util.getDeptMapping(request, response);
    
    String mode = request.getParameter("mode")==null?"":request.getParameter("mode");
	
    DataSet dsOrg = (DataSet)request.getAttribute("dsOrg");
    DataSet dsMap = (DataSet)request.getAttribute("dsMap");
    DataSet dsDept = (DataSet)request.getAttribute("dsDept");
    
    StringBuffer sbOrg = new StringBuffer();
    if (dsOrg!=null){
    	while(dsOrg.next()){ 
    		sbOrg.append(dsOrg.isEmpty("SID")?""+"|":dsOrg.getString("SID")+"|");			// 0   
    		sbOrg.append(dsOrg.isEmpty("SNAME")?""+"|":dsOrg.getString("SNAME")+"|");   	// 1   
    		sbOrg.append(dsOrg.isEmpty("BCID")?""+"|":dsOrg.getString("BCID")+"|");			// 2   
    		sbOrg.append(dsOrg.isEmpty("BNAME")?""+"|":dsOrg.getString("BNAME")+"|");		// 3   
    		sbOrg.append(dsOrg.isEmpty("DEPT_CNT")?""+"|":dsOrg.getString("DEPT_CNT")+"|");		// 3   
    		sbOrg.append("\r\n");    		                       
   		} 
    	//out.println(sbOrg.toString());
    }
    
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
    
    //StringBuffer sb = new StringBuffer();
    
    if(mode.equals("M")){
    	out.println(sbMap.toString());
    }else{
    	out.println(sbOrg.toString()+"++SPER++"+sbDept.toString()+"++SPER++");
    }
    
    //out.println(sb.toString());
%>