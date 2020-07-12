<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	String mode		   = request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	   = request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();

	//------------------------------------------------------------------------------------------		
	//		조회.
	//------------------------------------------------------------------------------------------	
	if(mode.equals("R"))	{

			//  사업단 인원 구하기	
			if(div_gn.equals("getBizManCnt"))	{
					EISBizUtil eis	= new EISBizUtil();
					eis.getBizManCnt(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
				    		sb.append((ds.isEmpty("dept_cd")?"":ds.getString("dept_cd"))+"|");
				    		sb.append((ds.isEmpty("dept_nm")?"":ds.getString("dept_nm"))+"|");
				    		sb.append((ds.isEmpty("man_gbn_cd")?"":ds.getString("man_gbn_cd"))+"|");
				    		sb.append((ds.isEmpty("man_gbn_nm")?"":ds.getString("man_gbn_nm"))+"|");
				    		sb.append((ds.isEmpty("full_cnt")?"":ds.getString("full_cnt"))+"|");
				    		sb.append((ds.isEmpty("curr_cnt")?"":ds.getString("curr_cnt"))+"|");
				    		sb.append((ds.isEmpty("flag")?"":ds.getString("flag"))+"|");    		
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
					
			//  사업단 공통코드 
			}else	if(div_gn.equals("getBizDeptCd"))	{
							EISBizUtil eis	= new EISBizUtil();
							eis.getBizDeptCd(request, response);
							
							DataSet ds = (DataSet)request.getAttribute("ds");
							StringBuffer sb = new StringBuffer();
							if (ds!=null){
								while(ds.next()){ 
						    		sb.append((ds.isEmpty("dept_cd")?"":ds.getString("dept_cd"))+"|");
						    		sb.append((ds.isEmpty("dept_nm")?"":ds.getString("dept_nm"))+"|");
						    		sb.append("\r\n");    	
								} 
							}
				
							out.println(sb.toString());		
							
			//  사업단 공통코드 
			}else	if(div_gn.equals("getBizYearDept"))	{
							EISBizUtil eis	= new EISBizUtil();
							eis.getBizYearDept(request, response);
							
							DataSet ds = (DataSet)request.getAttribute("ds");
							StringBuffer sb = new StringBuffer();
							if (ds!=null){
								while(ds.next()){ 
						    		sb.append((ds.isEmpty("dept_cd")?"":ds.getString("dept_cd"))+"|");
						    		sb.append((ds.isEmpty("dept_nm")?"":ds.getString("dept_nm"))+"|");
						    		sb.append((ds.isEmpty("year")?"":ds.getString("year"))+"|");						    		
						    		sb.append("\r\n");    	
								} 
							}
				
							out.println(sb.toString());										
					
			// 사업단별 영업현황을 구함.		
			}else if(div_gn.equals("getBizDept"))	{
					EISBizUtil eis	= new EISBizUtil();
					eis.getBizDept(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("dept_cd"              )?"":ds.getString("dept_cd"              )) + "|");
							sb.append((ds.isEmpty("dept_nm"              )?"":ds.getString("dept_nm"              )) + "|");
							sb.append((ds.isEmpty("cont_plan_svc"        )?"":ds.getString("cont_plan_svc"        )) + "|");
							sb.append((ds.isEmpty("cont_actual_svc"      )?"":ds.getString("cont_actual_svc"      )) + "|");
							sb.append((ds.isEmpty("cont_forecast_svc"    )?"":ds.getString("cont_forecast_svc"    )) + "|");
							sb.append((ds.isEmpty("cont_plan_const"      )?"":ds.getString("cont_plan_const"      )) + "|");
							sb.append((ds.isEmpty("cont_actual_const"    )?"":ds.getString("cont_actual_const"    )) + "|");
							sb.append((ds.isEmpty("cont_forecast_const"  )?"":ds.getString("cont_forecast_const"  )) + "|");
							sb.append((ds.isEmpty("sales_plan_svc"       )?"":ds.getString("sales_plan_svc"       )) + "|");
							sb.append((ds.isEmpty("sales_actual_svc"     )?"":ds.getString("sales_actual_svc"     )) + "|");
							sb.append((ds.isEmpty("sales_forecast_svc"   )?"":ds.getString("sales_forecast_svc"   )) + "|");
							sb.append((ds.isEmpty("sales_plan_const"     )?"":ds.getString("sales_plan_const"     )) + "|");
							sb.append((ds.isEmpty("sales_actual_const"   )?"":ds.getString("sales_actual_const"   )) + "|");
							sb.append((ds.isEmpty("sales_forecast_const" )?"":ds.getString("sales_forecast_const" )) + "|");
							sb.append((ds.isEmpty("contract_amt"         )?"":ds.getString("contract_amt"         )) + "|");
							sb.append((ds.isEmpty("sales_cost_plan"      )?"":ds.getString("sales_cost_plan"      )) + "|");
							sb.append((ds.isEmpty("sales_cost_actual"    )?"":ds.getString("sales_cost_actual"    )) + "|");
							sb.append((ds.isEmpty("sales_cost_forecast"  )?"":ds.getString("sales_cost_forecast"  )) + "|");
							sb.append((ds.isEmpty("sales_profit_plan"    )?"":ds.getString("sales_profit_plan"    )) + "|");
							sb.append((ds.isEmpty("sales_profit_actual"  )?"":ds.getString("sales_profit_actual"  )) + "|");
							sb.append((ds.isEmpty("sales_profit_forecast")?"":ds.getString("sales_profit_forecast")) + "|");
						
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
					
			// 전사손익을 구함.
			}else if(div_gn.equals("getBizSonYik"))	{
					EISBizUtil eis	= new EISBizUtil();
					eis.getBizSonYik(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("dept_cd"              )?"":ds.getString("dept_cd"              )) + "|");
							sb.append((ds.isEmpty("dept_nm"              )?"":ds.getString("dept_nm"              )) + "|");
							sb.append((ds.isEmpty("sales_plan_svc"       )?"":ds.getString("sales_plan_svc"       )) + "|");
							sb.append((ds.isEmpty("sales_actual_svc"     )?"":ds.getString("sales_actual_svc"     )) + "|");
							sb.append((ds.isEmpty("sales_forecast_svc"   )?"":ds.getString("sales_forecast_svc"   )) + "|");
							sb.append((ds.isEmpty("sales_cost_plan"      )?"":ds.getString("sales_cost_plan"      )) + "|");
							sb.append((ds.isEmpty("sales_cost_actual"    )?"":ds.getString("sales_cost_actual"    )) + "|");
							sb.append((ds.isEmpty("sales_cost_forecast"  )?"":ds.getString("sales_cost_forecast"  )) + "|");
							sb.append((ds.isEmpty("sales_profit_plan"    )?"":ds.getString("sales_profit_plan"    )) + "|");
							sb.append((ds.isEmpty("sales_profit_actual"  )?"":ds.getString("sales_profit_actual"  )) + "|");
							sb.append((ds.isEmpty("sales_profit_forecast")?"":ds.getString("sales_profit_forecast")) + "|");
						
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
			}	
	//------------------------------------------------------------------------------------------		
	//		등록,수정,삭제
	//------------------------------------------------------------------------------------------	
	} else {
			
			// 사업단 인원저장 
			if(div_gn.equals("setBizManCnt"))	{
					EISBizUtil eis	= new EISBizUtil();
					eis.setBizManCnt(request, response);
					
					out.println("true");
					
			//	 년도별 사업단 저장 
			}else if(div_gn.equals("setBizYearDept"))	{
				
					EISBizUtil eis	= new EISBizUtil();
					eis.setBizYearDept(request, response);
	
					out.println("true");					
				
			//  기관별 실적입력 - 매출액
			}else if(div_gn.equals("setBizDeptSales"))	{
				
					EISBizUtil eis	= new EISBizUtil();
					eis.setBizDeptSales(request, response);
	
					out.println("true");
			
					
			//  기관별 실적입력 - 손익
			} else if (div_gn.equals("setBizDeptCost"))	{
					EISBizUtil eis	= new EISBizUtil();
					eis.setBizDeptCost(request, response);
					
					out.println("true");

			//  기관별 실적입력 -수주
			}else if (div_gn.equals("setBizDeptCont"))	{
					
					EISBizUtil eis	= new EISBizUtil();
					eis.setBizDeptCont(request, response);
					
					out.println("true");
			}			
		
	}
	
	
	
%>
