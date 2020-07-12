
<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<%@ page import ="com.nc.util.*, com.nc.user.UserApp" %>

<%
	String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
    
	UserApp app = new UserApp();
	String mode = request.getParameter("mode");
	
	if(mode.equals("getDept")){ ///////부서명가져오기 		
		app.setUserDetail(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		
		if(ds != null){ 
			while(ds.next()){			
				sb.append(ds.getString("ID") + "|");
				sb.append(ds.getString("CODE") + "|");
				sb.append(ds.getString("NAME") + "|");
				sb.append(ds.getString("LINK") + "|");
				sb.append(ds.getString("INPUTDATE") + "|");
				sb.append(ds.getString("UPDATEDATE") + "|");
				sb.append(ds.getString("PARENTID") + "|");
				sb.append("\r\n");
			}
		}
		out.println(sb.toString());		
	}else if(mode.equals("Q")){ ////////////사용자조회 		
		app.setList(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		if(ds != null){
			while(ds.next()){	
				sb.append(ds.getString("USERID") + "|");
				sb.append(ds.getString("PASSWORD") + "|");
				sb.append(ds.getString("USERNAME") + "|");
				sb.append(ds.getString("EMAIL") + "|");
				sb.append(ds.getString("GROUPID") + "|");
				sb.append(ds.getString("LOGINSTATUS") + "|");
				sb.append(ds.getString("INPUTDATE") + "|");
				sb.append(ds.getString("DIVCODE") + "|");
				sb.append(ds.getString("POSITION") + "|");
				sb.append(ds.getString("AUTH01") + "|");
				sb.append(ds.getString("CHARGE") + "|");
				sb.append(ds.getString("APPRAISER") + "|");
				sb.append(ds.getString("DEPT_CD") + "|");
				sb.append(ds.getString("DIVNAME") + "|");
				sb.append(ds.getString("DEPTNAME") + "|");
				sb.append("\r\n");
			}
		}
		out.println(sb.toString());
	}else if(mode.equals("getDutyList")){ ////직위가져오기
		app.getDutyList(request, response);
	
		DataSet dsPst = (DataSet)request.getAttribute("dsPst");
		StringBuffer sb = new StringBuffer();
		
		if(dsPst != null){
			while(dsPst.next()){	
				sb.append(dsPst.getString("LDIV_CD") + "|");
				sb.append(dsPst.getString("ID") + "|");	
				sb.append(dsPst.getString("NAME") + "|");
				sb.append("\r\n");
			}
		}
		out.println(sb.toString());
	}else if(mode.equals("U")){
		app.setList(request, response);
		out.println("complete");
	}else if(mode.equals("D")){
		app.setList(request, response);
		out.println("complete");
	}else if(mode.equals("N")){
		app.setList(request, response);
		out.println("complete");
	}
%>