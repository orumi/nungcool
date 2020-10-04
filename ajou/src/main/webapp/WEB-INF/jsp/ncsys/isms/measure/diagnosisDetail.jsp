<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<div class="popup">	

<form class="form-horizontal" id="form_diagnosisDetail" name="form_diagnosisDetail" >

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
													<label class="control-label col-md-1" for="prepend" style="">지표버전</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" ng-model="measureDetail.pifldid">
										                        <option  ng-repeat="option in field" value="{{option.pifldid}}">{{option.pifldnm}}</option>
										                    </select>
										                </div>
										            </div>  
										            <label class="control-label col-md-1" for="prepend" style="">기준년도</label>
										            <div class="col-md-1" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="measureDetail.msrdtlnm"/>
										                </div>
										            </div>  
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">진단운영</label>
													<div class="col-md-6" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="measureDetail.msrdtlnm"/>
										                </div>
										            </div>    
													<label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
													<div class="col-md-1" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <input type="text" class="form-control" ng-model="measureDetail.sortby"/>
										                </div>
										            </div> 
												</div>
											</fieldset>
											
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend" style="">실적기간</label>
													<div class="col-md-2" style="padding-right: 1px;;">
														<div class="form-group">
															<div class="input-group">
																<input class="form-control" id="from" type="text" placeholder="From">
																<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
															</div>
														</div>
													</div> 	
										            <label class="control-label col-md-1" for="prepend" style="">~</label>
													<div class="col-md-2" style="padding-right: 1px;;">
										                <div class="form-group">
															<div class="input-group">
																<input class="form-control" id="to" type="text" placeholder="Select a date">
																<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
															</div>
														</div>
										            </div> 
												</div>
											</fieldset>	 
											
									</div>
								</div>
							</div>
						</article>
    </div><!-- end of row   -->
    <div id="buttonContent" style="width:100%;">
		<a class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;" onclick="javascript:closeEditDiagnosis();" >닫기</a>
		<a id="btn_insert" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('insertDetail');">저장하기</a>
		
		<a id="btn_delete" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('deleteDetail');">삭제하기</a>
		<a id="btn_update" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('updateDetail');">수정하기</a>
		
	</div>
</section>


</form>

</div>



    <script type="text/javascript">
	    function popInit() {
	    	pageSetUp();
	    	
		 // Date Range Picker
			$("#from").datepicker({
			    defaultDate: "+1w",
			    changeMonth: true,
			    numberOfMonths: 3,
			    prevText: '<i class="fa fa-chevron-left"></i>',
			    nextText: '<i class="fa fa-chevron-right"></i>',
			    onClose: function (selectedDate) {
			        $("#to").datepicker("option", "maxDate", selectedDate);
			    }
		
			});
			$("#to").datepicker({
			    defaultDate: "+1w",
			    changeMonth: true,
			    numberOfMonths: 3,
			    prevText: '<i class="fa fa-chevron-left"></i>',
			    nextText: '<i class="fa fa-chevron-right"></i>',
			    onClose: function (selectedDate) {
			        $("#from").datepicker("option", "minDate", selectedDate);
			    }
			});
	    }
    </script>

    
    
    
