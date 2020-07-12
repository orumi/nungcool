<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<!-- VISION CONTENT -->
					<div class="popup">

					<form class="form-horizontal" id="form_detail" name="form_detail" style="padding:40px;" >
					<section id="widget-yield" class="" >
						<div class="row">
									<!-- NEW WIDGET START -->
									<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
										<div class="jarviswidget" id="wid-id-1" >
											<header>
												<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
												<h2>맵정보</h2>
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
																<label class="control-label col-md-2" for="prepend" style="">명칭</label>
																<div class="col-md-5" style="padding-right: 1px;;">
													                <div class="icon-addon addon-md" >
													                    <input type="text" class="form-control"  ng-model="entity.map.mapname"/>
													                </div>
													            </div>
													            <label class="control-label col-md-1" for="prepend" style="">순서</label>
													            <div class="col-md-2" style="padding-right: 1px;;">
													                <div class="icon-addon addon-md" >
													                    <input type="text" class="form-control"  ng-model="entity.map.maprank"/>
													                </div>
													            </div>
													        </div>
													        <div class="form-group">
																<label class="control-label col-md-2" for="prepend" style="">배경이미지</label>
																<div class="col-md-8" style="padding-right: 1px;;">
													                <div class="icon-addon addon-md" >
													                    <select class="form-control" id="selMapImages" ng-model="entity.map.background" >
																			<option ng-repeat="option in entity.mapImages" value="{{option}}">{{option}}</option>
																		</select>
													                </div>
													            </div>
													            <div style="width:36px;float:left;">
													            <!-- <a ng-click="closeProperties()"  class="btn btn-default pull-right" style="width:36px;padding: 6px 8px; margin: 0px;">...</a> -->
																<div class="row fileupload-buttonbar">
														            <div class="col-md-7">
														                <!-- The fileinput-button span is used to style the file input field as button -->
														                <span class="btn btn-success fileinput-button" ng-class="{disabled: disabled}">
														                    <i class="glyphicon glyphicon-plus"></i>
														                    <span>파일업로드</span>
														                    <input type="file" name="files[]" multiple ng-disabled="disabled" file-model="myFile" onchange="angular.element(this).scope().fileUpload(event)">
														                </span>
														                <span class="fileupload-process"></span>
														            </div>
														        </div>
													            </div>

															</div>
														</fieldset>
														<header style="border-top:1px solid #c1c1c1;margin-top: 26px;padding-top: 8px;">아이콘 기본 설정</header>
														<legend></legend>
														<fieldset>
															<div class="form-group">
																<label class="control-label col-md-2" for="prepend" style="">넓이</label>
																<div class="col-md-2" style="padding-right: 1px;;">
													                <div class="icon-addon addon-md" >
													                    <input type="text" class="form-control"  ng-model="entity.map.iconWidth"/>
													                </div>
													            </div>
													            <label class="control-label col-md-2" for="prepend" style="">높이</label>
													            <div class="col-md-2" style="padding-right: 1px;;">
													                <div class="icon-addon addon-md" >
													                    <input type="text" class="form-control"  ng-model="entity.map.iconHeight"/>
													                </div>
													            </div>
													        </div>
													        <div class="form-group">
																<label class="control-label col-md-2" for="prepend" style="">아이콘모양</label>
																<div class="col-md-2" style="padding-right: 1px;;">
													                <div class="icon-addon addon-md" >
													                    <select class="form-control"  ng-model="entity.map.iconShape">
													                    	<option value="e">타원형</option>
													                    	<option value="r">사각형</option>
													                    </select>
													                </div>
													            </div>
													            <label class="control-label col-md-2" for="prepend" style="">글자표시</label>
													            <div class="col-md-1" style="padding-right: 1px;">
													                <input type="checkbox" class="form-control"  style="height:24px;margin-top: 6px;" ng-model="entity.map.showtext"/>
													            </div>
													            <label class="control-label col-md-2" for="prepend" style="">점수표시</label>
													            <div class="col-md-1" style="padding-right: 1px;;">
													                <input type="checkbox" class="form-control"  style="height:24px;margin-top: 6px;" ng-model="entity.map.showscore"/>
													            </div>

															</div>
														</fieldset>


														<fieldset style="margin-bottom: 20px;">
															<div class="form-group">
															   	<div id="buttonContent" style="width:100%;padding-right:20px;">
																	<a ng-click="closeProperties()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>

																	<a id="btn_delete_map" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('deleteMap');">삭제</a>

																	<a id="btn_adjust_map" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('adjustMap');">저장</a>

																</div>
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


    </script>
