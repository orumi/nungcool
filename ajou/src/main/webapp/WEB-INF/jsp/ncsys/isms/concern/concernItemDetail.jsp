<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="popup">	

<form class="form-horizontal" id="form_detail" name="form_detail" >

<section id="widget-base" class="" >
	<div class="row" >
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>진단항목 상세</h2>
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
													<label class="control-label col-md-1" for="prepend" style="">자산구분</label>
													<div class="col-md-5" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="astgrpid" ng-model="entity.concernItem.astgrpid" ng-required="true">
										                        <option  ng-repeat="option in entity.selAstGroups" value="{{option.astgrpid}}">{{option.astgrpnm}}</option>
										                    </select>
										                </div>
										            </div>    
										            
													<label class="control-label col-md-1" for="prepend" style="">Concern코드</label>
													<div class="col-md-5" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.concernItem.ccnitemcd" ng-required="true" />
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">취약점/위협</label>
													<div class="col-md-5" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea type="text" class="form-control" rows=5 ng-model="entity.concernItem.ccnitemnm"/>
										                </div>
										            </div>    
													<label class="control-label col-md-1" for="prepend" style="">조치방안</label>
													<div class="col-md-5" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea type="text" class="form-control" rows=5 ng-model="entity.concernItem.actionplan"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">발생가능성</label>
													<div class="col-md-1" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.concernItem.ccnvalue" ng-required="true">
										                        <option  value="1">1</option>
										                        <option  value="2">2</option>
										                        <option  value="3">3</option>
										                        <option  value="4">4</option>
										                        <option  value="5">5</option>
										                        <option  value="6">6</option>
										                    </select>
										                </div>
										            </div>    
													<label class="control-label col-md-1" for="prepend" style="">사용여부</label>
													<div class="col-md-1" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.concernItem.useyn" ng-required="true">
										                        <option  value="Y">예</option>
										                        <option  value="N">아니오</option>
										                    </select>
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">조치일정</label>
													<div class="col-md-1" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.concernItem.actionperiod" ng-required="true">
										                        <option  value="단기">단기</option>
										                        <option  value="중기">중기</option>
										                        <option  value="장기">장기</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-2" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.concernItem.sortby" ng-required="true"/>
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
      
    
    </script>
