<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
<!--
 .table-striped tbody tr td {
 	padding:4px 10px;
 }
-->
</style>

<div class="popup">	

<form class="form-horizontal" id="form_actualDetail" name="form_actualDetail" enctype="multipart/form-data" >

<section id="widget-base" class="" >
	<div class="row" >
						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="jarviswidget" id="wid-id-1" >								
								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>수행실적 등록</h2>
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
										                    <input type="text"  class="form-control" id="txtVersion" ng-model="actualDetail.fldnm"  ng-disabled="true" />
										                </div>
										            </div>    
										            <label class="control-label col-md-1" for="prepend" style="">통제</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" id="txtVersion" ng-model="actualDetail.rglnm" ng-disabled="true" />
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">통제항목</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="actualDetail.rgldtlnm" ng-disabled="true" />
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">IMSM기준</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="actualDetail.ismsstd" ng-disabled="true" />
										                </div>
										            </div>   
												</div>
											</fieldset>	
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">구분</label>
													<div class="col-md-2" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                	<input type="text"  class="form-control" ng-model="actualDetail.proe" ng-disabled="true" />
										                </div>
										            </div>
													<label class="control-label col-md-1" for="prepend" style="">수행주기</label>
													<div class="col-md-1" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="actualDetail.frequency" ng-disabled="true" />
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">담당구분</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                	<input type="text"  class="form-control" ng-model="actualDetail.ownertypenm" ng-disabled="true" />
										                </div>
										            </div> 
												</div>
											</fieldset>	
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">수행자료</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="actualDetail.proofitem" ng-disabled="true"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											<legend></legend>
											<fieldset class="col-md-5">
												<div class="form-group">
													<label class="control-label col-md-3" for="prepend" style="">수행월</label>
													<div class="col-md-3" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" style="padding-top:6px;font-size:14px;">
										                    {{actualDetail.year}}년 {{actualDetail.month}}월
										                </div>
										            </div> 
										            <label class="control-label col-md-4" for="prepend" style="">수행실적 (0.0 ~ 1)</label>
													<div id="controlgroup" class="col-md-2" style="padding-right: 1px;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="actualDetail.actual" numbers-only="numbers-only" ng-required="isActualDetailRequired();"/>
										                </div>
										            </div> 
												</div>
												<div class="form-group">
													<label class="control-label col-md-3" for="prepend" style="">수행내역</label>
													<div class="col-md-9" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea class="form-control" style="height:180px;" ng-model="actualDetail.actualdetail"></textarea>
										                </div>
										            </div> 
										            
												</div>
											</fieldset>			
											<fieldset class="col-md-7">
												<div class="form-group">
													<div class="col-md-10" style="padding-right: 1px;;">
										                <div class="row fileupload-buttonbar">
												            <div class="col-md-7">
												                <label class="control-label col-md-4" for="prepend" style="text-align: left;">수행파일</label>
												                <!-- The fileinput-button span is used to style the file input field as button -->
												                <span class="btn btn-success fileinput-button" ng-class="{disabled: disabled}">
												                    <i class="glyphicon glyphicon-plus"></i>
												                    <span>파일업로드</span>
												                    <input type="file" name="files[]" multiple ng-disabled="disabled" file-model="myFile" onchange="angular.element(this).scope().fileUpload(event)">
												                </span>
												                <span class="fileupload-process"></span>
												            </div>
												        </div>
												        <!-- The table listing the files available for upload/download -->
												        <div class="col-md-12" style="height: 180px;overflow-y: auto;margin-bottom: 25px;border: 1px solid #dfdfdf;padding: 8px;">
												        <table class="table table-striped files">
												            <tr data-ng-repeat="aFile in attachFiles" >
												                <td>
												                   <!--  <p class="name" data-ng-switch data-on="!!file.url"> -->
												                        <!-- <span data-ng-switch-when="true" data-ng-switch data-on="!!file.thumbnailUrl">
												                            <a data-ng-switch-when="true" data-ng-href="{{file.url}}" title="{{file.orginFileName}}" download="{{file.orginFileName}}" data-gallery>{{file.orginFileName}}</a>
												                            <a data-ng-switch-default data-ng-href="{{file.url}}" title="{{file.orginFileName}}" download="{{file.orginFileName}}">{{file.orginFileName}}</a>
												                        </span> -->
												                      <span ng-click="fileDown(aFile);" style="cursor:pointer;">{{aFile.orginFileName}}</span>
												                    <!-- </p> -->
												                </td>
												                <td>
												                    <button type="button" class="btn btn-danger btn-xs" ng-click="actionDeleteFile(aFile);">
												                        <i class="glyphicon glyphicon-trash"></i>
												                    </button>
												                </td>
												            </tr>
												        </table>
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
 
	<div id="buttonContent" style="width:100%; height:54px;   
									display: block;
								    padding: 10px 14px 15px;
								    border: 1px solid rgba(0,0,0,.1);
								    background: rgba(248,248,248,.9);">
		<a class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;" onclick="javascript:actionClose();" >닫기</a>
		<a id="btn_delete" class="btn btn-warning pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('deleteDetail');">삭제하기</a>
		<a id="btn_update" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('updateDetail');">저장하기</a>
		
		
	</div>
</form>
    
	
</div>



    <script type="text/javascript">
      
       
       
       
    </script>
