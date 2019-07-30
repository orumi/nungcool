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

		var analysisVerInitURL    = "<c:url value='/analysisConcern/analysisVerInit.json'/>";
		var analysisVerDetailURL  = "<c:url value='/analysisConcern/analysisVerDetail.json'/>";


		var header = $("meta[name='_csrf_header']").attr("content");
		var token = $("meta[name='_csrf']").attr("content");

	</script>

	<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
	<script src="<c:url value='/js/ncsys/isms/analysisConcern/analyVerModule.js'/>"></script>

<!-- MAIN CONTENT -->
<div class="wrap" id="analyVerApp" ng-app="analyVerApp" ng-controller="analyVerController">
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
									<h2>위험평가 분석기준</h2>
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

										            <div class="col-md-1" style="padding-left:0px;">
										                <a type="submit" class="btn btn-primary" style="width:68px;" onclick="javascript:reloadGrid();">
															조 회
														</a>
													</div>
													<div class="col-md-1" style="padding-left:0px;">
										                <a class="btn btn-primary" style="width:88px;" onclick="javascript:actionEdit(0);">
															기준 등록
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
 					<popup-analyVer-detail></popup-analyVer-detail>
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
                url : 'analysisVerList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "astgrpid":function() { return $("#selAstGroupId").val(); }},
                colNames: ['분석기준명','관리체계', '법적준거성', '기술위협', '정렬순서', '편집'],
                colModel: [
					{ name: 'analysisnm', width: "10%", align: 'left' },
                    { name: 'vernm', width: "10%", align: 'left' },
                    { name: 'ctrvernm', width: "10%", align: 'left'},
                    { name: 'astvernm', width: "10%", align: 'left' },
                    { name: 'sortby', width: "5%", align: 'right' },
                    { name: 'analysisid', sortable : false, resizable:false,width:"5%", align: "center", formatter:btnFormatter}
                ],
                cmTemplate: {sortable: false},
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
	                root : 'reAnalysisVer',
	                id   : 'analysisid',
	                repeatitems: true
	            },
	            gridComplete : function() {
	            	resizeGrid();
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


			$("#selAstGroupId").change(function(){ reloadGrid(); });

        });

		$(window).on('resize.jqGrid', function() {
			resizeGrid();
		})

		function resizeGrid(){
			$("#jqgrid").jqGrid('setGridWidth', $("#jqgridContent").width()-5);
		}
		function reloadGrid(){
			$("#jqgrid").jqGrid('setGridParam',{
				datatype: 'json',
			 });
			$("#jqgrid").trigger("reloadGrid");
		}

		function actionEdit(analysisid){
			$("#form_list").hide();
			$("#div_detail").show();

			$(".wrap").after("<div class='overlay'></div>");

			var scope = angular.element(document.getElementById("analyVerApp")).scope();

			if(analysisid != 0){
				scope.actionSelectDetail(analysisid);
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

    	   	resizeGrid();
		}

    </script>




