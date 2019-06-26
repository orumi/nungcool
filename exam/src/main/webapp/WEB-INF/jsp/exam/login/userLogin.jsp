<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   /* 로그인 후 이동해야할 페이지 정보  */
    String contextPath = request.getContextPath();
	String nextURL = contextPath+"/setMain.do";

	String reqURL = request.getParameter("reqURL");
	String sub = request.getParameter("sub");
	String menu = request.getParameter("menu");
	
	if(reqURL!=null){
		nextURL = reqURL+"?sub="+sub+"&menu="+menu+"&redirect=true";
	} 

%>
	

<head>

 <link rel="stylesheet" type="text/css" href="<c:url value='/css/exam/sub.css'/>"/>
</head>
<script>

	
	function entkey(){
	    if(event.keyCode == 13){
	    	fn_login(); // 로그인 메소드 실행
	    }
	}

	function fn_login(){
		var frm = document.loginfrm;
		if(frm.memid.value == ""){
			alert("아이디를 입력하여 주시기 바랍니다.");
			return;
		} else if(frm.mempw.value == ""){
			alert("비밀번호를 입력하여 주시기 바랍니다.");
			return;
		}
		
	     var url = "<c:url value='/login/loginService.do' />";
	     var surl = "<%=nextURL%>";

	     $.ajax({
				type     : "post",
			    dataType : "json",
			    data : {"memid":frm.memid.value,"mempw":frm.mempw.value},
	            url:url,
	            success: function(result){	
	            	
					if("Y" == result.RESULT_LOGIN){
						window.location.href = surl;
					} else if("OC" == result.RESULT_LOGIN){
						window.location.href = "<c:url value='/login/loginProc.do?sub=support&menu=loginProc&loginTag=OC' />";
					} else if("M" == result.RESULT_LOGIN){
						/* 비밀번호 이중으로 존재하는 경우  */
						alert("중복된 정보가 있습니다. 운영자에게 문의하시면 처리해 드립니다.");
					} else if("P" == result.RESULT_LOGIN){
						window.location.href = "<c:url value='/login/loginProc.do?sub=support&menu=loginProc&loginTag=P' />";	
					} else if ("N" == result.RESULT_LOGIN){
						alert("등록되지 않은 아이디 또는 비밀번호 입니다.");
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
		        error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        },
		        complete: function (data) {
		        	//gridView.hideToast();
		        },
			    
	        });

	}
</script>

	<!-- container -->
	<div class="container">
		<!-- login_wrap -->
		<div class="login_wrap">
			<!-- login_box -->
			<div class="login_box">
			<form name="loginfrm" id="loginfrm">
				<ul class="login_input">
					<li class="first">
					<input type="text" class="form-control" placeholder="memid" id="memid" name="memid" onkeypress="entkey();" style="ime-mode:inactive;margin-top:2px;"/>
					<!-- input type="text" value="아이디를 입력하세요" />  -->
					</li>
					<li>
					<input type="password" class="form-control" placeholder="mempw" id="mempw" name="mempw" onkeypress="entkey();" style="ime-mode:inactive" />
					</li>
					<li class="btn" style="padding-top:0px;"><a href="javascript:fn_login();"><img src="<c:url value='/images/exam/btn/btn_login_box01.gif'/>" alt="로그인"/></a></li>
				</ul>
				<ul class="member">
					<li class="first">
						<span>회원가입을 하시면 Kpetro모든 서비스를 편리하게 이용하실 수 있습니다.</span>
						<span><a href="javascript:actionMemberReg();"><img src="<c:url value='/images/exam/btn/btn_login_box02.gif'/>" alt="회원가입"/></a></span>
					</li>
					<li class="">
						<span>아이디/비밀번호를 잊으셨나요?</span>
						<span class="member_btn">
							<a href="#"><img src="<c:url value='/images/exam/btn/btn_login_box03.gif'/>" alt="아이디찾기"/></a>
							<a href="#"><img src="<c:url value='/images/exam/btn/btn_login_box04.gif'/>" alt="비밀번호찾기"/></a>
						</span>
					</li>
				</ul>
				<p class="call_bg"><img src="<c:url value='/images/exam/bg/call_bg.gif'/>" alt="상담콜센터 043-243-7980"/></p>
			</form>
			</div>
			<!-- /login_box -->
		</div>
		<!-- //login_wrap -->
		<div class="login_notice">
			<ul>
				<li>아이디 찾기는 업체명, 성명, 핸드폰번호 인증부여로 알림서비스를 제공합니다.</li>
				<li>임시비밀번호 제공은 업체명 성명 핸드폰번호 인증부여 과정을 거친 후 임시비밀번호가 부여됩니다.</li>
			</ul>
		</div>
	</div>
	<!-- //container -->

	

		
		<script>
		document.loginfrm.memid.focus();
		</script>