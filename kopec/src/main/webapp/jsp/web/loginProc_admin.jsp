<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nc.util.*" %>
<%@ page import="com.nc.cool.*" %>
<%
  	String userId = request.getParameter("userId");
	String passwd = request.getParameter("passwd");
	String flag   = request.getParameter("flag")==null?"":request.getParameter("flag");
	
    LoginUtil loginutil = new LoginUtil();
    loginutil.doAction(request, response);
	
    String tag = (String)request.getAttribute("tag");

    if (tag != null){
	    if ("true".equals(tag)) {
	%>
	<script>
		parent.location.href = "./main.jsp";
	</script>
	<%
	    }else{
	%>
	<script>
	alert("사용자 정보가 잘못 되었습니다.");
	self.close();
	parent.location.href = "./login_admin.jsp";
	//history.back();
	</script>
	<%
	    }
    } else {
    	%>
    	<script>
    	alert("잘못된 정보가 있습니다.");
    	self.close();
    	parent.location.href = "./login_admin.jsp"
    	//history.back();
    	</script>
    	<%    	
    }
%>
