<%@ page contentType="text/html; charset=euc-kr" %>
<%-- <%@ page import="com.kcube.slo.client.Slo" %> --%>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nc.util.*" %>
<%@ page import="com.nc.cool.*" %>
<%



    // recevie token param
    String token = request.getParameter("token");
    URL url = new URL("http://newportal.kepco-enc.com/ws/slo?wsdl");        //
    //String res = new Slo(url).getSloHttpSoap11Endpoint().checkOneTimeToken(token);
    String res = "";//new Slo(url).getSloHttpSoap11Endpoint().getEmpno(token);



    System.out.println("res:" + res);




    String userId = res;
    String flag   = "Y";


    session.setAttribute("loginUserId", userId);
    session.setAttribute("loginFlag", flag);

    LoginUtil loginUtil = new LoginUtil();
    loginUtil.doActionSLO(request, response);

    String tag = (String)request.getAttribute("tag");
    //System.out.println("pass : " + passwd);

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
    parent.location.href = "./login.jsp";

    </script>
    <%
        }
    } else {
        %>
        <script>
        alert("잘못된 정보가 있습니다.");
        self.close();
        parent.location.href = "./login.jsp"

        </script>
        <%
    }
%>
