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
				
					MeasureItemlUtil util	= new MeasureItemlUtil();
					util.getUserMeasure(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
						    		sb.append((ds.isEmpty("sid"      )?"":ds.getString("sid"      ))+"|");
						    		sb.append((ds.isEmpty("sname"    )?"":ds.getString("sname"    ))+"|");
						    		sb.append((ds.isEmpty("bid"      )?"":ds.getString("bid"      ))+"|");
						    		sb.append((ds.isEmpty("bname"    )?"":ds.getString("bname"    ))+"|");
						    		sb.append((ds.isEmpty("mid"      )?"":ds.getString("mid"      ))+"|");
						    		sb.append((ds.isEmpty("mname"    )?"":ds.getString("mname"    ))+"|");
						    		sb.append((ds.isEmpty("mcid"     )?"":ds.getString("mcid"     ))+"|");
						    		sb.append((ds.isEmpty("mweight"  )?"":ds.getString("mweight"  ))+"|");
						    		sb.append((ds.isEmpty("frequency")?"":ds.getString("frequency"))+"|");
						    		sb.append((ds.isEmpty("itemcount")?"":ds.getString("itemcount"))+"|");
						    		sb.append((ds.isEmpty("itemfixed")?"":ds.getString("itemfixed"))+"|");
						    		sb.append((ds.isEmpty("unit")?"":ds.getString("unit"))+"|");
						    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
					
			// 지표에 따른 항목 구하기
			}else if(div_gn.equals("getMeasItem"))	{
					MeasureItemlUtil util	= new MeasureItemlUtil();
					util.getMeasItem(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("measureid"  )?"":ds.getString("measureid"   )) + "|");
							sb.append((ds.isEmpty("code"  )?"":ds.getString("code"   )) + "|");
							sb.append((ds.isEmpty("itemname"  )?"":ds.getString("itemname"   )) + "|");
							sb.append((ds.isEmpty("itementry"  )?"":ds.getString("itementry"   )) + "|");
							sb.append((ds.isEmpty("itemfixed" )?"":ds.getString("itemfixed"  )) + "|");
				    		sb.append("\r\n");    	
						} 
					}
					
					out.println(sb.toString());
					
			// 지표항목 고정값에 따른 주기별 항목 입력값 구하기 
			}else if(div_gn.equals("getMeasItemFixedValue"))	{
					MeasureItemlUtil util	= new MeasureItemlUtil();
					util.getMeasItemFixedValue(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 

							sb.append((ds.isEmpty("measureid"  )?"":ds.getString("measureid"   )) + "|");
							sb.append((ds.isEmpty("code"  )?"":ds.getString("code"   )) + "|");
							sb.append((ds.isEmpty("strdate"  )?"":ds.getString("strdate"   )) + "|");
							sb.append((ds.isEmpty("actual"  )?"":ds.getString("actual"   )) + "|");			
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
			if(div_gn.equals("setMeasItemFixedValue"))	{
					MeasureItemlUtil util	= new MeasureItemlUtil();
					util.setMeasItemFixedValue(request, response);
					
					out.println("true");			
			}			
		
	}
	
	
	
%>
