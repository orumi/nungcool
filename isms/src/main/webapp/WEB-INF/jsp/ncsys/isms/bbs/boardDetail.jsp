<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="<c:url value='/js/se/js/service/HuskyEZCreator.js'/>" charset="utf-8"></script>

<div class="popup">	

<form class="form-horizontal" id="for_detail" name="form_detail" >

<section id="widget-base" class="" >
	<div class="row" >
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>자료실</h2>
								</header>
								<!-- widget div-->
								<div class="widget-content">
									<!-- widget edit box -->
									<div class="jarviswidget-editbox">
										<!-- This area used as dropdown edit box -->
									</div>
									<!-- end widget edit box -->
									<!-- widget content -->
									<div class="widget-body">
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">제목</label>
													<div class="col-md-10" style="padding-right: 90px;padding-left:13px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.board.nttSj"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">내용</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea name="txtDetail" id="txtDetail" rows="10" cols="100" ng-model="entity.board.nttCn" style="width:100%; height:212px; display:none;"></textarea>
										                </div>
										            </div>  
												</div>
											</fieldset>
											<c:if test="${boardVO.bbsAttrbCode == 'BBSA01'}">
											<fieldset>
												<div class="form-group">
										            <label class="control-label col-md-1" for="prepend" style="">게시시작</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:13px;;">
										                <div class="icon-addon addon-md" >
										                    <input datepicker type="text"  class="form-control" name="ntceBgnde" id="ntceBgnde" ng-model="entity.board.ntceBgnde" />
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">게시종료</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:13px;;">
										                <div class="icon-addon addon-md" >
										                    <input datepicker type="text"  class="form-control" name="ntceEndde" id="ntceEndde" ng-model="entity.board.ntceEndde" />
										                </div>
										            </div>   
												</div>
											</fieldset>
											</c:if>
											
											
									</div>
								</div>
							</div>
						</article>
    </div><!-- end of row   -->
</section>

	<div id="buttonContent" style="width:100%;">
		<a class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;" onclick="javascript:actionClose();" >닫기</a>
		<a id="btn_insert" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('insertDetail');">저장하기</a>
		
		<a id="btn_delete" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('deleteDetail');">삭제하기</a>
		<a id="btn_update" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('updateDetail');">수정하기</a>
		
	</div>
</form>






	
</div>



    
    
<script type="text/javascript">
	var oEditors = [];
	
	var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR
	function createEditArea(){
		// 추가 글꼴 목록
		//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "txtDetail",
			sSkinURI: "<c:url value='/js/se/SmartEditor2Skin.html'/>",	
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				fOnBeforeUnload : function(){
					//alert("완료!");
				},
				I18N_LOCALE : sLang
			}, //boolean
			fOnAppLoad : function(){
				//예제 코드
				//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
	}
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["txtDetail"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["txtDetail"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["txtDetail"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["txtDetail"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>
