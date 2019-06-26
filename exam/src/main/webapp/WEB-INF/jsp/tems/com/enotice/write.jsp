<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- include summernote css/js-->
  <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
  <link href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.css" rel="stylesheet">
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.7.0/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.7.0/summernote.js"></script>
  <script type="text/javascript" src="<c:url value='/js/tems/summernote/lang/summernote-ko-KR.js' />"></script>
<%-- <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script>
<link href="<c:url value='/css/tems/summernote/summernote.css' />" rel="stylesheet">
<script type="text/javascript" src="<c:url value='/js/tems/summernote/summernote.js' />"></script>

 --%>


			<div class="row">
				<div class="col-xs-12">
					<!-- PAGE CONTENT BEGINS -->

					<form id="boardForm"  class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-1 control-label " for="title"> 제목 </label>
							<div class="col-sm-10">
								<input type="text" id="title" placeholder="제목을 입력하세요" class="form-control" name="title" >
							</div>
							<div class="col-sm-1"></div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-1 control-label " for="writer"> 글쓴이 </label>
							<div class="col-sm-10">
								<input readonly type="text" id="writer" class="form-control" value="황일영" name="writer">
							</div>
							<div class="col-sm-1"></div>
						</div>

						<div class="form-group">
							<label class="col-sm-1 control-label " for="content"> 내용 </label>
							<div class="col-sm-10">
								<div id="summernote">Hello Summernote</div>
							</div>					
							<div class="col-sm-1"></div>
						</div>
						
						
						<!-- 첨부파일 -->
						<div class="form-group">
							<label class="col-sm-1 control-label " for="fileDropZone"> 첨부파일 </label>
							<div class="col-sm-10 well">
								<div id="fileDropZone">
									여기에 파일을 끌어 놓으세요
								</div>
								<div>
									<ul id="fileList">
									</ul>
								</div>
							</div>
							<div class="col-sm-1"></div>
						</div>
						<!-- 첨부파일 -->

						<div class="clearfix form-actions ">
							<div class="col-md-12 center">
								<button id="btn_submit" class="btn btn-info" type="submit">
								<i class="ace-icon fa fa-check bigger-110"></i>
								Submit
								</button>

								&nbsp; &nbsp; &nbsp;
								<button id="btn_list" class="btn" type="reset">
								<i class="ace-icon fa fa-undo bigger-110"></i>
								Reset
								</button>
							</div>
						</div>
						
						
						<div class="col-sm-6">
							bID: <input type="text" id="bID"  name="bID" value="${article.bID }"><br>
							groupNO: <input type="text" id="groupNO"  name="groupNO" value="${article.groupNO }"><br>
							depth: <input type="text" id="depth"  name="depth" value="${article.depth }"><br>
							orderby: <input type="text" id="orderby"  name="orderby" value="${article.orderby }"><br>
							pID: <input type="text" id="pID"  name="pID" value="${article.pID }"><br>
							
							crtPage: <input type="text" id="crtPage"  name="crtPage" value="${cri.crtPage }"><br>
							rowCnt: <input type="text" id="rowCnt"  name="rowCnt" value="${cri.rowCnt }"><br>
						</div>	
						
					</form>

					
					<!-- PAGE CONTENT ENDS -->
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
			
<script>

//summernote(editer) 충돌로 jQuery 변경
var $jq = jQuery.noConflict();

$jq(document).ready(function() {
	$jq('#summernote').summernote({
		height: 150, 
		lang: 'ko-KR' 
	});
});


//첨부파일
var attachList=[];

/*--------첨부파일 드래그--------------*/
$jq("#fileDropZone").on("dragover dragenter", function(event){
	event.preventDefault();
});


/*--------첨부파일 드롭-----*/
$jq("#fileDropZone").on("drop", function(event){
	event.preventDefault();	
	var files = event.originalEvent.dataTransfer.files;

	for(var i = 0, len = files.length; i < len; i++){
	
		var file = files[i];
		var formData = new FormData();
		formData.append("file", file);	
	
		$.ajax({
			type:"post",
			url:"<c:url value='/enotice/attachFile.json' />",
			data:formData,
			processData:false,
			contentType:false,	
			
			dataType:"json",
			success:function(attachFileVO){
				$jq("#fileList").append(
						 "<li><span>" + attachFileVO.orgName + "|</span><span>" + attachFileVO.fID + "|</span><span>" + attachFileVO.fileSize + "|</span><span><input type='text' name='fID' value="+ attachFileVO.fID +"></span></li>" );
			}
		});
	}

});


/*--------글저장, 첨부파일bno Update---------*/
$jq('#boardForm').submit(function() {
	event.preventDefault();
	
	var markupStr = $jq('#summernote').summernote('code');
	$jq.ajax({
		type: 'post',
		url : "<c:url value='/enotice/insert.do' />", 
		data : $jq('#boardForm').serialize() + "&content=" + markupStr,
	});
	
});





	
		
</script>

</html>