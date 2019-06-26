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
									<h2>위험평가 분석 기준 상세</h2>
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
													<label class="control-label col-md-2" for="prepend" style="">분석기준</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.analysis.analysisnm" ng-required="true" />
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
											
													<label class="control-label col-md-2" for="prepend" style="">관리체계 버전</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="versionid" ng-model="entity.analysis.versionid" ng-required="true">
										                        <option  ng-repeat="option in entity.selVersions" value="{{option.verid}}">{{option.vernm}}</option>
										                    </select>
										                </div>
										            </div>    
										            
												</div>
											</fieldset>
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-2" for="prepend" style="">법적 준거성</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="criteriaverid" ng-model="entity.analysis.criteriaverid" ng-required="true">
										                        <option  ng-repeat="option in entity.selCtrVersions" value="{{option.ctrverid}}">{{option.ctrvernm}}</option>
										                    </select>
										                </div>
										            </div>    
													
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-2" for="prepend" style="">기술취약</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="assetverid" ng-model="entity.analysis.assetverid" ng-required="true">
										                        <option  ng-repeat="option in entity.selAstVersions" value="{{option.astverid}}">{{option.astvernm}}</option>
										                    </select>
										                </div>
										            </div>    
													
												</div>
											</fieldset>
											
											<fieldset>
												<div class="form-group">
										            <label class="control-label col-md-2" for="prepend" style="">정렬순서</label>
													<div class="col-md-2" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.analysis.sortby" ng-required="true"/>
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
