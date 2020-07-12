<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.cool.PeriodUtil,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	PeriodUtil util= new PeriodUtil();
    util.CheckPeriod(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append(ds.isEmpty("div_yn")?"N":ds.getString("div_yn"));
    	    System.out.println("aaaa : " + ds.getString("div_yn"));    		
    	} 
    }

    out.println(sb.toString());
    
    System.out.println(sb.toString());
%>
