<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    MapUtil util = new MapUtil();
    util.getMapIconScoreJunSa(request, response);	

    DataSet dsIcon = (DataSet)request.getAttribute("dsIcon");
    DataSet dsLine = (DataSet)request.getAttribute("dsLine");
    
    StringBuffer sb = new StringBuffer();
    if (dsIcon!=null) {
    	while(dsIcon.next()) {

    		sb.append(dsIcon.getString("id"       )+"|");
    		sb.append(dsIcon.getString("mapId"    )+"|");
    		sb.append(dsIcon.getString("style"    )+"|");
    		sb.append(dsIcon.getString("text"     )+"|");
    		sb.append(dsIcon.getString("x"        )+"|");
    		sb.append(dsIcon.getString("y"        )+"|");
    		sb.append(dsIcon.getString("width"    )+"|");
    		sb.append(dsIcon.getString("height"   )+"|");
    		sb.append(dsIcon.getString("showText" )+"|");
    		sb.append(dsIcon.getString("showScore")+"|");
    		sb.append(dsIcon.getString("treeId"   )+"|");
    		sb.append(dsIcon.getString("treeLevel")+"|");
    		sb.append(dsIcon.getString("score"    )+"|");
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