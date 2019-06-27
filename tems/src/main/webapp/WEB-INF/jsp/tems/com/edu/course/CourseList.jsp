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


<!-- 메인박스 -->
<div id="edu_content" class="col-lg-10">
	
		<div class="col-lg-12 data_tbl">
			<!-- /데이타 테이블 제목-->
			<div class="dt_title pull-left">
				<i class="fa fa-th-large"></i>&nbsp;&nbsp;&nbsp;<span>교육훈련리스트</span>
			</div>
			<!-- /.데이타 테이블 제목-->
		
			<!-- 데이타 테이블 상단 툴바-->
			<div class="dt-toolbar">
			
				<div class="col-sm-6 form-inline">
					<select name="searchType" class="form-control input-sm ">
						<option value="">선택하세요</option>
				        <option value="s">상태</option>
				        <option value="n">교육훈련명</option>
			        </select>
					<input name="keyword"   class="form-control input-sm">
					<button id="btn_search" type="button" class="btn btn-default btn-sm">
						<span class="ace-icon fa fa-search icon-on-right"></span>
						검색
					</button>
				</div>
					
					
				
				<div class="col-sm-6">
					<div class="pull-right btn-group toolbar_group">	
						<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#courseEnrollModal" >
							교육훈련등록
						</button>
					</div>
					<div class="pull-right form-inline">
							<span>선택한 교육훈련 상태를</span>
							<select id="select_courseState" name="courseState" class="form-control input-sm">
								<option value="">선택하세요</option>
							    <c:forEach items="${courseStateCodeList}" var="courseStateCode">
							    	<option value="${courseStateCode.codeID }">${courseStateCode.codeName }</option>
							    </c:forEach>
					       	</select>
					       	<span>로</span>
							<button type="button" id="btn_courseState" class="btn btn-default btn-sm btn_courseState">변경</button>
					</div>	
				
				</div>
					
			</div>
			<!-- /데이타 테이블 상단 툴바-->		
			
			<!-- 데이타 테이블 리스트-->		
			<div class="data_list">
				<table class="table table-bordered table-striped table-hover">
					<colgroup>
						<col width="4%" />
						<col width="5%" />
						<col width="5%" />
						<col  />
						<col width="5%" />
						<col width="18%" />
						<col width="18%" />
						<col width="10%" />
						<col width="3%" />
					</colgroup>
					
					<thead>
						<tr>
							<th>
								<label><input id="allCheck" type="checkbox" class="checkbox"><span ></span></label>
							</th>
							<th>번호</th>
							<th>상태</th>
							<th>교육훈련명</th>
							<th>인원</th>
							<th>접수일시</th>
							<th>교육일시</th>
							<th>교육비</th>
							<th></th>
						</tr>
					</thead>
		
					<tbody>
						<c:forEach items="${courseList}" var="courseList">
							<tr>
								<td>
									<label><input type="checkbox" class="checkbox" name="chkedList" value="${courseList.cosID}"><span ></span></label>
								</td>
								<td>${courseList.cosID}</td>
								<td class="courseState ${courseList.cosID}">${courseList.codeName}(${courseList.codeID})</td>
								<td class="text-left" >
									<a href="./courseDetail.do?cosID=${courseList.cosID}&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }">${courseList.cosName}</a>
								</td>
								<td class="text-right">${courseList.memCnt}</td>
								<td >${courseList.enrollStartDate}~
									 ${courseList.enrollEndDate}
								</td>
								<td >${courseList.cosStartDate}~${courseList.cosEndDate}</td>
								<td class="text-right"><fmt:formatNumber value="${courseList.cosPrice}" pattern="#,###" />원</td>
								<td >
									<i class="fa fa-times text-danger btn_del hand" data-cosID="${courseList.cosID}"></i>
								</td>
							</tr>	
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<!-- /데이타 테이블 리스트-->
				
			<!-- 페이징 -->
			<div class="paging text-center">
				<ul class="pagination pagination-sm">
					<!-- 검색안했을때 -->
					<c:if test="${cri.searchType == null&&cri.keyword == null }">
						
						<c:if test="${pageMaker.prev }">
							<li class="previous">
								<a href="courseList.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }">Prev</a>
							</li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
							<li <c:out value="${cri.crtPage==idx? 'class=active' : '' }" /> >
								<a href="courseList.do?crtPage=${idx }&rowCnt=${cri.rowCnt }">${idx }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="next"">
								<a href="courseList.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }">Next</a>
							</li>
						</c:if>
						
					</c:if>
					
					<!-- 검색했을때 : 검색관련 속성 붙음 -->
					<c:if test="${cri.searchType != null&&cri.keyword != null }">
						
						<c:if test="${pageMaker.prev }">
							<li class="previous">
							<a href="courseList.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">Prev</a>
							</li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
							<li <c:out value="${cri.crtPage==idx? 'class=active' : '' }" /> >
							<a href="courseList.do?crtPage=${idx }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">${idx }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="next">
							<a href="courseList.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">Next</a>
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
<!-- 기타 영역 -->

	<!-- 교육훈련등록 팝업 -->
	<div id="courseEnrollModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	         	<h4 class="modal-title"><i class="fa fa-th-large"></i>&nbsp;&nbsp;&nbsp;<span>교육훈련등록</span></h4>
	      	</div>
	      
	      	<!-- Modal body -->
			<div class="modal-body">
	        
					
				<!-- 교육훈련등록 -->
				<div id="courseinfo" role="content" class="clear-both sub-content edu_wz">
					<div class="form-horizontal form-terms ui-sortable">
						<div class="jarviswidget jarviswidget-sortable" role="widget">	
							
							<!-- body -->   	
							<form id="courseForm" action="./courseInsert.do" method="post">
							<div class="widget-body">
								<fieldset>
								<div class="col-md-12 form-group ">
									<label class="col-md-3 form-label">교육훈련과정</label>
									<div class="col-md-9 form_box">
										<select name="subjectID" class="form-control w400">
											<option value="">선택하세요</option>
											<c:forEach items="${subjectList}" var="subjectList">
												<option value=${subjectList.subjectID }>${subjectList.subjectName }</option>
											</c:forEach>
										</select>
									</div>
								</div>
								</fieldset>
								
								<fieldset>
								<div class="col-md-12 form-group ">
									<label class="col-md-3 form-label">사용훈련명</label>
									<div class="col-md-9 form_box">
										<input type="text" name="cosName" class="form-control w400">
									</div>
								</div>
								</fieldset>		
								
								<fieldset>
								<div class="col-md-12 form-group">
									<label class="col-md-3 form-label">교육비</label>
									<div class="col-md-9 form-inline form_box">
										<input type="text" name="cosPrice" class="form-control w100">원
									</div>
								</div>
								</fieldset>	
								
								<fieldset>
								<div class="col-md-12 form-group">
									<label class="col-md-3 form-label">교육장소</label>
									<div class="col-md-9 form_box">
										<input type="text" name="cosPlace" class="form-control w100">
									</div>
								</div>
								</fieldset>	
								
								<fieldset>
								<div class="col-md-12 form-group">
									<label class="col-md-3 form-label">접수일시</label>
									<div class="col-md-9 form-inline form_box">
										<input type="text" name="enrollStartDate" class="form-control w100">
										<select name="enrollStartHour" class="form-control w70">
											<option value="">시간</option>
											<c:forEach begin="1" end="24" step="1" var="hour" >
												<option value=${hour }>${hour } 시</option>
											</c:forEach>
										</select>&nbsp;&nbsp;~&nbsp;&nbsp;
										<input type="text" name="enrollEndDate" class="form-control w100">
										<select name="enrollEndHour" class="form-control w70" >
											<option value="">시간</option>
											<c:forEach begin="1" end="24" step="1" var="hour" >
												<option value=${hour }>${hour } 시</option>
											</c:forEach>
										</select>
									</div>
								</div>
								</fieldset>	
								
								<fieldset>
								<div class="col-md-12 form-group">
									<label class="col-md-3 form-label">훈련일시</label>
										<div class="col-md-9 form-inline form_box">
										<input type="text" name="cosStartDate" class="form-control w100">
											&nbsp;&nbsp;~&nbsp;&nbsp;
										<input type="text" name="cosEndDate" class="form-control w100">
									</div>
								</div>
								</fieldset>
								
								<fieldset>
								<div class="col-md-12 form-group">
									<label class="col-md-3 form-label ">훈련상태</label>
									<div class="col-md-9 ">
										<label class="radio radio-inline form_box">
											<input type="radio" class="radiobox" name="cosState" value="1">
											<span>대기</span> 
										</label>
										<label class="radio radio-inline form_box">
											<input type="radio" class="radiobox" name="cosState" value="2">
											<span>접수중</span>  
										</label>
									</div>
								</div>
								</fieldset>	
								
								<input type="hidden" name="regID" value=<%=nLoginVO.getAdminid()%>>
								
								<div class="edu_wz_btn_box">
									<input type="submit" class="btn btn-default btn-sm" value="교육훈련등록">
								</div>
								
							</div>
							</form>
							<!-- /body -->  
						</div>
					</div>
				</div>
				<!-- /.교육훈련등록 -->
					
	        
	      	</div>
	      	<!-- /Modal body -->
	      
		  
	    </div>
	    <!-- /Modal content-->		    
	  </div>
	</div>
	<!-- /교육훈련등록 팝업 -->




<!-- /기타영역 -->



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
/*-------리스트 선택+해제------*/
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


//검색하기
$("#btn_search").on("click", function(event){
	var searchType = $("select[name=searchType]").val();
	var keyword = $("input[name=keyword]").val();
	var url =  "/tems/edu/course/courseList.do?searchType="+ searchType + "&keyword=" + keyword;
	
	window.location.href = url;
});



//교육훈련 상태 일괄변경
$("#btn_courseState").on("click", function(event){
	
	var codeID = $("#select_courseState").val();
	var codeName =  $("#select_courseState option:selected").text();
	
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
		url: "<c:url value= '/edu/course/updateCourseStateAll.json' />", 
		data : JSON.stringify(allChangeCodeVO),
		contentType: "application/json",
		success:function(data){
			location.href = "./courseList.do?&crtPage=" + ${cri.crtPage } + "&rowCnt=" + ${cri.rowCnt }  ;
		}
	});
	console.log(allChangeCodeVO);

});



//삭제 버튼 클릭시
$(".btn_del").on("click", function(event){
	
	var cosID = $(this).data("cosid");
	
	$.ajax({
		type: "post",
		url: "<c:url value= '/edu/course/listEnrollLMember.json' />", 
		data : {"cosID": cosID},
		dataType : 'text',
		success:function(cnt){
			if(cnt > '0'){
				alert("접수자가 있어 삭제할 수 없습니다.");
			}
			else {
				
				$.ajax({
					type: "post",
					url: "<c:url value= '/edu/course/deleteCourse.json' />", 
					data : {"cosID": cosID},
					success:function(data){
						location.href = "./courseList.do?&crtPage=" + ${cri.crtPage } + "&rowCnt=" + ${cri.rowCnt }  ;
					}
				});
			}
				
		}
	});
	

});


</script>
