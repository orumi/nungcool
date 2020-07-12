<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%

	String mode		= request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();
	
	if(mode.equals("R"))	{
		if(div_gn.equals("getMeasCopy"))	{

		
			// 지표대상부서를 구함.
		    HierarchyUtil util= new HierarchyUtil();
		    util.getMeasCopy(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("cid")?"":ds.getString("cid")) +"|");           		// 1
					sb.append((ds.isEmpty("cpid")?"":ds.getString("cpid")) +"|");           		// 
					sb.append((ds.isEmpty("ccid")?"":ds.getString("ccid")) +"|");           		// 
					sb.append((ds.isEmpty("clevel")?"":ds.getString("clevel")) +"|");           		// 
					sb.append((ds.isEmpty("crank")?"":ds.getString("crank")) +"|");           		// 5
					sb.append((ds.isEmpty("cweight")?"":ds.getString("cweight")) +"|");           		//
					sb.append((ds.isEmpty("cname")?"":ds.getString("cname")) +"|");           		//
					sb.append((ds.isEmpty("sid")?"":ds.getString("sid")) +"|");           		//
					sb.append((ds.isEmpty("spid")?"":ds.getString("spid")) +"|");           		//
					sb.append((ds.isEmpty("scid")?"":ds.getString("scid")) +"|");           		// 10
					sb.append((ds.isEmpty("slevel")?"":ds.getString("slevel")) +"|");           		//
					sb.append((ds.isEmpty("srank")?"":ds.getString("srank")) +"|");           		//
					sb.append((ds.isEmpty("sweight")?"":ds.getString("sweight")) +"|");           		//
					sb.append((ds.isEmpty("sname")?"":ds.getString("sname")) +"|");           		//
					sb.append((ds.isEmpty("bid")?"":ds.getString("bid")) +"|");           		// 15
					sb.append((ds.isEmpty("bpid")?"":ds.getString("bpid")) +"|");           		//
					sb.append((ds.isEmpty("bcid")?"":ds.getString("bcid")) +"|");           		//
					sb.append((ds.isEmpty("blevel")?"":ds.getString("blevel")) +"|");           		//
					sb.append((ds.isEmpty("brank")?"":ds.getString("brank")) +"|");           		//
					sb.append((ds.isEmpty("bweight")?"":ds.getString("bweight")) +"|");           		// 20
					sb.append((ds.isEmpty("bname")?"":ds.getString("bname")) +"|");           		//
					sb.append((ds.isEmpty("pid")?"":ds.getString("pid")) +"|");           		//
					sb.append((ds.isEmpty("ppid")?"":ds.getString("ppid")) +"|");           		//
					sb.append((ds.isEmpty("pcid")?"":ds.getString("pcid")) +"|");           		//
					sb.append((ds.isEmpty("plevel")?"":ds.getString("plevel")) +"|");           		// 25 
					sb.append((ds.isEmpty("prank")?"":ds.getString("prank")) +"|");           		//
					sb.append((ds.isEmpty("pweight")?"":ds.getString("pweight")) +"|");           		//
					sb.append((ds.isEmpty("pname")?"":ds.getString("pname")) +"|");           		//
					sb.append((ds.isEmpty("oid")?"":ds.getString("oid")) +"|");           		//
					sb.append((ds.isEmpty("opid")?"":ds.getString("opid")) +"|");           		// 30
					sb.append((ds.isEmpty("ocid")?"":ds.getString("ocid")) +"|");           		//
					sb.append((ds.isEmpty("olevel")?"":ds.getString("olevel")) +"|");           		//
					sb.append((ds.isEmpty("orank")?"":ds.getString("orank")) +"|");           		//
					sb.append((ds.isEmpty("oweight")?"":ds.getString("oweight")) +"|");           		//
					sb.append((ds.isEmpty("oname")?"":ds.getString("oname")) +"|");           		// 35
					sb.append((ds.isEmpty("mid")?"":ds.getString("mid")) +"|");           		//
					sb.append((ds.isEmpty("mpid")?"":ds.getString("mpid")) +"|");           		//
					sb.append((ds.isEmpty("mcid")?"":ds.getString("mcid")) +"|");           		//
					sb.append((ds.isEmpty("mlevel")?"":ds.getString("mlevel")) +"|");           		//
					sb.append((ds.isEmpty("mrank")?"":ds.getString("mrank")) +"|");           		// 40
					sb.append((ds.isEmpty("mweight")?"":ds.getString("mweight")) +"|");           		//
					sb.append((ds.isEmpty("mname")?"":ds.getString("mname")) +"|");           		//
					sb.append((ds.isEmpty("measureid")?"":ds.getString("measureid")) +"|");           		//
					sb.append((ds.isEmpty("etlkey")?"":ds.getString("etlkey")) +"|");           		// 44

					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());			
		}
	}	
		
	
	// -------------------------------------------------------------------------
	// Update... Delete...	
	// -------------------------------------------------------------------------
	if (mode.equals("U"))	{
		
		if(div_gn.equals("setMeasCopy"))	{		
				
				// 지표대상부서 복사 처리..
			    HierarchyUtil util= new HierarchyUtil();
			    util.setMeasCopy(request, response);
				
			    DataSet ds = (DataSet)request.getAttribute("ds");
			    
			    String copyOK = (String)request.getAttribute("rslt");
		    	out.println(copyOK);
		    	
		}else if (div_gn.equals("setMeasYearCopy"))	{		

	    		System.out.println(" setMeasYearCopy Start...");			
				  // 지표 년도 이관처리.
			    HierarchyUtil util= new HierarchyUtil();
			    util.setMeasYearCopy(request, response);
				
			    DataSet ds = (DataSet)request.getAttribute("ds");
			    
			    String copyOK = (String)request.getAttribute("rslt");
		    	out.println(copyOK);
	    		System.out.println(" setMeasYearCopy End..." + copyOK);
		}
		
	}
	
	// -------------------------------------------------------------------------
	// Delete...	
	// -------------------------------------------------------------------------
	if (mode.equals("D"))	{
		
			if (div_gn.equals("setMeasYearDeleteAll"))	{		
	
	    		System.out.println(" setMeasYearDeleteAll Start...");			
				  // 지표 년도 이관처리.
			    HierarchyUtil util= new HierarchyUtil();
			    util.setMeasYearDeleteAll(request, response);
				
			    DataSet ds = (DataSet)request.getAttribute("ds");
			    
			    String copyOK = (String)request.getAttribute("rslt");
		    	out.println(copyOK);
	    		System.out.println(" setMeasYearDeleteAll End..." + copyOK);
		}
		
	}	
	
%>
