<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    ScoreTableUtil util= new ScoreTableUtil();
    util.setMeasureItem(request, response);
	
    StringBuffer sb = new StringBuffer();

    DataSet dsMea = (DataSet)request.getAttribute("dsMea");
    if (dsMea!=null)
    	while(dsMea.next()){
    		sb.append("0^");
    		sb.append((dsMea.isEmpty("NAME")?"":dsMea.getString("NAME"))+"^");
    		//sb.append("AAA"+"^"); 
    		sb.append((dsMea.isEmpty("EQUATION")?"":Util.toText(dsMea.getString("EQUATION")))+"^");     		
    		sb.append((dsMea.isEmpty("FREQUENCY")?"":dsMea.getString("FREQUENCY"))+"^"); 
    		sb.append((dsMea.isEmpty("UNIT")?"":dsMea.getString("UNIT"))+"^"); 
    		sb.append((dsMea.isEmpty("WEIGHT")?"":dsMea.getString("WEIGHT"))+"^");     		
    		sb.append("\r\n");    	
    	}
    
    DataSet ds = (DataSet)request.getAttribute("ds");
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append("1^");
    		sb.append((ds.isEmpty("YEAR")?"":ds.getString("YEAR"))+"^");
    		sb.append((ds.isEmpty("MONTH")?"":ds.getString("MONTH"))+"^");
    		sb.append((ds.isEmpty("ACTUAL")?"":ds.getString("ACTUAL"))+"^");
    		sb.append((ds.isEmpty("PLANNED")?"":ds.getString("PLANNED"))+"^");
    		sb.append((ds.isEmpty("BASE")?"":ds.getString("BASE"))+"^");
    		sb.append((ds.isEmpty("LIMIT")?"":ds.getString("LIMIT"))+"^");
    		sb.append((ds.isEmpty("SCORE")?"":ds.getString("SCORE"))+"^");
    		sb.append((ds.isEmpty("YEARB")?"":ds.getString("YEARB"))+"^");
    		sb.append((ds.isEmpty("ACTUALB")?"":ds.getString("ACTUALB"))+"^");
    		sb.append((ds.isEmpty("PLANNEDB")?"":ds.getString("PLANNEDB"))+"^");
    		sb.append((ds.isEmpty("BASEB")?"":ds.getString("BASEB"))+"^");
    		sb.append((ds.isEmpty("LIMITB")?"":ds.getString("LIMITB"))+"^");
    		sb.append((ds.isEmpty("SCOREB")?"":ds.getString("SCOREB"))+"^");    		
    		sb.append((ds.isEmpty("PLANNEDB")?"":ds.getString("PLANNEDBASE"))+"^");
    		sb.append((ds.isEmpty("BASEB")?"":ds.getString("BASELIMIT"))+"^");
    		sb.append((ds.isEmpty("PLANNEDB")?"":ds.getString("PLANNEDBASEB"))+"^");
    		sb.append((ds.isEmpty("BASEB")?"":ds.getString("BASELIMITB"))+"^");    		
    		sb.append("\r\n");    		
   		} 
    }
    
    DataSet dsItem = (DataSet)request.getAttribute("dsItem");
    if (dsItem!=null)
    	while(dsItem.next()){
    		sb.append("2^");
    		sb.append((dsItem.isEmpty("CODE")?"":dsItem.getString("CODE"))+"^");
    		sb.append((dsItem.isEmpty("ITEMNAME")?"":dsItem.getString("ITEMNAME"))+"^");
    		sb.append((dsItem.isEmpty("ITEMENTRY")?"":dsItem.getString("ITEMENTRY"))+"^");
    		sb.append((dsItem.isEmpty("ITEMTYPE")?"":dsItem.getString("ITEMTYPE"))+"^");
    		sb.append((dsItem.isEmpty("STRDATE")?"":dsItem.getString("STRDATE"))+"^");
    		sb.append((dsItem.isEmpty("YEAR")?"":dsItem.getString("YEAR"))+"^");
    		sb.append((dsItem.isEmpty("MONTH")?"":dsItem.getString("MONTH"))+"^");
    		sb.append((dsItem.isEmpty("ACTUAL")?"":dsItem.getString("ACTUAL"))+"^");
    		sb.append((dsItem.isEmpty("ACCUM")?"":dsItem.getString("ACCUM"))+"^");
    		sb.append((dsItem.isEmpty("AVERAGE")?"":dsItem.getString("AVERAGE"))+"^");
    		sb.append("\r\n");  
    	}
    System.out.println(sb.toString());
    out.println(sb.toString());
%>
