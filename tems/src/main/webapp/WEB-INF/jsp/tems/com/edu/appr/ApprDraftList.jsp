<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%
	LoginUserVO nLoginVO = (LoginUserVO)session.getAttribute("loginUserVO");
%>

<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<link rel="stylesheet" href="<c:url value='/css/tems/edu/edu.css' />">




<!-- /row-->
<div class="row">





<!-- --------------------------------------------------------------------------------------------------- -->



<!-- /col-10-->

<div class="col-lg-10">
	<div class="dt-title pull-left">
		<i class="fa fa-th-large"></i> 
		<span><%=nLoginVO.getName()%>(<%=nLoginVO.getAdminid()%>) 님이 올린 결재문서</span>
	</div>


	<!-- /dt-toolbar-->
	<div class="dt-toolbar">
		<div class="col-sm-12 form-inline">
			<div>
				<select name="searchType" class="form-control input-sm">
					<option value=''>선택하세요</option>
			        <option value='t'>결재제목</option>
			        <option value='s'>진행상태</option>
		        </select>
				<input name="keyword"   class="form-control input-sm search_input">
				<button id="btn_serach" type="submit" class="btn btn-default btn-sm">
					<span class="ace-icon fa fa-search icon-on-right"></span>
					검색
				</button>
			</div>
			  
		</div>
	</div>
	<!-- /.dt-toolbar-->
	
	
	<div id="tbl_data" class="data_tbl">
		<table class="table table-bordered table-striped table-hover">
			<colgroup>
				<col width="5%" /><!-- 번호 -->
				<col width="8%" /><!-- 구분 -->
				<col  />		  <!-- 결재명 -->
				<col width="10%" /><!-- 기안자 -->
				<col width="15%" /><!-- 기안일 -->
				<col width="15%" /><!-- 진행상태 -->
			</colgroup>
			
			<thead>
				<tr>
					<th>번호</th>
					<th>구분</th>
					<th>결재명</th>
					<th>기안자</th>
					<th>기안일</th>
					<th>진행상태</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${apprList}" var="apprListVO">
				<tr>
					<td>${apprListVO.apprID}</td>
					<td>${apprListVO.apprTypeName}(${apprListVO.apprTypeID})</td>
					<td class="text-left" >
						<c:if test="${apprListVO.apprTypeID == 'REFUND'}">
				 			<a href="./apprDraftReadR.do?apprID=${apprListVO.apprID}&crtPage=${cri.crtPage}&rowCnt=${cri.rowCnt}&searchType=${cri.searchType}&keyword=${cri.keyword}">${apprListVO.apprName}</a>
						</c:if>
						<c:if test="${apprListVO.apprTypeID != 'REFUND'}">
				 			<a href="./apprDraftReadE.do?apprID=${apprListVO.apprID}&crtPage=${cri.crtPage}&rowCnt=${cri.rowCnt}&searchType=${cri.searchType}&keyword=${cri.keyword}">${apprListVO.apprName}</a>
						</c:if>
					</td>
					<td>${apprListVO.name}(${apprListVO.draftID})</td>
					<td>${apprListVO.draftDate}</td>
					<td>${apprListVO.apprStateName}(${apprListVO.apprStateID})</td>
				</tr>
				</c:forEach>	
			</tbody>
		</table>
	</div>
		
	<!-- 페이징 -->
	<div class="text-center">
								
		<ul class="pagination">
			
			<!-- 검색안했을때 -->
			<c:if test="${cri.searchType == null&&cri.keyword == null }">
				
				<c:if test="${pageMaker.prev }">
					<li class="previous">
					<a href="apprDraftList.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }">Prev</a>
					</li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<li <c:out value="${cri.crtPage==idx? 'class=active' : '' }" /> >
					<a href="apprDraftList.do?crtPage=${idx }&rowCnt=${cri.rowCnt }">${idx }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="next"">
					<a href="apprDraftList.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }">Next</a>
					</li>
				</c:if>
			
			</c:if>
			
			<!-- 검색했을때 : 검색관련 속성 붙음 -->
			<c:if test="${cri.searchType != null&&cri.keyword != null }">
				
				<c:if test="${pageMaker.prev }">
					<li class="previous">
					<a href="apprDraftList.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">Prev</a>
					</li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<li <c:out value="${cri.crtPage==idx? 'class=active' : '' }" /> >
					<a href="apprDraftList.do?crtPage=${idx }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">${idx }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="next">
					<a href="apprDraftList.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }">Next</a>
					</li>
				</c:if>
			
			</c:if>
			
		</ul>

	</div>
	<!-- /.페이징 -->	
		
			
</div>
<!-- /.col-10-->


<!-- /col-2-->
<div class="col-lg-2 well">

				
	
			
</div>
<!-- /.col-2-->




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
$("#btn_serach").on("click", function(event){

	var crtPage = ${cri.crtPage} ;
	var rowCnt = ${cri.rowCnt} ;
	var searchType = $("select[name=searchType]").val() ;
	var keyword = $("input[name=keyword]").val() ;
	
	
	var url = "apprDraftList.do?crtPage="+crtPage+"&rowCnt="+rowCnt+"&searchType="+searchType+"&keyword="+keyword ;
	
	window.location.href = url;
	
	
});


</script>
