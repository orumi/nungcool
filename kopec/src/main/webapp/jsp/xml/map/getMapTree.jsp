<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    MapUtil util = new MapUtil();
    util.getMapTree(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append(ds.getString("CID")+"|");
    		sb.append(ds.getString("CNAME")+"|");
    		sb.append(ds.getString("SID")+"|");
    		sb.append(ds.getString("SNAME")+"|");
    		sb.append(ds.getString("BID")+"|");
    		sb.append(ds.getString("BNAME")+"|");
    		sb.append(ds.getString("PID")+"|");
    		sb.append(ds.getString("PNAME")+"|");
    		sb.append(ds.getString("OID")+"|");
    		sb.append(ds.getString("ONAME")+"|");
    		sb.append(ds.getString("MID")+"|");
    		sb.append(ds.getString("MNAME"));
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
