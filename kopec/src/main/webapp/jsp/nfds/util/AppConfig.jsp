<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*, 
                 com.nc.cool.*" 
%>
<%
	request.setCharacterEncoding("UTF-8"); 

	String mode		   = request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();

	//------------------------------------------------------------------------------------------		
	//		조회.
	//------------------------------------------------------------------------------------------	
	if(mode.equals("Q")||mode.equals("R"))	{ 
			AppConfigUtil util	= new AppConfigUtil();
			util.getConfig(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){   
					sb.append((ds.isEmpty("fixedym"      )?"":ds.getString("fixedym"        )) +"|");
					sb.append((ds.isEmpty("curymyn"      )?"":ds.getString("curymyn"        )) +"|");

					sb.append((ds.isEmpty("sysdt"        )?"":ds.getString("sysdt"          )) +"|");
					sb.append((ds.isEmpty("showym"       )?"":ds.getString("showym"         )) +"|");
					sb.append((ds.isEmpty("showyear"     )?"":ds.getString("showyear"       )) +"|");
					sb.append((ds.isEmpty("showmonth"    )?"":ds.getString("showmonth"      )) +"|");
										
					sb.append("\r\n");
				} 
			}
			out.println(Util.toTextForFlexList(sb.toString()));	
			System.out.println("AppConfig.jsp "+Util.toTextForFlexList(sb.toString()));	
	}

	//------------------------------------------------------------------------------------------		
	//		등록,수정,삭제
	//------------------------------------------------------------------------------------------	
	else if(mode.equals("U"))	{ 
		AppConfigUtil util	= new AppConfigUtil();
		util.setConfig(request, response);
		out.println((String)request.getAttribute("rslt"));
	}
%>
