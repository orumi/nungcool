<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>

<%

	String mode = request.getParameter("mode");
	ValuateUtil util = new ValuateUtil();
	

     
    if("Q".equals(mode)){
	   	util.setEvalMeasure(request, response);
	
		//평가 그룹 지표명 가져 오기 
	    DataSet ds = (DataSet)request.getAttribute("ds");
	    DataSet dsCnt = (DataSet)request.getAttribute("dsCnt");
	    DataSet dsScr = (DataSet)request.getAttribute("dsScr");
	    StringBuffer sb = new StringBuffer();
	    
	    if (ds!=null){
	    	while(ds.next()){ 

	     		sb.append((ds.isEmpty("SNAME")?"0":ds.getString("SNAME"))+"|");
	     		sb.append((ds.isEmpty("BNAME")?"0":ds.getString("BNAME"))+"|");
	     		sb.append((ds.isEmpty("MID")?"":ds.getString("MID"))+"|");
	     		sb.append((ds.isEmpty("MCID")?"":ds.getString("MCID"))+"|");
	     		sb.append((ds.isEmpty("FILEPATH_PLAN")?"":ds.getString("FILEPATH_PLAN"))+"|");
	     		sb.append((ds.isEmpty("FILEPATH_PLAN")?"":ds.getString("FILENAME_PLAN"))+"|");
	     		sb.append((ds.isEmpty("EVALGRADE")?"":ds.getString("EVALGRADE"))+"|");
	     		sb.append("\r\n");    		
	   		} 
	    }
	     out.println(sb.toString());
	     System.out.println("---MCID--"+ds.getString("MCID"));
    	
	}else if("C".equals(mode)) { //데이타 그리드 선택시
		util.setOpinionDetail(request,response);
		
	    DataSet ds = (DataSet)request.getAttribute("ds");
		
	    StringBuffer sb = new StringBuffer();
	    
	    if (ds!=null){
	    	while(ds.next()){ 

	     		sb.append((ds.isEmpty("EVALOPINION")?"":ds.getString("EVALOPINION"))+"|");

	    		sb.append("\r\n");    		
	   		} 
	    }
	     out.println(sb.toString());
	}else if("A".equals(mode)){//평가 결과의견 저장버튼 클릭
		System.out.println("___________________________________________________");
		util.setOpinionDetail(request,response);
	}else if("D".equals(mode)){//평가 결과의견 삭제 버튼 클릭
	System.out.println("-------------------------------------------------------");
	util.setOpinionDetail(request,response);
	}else if("T".equals(mode)){//실적 보기 클릭시 
		util.setViewActual(request,response);
	
	    DataSet ds = (DataSet)request.getAttribute("ds");
	    StringBuffer sb = new StringBuffer();
	   
	    if (ds!=null){
	    	while(ds.next()){ 

	     		sb.append((ds.isEmpty("BNAME")?"":ds.getString("BNAME"))+"|");
	     		sb.append((ds.isEmpty("NAME")?"":ds.getString("NAME"))+"|");  //1
	     		sb.append((ds.isEmpty("PLANNED")?"":ds.getString("PLANNED"))+"|");
	     		sb.append((ds.isEmpty("DETAIL")?"":ds.getString("DETAIL"))+"|"); //3
	     		sb.append((ds.isEmpty("ESTIMATE")?"":ds.getString("ESTIMATE"))+"|");
	     		sb.append((ds.isEmpty("FILEPATH_PLAN")?"":ds.getString("FILEPATH_PLAN"))+"|");// 5  
	     		sb.append((ds.isEmpty("FILENAME_PLAN")?"":ds.getString("FILENAME_PLAN"))+"|");// 계획 첨부파일
	     		sb.append((ds.isEmpty("FILEPATH")?"":ds.getString("FILEPATH"))+"|");// 7  
	     		sb.append((ds.isEmpty("FILENAME")?"":ds.getString("FILENAME"))+"|");// 실적 첨부파일
	    		sb.append("‡");    		
	   		} 
	    }
	    //System.out.println("BNAME : "+ds.getString("BNAME"));
	    //System.out.println("NAME : "+ds.getString("NAME"));
	    
	    System.out.println("FILEPATH_PLAN"+ds.getString("FILEPATH_PLAN"));
	    out.println(sb.toString());
	
	
	
	}else if("I".equals(mode)) { //비계량지표 평가 평가등급 저장 
		util.flexsetEvalMeasure(request,response);
		out.println("--");
	}else if("E".equals(mode)) { //비계량지표 평가 평가등급 삭제  
		util.flexsetEvalMeasure(request,response);
		out.println("--");
	}
%>