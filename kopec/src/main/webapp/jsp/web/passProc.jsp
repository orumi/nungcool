<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nc.util.*" %>
<%@ page import="com.nc.cool.*" %>
<%
	String userId = (String)session.getAttribute("userId");

 // String userId = request.getParameter("userId");
	String passwd = request.getParameter("passwd");
	String npasswd = request.getParameter("npass");
	String cnpasswd = request.getParameter("cnpass");
	String flag   = request.getParameter("flag")==null?"":request.getParameter("flag");
	String ch_Pass="";
	
    LoginUtil loginutil = new LoginUtil();
    
   
    String tag = (String)request.getAttribute("tag");
    System.out.println("userId : " + userId);
    System.out.println("pass : " + passwd);
    System.out.println("npass : " + npasswd);
	System.out.println("cnpass : " + cnpasswd);
	npasswd = npasswd.trim();
	
	if ( passwd != null || !(passwd.equals(""))){
		loginutil.chack_pass(request, response);
		String chack = (String)request.getAttribute("chack");
		System.out.println("chack : "+chack);
		if("false".equals(chack)){
	   		%>
			<script>
			alert("기존 비밀번호를 정확히 입력해주세요");
			parent.location.href = "./pass.jsp";
			</script>
		<%	
			
		}else 	if (npasswd == null || npasswd.equals("") ) {
	   		%>
			<script>
			alert("신규 비밀번호를 입력해주세요");
			parent.location.href = "./pass.jsp";
			</script>
		<%	
			}else if (npasswd.equals(cnpasswd)) {
					loginutil.pass_change(request, response);
				%>		   		    
			   			<script>
			   			alert("정상적으로 변경하였습니다.");
			   			window.close(); 
		   			</script>
				<%
			   	}else {
		   		%>
			   			<script>
			   			alert("신규패스워드가 일치 하지 않습니다.");
			   			parent.location.href = "./pass.jsp";
			   			</script>
		  		<%	
		 			  }
	
	}
	%>
	


