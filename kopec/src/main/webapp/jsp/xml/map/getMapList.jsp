<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*"
%>
<%
    MapUtil util = new MapUtil();
    util.getMapList(request, response);

    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){
    		sb.append(ds.getString("ID")+"|");
    		sb.append(ds.getString("MAPNAME")+"|");
    		sb.append(ds.getString("BACKGROUND")+"|");
    		sb.append(ds.getString("ICONPROPS")+"|");
    		sb.append(ds.getString("MAPKIND")+"|");
    		sb.append(ds.getString("MAPDIVISION")+"|");
    		sb.append(ds.getString("MAPRANK")+"|");
    		sb.append(ds.getString("NAME")+"|");
    		sb.append(ds.getString("TCID")+"|");
    		sb.append("\r\n");

    		System.out.println("TCID :" +ds.getString("TCID"));
   		}
    }
    out.println(sb.toString());
%>