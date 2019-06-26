<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="exam.com.main.model.LoginUserVO" %>

<%
    LoginUserVO loginUserVO = (LoginUserVO) request.getSession().getAttribute("loginUserVO");
%>
<script type="text/javascript">
    //<![CDATA[


    function actionMenu(tag) {
        if ("main" == tag) {
            window.location.href = "<c:url value='/setMain.do'/>";
        } else if ("testRequest" == tag) {
            window.location.href = "<c:url value='/req/testRequest.do?sub=req&menu=testRequest'/>";
        } else if ("reqList" == tag) {
            window.location.href = "<c:url value='/detail/reqList.do?sub=detail&menu=reqList'/>";
        } else if ("testReport" == tag) {
            window.location.href = "<c:url value='/report/testReport.do?sub=report&menu=testReport'/>";
        } else if ("community" == tag) {
            window.location.href = "<c:url value='/detail/reqList.do?sub=detail&menu=reqList'/>";
        } else if ("center" == tag) {
            window.location.href = "<c:url value='/detail/reqList.do?sub=detail&menu=reqList'/>";
        }

        else if ("myInfo" == tag) {
            window.location.href = "<c:url value='/login/loginProc.do?sub=support&menu=memberReg&loginTag=UD' />";
        }
    }


    function actionOpenReqDetail(detailReqid) {
        window.location.href = "<c:url value='/req/testRequest.do?sub=req&menu=testRequest'/>" + "&detailReqid=" + detailReqid;
    }

    function actionOpenReqView(detailReqid) {
        window.location.href = "<c:url value='/detail/detailRequest.do?sub=req&menu=testRequest'/>" + "&detailReqid=" + detailReqid;
    }


    /* 회원가입  */
    function actionMemberReg(tag) {

        if (tag == "infor") {
            window.location.href = "<c:url value='/member/pageMember.do?sub=support&menu=memberReg&pageURL=infor'/>";
        } else if (tag == "msg") {
            window.location.href = "<c:url value='/member/pageMember.do?sub=support&menu=memberReg&pageURL=msg'/>";
        } else {

            window.location.href = "<c:url value='/member/pageMember.do?sub=support&menu=memberReg'/>";

        }

    }

    function actionLogout() {
        window.location.href = "<c:url value='/setMain.do?logout=true' />";
    }

    function actionChangeURL(tag) {
        alert("준비중입니다." + tag);
    }


    //]]>
</script>


<!-- gnb -->
<div class="gnb">
    <div class="gnb_in">
        <div style="float:left; margin-top:1px;margin-right:6px;">
            <div type="button" class="btn btn-primary" style="height:17px;padding:2px 12px !important;"
                 onclick="javascript:actionChangeURL('cert');">
                법정공인
            </div>
            <div type="button" class="btn btn-primary" style="height:17px;padding:2px 12px !important;"
                 onclick="javascript:actionChangeURL('edu');">
                교육
            </div>
        </div>
        <div style="width:3px;float:left; margin-top:1px;margin-right:6px;">
        </div>
        <% if (loginUserVO != null) { %>
        <div style="float:left;margin-right:5px;margin-top:1px;"><a href="javascript:actionMenu('main');" class="mypw">HOME</a>
        </div>

        <div class="div-logout" style="float:left;margin-top:1px;">
            <a href="javascript:actionLogout();"><i class="fa fa-sign-out fa-logout"></i></a>
        </div>
        <div class="div-logout-text" style="float:left;margin-top:1px;">
            <a href="javascript:actionLogout();">로그아웃</a>
        </div>


        <% } else { %>
        <div style="float:left;margin-right:5px;margin-top:1px;"><a href="javascript:actionMenu('main');" class="mypw">HOME</a>
        </div>

        <div class="div-logout" style="float:left;margin-top:1px;">
            <a href="javascript:actionLogout();"><i class="fa fa-user fa-logout"></i></a>
        </div>
        <div class="div-logout-text" style="float:left;margin-top:1px;">
            <a href="javascript:actionMemberReg('info');">회원가입</a>
        </div>

        <% } %>

        <%--
        <ul class="first">
            <li class="g01"><a href="#"><img src="<c:url value='/images/exam/btn/btn_legal.gif'/>" alt="법정공인"/></a></li>
            <li class="g02"><a href="#"><img src="<c:url value='/images/exam/btn/btn_training.gif'/>" alt="교육"/></a>
            </li>
        </ul>
        <ul class="last">
            <li class=""><a href="<c:url value='/setMain.do'/>"><img
                    src="<c:url value='/images/exam/btn/btn_home.gif'/>" alt="home"/></a></li>
            <li class=""><a href="#"><img src="<c:url value='/images/exam/btn/btn_membership.gif'/>" alt="회원가입"/></a>
            </li>
        </ul> --%>
    </div>
</div>
<!-- //gnb -->
<!-- header -->
<div class="header">
    <!-- menu -->
    <div class="menu">
        <h1><a href="javascript:actionMenu('main');"><img src="<c:url value='/images/exam/bg/logo.png'/>"
                                                          alt="kpetro 한국석유관리원"/></a></h1>
        <ul>
            <li><a href="javascript:actionMenu('testRequest');"> <img
                    src="<c:url value='/images/exam/menu/m01_off.gif'/>"
                    onmouseover="this.src='<c:url value='/images/exam/menu/m01_on.gif'/>'"
                    onmouseout="this.src='<c:url value='/images/exam/menu/m01_off.gif'/>'" alt="시험신청"/></a></li>
            <li><a href="javascript:actionMenu('reqList');"> <img src="<c:url value='/images/exam/menu/m02_off.gif'/>"
                                                                  onmouseover="this.src='<c:url
                                                                          value='/images/exam/menu/m02_on.gif'/>'"
                                                                  onmouseout="this.src='<c:url
                                                                          value='/images/exam/menu/m02_off.gif'/>'"
                                                                  alt="접수내역"/></a></li>
            <li><a href="javascript:actionMenu('testReport');"> <img
                    src="<c:url value='/images/exam/menu/m03_off.gif'/>"
                    onmouseover="this.src='<c:url value='/images/exam/menu/m03_on.gif'/>'"
                    onmouseout="this.src='<c:url value='/images/exam/menu/m03_off.gif'/>'" alt="시험서확인"/></a></li>


            <li><a href="<c:url value='/community/notice/list.do?sub=community&menu=notice'/>"><img
                    src="<c:url value='/images/exam/menu/m04_off.gif'/>"
                    onmouseover="this.src='<c:url value='/images/exam/menu/m04_on.gif'/>'"
                    onmouseout="this.src='<c:url value='/images/exam/menu/m04_off.gif'/>'" alt="커뮤니티"/></a></li>

            <% if (loginUserVO == null) {%>
            <li><a href="<c:url value='/member/pageMember.do?sub=support&menu=memberReg'/>"><img
                    src="<c:url value='/images/exam/menu/m05_off.gif'/>"
                    onmouseover="this.src='<c:url value='/images/exam/menu/m05_on.gif'/>'"
                    onmouseout="this.src='<c:url value='/images/exam/menu/m05_off.gif'/>'" alt="고객지원센터"/></a></li>
            <%
              } else {
            %>
            <li><a href="<c:url value='/login/loginProc.do?sub=support&menu=memberReg&loginTag=UD'/>">
                <img src="<c:url value='/images/exam/menu/m05_off.gif'/>"
                     onmouseover="this.src='<c:url value='/images/exam/menu/m05_on.gif'/>'"
                     onmouseout="this.src='<c:url value='/images/exam/menu/m05_off.gif'/>'" alt="고객지원센터"/></a></li>
            <%
            }
            %>

        </ul>
    </div>
    <!-- //menu -->
</div>

