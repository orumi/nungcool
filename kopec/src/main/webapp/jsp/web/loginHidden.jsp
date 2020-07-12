<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*" %>

<%

	String id = (String)session.getAttribute("id")!=null?(String)session.getAttribute("id"):"";
	String userId = (String)session.getAttribute("userId")!=null?(String) session.getAttribute("userId"):"";
	String userName = (String)session.getAttribute("userName")!=null?(String) session.getAttribute("userName"):"";
	String userGroup = (String)session.getAttribute("userGroup")!=null?(String) session.getAttribute("userGroup"):"";
	
%>
<script>
    var isScorecardOpen = true;
    var isMapOpen = false;
        
    top.userInfo.id = '<%=id%>';
    top.userInfo.userId = '<%=userId%>'; 
    top.userInfo.userName = '<%=userName%>';
    top.userInfo.userGroup = '<%=userGroup%>';
    
    function initFrame() {

    }
</script>
<html>
<body onload="initFrame()">
</body>
</html>

