<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  		<meta name="description" content="frequently asked questions using tabs and accordions" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		
		
<link rel="stylesheet" type="text/css" href="<c:url value='/css/exam/intro.css'/>"/>
<title>kpetro 한국석유관리원</title>
<script type="text/javascript">
//<![CDATA[

           
           function actionPerformed(tag){
        	   if( "exam_req" == tag ){
        		   window.location.href="<c:url value='/req/testRequest.do?sub=req&menu=testRequest'/>";
        	   }
           }
//]]>
</script>
</head>
<body>
<!-- header -->
<div class="header">
	<h1><img src="<c:url value='/images/exam/bg/logo01.gif'/>" alt="kpetro 한국석유관리원" /></h1>
</div>
<!-- //header -->

<!-- container -->
<div class="container">
	<!-- container_in -->
	<div class="container_in">
		<div class="intro_menu">
			<div class="intro_box menu01">
				<h2><img src="<c:url value='/images/exam/bg/h2_request.jpg'/>" alt="일반의뢰" /></h2>
				<p><img src="<c:url value='/images/exam/bg/request_txt.jpg'/>" alt="KOLAS 공인시험기관으로 석유 및 석유대체연료에 대한 국내외 표준규격으로 시험분석을 수행합니다." /></p>
				<ul>
					<li class="first"><a href="javascript:actionPerformed('exam_req');"><img src="<c:url value='/images/exam/btn/btn_application01.gif'/>" alt="시험의뢰" /></a></li>
					<li><a href="javascript:actionPerformed('exam_stat');"><img src="<c:url value='/images/exam/btn/btn_check01.gif'/>" alt="진행상태조회" /></a></li>
				</ul>
			</div>
			<div class="intro_box menu02">
				<h2><img src="<c:url value='/images/exam/bg/h2_court.jpg'/>" alt="법정공인" /></h2>
				<p><img src="<c:url value='/images/exam/bg/court_txt.jpg'/>" alt="석유대체연료 성능평가 자동차 에너지 효율 측정 자동차용 첨가제 검사 운행차 배출가스 저감장치 인증 건설기계 배출가스 인증 토양오염도 검사촉매제(요소수) 검사 등" /></p>
				<ul>
					<li class="first "><a href="#"><img src="<c:url value='/images/exam/btn/btn_application02.gif'/>" alt="시험의뢰" /></a></li>
					<li><a href="#"><img src="<c:url value='/images/exam/btn/btn_check02.gif'/>" alt="진행상태조회" /></a></li>
				</ul>
			</div>
			<div class="intro_box menu03">
				<h2><img src="<c:url value='/images/exam/bg/h2_training.jpg'/>" alt="교육" /></h2>
				<p><img src="<c:url value='/images/exam/bg/training_txt.jpg'/>" alt="국내 유일의 석유 및 석유대체연료 전문기관으로 기업체 기술지원 등 현장 기술 향상을 위한 교육프로그램을 수행합니다." /></p>
				<ul>
					<li class="first "><a href="#"><img src="<c:url value='/images/exam/btn/btn_application03.gif'/>" alt="교육신청" /></a></li>
					<li><a href="#"><img src="<c:url value='/images/exam/btn/btn_reissue01.gif'/>" alt="수료증 재발급" /></a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //container_in -->
</div>
<!-- //container -->

<!-- footer -->
<div class="footer">
	<!-- footer_in -->
	<div class="footer_in">
		<ul class="footer_info">
			<li class="first"><a href="#"><img src="<c:url value='/images/exam/btn/information.gif'/>" alt="개인정보 보호정책" /></a></li>
			<li><a href="#"><img src="<c:url value='/images/exam/btn/provision.gif'/>" alt="이용약관" /></a></li>
			<li><a href="#"><img src="<c:url value='/images/exam/btn/mail.gif'/>" alt="이메일" /></a></li>
			<li><a href="#"><img src="<c:url value='/images/exam/btn/refusal.gif'/>" alt="무단수집거부" /></a></li>
			<li><a href="#"><img src="<c:url value='/images/exam/btn/way.gif'/>" alt="찾아오시는길" /></a></li>
			<li><a href="#"><img src="<c:url value='/images/exam/btn/ad_mail.gif'/>" alt="관리자메일" /></a></li>
		</ul>
		<p class="address">
			[28115] 충청북도 청주시 청원구 오창읍 양청3길 33  전화 :043)240-7980 <br/>
			COPY RIGHT© 한국석유관리원 ALL RIGHTS RESERVED
		</p>
		<div class="move_btn">
			<span class="move_b">
				<select>
					<option>내부사이트</option>
					<option>내부사이트</option>
					<option>내부사이트</option>
				</select>
			</span>
			<a href="#"><img src="<c:url value='/images/exam/btn/btn_move01.gif'/>" alt="이동" /></a> 
		</div>
	</div>
	<!-- footer_in -->
</div>
<!-- //footer -->
</body>
</html>
