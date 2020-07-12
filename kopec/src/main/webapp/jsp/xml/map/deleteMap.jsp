<%@ page contentType="text/tvs; charset=utf-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("utf-8");

	MapUtil util = new MapUtil();
	util.deleteMap(request, response);
	
	DataSet ds = (DataSet)request.getAttribute("ds");
	StringBuffer sb = new StringBuffer();
	if (ds!=null){
		while(ds.next()){ 
			sb.append(ds.getString("ID")+"|");
			sb.append(ds.getString("MAPNAME")+"|");
			sb.append(ds.getString("BACKGROUND")+"|");
			sb.append(ds.getString("ICONPROPS")+"|");
			sb.append(ds.getString("MAPRANK"));
			sb.append("\r\n");    		
			} 
	}
	out.println(sb.toString());
%>