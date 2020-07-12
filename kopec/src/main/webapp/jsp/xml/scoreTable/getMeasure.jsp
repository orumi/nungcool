<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");
    ScoreTableUtil util= new ScoreTableUtil();
    util.getMeasure(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    DataSet dsItem = (DataSet)request.getAttribute("dsItem");
    StringBuffer sbItem = new StringBuffer();
    if (dsItem!=null)
    	while(dsItem.next()){
    		sbItem.append((dsItem.isEmpty("CODE")?"":dsItem.getString("CODE"))+",");
    		sbItem.append((dsItem.isEmpty("ITEMNAME")?"":dsItem.getString("ITEMNAME"))+",");
    		sbItem.append((dsItem.isEmpty("ITEMENTRY")?"":dsItem.getString("ITEMENTRY"))+",");
    		sbItem.append((dsItem.isEmpty("ITEMTYPE")?"":dsItem.getString("ITEMTYPE"))+",");
    		sbItem.append("`");
    	}
    
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("ID")?"0":ds.getString("ID"))+"|");  											//0
    		sb.append((ds.isEmpty("NAME")?"":ds.getString("NAME"))+"|");  										//1
    		sb.append((ds.isEmpty("DETAILDEFINE")?"":Util.toText(ds.getString("DETAILDEFINE")) )+"|"); 			//2
    		sb.append((ds.isEmpty("MEAN")?"":Util.toText(ds.getString("MEAN")) )+"|");							//3
    		sb.append((ds.isEmpty("EQUATIONDEFINE")?"":Util.toText(ds.getString("EQUATIONDEFINE")) )+"|");		//4
    		sb.append((ds.isEmpty("WEIGHT")?"0":ds.getString("WEIGHT"))+"|");									//5
    		sb.append((ds.isEmpty("UNIT")?"":ds.getString("UNIT"))+"|");										//6
    		sb.append((ds.isEmpty("TREND")?"":ds.getString("TREND"))+"|");										//7
    		sb.append((ds.isEmpty("FREQUENCY")?"":ds.getString("FREQUENCY"))+"|");								//8
    		sb.append((ds.isEmpty("MEASUREMENT")?"":ds.getString("MEASUREMENT"))+"|");							//9
    		sb.append((ds.isEmpty("UPDATEID")?"":ds.getString("UPDATEID"))+"|");								//10
    		sb.append((ds.isEmpty("PLANNED")?"0":ds.getString("PLANNED"))+"|");									//11
    		sb.append((ds.isEmpty("BASE")?"0":ds.getString("BASE"))+"|");										//12
    		sb.append((ds.isEmpty("LIMIT")?"0":ds.getString("LIMIT"))+"|");										//13
    		sb.append((ds.isEmpty("EQUATION")?"":Util.toText(ds.getString("EQUATION")))+"|");					//14
    		sb.append((ds.isEmpty("YA1")?"":ds.getString("YA1"))+"|");											//15
    		sb.append((ds.isEmpty("YA2")?"":ds.getString("YA2"))+"|");											//16
    		sb.append((ds.isEmpty("YA3")?"":ds.getString("YA3"))+"|");											//17
    		sb.append((ds.isEmpty("YA4")?"":ds.getString("YA4"))+"|");											//18
    		sb.append((ds.isEmpty("Y")?"":ds.getString("Y"))+"|");												//19
    		sb.append((ds.isEmpty("YB1")?"":ds.getString("YB1"))+"|");											//20
    		sb.append((ds.isEmpty("YB2")?"":ds.getString("YB2"))+"|");											//21
    		sb.append((ds.isEmpty("YB3")?"":ds.getString("YB3"))+"|");											//22
    		sb.append((ds.isEmpty("RANK")?"0":ds.getString("RANK"))+"|");										//23
    		sb.append((ds.isEmpty("ETLKEY")?"0":ds.getString("ETLKEY"))+"|");									//24
    		sb.append((ds.isEmpty("MEASUREID")?"0":ds.getString("MEASUREID"))+"|");								//25
    		sb.append((ds.isEmpty("ONAME")?"":ds.getString("ONAME"))+"|");										//26
    		sb.append((ds.isEmpty("PNAME")?"":ds.getString("PNAME"))+"|");										//27
    		sb.append((ds.isEmpty("USERNAME")?"":ds.getString("USERNAME"))+"|");								//28
    		sb.append(sbItem.toString()+"|");																	//29
    		sb.append((ds.isEmpty("DATASOURCE")?"":ds.getString("DATASOURCE"))+"|");                        //30
    		sb.append((ds.isEmpty("PLANNEDBASE")?"":ds.getString("PLANNEDBASE"))+"|");                        //31
    		sb.append((ds.isEmpty("BASELIMIT")?"":ds.getString("BASELIMIT"))+"|");                        //32    		 
    		sb.append((ds.isEmpty("IFSYSTEM")?"":ds.getString("IFSYSTEM"))+"|");                        //33
    		sb.append((ds.isEmpty("MNGDEPTNM")?"":ds.getString("MNGDEPTNM"))+"|");                        //34
    		sb.append((ds.isEmpty("TARGETRATIONLE")?"":ds.getString("TARGETRATIONLE"))+"|");                        //35   	  
    		
    		sb.append("\r\n");    		
   		} 
    }
    out.println(sb.toString());
%>
