<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



				<div class="col-xs-12">
					<!-- PAGE CONTENT BEGINS -->

					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-1 control-label " for="title"> 제목 </label>
							<div class="col-sm-10">
								<input readonly type="text" id="title" class="form-control" name="title" value="${article.title }">
							</div>
							<div class="col-sm-1"></div>
						</div>

						<div class="form-group">
							<label class="col-sm-1 control-label " for="writer"> 글쓴이
							</label>
							<div class="col-sm-10">
								<input readonly type="text" id="writer" class="form-control" name="writer" value="${article.writer }">
							</div>
							<div class="col-sm-1"></div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-1 control-label " for="content"> 내용
							</label>
							<div class="col-sm-10">
								<textarea readonly class="form-control" id="content" rows="13" name="content">
									${article.content }<br><br>
									bID: ${article.bID }<br>
									regID: ${article.regID }<br>
									regDate: ${article.regDate }<br>
									modifyID: ${article.modifyID }<br>
									modifyDate: ${article.modifyDate }<br>
									cnt: ${article.cnt }<br>
									groupNO: ${article.groupNO }<br>
									depth: ${article.depth }<br>
									orderby: ${article.orderby }<br>
									pID: ${article.pID }
								</textarea>
							</div>
							<div class="col-sm-1"></div>
						</div>
						
						<!-- 첨부파일 -->
						<div class="form-group">
							<label class="col-sm-1 control-label " for="fileDropZone"> 첨부파일 </label>
							<div class="col-sm-10 well">
								<div>
									<ul id="fileList">
										<c:forEach items="${attachFileList}" var="attachFileList">
											<li data-fid='${attachFileList.fID }'><span>${attachFileList.orgName }|</span><span>${attachFileList.fID }|</span><span>${attachFileList.fileSize}|</span></a></li>
										</c:forEach>	
									</ul>
								</div>
							</div>
							<div class="col-sm-1"></div>
						</div>
						<!-- 첨부파일 -->

					</form>
					
					
					<form id="formData" method="post">
						<input id='bid' type="hidden" name="bID" value="${article.bID }" /> 
						<input id='crtPage' type="hidden" name="crtPage" value="${cri.crtPage }" /> 
						<input type="hidden" name="rowCnt" value="${cri.rowCnt }" /> 
						
					</form>
					
					<div class="row"><!-- row 버튼영역 -->
						<div class="col-xs-6">
						</div>
						
						<div class="col-xs-5">
							<p>
							
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
								
							
								<button type="button" class="btn btn-light btn-sm pull-right btn_list">
										<span class="ace-icon fa fa-list icon-on-right"></span>
										목록보기
								</button>
								
							
							</p>
						</div>
						<div class="col-xs-1">
						</div>
						
					</div><!-- /.row 버튼영역 -->



					<!-- PAGE CONTENT ENDS -->
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
					
					

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
		formObj.attr("action", "write.do");
		formObj.attr("method", "get");
		
		formObj.submit();
	});

	$(".btn_delete").on("click", function(){
		
		$.ajax({
			type:"post",
			url:"<c:url value='/enotice/selectReBoardCnt.json' />",
			data:formObj.serialize(),
			dataType:"json",
			success:function(reBoardCnt){
				if(reBoardCnt > 0){
					alert("답글을 지워주세요  답글갯수:" + reBoardCnt);	
				}
				else {
					formObj.attr("action", "delete.do");
					formObj.submit();
					alert("삭제되었습니다");
				}
			}
		});
	});
	
	
	$(".btn_modify").on("click", function(){
		formObj.attr("action", "modify.do");
		formObj.attr("method", "get");
		
		formObj.submit();
	});
	
	$(".btn_list").on("click", function(){
		$("#crtPage").attr("disabled","disabled")
		formObj.attr("action", "list.do");
		formObj.attr("method", "get");
		
		formObj.submit();
	});
	
});

/*--------첨부파일 다운로드--- -----------*/
$("#fileList").on("click","li", function(event){
	var fID = $(this).data("fid");
	console.log(fID);
});


</script>

