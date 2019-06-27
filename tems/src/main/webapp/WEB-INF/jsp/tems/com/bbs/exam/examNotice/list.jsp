<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%
	LoginUserVO nLoginVO = (LoginUserVO)session.getAttribute("loginUserVO");
%>

<link rel="stylesheet" href="<c:url value='/css/tems/bbs.css' />">


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>





<div class="row">
				
				<div class="col-xs-12">
					<!-- PAGE CONTENT START -->
					
								
				<!-- 검색 -->
					<div class="row"><!-- row 검색 & 글쓰기버튼 -->
						<div class="col-xs-12 bbs_header">
							<div class="col-xs-6">
								<form class="form-inline" action="list.do" method="get" >
									<select name="searchType" class="form-control input-sm">
								        <option value=''>선택하세요</option>
								        <option value='t'>제목</option>
								        <option value='c'>내용</option>
								        <option value='tc'>제목+내용</option>
							        </select>
									<input name="keyword"   class="form-control input-sm">
									<button type="submit" class="btn btn-default btn-sm">
										<span class="ace-icon fa fa-search icon-on-right"></span>
										검색
									</button>
								</form>
							</div>
							
							<div class="col-xs-6">
								<a href="write.do?crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }">
								<button type="button" class="btn btn-info btn-sm pull-right">
										<span class="ace-icon fa fa-pencil icon-on-right"></span>
										글쓰기
										
								</button>
								</a>
							</div>
						</div>
					</div><!-- /.row 검색 & 글쓰기버튼 -->
					
					
					<div class="row"><!-- row 리스트 -->
						<div class="col-xs-12 bbs_table">
							<table class="table table-striped table-bordered table-hover">
								<colgroup>
									<col width="5%" /><!-- 번호 -->
									<col  />		   <!-- 제목 -->
									<col width="15%" /><!-- 작성자 -->
									<col width="15%" /><!-- 작성일 -->
									<col width="10%" /><!-- 조회수 -->
								</colgroup>
								
								<thead>
									<tr>
										<th class="center">번호</th>
										<th>제목</th>
										<th class="hidden-480">작성자</th>
										<th>작성일</th>
										<th class="hidden-480">조회수</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${boardList}" var="boardList">
									<tr>
										<td class="center">${boardList.bID }</td>
										<td>
											<c:if test="${boardList.depth>0 }">
												<c:forEach begin="1" end="${boardList.depth }" step="1">
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												</c:forEach>
												┗
											</c:if>
											<a href="read.do?bID=${boardList.bID }&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }">${boardList.title }</a>
										</td>
										<td class="text-center">${boardList.writer }</td>
										<td class="text-center">${boardList.regDate }</td>
										<td class="text-right">${boardList.cnt }</td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div><!-- /.col -->
					</div><!-- /.row 리스트-->


					<div class="row"><!-- row 검색 & 글쓰기버튼 -->
						<div class="col-xs-12 bbs_footer">						
							<div class="col-xs-6">
								
									<ul class="pagination">
										
										<!-- 검색안했을때 -->
										<c:if test="${cri.searchType == null&&cri.keyword == null }">
											
											<c:if test="${pageMaker.prev }">
												<li class="previous">
												<a href="list.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }">Prev</a>
												</li>
											</c:if>
											<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
												<li <c:out value="${cri.crtPage==idx? 'class=active' : '' }" /> >
												<a href="list.do?crtPage=${idx }&rowCnt=${cri.rowCnt }">${idx }</a>
												</li>
											</c:forEach>
											<c:if test="${pageMaker.next }">
												<li class="next"">
												<a href="list.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }">Next</a>
												</li>
											</c:if>
										
										</c:if>
										
										<!-- 검색했을때 : 검색관련 속성 붙음 -->
										<c:if test="${cri.searchType != null&&cri.keyword != null }">
											
											<c:if test="${pageMaker.prev }">
												<li class="previous">
												<a href="list.do?crtPage=${pageMaker.startPage-1 }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">Prev</a>
												</li>
											</c:if>
											<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
												<li <c:out value="${cri.crtPage==idx? 'class=active' : '' }" /> >
												<a href="list.do?crtPage=${idx }&rowCnt=${cri.rowCnt }&searchType=${cri.searchType }&keyword=${cri.keyword }">${idx }</a>
												</li>
											</c:forEach>
											<c:if test="${pageMaker.next }">
												<li class="next">
												<a href="list.do?crtPage=${pageMaker.endPage+1 }&rowCnt=${cri.rowCnt }">Next</a>
												</li>
											</c:if>
										
										</c:if>
										
									</ul>
								
							</div>
							
							<div class="col-xs-6">
								<a href="write.do?crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }">
								<button type="button" class="btn btn-info btn-sm pull-right">
										<span class="ace-icon fa fa-pencil icon-on-right"></span>
										글쓰기
										
								</button>
								</a>
							</div>
						</div><!-- /.row 검색 & 글쓰기버튼 -->
					</div>							
					

<br>
<br>
<br>
<br>
<br>
<br>
<br>

</body>
</html>