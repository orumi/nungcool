<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	String mode		= request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();

	//System.out.println("CEO:"+mode+"/"+div_gn);
	if(mode.equals("R"))	{
		if(div_gn.equals("getCeoOrgBscStatus"))	{
			MeasReportUtil ceo	= new MeasReportUtil();
			ceo.getCeoOrgBscStatus(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("sid")?"":ds.getString("sid"))+"|");
		    		sb.append((ds.isEmpty("sname")?"":ds.getString("sname"))+"|");
		    		sb.append((ds.isEmpty("bcid")?"":ds.getString("bcid"))+"|");
		    		sb.append((ds.isEmpty("bname")?"":ds.getString("bname"))+"|");
		    		sb.append((ds.isEmpty("bscore")?"":ds.getString("bscore"))+"|");
		    		sb.append((ds.isEmpty("grade_s")?"":ds.getString("grade_s"))+"|");
					sb.append((ds.isEmpty("grade_a")?"":ds.getString("grade_a"))+"|");
					sb.append((ds.isEmpty("grade_b")?"":ds.getString("grade_b"))+"|");
					sb.append((ds.isEmpty("grade_c")?"":ds.getString("grade_c"))+"|");
					sb.append((ds.isEmpty("grade_d")?"":ds.getString("grade_d"))+"|");
		    		sb.append((ds.isEmpty("notinput")?"":ds.getString("notinput"))+"|");	    		
		    		sb.append("\r\n");    	
				} 
			}

			out.println(sb.toString());
			
		}else if(div_gn.equals("getCeoOrgPstStatus"))	{
			MeasReportUtil ceo	= new MeasReportUtil();
			ceo.getCeoOrgPstStatus(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			
			if (ds!=null){
				while(ds.next()){ 
					//System.out.println("getCeoOrgPstStatus : "+ds.getString("bname"));
		    		sb.append((ds.isEmpty("name")?"":ds.getString("name"))+"|");
		    		sb.append((ds.isEmpty("pcscore")?"":ds.getString("pcscore"))+"|"); 		
		    		sb.append("\r\n"); 	
		    		
				} 
			}
			
			out.println(sb.toString());
		}else if(div_gn.equals("getCeoOrgMeasStatus"))	{
			MeasReportUtil ceo	= new MeasReportUtil();
			ceo.getCeoOrgMeasStatus(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			
			if (ds!=null){
				while(ds.next()){
					String comments = ds.isEmpty("comments")?"":ds.getString("comments");
					comments = comments.replaceAll("\r\n","&&enter&&");
					
		    		sb.append((ds.isEmpty("pname")?"":ds.getString("pname"))+"|");
		    		sb.append((ds.isEmpty("mname")?"":ds.getString("mname"))+"|");
		    		sb.append((ds.isEmpty("score")?"":ds.getString("score"))+"|");
		    		sb.append(comments+"|");	    		
		    		sb.append("\r\n"); 	
		    		
				} 
			}

			out.println(sb.toString());
		}
	}		
	
	
%>
