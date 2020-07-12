<%@ page language    = "java"
    contentType = "text/html; charset=euc-kr"
    import      = "java.util.*,
                   java.io.*,                   
                   com.nc.util.*,
                   com.nc.commu.*
                   "
%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	String groupId = (String) session.getAttribute("groupId");
	String userName = (String) session.getAttribute("userName");
	String userId = (String) session.getAttribute("userId");

%>
<% 	if (userId == null || ("".equals(userId))) {%>
<script language="javascript">
<!--
		var id = "<%=userId%>";
		var sure;
		if(id == "null" || id == "")	{
			alert("다시 로그인접속하여 주십시오.");
			top.location.href = "../loginProc.jsp";
		}
//-->
</script>
<%	}%>
<%
	Common_Data cd = null;
	cd = new Common_Data();

	/**********************
	String tableName 	= request.getParameter("tableName");
    if (tableName == null || tableName.equals("null")) tableName = "TBLPUBLICBOARD";
	**********************/
	String div_cd 	= request.getParameter("div_cd");
    if (div_cd == null || div_cd.equals("null")) div_cd = "1";
	
    String tag 			= request.getParameter("tag") == null ? "C" : (request.getParameter("tag")).trim();
    String seq 			= request.getParameter("seq") == null ? "" : (request.getParameter("seq")).trim();
    String currentPage 	= request.getParameter("currentPage") == null ? "1" : (request.getParameter("currentPage")).trim();
	String tmpFileName	= request.getParameter("tmpFileName") == null ? "" : request.getParameter("tmpFileName").trim();

	CommuBoard cB = new CommuBoard();
	cB.setCommuRecordDelete(request, response); 
	
	String error_msg = cd.Alert_Window("정상적으로 삭제되었습니다.", 7, "./bbs_list.jsp?div_cd="+div_cd+"&currentPage=1");
	out.println(error_msg);
%>
