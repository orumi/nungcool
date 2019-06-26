<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page errorPage="error.jsp" %>
<%@ include file="beans/smartcert_PDFSignService.jsp"%>
<%
	/* 	
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0); 
	*/
	
	String errUrl = "./error.jsp?msg=";
	if (!request.isRequestedSessionIdValid()) {
		response.setHeader("Set-Cookie", "cabsoftfileDownload=100; path=/");
		response.sendRedirect(errUrl + java.net.URLEncoder.encode("timeout", "utf-8"));
	} else {
		try {
			out.clear();
			out = pageContext.pushBody();
			SmartCertSignService sign = new SmartCertSignService();
			sign.processRequest(request, response);
		} catch (Exception e) {
			response.setHeader("Set-Cookie", "cabsoftfileDownload=200; path=/");
			response.sendRedirect(errUrl + java.net.URLEncoder.encode(e.getMessage(), "utf-8"));
		}
	}
%>
