<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nc.util.*" %>
<%@ page import="com.nc.cool.*" %>
<%
    String userId = request.getParameter("userId");

    LoginUtil loginutil = new LoginUtil();
    loginutil.doActionSimga(request, response);
	
    String tag = (String)request.getAttribute("tag");
	String mid = (String)request.getAttribute("mid");
    if (tag != null){
	    if ("true".equals(tag)) {
	%>
	<script>
	parent.location.href = "./main.jsp?mode=sigma&mid=<%=mid%>&strDate=200506";
	</script>
	<%
	        }else{
	%>
	<script>
	alert("����� ������ �߸� �Ǿ����ϴ�.");
	</script>
	<%
	    }
    } else {
    	%>
    	<script>
    	alert("�߸��� ������ �ֽ��ϴ�.");
    	</script>
    	<%    	
    }
%>
