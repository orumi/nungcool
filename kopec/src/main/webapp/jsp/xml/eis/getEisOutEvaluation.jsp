<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	String mode		= request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();

	String eval_year	= request.getParameter("eval_year") == null ? "" : (request.getParameter("eval_year")).trim();
	String org_cd	= request.getParameter("org_cd") == null ? "%" : (request.getParameter("org_cd")).trim();	
	
	if(mode.equals("R"))	{
		if(div_gn.equals("getEisEvalOrg"))	{
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.getEisEvalOrg(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("org_cd")?"":ds.getString("org_cd"))+"|");
		    		sb.append((ds.isEmpty("org_nm")?"":ds.getString("org_nm"))+"|");
		    		sb.append((ds.isEmpty("emp_bonus")?"":ds.getString("emp_bonus"))+"|");
		    		sb.append((ds.isEmpty("chief_bonus")?"":ds.getString("chief_bonus"))+"|");
		    		sb.append((ds.isEmpty("eval_rank")?"":ds.getString("eval_rank"))+"|");
		    		sb.append((ds.isEmpty("eval_score")?"":ds.getString("eval_score"))+"|");
		    		sb.append((ds.isEmpty("qty_meas")?"":ds.getString("qty_meas"))+"|");
		    		sb.append((ds.isEmpty("qly_meas")?"":ds.getString("qly_meas"))+"|");		    		
		    		sb.append("\r\n");    	
				} 
			}

			out.println(sb.toString());
			
		}else if(div_gn.equals("getEisEvalOrgMeas"))	{
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.getEisEvalOrgMeas(request, response);
			
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
			
			System.out.println(sb.toString());
		}
	}		
	
	
%>
