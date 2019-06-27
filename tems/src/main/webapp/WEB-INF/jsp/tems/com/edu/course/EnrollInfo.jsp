<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%
	LoginUserVO nLoginVO = (LoginUserVO)session.getAttribute("loginUserVO");
%>

<script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<link rel="stylesheet" href="<c:url value='/css/tems/edu/edu.css' />">



<!-- /row-->
<div class="row">
<!-- --------------------------------------------------------------------------------------------------- -->

<!-- /메인박스 -->
<div id="edu_content" class="col-lg-10" >

	<div id="enrollerinfo" class="col-lg-12 data_tbl">
	
		<!-- /title-box-->
		<div class="title-box">
			<div class="col-sm-6 info_title">
				<i class="fa fa-th-large va"></i> 
				<span>홍길동 님 교육훈련정보</span>
			</div>
			<div class="col-sm-6 pr_0">
				<a href="./courseDetail.do?cosID=${courseEnroll.cosID}&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }"><button class="btn btn-default btn-sm  pull-right" >리스트</button></a>
			</div>
				
		</div>
		<!-- /.title-box-->
	
		<div id="tbl_view" class="view_tbl">
			<table class="table table-bordered ">
				<tr>
					<th >교육훈련명</th>
					<td colspan="3">${courseEnroll.cosName }</td>
				</tr>
				<tr>
					<th>수강료</th>
					<td>${courseEnroll.cosPrice }원</td>
					<th>장소</th>
					<td>${courseEnroll.cosPlace }</td>
				</tr>
				<tr>
					<th>접수기간</th>
					<td>${courseEnroll.enrollStartDate }~${courseEnroll.enrollEndDate }</td>
					<th>훈련기간</th>
					<td>${courseEnroll.cosStartDate }~${courseEnroll.cosEndDate }</td>
				</tr>
				<tr>
					<th>업체명</th>
					<td>${courseEnroll.comName }</td>
					<th>대표자</th>
					<td>${courseEnroll.comCEO }</td>
				</tr>
				<tr>
					<th>핸드폰</th>
					<td>${courseEnroll.hp }</td>
					<th>이메일</th>
					<td>${courseEnroll.email }</td>
				</tr>
				
			</table>
		</div>
	
			
		<!-- /접수상태관리 -->
		<div role="content" class="clear-both sub-content edu_wz enrollwz ">
			
							
			<div class="form-horizontal form-terms ui-sortable ">
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>접수상태 관리</h2>
						<button class="btn btn-default btn-xs  pull-right enrollwz_header_btn" >신청서보기</button>
						<button class="btn btn-default btn-xs  pull-right enrollwz_header_btn" >견적서보기</button>
					</header>
			
					<!-- body -->    	
					<div class="widget-body">
						<form id="enrollStateMng" action="./updateEnrollState.do" method="post">
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">접수상태/${courseEnroll.enrollState }</label>
								<div class="col-md-10 ">
									<c:forEach items="${enrollStateList}" var="enrollState">
										<label class="radio radio-inline form_box">
											<input type="radio" class="radiobox" name="enrollState" value="${enrollState.codeID }" <c:if test="${courseEnroll.enrollState == enrollState.codeID }"> checked="checked"</c:if>>
											<span>${enrollState.codeName }(${enrollState.codeID })</span> 
										</label>
									</c:forEach>
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">접수완료 알림(견적서)/${courseEnroll.mailEstimate }/${courseEnroll.smsEstimate }</label>
								<div class="col-md-10 form-inline">
									<label class="checkbox-inline form_box">
										 <input type="checkbox" class="checkbox" name="mailEstimate" value="y" <c:if test="${'y' == courseEnroll.mailEstimate }"> checked</c:if> >
										 <span>메일발송</span>
									</label>
									<label class="checkbox-inline form_box">
										  <input type="checkbox" class="checkbox" name="smsEstimate" value="y" <c:if test="${'y' == courseEnroll.smsEstimate }"> checked</c:if> >
										  <span>문자발송</span>
									</label>
								</div>
							</div>
							</fieldset>	
							
							<div class="btn-box">
								<button type="submit" class="btn btn-default btn-sm" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
							</div>
							
							cosID:<input type="text" name="cosID" value="${courseEnroll.cosID }">
							enrollID:<input type="text" name="enrollID" value="${courseEnroll.enrollID }">		
							adminID:<input type="text" name="adminID" value="<%=nLoginVO.getAdminid()%>">
						</form>
				<!--  end of  form-horizontal tems_search  -->
				<!--  end of jarviswidget -->
					</div>
				</div>
			
				<!-- end of widget-body -->
			</div>
				<!--  end of content -->			
		</div>
		<!-- /.접수상태관리 -->
	
	
		<!-- /결제상태관리 -->
		<div role="content" class="clear-both sub-content edu_wz enrollwz ">
			
							
			<div class="form-horizontal form-terms ui-sortable ">
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>결제상태 관리</h2>
						<button class="btn btn-default btn-xs  pull-right enrollwz_header_btn" >환불정보보기</button>
					</header>
			
					<!-- body -->    	
					<div class="widget-body">
						<form id="payStateMng" action="./updatePayState.do" method="post">
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">결제상태/${pay.payState }</label>
								<div class="col-md-10 ">
									<c:forEach items="${payStateList}" var="payState">
										<label class="radio radio-inline form_box">
												<input type="radio" class="radiobox" name="payState" value="${payState.codeID }" <c:if test="${pay.payState == payState.codeID }"> checked="checked"</c:if>>
												<span>${payState.codeName }(${payState.codeID })</span> 
										</label>
									</c:forEach>
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">결제완료 알림/${pay.mailPayed }/${pay.smsPayed }</label>
								<div class="col-md-10 form-inline">
									
									<label class="checkbox-inline form_box">
										  <input type="checkbox" class="checkbox" name="mailPayed" value="y" <c:if test="${'y' == pay.mailPayed }"> checked</c:if> >
										  <span>메일발송</span>
									</label>
									<label class="checkbox-inline form_box">
										  <input type="checkbox" class="checkbox" name="smsPayed"  value="y" <c:if test="${'y' == pay.smsPayed }"> checked</c:if> >
										  <span>문자발송</span>
									</label>
								</div>
							</div>
							</fieldset>
							
							<div class="btn-box">
								<button type="submit" class="btn btn-default btn-sm" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
							</div>
							
							cosID:<input type="text" name="cosID" value="${courseEnroll.cosID }">
							enrollID:<input type="text" name="enrollID" value="${pay.enrollID }">	
							payID:<input type="text" name="payID" value="${pay.payID }">
							adminID:<input type="text" name="adminID" value="<%=nLoginVO.getAdminid()%>">
						</form>
				<!--  end of  form-horizontal tems_search  -->
				<!--  end of jarviswidget -->
					</div>
				</div>
			
				<!-- end of widget-body -->
			</div>
				<!--  end of content -->			
		</div>
		<!-- /.결제상태관리 -->
		
			
	   	<!-- 결제정보관리 -->
		<div role="content" class="clear-both sub-content edu_wz enrollwz ">
			
							
			<div class="form-horizontal form-terms ui-sortable ">
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>결제정보 관리</h2>
					</header>
			
					<!-- body -->    	
					<div class="widget-body">
						<form id="payInfoMng" action="./updatePayInfo.do" method="post">
							<fieldset>
								<div class="col-md-12 form-group">
									<label class="col-md-2 form-label">교육비</label>
									<div class="col-md-10 form-inline">
										<label class="form_box">${courseEnroll.cosPrice}원</label>
									</div>
								</div>
							</fieldset>	
					
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">결제방법/${pay.payType }</label>
								<div class="col-md-10 ">
									<c:forEach items="${payTypeList}" var="payType">
										<label class="radio radio-inline form_box">
												<input type="radio" class="radiobox" name="payType" value="${payType.codeID }" <c:if test="${pay.payType == payType.codeID }"> checked="checked"</c:if>>
												<span>${payType.codeName }(${payType.codeID })</span> 
										</label>
									</c:forEach>
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">세금계산서/${pay.taxType }</label>
								<div class="col-md-3 ">
									<c:forEach items="${taxTypeList}" var="taxType">
										<label class="radio radio-inline form_box">
												<input type="radio" class="radiobox" name="taxType" value="${taxType.codeID }" <c:if test="${pay.taxType == taxType.codeID }"> checked="checked"</c:if>>
												<span>${taxType.codeName }(${taxType.codeID })</span> 
										</label>
									</c:forEach>
								</div>
								
								<label class="col-md-2 form-label">수신메일</label>
								<div class="col-md-5  form-inline form_box">
									<input type="text" class="form-control w200" name="taxEmail" value="${pay.taxEmail }">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<button class="btn btn-default btn-xs" >세금계산서발급</button>
									&nbsp;
									<span>2013-05-09</span>
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">결제시기/${pay.payTime }</label>
								<div class="col-md-10 ">
									<c:forEach items="${payTimeList}" var="payTime">
										<label class="radio radio-inline form_box">
												<input type="radio" class="radiobox" name="payTime" value="${payTime.codeID }" <c:if test="${pay.payTime == payTime.codeID }"> checked="checked"</c:if>>
												<span>${payTime.codeName }(${payTime.codeID })</span> 
										</label>
									</c:forEach>
								</div>
							</div>
							</fieldset>	
							
							<div class="btn-box">
								<button type="submit" class="btn btn-default btn-sm" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
							</div>
							
							cosID:<input type="text" name="cosID" value="${courseEnroll.cosID }">
							enrollID:<input type="text" name="enrollID" value="${pay.enrollID }">	
							payID:<input type="text" name="payID" value="${pay.payID }">
							adminID:<input type="text" name="adminID" value="<%=nLoginVO.getAdminid()%>">
						</form>
				<!--  end of  form-horizontal tems_search  -->
				<!--  end of jarviswidget -->
					</div>
				</div>
			
				<!-- end of widget-body -->
			</div>
				<!--  end of content -->			
		</div>
		<!-- /.결제정보관리 -->
		
	
		<!-- /접수증관리 -->
		<div role="content" class="clear-both sub-content edu_wz enrollwz ">
			
							
			<div class="form-horizontal form-terms ui-sortable ">
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>접수증 관리</h2>
						<button class="btn btn-default btn-xs  pull-right enrollwz_header_btn" >접수증보기</button>
					</header>
			
					<!-- body -->    	
					<div class="widget-body">
				
						<fieldset>
						<div class="col-md-12 form-group">
							<label class="col-md-2 form-label">접수증발급</label>
							<div class="col-md-10 form-inline form_box">
								<span class="receiptNO">${receipt.receiptNO }</span>
							</div>
						</div>
						</fieldset>	
						
						<fieldset>
						<div class="col-md-12 form-group">
							<label class="col-md-2 form-label">접수완료 알림(접수증)/${receipt.mailReceipt }/${receipt.smsReceipt }</label>
							<div class="col-md-10 form-inline">
								<label class="checkbox-inline form_box">
									  <input type="checkbox" class="checkbox" name="mailReceipt" value="y" <c:if test="${'y' == receipt.mailReceipt }"> checked</c:if> >
									  <span>메일발송</span>
								</label>
								<label class="checkbox-inline form_box">
									  <input type="checkbox" class="checkbox" name="smsReceipt"  value="y" <c:if test="${'y' == receipt.smsReceipt }"> checked</c:if> >
									  <span>문자발송</span>
								</label>
							</div>
						</div>
						</fieldset>	
						
						<div class="btn-box">
							<button class="btn btn-default btn-sm">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</button>
						</div>
				<!--  end of  form-horizontal tems_search  -->
				<!--  end of jarviswidget -->
					</div>
				</div>
			
				<!-- end of widget-body -->
			</div>
				<!--  end of content -->			
		</div>
		<!-- /.접수증관리 -->
	
		
		<!-- /평가관리 -->
		<div role="content" class="clear-both sub-content edu_wz enrollwz ">
			
							
			<div class="form-horizontal form-terms ui-sortable ">
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>평가 관리</h2>
					</header>
			
					<!-- body -->    	
					<div class="widget-body">
						<form id="gradeMng" action="./updateGrade.do" method="post">
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">수료유무/${grade.pass }</label>
								<div class="col-md-10 ">
									
									<label class="radio radio-inline form_box">
										<input type="radio" class="radiobox" name="pass" value="1" <c:if test="${1 == grade.pass }"> checked="checked"</c:if>>
										<span>수료</span> 
									</label>
									<label class="radio radio-inline form_box">
										<input type="radio" class="radiobox" name="pass" value="2" <c:if test="${2 == grade.pass }"> checked="checked"</c:if> >
										<span>미수료</span>  
									</label>
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">점수/${grade.score }</label>
								<div class="col-md-10 form-inline form_box">
									<input type="text" class="form-control w50 "  name="score" value="${grade.score }">&nbsp; 점
								</div>
							</div>
							</fieldset>	
						
							<div class="btn-box">
								<button type="submit" class="btn btn-default btn-sm" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
							</div>
							
							cosID:<input type="text" name="cosID" value="${courseEnroll.cosID }">
							enrollID:<input type="text" name="enrollID" value="${courseEnroll.enrollID }">	
							gradeID:<input type="text" name="gradeID" value="${grade.gradeID }">
							adminID:<input type="text" name="adminID" value="<%=nLoginVO.getAdminid()%>">
						</form>
				<!--  end of  form-horizontal tems_search  -->
				<!--  end of jarviswidget -->
					</div>
				</div>
			
				<!-- end of widget-body -->
			</div>
				<!--  end of content -->			
		</div>
		<!-- /.평가관리 -->
		
	
		<!-- /수료증관리 -->
		<div role="content" class="clear sub-content edu_wz enrollwz">
			
							
			<div class="form-horizontal form-terms ui-sortable ">
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>수료증 관리</h2>
						<button class="btn btn-default btn-xs  pull-right enrollwz_header_btn" >수료증보기</button>
					</header>
			
					<!-- body -->    	
					<div class="widget-body">
						<form id="certificateMng" action="./updateCertificate.do" method="post">
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">수료증발급/${certificate.certificateIssue }</label>
								<div class="col-md-3 form-inline form_box">
									<span class="certificateNO">${certificate.certificateNO }</span>
								</div>
								<label class="checkbox-inline form_box">
										  <input type="checkbox" class="checkbox" name="certificateIssue" value="y" <c:if test="${'y' == certificate.certificateIssue }"> checked="checked"</c:if>>
										  <span>발행대상</span>
								</label>
							
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">수료증발금 알림/${certificate.mailCertificate }/${certificate.smsCertificate }</label>
								<div class="col-md-10 form-inline">
										
									<label class="checkbox-inline form_box">
										  <input type="checkbox" class="checkbox" name="mailCertificate" value="y" <c:if test="${'y' == certificate.mailCertificate }"> checked="checked"</c:if>>
										  <span>메일발송</span>
									</label>
									<label class="checkbox-inline form_box">
										  <input type="checkbox" class="checkbox" name="smsCertificate" value="y" <c:if test="${'y' == certificate.smsCertificate }"> checked="checked"</c:if>>
										  <span>문자발송</span>
									</label>
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-2 form-label">프린트</label>
								<div class="col-md-2 form-inline form_box">
									<span>2016-03-03</span>&nbsp;
									<i class="fa fa-times text-danger"></i>
								</div>
								<div class="col-md-2 form-inline form_box">
									<span>2016-03-03</span>&nbsp;
									<i class="fa fa-times text-danger"></i>
								</div>
							</div>
							</fieldset>	
							
							<div class="btn-box">
								<button class="btn btn-default btn-sm">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</button>
							</div>
							
							cEnrollID:<input type="text" name="cEnrollID" value="${certificate.cEnrollID }">
							eEnrollID:<input type="text" name="eEnrollID" value="${certificate.eEnrollID }">		
							certificateID:<input type="text" name="certificateID" value="${certificate.certificateID }">
						</form>
				<!--  end of  form-horizontal tems_search  -->
				<!--  end of jarviswidget -->
					</div>
				</div>
			
				<!-- end of widget-body -->
			</div>
				<!--  end of content -->			
		</div>
		<!-- /.수료증관리 -->
		
		
		
		<!-- /.버튼-->
		<div class="title-box">
			<div class="col-sm-6 info_title">
				
			</div>
			<div class="col-sm-6 pr_0">
				<a href="./courseDetail.do?cosID=${courseEnroll.cosID}&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }"><button class="btn btn-default btn-sm  pull-right" >리스트</button></a>
			</div>
		</div>
		<!-- /.버튼-->

	</div>
	
</div>
<!-- /.메인박스 -->

<!-- /도움말박스 -->
<div class="col-lg-2 well">

</div>
<!-- /.도움말박스 -->






<!-- --------------------------------------------------------------------------------------------------- -->
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</div>
<!-- /.row-->

<script>
//접수증 발급
$("#btn_receipt").on("click", function(event){
	var enrollID = "${courseEnroll.enrollID }";
	var adminID = "<%=nLoginVO.getAdminid()%>";
	
	var receiptVO = {
		"rEnrollID": enrollID ,
		"issueID": adminID 
	};
	
	if($(".receiptNO").text()==''){
	
		$.ajax({
			type: "post",
			url: "<c:url value= '/edu/course/insertReceipt.json' />", 
			data : JSON.stringify(receiptVO),
			contentType: "application/json",
			success:function(receiptNO){
				$(".receiptNO").text(receiptNO);
			}
		});
	}
	else{
		alert("접수증이 이미발급되었습니다.")
	}
 
});



//수료증 발급
$("#btn_certificate").on("click", function(event){
	var enrollID = "${courseEnroll.enrollID }";
	var adminID = "<%=nLoginVO.getAdminid()%>";
	
	var certificateVO = {
		"cEnrollID": enrollID ,
		"issueID": adminID 
	};
	
	if($(".certificateNO").text()==''){
	
		$.ajax({
			type: "post",
			url: "<c:url value= '/edu/course/insertCertificate.json' />", 
			data : JSON.stringify(certificateVO),
			contentType: "application/json",
			success:function(certificateNO){
				$(".certificateNO").text(certificateNO);
			}
		});
	}
	else{
		alert("수료증이 이미발급되었습니다.")
	}
 
});


</script>




