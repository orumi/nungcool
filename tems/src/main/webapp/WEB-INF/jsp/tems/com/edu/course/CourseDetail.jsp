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


	<!-- /상단 왼쪽 박스 -->
	<div class="col-lg-8 leftbox">
	
		<!-- /교육훈련등록 -->
		<div id="courseinfo" role="content" class="clear-both sub-content edu_wz">
			<div class="form-horizontal form-terms ui-sortable">
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>교육훈련등록</h2>
					</header>
			
					<!-- body -->    	
					<div class="widget-body">
						
						<form id="courseForm" action="./courseUpdate.do" method="post">			
							<fieldset>
							<div class="col-md-12 form-group ">
								<label class="col-md-3 form-label">교육훈련명</label>
								<div class="col-md-9 form_box">
									<input type="text" name="cosName" class="form-control input_400" value="${courseVO.cosName }">
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label">교육비</label>
								<div class="col-md-9 form-inline form_box">
									<input type="text" name="cosPrice" class="form-control w100" value="${courseVO.cosPrice }">원
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label">교육장소</label>
								<div class="col-md-9 form_box">
									<input type="text" name="cosPlace" class="form-control input_400" value="${courseVO.cosPlace }">
								</div>
							</div>
							</fieldset>	
				
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label">접수일시</label>
								<div class="col-md-9 form-inline form_box">
									<input type="text" name="enrollStartDate" class="form-control w100" value="${courseVO.enrollStartDate }">
									<select name="enrollStartHour" class="form-control w70">
										<option value="">시간</option>
										<c:forEach begin="1" end="24" step="1" var="hour" >
											<option value="${hour }" <c:if test="${hour == courseVO.enrollStartHour }"> selected="selected"</c:if>>${hour } 시</option>
										</c:forEach>
									</select>&nbsp;&nbsp;~&nbsp;&nbsp;
									<input type="text" name="enrollEndDate" class="form-control w100" value="${courseVO.enrollEndDate }" >
									<select name="enrollEndHour" class="form-control w70" >
										<option value="">시간</option>
										<c:forEach begin="1" end="24" step="1" var="hour" >
											<option value="${hour }" <c:if test="${hour == courseVO.enrollEndHour }"> selected="selected"</c:if>>${hour } 시</option>
										</c:forEach>
									</select>
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label">훈련일시</label>
								<div class="col-md-9  form-inline form_box">
									<input type="text" name="cosStartDate" class="form-control w100" value="${courseVO.cosStartDate }" >
									&nbsp;&nbsp;~&nbsp;&nbsp;
									<input type="text" name="cosEndDate" class="form-control w100" value="${courseVO.cosEndDate }" >
									
								</div>
							</div>
							</fieldset>
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label ">훈련상태</label>
								<div class="col-md-9 ">
								    <c:forEach items="${courseStateCodeList }" var="courseStateCode">
								    	<label class="radio radio-inline form_box">
											<input type="radio" class="radiobox" name="cosState" value="${courseStateCode.codeID }"  <c:if test="${courseStateCode.codeID == courseVO.cosState }"> checked="checked"</c:if>>
											<span>${courseStateCode.codeName }(${courseStateCode.codeID })</span> 
										</label>
								    </c:forEach>
								</div>
							</div>
							</fieldset>	
							cosID:<input type="text" name="cosID" value="${courseVO.cosID }"><br>
							subjectID:<input type="text" name="subjectID" value="${courseVO.subjectID }"><br>
							modifyID:<input type="text" name="modifyID" value="<%=nLoginVO.getAdminid()%>">
								
							<div class="edu_wz_btn_box">
								<input type="submit" class="btn btn-default btn-sm" value="교육훈련등록">
							</div>
						</form>
						
					</div>
				</div>
			</div>
				<!--  end of content -->			
		</div>
		<!-- /.교육훈련등록 -->

	</div>
	<!-- /.상단 왼쪽 박스 -->
	

	
	<!-- /상단 오른쪽 박스 -->
	<div class="col-lg-4 rightbox">
		
		<!-- /내부결재 -->
		<!-- /교육훈련등록 -->
		<div  id="apprstate" role="content" class="clear-both sub-content edu_wz">
			
							
			<div class="form-horizontal form-terms ui-sortable mb_0">
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>내부결재</h2>
					</header>

					<!-- body -->    	
					<div class="widget-body table-responsive">
						<table class="table table-hover table-unborder">
							<colgroup>
								<col  /> <!-- 결재제목 -->
								<col width="25%" /> <!-- 날짜 -->
								<col width="15%" /> <!-- 상태 -->
							</colgroup>
						
							<tbody>
								<tr>
									<td>SO 18436-4 트라이볼로지 영</td>
									<td class="text-right">2016-03-17</td>
									<td class="text-right">진행중</td>
								</tr>				
								<tr>
									<td>SO 18436-4 트라이볼로지 영</td>
									<td class="text-right">2016-03-17</td>
									<td class="text-right">진행중</td>
								</tr>				
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
		<!-- /내부결재 -->
		
		
		<!-- /첨부파일 -->
		<div id="coursefile" role="content" class="clear-both sub-content">
	
			<!--  start of  form-horizontal tems_search  -->
			<!--  start of widget-body -->
			<div class="form-horizontal form-terms ui-sortable"> 
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<header role="heading">
						<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
						<h2>첨부파일</h2>
					</header>

					<!-- body -->    	
					<div class="widget-body">
						<table class="table table-hover table-unborder">
							<colgroup>
								<col  /> <!-- 파일이름 -->
								<col width="25%" /> <!-- 용량 -->
								<col width="8%" /> <!-- 삭제 -->
							</colgroup>
							<tbody>
								<tr>
									<td>출석부.jpg</td>
									<td class="text-right">25.3M</td>
									<td class="text-right"><i class="fa fa-times text-danger"></i></td>
								</tr>				
								<tr>
									<td>설문지.zip</td>
									<td class="text-right">25.3M</td>
									<td class="text-right"><i class="fa fa-times text-danger"></i></td>
								</tr>
								<tr>
									<td>시험지.zip</td>
									<td class="text-right">25.3M</td>
									<td class="text-right"><i class="fa fa-times text-danger"></i></td>
								</tr>				
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
		<!-- /.첨부파일 -->		
		
	</div>
	<!-- /상단 오른쪽 박스 -->	
	
	<!-- 하단 데이타 테이블 오른쪽 박스 -->	
	<div id="memberlist" class="col-lg-12 data_tbl">
	
		<!-- /데이타 테이블 제목-->
		<div class="dt_title pull-left">
			<i class="fa fa-th-large"></i>&nbsp;&nbsp;&nbsp;<span>훈련생리스트</span>
		</div>
		<!-- /.데이타 테이블 제목-->
		
		<!-- 데이타 테이블 상단 툴바-->
		<div class="dt-toolbar">
			
			<div class="col-sm-4 form-inline">
				<select name="searchType" class="form-control input-sm">
					<option value=''>선택하세요</option>
			        <option value='ens'>접수상태</option>
			        <option value='pas'>결제상태</option>
		        </select>
				<input name="keyword"   class="form-control input-sm">
				<button id="btn_search" type="button" class="btn btn-default btn-sm">
					<span class="ace-icon fa fa-search icon-on-right"></span>
					검색
				</button>
			</div>
			
			<div class="col-sm-8">
				<div class="pull-right toolbar_group">	
					<button id="btn_appr" class="btn btn-default btn-sm" >내부결재</button>
				</div>
				<div class="pull-right form-inline">

						<span>선택한 훈련생의 접수상태를</span>
						<select id="select_enrollState" name="enrollstate" class="form-control input-sm">
							<option value=''>선택하세요</option>
							<c:forEach items="${enrollStateCodeList}" var="enrollStateCode">
								<option value='${enrollStateCode.codeID}'>${enrollStateCode.codeName}</option>
							</c:forEach>
				       	</select>
				       	<span>로</span>
						<button id="btn_enrollState" class="btn btn-default btn-sm btn_courseState" >변경</button>
				</div>	
			
			</div>
				
		</div>
		<!-- /데이타 테이블 상단 툴바-->
		
		<!-- 데이타 테이블 리스트-->
		<div class="data_list">
			<form id="form_apprMember">
				<table class="table table-bordered table-striped table-hover">
					<colgroup>
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
					</colgroup>
					<thead>
						<tr>
							<th rowspan="2">
								<label><input id="allCheck" type="checkbox" class="checkbox"><span ></span></label>
							</th>
							<th rowspan="2">번호</th>
							<th colspan="5">접수정보</th>
							<th rowspan="2">견적서</th>
							<th colspan="3">결제정보</th>
							<th colspan="2">계산서</th>
							<th rowspan="2">접수증<br>발급</th>
							<th colspan="2">평가</th>
							<th rowspan="2">수료증<br>발급</th>
						</tr>
						<tr>
							<th>이름</th>
							<th>핸드폰</th>
							<th>이메일</th>
							<th>상태</th>
							<th>접수서류</th>
							<th>방법</td>
							<th>시기</td>
							<th>상태</td>
							<th>종류</td>
							<th>발급</td>
							<th>결과</th>
							<th>점수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${enrollLMember}" var="enrollLMember">
						<tr>
							<td>
								<label><input type="checkbox" class="checkbox" name="chkedList" value="${enrollLMember.enrollID}"><span ></span></label>
							</td>
							<td>${enrollLMember.enrollID}</td>
							<td><a href="./enrollInfo.do?cosID=${courseVO.cosID}&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }&enrollID=${enrollLMember.enrollID}" >${enrollLMember.memName}</a></td>
							<td>${enrollLMember.hp}</td>
							<td>${enrollLMember.email}</td>
							<td>${enrollLMember.enrollStateName}(${enrollLMember.enrollStateID})</td>
							<td>보기</td>
							<td>${enrollLMember.estimateCnt}</td>
							<td>${enrollLMember.payTypeName}(${enrollLMember.payTypeID})</td>
							<td>${enrollLMember.payTimeName}(${enrollLMember.payTimeID})</td>
							<td>${enrollLMember.payStateName}(${enrollLMember.payStateID})</td>
							<td>${enrollLMember.taxTypeName}(${enrollLMember.taxTypeID})</td>
							<td>${enrollLMember.taxbillCnt}</td>
							<td>${enrollLMember.receiptCnt}</td>
							<td>${enrollLMember.passName}(${enrollLMember.passID})</td>
							<td>${enrollLMember.score}</td>
							<td>${enrollLMember.certificateCnt}</td>
						</tr>
						</c:forEach>	
					</tbody>
		
				</table>
				
				<input type="text" name="cosID" value=" ${courseVO.cosID }">
			
			</form>	
		</div>
		<!-- /데이타 테이블 리스트-->
		
		
	
	
	</div>
	<!-- /데이타 테이블 리스트-->
	
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
	
	var cosID= ${courseVO.cosID} ;
	var crtPage = ${cri.crtPage } ;
	var rowCnt = ${cri.rowCnt } ;
	var searchType = $("select[name=searchType]").val();
	var keyword = $("input[name=keyword]").val();
	var url =  "/tems/edu/course/courseDetail.do?cosID="+cosID+"&crtPage="+crtPage+"&rowCnt="+rowCnt+"&searchType="+ searchType + "&keyword=" + keyword;
	
	window.location.href = url ;
	
});



/*-------enrollMember 전체 선택+해제------*/
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



/*-------내부결재 클릭시------*/
$("#btn_appr").on("click", function(event){
		
	$("#form_apprMember").attr("action", "/tems/edu/appr/apprWriteE.do" );
	$("#form_apprMember").attr("method", "POST" );
	$("#form_apprMember").submit();  
	
	
})




//교육훈련생 접수상태 일괄변경
$("#btn_enrollState").on("click", function(event){
	
	var codeID = $("#select_enrollState").val();
	var codeName =  $("#select_enrollState option:selected").text();
	
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
	
	console.log(allChangeCodeVO);
	
	
	$.ajax({
		type: "post",
		url: "<c:url value= '/edu/course/updateEnrollStateAll.json' />", 
		data : JSON.stringify(allChangeCodeVO),
		contentType: "application/json",
		success:function(data){
			var cosID= ${courseVO.cosID} ;
			var crtPage = ${cri.crtPage } ;
			var rowCnt = ${cri.rowCnt } ;
			var searchType = $("select[name=searchType]").val();
			var keyword = $("input[name=keyword]").val();
			var url =  "/tems/edu/course/courseDetail.do?cosID="+cosID+"&crtPage="+crtPage+"&rowCnt="+rowCnt+"&searchType="+ searchType + "&keyword=" + keyword;

			window.location.href = url ;
		}
	});
	console.log(allChangeCodeVO);
 
});


</script>



