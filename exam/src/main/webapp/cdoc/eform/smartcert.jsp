<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="com.cabsoft.utils.StringUtils"%>
<%@ page language="java" import="com.cabsoft.utils.SystemUtils"%>
<%@ page language="java" import="com.cabsoft.RXSession"%>
<%@ page errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	/* 
	* 증명발급 HTML 뷰어 Mask 
	*/
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("utf-8");
	
	// TODO 세션 체크
	
	// TODO 에러페이지

	String errUrl = "./error.jsp?msg=";
	if (!request.isRequestedSessionIdValid()) {		// 세션 체크
		response.sendRedirect(errUrl + java.net.URLEncoder.encode("timeout", "utf-8"));
	} else {
		// 이전 jobID 제거
		String jobID = (String) session.getAttribute("jobID");
		if (!StringUtils.isEmpty(jobID)) {
			session.setAttribute(jobID + "_session", null);
			session.removeAttribute(jobID + "_session");
			session.setAttribute("jobID", null);
			session.removeAttribute("jobID");
		}

		//jobid생성
		jobID = SystemUtils.GenerateID();
		request.getSession().setAttribute("jobID", jobID);

		String servlet = StringUtils.nvl(request.getParameter("Servlet"), "");
		
		// html 뷰어로 전달
		String filename = StringUtils.nvl(request.getParameter("ReportFile"), "");
		String process = StringUtils.nvl(request.getParameter("Process"), "PDF");
		String rptTitle = URLDecoder.decode(StringUtils.nvl(request.getParameter("rptTitle"), ""));
		String certpasswd = StringUtils.nvl(request.getParameter("rptpasswd"), "");
		String requesrpasswd = StringUtils.nvl(request.getParameter("reqpasswd"), "");
		String toolbarType = StringUtils.nvl(request.getParameter("toolbarType"), "ios");
		String plugin = StringUtils.nvl(request.getParameter("plugin"), "");
		
		toolbarType = (null==toolbarType) ? RXSession.TOOLBAR_DEFAULT : toolbarType;

		String xmlType = StringUtils.nvl(request.getParameter("xmlType"), ""); 		
		
		RXSession ss = new RXSession();
		ss.setJobID(jobID);
		ss.setRxprintData("");
		ss.setIssueID("");
		ss.setRptFile(filename);
		ss.setXmlData("");
		ss.setPdfData(null);
		ss.setToolbarType(toolbarType);
		ss.setPluginMode((plugin==null ? false : ("1".equals(plugin) ? true : false)));
		
		if (requesrpasswd != null && "1".equals(requesrpasswd)) {
			certpasswd = "";
			// 사용자 암호 입력이 요구됨(미리보기 후에 결정)
			ss.setUserpwd("");
			ss.setReqpasswd(true);
		} else {
			//암호 자동입력(미리보기전에 결정)
			ss.setUserpwd(certpasswd);
			ss.setReqpasswd(false);
		}
		
		ss.setPageView(null);
		ss.setJson(null);

		session.setAttribute(jobID + "_session", ss);
		
		// TODO 테스트용파라미터. 운영반영전 삭제 필요
		String xmlData = (String) request.getParameter("xmlData");
		String dbUse = (String) request.getParameter("dbUse");
%>
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=utf-8" Cache-control="no-cache" Pragma="no-cache">
<link href="<c:url value="/cdoc/eform/smartcertviewer/loading/jquery.loadmask.css" />" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value="/cdoc/eform/smartcertviewer/js/jquery-1.9.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/cdoc/eform/smartcertviewer/loading/jquery-latest.pack.js" />" ></script>
<script type='text/javascript' src="<c:url value="/cdoc/eform/smartcertviewer/loading/jquery.loadmask.js" />" ></script>
<style>
body {
	font-size: 11px;
	font-family: tahoma;
}

#content {
	padding: 5px;
	width: 200px;
}

#buttons {
	padding-left: 40px;
}
</style>
<script language="javascript">
	$(document).ready(function() {
		$("#body").mask("<%=rptTitle%> 생성 중 ...");
	} );
	
	/* function makeForm(url){
		var f = document.createElement("form");
	    f.setAttribute("method", "post");
	    f.setAttribute("action", url);
	    document.body.appendChild(f);
	    return f;
	} */
	
	function addData(name, value){
		var i = document.createElement("input");
		i.setAttribute("type","hidden");
		i.setAttribute("name",name);
		i.setAttribute("value",value);
		return i;
	}
	
	window.onload = function(){
		var f = document.getElementById("eform");
		f.appendChild(addData('ReportFile', '<%=filename%>'));
		f.appendChild(addData('Process', '<%=process%>'));
		f.appendChild(addData('certpasswd', '<%=certpasswd%>'));
		f.appendChild(addData('rptTitle', '<%=rptTitle%>'));
		f.appendChild(addData('xmlType', '<%=xmlType%>'));
		
		/* TODO 테스트용파라미터. 운영반영전 삭제 필요 start */
		f.appendChild(addData("xmlData", '<%=xmlData%>'));					
		f.appendChild(addData("dbUse", '<%=dbUse%>'));			
		/* TODO 테스트용파라미터. 운영반영전 삭제 필요 end */
		
		f.submit();
	}

</script>

</head>
<body id="body" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0">
	<table cellspacing="0" cellpadding="0" align="center" style="height: 100%;">
		<tr>
			<td></td>
		</tr>
	</table>
	<form id="eform" action="<c:url value='<%=servlet%>'/>" method="post">
	</form>
</body>
</html>
<%
	}
%>