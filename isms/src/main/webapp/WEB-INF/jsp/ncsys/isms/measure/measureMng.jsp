<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<sec:csrfMetaTags />
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
		var measureDetailInfoURL = "<c:url value='/measure/measureDetialInfo.json'/>";
		var measureDetailURL     = "<c:url value='/measure/measureDetial.json'/>";
		var measureFieldURL   = "<c:url value='/measure/measureField.json'/>";
		var measureURL        = "<c:url value='/measure/measure.json'/>";
		var versionURL        = "<c:url value='/measure/version.json'/>";

		var header = $("meta[name='_csrf_header']").attr("content");
		var token = $("meta[name='_csrf']").attr("content");


		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/measure/measureMngModule.js'/>"></script>


<!-- MAIN CONTENT -->
<div class="wrap" id="measureMngApp" ng-app="measureMngApp" ng-controller="measureMngController">
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
									<h2>진단지표항목 관리</h2>
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
													<label class="control-label col-md-1" for="prepend">지표버전</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selVersion" ng-model="piverid" >
										                    	<option ng-repeat="option in version" value="{{option.piverid}}">{{option.pivernm}}</option>
										                    </select>
										                </div>
										            </div>
										            <div class="col-md-1" style="padding-left:0px;">
										                <a type="submit" class="btn btn-default" onclick="javascript:actionEditVersion();">
															...
														</a>
													</div>
												</div>
											</fieldset>
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend">분야 </label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select class="form-control" id="selField">
										                        <option  value="0">::전체::</option>
										                        <option  ng-repeat="option in field" value="{{option.pifldid}}">{{option.pifldnm}}</option>
										                    </select>
										                </div>
										            </div>
										            <div class="col-md-1" style="padding-left:0px;">
										                <a type="submit" class="btn btn-primary" style="width:68px;" onclick="javascript:reloadGrid();">
															조 회
														</a>
													</div>
													<div class="col-md-1" style="padding-left:0px;">
										                <a class="btn btn-primary" style="width:108px;" onclick="javascript:actionEdit(0);">
															지표항목 등록
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
 					<popup-measure-detail></popup-measure-detail>
			   	</div>

				<div class="" id="div_version" name="div_version" style="display: none;">
					<popup-measure-version></popup-measure-version>
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

            /* csrf */
            $.ajaxSetup({
			    headers : {
			    	'X-CSRF-TOKEN': token
			    }
			});


            $("#jqgrid").jqGrid({
                url : 'measureDetialList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "versionId":function() { return $("#selVersion").val(); }, "fieldId":function() { return $("#selField").val(); }  },
                colNames: ['순번','분야', '진단지표', '진단항목', '편집'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
                    { name: 'pifldnm', width: "10%", align: 'left', cellattr: arrtSetting },
                    { name: 'msrname', width: "20%", align: 'left', cellattr: arrtSetting },
                    { name: 'msrdtlnm', width: "30%" },
                    { name: 'msrdtlid', sortable : false, resizable:false,width:"10%", align: "center", formatter:btnFormatter},
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
	                root : 'measureList',
	                id   : 'rgldtlid',
/* 	                page : 'pageMaker.cri.crtPage',
	                total: 'pageMaker.endPage',
	                records: 'pageMaker.totCnt', */
	                repeatitems: true
	            },
	            gridComplete : function() {
					$("#jqgrid").jqGrid('setGridWidth', $("#jqgridContent").width()-5);
                }
            });


            function btnFormatter(cellValue, options, rowObject){
            	var btn = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:actionEdit('" + cellValue + "');\"><i class='fa fa-pencil'></i> 수정</div>";

            	return btn;
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


			$("#selVersion").change(function(){ reloadGrid(); });
			$("#selField").change(function(){ reloadGrid(); });

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

		function actionEdit(msrdtlid){
			if(oEditors.length !=0 ){
			} else {
				createEditArea();
				createEditArea2();
			}

			$("#form_list").hide();
			$("#div_detail").show();

			$(".wrap").after("<div class='overlay'></div>");

			//version
			console.log("selected Version : "+$("#selVersion").text());
			$("#txtVersion").val($("#selVersion option:selected").text());

			var scope = angular.element(document.getElementById("measureMngApp")).scope();

			if(msrdtlid != 0){
				scope.actionSelectDetail(msrdtlid);
				$("#btn_insert").hide();
				$("#btn_update").show();
				$("#btn_delete").show();
			} else {
				//set clear;
				scope.setClearDetail();
				$("#btn_insert").show();
				$("#btn_update").hide();
				$("#btn_delete").hide();
			}

      	}

		function actionClose(){
    	   	$("#form_list").show();
	    	$("#div_detail").hide();

    	   	$(".overlay").remove();
		}

		function actionEditVersion(){
			$("#form_list").hide();
			$("#div_version").show();

			$(".wrap").after("<div class='overlay'></div>");

			//clear
    	   	var scope = angular.element(document.getElementById("measureMngApp")).scope();
    	   	scope.selVersion = null;
    	   	scope.$apply();

			$("#btn_insert_version").show();
    	   	$("#btn_update_version").hide();
    	   	$("#btn_delete_version").hide();
		}

		function closeEditVersion(){
			$("#form_list").show();
	    	$("#div_version").hide();

    	   	$(".overlay").remove();
		}

    </script>




