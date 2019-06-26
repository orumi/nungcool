<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<link rel="stylesheet" href="<c:url value='/css/exam/bbs.css' />">




<!-- right_warp(오른쪽 내용) -->
<div class="right_warp">    
    <div class="title_route">
    		<div class="title_route">
				<h3>자주하는질문</h3>
				<p class="route">
				<img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> 
				<img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 커뮤니티 
				<img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>자주하는질문</span></p>
			</div>
    </div>
    


	<!-- 신청내역정보 -->
	<h4 class="title01">자주하는질문</h4>
	<!-- table_bg -->
	<div class="table_bg">
	    <table summary="신청내역정보" class="table_h">
	        <colgroup>
	            <col width="5%"/> <!-- 번호 -->
	            <col />           <!-- 질문 --> 
	            <col width="10%"/><!-- 작성자 -->
	            <col width="20%"/><!-- 작성일 -->
	            <col width="8%"/> <!-- 조회수 -->
	        </colgroup>
	        <tr>
	            <th>번호</th>
	            <th>질문</th>
	            <th>작성자</th>
	            <th>작성일</th>
	            <th class="b_R_none">조회수</th>
	        </tr>
	        <tbody>
				<c:forEach items="${boardList}" var="boardList">
					<tr>
						<td class="txt_C">${boardList.bID }</td>
						<td >
							<c:if test="${boardList.depth>0 }">
								<c:forEach begin="1" end="${boardList.depth }" step="1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:forEach>
								┗
							</c:if>
							<a href="read.do?bID=${boardList.bID }&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }">${boardList.title }</a>
						</td>
						<td class="txt_C">${boardList.writer }</td>
						<td class="txt_C">${boardList.regDate }</td>
						<td class="txt_C b_R_none"">${boardList.cnt }</td>
					</tr>
				</c:forEach>
	        </tbody>
	    </table>
	</div>
	<!-- //신청내역정보 -->
	
	   	
	 	
	<!-- 페이지리스트 -->
	<p class="pagelist m_T14">
	
		<!-- 검색안했을때 -->
		<c:if test="${cri.searchType == null&&cri.keyword == null }">
		
		       <c:if test="${pageMaker.prev }">
		       	<a href="list.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }" class="btn_pr02"><img src="<c:url value='/images/exam/btn/btn_pr02.gif'/>" alt="이전"/></a>
		       </c:if>
		       
		       <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				<c:if test="${cri.crtPage==idx}">
					<strong><a href="list.do?crtPage=${idx }&rowCnt=${cri.rowCnt }">${idx }</a></strong>
				</c:if>
				<c:if test="${cri.crtPage!=idx}">
					<a href="list.do?crtPage=${idx }&rowCnt=${cri.rowCnt }">${idx }</a>
				</c:if>
			</c:forEach>
			
		       <c:if test="${pageMaker.next }">
		       	<a href="list.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }"><img src="<c:url value='/images/exam/btn/btn_nex01.gif'/>" alt="다음"/></a>
			</c:if>
			
		</c:if>
		
		<!-- 검색했을때 : 검색관련 속성 붙음 -->
		<c:if test="${cri.searchType != null&&cri.keyword != null }">
		
			<c:if test="${pageMaker.prev }">
				<a href="list.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }" class="btn_pr02"><img src="<c:url value='/images/exam/btn/btn_pr02.gif'/>" alt="이전"/></a>
			</c:if>
		       
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				<c:if test="${cri.crtPage==idx}">
					<strong><a href="list.do?crtPage=${idx }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">${idx }</a></strong>
				</c:if>
				<c:if test="${cri.crtPage!=idx}">
					<a href="list.do?crtPage=${idx }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">${idx }</a>
				</c:if>
			</c:forEach>
			
			<c:if test="${pageMaker.next }">
				<a href="list.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }"><img src="<c:url value='/images/exam/btn/btn_nex01.gif'/>" alt="다음"/></a>
			</c:if>
		
		</c:if>
	     											
	</p>
	<!-- //페이지리스트 -->
		
	<div class="seachArea" >
		<form class="form-inline" action="list.do" method="get" >
			<select name="searchType" class="h30">
				<option value=''>선택하세요</option>
				<option value='t'>제목</option>
				<option value='c'>내용</option>
				<option value='tc'>제목+내용</option>
			</select>
		
			<input type="text" name="keyword" class="h30">
	
			<button type="submit" class="btn btn-default btn-sm serachBtn">
				<span class="ace-icon fa fa-search icon-on-right "></span>
				검색
			</button>
		</form>	
	</div>
				
</div>
<!-- //right_warp(오른쪽 내용) -->