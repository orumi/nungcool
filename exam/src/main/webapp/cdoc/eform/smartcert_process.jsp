<%
	/*
	*	원본 데이터 저장 단계
	*/
%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.io.PrintWriter"%>
<%@ include file="beans/serial_Beans.jsp"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	String errUrl = "./error.jsp?msg=";
	if (!request.isRequestedSessionIdValid()) {
		out.println("{\"result\":\"" + java.net.URLEncoder.encode("[STEP 01]서버와의 연결(세션)이 종료되었습니다. ", "utf-8") + "\"}");
	} else {
		try {
			SerialBeans serial = new SerialBeans();
			String ret = serial.processRequest(request, response);
			out.println("{\"result\":\"" + ret + "\"}");
		} catch (Exception e) {
			out.println("{\"result\":\"" + java.net.URLEncoder.encode("[STEP 01]비정상 처리되었습니다. \n"+e.toString(), "utf-8") + "\"}");
		}
	}
%>
