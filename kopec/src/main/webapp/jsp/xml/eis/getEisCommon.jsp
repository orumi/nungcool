<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	String ldiv_cd       = request.getParameter("ldiv_cd") == null ? "" : (request.getParameter("ldiv_cd")).trim();
	
	EISCommon com	= new EISCommon();
	com.getComCode(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("ldiv_cd")?"":ds.getString("ldiv_cd"))+"|");
    		sb.append((ds.isEmpty("div_cd")?"":ds.getString("div_cd"))+"|");
    		sb.append((ds.isEmpty("div_nm")?"":ds.getString("div_nm"))+"|");
    		sb.append((ds.isEmpty("div_snm")?"":ds.getString("div_snm"))+"|");
    		sb.append((ds.isEmpty("mng1")?"":ds.getString("mng1"))+"|");
    		sb.append((ds.isEmpty("mng2")?"":ds.getString("mng2"))+"|");
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());

	
%>
