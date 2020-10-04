<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="popup">	

<form class="form-horizontal" id="for_detail" name="form_detail" >

<section id="widget-base" class="" >
	<div class="row" >
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>자산정보 상세</h2>
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
													<label class="control-label col-md-1" for="prepend" style="">자산버전</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" id="txtVersion" />
										                </div>
										            </div>    
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">자산구분</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.asset.astgrpid">
										                        <option  ng-repeat="option in entity.selAstGrps" value="{{option.astgrpid}}">{{option.astgrpnm}}</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">관리번호</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.asset.mgnno" ng-required="true"/>
										                </div>
										            </div>    
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">대분류</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.asset.cate01"/>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">소분류</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.cate02" />
										                </div>
										            </div>   
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="padding-top: 0px;font-size: 12px;">자산명(호스트)</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;" >
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" name="assetnm" ng-model="entity.asset.assetnm" ng-required="true"  placeholder="자산 명칭 또는 호스트명" />
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">설명</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.assetdfn" />
										                </div>
										            </div>   
												</div>
											</fieldset>	 
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">IP</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.asset.ipinfo"/>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">대수</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.ea" />
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">위치</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.position" />
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">모델명</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.modelnm" />
										                </div>
										            </div>   
												</div>
											</fieldset>
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">자산번호</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.asset.astno"/>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">담당자</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.ownerid" />
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">관리자</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.mgnid" />
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">운영여부</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.asset.operyn">
										                        <option  value="Y">운영</option>
										                        <option  value="N">미운영</option>
										                    </select>
										                </div>
										            </div>   
												</div>
											</fieldset>
											<header style="border-top:0px solid #c1c1c1;margin-top: 8px;padding-top: 8px;">제조사정보</header>
											<legend style="padding:4px 0;"></legend>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">관리부서</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.asset.introdept"/>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">업체정보</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.introcmpny" />
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">도입일</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input datepicker type="text"  class="form-control" name="introDt" id="introDt" ng-model="entity.asset.introdt" />
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">유지보수업체</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.ascmpny" />
										                </div>
										            </div>   
												</div>
											</fieldset>
											<header style="border-top:0px solid #c1c1c1;margin-top: 8px;padding-top: 8px;">중요도</header>
											<legend style="padding:4px 0;"></legend>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">기밀성(C)</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.asset.imptc" ng-required="true">
										                        <option  value="3">H(3)</option>
										                        <option  value="2">M(2)</option>
										                        <option  value="1">L(1)</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">무결성(I)</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.asset.impti" ng-required="true">
										                        <option  value="3">H(3)</option>
										                        <option  value="2">M(2)</option>
										                        <option  value="1">L(1)</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">가용성(A)</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.asset.impta" ng-required="true">
										                        <option  value="3">H(3)</option>
										                        <option  value="2">M(2)</option>
										                        <option  value="1">L(1)</option>
										                    </select>
										                </div>
										            </div>
										               
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">인증대상</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.asset.certiyn">
										                        <option  value="Y">Y</option>
										                        <option  value="N">N</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">취약점대상</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.asset.wktstyn">
										                        <option  value="Y">Y</option>
										                        <option  value="N">N</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.asset.sortby" ng-required="true"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
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
      
       
       function openYield(){
    	   $("#form_regulationDetail").hide();
    	   $("#form_regulationDetailYield").show();
    	   
    	   //clear
    	   var scope = angular.element(document.getElementById("regulationDetailApp")).scope();
    	   scope.selField = null;
    	   scope.$apply();
    	   
    	   $("#btn_insert_field").show();
    	   $("#btn_update_field").hide();
    	   $("#btn_delete_field").hide();
    	   
    	   
       }
       
       function openRegulation(){
    	   $("#form_regulationDetail").hide();
    	   $("#form_regulation").show();
    	   
    	  //clear
    	   var scope = angular.element(document.getElementById("regulationDetailApp")).scope();
    	   scope.selRegulation = null;
    	   scope.$apply();
    	   
    	   $("#btn_insert_regulation").show();
    	   $("#btn_update_regulation").hide();
    	   $("#btn_delete_regulation").hide();
    	   
       }
       
       function closeBranch(){
    	   $("#form_regulationDetail").show();
    	   $("#form_regulationDetailYield").hide();
    	   $("#form_regulation").hide();
       }
    
    </script>
