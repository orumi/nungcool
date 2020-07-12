<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.cool.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%

	System.out.println(" setPeriodYearCopy Start..."  );

	PeriodUtil util= new PeriodUtil();
	util.setPeriodYearCopy(request, response);
	
    String copyOK = (String)request.getAttribute("rslt");
	out.println(copyOK);
	System.out.println(" setPeriodYearCopy End..." + copyOK);
%>