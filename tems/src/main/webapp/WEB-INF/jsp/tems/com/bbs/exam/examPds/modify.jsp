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

  <!-- include summernote css/js-->
  <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
  <link href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.css" rel="stylesheet">
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.7.0/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.7.0/summernote.js"></script>
  <script type="text/javascript" src="<c:url value='/js/tems/summernote/lang/summernote-ko-KR.js' />"></script>


 <!--  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script> -->
  <script type="text/javascript" src="<c:url value='/js/tems/summernote/summernote.js' />"></script>
  <link href="<c:url value='/css/tems/summernote/summernote.css' />" rel="stylesheet">



			<div class="row">
				<div class="col-xs-12">
					<!-- PAGE CONTENT BEGINS -->

					<form id="boardForm"  class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-1 control-label " for="title"> 제목 </label>
							<div class="col-sm-10">
								<input type="text" id="title" class="form-control" name="title"  value="${article.title }">
							</div>
							<div class="col-sm-1"></div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-1 control-label " for="writer"> 글쓴이 </label>
							<div class="col-sm-10">
								<input readonly type="text" id="writer" class="form-control" name="writer" value="${article.writer }">
							</div>
							<div class="col-sm-1"></div>
						</div>

						<div class="form-group">
							<label class="col-sm-1 control-label " for="content"> 내용 </label>
							<div class="col-sm-10">
								<div id="summernote">${article.content }</div>
							</div>					
							<div class="col-sm-1"></div>
						</div>
						
						
						<!-- 첨부파일 -->
						<div class="form-group">
							<label class="col-sm-1 control-label " for="fileDropZone"> 첨부파일 </label>
							<div class="col-sm-10">
								<div id="fileDropZone" class="fileZone">
									<div>
										<ul id="fileList">
											
										</ul>
									</div>
								</div>
								
							</div>
							<div class="col-sm-1"></div>
						</div>
						<!-- 첨부파일 -->
						
						
						<!-- 버튼영역 -->
						<div class="col-sm-11 btn_area">
							<button id="btn_submit" class="btn btn-info " type="submit">
								<i class="ace-icon fa fa-check"></i>
								저장
							</button>
			
							<a href="list.do?crtPage=${cri.crtPage }&rowCnt=${cri.rowCnt }">
								<button id="btn_reset" class="btn btn-sm pull-right" type="button">
								
									<i class="ace-icon fa fa-undo"></i>
									취소
								</button>
							</a>
						</div>
						<div class="col-sm-1"></div>
						<!-- /버튼영역 -->
		
					
						
						<br><br><br><br><br><br><br><br><br>
						<div class="col-sm-6">
 							bID: <input type="text" id="bID"  name="bID" value="${article.bID }"><br>
							
							regID: <input type="text" id="regID"  name="regID" value="${article.regID }"><br>
							regDate: <input type="text" id="regDate"  name="regDate" value="${article.regDate }"><br>
							
							modifyID <input type="text" id="modifyID"  name="modifyID" value="${article.modifyID }"><br>
							modifyDate <input type="text" id="modifyDate"  name="modifyDate" value="${article.modifyDate }"><br>
							
							cnt: <input type="text" id="cnt"  name="cnt" value="${article.cnt }"><br>
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

//첨부파일
var attachList=[];


//에디터
$(document).ready(function() {
	$('#summernote').summernote({
		height: 300, 
		lang: 'ko-KR',
		disableDragAndDrop: true
	});
});


//첨부파일 출력
$(document).ready(function() {
	
	$.ajax({
		url: "<c:url value='/examPds/listFile.json' />",
		type: "post",
		data: "bID=" + ${article.bID },
		
		success:function(attachFileVO){
			
			$(attachFileVO).each(
				function(){
					$("#fileList").append(
							 "<li><span>" + this.orgName + "|</span><span >" + this.fID + "|</span><span class='pull-right' id=btn_fileDel data-saveName="+ this.saveName + "><i class='fa fa-times text-danger mouseLink'></i></span><span class='pull-right'>" + this.fileSize + "&nbsp;KB &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span><input type='hidden' name='fID' value="+ this.fID +"></span></li>"
					);
					
					attachList.push(this); 
					
				
					console.log(this);				
			});
			
		
		}
	});
	
});

 
/*--------첨부파일 드래그--------------*/
$("#fileDropZone").on("dragover dragenter", function(event){
	event.preventDefault();
});


/*--------첨부파일 드롭-----*/
$("#fileDropZone").on("drop", function(event){
	event.preventDefault();	
	var files = event.originalEvent.dataTransfer.files;
	
	for(var i = 0, len = files.length; i < len; i++){
	
		var file = files[i];
		var formData = new FormData();
		formData.append("file", file);	
		console.log(file);
		console.log("================================");
		console.log(file.name);
		console.log(file.size);
		console.log("================================");
		
		$.ajax({
			url: "<c:url value='/examPds/attachFile.json' />",
			type: "post",
			data: formData,
			processData:false,
			contentType:false,
			
			dataType:"json",
			success:function(attachFileVO){
				$("#fileList").append(
						 "<li><span>" + attachFileVO.orgName + "|</span><span >" + attachFileVO.fID + "|</span><span class='pull-right' id=btn_fileDel data-saveName="+ attachFileVO.saveName + "><i class='fa fa-times text-danger mouseLink'></i></span><span class='pull-right'>" + attachFileVO.fileSize + "&nbsp;KB &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span><input type='hidden' name='fID' value="+ attachFileVO.fID +"></span></li>"
									);
				
				attachList.push(attachFileVO); 
				console.log(attachList.length);
				
			},
		});
		
		
	}
});
 

/*--------글저장, 첨부파일bno Update---------*/
$('#boardForm').submit(function() {
	event.preventDefault();
	
	//보드객체 생성
	var boardVO = {
		title: $("input[name=title]").val(),
		writer: $("input[name=writer]").val(),
		content: $('#summernote').summernote('code'),
		
		
		bID: $("input[name=bID]").val(),
		
		
		modifyID: $("input[name=modifyID]").val(),
		modifyDate: $("input[name=modifyDate]").val(),
		
		cnt: $("input[name=cnt]").val(),
		groupNO: $("input[name=groupNO]").val(),
		depth: $("input[name=depth]").val(),
		orderby: $("input[name=orderby]").val(),
		pID: $("input[name=pID]").val()
	}
	
	//모든 정보 담기
	var allBoardVO = {
	    boardVO: boardVO,
	    attachList: attachList
	};
	
	console.log(JSON.stringify(allBoardVO));
	
	
	$.ajax({
		
		type: 'post',
		url : "<c:url value='/bbs/examPds/update.json' />", 
		data : JSON.stringify(allBoardVO),
		contentType: "application/json",
		dataType : 'text',
		success : function(bID) {
			location.href = "./read.do?bID=" + bID +"&crtPage=" + ${cri.crtPage } + "&rowCnt=" + ${cri.rowCnt }  ;
		}
	});


	

});



/*---첨부파일 삭제---*/
$("#fileList").on("click","#btn_fileDel", function(event){
	var that =$(this)
	var saveName = that.attr("data-saveName");
	alert(saveName);
	
	for(var i=0 ;i<attachList.length ; i++ ){
		
		if(saveName==attachList[i].saveName){
			console.log("==================");
			console.log(attachList[i].saveName);
			console.log(i+"번째 같음");
			attachList.splice(i,1);
			that.parent().remove();
		
		}
		
	}

});


</script>

