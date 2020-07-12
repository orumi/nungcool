<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>

<%
	String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
    
	ValuateUtil util = new ValuateUtil();
	
	String mode = request.getParameter("mode");
	System.out.println("MODE : "+mode);

	if(mode.equals("Q")){ ///////지표 리스트가져오기  	
		
		util.setMeasure(request, response);
		System.out.println("======================================================");
	
			
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		//System.out.println("DataSet : "+ ds);
		
		if(ds != null){ 
			while(ds.next()){			
				sb.append(ds.getString("PNAME") + "|");
				sb.append(ds.getString("MNAME") + "|");
				sb.append(ds.getString("FREQUENCY") + "|");
				sb.append(ds.getString("PLANNED") + "|");
				sb.append(ds.getString("MEASUREID") + "|");
				sb.append("‡");
			}
		}
		//out.println("DataSet_sb : "+ sb);
		out.println(sb.toString());		
	}else if(mode.equals("W")){

		util.UpdadePland(request, response);
		out.println("complete");
		
	}

	%>