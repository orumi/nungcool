<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    MapUtil util = new MapUtil();
    util.getMapIconScore(request, response);
	
    ArrayList list      = (ArrayList)request.getAttribute("iconList");
    DataSet dsLine = (DataSet)request.getAttribute("dsLine");
    
    StringBuffer sb = new StringBuffer();
    if (list!=null){
    	for(int i=0;i<list.size();i++){
    		Icon icon = (Icon)list.get(i);
    		
    		sb.append(icon.id+"|");
    		sb.append(icon.mapId+"|");
    		sb.append(icon.style+"|");
    		sb.append(icon.text+"|");
    		sb.append(icon.x+"|");
    		sb.append(icon.y+"|");
    		sb.append(icon.width+"|");
    		sb.append(icon.height+"|");
    		sb.append(icon.showText+"|");
    		sb.append(icon.showScore+"|");
    		sb.append(icon.treeId+"|");
    		sb.append(icon.treeLevel+"|");
    		for (int j=0;j<icon.score.length;j++){
    			sb.append(Common.round(icon.score[j],1)+",");
    		}
    		sb.append("|");
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