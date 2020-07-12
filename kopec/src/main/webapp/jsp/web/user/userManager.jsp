
<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<%@ page import ="com.nc.util.*, com.nc.user.UserApp" %>

<%
	UserApp app = new UserApp();
	app.getManager(request, response);
	
	DataSet ds = (DataSet)request.getAttribute("ds");
	StringBuffer sb = new StringBuffer();
	
	if(ds != null){ 
		while(ds.next()){			
			sb.append(ds.getString("SNAME") + "|");
			sb.append(ds.getString("BNAME") + "|");
			sb.append(ds.getString("MNAME") + "|");

			
			if(ds.getString("TAG").equals("M")){
				sb.append("부|");
			}else{
				sb.append("정|");
			}
			
			sb.append("\r\n");
		}
	}
	System.out.println(sb.toString());
	out.println(sb.toString());
%>