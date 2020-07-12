<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    HierarchyUtil util= new HierarchyUtil();
    util.getHierarchy(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("CID")?"0":ds.getString("CID"))+"|");
    		sb.append((ds.isEmpty("CNAME")?"":ds.getString("CNAME"))+"|");
    		sb.append((ds.isEmpty("CWEIGHT")?"0":ds.getString("CWEIGHT"))+"|");
    		sb.append((ds.isEmpty("CCID")?"0":ds.getString("CCID"))+"|");
    		sb.append((ds.isEmpty("CRANK")?"0":ds.getString("CRANK"))+"|");
    		sb.append((ds.isEmpty("SID")?"0":ds.getString("SID"))+"|");
    		sb.append((ds.isEmpty("SNAME")?"":ds.getString("SNAME"))+"|");
    		sb.append((ds.isEmpty("SWEIGHT")?"0":ds.getString("SWEIGHT"))+"|");
    		sb.append((ds.isEmpty("SCID")?"0":ds.getString("SCID"))+"|");
    		sb.append((ds.isEmpty("SRANK")?"0":ds.getString("SRANK"))+"|");    		
    		sb.append((ds.isEmpty("BID")?"0":ds.getString("BID"))+"|");
    		sb.append((ds.isEmpty("BNAME")?"":ds.getString("BNAME"))+"|");
    		sb.append((ds.isEmpty("BWEIGHT")?"0":ds.getString("BWEIGHT"))+"|");
    		sb.append((ds.isEmpty("BCID")?"0":ds.getString("BCID"))+"|");
    		sb.append((ds.isEmpty("BRANK")?"0":ds.getString("BRANK"))+"|");    		
    		sb.append((ds.isEmpty("PID")?"0":ds.getString("PID"))+"|");
    		sb.append((ds.isEmpty("PNAME")?"":ds.getString("PNAME"))+"|");
    		sb.append((ds.isEmpty("PWEIGHT")?"0":ds.getString("PWEIGHT"))+"|");
    		sb.append((ds.isEmpty("PCID")?"0":ds.getString("PCID"))+"|");
    		sb.append((ds.isEmpty("PRANK")?"0":ds.getString("PRANK"))+"|");    		
    		sb.append((ds.isEmpty("OID")?"0":ds.getString("OID"))+"|");
    		sb.append((ds.isEmpty("ONAME")?"":ds.getString("ONAME"))+"|");
    		sb.append((ds.isEmpty("OWEIGHT")?"0":ds.getString("OWEIGHT"))+"|");
    		sb.append((ds.isEmpty("OCID")?"0":ds.getString("OCID"))+"|");
    		sb.append((ds.isEmpty("ORANK")?"0":ds.getString("ORANK"))+"|");
    		sb.append((ds.isEmpty("MID")?"0":ds.getString("MID"))+"|");
    		sb.append((ds.isEmpty("MNAME")?"":ds.getString("MNAME"))+"|");
    		sb.append((ds.isEmpty("MWEIGHT")?"0":ds.getString("MWEIGHT"))+"|");
    		sb.append((ds.isEmpty("MCID")?"0":ds.getString("MCID"))+"|");
    		sb.append((ds.isEmpty("MRANK")?"0":ds.getString("MRANK"))+"|");  
    		sb.append((ds.isEmpty("MEASUREID")?"0":ds.getString("MEASUREID"))+"|");  
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
