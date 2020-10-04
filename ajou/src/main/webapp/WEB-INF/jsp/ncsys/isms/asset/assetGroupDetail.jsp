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
									<h2>자산분류 상세</h2>
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
													<label class="control-label col-md-1" for="prepend" style="">자산분류</label>
													<div class="col-md-3" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.selAstKindId">
										                        <option  ng-repeat="option in entity.selAstKinds" value="{{option.astgrpkind}}">{{option.astgrpkindnm}}</option>
										                    </select>
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
										            <label class="control-label col-md-1" for="prepend" style="">자산구분명</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.assetGrp.astgrpnm" ng-required="true"/>
										                </div>
										            </div>    
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">분류기준</label>
													<div class="col-md-11" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea type="text" class="form-control" rows=5 ng-model="entity.assetGrp.astgrpdfn"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">사용여부</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.assetGrp.useyn" >
										                        <option value="Y">예</option>
										                        <option value="N">아니오</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.assetGrp.sortby" ng-required="true"/>
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
