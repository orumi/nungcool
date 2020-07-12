<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	String mode		   = request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	   = request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();
	
	System.out.println("Mode = " +  request.getParameter("mode")  + " : " + request.getParameter("div_gn"));
	
	//------------------------------------------------------------------------------------------		
	//		조회.
	//------------------------------------------------------------------------------------------	
	if(mode.equals("R"))	{ 

			//  사용자별 지표리스트 구하기
			if(div_gn.equals("getUserMeasure"))	{				
				
					MeasureOrgUser util	= new MeasureOrgUser();
					util.getUserMeasure(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
						    		sb.append((ds.isEmpty("sid"    )?"":ds.getString("sid"     ))+"|");
						    		sb.append((ds.isEmpty("snm"    )?"":ds.getString("snm"     ))+"|");
						    		sb.append((ds.isEmpty("bid"    )?"":ds.getString("bid"     ))+"|");
						    		sb.append((ds.isEmpty("bnm"    )?"":ds.getString("bnm"     ))+"|");
						    		sb.append((ds.isEmpty("mid"    )?"":ds.getString("mid"     ))+"|");
						    		sb.append((ds.isEmpty("mnm"    )?"":ds.getString("mnm"     ))+"|");
						    		sb.append((ds.isEmpty("mcid"   )?"":ds.getString("mcid"    ))+"|");
						    		sb.append((ds.isEmpty("mw"     )?"":ds.getString("mw"      ))+"|");
						    		sb.append((ds.isEmpty("freq"   )?"":ds.getString("freq"    ))+"|");

						    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
					
			// 지표에 따른 항목 구하기
			}else if(div_gn.equals("getMeasUser"))	{
					MeasureOrgUser util	= new MeasureOrgUser();
					util.getMeasUser(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("usertype"  )?"":ds.getString("usertype"   )) + "|");
							sb.append((ds.isEmpty("usertypenm")?"":ds.getString("usertypenm" )) + "|");
							sb.append((ds.isEmpty("userid"    )?"":ds.getString("userid"     )) + "|");
							sb.append((ds.isEmpty("usernm"    )?"":ds.getString("usernm"     )) + "|");
				    		sb.append("\r\n");    	
						} 
					}
					
					out.println(sb.toString());
			}			
	//------------------------------------------------------------------------------------------		
	//		등록,수정,삭제
	//------------------------------------------------------------------------------------------	
	} else {
			
			//	지표항목 고정값에 따른 주기별 항목 입력값 등록
			if(div_gn.equals("setMeasUser"))	{
					MeasureOrgUser util	= new MeasureOrgUser();
					util.setMeasUser(request, response);
					
				    String result = (String) request.getAttribute("result");
					if ((result==null) || ("".equals(result))) result="false";
				       
				    out.println(result);		
			}			

			//	지표항목 고정값에 따른 주기별 항목 입력값 등록
			if(div_gn.equals("setMeasUserAll"))	{
					MeasureOrgUser util	= new MeasureOrgUser();
					util.setMeasUserAll(request, response);
					
				    String result = (String) request.getAttribute("result");
					if ((result==null) || ("".equals(result))) result="false";
				       
				    out.println(result);		
			}						
	}
%>
