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
													<label class="control-label col-md-1" for="prepend" style="">버전</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" id="selCtrVerNM" />
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
										            <label class="control-label col-md-1" for="prepend" style="">법령지침</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.criteriaItem.guideline" ng-required="true"/>
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">관련조항</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.criteriaItem.currentstate" ng-required="true"/>
										                </div>
										            </div>    
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">내용</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea type="text" class="form-control" rows=5 ng-model="entity.criteriaItem.ctrcnt"/>
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">현황</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea type="text" class="form-control" rows=5 ng-model="entity.criteriaItem.article"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">우려사항</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.criteriaItem.ctrccn" />
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">법령여부</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.criteriaItem.legal" ng-required="true">
										                        <option value="H">H</option>
										                        <option value="M">M</option>
										                        <option value="L">L</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">보호대책여부</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.criteriaItem.protect" ng-required="true">
										                        <option value="Y">Y</option>
										                        <option value="P">P</option>
										                        <option value="N">N</option>
										                        <option value="NA">NA</option>
										                    </select>
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text"  class="form-control" ng-model="entity.criteriaItem.sortby" ng-required="true"/>
										                </div>
										            </div> 
										              
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">대응방안</label>
													<div class="col-md-5" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea type="text" class="form-control" rows=5 ng-model="entity.criteriaItem.actionplan"/>
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
