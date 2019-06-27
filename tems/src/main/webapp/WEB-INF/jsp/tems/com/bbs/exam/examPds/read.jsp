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


<!-- row -->
<div class="row">

	<div class="col-sm-11">
		
		<div class="col-sm-12">
			<table class="table table-bordered ">
				<tr>
					<td>&nbsp;&nbsp;&nbsp;${article.title }</td>
				</tr>
				<tr>
					<td>
					   <span class="col-sm-7"></span>
					   <span class="col-sm-2">작성자: ${article.writer }</span>
					   <span class="col-sm-2">등록일: ${article.regDate }</span>
					   <span class="col-sm-1">조회수: ${article.cnt }</span>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="col-sm-12 article_content">
			<c:out  value="${article.content }" escapeXml="false"/>
		</div>
		
		<div class="col-sm-12 form-group">		
									
			<!-- 첨부파일 -->
		
				
			<div id="fileDropZone"  class="fileZone"">
				<div>
					<b>첨부파일</b>
					<ul id="fileList" class="fileList" >
						<c:forEach items="${attachFileList}" var="attachFileList">
							<li class="mouseLink noBullet" data-filePath='${attachFileList.filePath }' data-orgName='${attachFileList.orgName }'><i class="fa fa-file-o"></i>&nbsp; <span>${attachFileList.orgName }|</span><span>${attachFileList.fID }|</span><span class='pull-right'>${attachFileList.fileSize} KB</span></a></li>
						</c:forEach>	
					</ul>
				</div>
			</div>
			
			<!-- 첨부파일 -->	
		</div>
		
		
		<!-- 버튼영역 -->
		<div class="col-sm-12 btn_area">
			<form id="formData" >
				<button type="button" class="btn btn-info btn-sm pull-right btn_reply">
					<span class="ace-icon fa fa-pencil icon-on-right"></span>
					답글쓰기
				</button>
			
				<button type="button" class="btn btn-info btn-sm pull-right btn_delete">
					<span class="ace-icon fa fa-pencil icon-on-right"></span>
						삭제
				</button>
				
				
				<button type="button" class="btn btn-info btn-sm pull-right btn_modify">
					<span class="ace-icon fa fa-pencil icon-on-right"></span>
						수정
				</button>
				
			
				<button type="button" class="btn btn-light btn-sm pull-right btn_list"  >
					<span class="ace-icon fa fa-list icon-on-right"></span>
						목록보기
				</button>
			</form>
		</div>
		<!-- /버튼영역 -->
		
		
		
		
	</div>	

	
	<div class="col-sm-1">
		
	</div>		

	
</div>
<!-- /row -->				
















					
					

<br>
<br>
<br>
<br>
<br>
<br>
<br>


<script>
$(document).ready(function(){
	var formObj = $("form[id='formData']")
	
	$(".btn_reply").on("click", function(){
		
		formObj.attr("action", "write.do?bID=${article.bID }&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }");
		formObj.attr("method", "post");
		
		formObj.submit();
	});

	
	$(".btn_delete").on("click", function(){
		
		$.ajax({
			type:"post",
			url:"<c:url value='/bbs/examPds/selectReBoardCnt.json' />",
			data:"bID=" + ${article.bID },
			dataType:"text",
			success:function(reBoardCnt){
				if(reBoardCnt > 0){
					alert("답글을 지워주세요  답글갯수:" + reBoardCnt);	
				}
				else {
					
					$.ajax({
						type:"post",
						url:"<c:url value='/bbs/examPds/delete.json' />",
						data:"bID=" + ${article.bID },
						dataType:"text",
						success:function(reBoardCnt){
							alert("삭제되었습니다");
							location.href = "./list.do?crtPage=" + ${cri.crtPage } + "&rowCnt=" + ${cri.rowCnt }  ;
						}
					});
					
					
				}
			}
		});
	});
	
	
	$(".btn_modify").on("click", function(){
		formObj.attr("action", "modify.do?bID=${article.bID }&crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }");
		formObj.attr("method", "post");
		
		formObj.submit();
	});
	
	
	$(".btn_list").on("click", function(){
		formObj.attr("action", "list.do?crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }");
		formObj.attr("method", "post");
		
		formObj.submit();
	});
	
	

	
	
});

/*--------첨부파일 다운로드--- -----------*/
$("#fileList").on("click","li", function(event){
	var that =$(this)
	
	var filePath = that.attr("data-filePath");
	var orgName = that.attr("data-orgName");

	window.open("<c:url value='/common/getFileDown.json?filenick="+filePath+"&fileName="+orgName+"'/>");
	
});


</script>

