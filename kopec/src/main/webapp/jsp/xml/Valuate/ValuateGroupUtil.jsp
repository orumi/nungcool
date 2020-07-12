<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");

	String mode		   = request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	   = request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();

	//------------------------------------------------------------------------------------------		
	//		조회.
	//------------------------------------------------------------------------------------------	
	if(mode.equals("R"))	{
		
			System.out.println("div_gb :" + div_gn);

			// 평가조직별 평가위원 구함.
			if(div_gn.equals("getValuateOrgGroup"))	{
					ValuateGroupUtil util =  new ValuateGroupUtil();
					util.getValuateOrgGroup(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("sid"         )?"":ds.getString("sid"     ))+"|");
							sb.append((ds.isEmpty("scid"        )?"":ds.getString("scid"    ))+"|");
							sb.append((ds.isEmpty("sname"       )?"":ds.getString("sname"   ))+"|");
							sb.append((ds.isEmpty("bid"         )?"":ds.getString("bid"     ))+"|");
							sb.append((ds.isEmpty("bcid"        )?"":ds.getString("bcid"    ))+"|");
							sb.append((ds.isEmpty("bname"       )?"":ds.getString("bname"   ))+"|");
							sb.append((ds.isEmpty("grpid"       )?"":ds.getString("grpid"   ))+"|");
							sb.append((ds.isEmpty("empno"       )?"":ds.getString("empno"   ))+"|");
							sb.append((ds.isEmpty("empnm"       )?"":ds.getString("empnm"   ))+"|");
							
				    		sb.append("\r\n");    	
						} 
					}		
					out.println(sb.toString());
					
			// 평가위원 구함.
			}else if(div_gn.equals("getValuator"))	{
					ValuateGroupUtil util =  new ValuateGroupUtil();
					util.getValuator(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("deptcd"      )?"":ds.getString("deptcd"     ))+"|");
							sb.append((ds.isEmpty("deptnm"      )?"":ds.getString("deptnm"     ))+"|");
							sb.append((ds.isEmpty("userid"      )?"":ds.getString("userid"     ))+"|");
							sb.append((ds.isEmpty("usernm"      )?"":ds.getString("usernm"     ))+"|");
							
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
			}	
			
	//------------------------------------------------------------------------------------------		
	//		등록,수정,삭제
	//------------------------------------------------------------------------------------------	
	} else {
			
			// 평가그룹 및 평가위원 설정
			if(div_gn.equals("setOrgValuator"))	{
					ValuateGroupUtil util =  new ValuateGroupUtil();
					util.setOrgValuator(request, response);
					
					out.println("true");				
			}					
	}
	
	
	
%>
