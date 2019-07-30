<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovLoginUsr.jsp
  * @Description : Login 인증 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.03    박지욱          최초 생성
  *   2011.09.25    서준식          사용자 관리 패키지가 미포함 되었을때에 회원가입 오류 메시지 표시
  *   2011.10.27    서준식          사용자 입력 탭 순서 변경
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.03
  *  @version 1.0
  *  @see
  *
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
	<!-- Style Sheets -->
	<link rel="stylesheet" href="<c:url value='/css/login/cloudflare/pace-theme-minimal.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/login/cloudflare/metisMenu.min.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/login/cloudflare/animate.min.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/login/cloudflare/toastr.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/bootstrap/css/bootstrap.min.css'/>">
	<link rel="stylesheet" href="<c:url value='/bootstrap/css/font-awesome.min.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/login/style.min.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/login/theme-all.min.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/login/demo.min.css'/>">
	<!-- / Style Sheets -->

    <!-- Style Sheets -->
    <link rel="stylesheet" href="<c:url value='/css/login/login.min.css' />">
    <!-- / Style Sheets -->


<%-- <script type="text/javaScript" language="javascript" src="<c:url value='/js/egovframework/com/uat/uia/EgovGpkiVariables.js' />"></script>
<script type="text/javaScript" language="javascript" src="<c:url value='/js/egovframework/com/uat/uia/EgovGpkiInstall.js' />"></script>
<script type="text/javaScript" language="javascript" src="<c:url value='/js/egovframework/com/uat/uia/EgovGpkiFunction.js' />"></script>
<OBJECT ID="GPKISecureWeb" CLASSID = "CLSID:C8223F3A-1420-4245-88F2-D874FC081572"> --%>
</OBJECT>
<title>ISMS 로그인</title>
<script type="text/javaScript" language="javascript">

function checkLogin(userSe) {
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.rdoSlctUsr[0].checked = true;
        document.loginForm.rdoSlctUsr[1].checked = false;
        document.loginForm.rdoSlctUsr[2].checked = false;
        document.loginForm.userSe.value = "GNR";
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.rdoSlctUsr[0].checked = false;
        document.loginForm.rdoSlctUsr[1].checked = true;
        document.loginForm.rdoSlctUsr[2].checked = false;
        document.loginForm.userSe.value = "ENT";
    // 업무사용자
    } else if (userSe == "USR") {
        document.loginForm.rdoSlctUsr[0].checked = false;
        document.loginForm.rdoSlctUsr[1].checked = false;
        document.loginForm.rdoSlctUsr[2].checked = true;
        document.loginForm.userSe.value = "USR";
    }
}

function actionLogin() {

    if (document.loginForm.id.value =="") {
        alert("아이디를 입력하세요");
    } else if (document.loginForm.password.value =="") {
        alert("비밀번호를 입력하세요");
    } else {
        document.loginForm.action="<c:url value='/uat/uia/actionLogin.do'/>";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    }
}

function actionCrtfctLogin() {
    document.defaultForm.action="<c:url value='/uat/uia/actionCrtfctLogin.do'/>";
    document.defaultForm.submit();
}

function goFindId() {
    document.defaultForm.action="<c:url value='/uat/uia/egovIdPasswordSearch.do'/>";
    document.defaultForm.submit();
}

function goRegiUsr() {

	var useMemberManage = '${useMemberManage}';

	if(useMemberManage != 'true'){
		alert("사용자 관리 컴포넌트가 설치되어 있지 않습니다. \n관리자에게 문의하세요.");
		return false;
	}

    var userSe = document.loginForm.userSe.value;
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmMber.do'/>";
        document.loginForm.submit();
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmEntrprs.do'/>";
        document.loginForm.submit();
    // 업무사용자
    } else if (userSe == "USR") {
        alert("업무사용자는 별도의 회원가입이 필요하지 않습니다.");
    }
}

function goGpkiIssu() {
    document.defaultForm.action="<c:url value='/uat/uia/egovGpkiIssu.do'/>";
    document.defaultForm.submit();
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
    //form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
}

function fnInit() {
	/* if (document.getElementById('loginForm').message.value != null) {
	    var message = document.getElementById('loginForm').message.value;
	} */
    /* if (${message} != "") {
        alert(${message});
    } */

    getid(document.loginForm);
    // 포커스
    //document.loginForm.rdoSlctUsr.focus();
}

</script>
</head>
<body onLoad="fnInit();">
   <div class="single-container login-screen animated fadeInDown">
        <section class="sign-widget-title">
            <h1>ISMS 정보보호관리 시스템 </h1>
            <h4>&nbsp;</h4>
            <h4>시스템 로그인</h4>
        </section>
        <section class="sign-widget">
            <header>
                <h4>시스템 사용을 위해 로그인하셔야 합니다.</h4>
            </header>
            <div class="body">
                <form name="loginForm" action ="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                	<input name="userSe" type="hidden" value="USR"/>
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
                    <div class="form-actions">
                        <button class="btn btn-block btn-primary" type="" onclick="actionLogin();">
                            <span class="fa-icon-circle" >
                                <i class="fa fa-sign-in"></i>
                            </span>
                            <small class="l-mar-5">Login</small>
                        </button>
                        <div class="form-group">
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


