<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : collLogin.jsp
  * @Description : Login 인증 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2019.02.03    박지욱          최초 생성
  *
  *  @author
  *  @since 2019.  .  .
  *  @version 1.0
  *  @see
  *
  *  Copyright (C) 2019 by NCSYS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >

	<style type="text/css">


	</style>


    <!-- Style Sheets -->
    <link rel="stylesheet" href="<c:url value='/css/login/login.min.css' />">
    <!-- / Style Sheets -->


<title>로그인</title>
<script type="text/javaScript" language="javascript">


</script>
</head>
<body onLoad="fnInit();">
   <div class="single-container login-screen animated fadeInDown">
        <section class="sign-widget-title">
            <h1 style="margin-bottom:16px;">NCSYS BSC 성과관리 시스템 </h1>
            <h4>시스템 로그인</h4>
        </section>
        <section class="sign-widget">
            <header>
                <h4>시스템 사용을 위해 로그인하셔야 합니다.</h4>
            </header>
            <div class="body">
                <form name="loginForm" action ="<c:url value='/cmm/login/coolActionLogin.do'/>" method="post">
                	<input name="userSe" type="hidden" value="GNR"/>
                	<input name="j_username" type="hidden"/>
                    <fieldset>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fa fa-user"></i>
                                </span>
                                <input type="text" name="id" id="id" class="form-control"  style="ime-mode: disabled;" tabindex="4" maxlength="10"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fa fa-lock" style="width:11px;"></i>
                                </span>
                                <input type="password" name="password" id="password" class="form-control" style="ime-mode: disabled;" maxlength="12" tabindex="5" onKeyDown="javascript:if (event.keyCode == 13) { actionLogin(); }"/>
                            </div>
                        </div>
                    </fieldset>
                    <div style="margin-bottom:6px;margin-top:12px;">
                        <button class="btn btn-block btn-primary" type="" onclick="actionLogin();">
                            <span class="fa-icon-circle" >
                                <i class="fa fa-sign-in"></i>
                            </span>
                            <small class="l-mar-5">Login</small>
                        </button>
                        <div class="form-group" style="margin-top:12px;">
                        <a href="#" class="forgot">비밀번호 찾기</a>
                        |
                        <a href="register.html" class="register">계정 요청&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </a>
                        </div>
                    </div>
                </form>
            </div>

        </section>
    </div>

</body>
</html>


