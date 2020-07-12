<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
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

			//  사업단별 계약잔고 구하기
			if(div_gn.equals("getSimaContractAmt"))	{
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.getSimaContractAmt(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
				    		sb.append((ds.isEmpty("dept_cd")?"":ds.getString("dept_cd"))+"|");
				    		sb.append((ds.isEmpty("dept_nm")?"":ds.getString("dept_nm"))+"|");
				    		sb.append((ds.isEmpty("bef_cont_amt")?"":ds.getString("bef_cont_amt"))+"|");
				    		sb.append((ds.isEmpty("sale_amt")?"":ds.getString("sale_amt"))+"|");
				    		sb.append((ds.isEmpty("cont_amt")?"":ds.getString("cont_amt"))+"|");
				    		sb.append((ds.isEmpty("flag")?"":ds.getString("flag"))+"|");    		
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
					
			// 수주원별  매출액을 구함.		
			}else if(div_gn.equals("getSimsaSalesAmt"))	{
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.getSimsaSalesAmt(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("biz_ldiv_cd"  )?"":ds.getString("biz_ldiv_cd"   )) + "|");
							sb.append((ds.isEmpty("biz_ldiv_nm"  )?"":ds.getString("biz_ldiv_nm"   )) + "|");
							sb.append((ds.isEmpty("biz_sdiv_cd"  )?"":ds.getString("biz_sdiv_cd"   )) + "|");
							sb.append((ds.isEmpty("biz_sdiv_nm"  )?"":ds.getString("biz_sdiv_nm"   )) + "|");
							sb.append((ds.isEmpty("bef_sale_amt" )?"":ds.getString("bef_sale_amt"  )) + "|");
							sb.append((ds.isEmpty("plan_amt"     )?"":ds.getString("plan_amt"      )) + "|");
							sb.append((ds.isEmpty("actual_amt"   )?"":ds.getString("actual_amt"    )) + "|");
				    		sb.append("\r\n");    	
						} 
					}
					
					out.println(sb.toString());
					
			// 지적재산
			}else if(div_gn.equals("getSimaIntellActual"))	{
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.getSimaIntellActual(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("nat_gbn_cd"  )?"":ds.getString("nat_gbn_cd"   )) + "|");
							sb.append((ds.isEmpty("nat_gbn_nm"  )?"":ds.getString("nat_gbn_nm"   )) + "|");
							sb.append((ds.isEmpty("patent_apply"  )?"":ds.getString("patent_apply"   )) + "|");
							sb.append((ds.isEmpty("patent_regi"  )?"":ds.getString("patent_regi"   )) + "|");
							sb.append((ds.isEmpty("brend_regi" )?"":ds.getString("brend_regi"  )) + "|");
							sb.append((ds.isEmpty("tech_regi"     )?"":ds.getString("tech_regi"      )) + "|");
							sb.append((ds.isEmpty("copyright"   )?"":ds.getString("copyright"    )) + "|");
							sb.append((ds.isEmpty("program"  )?"":ds.getString("program"   )) + "|");					
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
					
					//  심사 Report Form 
			}else if(div_gn.equals("getSimsaRpt"))	{
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.getSimsaRpt(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("eis_no"  )?"":ds.getString("eis_no"   )) + "|");
							sb.append((ds.isEmpty("eis_nm"  )?"":ds.getString("eis_nm"   )) + "|");
							sb.append((ds.isEmpty("ldiv_cd"  )?"":ds.getString("ldiv_cd"   )) + "|");
							sb.append((ds.isEmpty("ldiv_nm"  )?"":ds.getString("ldiv_nm"   )) + "|");
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());							
					
					//  심사 Report Form 
			}else if(div_gn.equals("getSimsaRptForm"))	{
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.getSimsaRptForm(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("eis_no"  )?"":ds.getString("eis_no"   )) + "|");
							sb.append((ds.isEmpty("eis_nm"  )?"":ds.getString("eis_nm"   )) + "|");
							sb.append((ds.isEmpty("ldiv_cd"  )?"":ds.getString("ldiv_cd"   )) + "|");
							sb.append((ds.isEmpty("ldiv_nm"  )?"":ds.getString("ldiv_nm"   )) + "|");
							sb.append((ds.isEmpty("sdiv_cd"  )?"":ds.getString("sdiv_cd"   )) + "|");
							sb.append((ds.isEmpty("sdiv_nm"  )?"":ds.getString("sdiv_nm"   )) + "|");
							sb.append((ds.isEmpty("eis_div_cd" )?"":ds.getString("eis_div_cd"  )) + "|");
							sb.append((ds.isEmpty("unit"         )?"":ds.getString("unit"      )) + "|");
							sb.append((ds.isEmpty("dot_pos"   )?"":ds.getString("dot_pos"    )) + "|");
							sb.append((ds.isEmpty("disp_ord"  )?"":ds.getString("disp_ord"   )) + "|");					
							sb.append((ds.isEmpty("value"       )?"":ds.getString("value"   )) + "|");										
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());					
					
			//  심사 Report 실적
			}else if(div_gn.equals("getSimsaRptRslt"))	{
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.getSimsaRptRslt(request, response);
					
					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){ 
							sb.append((ds.isEmpty("eis_no"  )?"":ds.getString("eis_no"   )) + "|");
							sb.append((ds.isEmpty("eis_nm"  )?"":ds.getString("eis_nm"   )) + "|");
							sb.append((ds.isEmpty("ldiv_cd"  )?"":ds.getString("ldiv_cd"   )) + "|");
							sb.append((ds.isEmpty("ldiv_nm"  )?"":ds.getString("ldiv_nm"   )) + "|");
							sb.append((ds.isEmpty("sdiv_cd"  )?"":ds.getString("sdiv_cd"   )) + "|");
							sb.append((ds.isEmpty("sdiv_nm"  )?"":ds.getString("sdiv_nm"   )) + "|");
							sb.append((ds.isEmpty("eis_div_cd" )?"":ds.getString("eis_div_cd"  )) + "|");
							sb.append((ds.isEmpty("unit"         )?"":ds.getString("unit"      )) + "|");
							sb.append((ds.isEmpty("dot_pos"   )?"":ds.getString("dot_pos"    )) + "|");
							sb.append((ds.isEmpty("disp_ord"  )?"":ds.getString("disp_ord"   )) + "|");					
							sb.append((ds.isEmpty("value"       )?"":ds.getString("value"   )) + "|");										
				    		sb.append("\r\n");    	
						} 
					}
		
					out.println(sb.toString());
			}
			
	//------------------------------------------------------------------------------------------		
	//		등록,수정,삭제
	//------------------------------------------------------------------------------------------	
	} else {
			
			// 사업단별 계약잔고.
			if(div_gn.equals("setSimaContractAmt"))	{
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.setSimaContractAmt(request, response);
					
					out.println("true");
				
			//  수주원별 매출액
			}else if(div_gn.equals("setSimsaSalesAmt"))	{
				
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.setSimsaSalesAmt(request, response);
	
					out.println("true");
			
					
			//  지적자산.
			} else if (div_gn.equals("setSimaIntellActual"))	{
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.setSimaIntellActual(request, response);
					
					out.println("true");

			// 심사보고서  : 대분류
			}else if (div_gn.equals("setSimaEisNo"))	{
					
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.setSimaEisNo(request, response);
					
					out.println("true");															
					
			// 심사보고서 형태 : 대분류
			}else if (div_gn.equals("setSimaEisRpt"))	{
					
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.setSimaEisRpt(request, response);
					
					out.println("true");										

			// 심사보고서 형태 : 소분류
			}else if (div_gn.equals("setSimaEisRptForm"))	{
					
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.setSimaEisRptForm(request, response);

					out.println("true");					

			//  심사보고서 실적
			}else if (div_gn.equals("setSimsaRptRslt"))	{
					
					EISSimsaUtil eis	= new EISSimsaUtil();
					eis.setSimsaRptRslt(request, response);
					
					out.println("true");
			}			
		
	}
	
	
	
%>
