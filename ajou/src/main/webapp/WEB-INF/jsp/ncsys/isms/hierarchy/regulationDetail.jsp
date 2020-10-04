<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="popup">	

<form class="form-horizontal" id="form_regulationDetail" name="form_regulationDetail" >

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
													<label class="control-label col-md-1" for="prepend" style="">분야</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="regulationDetail.fldid">
										                        <option  ng-repeat="option in field" value="{{option.fldid}}">{{option.fldnm}}</option>
										                    </select>
										                </div>
										            </div>    
										            <div class="col-md-1" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-default" onclick="javascript:openYield();">
															...
														</a>
													</div>
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">통제</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="regulationDetail.rglid">
										                        <option  ng-repeat="option in regulation" value="{{option.rglid}}">{{option.rglnm}}</option>
										                    </select>
										                </div>
										            </div>    
										            <div class="col-md-1" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-default" onclick="javascript:openRegulation();">
															...
														</a>
													</div>
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">통제항목</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="regulationDetail.rgldtlnm"/>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">ISMS기준</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="regulationDetail.ismsstd" />
										                </div>
										            </div>   
												</div>
											</fieldset>	 
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">관리목적</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea rows=5  class="form-control"  ng-model="regulationDetail.mgrgoal"></textarea>
										                </div>
										            </div> 
												</div>
											</fieldset>	
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">적용내용</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea rows=5  class="form-control" ng-model="regulationDetail.adjustcnt" ></textarea>
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">적용여부</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                    <select style="width:60px;" ng-model="regulationDetail.adjustyn">
										                    	<option value="Y">Y</option>
										                    	<option value="N">N</option>
										                    </select>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                    <input type="text" ng-model="regulationDetail.sortby">
										            </div>  
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">관련문서</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea rows=5  class="form-control" ng-model="regulationDetail.referdoc" ></textarea>
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">증적자료</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea rows=5  class="form-control" ng-model="regulationDetail.referpds" ></textarea>
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
    
<form class="form-horizontal" id="form_regulationDetailYield" name="form_regulationDetailYield" style="display: none;padding:40px;">    
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
													<label class="control-label col-md-2" for="prepend" style="">분야</label>
													<div class="col-md-3" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="selField.fldnm"/>
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
																	<th style="width:40%">분야</th>
																	<th style="width:20%">정렬순서</th>
																</tr>
															</thead>
														</table>	
													</div>		
													<div class="table-responsive" style="height:200px;overflow-y: scroll;overflow-x:hidden; margin-bottom: 20px; ">		
														<table class="table table-bordered">	
															<tbody>
																<tr ng-repeat="yield in field" style="cursor: pointer;" >
																	<td ng-click="actionShowYieldDetail(yield)" style="width:40%">{{yield.fldnm}}</td>
																	<td ng-click="actionShowYieldDetail(yield)" style="width:20%">{{yield.sortby}}</td>
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
    
<form class="form-horizontal" id="form_regulation" name="form_regulation" style="display: none;padding:40px;">    
<section id="widget-yield" class="" >
	<div class="row">
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>통제 정보</h2>
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
													<label class="control-label col-md-1" for="prepend" style="">통제</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control"  ng-model="selRegulation.rglnm"/>
										                </div>
										            </div>    
													<label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control"  ng-model="selRegulation.sortby"/>
										                </div>
										            </div>    
												</div>
											</fieldset>
											
											<fieldset style="margin-bottom: 20px;">
												<div class="form-group">
												   	<div id="buttonContent" style="width:100%;padding-right:20px;">
														<a class="btn btn-default pull-right" onclick="javascript:closeBranch();" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
														
														<a id="btn_insert_regulation" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedRegulation('insertRegulation');">추가하기</a>
														
														<a id="btn_delete_regulation" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedRegulation('deleteRegulation');">삭제하기</a>
														<a id="btn_update_regulation" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedRegulation('updateRegulation');">수정하기</a>
														
													</div>
												</div>
											</fieldset>	
																						
											<fieldset>
													<div class="table-responsive" style="height:35px;overflow-y: scroll;overflow-x:hidden; ">
														<table class="table table-bordered" style="height:35px;">
															<thead>
																<tr>
																	<th style="width:40%">통제</th>
																	<th style="width:20%">정렬순서</th>
																</tr>
															</thead>
														</table>	
													</div>		
													<div class="table-responsive" style="height:200px;overflow-y: scroll;overflow-x:hidden; margin-bottom: 20px; ">		
														<table class="table table-bordered">	
															<tbody>
																<tr ng-repeat="rgl in regulation" style="cursor: pointer;" >
																	<td ng-click="actionShowRegulation(rgl)" style="width:40%">{{rgl.rglnm}}</td>
																	<td ng-click="actionShowRegulation(rgl)" style="width:20%">{{rgl.sortby}}</td>
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
