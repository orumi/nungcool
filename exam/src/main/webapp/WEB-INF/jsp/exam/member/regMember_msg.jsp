<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>

</head>
<body>
<form action="" method="post">
<!-- wrap -->

		<!-- right_warp(오른쪽 내용) -->
		<div class="right_warp">
			<div class="title_route">
				<h3>회원가입</h3>
				<p class="route">
					<img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 고객지원 센터 <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt="" /> <span>회원가입</span>
				</p>
			</div>
			<!-- m_screen01  -->
			<div class="m_screen01">
				<p class="name">
					<span class="txt01"><%=request.getSession().getAttribute("welcomeJoinName")%></span>
					<span class="txt02">님!</span><br>
					<span class="txt03">KPetro TEMS시스템</span>
					에 가입해 주셔서 감사합니다.
				</p>
				<!-- m_screen01_in -->
				<div class="m_screen01_in">
					<p class="txt01">가입하신 아이디는 <span><%=request.getSession().getAttribute("welcomeJoinId")%></span> 입니다.</p>
					<p class="txt02">Kpetro는 타업체 명의 도용으로 인한 피해를 방지하기 위하여 회원 실명제를 시행하고 있습니다.
					<br/>운영자의 확인 절차 후에 서비스 이용이 불가능할 수도 있습니다.</p>
					<p class="txt03"><strong>[회원가입 완료]</strong> 아래의 연락처로 문의하시면 안내해 드리겠습니다 .<br/>감사합니다.</p>
					<ul class="mail_phon">
						<li>abcde@gamil.com</li>
						<li>043-243-7980</li>
					</ul>
				</div>
				<!-- //m_screen01_in -->
				<p class="txt_C m_T40"><a href="${pageContext.request.contextPath}/login.do?reqURL=/exam/community/notice/list.do&sub=community&menu=notice"><img src="<c:url value='/images/exam/btn/btn_check06.gif'/>" alt="확인"/></a></p>
			</div>
			<!-- //m_screen01  -->
		</div>
		<!-- //right_warp(오른쪽 내용) -->


</form>
</body>
</html>
