<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<!-- VISION CONTENT -->
					<div class="popup">
					    
					<form class="form-horizontal" id="form_version" name="form_version" style="padding:40px;">    
					<section id="widget-yield" class="" >
						<div class="row">
									<!-- NEW WIDGET START -->
									<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
										<div class="jarviswidget" id="wid-id-1" >								
											<header>
												<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
												<h2>버전 정보</h2>
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
																<label class="control-label col-md-2" for="prepend" style="">법적준거 버전</label>
																<div class="col-md-4" style="padding-right: 1px;;">
													                <div class="icon-addon addon-md" >
													                    <input type="text" class="form-control"  ng-model="entity.criteriaVer.ctrvernm" ng-required="true"/>
													                </div>
													            </div>    
																<label class="control-label col-md-2" for="prepend" style="">정렬순서</label>
																<div class="col-md-3" style="padding-right: 1px;;">
													                <div class="icon-addon addon-md" >
													                    <input type="text" class="form-control"  ng-model="entity.criteriaVer.sortby" ng-required="true"/>
													                </div>
													            </div>    
															</div>
														</fieldset>
														
														<fieldset style="margin-bottom: 20px;">
															<div class="form-group">
															   	<div id="buttonContent" style="width:100%;padding-right:20px;">
																	<a class="btn btn-default pull-right" onclick="javascript:closeEditVersion();" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
																	
																	<a id="btn_insert_version" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedVersion('insertVersion');">추가하기</a>
																	
																	<a id="btn_delete_version" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedVersion('deleteVersion');">삭제하기</a>
																	<a id="btn_update_version" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformedVersion('updateVersion');">수정하기</a>
																	
																</div>
															</div>
														</fieldset>	
																									
														<fieldset>
																<div class="table-responsive" style="height:35px;overflow-y: scroll;overflow-x:hidden; ">
																	<table class="table table-bordered" style="height:35px;">
																		<thead>
																			<tr>
																				<th style="width:40%">자산버전</th>
																				<th style="width:20%">정렬순서</th>
																			</tr>
																		</thead>
																	</table>	
																</div>		
																<div class="table-responsive" style="height:200px;overflow-y: scroll;overflow-x:hidden; margin-bottom: 20px; ">		
																	<table class="table table-bordered">	
																		<tbody>
																			<tr ng-repeat="ver in entity.selCriteriaVers" style="cursor: pointer;" >
																				<td ng-click="actionShowVersion(ver)" style="width:40%">{{ver.ctrvernm}}</td>
																				<td ng-click="actionShowVersion(ver)" style="width:20%">{{ver.sortby}}</td>
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
 
    
    </script>
