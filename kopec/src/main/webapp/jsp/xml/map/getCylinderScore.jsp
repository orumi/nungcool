<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.tree.*,
                 com.nc.xml.*" 
%>
<%
    MapUtil util = new MapUtil();
    util.getCylinderScore(request, response);
	
    TreeNode node = (TreeNode)request.getAttribute("node");
    StringBuffer sb = new StringBuffer();
    if (node!=null){
    	node.buildPlanNode(sb,3); 		
    }
    out.println(sb.toString());
%>