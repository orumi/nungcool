<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.io.PrintWriter"%>
<%@ page errorPage="error.jsp" %>
<%@ include file="beans/smartcert_PDFExportService.jsp"%>
<%

	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	String errUrl = "./error.jsp?msg=";
	if (!request.isRequestedSessionIdValid()) {
		response.sendRedirect(errUrl + java.net.URLEncoder.encode("timeout", "utf-8"));
	} else {
		try {
			PDFExportService service = new PDFExportService();
			String ret = service.processRequest(request, response);
//			out.println("{\"result\":\"" + ret + "\"}");
			if(!ret.equalsIgnoreCase("OK")){
				response.sendRedirect(errUrl + java.net.URLEncoder.encode(ret, "utf-8"));
			}else{
				String __p = java.net.URLEncoder.encode((String)request.getParameter("__p"), "utf-8");
				String __q = (String)request.getParameter("__q");
				String next_url = "smartcert_serviceexport2.jsp?__p=" + __p + "&__q=" + __q;
				 //client에 응답없이 바로 진행하는 경우(응답시간이 길어질수 있다)
				//pageContext.forward(next_url);
				 //client에 응답하고 진행하는 경우(또다른 요청으로 처리)
				response.sendRedirect(next_url); 
			}
		} catch (Exception e) {
			response.sendRedirect(errUrl + java.net.URLEncoder.encode(e.getMessage(), "utf-8"));
		}
	}
%>
