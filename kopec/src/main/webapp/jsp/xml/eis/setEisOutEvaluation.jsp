<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	String mode		= request.getParameter("mode") == null ? "D" : (request.getParameter("mode")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();

	if(mode.equals("D"))	{
		if(div_gn.equals("setEisEvalOrg"))	{
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.setEisEvalOrg(request, response);
			
			out.println("true");
			
		}else if(div_gn.equals("setEisEvalOrgMeas"))	{
			
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.setEisEvalOrgMeas(request, response);

			out.println("true");
		}else if(div_gn.equals("setEisEvalOrgMeasValue"))	{
			
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.setEisEvalOrgMeasValue(request, response);

			out.println("true");
		}
	}		
	
	if(mode.equals("U"))	{
		
		//System.out.println("setEisEvalOrg Start");		
		
		// 그룹사 실적개요
		if(div_gn.equals("setEisEvalOrg"))	{
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.setEisEvalOrg(request, response);
			
			out.println("true");
			
		// 지표설정	
		}else if(div_gn.equals("setEisEvalOrgMeas"))	{
			
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.setEisEvalOrgMeas(request, response);

			out.println("true");
		
		// 그룹사별 지표실적 등	
		} else if (div_gn.equals("setEisEvalOrgMeasValue"))	{
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.setEisEvalOrgMeasValue(request, response);
			
			out.println("true");

  	    // 외부평가지표 년도 이관처리.			
		}else if (div_gn.equals("setOutEvalMeasYearCopy"))	{		

    		System.out.println(" setOutEvalMeasYearCopy Start...");			

			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.setOutEvalMeasYearCopy(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    String copyOK = (String)request.getAttribute("rslt");
	    	out.println(copyOK);
    		System.out.println(" setMeasYearCopy End..." + copyOK);
		// 외부평가지표 그룹 복사
		}else if (div_gn.equals("setOutEvalMeasGroupCopy"))	{		

        		System.out.println(" setOutEvalMeasYearCopy Start...");			

    			EISOutEvaluation eis	= new EISOutEvaluation();
    			eis.setOutEvalMeasGroupCopy(request, response);
    			
    		    DataSet ds = (DataSet)request.getAttribute("ds");
    		    
    		    String copyOK = (String)request.getAttribute("rslt");
    	    	out.println(copyOK);
        		System.out.println(" setMeasGroupCopy End..." + copyOK);	
    		
      	 // 외부평가지표 공통코드에 등록	    		
		}else if (div_gn.equals("addMeasComCode"))	{
			
			System.out.println(" addMeasComCode Start...");			
			
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.addMeasComCode(request, response);
			
			out.println("true");

		// 외부평가부문 공통코드에 등록	    		
		}else if (div_gn.equals("addClassComCode"))	{
			
			System.out.println(" addClassComCode Start...");			
			
			EISOutEvaluation eis	= new EISOutEvaluation();
			eis.addClassComCode(request, response);
			
			out.println("true");
		}			
	}			
	
	
%>
