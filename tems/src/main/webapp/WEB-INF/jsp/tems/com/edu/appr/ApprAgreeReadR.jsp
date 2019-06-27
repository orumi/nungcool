<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%
	LoginUserVO nLoginVO = (LoginUserVO)session.getAttribute("loginUserVO");
%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<link rel="stylesheet" href="<c:url value='/css/tems/edu/edu.css' />">



<!-- /row-->
<div class="row">
<!-- --------------------------------------------------------------------------------------------------- -->



<div class="col-lg-10">
	<form id="appPaperForm" action="apprInsert.do" method="post">
	
		<!-- col-12-->
		<!-- /결재선 왼쪽-->
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
												<td>${apprMember.enrollStateName }(${apprMember.enrollStateID })</td>
												<td>${apprMember.payStateName}(${apprMember.payStateID})</td>
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
				<c:if test="${crtApprManagerVO.myApprState == 'H'}">
						<button id="btn_agreeOK" type="button" class="btn btn-default btn-sm" >결재하기</button>
						<button type="button" class="btn btn-default btn-sm pull-right" data-toggle="modal" data-target="#appRefundModal" >
							반려
						</button>
				</c:if>
				<c:if test="${crtApprManagerVO.myApprState != 'H'}">
						<button id="btn_list" type="button" class="btn btn-default btn-sm" >목록</button>
				</c:if>
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




	<!-- 반려사유 팝업 -->
	<div id="appRefundModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	         	<h4 class="modal-title"><i class="fa fa-th-large"></i>&nbsp;&nbsp;&nbsp;<span>반려사유</span></h4>
	      	</div>
	      
	      	<!-- Modal body -->
			<div class="modal-body">
	        
					
				<!-- 반려사유작성 -->
				<div id="courseinfo" role="content" class="clear-both sub-content edu_wz">
					<div class="form-horizontal form-terms ui-sortable">
						<!-- body -->   	
						
							<fieldset>
								<div class="widget-body">
									<textarea id="rejectMemo" class="" rows="5" name="rejectMemo" ></textarea>						
								</div>
							</fieldset>
							<div class="edu_wz_btn_box">
								<input id="btn_reject" type="button" class="btn btn-default btn-sm" value="반려">
							</div>
						
						<!-- /body -->  
						
					</div>
				</div>
				<!-- /.반려사유작성 -->
					
	        
	      	</div>
	      	<!-- /Modal body -->
	      
		  
	    </div>
	    <!-- /Modal content-->		    
	  </div>
	</div>
	<!-- /반려사유 팝업 -->





<script>

/*-------결재버튼 클릭시-----*/
$("#btn_agreeOK").on("click", function() { 
	var apprID = "${apprVO.apprID}" ;
	var adminID = "<%=nLoginVO.getAdminid()%>" ;
		
	var crtPage = ${cri.crtPage} ;
	var rowCnt = ${cri.rowCnt} ;
	var searchType = '${cri.searchType}' ;
	var keyword = '${cri.keyword}' ;
	
	var url = "apprAgreeReadR.do?apprID="+apprID+"&crtPage="+crtPage+"&rowCnt="+rowCnt+"&searchType="+searchType+"&keyword="+keyword ;
	
	$.ajax({
		url: "<c:url value='/edu/appr/updateAgreeOK.json' />",
		type: "post",
		data: {"apprID": apprID, "adminID": adminID },
		
		success: function(event){		
			
			window.location.href = url ;	
			
		}
	});

});



/*-------리스트버튼 클릭시-----*/
$("#btn_list").on("click", function() { 
		
	var crtPage = ${cri.crtPage} ;
	var rowCnt = ${cri.rowCnt} ;
	var searchType = '${cri.searchType}' ;
	var keyword = '${cri.keyword}' ;
	
	var url = "apprAgreeList.do?crtPage="+crtPage+"&rowCnt="+rowCnt+"&searchType="+searchType+"&keyword="+keyword ;

	window.location.href = url ;	

});




/*-------반려버튼 클릭시-----*/
$("#btn_reject").on("click", function() { 
	
	var crtPage = ${cri.crtPage} ;
	var rowCnt = ${cri.rowCnt} ;
	var memo = $("#rejectMemo").val();
	var adminID = '<%=nLoginVO.getAdminid()%>';
	var apprID = ${apprVO.apprID};  
	
	var apprManagerVO = {
			"memo" : memo, 
			"adminID" : adminID, 
			"apprID" : apprID
	};
	
	$.ajax({
		url: "<c:url value='/edu/appr/updateReject.json' />",
		type: "post",
		data: JSON.stringify(apprManagerVO),
		contentType: "application/json",
		success: function(event){	
			location.href = "./apprAgreeReadR.do?&apprID="+apprID+"&crtPage"+${cri.crtPage }+"&rowCnt="+${cri.rowCnt };
		}
	});
	

});

</script>

