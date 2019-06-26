<%@page import="exam.com.main.model.StateVO" %>
<%@page import="exam.com.main.model.LoginUserVO" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    LoginUserVO loginUserVO = (LoginUserVO) request.getSession().getAttribute("loginUserVO");

    String memid = "";
    String memname = "";
    String comname = "";

    String s01 = "0";
    String s02 = "0";
    String s03 = "0";
    String s04 = "0";

    if (loginUserVO != null) {
        memid = loginUserVO.getMemid();
        memname = loginUserVO.getMemname();
        comname = loginUserVO.getComname();

        StateVO stateVO = (StateVO) request.getAttribute("stateVO");
        if (stateVO != null) {
            s01 = stateVO.getS01();
            s02 = stateVO.getS02();
            s03 = stateVO.getS03();
            s04 = stateVO.getS04();
        }
    }
%>
<script>

    function entkey() {
        if (event.keyCode == 13) {
            fn_login(); // 로그인 메소드 실행
        }
    }

    function fn_login() {
        var frm = document.loginfrm;
        if (frm.memid.value == "") {
            alert("아이디를 입력하여 주시기 바랍니다.");
            return;
        } else if (frm.mempw.value == "") {
            alert("비밀번호를 입력하여 주시기 바랍니다.");
            return;
        }

        var url = "<c:url value='/login/loginService.do' />";
        var surl = "<c:url value='/setMain.do' />";

        $.ajax({
            type: "post",
            dataType: "json",
            data: {"memid": frm.memid.value, "mempw": frm.mempw.value},
            url: url,
            success: function (result) {

                if ("Y" == result.RESULT_LOGIN) {
                    window.location.href = surl;
                } else if ("OC" == result.RESULT_LOGIN) {
                    window.location.href = "<c:url value='/login/loginProc.do?sub=support&menu=loginProc&loginTag=OC' />";
                } else if ("M" == result.RESULT_LOGIN) {
                    alert("중복된 정보가 있습니다. 운영자에게 문의하시면 처리해 드립니다.");
                } else if("P" == result.RESULT_LOGIN){
					window.location.href = "<c:url value='/login/loginProc.do?sub=support&menu=loginProc&loginTag=P' />";


                } else if ("N" == result.RESULT_LOGIN) {
                    alert("등록되지 않은 아이디 또는 비밀번호 입니다.");
                    $("#memid").val("");
                    $("#mempw").val("");
                }
                /*
                 if(result.RESULT_YN =="N"){
                 var Ca = /\+/g;
                 alert(decodeURIComponent( result.RESULT_MESSAGE.replace(Ca, " ") ));
                 //alert(result.RESULT_MESSAGE);
                 }else{
                 window.location.href=surl;
                 } */
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            },
            complete: function (data) {
                //gridView.hideToast();
            },

        });

    }


</script>


<!-- container -->
<div class="container">
    <!-- left_warp (왼쪽 비주얼) -->
    <div class="main_left_warp">
        <!-- visual -->
        <div class="visual">
            <!-- slideshow -->
            <div id="slideshow">
                <ul id="slides">
                    <li class="img01">
                        <img src="<c:url value='/images/exam/bg/visual_bg01.jpg'/>" class=""
                             alt="의뢰시험절차안내 신청부터 성적서발급까지 각 단계별로 자세한 내용을 안내해드립니다. "/>
                        <a href="#" class="btn"><img src="<c:url value='/images/exam/btn/btn_content.gif'/>"
                                                     alt="자세한 내용보기"/></a>
                    </li>
                    <li class="img01">
                        <img src="<c:url value='/images/exam/bg/visual_bg02.jpg'/>" class=""
                             alt="의뢰시험절차안내 신청부터 성적서발급까지 각 단계별로 자세한 내용을 안내해드립니다."/>
                        <a href="#" class="btn"><img src="<c:url value='/images/exam/btn/btn_content.gif'/>"
                                                     alt="자세한 내용보기"/></a>
                    </li>
                    <li class="img01">
                        <img src="<c:url value='/images/exam/bg/visual_bg03.jpg'/>" class=""
                             alt="의뢰시험절차안내 신청부터 성적서발급까지 각 단계별로 자세한 내용을 안내해드립니다."/>
                        <a href="#" class="btn"><img src="<c:url value='/images/exam/btn/btn_content.gif'/>"
                                                     alt="자세한 내용보기"/></a>
                    </li>
                    <li class="img01">
                        <img src="<c:url value='/images/exam/bg/visual_bg04.jpg'/>" class=""
                             alt="의뢰시험절차안내 신청부터 성적서발급까지 각 단계별로 자세한 내용을 안내해드립니다."/>
                        <a href="#" class="btn"><img src="<c:url value='/images/exam/btn/btn_content.gif'/>"
                                                     alt="자세한 내용보기"/></a>
                    </li>
                </ul>
            </div>
            <!-- //slideshow -->
            <ul id="pagination" class="pagination">
                <li onclick="slideshow.pos(0)"></li>
                <li onclick="slideshow.pos(1)"></li>
                <li onclick="slideshow.pos(2)"></li>
                <li onclick="slideshow.pos(3)"></li>
            </ul>
        </div>
        <!-- //visual -->
        <script type="text/javascript">
            var slideshow = new TINY.fader.fade('slideshow', {
                id: 'slides',
                auto: 2,
                resume: true,
                navid: 'pagination',
                activeclass: 'current',
                visible: true,
                position: 0
            });
        </script>

        <!-- test_btn -->
        <div class="test_btn">
            <ul>
                <li class="first"><a href="javascript:actionMenu('testRequest');"><img
                        src="<c:url value='/images/exam/btn/btn_test.jpg'/>" alt="의뢰시험 신청 의뢰시험 신청 설명입니다."/></a></li>
                <li><a href="javascript:actionMenu('reqList');"><img
                        src="<c:url value='/images/exam/btn/btn_progression.jpg'/>" alt="진행상태 확인 진행상태 확인 설명입니다."/></a>
                </li>
            </ul>
        </div>
        <!-- test_btn -->

        <!-- notice_wrap -->
        <div class="notice_wrap">
            <!-- 공지사항 -->
            <div class="notice">
                <h4>
                    <img src="<c:url value='/images/exam/bg/notice.gif'/>" alt="공지사항"/>
                    <a href="#"><img src="<c:url value='/images/exam/btn/btn_next01.gif'/>" alt="더보기"/></a>
                </h4>
                <ul>
                    <c:forEach var="boardList" items="${boardList}">

                        <li><a href="<c:url value='community/notice/read.do?bID='/>${boardList.bID}">
                            <c:choose>
                                <c:when test="${fn:length(boardList.title) > 28}">
                                    <c:out value="${fn:substring(boardList.title,0,27)}"/>....
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${boardList.title}"/>
                                </c:otherwise>
                            </c:choose>
                            <span class="days">${boardList.regDate}</span></a></li>
                    </c:forEach>
                </ul>
            </div>
            <!-- //공지사항 -->
            <!-- 자주하는질문 -->
            <div class="question">
                <h4>
                    <img src="<c:url value='/images/exam/bg/question.gif'/>" alt="자주하는질문"/>
                    <a href="#"><img src="<c:url value='/images/exam/btn/btn_next01.gif'/>" alt="더보기"/></a>
                </h4>
                <ul>
                    <c:forEach var="faqList" items="${faqList}">
                        <li><a href="<c:url value='community/faq/read.do?bID='/>${faqList.bID}">
                            <c:choose>
                                <c:when test="${fn:length(faqList.title) > 28}">
                                    <c:out value="${fn:substring(faqList.title,0,27)}"/>....
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${faqList.title}"/>
                                </c:otherwise>
                            </c:choose>
                            <span class="days">${faqList.regDate}</span></a></li>
                    </c:forEach>
                </ul>
            </div>
            <!-- //자주하는질문 -->
        </div>
        <!-- //notice_wrap -->
    </div>
    <!-- //left_warp (왼쪽 비주얼) -->

    <!-- right_warp(오른쪽 로그인 및 버튼) -->
    <div class="main_right_warp">
        <% if (loginUserVO != null) { %>
        <div class="login">
            <h4><img src="<c:url value='/images/exam/bg/member_login.gif'/>" alt="Member Login"/></h4>
            <ul class="id_pw" style="float:left">
                <div class="login-user">
                    <i class="fa fa-user fa-lg fa-fw fa-login"></i>
                </div>
                <div style="float:right;padding-top:2px;">
                    <div class="loginname" style="width:74px;"><%=memname %>님</div>
                    <div style="float:right;margin-left:12px;">
                        <div class="myinfo"><a href="javascript:actionMenu('myInfo');">내정보</a></div>
                    </div>
                    <div style="margin-top:25px;padding-top:2px;padding-left:2px;width:134px;height:15px;overflow:hidden;position:absolute; "><%=comname %>
                    </div>
                </div>
            </ul>
            <div class="login-info">
                <div class="div-logout" style="float:left;">
                    <a href="javascript:actionLogout();"><i class="fa fa-sign-out fa-logout"></i></a>
                </div>
                <div class="div-logout-text" style="float:left;">
                    <a href="javascript:actionLogout();">로그아웃</a>
                </div>
                <div style="float:right;margin-right:23px;margin-top:5px;"><a href="${pageContext.request.contextPath}/member/pswordChange.do?sub=support&menu=memberReg" class="mypw">비밀번호변경</a>
                </div>
            </div>
            <div class="div-state" style="margin-top:31px;margin-left: 2px;margin-right: 2px; margin-bottom:-15px;">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th width="70%">구 분</th>
                        <th width="30%">건 수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>접수진행</td>
                        <td align="center"><span class="badge bg-color-blueLight">
                        <c:choose>
                            <c:when test="${stateVO.s01 eq null}">0</c:when>
                            <c:otherwise>${stateVO.s01}</c:otherwise>
                        </c:choose></span></td>
                    </tr>
                    <tr>
                        <td>분석진행</td>
                        <td align="center"><span class="badge bg-color-blueLight">
                        <c:choose>
                            <c:when test="${stateVO.s02 eq null}">0</c:when>
                            <c:otherwise>${stateVO.s02}</c:otherwise>
                        </c:choose></span></td>
                    </tr>
                    <tr>
                        <td>성적서발급완료(미출력)</td>
                        <td align="center"><span class="badge bg-color-blueLight">
                        <c:choose>
                            <c:when test="${stateVO.s03 eq null}">0</c:when>
                            <c:otherwise>${stateVO.s03}</c:otherwise>
                        </c:choose></span></td>
                    </tr>
                    <tr>
                        <td>등본(통합)신청</td>
                        <td align="center"><span class="badge bg-color-blueLight">
                        <c:choose>
                            <c:when test="${stateVO.s04 eq null}">0</c:when>
                            <c:otherwise>${stateVO.s04}</c:otherwise>
                        </c:choose></span></td>
                    </tr>
                    </tbody>
                </table>
            </div>


        </div>
        <% } else { %>
        <form name="loginfrm" id="loginfrm">
            <div class="login">
                <h4><img src="<c:url value='/images/exam/bg/member_login.gif'/>" alt="Member Login"/></h4>
                <ul class="id_pw">
                    <li class="id"><input type="text" placeholder="아이디를 입력 하세요" id="memid" name="memid" onkeypress="entkey();"
                                          style="ime-mode:inactive"/></li>
                    <li class="pw"><input type="password" placeholder="비밀번호를 입력 하세요" id="mempw" name="mempw"
                                          onkeypress="entkey();" style="ime-mode:inactive"/></li>
                    <li class="id_save"><input type="checkbox"/> 아이디 저장</li>
                </ul>
                <p class="login_btn"><a href="javascript:fn_login();"><img
                        src="<c:url value='/images/exam/btn/btn_login.gif'/>" alt="Member Login"/></a></p>
                <ul class="member_id">
                    <li class="menber"><a href="<c:url value='/member/pageMember.do?sub=support&menu=memberReg'/>"><img
                            src="<c:url value='/images/exam/btn/btn_membership01.gif'/>" alt="회원가입"/></a></li>
                    <li class="id_pw_ find"><a href="${pageContext.request.contextPath}/member/idInquiry.do?sub=support&menu=searchID">
                        <img src="<c:url value='/images/exam/btn/btn_idpass.gif'/>" alt="아이디 비밀번호"/></a></li>
                </ul>
            </div>
        </form>
        <% } %>
        <p class="estimat"><a href="${pageContext.request.contextPath}/support/testRequest.do?sub=support&menu=testRequest"><img
                src="<c:url value='/images/exam/btn/btn_estimate.jpg'/>" alt="견적서 산출"/></a></p>

        <p class="mark"><a href="javascript:alert('위변조');"><img src="<c:url value='/images/exam/btn/btn_mark.jpg'/>"
                                                                alt="성적서 위변조 확인"/></a></p>

        <p class="issue_member">
            <span><a href="${pageContext.request.contextPath}/report/testReport.do?sub=report&menu=testReport"><img src="<c:url value='/images/exam/btn/btn_issue.jpg'/>" alt="등본발급요청"/></a></span>
            <span><a href="#"><img src="<c:url value='/images/exam/btn/btn_member.jpg'/>" alt="연회비회원"/></a></span>
        </p>

        <p class="btn_service">
            <span><a href=""><img src="<c:url value='/images/exam/btn/btn_service.jpg'/>" alt="설비계약서비스"/></a></span>
            <span><a href="#"><img src="<c:url value='/images/exam/btn/btn_service01.jpg'/>" alt="교육신청서비스"/></a></span>
        </p>

        <p><a href="#"><img src="<c:url value='/images/exam/btn/btn_phone.jpg'/>" alt="문의전화 043-243-7980"/></a></p>
    </div>
    <!-- //right_warp(오른쪽 로그인 및 버튼) -->
</div>
<!-- //container -->
