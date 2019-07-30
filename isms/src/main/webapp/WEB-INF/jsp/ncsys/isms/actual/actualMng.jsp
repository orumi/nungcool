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

		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/> ">
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/css/fileupload/jquery.fileupload.css'/> ">
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/css/fileupload/jquery.fileupload-ui.css'/> ">

		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>

		<script type="text/javascript">
			var regulationDetialInfoURL = "<c:url value='/hierarchy/regulationDetialInfo.json'/>";
			var actualDetailURL = "<c:url value='/actual/actualDetail.json'/>";
			var regulationFieldURL = "<c:url value='/hierarchy/regulationField.json'/>";
			var regulationURL = "<c:url value='/hierarchy/regulation.json'/>";
			var versionURL = "<c:url value='/hierarchy/version.json'/>";

			var commonCdURL = "<c:url value='/certification/commonCd.json'/>";

			var uploadFileURL = "<c:url value='/actual/uploadFile.json'/>";
			var deleteFileURL = "<c:url value='/actual/deleteFile.json'/>";

			var attachURL = "<c:url value='/cmm/fms/AttachFileDown.do'/>";

			var header = $("meta[name='_csrf_header']").attr("content");
			var token = $("meta[name='_csrf']").attr("content");


		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/actual/actualManageModule.js'/>"></script>


<!-- MAIN CONTENT -->
<div class="wrap" id="actualMngApp" ng-app="actualMngApp" ng-controller="actualMngController">
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
									<h2>점검항목 관리</h2>
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
													<label class="control-label col-md-1" for="prepend">년도</label>
													<div class="col-md-1" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selYear" ng-model="selYear" ng-options="opt.value for opt in years" >
										                    </select>
										                </div>
										            </div>
										            <label class="control-label col-md-1" for="prepend">체계버전</label>
										            <div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selVersion" ng-model="verid" >
										                    	<option ng-repeat="option in version" value="{{option.verid}}">{{option.vernm}}</option>
										                    </select>
										                </div>
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
										                        <option  ng-repeat="option in field" value="{{option.fldid}}">{{option.fldnm}}</option>
										                    </select>
										                </div>
										            </div>
										            <div class="col-md-1" style="padding-left:0px;">
										                <a type="submit" class="btn btn-primary" style="width:68px;" onclick="javascript:reloadGrid();">
															조 회
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
				<!-- DETAIL CONTENT -->
 					<popup-actual-detail></popup-actual-detail>
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
                url : 'actualList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "versionId":function() { return $("#selVersion").val(); }, "fieldId":function() { return $("#selField").val(); },
            		"year":function() { return angular.element(document.getElementById("actualMngApp")).scope().selYear.value; } },
                colNames: ['순번','분야','ISMS기준','수행자료[계획]','수행주기','구분','1','2','3','4','5','6','7','8','9','10','11','12'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
                    { name: 'fldnm', width: "10%", align: 'center', cellattr: arrtSetting },
                    { name: 'ismsstd', width: "20%", cellattr: arrtSetting },
                    { name: 'proofitem', width: "20%" },
                    { name: 'frequency', width: "10%" },
                    { name: 'proe', width: "5%"},
                    { name: 'a01', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a02', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a03', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a04', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a05', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a06', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a07', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a08', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a09', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a10', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a11', width: "5%", align: 'center', formatter:btnFormatter },
                    { name: 'a12', width: "5%", align: 'center', formatter:btnFormatter }
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
                caption : "ISMS인증 기준",
                rowNum  : 10000,
                beforeSelectRow: function () {
                    return false;
                },
                jsonReader: {
	                root : 'actualList',
	                id   : 'rgldtlid',
/* 	                page : 'pageMaker.cri.crtPage',
	                total: 'pageMaker.endPage',
	                records: 'pageMaker.totCnt', */
	                repeatitems: true
	            },
	            gridComplete : function() {
	            	resizeGrid();
                }
            });


            function btnFormatter(cellValue, options, rowObject){

            	var colNm = options.colModel.name;
            	var month = colNm.replace("a","");
            	var frq = rowObject.frequency;

            	var writer = "";

            	if(isWritable(rowObject.frequency,options.colModel.name)){

            		if(cellValue!=""){
            			if(cellValue == 1){
            				writer = "<div class='btn btn-xs btn-default score_green' data-original-title='Edit Row' onclick=\"javascript:actionEditActual('" + rowObject.year + "','" + month + "','" +rowObject.proofid+ "','" +rowObject.rgldtlid+ "','U');\">"+cellValue+"</div>";
            			} else {
            				writer = "<div class='btn btn-xs btn-default score_red' data-original-title='Edit Row' onclick=\"javascript:actionEditActual('" + rowObject.year + "','" + month + "','" +rowObject.proofid+ "','" +rowObject.rgldtlid+ "','U');\">"+cellValue+"</div>";
            			}
            		} else {
            			writer = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:actionEditActual('" + rowObject.year + "','" + month + "','" +rowObject.proofid+ "','" +rowObject.rgldtlid+ "','C');\"><i class='fa fa-pencil'></i>"+cellValue+"</div>";
            		}
            	}

            	return writer;
            }

            function isWritable(frq, mth){
            	if(frq=="월") {
            		return true;
            	} else if (frq=="분기"){
            		if(mth=="a03"||mth=="a06"||mth=="a09"||mth=="a12") return true;
            		else return false;
            	} else if (frq=="반기"){
            		if(mth=="a06"||mth=="a12") return true;
            		else return false;
            	} else if (frq=="년"){
            		if(mth=="a12") return true;
            		else return false;
            	}
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
			$("#selYear").change(function(){ reloadGrid(); });

        });

		$(window).on('resize.jqGrid', function() {
			resizeGrid();
		})

		function resizeGrid(){
			$("#jqgrid").jqGrid('setGridWidth', $("#jqgridContent").width());
		}

		function reloadGrid(){
			$("#jqgrid").jqGrid('setGridParam',{
				datatype: 'json',
			 });
			$("#jqgrid").trigger("reloadGrid");
		}
		function actionEditActual(year,month,proofid,rgldtlid, crud){

			$("#form_list").hide();
			$("#div_detail").show();

			$(".wrap").after("<div class='overlay'></div>");

			var scope = angular.element(document.getElementById("actualMngApp")).scope();

			scope.actionSelectDetail(year,month,proofid,rgldtlid);
			$("#btn_update").show();

			if("C" == crud){
				$("#btn_delete").hide();
			} else {
				$("#btn_delete").show();
			}

      	}

		function actionClose(){
    	   	$("#form_list").show();
	    	$("#div_detail").hide();

    	   	$(".overlay").remove();

    	   	resizeGrid();
		}


    </script>



