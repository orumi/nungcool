<%@ page contentType="text/html; charset=euc-kr" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"))+"/jsp/web/";

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):"";
	if(!id.equals("")) {

		String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
		String mid = request.getParameter("mid")!=null?request.getParameter("mid"):"";
		String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):"";

%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>한국전력기술(주) :: 성과관리시스템</title>
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
     	document.all.mainFrm.document.all.contentFrm.rows = "0, 0,*,0, 0,0,0, 0";
        scorecardFrm.openTree(date,id,level);
        topFrm.clikScorecard();
    }

    function closeTopMenu() {
    	document.all.mainFrm.rows="11,*,0";

    	if (eis.leftMenu!=null)
    		eis.leftMenu.style.display="none";
    	if (score.leftMenu !=null)
    		score.leftMenu.style.display="none";
    	if (analysis.leftMenu !=null)
    		analysis.leftMenu.style.display="none";
    	if (actual.leftMenu !=null)
    		actual.leftMenu.style.display="none";
    	if (valuate.leftMenu !=null)
    		valuate.leftMenu.style.display="none";
    	if (board.leftMenu!=null)
    		board.leftMenu.style.display="none";
    	if (admin.leftMenu!=null)
    		admin.leftMenu.style.display="none";
    }

    function openTopMenu() {
    	document.all.mainFrm.rows="49,*,0";

    	if (eis.leftMenu!=null)
    		eis.leftMenu.style.display="inline";
    	if (score.leftMenu!=null)
    		score.leftMenu.style.display="inline";
    	if (analysis.leftMenu!=null)
    		analysis.leftMenu.style.display="inline";
    	if (actual.leftMenu!=null)
    		actual.leftMenu.style.display="inline";
    	if (valuate.leftMenu!=null)
    		valuate.leftMenu.style.display="inline";
    	if (board.leftMenu!=null)
    		board.leftMenu.style.display="inline";
    	if (admin.leftMenu!=null)
    		admin.leftMenu.style.display="inline";

    }

    function openMenu() {
    	document.all.mainFrm.rows="49,*,0";
    }
    function closeMenu() {
    	document.all.mainFrm.rows="49,*,0";
    }
    function openScoreTable(dId,tId,level,year,month){
		openMenu();
		document.all.mainFrm.document.all.contentFrm.rows = "0, 0,*,0, 0,0,0, 0";
    	score.openScoreTable(dId,tId,level,year,month);
    }

</script>
</head>

<frameset rows="*">
    	<frameset id="mainFrm" name="mainFrm" rows="49,*,0" cols="*" border="0" >
    		<frame src="topmenu.jsp?mode=<%=mode%>" name="topFrm" scrolling="no" noresize>
    		<frameset name="contentFrm" id="contentFrm" rows="*, 0,0,0, 0,0,0, 0" cols="*" frameborder="no" border="0" framespacing="0">
    		    	<frame src="FrmMain.jsp" name="FrmMain" id="main" scrolling="no">

    		    	<frame src="FrmEis.jsp"  name="FrmEis" id="eis" scrolling="auto">
    		    	<frame src="FrmScorecard.jsp" name="FrmScorecard" id="score" scrolling="auto">
                	<frame src="" name="FrmAnalysis" id="analysis" scrolling="auto">

                	<frame src="" name="FrmActual"   id="actual"  scrolling="auto">
    		    	<frame src="" name="FrmValuate"  id="valuate" scrolling="auto">
    		    	<frame src="FrmBoard.jsp" name="FrmBoard"  id="board" scrolling="auto">

    		    	<frame src="" name="FrmAdmin" id="admin" scrolling="auto">
    		</frameset>
    		<frame src="loginHidden.jsp" name="hiddenFrm" scrolling="no" noresize>
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