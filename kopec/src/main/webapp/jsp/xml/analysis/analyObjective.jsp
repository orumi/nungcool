<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.tree.*,
                 com.nc.xml.*" 
%>
<%

	
    AnalysisUtil util= new AnalysisUtil();
    util.setTaskObjective(request, response);

    ArrayList list = (ArrayList)request.getAttribute("list");
	DataSet ds = (DataSet)request.getAttribute("dsStat");
    StringBuffer sb = new StringBuffer();
    
    if (list!=null)
    	for(int i=0;i<list.size();i++){
    		AnalyObjective obj = (AnalyObjective)list.get(i);
    		sb.append("obj|"+obj.pname+"|");
    		sb.append(obj.oname+"|");
    		sb.append(obj.score+"|");
    		sb.append((obj.exec!=null?obj.exec:"")+"|");
    		sb.append("\r\n");    		
    		
    	}
    
    if (ds!=null)
    	while (ds.next()){
    		sb.append("stat|");
    		sb.append((ds.isEmpty("EXECWORK")?"":ds.getString("EXECWORK"))+"|");
    		sb.append((ds.isEmpty("TNAME")?"":ds.getString("TNAME"))+"|");
    		sb.append((ds.isEmpty("SYEAR")?"":ds.getString("SYEAR"))+"|");
    		sb.append((ds.isEmpty("SYEAR")?"":ds.getString("SYEAR"))+"|");
    		sb.append((ds.isEmpty("REAL")?"":ds.getString("REAL"))+"|");
    		sb.append((ds.isEmpty("QTRGOAL")?"":ds.getString("QTRGOAL"))+"|");
    		sb.append((ds.isEmpty("QTRACHV")?"":ds.getString("QTRACHV"))+"|");
    		sb.append("\r\n");    
    	}
    
    out.println(sb.toString());

%>
