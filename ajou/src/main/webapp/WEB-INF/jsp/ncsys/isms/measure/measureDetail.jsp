<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript" src="<c:url value='/js/se/js/service/HuskyEZCreator.js'/>" charset="utf-8"></script>


<div class="popup">	

<form class="form-horizontal" id="form_measureDetail" name="form_measureDetail" >

<section id="widget-base" class="" >
	<div class="row" >
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>통제항목 상세</h2>
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
													<label class="control-label col-md-1" for="prepend" style="">체계버전</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" id="txtVersion" />
										                </div>
										            </div>    
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">진단분야</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="measureDetail.pifldid">
										                        <option  ng-repeat="option in field" value="{{option.pifldid}}">{{option.pifldnm}}</option>
										                    </select>
										                </div>
										            </div>    
										            <div class="col-md-1" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-default" onclick="javascript:openField();">
															...
														</a>
													</div>
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">진단지표</label>
													<div class="col-md-6" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="measureDetail.msrid">
										                        <option  ng-repeat="option in measure" value="{{option.msrid}}">{{option.msrname}}</option>
										                    </select>
										                </div>
										            </div>    
										            <div class="col-md-1" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-default" onclick="javascript:openMeasure();">
															...
														</a>
													</div>
													<label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-1" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="measureDetail.sortby"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">진단항목</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="measureDetail.msrdtlnm"/>
										                </div>
										            </div> 
												</div>
											</fieldset>	 
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">세부설명</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea name="txtDetail" id="txtDetail" rows="10" cols="100" ng-model="measureDetail.msrdtl" style="width:100%; height:212px; display:none;"></textarea>
										                </div>
										            </div> 
												</div>
											</fieldset>	
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">인정실적</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea rows=2  class="form-control" ng-model="measureDetail.certiact" ></textarea>
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">증빙자료</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea rows=2  class="form-control" ng-model="measureDetail.proofpds" ></textarea>
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">산정방법</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea name="txtCalMtd" id="txtCalMtd" rows="10" cols="100" ng-model="measureDetail.calmtd" style="width:100%; height:312px; display:none;"></textarea>
										                </div>
										            </div> 
												</div>
											</fieldset>	
									</div>
								</div>
							</div>
						</article>
    </div><!-- end of row   -->
    <div id="buttonContent" style="width:100%;">
		<a class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;" onclick="javascript:actionClose();" >닫기</a>
		<a id="btn_insert" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('insertDetail');">저장하기</a>
		
		<a id="btn_delete" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('deleteDetail');">삭제하기</a>
		<a id="btn_update" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('updateDetail');">수정하기</a>
		
	</div>
</section>


</form>
    
<form class="form-horizontal" id="form_measureDetailField" name="form_measureDetailField" style="display: none;padding:40px;">    
<section id="widget-yield" class="" >
	<div class="row">
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>분야 상세</h2>
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
													<label class="control-label col-md-2" for="prepend" style="">진단분야</label>
													<div class="col-md-3" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="selField.pifldnm"/>
										                </div>
										            </div>    
													<label class="control-label col-md-2" for="prepend" style="">정렬순서</label>
													<div class="col-md-3" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="selField.sortby"/>
										                </div>
										            </div>    
												</div>
											</fieldset>
											
											<fieldset style="margin-bottom: 20px;">
												<div class="form-group">
												   	<div id="buttonContent" style="width:100%;padding-right:20px;">
														<a class="btn btn-default pull-right" onclick="javascript:closeBranch();" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
														
														<a id="btn_insert_field" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedField('insertField');">추가하기</a>
														
														<a id="btn_delete_field" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedField('deleteField');">삭제하기</a>
														<a id="btn_update_field" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedField('updateField');">수정하기</a>
													</div>
												</div>
											</fieldset>	
																						
											<fieldset>
													<div class="table-responsive" style="height:35px;overflow-y: scroll;overflow-x:hidden; ">
														<table class="table table-bordered" style="height:35px;">
															<thead>
																<tr>
																	<th style="width:40%">진단분야</th>
																	<th style="width:20%">정렬순서</th>
																</tr>
															</thead>
														</table>	
													</div>		
													<div class="table-responsive" style="height:200px;overflow-y: scroll;overflow-x:hidden; margin-bottom: 20px; ">		
														<table class="table table-bordered">	
															<tbody>
																<tr ng-repeat="field in field" style="cursor: pointer;" >
																	<td ng-click="actionShowFieldDetail(field)" style="width:40%">{{field.pifldnm}}</td>
																	<td ng-click="actionShowFieldDetail(field)" style="width:20%">{{field.sortby}}</td>
																</tr>
															</tbody>
														</table>
														
													</div>
											</fieldset>				
												
									</div>
								</div>
							</div>
						</article>

    </div><!-- end of row   -->
</section>    

</form>    
    
<form class="form-horizontal" id="form_measure" name="form_measure" style="display: none;padding:40px;">    
<section id="widget-yield" class="" >
	<div class="row">
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>진단지표 정보</h2>
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
													<label class="control-label col-md-1" for="prepend" style="">진단지표</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control"  ng-model="selMeasure.msrname"/>
										                </div>
										            </div>    
													<label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control"  ng-model="selMeasure.sortby"/>
										                </div>
										            </div>    
												</div>
											</fieldset>
											
											<fieldset style="margin-bottom: 20px;">
												<div class="form-group">
												   	<div id="buttonContent" style="width:100%;padding-right:20px;">
														<a class="btn btn-default pull-right" onclick="javascript:closeBranch();" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
														
														<a id="btn_insert_measure" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedMeasure('insertMeasure');">추가하기</a>
														
														<a id="btn_delete_measure" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedMeasure('deleteMeasure');">삭제하기</a>
														<a id="btn_update_measure" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedMeasure('updateMeasure');">수정하기</a>
														
													</div>
												</div>
											</fieldset>	
																						
											<fieldset>
													<div class="table-responsive" style="height:35px;overflow-y: scroll;overflow-x:hidden; ">
														<table class="table table-bordered" style="height:35px;">
															<thead>
																<tr>
																	<th style="width:40%">진단지표</th>
																	<th style="width:20%">정렬순서</th>
																</tr>
															</thead>
														</table>	
													</div>		
													<div class="table-responsive" style="height:380px;overflow-y: scroll;overflow-x:hidden; margin-bottom: 20px; ">		
														<table class="table table-bordered">	
															<tbody>
																<tr ng-repeat="msr in measure" style="cursor: pointer;" >
																	<td ng-click="actionShowMeasure(msr)" style="width:40%">{{msr.msrname}}</td>
																	<td ng-click="actionShowMeasure(msr)" style="width:20%">{{msr.sortby}}</td>
																</tr>
															</tbody>
														</table>
														
													</div>
											</fieldset>				
												
									</div>
								</div>
							</div>
						</article>

    </div><!-- end of row   -->
</section>    

</form>       

	
</div>



    <script type="text/javascript">
      
       
       function openField(){
    	   $("#form_measureDetail").hide();
    	   $("#form_measureDetailField").show();
    	   
    	   //clear
    	   var scope = angular.element(document.getElementById("measureMngApp")).scope();
    	   scope.selField = null;
    	   scope.$apply();
    	   
    	   $("#btn_insert_field").show();
    	   $("#btn_update_field").hide();
    	   $("#btn_delete_field").hide();
    	   
    	   
       }
       
       function openMeasure(){
    	   $("#form_measureDetail").hide();
    	   $("#form_measure").show();
    	   
    	  //clear
    	   var scope = angular.element(document.getElementById("measureMngApp")).scope();
    	   scope.selmeasure = null;
    	   scope.$apply();
    	   
    	   $("#btn_insert_measure").show();
    	   $("#btn_update_measure").hide();
    	   $("#btn_delete_measure").hide();
    	   
       }
       
       function closeBranch(){
    	   $("#form_measureDetail").show();
    	   $("#form_measureDetailField").hide();
    	   $("#form_measure").hide();
       }
    
    </script>

    
    
    
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
	function createEditArea2(){
		// 추가 글꼴 목록
		//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "txtCalMtd",
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