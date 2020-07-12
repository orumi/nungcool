<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.cool.*,
                 com.nc.xml.*,
                 com.nc.util.DataSet"%>
<%
	request.setCharacterEncoding("UTF-8");

	String mode		= request.getParameter("mode")   == null ? "Q" : (request.getParameter("mode")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? ""  : (request.getParameter("div_gn")).trim();	
		
	/* ------------------------------------------------------------------------------------------------- */
	// 데이타 조회.		
	/* ------------------------------------------------------------------------------------------------- */
	if(mode.equals("Q"))	{
		
		// 코드리스트 정보를 조회.
		if(div_gn.equals("getCodeList")){
	
			CodeUtil util= new CodeUtil();
		    util.getCodeList(request, response);
	
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){  
					sb.append((ds.isEmpty("ldiv_cd"     )?"":ds.getString("ldiv_cd"      )) +"|");
					sb.append((ds.isEmpty("sdiv_cd"     )?"":ds.getString("sdiv_cd"      )) +"|");
					sb.append((ds.isEmpty("div_nm"      )?"":ds.getString("div_nm"       )) +"|");
					sb.append((ds.isEmpty("div_snm"     )?"":ds.getString("div_snm"      )) +"|");
					sb.append((ds.isEmpty("ord"         )?"":ds.getString("ord"          )) +"|");
					sb.append((ds.isEmpty("use_yn"      )?"":ds.getString("use_yn"       )) +"|");
					
					sb.append("\r\n");    		
				} 
			}
			
			out.println(sb.toString());	
		}
	}
	
	/* ------------------------------------------------------------------------------------------------- */
	// 데이타 수정처리.		
	/* ------------------------------------------------------------------------------------------------- */
	if("U".equals(mode)||"D".equals(mode))	{
		
		if(div_gn.equals("setCodeInfo")){	
			CodeUtil util= new CodeUtil();
		    util.setCodeInfo(request, response);
	
	   		String rslt  = (String) request.getAttribute("rslt" );
	   		out.println(rslt);	    
		}
   
	}
%>
