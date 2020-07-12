<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	String mode		= request.getParameter("mode") == null ? "" : (request.getParameter("mode")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();

	System.out.println("setComCode : "+ mode);			
	
	if(mode.equals("D"))	{
		if(div_gn.equals("setComCode"))	{
			EISCommon com	= new EISCommon();
			com.setComCode(request, response);
			
			out.println("true");
			
		}
	}		
	
	if(mode.equals("U"))	{

		if(div_gn.equals("setComCode"))	{
			EISCommon com	= new EISCommon();
			com.setComCode(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append((ds.isEmpty("ldiv_cd")?"":ds.getString("ldiv_cd"))+"|");
		    		sb.append((ds.isEmpty("div_cd")?"":ds.getString("div_cd"))+"|");
		    		sb.append((ds.isEmpty("div_nm")?"":ds.getString("div_nm"))+"|");
		    		sb.append("\r\n");    		
		   		} 
		    }
		    out.println(sb.toString());
		}			
	}			
	
	
%>
