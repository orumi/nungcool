<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<head>
  <title>Login Page</title>
  <style>
    .error {
      padding: 15px;
      margin-bottom: 20px;
      border: 1px solid transparent;
      border-radius: 4px;
      color: #a94442;
      background-color: #f2dede;
      border-color: #ebccd1;
    }

    .msg {
      padding: 15px;
      margin-bottom: 20px;
      border: 1px solid transparent;
      border-radius: 4px;
      color: #31708f;
      background-color: #d9edf7;
      border-color: #bce8f1;
    }

    #login-box {
      width: 300px;
      padding: 20px;
      margin: 100px auto;
      background: #fff;
      -webkit-border-radius: 2px;
      -moz-border-radius: 2px;
      border: 1px solid #000;
    }
  </style>
</head>
<body>

<h1>Spring Security Login Form (Database Authentication)</h1>

<div id="login-box">

  <h3>Login with Username and Password</h3>

  <div>
    login has been successfully completed.
    <%
      LoginUserVO loginUserVO = (LoginUserVO) request.getAttribute("loginUserVO");
    %>
    Welcome mr.<%=loginUserVO.getName()%>

  </div>
</div>

</body>
</html>