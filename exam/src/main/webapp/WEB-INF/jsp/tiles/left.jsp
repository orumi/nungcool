<%@ page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="exam.com.main.model.LoginUserVO " %>

<%

    /*
    
    	main : main page
    	req  : 시험신청
    	detail : 접수내역
    	report : 성적서
    	
    */

	String sub = request.getParameter("sub")!=null?request.getParameter("sub"):"main";
	String menu = request.getParameter("menu")!=null?request.getParameter("menu"):"";


	String subTitle = "시험신청";

	if("detail".equals(sub)){
		subTitle = "접수내역";
	} else if ("report".equals(sub)){
		subTitle = "성적서확인";
	} else if ("community".equals(sub)){
		subTitle = "커뮤니티";
	} else if ("support".equals(sub)){
		subTitle = "고객지원센터";
	} else if ("".equals(sub)){
		subTitle = "";
	}

%>


<%
	LoginUserVO loginUserVO = (LoginUserVO) request.getSession().getAttribute("loginUserVO");
%>



	<!-- left_warp(왼쪽 메뉴) -->
		<div class="left_warp">
			<% if("support".equals(sub)) {%>
				<h2 style="font-size:22px;"><%=subTitle%></h2>
			<% } else { %>
				<h2><%=subTitle%></h2>
			<% } %>
			<ul class="snb">
				<% if ("req".equals(sub)){ %>
					<li class="<%="intro".equals(menu)?"select":"" %>" ><a href="<c:url value='/req/intro.do?sub=req&menu=intro'/>"><span class="text">신청안내</span></a></li>
					<li class="last <%="testRequest".equals(menu)?"select":"" %>"><a href="<c:url value='/req/testRequest.do?sub=req&menu=testRequest'/>" ><span class="text">일반시험의뢰</span></a></li>
					<li class="bottom_bg"><span>&nbsp;</span></li>
				<% } else if("detail".equals(sub)){ %>
					<li class="<%="reqList".equals(menu)?"select":"" %>" ><a href="<c:url value='/detail/reqList.do?sub=detail&menu=reqList'/>"><span class="text">접수정보조회<br>&nbsp;&nbsp;&nbsp;(수수료납부)</span></a></li>
					<li class="last <%="state".equals(menu)?"select":"" %>"><a href="<c:url value='/detail/state.do?sub=detail&menu=state'/>" ><span class="text">분석진행상태</span></a></li>
					<li class="bottom_bg"><span>&nbsp;</span></li>
				<% } else if("report".equals(sub)){ %>
					<li class="<%="testReport".equals(menu)?"select":"" %>" ><a href="<c:url value='/report/testReport.do?sub=report&menu=testReport'/>"><span class="text">성적서 발급조회</span></a></li>
					<li class="last <%="copyReport".equals(menu)?"select":"" %>"><a href="<c:url value='/report/copyReport.do?sub=report&menu=copyReport'/>" ><span class="text">등본(통합)발급</span></a></li>
					<li class="bottom_bg"><span>&nbsp;</span></li>
				<% } else if("community".equals(sub)){ %>
					<li class="<%="notice".equals(menu)?"select":"" %>" ><a href="<c:url value='/community/notice/list.do?sub=community&menu=notice'/>"><span class="text">공지사항</span></a></li>
				    <li class="<%="pds".equals(menu)?"select":"" %>" ><a href="<c:url value='/community/pds/list.do?sub=community&menu=pds'/>"><span class="text">자료실</span></a></li>
					<li class="last <%="faq".equals(menu)?"select":"" %>"><a href="<c:url value='/community/faq/list.do?sub=community&menu=faq'/>" ><span class="text">자주묻는 질문</span></a></li>
					<li class="bottom_bg"><span>&nbsp;</span></li>

				<% } else if("support".equals(sub)){ %>
					<!-- 로그인 안되었을 때-->
					<% if (loginUserVO == null) {%>
					    <li class="<%="help".equals(menu)?"select":"" %>" ><a href=""><span class="text">도움말</span></a></li>
					    <li class="<%="memberReg".equals(menu)?"select":"" %>" ><a href="<c:url value='/member/pageMember.do?sub=support&menu=memberReg'/>"><span class="text">회원가입</span></a></li>
					    <li class="<%="searchID".equals(menu)?"select":"" %>"><a href="<c:url value='/member/idInquiry.do?sub=support&menu=searchID'/>" ><span class="text">아이디/비밀번호찾기</span></a></li>
					    <li class="last <%="testRequest".equals(menu)?"select":"" %>"><a href="<c:url value='/support/testRequest.do?sub=support&menu=testRequest'/>" ><span class="text">견적서 산출</span></a></li>
					    <li class="bottom_bg"><span>&nbsp;</span></li>
					<%} else {%>
					<!-- 로그인 되었을 때-->
				        <li class="<%="help".equals(menu)?"select":"" %>" ><a href=""><span class="text">도움말</span></a></li>
				        <li class="<%="membership".equals(menu)?"select":"" %>" ><a href="<c:url value='/member/membership.do?sub=support&menu=membership'/>"><span class="text">연회비회원</span></a></li>
				        <li class="<%="equipment".equals(menu)?"select":"" %>" ><a href="<c:url value='/member/equipment.do?sub=support&menu=equipment'/>"><span class="text">설비계약서비스</span></a></li>
				        <li class="<%="memberReg".equals(menu)?"select":"" %>" ><a href="<c:url value='/login/loginProc.do?sub=support&menu=memberReg&loginTag=UD'/>"><span class="text">자기정보 수정</span></a></li>
				        <li class="last <%="searchID".equals(menu)?"select":"" %>"><a href="<c:url value='/member/pswordChange.do?sub=support&menu=searchID'/>" ><span class="text">비밀번호 변경</span></a></li>
				        <li class="bottom_bg"><span>&nbsp;</span></li>
					<%}%>
				<% } %>
			</ul>
			<div class="service_btn_w">
				<span class="left_btn_T">&nbsp;</span>
				<ul class="service_btn">
					<li class="first"><a href=".html">등본발급요청</a></li>
					<li><a href=".html">연회비회원</a></li>
					<li><a href=".html">설비계약서비스</a></li>
					<li class="last"><a href=".html">교육신청서비스</a></li>
				</ul>
				<span class="left_btn_b">&nbsp;</span>
			</div>
			<p class="phone"><img src="<c:url value='/images/exam/btn/btn_phone.gif'/>" alt="문의전화 040-243-7980"/></p>
		</div>
		<!-- //left_warp(왼쪽 메뉴) -->