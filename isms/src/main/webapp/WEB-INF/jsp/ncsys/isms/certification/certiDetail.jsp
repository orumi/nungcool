<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="popup">	

<form class="form-horizontal" id="form_certiDetail" name="form_certiDetail" >

<section id="widget-base" class="" >
	<div class="row" >
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>점검항목 상세</h2>
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
													<label class="control-label col-md-1" for="prepend" style="">분야</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" id="txtVersion" ng-model="certiDetail.fldnm"  ng-disabled="true" />
										                </div>
										            </div>    
										            <label class="control-label col-md-1" for="prepend" style="">통제</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" id="txtVersion" ng-model="certiDetail.rglnm" ng-disabled="true" />
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">통제항목</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="certiDetail.rgldtlnm" ng-disabled="true" />
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">IMSM기준</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="certiDetail.ismsstd" ng-disabled="true" />
										                </div>
										            </div>   
												</div>
											</fieldset>	
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">구분</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="certiDetail.proe">
										                        <option  ng-repeat="option in opProe" value="{{option.val}}">{{option.val}}</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">담당구분</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="certiDetail.ownertype">
										                        <option  ng-repeat="option in ownerType" value="{{option.code}}">{{option.codenm}}</option>
										                    </select>
										                </div>
										            </div> 
												</div>
											</fieldset>	
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">수행주기</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="certiDetail.frequency">
										                        <option  ng-repeat="option in opFrequency" value="{{option.val}}">{{option.val}}</option>
										                    </select>
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">수행자료</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="certiDetail.proofitem" />
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
