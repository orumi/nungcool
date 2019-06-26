<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ page import="tems.com.common.StringUtils" %>
<% session.setAttribute("loginUserVO", null); 
	String ecd = StringUtils.nvl(request.getParameter("ecd"),"");
%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>종합시험관리시스템</title>

		<meta name="description" content="User login page" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css' />" />
		<link rel="stylesheet" href="<c:url value='/assets/css/font-awesome.min.css' />" />

		<!-- text fonts -->
		<link rel="stylesheet" href="<c:url value='/assets/css/ace-fonts.css' />" />

		<!-- ace styles -->
		<link rel="stylesheet" href="<c:url value='/assets/css/ace.min.css' />" />

		<!--[if lte IE 9]>
			<link rel="stylesheet" href="<c:url value='/assets/css/ace-part2.min.css' />" />
		<![endif]-->
		<link rel="stylesheet" href="<c:url value='/assets/css/ace-rtl.min.css' />" />

		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="<c:url value='/assets/css/ace-ie.min.css' />" />
		<![endif]-->
		<link rel="stylesheet" href="<c:url value='/assets/css/ace.onpage-help.css' />" />

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="<c:url value='/assets/js/html5shiv.js' />"></script>
		<script src="<c:url value='/assets/js/respond.min.js' />"></script>
		<![endif]-->
		
		
		<script>
			<%if(!ecd.equals("")){
				if(ecd.equals("1")){
					%>
					alert("메뉴 사용권한이 없습니다..");
					<%
				} else if(ecd.equals("2")){
					%>
					alert("사용자 정보가 없습니다.");
					<%
				}
			}%>
			
			function entkey(){
			    if(event.keyCode == 13){
			    	fn_login(); // 로그인 메소드 실행
			    }
			}
		
			function fn_login(){
				var frm = document.loginfrm;
				if(frm.adminid.value == ""){
					alert("아이디를 입력하여 주시기 바랍니다.");
					return;
				} else if(frm.adminpw.value == ""){
					alert("비밀번호를 입력하여 주시기 바랍니다.");
					return;
				}
				
			     var url = "<c:url value='/login/userLogin.do' />";
			     var surl = "<c:url value='/setMain.do' />";
	
			     $.ajax({
						type : "post",
					    dataType : "json",
					    data : {"adminid":frm.adminid.value,"adminpw":frm.adminpw.value},
			            url:url,
			            success: function(result){			            	
			                 if(result.RESULT_YN =="N"){
			                	var Ca = /\+/g;
			                	alert(decodeURIComponent( result.RESULT_MESSAGE.replace(Ca, " ") )); 
		                	 	//alert(result.RESULT_MESSAGE);
			                 }else{
				                window.location.href=surl;
				             }
				        }			            
			        });

			}
		
		</script>
	</head>

	<body class="login-layout light-login">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">
							<div class="center">
								<h1>
									<i class="ace-icon fa fa-leaf green"></i>
									<span class="red">K</span>
									<span class="white" id="id-text2">Petro</span>
								</h1>
								<h4 class="blue" id="id-company-text">&copy; 종합시험관리시스템</h4>
							</div>

							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-coffee green"></i>
												Please Enter Your Information
											</h4>

											<div class="space-6"></div>

											<form name="loginfrm" id="loginfrm">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="adminid" id="adminid" name="adminid" onkeypress="entkey();" />
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="adminpw" id="adminpw" name="adminpw" onkeypress="entkey();" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>

													<div class="space"></div>

													<div class="clearfix">
														<button type="button" class="width-35 pull-right btn btn-sm btn-primary" onclick="javascript:fn_login()">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110">로그인</span>
														</button>
													</div>

												</fieldset>
											</form>

										</div><!-- /.widget-main -->
									</div><!-- /.widget-body -->
								</div><!-- /.login-box -->


							</div><!-- /.position-relative -->
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script type="text/javascript">
		var txt = "<c:url value='/assets/js/jquery.min.js' />"
			window.jQuery || document.write("<script src="+txt+">"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
		<script type="text/javascript">
		var txt = "<c:url value='/assets/js/jquery1x.min.js' />"
				 window.jQuery || document.write("<script src="+txt+">"+"<"+"/script>");
		</script>
		<![endif]-->
		<script type="text/javascript">
		var txt = "<c:url value='/assets/js/jquery.mobile.custom.min.js' />"
			if('ontouchstart' in document.documentElement) document.write("<script src="+txt+">"+"<"+"/script>");
		</script>
		
		<script>
		document.loginfrm.adminid.focus();
		</script>
	</body>
</html>