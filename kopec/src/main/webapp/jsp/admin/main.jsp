<%@ page contentType="text/html; charset=euc-kr" %>
<%	
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"))+"/jsp/web/";

	String id = "admin";//(String)session.getAttribute("id")!=null?(String)session.getAttribute("id"):""; 
	if(!id.equals("")) {
		
		String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
		String mid = request.getParameter("mid")!=null?request.getParameter("mid"):"";
		String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):"";
%>

<html>
<head>
<title>BSC ADMINISTRATOR</title>
<jsp:include page="../../jsp/web/js/js.jsp" flush="true"/>
<script language="JavaScript" type="text/JavaScript">
    // 유저정보
    userInfo = {
        id:"",
        userId:"",
        userName:"",
        userGroup:""
    }
    
    function openTree(date,id,level){
     	document.all.mainFrm.document.all.contentFrm.rows = "0,*,0,0,0, 0,0";
        scorecardFrm.openTree(date,id,level);
        topFrm.clikScorecard();
    } 
    
    function closeTopMenu() {
    	document.all.mainFrm.rows="0,*,0";
    }
    
    function openTopMenu() {
    	document.all.mainFrm.rows="55,*,0";
    }
</script>
</head>

<frameset rows="*">
    	<frameset name="mainFrm" rows="45,*,0" cols="*" border="0" >
    		<frame src="topmenu.jsp?mode=<%=mode%>" name="topFrm" scrolling="no" noresize>
    		<frameset name="contentFrm" rows="*,0,0,0,0,0,0" cols="*" frameborder="no" border="0" framespacing="0">
    		    	<frame src="FrmETL.jsp" name="FrmETL" scrolling="no">
                	<frame src="" name="FrmDB" scrolling="no">
    		</frameset>
    	</frameset>
</frameset>
<noframes>
<body>
<P> 프레임을 사용하고 있습니다. 프레임에 대응하는 브라우저로 보시기 바랍니다. </p>
</body>
</noframes>
</html>
<script language="JavaScript" type="text/JavaScript">

</script>
<%
    } else {
%>
<script>
	alert("잘못된 접속입니다.");
  	top.location.href = "./loginProc.jsp";
</script>
<%
    }
%>