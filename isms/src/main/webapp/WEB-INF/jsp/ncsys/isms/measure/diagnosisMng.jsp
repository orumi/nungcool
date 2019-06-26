<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<style>
		
			.ui-jqgrid .ui-jqgrid-htable th {
			    background-color: #403f3d;
			    color: #ddd;
			    background-image: none !important;;
			    
			}
			
			.overlay {position: absolute; top: 0; right: 0; bottom: 0; left: 0; z-index: 999; background: #eaeaea; opacity: 1.0; -ms- filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=30)"; } 
            .popup {position: absolute; top: 8px; left: 0%; z-index: 999999; width: 98%;}
		
		</style>
  
 
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>
		
		<script type="text/javascript">
		var diagnosisInitURL       = "<c:url value='/diagnosis/diagnosisInit.json'/>";
		
		var diagnosisDetailURL     = "<c:url value='/diagnosis/diagnosisDetail.json'/>";
		var diagnosisListURL           = "<c:url value='/diagnosis/diagnosisList.json'/>";
		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/measure/diagnosisMngModule.js'/>"></script>
	
	 
<!-- MAIN CONTENT -->
<div class="wrap" id="diagnosisMngApp" ng-app="diagnosisMngApp" ng-controller="diagnosisMngController">
<div id="content" >
				<!-- LIST CONTENT -->
				<form class="form-horizontal" id="form_list" name="form_list">
				<!-- widget grid -->
				<section id="widget-base" class="" >

					<!-- row --> 
					<div class="row">

						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

							<div class="jarviswidget" id="wid-id-1" >								

								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>진단운영 관리</h2>
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
													<label class="control-label col-md-1" for="prepend">진단운영</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selDiagnosis" ng-model="dgsid" >
										                    	<option ng-repeat="option in diagnosis" value="{{option.dgsid}}">{{option.dgsname}}</option>
										                    </select>
										                </div>
										            </div>   

													<div class="col-md-1" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-default" style="width:68px;" onclick="javascript:reloadGrid();">
															조 회
														</a>
													</div>
													
										            <div class="col-md-3" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-success" ng-click="setClearDetail();">
															<i class="fa fa-check-square-o"></i>
															운영관리
														</a>
														<a class="btn btn-primary" style="width:106px;" ng-click="actionSaveWgt();">
															가중치 저장
														</a>
													</div> 

												</div>
											</fieldset>
											
											
											<legend></legend>
											
											<div id="jqgridContent" style="" >
											    <table id="jqgrid"><tr><td /></tr></table>
											    <div id="pjqgrid"></div>
											</div>

											
											
									</div>
									<!-- end widget content -->
									
								</div>
								<!-- end widget div-->
								
												
							</div>

						</article>
						<!-- WIDGET END -->

					</div>

				</section>
				<!-- end widget grid -->
				
				
				</form>


				<div class="" id="div_detail" name="div_detail" style="display: none;">
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
															                    <select  class="form-control" ng-model="diagnosisDetail.piversionid">
															                        <option  ng-repeat="option in versions" value="{{option.piverid}}">{{option.pivernm}}</option>
															                    </select>
															                </div>
															            </div>  
															            <label class="control-label col-md-1" for="prepend" style="">기준년도</label>
															            <div class="col-md-1" style="padding-right: 1px;;">
															                <div class="icon-addon addon-md" >
															                    <select  class="form-control" id="selYear" ng-model="diagnosisDetail.year" >
															                    	<option ng-repeat="option in years" value="{{option}}">{{option}}</option>
										                    					</select>
															                </div>
															            </div>  
																	</div> 
																</fieldset>
																<fieldset>
																	<div class="form-group">
																		<label class="control-label col-md-1" for="prepend" style="">진단운영</label>
																		<div class="col-md-6" style="padding-right: 1px;;">
															                <div class="icon-addon addon-md" >
															                    <input type="text" class="form-control" ng-model="diagnosisDetail.dgsname"/>
															                </div>
															            </div>    
																		<label class="control-label col-md-1" for="prepend" style="">정렬순서</label>
																		<div class="col-md-1" style="padding-right: 1px;;">
															                <div class="icon-addon addon-md" >
															                    <input type="text" class="form-control" ng-model="diagnosisDetail.sortby"/>
															                </div>
															            </div> 
																	</div>
																</fieldset>
																
																
																<fieldset>
																	<div class="form-group">
																		<label class="control-label col-md-1" for="prepend" style="">실적기간</label>
																		<div class="col-md-2" style="padding-right: 1px;;">
																				<div class="input-group">
																					<input class="form-control" id="from" type="text" ng-model="diagnosisDetail.begindt" placeholder="실적시작">
																					<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
																				</div>
																		</div> 	
															            <label class="control-label col-md-1" for="prepend" style="">~</label>
																		<div class="col-md-2" style="padding-right: 1px;;">
																				<div class="input-group">
																					<input class="form-control" id="to" type="text" ng-model="diagnosisDetail.enddt" placeholder="실적종료">
																					<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
																				</div>
															            </div> 
																	</div>
																</fieldset>	
																
																<fieldset style="margin-top: 14px;">
																	<div class="table-responsive" style="height:35px;overflow-y: scroll;overflow-x:hidden; ">
																		<table class="table table-bordered" style="height:35px;">
																			<thead>
																				<tr>
																					<th style="width:10%">기준년도</th>
																					<th style="width:30%">진단운영</th>
																					<th style="width:25%">실적시작</th>
																					<th style="width:25%">실적종료</th>
																					<th style="width:10%">정렬순서</th>
																				</tr>
																			</thead>
																		</table>	
																	</div>		
																	<div class="table-responsive" style="height:200px;overflow-y: scroll;overflow-x:hidden; margin-bottom: 20px; ">		
																		<table class="table table-bordered">	
																			<tbody>
																				<tr ng-repeat="dgn in diagnosis" style="cursor: pointer;" >
																					<td ng-click="actionShowDiagonsis(dgn)" style="width:10%">{{dgn.year}}</td>
																					<td ng-click="actionShowDiagonsis(dgn)" style="width:30%">{{dgn.dgsname}}</td>
																					<td ng-click="actionShowDiagonsis(dgn)" style="width:25%">{{dgn.begindt}}</td>
																					<td ng-click="actionShowDiagonsis(dgn)" style="width:25%">{{dgn.enddt}}</td>
																					<td ng-click="actionShowDiagonsis(dgn)" style="width:10%">{{dgn.sortby}}</td>
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
					    <div id="buttonContent" style="width:100%;">
							<a class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;" onclick="javascript:closeEditDiagnosis();" >닫기</a>
							<a id="btn_insert" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('insertDetail');">저장하기</a>
							
							<a id="btn_delete" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('deleteDetail');">삭제하기</a>
							<a id="btn_update" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('updateDetail');">수정하기</a>
							
							<a id="btn_reset" class="btn btn-danger pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('resetDetail');">초기화</a>
							
						</div>
					</section>
					
					
					</form>
			   	</div>


</div>
</div>
<!-- END MAIN CONTENT -->


    <script type="text/javascript">
       $(document).ready(function() {
			'use strict';

			var arrtSetting = function (rowId, val, rawObject, cm) {
                          var attr = rawObject.attr[cm.name], result;
                          if (attr.rowspan) {
                              result = ' rowspan=' + '"' + attr.rowspan + '"';
                          } else if (attr.display) {
                              result = ' style="display:' + attr.display + '"';
                          }
                          return result;
            };
        
            $("#jqgrid").jqGrid({
                url : diagnosisListURL,
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "dgsid":function() { return $("#selDiagnosis").val(); } } ,
                colNames: ['순번','분야', '진단지표', '진단항목', '가중치'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
                    { name: 'pifldnm', width: "10%", align: 'left', cellattr: arrtSetting },
                    { name: 'msrname', width: "20%", align: 'left', cellattr: arrtSetting },
                    { name: 'msrdtlnm', width: "30%" },
                    { name: 'msrdtlid', sortable : false, resizable:false,width:"10%", align: "center", formatter:editFormatter},
                ],
                cmTemplate: {sortable: false},
                //rowNum: 10,
                //rowList: [5, 10, 20],
                //pager : jQuery('#pjqgrid'),
                loadtext : ' 로딩중..',
                gridview: true,
                hoverrows: false,
                autoencode: true,
                autowidth: true,
                ignoreCase: true,
                viewrecords: true,
                height: '100%',
                caption : "통제목록 정보",
                rowNum  : 10000,
                beforeSelectRow: function () {
                    return false;
                },
                jsonReader: {  
	                root : 'diagnosisList',  
	                id   : 'msrdtlid', 
/* 	                page : 'pageMaker.cri.crtPage',
	                total: 'pageMaker.endPage',
	                records: 'pageMaker.totCnt', */
	                repeatitems: true  
	            },
	            gridComplete : function() {
					$("#jqgrid").jqGrid('setGridWidth', $("#jqgridContent").width()-5);
                }
            });
            
            
            function editFormatter(cellValue, options, rowObject){
            	var edit = "<input type='text' name='txtWgt' id='"+cellValue+"' style='width:100%;text-align: right;' value='"+rowObject.weight+"'>";
            	return edit;
            }
            
            
         // remove classes
			$(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
			$(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
			$(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
			$(".ui-jqgrid-pager").removeClass("ui-state-default");
			$(".ui-jqgrid").removeClass("ui-widget-content");

			// add classes
			$(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
			$(".ui-jqgrid-btable").addClass("table table-bordered table-striped");

			
			$("#selDiagnosis").change(function(){ reloadGrid(); });
			
			
			// KR language callendar
			$.datepicker.regional['kr'] = {
			    closeText       : '닫기', // 닫기 버튼 텍스트 변경
			    currentText     : '오늘', // 오늘 텍스트 변경
			    monthNames      : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 개월 텍스트 설정
			    monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 개월 텍스트 설정
			    dayNames        : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'], // 요일 텍스트 설정
			    dayNamesShort   : ['월','화','수','목','금','토','일'],   // 요일 텍스트 축약 설정&nbsp;   
			    dayNamesMin     : ['월','화','수','목','금','토','일'],   // 요일 최소 축약 텍스트 설정
			    yearSuffix: '년 ',
			    showMonthAfterYear: true,
			    dateFormat      : 'yy/mm/dd' // 날짜 포맷 설정
			};

			// Seeting up default language, Korean
			$.datepicker.setDefaults($.datepicker.regional['kr']);
			
			 // Date Range Picker
			$("#from").datepicker({
			    changeMonth: true,
			    changeYear: true,
			    prevText: '<i class="fa fa-chevron-left"></i>',
			    nextText: '<i class="fa fa-chevron-right"></i>',
			    onClose: function (selectedDate) {
			        $("#to").datepicker("option", "minDate", selectedDate);
			    }
		
			});
			 
			$("#to").datepicker({
			    changeMonth: true,
			    changeYear: true,
			    prevText: '<i class="fa fa-chevron-left"></i>',
			    nextText: '<i class="fa fa-chevron-right"></i>',
			    onClose: function (selectedDate) {
			        $("#from").datepicker("option", "maxDate", selectedDate);
			    }
			});
			
        });

		$(window).on('resize.jqGrid', function() {
			$("#jqgrid").jqGrid('setGridWidth', $("#jqgridContent").width()-5);
		})

		function reloadGrid(){
			$("#jqgrid").jqGrid('setGridParam',{
				datatype: 'json',
			 });
			$("#jqgrid").trigger("reloadGrid");
		}
		
	    
		function actionEditDiagnosis(){
			$("#form_list").hide();
			$("#div_detail").show();
			
    	   	var scope = angular.element(document.getElementById("diagnosisMngApp")).scope();

    	   	scope.setClearDetail();
		}
		
		function closeEditDiagnosis(){
			$("#form_list").show();
	    	$("#div_detail").hide();
    	   
		}
		
    </script>




