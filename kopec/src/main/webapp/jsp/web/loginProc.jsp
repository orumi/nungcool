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
    //System.out.println("pass : " + passwd);

    if (tag != null){
	    if ("true".equals(tag)) {
	%>
	<script>
		top.location.href = "./main.jsp";
	</script>
	<%
	    }else{
	%>
	<script>
	alert("����� ������ �߸� �Ǿ����ϴ�.");
	self.close();
	top.location.href = "./login.jsp";
	</script>
	<%
	    }
    } else {
    	%>
    	<script>
    	alert("�߸��� ������ �ֽ��ϴ�.");
    	self.close();
    	top.location.href = "./login.jsp"
    	</script>
    	<%
    }
%>
