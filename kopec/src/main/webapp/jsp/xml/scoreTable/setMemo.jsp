<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");
    ScoreTableUtil util= new ScoreTableUtil();
    util.setMomo(request, response);
	
    String userId = (String)session.getAttribute("userId");
    String userName = (String)session.getAttribute("userName");
    
    DataSet dsMea = (DataSet)request.getAttribute("dsMea");
    DataSet dsMemo = (DataSet)request.getAttribute("dsMemo");
    DataSet dsUser = (DataSet) request.getAttribute("dsUser");
    
    StringBuffer sb = new StringBuffer();
    
    String msg = (String)request.getAttribute("msg");
    if (msg!=null){
    	sb.append("msg|");
    	sb.append(msg);
    	sb.append("\r\n");
    }
    if (dsUser!=null)
    	while (dsUser.next()){
    		sb.append("user|");
    		sb.append((dsUser.isEmpty("USERID")?"":dsUser.getString("USERID"))+"|");
    		sb.append((dsUser.isEmpty("USERNAME")?"":dsUser.getString("USERNAME"))+"|"); 
    		sb.append((dsUser.isEmpty("DNAME")?"":dsUser.getString("DNAME"))+"|"); 
    		sb.append("\r\n");
    	}
    
    if (dsMea!=null)
    	while(dsMea.next()){
    		sb.append("measure|");
    		sb.append((dsMea.isEmpty("UPDATEID")?"":dsMea.getString("UPDATEID"))+"|");
    		sb.append((dsMea.isEmpty("NAME")?"":dsMea.getString("NAME"))+"|");  
    		sb.append("\r\n");
    	}
    		
	if (dsMemo!=null)
		while(dsMemo.next()){
			sb.append("memo|");
    		sb.append((dsMemo.isEmpty("STRDATE")?"":dsMemo.getString("STRDATE"))+"|");
    		sb.append((dsMemo.isEmpty("ACTUAL")?"":dsMemo.getString("ACTUAL"))+"|"); 
    		sb.append((dsMemo.isEmpty("PLANNED")?"":dsMemo.getString("PLANNED"))+"|"); 
    		sb.append((dsMemo.isEmpty("BASE")?"":dsMemo.getString("BASE"))+"|"); 
    		sb.append((dsMemo.isEmpty("LIMIT")?"":dsMemo.getString("LIMIT"))+"|"); 
    		sb.append((dsMemo.isEmpty("COMMENTS")?"":Util.toText(dsMemo.getString("COMMENTS")))+"|"); 
    		sb.append((dsMemo.isEmpty("FILENAME")?"":dsMemo.getString("FILENAME"))+"|");
    		sb.append((dsMemo.isEmpty("UPDATEDATE")?(dsMemo.isEmpty("INPUTDATE")?"":dsMemo.getString("INPUTDATE")):dsMemo.getString("UPDATEDATE"))+"|"); 
    		sb.append((dsMemo.isEmpty("UPNAME")?(dsMemo.isEmpty("INNAME")?"":dsMemo.getString("INNAME")):dsMemo.getString("UPNAME"))+"|"); 
    		
    		sb.append("\r\n");
		}
    out.println(sb.toString());
%>
