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

<!-- row-->
<div class="row">
<!-- --------------------------------------------------------------------------------------------------- -->
<!-- --------------------------------------------------------------------------------------------------- -->


<!-- /메인박스 -->
<div class="col-lg-10">
	<div class="col-lg-12 data_tbl">
		<!-- /데이타 테이블 제목-->
		<div class="dt_title pull-left">
			<i class="fa fa-th-large"></i>&nbsp;&nbsp;&nbsp;<span>결제리스트</span>
		</div>
		<!-- /.데이타 테이블 제목-->

		<!-- 데이타 테이블 상단 툴바-->
		<div class="dt-toolbar">
			<div class="col-sm-4 form-inline">
				<select name="searchType" class="form-control input-sm">
						<option value=''>선택하세요</option>
						<option value='pst'>결제상태</option>
						<option value='pty'>결제방법</option>
				</select> 
				<input name="keyword" class="form-control input-sm ">
				<button id="btn_search" type="button" class="btn btn-default btn-sm">
					<span class="ace-icon fa fa-search icon-on-right"></span> 
					검색
				</button>
			</div>

			<div class="col-sm-8">
				<div class="pull-right btn-group toolbar_group">	
					<button id="btn_appr" type="button" class="btn btn-default btn-sm ">
						환불승인요청
					</button>
				</div>
				<div class="pull-right btn-group toolbar_group">	
					<button type="button" class="btn btn-default btn-sm">
						계산서발급
					</button>
				</div>
				<div class="pull-right form-inline">
						<span>선택한 훈련생 결제상태를</span>
						<select id="select_payState" name="payState" class="form-control input-sm">
							<option value="">선택하세요</option>
						    <c:forEach items="${payStateCodeList}" var="payStateCode">
						    	<option value="${payStateCode.codeID }">${payStateCode.codeName }</option>
						    </c:forEach>
				       	</select>
				       	<span>로</span>
						<button type="button" id="btn_payState" class="btn btn-default btn-sm btn_payState">변경</button>
				</div>	
			</div>



		</div>
		<!-- /데이타 테이블 상단 툴바-->
		
		<!-- 데이타 테이블 리스트-->	
		<div class="data_list">
			<form id="form_refundMember">
				<table class="table table-bordered table-striped table-hover">
					<colgroup>
						<col width="2%" />  <!-- 체크박스 -->
						<col width="3%" />  <!-- 번호 -->
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
						<col width="5%" />	<!-- 계산서발급 -->
					</colgroup>
	
					<thead>
						<tr>
							<th rowspan="2"><label><input id="allCheck" type="checkbox" class="checkbox"><span></span></label></th>
							<th rowspan="2">번호</th>
							<th rowspan="2">교육훈련명</th>
							<th rowspan="2">교육비</th>
							<th colspan="4">접수정보</th>
							<th colspan="3">결제정보</th>
							<th colspan="2">계산서</th>
						</tr>
						<tr>
							<th>이름</th>
							<th>핸드폰</th>
							<th>이메일</th>
							<th>상태</th>
							<th>방법
							</td>
							<th>시기
							</td>
							<th>상태
							</td>
							<th>종류
							</td>
							<th>발급
							</td>
						</tr>
	
					</thead>
					<tbody>
						<c:forEach items="${payMemberList }" var="payMemberList">
							<tr>
								<td><label><input type="checkbox" class="checkbox" name="chkedList" value="${payMemberList.enrollID }"><span></span></label></td>
								<td>${payMemberList.enrollID }</td>
								<td class="text-left">${payMemberList.cosName }/${payMemberList.enrollCmplDate }</td>
								<td class="text-right">${payMemberList.cosPrice }원</td>
								<td>${payMemberList.memName }</td>
								<td>${payMemberList.hp }</td>
								<td>${payMemberList.email }</td>
								<td>${payMemberList.enrollStateName }(${payMemberList.enrollStateID })</td>
								<td>${payMemberList.payTypeName}(${payMemberList.payTypeID})</td>
								<td>${payMemberList.payTimeName}(${payMemberList.payTimeID})</td>
								<td>${payMemberList.payStateName}(${payMemberList.payStateID})</td>
								<td>${payMemberList.taxTypeName}(${payMemberList.taxTypeID})</td>
								<td>${payMemberList.taxBillCnt}</td>
							</tr>
						</c:forEach>
					</tbody>
	
				</table>
				
				
			
			
				
			</form>
		</div>
		<!-- /데이타 테이블 리스트-->	
		
		<!-- 페이징 -->
		<div class="paging text-center">
			<ul class="pagination pagination-sm">
				<!-- 검색안했을때 -->
				<c:if test="${cri.searchType == null&&cri.keyword == null }">
					
					<c:if test="${pageMaker.prev }">
						<li class="previous">
							<a href="payList.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }">Prev</a>
						</li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
						<li <c:out value="${cri.crtPage==idx? 'class=active' : '' }" /> >
							<a href="payList.do?crtPage=${idx }&rowCnt=${cri.rowCnt }">${idx }</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next }">
						<li class="next"">
							<a href="payList.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }">Next</a>
						</li>
					</c:if>
					
				</c:if>
				
				<!-- 검색했을때 : 검색관련 속성 붙음 -->
				<c:if test="${cri.searchType != null&&cri.keyword != null }">
					
					<c:if test="${pageMaker.prev }">
						<li class="previous">
						<a href="payList.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">Prev</a>
						</li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
						<li <c:out value="${cri.crtPage==idx? 'class=active' : '' }" /> >
						<a href="payList.do?crtPage=${idx }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">${idx }</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next }">
						<li class="next">
						<a href="payList.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">Next</a>
						</li>
					</c:if>
				
				</c:if>
			</ul>
		</div>
		<!-- /.페이징 -->
		
		</div>		
	
</div>
<!-- /.메인박스 -->




<!-- /도움말박스 -->
<div id="edu_help" class="col-lg-2 well">

</div>
<!-- /.도움말박스 -->




<!-- --------------------------------------------------------------------------------------------------- -->
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
//검색하기
$("#btn_search").on("click", function(event){
	var searchType = $("select[name=searchType]").val();
	var keyword = $("input[name=keyword]").val();
	var url =  "/tems/edu/pay/payList.do?searchType="+ searchType + "&keyword=" + keyword;
	
	window.location.href = url;
});


/*-------전체 선택+해제------*/
$("#allCheck").on("click", function(event){

	if($("#allCheck").prop("checked")) {
		//해당화면에 전체 checkbox들을 체크해준다
		$("input[name=chkedList]").prop("checked",true);
	// 전체선택 체크박스가 해제된 경우
	} else {
		//해당화면에 모든 checkbox들의 체크를해제시킨다.
		$("input[name=chkedList]").prop("checked",false);
	}
	
});


//교육훈련 상태 일괄변경
$("#btn_payState").on("click", function(event){
	
	var codeID = $("#select_payState").val();
	var codeName =  $("#select_payState option:selected").text();
	
	var chkedList = [] ;
	$("input[name=chkedList]:checked").each(function() {
		chkedList.push($(this).val());
    });
	
	var adminID = "<%=nLoginVO.getAdminid()%>" ;
	
	var allChangeCodeVO = {
			"codeID" : codeID, 
			"codeName" : codeName, 
			"chkedList" : chkedList,
			"adminID" : adminID
	};
	
	$.ajax({
		type: "post",
		url: "<c:url value= '/edu/pay/updatePayStateAll.json' />", 
		data : JSON.stringify(allChangeCodeVO),
		contentType: "application/json",
		success:function(data){
			location.href = "./payList.do?&crtPage=" + ${cri.crtPage } + "&rowCnt=" + ${cri.rowCnt }  ;
		}
	});
	console.log(allChangeCodeVO);

});



/*-------내부결재 클릭시(환불)------*/
$("#btn_appr").on("click", function(event){
		
	$("#form_refundMember").attr("action", "/tems/edu/appr/apprWriteR.do" );
	$("#form_refundMember").attr("method", "POST" );
	$("#form_refundMember").submit();  
	
	
})




</script>