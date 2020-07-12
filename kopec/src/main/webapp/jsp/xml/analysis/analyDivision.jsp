<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.tree.*,
                 com.nc.xml.*" 
%>
<%

	
    AnalysisUtil util= new AnalysisUtil();
    util.setScoreTable(request, response);

    StringBuffer sb = (StringBuffer)request.getAttribute("sb");
    out.println(sb.toString());
%>
