<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	String mode		= request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String eis_no	= request.getParameter("eis_no") == null ? "" : (request.getParameter("eis_no")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();
	
	System.out.println(".jsp pages accepted mode : "+mode);
	System.out.println(".jsp pages accepted eis_no : "+eis_no);
	System.out.println(".jsp pages accepted div_gn : "+div_gn);
	
	if(mode.equals("R"))	{
		if(div_gn.equals("01"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisTeSalesAmt(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("BIZ_LDIV_CD")?"":ds.getString("BIZ_LDIV_CD"))+"|");
					sb.append((ds.isEmpty("BIZ_SDIV_CD")?"":ds.getString("BIZ_SDIV_CD"))+"|");
					sb.append((ds.isEmpty("BEF_SALE_AMT")?"":ds.getString("BEF_SALE_AMT"))+"|");
					sb.append((ds.isEmpty("PLAN_AMT")?"":ds.getString("PLAN_AMT"))+"|");
					sb.append((ds.isEmpty("ACTUAL_AMT")?"":ds.getString("ACTUAL_AMT"))+"|");
					sb.append((ds.isEmpty("VARIATION")?"":ds.getString("VARIATION"))+"|");
					sb.append((ds.isEmpty("ACHIEVE_RATE")?"":ds.getString("ACHIEVE_RATE"))+"|");
					sb.append((ds.isEmpty("PRE_YEAR_VARIAT")?"":ds.getString("PRE_YEAR_VARIAT"))+"|");
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());
		}else if(div_gn.equals("02"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisTeContractAmt(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("DEPT_NM")?"":ds.getString("DEPT_NM"))+"|");
					sb.append((ds.isEmpty("BEF_CONT_AMT")?"":ds.getString("BEF_CONT_AMT"))+"|");
					sb.append((ds.isEmpty("SALE_AMT")?"":ds.getString("SALE_AMT"))+"|");
					sb.append((ds.isEmpty("C0NT_AMT")?"":ds.getString("C0NT_AMT"))+"|");
					sb.append((ds.isEmpty("END_YEAR_CONTRACT_BALANCE")?"":ds.getString("END_YEAR_CONTRACT_BALANCE"))+"|");
					sb.append((ds.isEmpty("PRE_YEAR_VARIAT")?"":ds.getString("PRE_YEAR_VARIAT"))+"|");
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());
		}else if(div_gn.equals("03"))	{
			String nat_gbn_cd_s = "";
			int patent_apply_s = 0;
			int patent_regi_s = 0;
			int brend_regi_s = 0;
			int tech_regi_s = 0;
			int copyright_s = 0;
			int program_s = 0;
			int sum_s = 0;
			
			int ii = 0;
			
			EISAdministration eis	= new EISAdministration();
			eis.getEisTeIntellActual(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("NAT_GBN_CD")?"":ds.getString("NAT_GBN_CD"))+"|");
					sb.append((ds.isEmpty("PATENT_APPLY")?"":ds.getString("PATENT_APPLY"))+"|");
					sb.append((ds.isEmpty("PATENT_REGI")?"":ds.getString("PATENT_REGI"))+"|");
					sb.append((ds.isEmpty("BREND_REGI")?"":ds.getString("BREND_REGI"))+"|");
					sb.append((ds.isEmpty("TECH_REGI")?"":ds.getString("TECH_REGI"))+"|");
					sb.append((ds.isEmpty("COPYRIGHT")?"":ds.getString("COPYRIGHT"))+"|");
					sb.append((ds.isEmpty("PROGRAM")?"":ds.getString("PROGRAM"))+"|");
					sb.append((ds.isEmpty("SUM")?"":ds.getString("SUM"))+"|");
					sb.append("\r\n"); 
					
					if(ds.getString("PATENT_APPLY") != null)	{
						if(ds.getString("PATENT_APPLY").trim() != "")	{
							patent_apply_s = patent_apply_s + Integer.parseInt(ds.getString("PATENT_APPLY").trim());
						}
					}
					if(ds.getString("PATENT_REGI") != null)	{
						if(ds.getString("PATENT_REGI").trim() != "")	{
							patent_regi_s = patent_regi_s + Integer.parseInt(ds.getString("PATENT_REGI").trim());
						}
					}
					if(ds.getString("BREND_REGI") != null)	{
						if(ds.getString("BREND_REGI").trim() != "")	{
							brend_regi_s = brend_regi_s + Integer.parseInt(ds.getString("BREND_REGI").trim());
						}
					}
					if(ds.getString("TECH_REGI") != null)	{
						if(ds.getString("TECH_REGI").trim() != "")	{
							tech_regi_s = tech_regi_s + Integer.parseInt(ds.getString("TECH_REGI").trim());
						}
					}
					if(ds.getString("COPYRIGHT") != null)	{
						if(ds.getString("COPYRIGHT").trim() != "")	{
							copyright_s = copyright_s + Integer.parseInt(ds.getString("COPYRIGHT").trim());
						}
					}
					if(ds.getString("PROGRAM") != null)	{
						if(ds.getString("PROGRAM").trim() != "")	{
							program_s = program_s + Integer.parseInt(ds.getString("PROGRAM").trim());
						}
					}
					if(ds.getString("SUM") != null)	{
						if(ds.getString("SUM").trim() != "")	{
							sum_s = sum_s + Integer.parseInt(ds.getString("SUM").trim());
						}
					}
					/*
					if(ii == 1)	{
						patent_apply_s = patent_apply_s + integer.parseInt(;
						patent_regi_s = 0;
						brend_regi_s = 0;
						tech_regi_s = 0;
						copyright_s = 0;
						program_s = 0;
						sum_s = 0;
						
						System.out.println(ds.getString("PATENT_APPLY") + " | ");
						System.out.println(ds.getString("PATENT_REGI") + " | ");
						System.out.println(ds.getString("BREND_REGI") + " | ");
						System.out.println(ds.getString("TECH_REGI") + " | ");
						System.out.println(ds.getString("COPYRIGHT") + " | ");
						System.out.println(ds.getString("PROGRAM") + " | ");
						System.out.println(ds.getString("SUM") + " | ");
						System.out.println("\r\n");
					}
					*/
					ii++;
				}

				if(ii > 0)	{
					sb.append("합계|");
					sb.append(String.valueOf(patent_apply_s)+"|");
					sb.append(String.valueOf(patent_regi_s)+"|");
					sb.append(String.valueOf(brend_regi_s)+"|");
					sb.append(String.valueOf(tech_regi_s)+"|");
					sb.append(String.valueOf(copyright_s)+"|");
					sb.append(String.valueOf(program_s)+"|");
					sb.append(String.valueOf(sum_s)+"|");
					sb.append("\r\n");  
				}
			}

			out.println(sb.toString());
		}else	{
			EISAdministration eis	= new EISAdministration();
		    eis.getRptFormList(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append((ds.isEmpty("EIS_NO")?"":ds.getString("EIS_NO"))+"|");
		    		sb.append((ds.isEmpty("EIS_NM")?"":ds.getString("EIS_NM"))+"|");
		    		sb.append((ds.isEmpty("LDIV_CD")?"":ds.getString("LDIV_CD"))+"|");
		    		sb.append((ds.isEmpty("LDIV_NM")?"":ds.getString("LDIV_NM"))+"|");
		    		sb.append((ds.isEmpty("SDIV_CD")?"":ds.getString("SDIV_CD"))+"|");
		    		sb.append((ds.isEmpty("SDIV_NM")?"":ds.getString("SDIV_NM"))+"|");
		    		sb.append((ds.isEmpty("VAL1")?"":ds.getString("VAL1"))+"|");
		    		sb.append((ds.isEmpty("VAL2")?"":ds.getString("VAL2"))+"|");
		    		sb.append((ds.isEmpty("VAL3")?"":ds.getString("VAL3"))+"|");
		    		sb.append((ds.isEmpty("VAL4")?"":ds.getString("VAL4"))+"|");
		    		sb.append((ds.isEmpty("VAL5")?"":ds.getString("VAL5"))+"|");
		    		sb.append((ds.isEmpty("VAL6")?"":ds.getString("VAL6"))+"|");
		    		sb.append((ds.isEmpty("VAL7")?"":ds.getString("VAL7"))+"|");
		    		sb.append((ds.isEmpty("DISP_ORD")?"":ds.getString("DISP_ORD"))+"|");
		    		sb.append("\r\n");    		
		   		} 
		    }
		    
		    out.println(sb.toString());
		}
	}
	
	if(mode.equals("B"))	{
		if(div_gn.equals("01"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisTeManCnt(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("EIS_YEAR")?"":ds.getString("EIS_YEAR"))+"|"); 	
					sb.append((ds.isEmpty("IY_VAL")?"":ds.getString("IY_VAL"))+"|"); 	
					sb.append((ds.isEmpty("IYF_VAL")?"":ds.getString("IYF_VAL"))+"|"); 	
					sb.append((ds.isEmpty("JK_VAL")?"":ds.getString("JK_VAL"))+"|"); 	
					sb.append((ds.isEmpty("JKF_VAL")?"":ds.getString("JKF_VAL"))+"|"); 	
					sb.append((ds.isEmpty("BJ_VAL")?"":ds.getString("BJ_VAL"))+"|"); 	
					sb.append((ds.isEmpty("BJF_VAL")?"":ds.getString("BJF_VAL"))+"|"); 	
					sb.append((ds.isEmpty("YK_VAL")?"":ds.getString("YK_VAL"))+"|"); 	
					sb.append((ds.isEmpty("YB_VAL")?"":ds.getString("YB_VAL"))+"|"); 	
					sb.append((ds.isEmpty("JJ_VAL")?"":ds.getString("JJ_VAL"))+"|"); 	
					sb.append((ds.isEmpty("IYC_VAL")?"":ds.getString("IYC_VAL"))+"|"); 	
					sb.append((ds.isEmpty("JKC_VAL")?"":ds.getString("JKC_VAL"))+"|"); 	
					sb.append((ds.isEmpty("BJC_VAL")?"":ds.getString("BJC_VAL"))+"|"); 	
					sb.append((ds.isEmpty("JH_VAL")?"":ds.getString("JH_VAL"))+"|"); 	
					sb.append((ds.isEmpty("HH_VAL")?"":ds.getString("HH_VAL"))+"|"); 	
					sb.append((ds.isEmpty("HM_VAL")?"":ds.getString("HM_VAL"))+"|"); 	
					sb.append((ds.isEmpty("IY_NAME")?"":ds.getString("IY_NAME"))+"|"); 	
					sb.append((ds.isEmpty("JK_NAME")?"":ds.getString("JK_NAME"))+"|"); 	
					sb.append((ds.isEmpty("BJ_NAME")?"":ds.getString("BJ_NAME"))+"|"); 	
					sb.append((ds.isEmpty("YK_NAME")?"":ds.getString("YK_NAME"))+"|"); 	
					sb.append((ds.isEmpty("YB_NAME")?"":ds.getString("YB_NAME"))+"|"); 	
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());
			
		// 손익	
		}else if(div_gn.equals("02"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisBizSalesStatus(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("YM")?"":ds.getString("YM"))+"|");
					sb.append((ds.isEmpty("SALES_PLAN")?"":ds.getString("SALES_PLAN"))+"|");
					sb.append((ds.isEmpty("SALES_ACTUAL")?"":ds.getString("SALES_ACTUAL"))+"|"); 
					sb.append((ds.isEmpty("SALES_FORECAST")?"":ds.getString("SALES_FORECAST"))+"|"); 
					sb.append((ds.isEmpty("SALES_COST_PLAN")?"":ds.getString("SALES_COST_PLAN"))+"|"); 
					sb.append((ds.isEmpty("SALES_COST_ACTUAL")?"":ds.getString("SALES_COST_ACTUAL"))+"|"); 
					sb.append((ds.isEmpty("SALES_COST_FORECAST")?"":ds.getString("SALES_COST_FORECAST"))+"|"); 
					sb.append((ds.isEmpty("SALES_PROFIT_PLAN")?"":ds.getString("SALES_PROFIT_PLAN"))+"|"); 
					sb.append((ds.isEmpty("SALES_PROFIT_ACTUAL")?"":ds.getString("SALES_PROFIT_ACTUAL"))+"|"); 
					sb.append((ds.isEmpty("SALES_PROFIT_FORECAST")?"":ds.getString("SALES_PROFIT_FORECAST"))+"|"); 
					sb.append((ds.isEmpty("SALES_PLAN_G")?"":ds.getString("SALES_PLAN_G"))+"|");
					sb.append((ds.isEmpty("SALES_ACTUAL_G")?"":ds.getString("SALES_ACTUAL_G"))+"|"); 
					sb.append((ds.isEmpty("SALES_FORECAST_G")?"":ds.getString("SALES_FORECAST_G"))+"|"); 
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());
		}else if(div_gn.equals("03"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisBizSalesDeptStatus(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("YM")?"":ds.getString("YM"))+"|");																	
					sb.append((ds.isEmpty("DEPT_CD")?"":ds.getString("DEPT_CD"))+"|");																	
					sb.append((ds.isEmpty("DIV_NM")?"":ds.getString("DIV_NM"))+"|");															
					sb.append((ds.isEmpty("SALES_PLAN")?"":ds.getString("SALES_PLAN"))+"|");														
					sb.append((ds.isEmpty("SALES_ACTUAL")?"":ds.getString("SALES_ACTUAL"))+"|");															
					sb.append((ds.isEmpty("SALES_FORECAST")?"":ds.getString("SALES_FORECAST"))+"|");															
					sb.append((ds.isEmpty("SALES_COST_PLAN")?"":ds.getString("SALES_COST_PLAN"))+"|");														
					sb.append((ds.isEmpty("SALES_COST_ACTUAL")?"":ds.getString("SALES_COST_ACTUAL"))+"|");														
					sb.append((ds.isEmpty("SALES_COST_FORECAST")?"":ds.getString("SALES_COST_FORECAST"))+"|");														
					sb.append((ds.isEmpty("SALES_PROFIT_PLAN")?"":ds.getString("SALES_PROFIT_PLAN"))+"|");														
					sb.append((ds.isEmpty("SALES_PROFIT_ACTUAL")?"":ds.getString("SALES_PROFIT_ACTUAL"))+"|");														
					sb.append((ds.isEmpty("SALES_PROFIT_FORECAST")?"":ds.getString("SALES_PROFIT_FORECAST"))+"|");															
					sb.append((ds.isEmpty("SALES_PLAN_G")?"":ds.getString("SALES_PLAN_G"))+"|");														
					sb.append((ds.isEmpty("SALES_ACTUAL_G")?"":ds.getString("SALES_ACTUAL_G"))+"|");															
					sb.append((ds.isEmpty("SALES_FORECAST_G")?"":ds.getString("SALES_FORECAST_G"))+"|");															
					sb.append((ds.isEmpty("CONTRACT_AMT")?"":ds.getString("CONTRACT_AMT"))+"|");		
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());
		}else if(div_gn.equals("04"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisBizContractStatus(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("YM")?"":ds.getString("YM"))+"|");
					sb.append((ds.isEmpty("DEPT_CD")?"":ds.getString("DEPT_CD"))+"|");
					sb.append((ds.isEmpty("DIV_NM")?"":ds.getString("DIV_NM"))+"|");
					sb.append((ds.isEmpty("CONT_PLAN_SVC")?"":ds.getString("CONT_PLAN_SVC"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_SVC")?"":ds.getString("CONT_ACTUAL_SVC"))+"|");
					sb.append((ds.isEmpty("CONT_SVC_PER_CALC")?"":ds.getString("CONT_SVC_PER_CALC"))+"|");
					sb.append((ds.isEmpty("CONT_PLAN_CONST")?"":ds.getString("CONT_PLAN_CONST"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_CONST")?"":ds.getString("CONT_ACTUAL_CONST"))+"|");
					sb.append((ds.isEmpty("CONT_CONST_PER_CALC")?"":ds.getString("CONT_CONST_PER_CALC"))+"|");	
					sb.append((ds.isEmpty("CONT_PLAN")?"":ds.getString("CONT_PLAN"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL")?"":ds.getString("CONT_ACTUAL"))+"|");	
					sb.append((ds.isEmpty("CONT_PER_SUM_CALC")?"":ds.getString("CONT_PER_SUM_CALC"))+"|");
					sb.append((ds.isEmpty("CONT_PLAN_SVC_SUM")?"":ds.getString("CONT_PLAN_SVC_SUM"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_SVC_SUM")?"":ds.getString("CONT_ACTUAL_SVC_SUM"))+"|");	
					sb.append((ds.isEmpty("CONT_SVC_SUM_CALC")?"":ds.getString("CONT_SVC_SUM_CALC"))+"|");
					sb.append((ds.isEmpty("CONT_PLAN_CONST_SUM")?"":ds.getString("CONT_PLAN_CONST_SUM"))+"|");	
					sb.append((ds.isEmpty("CONT_ACTUAL_CONST_SUM")?"":ds.getString("CONT_ACTUAL_CONST_SUM"))+"|");
					sb.append((ds.isEmpty("CONT_CONST_SUM_CALC")?"":ds.getString("CONT_CONST_SUM_CALC"))+"|");	
					sb.append((ds.isEmpty("CONT_PLAN_SUM")?"":ds.getString("CONT_PLAN_SUM"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_SUM")?"":ds.getString("CONT_ACTUAL_SUM"))+"|");	
					sb.append((ds.isEmpty("CONT_SUM_CALC")?"":ds.getString("CONT_SUM_CALC"))+"|");
					sb.append((ds.isEmpty("CONT_FORECAST_SVC")?"":ds.getString("CONT_FORECAST_SVC"))+"|");	
					sb.append((ds.isEmpty("CONT_FORECAST_CONST")?"":ds.getString("CONT_FORECAST_CONST"))+"|");
					sb.append((ds.isEmpty("CONT_FORECAST")?"":ds.getString("CONT_FORECAST"))+"|");
					sb.append((ds.isEmpty("CONT_FORECAST_SVC_SUM")?"":ds.getString("CONT_FORECAST_SVC_SUM"))+"|");	
					sb.append((ds.isEmpty("CONT_FORECAST_CONST_SUM")?"":ds.getString("CONT_FORECAST_CONST_SUM"))+"|");
					sb.append((ds.isEmpty("CONT_FORECAST_SUM")?"":ds.getString("CONT_FORECAST_SUM"))+"|");
					sb.append((ds.isEmpty("CONTRACT_AMT")?"":ds.getString("CONTRACT_AMT"))+"|");																																		
					sb.append((ds.isEmpty("CONTRACT_AMT01")?"":ds.getString("CONTRACT_AMT01"))+"|");																																	
					sb.append((ds.isEmpty("CONTRACT_AMT02")?"":ds.getString("CONTRACT_AMT02"))+"|");																																	
					sb.append((ds.isEmpty("CONTRACT_AMT03")?"":ds.getString("CONTRACT_AMT03"))+"|");																																	
					sb.append((ds.isEmpty("CONTRACT_AMT04")?"":ds.getString("CONTRACT_AMT04"))+"|");																																	
					sb.append((ds.isEmpty("CONTRACT_AMT_SUM")?"":ds.getString("CONTRACT_AMT_SUM"))+"|");																																
					sb.append((ds.isEmpty("CONT_PLAN_G")?"":ds.getString("CONT_PLAN_G"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_G")?"":ds.getString("CONT_ACTUAL_G"))+"|");	
					sb.append("\r\n");    		
				} 
			}
	
			out.println(sb.toString());				
			
			//  정원대비 현원	
			}else if(div_gn.equals("06"))	{
				EISAdministration eis	= new EISAdministration();
				eis.getEisManCnt(request, response); 
				
				DataSet ds = (DataSet)request.getAttribute("ds");
				StringBuffer sb = new StringBuffer();
				if (ds!=null){
					while(ds.next()){ 
						sb.append((ds.isEmpty("DIV_CD")?"":ds.getString("DIV_CD"))+"|");
						sb.append((ds.isEmpty("DIV_NM")?"":ds.getString("DIV_NM"))+"|");
						sb.append((ds.isEmpty("JUNG_CNT")?"":ds.getString("JUNG_CNT"))+"|");
						sb.append((ds.isEmpty("CURR_CNT")?"":ds.getString("CURR_CNT"))+"|");
						sb.append((ds.isEmpty("ADD_CNT")?"":ds.getString("ADD_CNT"))+"|");					
						sb.append("\r\n");    		
					} 
				}			

			out.println(sb.toString());

			//  분류별 인원 : graph용	
			}else if(div_gn.equals("07"))	{
				EISAdministration eis	= new EISAdministration();
				eis.getEisDivManCnt(request, response); 
				
				DataSet ds = (DataSet)request.getAttribute("ds");
				StringBuffer sb = new StringBuffer();
				if (ds!=null){
					while(ds.next()){ 
						sb.append((ds.isEmpty("YM")?"":ds.getString("YM"))+"|");
						sb.append((ds.isEmpty("JUNG_CNT")?"":ds.getString("JUNG_CNT"))+"|");
						sb.append((ds.isEmpty("BYUL_CNT")?"":ds.getString("BYUL_CNT"))+"|");
						sb.append((ds.isEmpty("TECH_CNT")?"":ds.getString("TECH_CNT"))+"|");
						sb.append((ds.isEmpty("SUPP_CNT")?"":ds.getString("SUPP_CNT"))+"|");					
						sb.append("\r\n");    		
					} 
				}			

			out.println(sb.toString());		
			
			//  손익  : graph용	
			}else if(div_gn.equals("08"))	{
				EISAdministration eis	= new EISAdministration();
				eis.getEisSonYik(request, response); 
				
				DataSet ds = (DataSet)request.getAttribute("ds");
				StringBuffer sb = new StringBuffer();
				if (ds!=null){
					while(ds.next()){ 
						sb.append((ds.isEmpty("div_cd")?"":ds.getString("div_cd"))+"|");
						sb.append((ds.isEmpty("div_nm")?"":ds.getString("div_nm"))+"|");
						sb.append((ds.isEmpty("plan_amt")?"":ds.getString("plan_amt"))+"|");			
						sb.append((ds.isEmpty("actual_amt")?"":ds.getString("actual_amt"))+"|");					
						sb.append((ds.isEmpty("forecast_amt")?"":ds.getString("forecast_amt"))+"|");								
						sb.append("\r\n");    		
					} 
				}			

			out.println(sb.toString());				
			
			//  영업 및 수주(분기게획실적 및 년 계획실적 전망)
			}else if(div_gn.equals("09"))	{
				EISAdministration eis	= new EISAdministration();
				eis.getEisBizContDept(request, response); 
				
				DataSet ds = (DataSet)request.getAttribute("ds");
				StringBuffer sb = new StringBuffer();
				if (ds!=null){
					while(ds.next()){ 
						sb.append((ds.isEmpty("ym"               )?"":ds.getString("ym"               ))+"|");                //0
						sb.append((ds.isEmpty("dept_cd"          )?"":ds.getString("dept_cd"          ))+"|");
						sb.append((ds.isEmpty("dept_nm"          )?"":ds.getString("dept_nm"          ))+"|");
						sb.append((ds.isEmpty("cont_plan"        )?"":ds.getString("cont_plan"        ))+"|");
						sb.append((ds.isEmpty("cont_actual"      )?"":ds.getString("cont_actual"      ))+"|");
						sb.append((ds.isEmpty("cont_forecast"    )?"":ds.getString("cont_forecast"    ))+"|");      // 5
						sb.append((ds.isEmpty("cont_chai"    )?"":ds.getString("cont_chai"    ))+"|");						
						sb.append((ds.isEmpty("sales_plan"       )?"":ds.getString("sales_plan"       ))+"|");
						sb.append((ds.isEmpty("sales_actual"     )?"":ds.getString("sales_actual"     ))+"|");
						sb.append((ds.isEmpty("sales_forecast"   )?"":ds.getString("sales_forecast"   ))+"|");
						sb.append((ds.isEmpty("contract_amt"     )?"":ds.getString("contract_amt"     ))+"|");         //10
						sb.append((ds.isEmpty("y_cont_plan"      )?"":ds.getString("y_cont_plan"      ))+"|");
						sb.append((ds.isEmpty("y_cont_actual"    )?"":ds.getString("y_cont_actual"    ))+"|");
						sb.append((ds.isEmpty("y_cont_forecast"  )?"":ds.getString("y_cont_forecast"  ))+"|");
						sb.append((ds.isEmpty("y_cont_chai"  )?"":ds.getString("y_cont_chai"  ))+"|");						
						sb.append((ds.isEmpty("y_sales_plan"     )?"":ds.getString("y_sales_plan"     ))+"|");      //15
						sb.append((ds.isEmpty("y_sales_actual"   )?"":ds.getString("y_sales_actual"   ))+"|");
						sb.append((ds.isEmpty("y_sales_forecast" )?"":ds.getString("y_sales_forecast" ))+"|");
						sb.append((ds.isEmpty("y_contract_amt"   )?"":ds.getString("y_contract_amt"   ))+"|");
					
						sb.append("\r\n");    		
					} 
				}			

			out.println(sb.toString());						

		}else	{
			EISAdministration eis	= new EISAdministration();
		    eis.getRptFormList(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append((ds.isEmpty("EIS_NO")?"":ds.getString("EIS_NO"))+"|");
		    		sb.append((ds.isEmpty("EIS_NM")?"":ds.getString("EIS_NM"))+"|");
		    		sb.append((ds.isEmpty("LDIV_CD")?"":ds.getString("LDIV_CD"))+"|");
		    		sb.append((ds.isEmpty("LDIV_NM")?"":ds.getString("LDIV_NM"))+"|");
		    		sb.append((ds.isEmpty("SDIV_CD")?"":ds.getString("SDIV_CD"))+"|");
		    		sb.append((ds.isEmpty("SDIV_NM")?"":ds.getString("SDIV_NM"))+"|");
		    		sb.append((ds.isEmpty("VAL1")?"":ds.getString("VAL1"))+"|");
		    		sb.append((ds.isEmpty("VAL2")?"":ds.getString("VAL2"))+"|");
		    		sb.append((ds.isEmpty("VAL3")?"":ds.getString("VAL3"))+"|");
		    		sb.append((ds.isEmpty("VAL4")?"":ds.getString("VAL4"))+"|");
		    		sb.append((ds.isEmpty("VAL5")?"":ds.getString("VAL5"))+"|");
		    		sb.append((ds.isEmpty("VAL6")?"":ds.getString("VAL6"))+"|");
		    		sb.append((ds.isEmpty("VAL7")?"":ds.getString("VAL7"))+"|");
		    		sb.append((ds.isEmpty("DISP_ORD")?"":ds.getString("DISP_ORD"))+"|");
		    		sb.append("\r\n");    		
		   		} 
		    }
		    
		    out.println(sb.toString());
		}
	}
	
	
	/* 경영 정보 연도별 평가 추이   */
	if(mode.equals("F"))	{
		if(div_gn.equals("01"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisOutEvalStatusG(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("PADEP")?"":ds.getString("PADEP"))+"|"); 
					sb.append((ds.isEmpty("ORG_CD")?"":ds.getString("ORG_CD"))+"|"); 
					sb.append((ds.isEmpty("DIV_NM")?"":ds.getString("DIV_NM"))+"|"); 
					sb.append((ds.isEmpty("EMP_BONUS1")?"":ds.getString("EMP_BONUS1"))+"|"); 
					sb.append((ds.isEmpty("EMP_BONUS2")?"":ds.getString("EMP_BONUS2"))+"|"); 
					sb.append((ds.isEmpty("EMP_BONUS3")?"":ds.getString("EMP_BONUS3"))+"|"); 
					sb.append((ds.isEmpty("EMP_BONUS4")?"":ds.getString("EMP_BONUS4"))+"|"); 
					sb.append((ds.isEmpty("EMP_BONUS5")?"":ds.getString("EMP_BONUS5"))+"|"); 
					sb.append((ds.isEmpty("EMP_BONUS6")?"":ds.getString("EMP_BONUS6"))+"|"); 
					sb.append((ds.isEmpty("EMP_BONUS7")?"":ds.getString("EMP_BONUS7"))+"|"); 
					sb.append((ds.isEmpty("EMP_BONUS8")?"":ds.getString("EMP_BONUS8"))+"|"); 
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());
		}else if(div_gn.equals("02"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisOutEvalStatusGP(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("eval_year")?"":ds.getString("eval_year"))+"|");                                                                
					sb.append((ds.isEmpty("emp_bonus_00")?"":ds.getString("emp_bonus_00"))+"|");                                                                
					sb.append((ds.isEmpty("emp_bonus_01")?"":ds.getString("emp_bonus_01"))+"|");                                                                
					sb.append((ds.isEmpty("emp_bonus_02")?"":ds.getString("emp_bonus_02"))+"|");                                                                
					sb.append((ds.isEmpty("emp_bonus_03")?"":ds.getString("emp_bonus_03"))+"|");
					sb.append((ds.isEmpty("emp_bonus_07")?"":ds.getString("emp_bonus_07"))+"|");
					sb.append((ds.isEmpty("emp_bonus_08")?"":ds.getString("emp_bonus_08"))+"|");
					sb.append((ds.isEmpty("emp_bonus_09")?"":ds.getString("emp_bonus_09"))+"|");
					sb.append((ds.isEmpty("emp_bonus_10")?"":ds.getString("emp_bonus_10"))+"|");
					sb.append((ds.isEmpty("emp_bonus_11")?"":ds.getString("emp_bonus_11"))+"|");
					sb.append((ds.isEmpty("emp_bonus_12")?"":ds.getString("emp_bonus_12"))+"|");
					
					sb.append((ds.isEmpty("chief_bonus_00")?"":ds.getString("chief_bonus_00"))+"|");                                                                
					sb.append((ds.isEmpty("chief_bonus_01")?"":ds.getString("chief_bonus_01"))+"|");                                                                
					sb.append((ds.isEmpty("chief_bonus_02")?"":ds.getString("chief_bonus_02"))+"|");                                                                
					sb.append((ds.isEmpty("chief_bonus_03")?"":ds.getString("chief_bonus_03"))+"|"); 
					sb.append((ds.isEmpty("chief_bonus_07")?"":ds.getString("chief_bonus_07"))+"|"); 
					sb.append((ds.isEmpty("chief_bonus_08")?"":ds.getString("chief_bonus_08"))+"|"); 
					sb.append((ds.isEmpty("chief_bonus_09")?"":ds.getString("chief_bonus_09"))+"|"); 
					sb.append((ds.isEmpty("chief_bonus_10")?"":ds.getString("chief_bonus_10"))+"|"); 
					sb.append((ds.isEmpty("chief_bonus_11")?"":ds.getString("chief_bonus_11"))+"|"); 
					sb.append((ds.isEmpty("chief_bonus_12")?"":ds.getString("chief_bonus_12"))+"|"); 
					
					sb.append((ds.isEmpty("eval_rank_00")?"":ds.getString("eval_rank_00"))+"|");                                                                
					sb.append((ds.isEmpty("eval_rank_01")?"":ds.getString("eval_rank_01"))+"|");                                                                
					sb.append((ds.isEmpty("eval_rank_02")?"":ds.getString("eval_rank_02"))+"|");                                                                
					sb.append((ds.isEmpty("eval_rank_03")?"":ds.getString("eval_rank_03"))+"|"); 
					sb.append((ds.isEmpty("eval_rank_07")?"":ds.getString("eval_rank_07"))+"|"); 
					sb.append((ds.isEmpty("eval_rank_08")?"":ds.getString("eval_rank_08"))+"|"); 
					sb.append((ds.isEmpty("eval_rank_09")?"":ds.getString("eval_rank_09"))+"|");
					sb.append((ds.isEmpty("eval_rank_10")?"":ds.getString("eval_rank_10"))+"|");
					sb.append((ds.isEmpty("eval_rank_11")?"":ds.getString("eval_rank_11"))+"|");
					sb.append((ds.isEmpty("eval_rank_12")?"":ds.getString("eval_rank_12"))+"|");
					
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());
			//System.out.println(sb.toString());
		}else if(div_gn.equals("03"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisOutEvalMeas(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("WEIGHT")?"":ds.getString("WEIGHT"))+"|");
					sb.append((ds.isEmpty("MEAS_DIV_NM")?"":ds.getString("MEAS_DIV_NM"))+"|");	
					sb.append((ds.isEmpty("MEAS_GRP_NM")?"":ds.getString("MEAS_GRP_NM"))+"|");
					sb.append((ds.isEmpty("MEAS_NM")?"":ds.getString("MEAS_NM"))+"|");
					sb.append((ds.isEmpty("MEAS_CD")?"":ds.getString("MEAS_CD"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_00")?"":ds.getString("EVAL_GRADE_00"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_00")?"":ds.getString("GRADE_SCORE_00"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_01")?"":ds.getString("EVAL_GRADE_01"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_01")?"":ds.getString("GRADE_SCORE_01"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_02")?"":ds.getString("EVAL_GRADE_02"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_02")?"":ds.getString("GRADE_SCORE_02"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_03")?"":ds.getString("EVAL_GRADE_03"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_03")?"":ds.getString("GRADE_SCORE_03"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_07")?"":ds.getString("EVAL_GRADE_07"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_07")?"":ds.getString("GRADE_SCORE_07"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_08")?"":ds.getString("EVAL_GRADE_08"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_08")?"":ds.getString("GRADE_SCORE_08"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_09")?"":ds.getString("EVAL_GRADE_09"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_09")?"":ds.getString("GRADE_SCORE_09"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_10")?"":ds.getString("EVAL_GRADE_10"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_10")?"":ds.getString("GRADE_SCORE_10"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_11")?"":ds.getString("EVAL_GRADE_11"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_11")?"":ds.getString("GRADE_SCORE_11"))+"|");
					sb.append((ds.isEmpty("EVAL_GRADE_12")?"":ds.getString("EVAL_GRADE_12"))+"|");
					sb.append((ds.isEmpty("GRADE_SCORE_12")?"":ds.getString("GRADE_SCORE_12"))+"|");
					sb.append("\r\n"); 
				} 
			}

			out.println(sb.toString());
			
			//System.out.println(sb.toString());
		}else if(div_gn.equals("04"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisBizContractStatus(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("YM")?"":ds.getString("YM"))+"|");
					sb.append((ds.isEmpty("DEPT_CD")?"":ds.getString("DEPT_CD"))+"|");
					sb.append((ds.isEmpty("DIV_NM")?"":ds.getString("DIV_NM"))+"|");
					sb.append((ds.isEmpty("CONT_PLAN_SVC")?"":ds.getString("CONT_PLAN_SVC"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_SVC")?"":ds.getString("CONT_ACTUAL_SVC"))+"|");
					sb.append((ds.isEmpty("CONT_SVC_PER_CALC")?"":ds.getString("CONT_SVC_PER_CALC"))+"|");
					sb.append((ds.isEmpty("CONT_PLAN_CONST")?"":ds.getString("CONT_PLAN_CONST"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_CONST")?"":ds.getString("CONT_ACTUAL_CONST"))+"|");
					sb.append((ds.isEmpty("CONT_CONST_PER_CALC")?"":ds.getString("CONT_CONST_PER_CALC"))+"|");	
					sb.append((ds.isEmpty("CONT_PLAN")?"":ds.getString("CONT_PLAN"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL")?"":ds.getString("CONT_ACTUAL"))+"|");	
					sb.append((ds.isEmpty("CONT_PER_SUM_CALC")?"":ds.getString("CONT_PER_SUM_CALC"))+"|");
					sb.append((ds.isEmpty("CONT_PLAN_SVC_SUM")?"":ds.getString("CONT_PLAN_SVC_SUM"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_SVC_SUM")?"":ds.getString("CONT_ACTUAL_SVC_SUM"))+"|");	
					sb.append((ds.isEmpty("CONT_SVC_SUM_CALC")?"":ds.getString("CONT_SVC_SUM_CALC"))+"|");
					sb.append((ds.isEmpty("CONT_PLAN_CONST_SUM")?"":ds.getString("CONT_PLAN_CONST_SUM"))+"|");	
					sb.append((ds.isEmpty("CONT_ACTUAL_CONST_SUM")?"":ds.getString("CONT_ACTUAL_CONST_SUM"))+"|");
					sb.append((ds.isEmpty("CONT_CONST_SUM_CALC")?"":ds.getString("CONT_CONST_SUM_CALC"))+"|");	
					sb.append((ds.isEmpty("CONT_PLAN_SUM")?"":ds.getString("CONT_PLAN_SUM"))+"|");
					sb.append((ds.isEmpty("CONT_ACTUAL_SUM")?"":ds.getString("CONT_ACTUAL_SUM"))+"|");	
					sb.append((ds.isEmpty("CONT_SUM_CALC")?"":ds.getString("CONT_SUM_CALC"))+"|");
					sb.append((ds.isEmpty("CONT_FORECAST_SVC")?"":ds.getString("CONT_FORECAST_SVC"))+"|");	
					sb.append((ds.isEmpty("CONT_FORECAST_CONST")?"":ds.getString("CONT_FORECAST_CONST"))+"|");
					sb.append((ds.isEmpty("CONT_FORECAST")?"":ds.getString("CONT_FORECAST"))+"|");
					sb.append((ds.isEmpty("CONT_FORECAST_SVC_SUM")?"":ds.getString("CONT_FORECAST_SVC_SUM"))+"|");	
					sb.append((ds.isEmpty("CONT_FORECAST_CONST_SUM")?"":ds.getString("CONT_FORECAST_CONST_SUM"))+"|");
					sb.append((ds.isEmpty("CONT_FORECAST_SUM")?"":ds.getString("CONT_FORECAST_SUM"))+"|");
					sb.append((ds.isEmpty("CONTRACT_AMT")?"":ds.getString("CONTRACT_AMT"))+"|");																																		
					sb.append((ds.isEmpty("CONTRACT_AMT01")?"":ds.getString("CONTRACT_AMT01"))+"|");																																	
					sb.append((ds.isEmpty("CONTRACT_AMT02")?"":ds.getString("CONTRACT_AMT02"))+"|");																																	
					sb.append((ds.isEmpty("CONTRACT_AMT03")?"":ds.getString("CONTRACT_AMT03"))+"|");																																	
					sb.append((ds.isEmpty("CONTRACT_AMT04")?"":ds.getString("CONTRACT_AMT04"))+"|");																																	
					sb.append((ds.isEmpty("CONTRACT_AMT_SUM")?"":ds.getString("CONTRACT_AMT_SUM"))+"|");																																
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());
		}else if(div_gn.equals("05"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisOutEvalMeasSO(request, response); 
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("EVAL_YEAR")?"":ds.getString("EVAL_YEAR"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_00")?"":ds.getString("QLY_MEAS_00"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_01")?"":ds.getString("QLY_MEAS_01"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_02")?"":ds.getString("QLY_MEAS_02"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_03")?"":ds.getString("QLY_MEAS_03"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_07")?"":ds.getString("QLY_MEAS_07"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_08")?"":ds.getString("QLY_MEAS_08"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_09")?"":ds.getString("QLY_MEAS_09"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_10")?"":ds.getString("QLY_MEAS_10"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_11")?"":ds.getString("QLY_MEAS_11"))+"|");
					sb.append((ds.isEmpty("QLY_MEAS_12")?"":ds.getString("QLY_MEAS_12"))+"|");
					
					sb.append((ds.isEmpty("QTY_MEAS_00")?"":ds.getString("QTY_MEAS_00"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_01")?"":ds.getString("QTY_MEAS_01"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_02")?"":ds.getString("QTY_MEAS_02"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_03")?"":ds.getString("QTY_MEAS_03"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_07")?"":ds.getString("QTY_MEAS_07"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_08")?"":ds.getString("QTY_MEAS_08"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_09")?"":ds.getString("QTY_MEAS_09"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_10")?"":ds.getString("QTY_MEAS_10"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_11")?"":ds.getString("QTY_MEAS_11"))+"|");
					sb.append((ds.isEmpty("QTY_MEAS_12")?"":ds.getString("QTY_MEAS_12"))+"|");
					
					sb.append((ds.isEmpty("EVAL_SCORE_00")?"":ds.getString("EVAL_SCORE_00"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_01")?"":ds.getString("EVAL_SCORE_01"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_02")?"":ds.getString("EVAL_SCORE_02"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_03")?"":ds.getString("EVAL_SCORE_03"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_07")?"":ds.getString("EVAL_SCORE_07"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_08")?"":ds.getString("EVAL_SCORE_08"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_09")?"":ds.getString("EVAL_SCORE_09"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_10")?"":ds.getString("EVAL_SCORE_10"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_11")?"":ds.getString("EVAL_SCORE_11"))+"|");
					sb.append((ds.isEmpty("EVAL_SCORE_12")?"":ds.getString("EVAL_SCORE_12"))+"|");
					
					sb.append((ds.isEmpty("EVAL_RANK_00")?"":ds.getString("EVAL_RANK_00"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_01")?"":ds.getString("EVAL_RANK_01"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_02")?"":ds.getString("EVAL_RANK_02"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_03")?"":ds.getString("EVAL_RANK_03"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_07")?"":ds.getString("EVAL_RANK_07"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_08")?"":ds.getString("EVAL_RANK_08"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_09")?"":ds.getString("EVAL_RANK_09"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_10")?"":ds.getString("EVAL_RANK_10"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_11")?"":ds.getString("EVAL_RANK_11"))+"|");
					sb.append((ds.isEmpty("EVAL_RANK_12")?"":ds.getString("EVAL_RANK_12"))+"|");
				} 
			}

			out.println(sb.toString());
		}else if(div_gn.equals("06"))	{
			EISAdministration eis	= new EISAdministration();
			eis.getEisEvalOrgMeasP(request, response);  
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("org_cd")?"":ds.getString("org_cd"))+"|");
		    		sb.append((ds.isEmpty("org_nm")?"":ds.getString("org_nm"))+"|");
		    		sb.append((ds.isEmpty("meas_cd")?"":ds.getString("meas_cd"))+"|");
		    		sb.append((ds.isEmpty("meas_nm")?"":ds.getString("meas_nm"))+"|");
		    		sb.append((ds.isEmpty("meas_grp_cd")?"":ds.getString("meas_grp_cd"))+"|");
		    		sb.append((ds.isEmpty("meas_grp_nm")?"":ds.getString("meas_grp_nm"))+"|");
		    		sb.append((ds.isEmpty("meas_div_cd")?"":ds.getString("meas_div_cd"))+"|");
		    		sb.append((ds.isEmpty("meas_div_nm")?"":ds.getString("meas_div_nm"))+"|");
		    		sb.append((ds.isEmpty("weight")?"":ds.getString("weight"))+"|");
		    		sb.append((ds.isEmpty("disp_ord")?"":ds.getString("disp_ord"))+"|");
		    		sb.append((ds.isEmpty("eval_grade")?"":ds.getString("eval_grade"))+"|");
		    		sb.append((ds.isEmpty("actual_value")?"":ds.getString("actual_value"))+"|");
		    		sb.append((ds.isEmpty("grade_score")?"":ds.getString("grade_score"))+"|");
		    		sb.append((ds.isEmpty("eval_score")?"":ds.getString("eval_score"))+"|");		    		
		    		sb.append("\r\n"); 	
		    		
				} 
			}

			out.println(sb.toString());
		}else	{
			EISAdministration eis	= new EISAdministration();
		    eis.getRptFormList(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append((ds.isEmpty("EIS_NO")?"":ds.getString("EIS_NO"))+"|");
		    		sb.append((ds.isEmpty("EIS_NM")?"":ds.getString("EIS_NM"))+"|");
		    		sb.append((ds.isEmpty("LDIV_CD")?"":ds.getString("LDIV_CD"))+"|");
		    		sb.append((ds.isEmpty("LDIV_NM")?"":ds.getString("LDIV_NM"))+"|");
		    		sb.append((ds.isEmpty("SDIV_CD")?"":ds.getString("SDIV_CD"))+"|");
		    		sb.append((ds.isEmpty("SDIV_NM")?"":ds.getString("SDIV_NM"))+"|");
		    		sb.append((ds.isEmpty("VAL1")?"":ds.getString("VAL1"))+"|");
		    		sb.append((ds.isEmpty("VAL2")?"":ds.getString("VAL2"))+"|");
		    		sb.append((ds.isEmpty("VAL3")?"":ds.getString("VAL3"))+"|");
		    		sb.append((ds.isEmpty("VAL4")?"":ds.getString("VAL4"))+"|");
		    		sb.append((ds.isEmpty("VAL5")?"":ds.getString("VAL5"))+"|");
		    		sb.append((ds.isEmpty("VAL6")?"":ds.getString("VAL6"))+"|");
		    		sb.append((ds.isEmpty("VAL7")?"":ds.getString("VAL7"))+"|");
		    		sb.append((ds.isEmpty("DISP_ORD")?"":ds.getString("DISP_ORD"))+"|");
		    		sb.append("\r\n");    		
		   		} 
		    }
		    
		    out.println(sb.toString());
		}
	}
	
	if(mode.equals("G") && eis_no.equals("01"))	{
		EISAdministration eis	= new EISAdministration();
	    eis.getGraphManCnt(request, response);
		
	    DataSet ds = (DataSet)request.getAttribute("ds");
	    StringBuffer sb = new StringBuffer();
	    if (ds!=null){
	    	while(ds.next()){ 
	    		sb.append((ds.isEmpty("EIS_NO")?"":ds.getString("EIS_NO"))+"|");
	    		sb.append((ds.isEmpty("EIS_NM")?"":ds.getString("EIS_NM"))+"|");
	    		sb.append((ds.isEmpty("LDIV_CD")?"":ds.getString("LDIV_CD"))+"|");
	    		sb.append((ds.isEmpty("LDIV_NM")?"":ds.getString("LDIV_NM"))+"|");
	    		sb.append((ds.isEmpty("EIS_YEAR")?"":ds.getString("EIS_YEAR"))+"|");	    		
	    		sb.append((ds.isEmpty("SDIV_CD01")?"":ds.getString("SDIV_CD01"))+"|");
	    		sb.append((ds.isEmpty("SDIV_CD02")?"":ds.getString("SDIV_CD02"))+"|");
	    		sb.append("\r\n");    		
	   		} 
	    }
	    out.println(sb.toString());
	}
	
%>
