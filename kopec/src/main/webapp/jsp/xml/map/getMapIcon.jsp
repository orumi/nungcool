<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    MapUtil util = new MapUtil();
    util.getMapIcon(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    DataSet dsLine = (DataSet)request.getAttribute("dsLine");
    
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append(ds.getString("ID")+"|");
    		sb.append(ds.getString("MAPID")+"|");
    		sb.append(ds.getString("ICONSTYLE")+"|");
    		sb.append(ds.getString("ICONTEXT")+"|");
    		sb.append(ds.getString("X")+"|");
    		sb.append(ds.getString("Y")+"|");
    		sb.append(ds.getString("WIDTH")+"|");
    		sb.append(ds.getString("HEIGHT")+"|");
    		sb.append(ds.getString("SHOWTEXT")+"|");
    		sb.append(ds.getString("SHOWSCORE")+"|");
    		sb.append(ds.getString("TREEID")+"|");
    		sb.append(ds.getString("TREELEVEL"));
    		sb.append("\r\n");    		
   		} 
    }
    if (dsLine!=null)
    	while(dsLine.next()) {
    		sb.append("line|");
    		sb.append(dsLine.getString("MAPID")+"|");
    		sb.append(dsLine.getString("X")+"|");
    		sb.append(dsLine.getString("Y")+"|");
    		sb.append(dsLine.getString("WIDTH")+"|");
    		sb.append(dsLine.getString("HEIGHT")+"|");
    		sb.append(dsLine.getString("CURVEX")+"|");
    		sb.append(dsLine.getString("CURVEY")+"|");
    		sb.append(dsLine.getString("HEADERX")+"|");
    		sb.append(dsLine.getString("HEADERY")+"|");    		
    		sb.append("\r\n");   	
    	}

    out.println(sb.toString());
%>