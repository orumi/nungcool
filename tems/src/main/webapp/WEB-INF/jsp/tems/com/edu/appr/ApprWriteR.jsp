<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<link rel="stylesheet" href="<c:url value='/css/tems/edu/edu.css' />">



<!-- /row-->
<div class="row">
<!-- --------------------------------------------------------------------------------------------------- -->



<div class="col-lg-10">
	<form id="appPaperForm" action="insertApprR.do" method="post">
	
		<!-- col-12-->
		<!-- 결재선 왼쪽-->
		<div class="col-lg-7">
			<!-- 타이틀 -->
			<div class="dt-title pull-left">
				<i class="fa fa-th-large"></i> 
				<span>결재선</span>
			</div>
			<!-- /타이틀 -->
			
			<!-- 버튼 -->
			<div class="pull-right">
				<button class="btn btn-default btn-sm ">결재선지정</button>
			</div>
			<!-- /버튼 -->	
			
			<!-- 결재라인 테이블 -->	
			<div class="view_tbl">
				<table class="table table-bordered ">
					<tr>
						<th>구분</th>
						<th>기안자</th>
						<th>1차승인</th>
						<th>2차승인</th>
						<th>3차승인</th>
						<th>4차승인</th>
					</tr>
					<tr id="apprDetail">
						<th>결재자</th>
						<td id="appr_draftName"></td>
						<td id="appr_fstName"></td>
						<td id="appr_sndName"></td>
						<td id="appr_trdName"></td>
						<td id="appr_fthName"></td>
					</tr>
					<tr>
						<th>결재일</th>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					
				</table>
			</div>
			<!-- /결재라인 테이블 -->
		
		</div>
		<!-- /결재선 왼쪽-->
		
		<!-- /최상단 오른쪽-->
		<div class="col-lg-5">
		<!--결재선 템플릿-->
			<div role="content" class="clear-both sub-content">
	
				<!--  start of  form-horizontal tems_search  -->
				<!--  start of widget-body -->
				<div class="form-horizontal form-terms ui-sortable"> 
					<div class="jarviswidget jarviswidget-sortable" role="widget">	
						<header role="heading">
							<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
							<h2>결재정보</h2>
						</header>
	
						<!-- body -->    	
						<div class="widget-body" style="overflow-y:scroll; height:105px">
							<table class="table table-hover table-unborder">
								<colgroup>
									<col width="8%" /> <!-- 번호 -->
									<col  /> <!-- 결재선 -->
								</colgroup>
								<tbody>
									<c:forEach items="${apprList}" var="apprList">
										<tr class="apprLine " data-apprlineid=${apprList.apprlineid }>
											<td>${apprList.apprlineid }</td>
											<td>${apprList.apprnm }</td>
										</tr>
									</c:forEach>
								</tbody>
								</table>
						<!--  end of  form-horizontal tems_search  -->
						<!--  end of jarviswidget -->
						</div>
					</div>
					<!-- end of widget-body -->
				</div>
				<!--  end of content -->			
		    </div>
			<!-- /결재선 템플릿 -->	
		
		</div>
		<!-- /.상단 오른쪽-->
		<!-- / col-12-->

	
		<!-- col-12-->
		<div class="col-lg-12">
			<!-- 타이틀 -->
			<div class="dt-title pull-left">
				<i class="fa fa-th-large"></i> 
				<span>결재내용</span>
			</div>
			<!-- /타이틀 -->
			
			<!-- 본문 -->
			<div id="tbl_view">
				<table class="table table-bordered ">
					<tr>
						<td>
							<!-- 제목 -->
							<div class="apprName">
								<input type="text" class="form-control input_400" name="apprName" value="" >								
							</div>
							<!-- /제목 -->
						</td>
					</tr>
					<tr>

						<td>
							<!-- 내용 -->
							<div class="apprContent" >
								<textarea class="form-control" rows="5" name="apprContent" ></textarea>
							</div>
							<div class="are">-아래-</div>
							<!-- /내용 -->


<!-- -------------------------------------------------------------------------------------------------------------------------------------------- -->
							
							<!-- 데이타 테이블 리스트-->	
							<div class="data_list view_tbl apprList">
								<div class="dt-title pull-right">
									<span>총인원: 5명</span>
								</div>
								
								<table class="table table-bordered table-striped table-hover">
									<colgroup>
										
										<%-- <col width="3%" />  <!-- 번호 -->
										<col /> 			<!-- 교육훈련명 -->
										<col />				<!-- 교육비 -->
										<col width="5%" />	<!-- 이름 -->
										<col width="10%" />	<!-- 핸드폰 -->
										<col />				<!-- 이메일 -->
										<col width="10%" />	<!-- 접수상태 -->
										<col width="10%" />	<!-- 결제방법 -->
										<col width="5%" />	<!-- 결제시기 -->
										<col width="6%" />	<!-- 결제상태 -->
										<col width="5%" />	<!-- 계산서종류 -->
										<col width="5%" />	<!-- 계산서발급 --> --%>
									</colgroup>
					
									<thead>
										<tr>
											<th>번호</th>
											<th>교육훈련명</th>
											<th>교육비</th>
											<th>이름</th>
											<th>핸드폰</th>
											<th>이메일</th>
											<th>접수상태</th>
											<th>결제상태</th>
										</tr>
					
									</thead>
									<tbody>
										<c:forEach items="${apprMemberList }" var="apprMember">
											<tr>
												<td>${apprMember.enrollID }</td>
												<td class="text-left">${apprMember.cosName }</td>
												<td>${apprMember.payPrice }</td>
												<td>${apprMember.memName }</td>
												<td>${apprMember.hp }</td>
												<td>${apprMember.email }</td>
												<td>${apprMember.enrollStateName }(${payMemberList.enrollStateID })</td>
												<td>${apprMember.payStateName}(${payMemberList.payStateID})</td>
											</tr>
										</c:forEach>
									</tbody>
					
								</table>
					
							</div>
							<!-- /데이타 테이블 리스트-->	

<!-- -------------------------------------------------------------------------------------------------------------------------------------------- -->
						
							<!-- 히든 영역 -->
							<div>	
									<input type="text"  name="draftID"  value="" class="draftID">
									<input type="text"  name="firstID"  value="" class="firstID">
									<input type="text"  name="secondID"  value="" class="secondID">
									<input type="text"  name="thirdID"  value="" class="thirdID">
									<input type="text"  name="fourthID"  value="" class="fourthID" >
									<br>
									<c:forEach items="${apprMemberList }" var="apprMember">
										<input type="text"  name="memberList"  value="${apprMember.enrollID}">
									</c:forEach>
									<br>
									<input type="text"  name="apprType"  value="REFUND">
									
									
							</div>	
							<!-- /히든 영역 -->
						
						</td>
					</tr>
				</table>
			</div>
			<!-- /본문 -->
			
			<div class="edu_wz_btn_box">
				<button type="submit" class="btn btn-default btn-sm" >결재올리기</button>
			</div>
		</div>
		<!-- /col-12-->
		
			
				
		
	</form>
</div>


<div class="col-lg-2 well">
도움말들어갈자리

</div>




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
/*-------결재선 클릭시-----*/
$(".apprLine").on("click", function(event){
	var that = $(this);
	var apprlineid = that.data("apprlineid");
	
	$.ajax({
		url: "<c:url value='/edu/appr/selectApprLine.json' />",
		type: "post",
		data: "&apprlineid=" + apprlineid,
		dataType: "json",
		success: function(apprDetail){
			$("#appr_draftName").html(apprDetail[0].draftnm +"<br>(" + apprDetail[0].draftid + ")" );
			$("#appr_fstName").html(apprDetail[0].fst +"<br>(" + apprDetail[0].fstapprid + ")" );
			$("#appr_sndName").html(apprDetail[0].snd +"<br>(" + apprDetail[0].sndapprid  + ")" );
			$("#appr_trdName").html(apprDetail[0].trd +"<br>(" + apprDetail[0].trdapprid + ")" );
			$("#appr_fthName").html(apprDetail[0].fth +"<br>(" + apprDetail[0].fthapprid + ")" );
		
			$(".draftID").val(apprDetail[0].draftid);
			$(".firstID").val(apprDetail[0].fstapprid);
			$(".secondID").val(apprDetail[0].sndapprid);
			$(".thirdID").val(apprDetail[0].trdapprid);
			$(".fourthID").val(apprDetail[0].fthapprid);
			
		}
	});
	
});


		
	
	
	

	

</script>


