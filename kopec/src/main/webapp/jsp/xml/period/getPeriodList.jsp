<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.cool.PeriodUtil,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	PeriodUtil util= new PeriodUtil();
    util.processPeriod(request, response);
	
    DataSet ds = (DataSet)request.getAttribute("ds");
    StringBuffer sb = new StringBuffer();
    if (ds!=null){
    	while(ds.next()){ 
    		sb.append((ds.isEmpty("div_cd")?"0":ds.getString("div_cd"))+"|");				//code
    		sb.append((ds.isEmpty("div_nm")?"":ds.getString("div_nm"))+"|");			    //업무명
    		sb.append((ds.isEmpty("start_dt")?"0":ds.getString("start_dt"))+"|");			//시작일
    		sb.append((ds.isEmpty("end_dt")?"0":ds.getString("end_dt"))+"|");				//종료일
    		sb.append((ds.isEmpty("div_yn")?"0":ds.getString("div_yn"))+"|");	            //상태

    		sb.append((ds.isEmpty("Q1")?"0":ds.getString("Q1"))+"|");    
     		sb.append((ds.isEmpty("Q2")?"0":ds.getString("Q2"))+"|");    
    		sb.append((ds.isEmpty("Q3")?"0":ds.getString("Q3"))+"|");    
     		sb.append((ds.isEmpty("Q4")?"0":ds.getString("Q4"))+"|");    
    		sb.append((ds.isEmpty("M01")?"0":ds.getString("M01"))+"|");  
     		sb.append((ds.isEmpty("M02")?"0":ds.getString("M02"))+"|");  
    		sb.append((ds.isEmpty("M03")?"0":ds.getString("M03"))+"|");  
     		sb.append((ds.isEmpty("M04")?"0":ds.getString("M04"))+"|");  
    		sb.append((ds.isEmpty("M05")?"0":ds.getString("M05"))+"|");  
     		sb.append((ds.isEmpty("M06")?"0":ds.getString("M06"))+"|");  
    		sb.append((ds.isEmpty("M07")?"0":ds.getString("M07"))+"|");  
     		sb.append((ds.isEmpty("M08")?"0":ds.getString("M08"))+"|");  
    		sb.append((ds.isEmpty("M09")?"0":ds.getString("M09"))+"|");  
     		sb.append((ds.isEmpty("M10")?"0":ds.getString("M10"))+"|");  
    		sb.append((ds.isEmpty("M11")?"0":ds.getString("M11"))+"|");  
     		sb.append((ds.isEmpty("M12")?"0":ds.getString("M12"))+"|");  
    		
    		sb.append("\r\n");    		
   		} 
    }
    //System.out.println(sb.toString());
    out.println(sb.toString());

%>
