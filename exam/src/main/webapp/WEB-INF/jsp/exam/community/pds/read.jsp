<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<link rel="stylesheet" href="<c:url value='/css/exam/bbs.css' />">




<!-- right_warp(오른쪽 내용) -->
<div class="right_warp">

	<div class="title_route">
	    <div class="title_route">
	    		<div class="title_route">
					<h3>공지사항</h3>
					<p class="route">
					<img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> 
					<img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 커뮤니티 
					<img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>공지사항</span></p>
				</div>
	    </div>
	
	</div>
	    
    


	<div class="table_bg">
		<table class="table_h">
			<thead>
			<tr>
				<th class="b_R_none">${article.title }</th>
			</tr>
			</thead>
			
			<tbody>
			<tr>
				<td class="title b_R_none">
			    	<span class="writer"> 작성자: ${article.writer } </span>
					<span class="cnt"> 조회수: ${article.cnt } </span>
					<span class="regDate"> 작성일 : ${article.regDate } </span>
			    </td>
			 </tr>
			 <tr>
			 	<td class="b_R_none">
					<div class="cont">	
						${article.content }
					</div>
					<div class="fileList">
						<c:forEach items="${attachFileList}" var="attachFileList">	
							<li class="mouseLink noBullet" data-filePath='${attachFileList.filePath }' data-orgName='${attachFileList.orgName }'>
								<i class="fa fa-file-o"></i>
								<span class="hoverLink">${attachFileList.orgName }</span>
							</li>
						</c:forEach>
					</div>
				</td>
			 </tr>
			 
			 </tbody>
		</table>
	</div>
	
	<div class="btnArea">
		<a href="list.do?crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }">
			<button type="submit" class="btn btn-default btn-sm serachBtn">
				목록
			</button>
		</a>
	</div>
</div>
<!-- //right_warp(오른쪽 내용) -->




<script>
/*--------첨부파일 다운로드--- -----------*/
$(".fileList").on("click","li", function(event){
	var that =$(this)
	var filePath = that.attr("data-filePath");
	var orgName = that.attr("data-orgName");

	window.open("<c:url value='/common/download.json?filenick="+filePath+"&fileName="+orgName+"'/>");	
});
</script>