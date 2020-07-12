<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.mbo.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	//String mode		   = request.getParameter("mode")   == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	   = request.getParameter("div_gn") == null ? ""  : (request.getParameter("div_gn")).trim();

	
	// 조직 TREE : 사업단 
	if(div_gn.equals("getOrgDan"))	{
		mboOrgUtil util = new mboOrgUtil();
		util.getOrgDan(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		if (ds!=null){
			while(ds.next()){ 
			    		sb.append((ds.isEmpty("dan_cd"  )?"":ds.getString("dan_cd"  ))+"|");
			    		sb.append((ds.isEmpty("dan_nm"  )?"":ds.getString("dan_nm"  ))+"|");
			    		sb.append((ds.isEmpty("group_cd")?"":ds.getString("group_cd"))+"|");
			    		sb.append((ds.isEmpty("child"   )?"":ds.getString("child"   ))+"|");
			    		
			    		sb.append("\r\n");    	
			} 
		}
		out.println(sb.toString());
	}		

	// 조직 TREE : 사업단아래의 JobGroup 
	if(div_gn.equals("getOrgJobGroup"))	{
		mboOrgUtil util = new mboOrgUtil();
		util.getOrgJobGroup(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		if (ds!=null){
			while(ds.next()){ 
			    		sb.append((ds.isEmpty("job_group_cd"  )?"":ds.getString("job_group_cd"  ))+"|");
			    		sb.append((ds.isEmpty("job_group_nm"  )?"":ds.getString("job_group_nm"  ))+"|");
			    		sb.append((ds.isEmpty("child"         )?"":ds.getString("child"         ))+"|");
			    		
			    		sb.append("\r\n");    	
			} 
		}
		out.println(sb.toString());
	}	
	
	
	
	// 조직 TREE : 사업단아래의 레벨 3
	if(div_gn.equals("getOrgDivision"))	{
		mboOrgUtil util = new mboOrgUtil();
		util.getOrgDivision(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		if (ds!=null){
			while(ds.next()){ 
			    		sb.append((ds.isEmpty("org_cd"  )?"":ds.getString("org_cd"  ))+"|");
			    		sb.append((ds.isEmpty("org_nm"  )?"":ds.getString("org_nm"  ))+"|");
	
			    		sb.append((ds.isEmpty("group_cd"  )?"":ds.getString("group_cd"  ))+"|");		    		
			    		sb.append((ds.isEmpty("child"     )?"":ds.getString("child"     ))+"|");
			    		
			    		sb.append("\r\n");    	
			} 
		}
		out.println(sb.toString());
	}		
	
	// 조직 TREE : 사업단아래의 레벨 : 부모조직 아래 모든 조직.
	if(div_gn.equals("getOrgInfo"))	{
		mboOrgUtil util = new mboOrgUtil();
		util.getOrgInfo(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		if (ds!=null){
			while(ds.next()){ 
			    		sb.append((ds.isEmpty("org_cd"  )?"":ds.getString("org_cd"  ))+"|");
			    		sb.append((ds.isEmpty("org_nm"  )?"":ds.getString("org_nm"  ))+"|");
			    		sb.append((ds.isEmpty("owner_org_cd"  )?"":ds.getString("owner_org_cd"  ))+"|");		    		
			    		sb.append((ds.isEmpty("child"     )?"":ds.getString("child"     ))+"|");
			    		
			    		sb.append("\r\n");    	
			} 
		}
		out.println(sb.toString());
	}
%>
