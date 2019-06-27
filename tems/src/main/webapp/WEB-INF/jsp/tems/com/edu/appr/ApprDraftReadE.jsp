<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<link rel="stylesheet" href="<c:url value='/css/tems/edu/edu.css' />">



<!-- /row-->
<div class="row">
<!-- --------------------------------------------------------------------------------------------------- -->



<div class="col-lg-10">
	<form id="appPaperForm" action="apprInsert.do" method="post">
	
		<!-- col-12-->
		<div class="col-lg-7 apprLine">
		
			<!-- 타이틀 -->
			<div class="dt-title pull-left">
				<i class="fa fa-th-large"></i> 
				<span>결재선</span>
			</div>
			<!-- /타이틀 -->
			
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
						<td id="appr_draftName">${apprVO.draftID }<br>${apprVO.name }</td>
						<td id="appr_fstName">${apprManagerList[0].name }<br>${apprManagerList[0].adminID }</td>
						<td id="appr_sndName">${apprManagerList[1].name }<br>${apprManagerList[1].adminID }</td>
						<td id="appr_trdName">${apprManagerList[2].name }<br>${apprManagerList[2].adminID }</td>
						<td id="appr_fthName">${apprManagerList[3].name }<br>${apprManagerList[3].adminID }</td>
					</tr>
					<tr>
						<th>결재일</th>
						<td>${apprVO.draftDate }</td>
						<td>${apprManagerList[0].apprDate }</td>
						<td>${apprManagerList[1].apprDate }</td>
						<td>${apprManagerList[2].apprDate }</td>
						<td>${apprManagerList[3].apprDate }</td>
					</tr>
					
				</table>
			</div>
			<!-- /결재라인 테이블 -->
		</div>
		<!-- /결재선 왼쪽-->	
		
		<!-- /최상단 오른쪽-->
		<div class="col-lg-5">
		
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
							<div class="apprName">${apprVO.apprName }</div>
							<!-- /제목 -->
						</td>
					</tr>
					<tr>

						<td>
							<!-- 내용 -->
							<div class="apprContent" >${apprVO.apprContent }</div>
							<div class="are">-아래-</div>
							<!-- /내용 -->



							
							<!-- 교육훈련정보 요약 테이블 -->	
							<div id="tbl_view" class="view_tbl apprTable">
								<table class="table table-bordered ">
									<tr>
										<th >교육훈련명</th>
										<td colspan="3">${courseVO.cosName }</td>
									</tr>
									<tr>
										<th>수강료</th>
										<td>${courseVO.cosPrice }원</td>
										<th>장소</th>
										<td>${courseVO.cosPlace }</td>
									</tr>
									<tr>
										<th>접수기간</th>
										<td>${courseVO.enrollStartDate }~${courseVO.enrollEndDate }</td>
										<th>훈련기간</th>
										<td>${courseVO.cosStartDate }~${courseVO.cosEndDate }</td>
									</tr>
								</table>
							</div>
							<!-- /교육훈련정보 요약 테이블 -->
						
						
							
							
							<!-- 데이타 테이블 리스트-->
							<div class="data_list view_tbl apprList">
								<div class="dt-title pull-right">
									<span>총인원: ${fn:length(apprMemberList)} 명</span>
								</div>
								
								<table class="table table-bordered table-striped">
									<%-- <colgroup>
										<col width="2%" /> <!-- 체크박스 -->
										<col width="3%" /> <!-- 번호 -->
										<col width="5%" /> <!-- 이름 -->
										<col  />           <!-- 핸드폰 -->
										<col  />           <!-- 이메일 -->
										<col width="8%" /> <!-- 접수상태 -->
										<col width="5%" /> <!-- 접수증 -->
										<col width="5%" /> <!-- 견적서 -->
										<col width="5%" /> <!-- 결제방법 -->
										<col width="5%" /> <!-- 결제시기 -->
										<col width="8%" /> <!-- 결제상태 -->
										<col width="5%" /> <!-- 계산서종류 -->
										<col width="5%" /> <!-- 계산서발급 -->
										<col width="5%" /> <!-- 접수증발행 -->
										<col width="5%" /> <!-- 평가결과 -->
										<col width="5%" /> <!-- 평가점수 -->
										<col width="5%" /> <!-- 수료증발급 -->
									</colgroup> --%>
									<thead>
										<tr>
											<th>번호</th>
											<th>이름</th>
											<th>핸드폰</th>
											<th>이메일</th>
											<th>접수상태</th>
											<th>결제상태</td>
											<th>평가결과</th>
											<th>평가점수</th>
											<th>수료증발급대상</td>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${apprMemberList}" var="apprMember">
										<tr>
											<td>${apprMember.enrollID}</td>
											<td><a href="./enrollInfo.do?cosID=${courseVO.cosID}&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }&enrollID=${apprMember.enrollID}" >${apprMember.memName}</a></td>
											<td>${apprMember.hp}</td>
											<td>${apprMember.email}</td>
											<td>${apprMember.enrollStateName }(${apprMember.enrollStateID })</td>
											<td>${apprMember.payStateName}(${apprMember.payStateID})</td>
											<td>${apprMember.passName}(${apprMember.passID})</td>
											<td>${apprMember.score}</td>
											<td>${apprMember.certificateIssue}</td>
										</tr>
										</c:forEach>	
									</tbody>
						
								</table>
								
							</div>
							<!-- /데이타 테이블 리스트-->
						
						
						
						</td>
					</tr>
				</table>
			</div>
			<!-- /본문 -->
		</div>
		<!-- / col-12-->
		
		<!-- col-12-->
		<div class="col-lg-12">
			<div class="edu_wz_btn_box">
				<button id="btn_list" type="button" class="btn btn-default btn-sm" >목록</button>
			</div>
		</div>
		<!-- / col-12-->
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

$("#btn_list").on("click", function(event){

	var crtPage = ${cri.crtPage} ;
	var rowCnt = ${cri.rowCnt} ;
	var searchType = '${cri.searchType}' ;
	var keyword = '${cri.keyword}' ;
	
	var url = "apprDraftList.do?crtPage="+crtPage+"&rowCnt="+rowCnt+"&searchType="+searchType+"&keyword="+keyword ;
	
	window.location.href = url ;
	
	
});

	

</script>


