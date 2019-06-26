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
										            <label class="control-label col-md-1" for="prepend" style="">수행일자</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input datepicker type="text"  class="form-control" name="introDt" id="introDt" ng-model="entity.plannedSchedule.plandt" />
										                </div>
										            </div>   
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">수행제목</label>
													<div class="col-md-10" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.plannedSchedule.plantitle"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">수행내용</label>
													<div class="col-md-10" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <textarea rows=5  class="form-control" ng-model="entity.plannedSchedule.plancontent" ></textarea>
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">완료여부</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;" >
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="entity.plannedSchedule.completeyn" ng-required="true">
										                        <option  value="Y">Y</option>
										                        <option  value="N">N</option>
										                    </select>
										                </div>
										            </div> 
										            <label class="control-label col-md-1" for="prepend" style="">수행기간</label>
													<div class="col-md-2" style="padding-right: 2px;padding-left:4px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="entity.plannedSchedule.period"/>
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
