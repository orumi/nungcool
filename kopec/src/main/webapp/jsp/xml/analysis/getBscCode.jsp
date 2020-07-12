<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%

String mode		= request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
String div_gn	= request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();

if(mode.equals("R"))	{
	if(div_gn.equals("getMeasList"))	{

	
		// 지표대상부서를 구함.
	    MeasReportUtil util= new MeasReportUtil();
	    util.getMeasList(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		if (ds!=null){
			while(ds.next()){ 
				sb.append((ds.isEmpty("id")?"":ds.getString("id")) +"|");           		// 0
				sb.append((ds.isEmpty("code")?"":ds.getString("code")) +"|");           		//  1
				sb.append((ds.isEmpty("name")?"":ds.getString("name")) +"|");           		//  2
				sb.append((ds.isEmpty("measchar")?"":ds.getString("measchar")) +"|");           		//  3
				sb.append((ds.isEmpty("meascharnm")?"":ds.getString("meascharnm")) +"|");       // 4

				sb.append("\r\n");    		
			} 
		}

		out.println(sb.toString());			
	}
	
	if(div_gn.equals("getYearMeasList"))	{

		
		// 지표대상부서를 구함.
	    MeasReportUtil util= new MeasReportUtil();
	    util.getYearMeasList(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		if (ds!=null){
			while(ds.next()){ 
				sb.append((ds.isEmpty("id")?"":ds.getString("id")) +"|");           		// 0
				sb.append((ds.isEmpty("code")?"":ds.getString("code")) +"|");           		//  1
				sb.append((ds.isEmpty("name")?"":ds.getString("name")) +"|");           		//  2
				sb.append((ds.isEmpty("measchar")?"":ds.getString("measchar")) +"|");           		//  3
				sb.append((ds.isEmpty("meascharnm")?"":ds.getString("meascharnm")) +"|");       // 4

				sb.append("\r\n");    		
			} 
		}

		out.println(sb.toString());			
	}	
}	
	
%>