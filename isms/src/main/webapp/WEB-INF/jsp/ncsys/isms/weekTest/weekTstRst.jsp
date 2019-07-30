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

		<!-- <script type="text/javascript" language="javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script> -->

		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>

		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>

		<script type="text/javascript">
		var weekTstRstInitURL = "<c:url value='/weekTest/weekTestItemRstInit.json'/>";
		var weekTstFieldRstURL = "<c:url value='/weekTest/weekTestItemFieldRstList.json'/>";

		var header = $("meta[name='_csrf_header']").attr("content");
		var token = $("meta[name='_csrf']").attr("content");


		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/weekTest/weekTestRstModule.js'/>"></script>

<!-- MAIN CONTENT -->
<div class="wrap" id="weekTestRstApp" ng-app="weekTestRstApp" ng-controller="weekTestRstController">
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
									<h2>기술취약점 결과 조회</h2>
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
													<label class="control-label col-md-1" for="prepend">체계버전</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selVersion" ng-model="entity.selAstVerid" >
										                    	<option ng-repeat="option in entity.selAstVers" value="{{option.astverid}}">{{option.astvernm}}</option>
										                    </select>
										                </div>
										            </div>
										            <div class="col-md-1" style="padding-left:0px;">
										                <a type="submit" id="btnSubmit" class="btn btn-primary" style="width:68px;" >
															조 회
														</a>
													</div>
													<!-- <div class="col-md-1" style="padding-left:0px;">
										                <a type="submit" id="btnExportExcel" class="btn btn-primary" style="width:68px;" >
															엑셀 출력
														</a>
													</div>   -->
												</div>
											</fieldset>


											<legend></legend>

											<div id="jqgridContentAst" style="" >
											    <table id="jqgridAst"><tr><td /></tr></table>
											    <div id="pjqgridAst"></div>
											</div>
											<div id="jqgridContentField" style="    margin-top: 12px;" >
											    <table id="jqgridField"><tr><td /></tr></table>
											    <div id="pjqgridField"></div>
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
 					<popup-regulation-detail></popup-regulation-detail>
			   	</div>

				<div class="" id="div_version" name="div_version" style="display: none;">
					<popup-regulation-version></popup-regulation-version>
			   	</div>


</div>
</div>
<!-- END MAIN CONTENT -->


    <script type="text/javascript">
       $(document).ready(function() {
			'use strict';


			/* csrf */
            $.ajaxSetup({
			    headers : {
			    	'X-CSRF-TOKEN': token
			    }
			});

            $("#jqgridAst").jqGrid({
                url : 'weekTestItemAstRstList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "astverid":function() { return $("#selVersion").val(); }  },
                colNames: ['구분','구분별점검항목', '장비대수', '총점검항목', '양호','취약', 'N/A', '평균점수'],
                colModel: [
					{ name: 'astgrpnm', width: "20%", align: 'left' },
                    { name: 'cntitem', index:'cntitem', width: "10%", align: 'right' },
                    { name: 'astcnt', width: "10%", align: 'right' },
                    { name: 'tcnt', width: "10%", align: 'right' },
                    { name: 'gcnt', width: "10%", align: 'right' },
                    { name: 'wcnt', width: "10%", align: 'right' },
                    { name: 'nacnt', width: "10%", align: 'right' },
                    { name: 'tstavg', width: "10%", align: 'right', formatter:percentFormatter }
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
                footerrow: true,
                userDataOnFooter : true,
                caption : "장비별 보안지수 [수량]",
                rowNum  : 10000,
                beforeSelectRow: function () {
                    return false;
                },
                jsonReader: {
	                root : 'reWeekTestAstRst',
	                id   : 'astgrpid',
	                repeatitems: true
	            },
	            gridComplete : function() {
	            	var cntitem_sum = $("#jqgridAst").jqGrid('getCol','cntitem', false, 'sum');
	            	var tstavg_avg = $("#jqgridAst").jqGrid('getCol','tstavg', false, 'avg').toFixed(2);


					$("#jqgridAst").jqGrid('setGridWidth', $("#jqgridContentAst").width()-5);

					$('#jqgridAst').jqGrid('footerData', 'set', { astgrpnm:'합계', cntitem:cntitem_sum, tstavg:tstavg_avg});

                }
            });

            $("#jqgridField").jqGrid({
            	height: '100%',
            	colNames: ['구분','구분별점검항목'],
                colModel: [
					{ name: 'astgrpnm', width: "10%", align: 'left' },
                    { name: 'cntitem', width: "10%", align: 'right' },
                ],
                loadtext : ' 로딩중..',
                gridview: true,
                hoverrows: false,
                autoencode: true,
                autowidth: true,
                ignoreCase: true,
                viewrecords: true,
                gridComplete : function() {
					$("#jqgridField").jqGrid('setGridWidth', $("#jqgridContentField").width()-5);
					$("#jqgridAst").jqGrid('setGridWidth', $("#jqgridContentAst").width()-5);
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

			$("#btnSubmit").click(function(){ reloadGrid(); } )
			$("#btnExportExcel").click(function(){ actionExportExcel(); } )

        });

		$(window).on('resize.jqGrid', function() {
			$("#jqgridAst").jqGrid('setGridWidth', $("#jqgridContentAst").width()-5);
			$("#jqgridField").jqGrid('setGridWidth', $("#jqgridContentField").width()-5);
		})

		function actionExportExcel(){
			createExcelFromGrid("jqgridAst","jqgridAst");
		}

		function reloadGrid(){

			$("#jqgridAst").jqGrid('setGridParam',{
				datatype: 'json',
				}).trigger("reloadGrid");

			var scope = angular.element(document.getElementById("weekTestRstApp")).scope();
			scope.selectWktstFieldRst($("#selVersion").val());
		}

		function percentFormatter(cellValue, options, rowObject){
			if(cellValue) return cellValue+" %";
			else return "";
        }

		function reLoadGridField(){
			$("#jqgridField").jqGrid('GridUnload');
			var scope = angular.element(document.getElementById("weekTestRstApp")).scope();

			var aColModel = new Array();
			var aColNames = new Array();

			aColModel.push({name: 'astgrpnm', width: "20%", align: 'left'});
			aColNames.push('구분');

			$.each(scope.entity.wktstFields, function(idx, object){
				aColNames.push(object.wktstfieldnm);
				aColModel.push({name:object.wktstfieldid, width: "10%", align: 'right', formatter:percentFormatter});
			});

			$("#jqgridField").jqGrid({
            	datatype: 'local',
            	data: scope.entity.wktstFieldRst ,
            	postData : { "astverid":function() { return $("#selVersion").val(); }  },
                colNames: aColNames,
                colModel: aColModel,
                cmTemplate: {sortable: false},
                loadtext : ' 로딩중..',
                gridview: true,
                hoverrows: false,
                autoencode: true,
                autowidth: true,
                ignoreCase: true,
                viewrecords: true,
                footerrow: true,
                userDataOnFooter : true,
                height: '100%',
                rowNum: 1000,
                caption : "분야별 보안지수 [%]",
                rowNum  : 10000,
                beforeSelectRow: function () {
                    return false;
                },
                jsonReader: {
	                root : 'reWeekTestFieldRstList',
	                id   : 'astgrpnm',
	                repeatitems: true
	            },
	            gridComplete : function() {
					$('#jqgridField').jqGrid('footerData', 'set', scope.entity.wktstFieldTotal);

					$("#jqgridField").jqGrid('setGridWidth', $("#jqgridContentField").width()-5);
					$("#jqgridAst").jqGrid('setGridWidth', $("#jqgridContentAst").width()-5);
                }
            });

			$("#jqgridField").trigger("reloadGrid");
		}


/* 		var createExcelFromGrid = function(gridID,filename) {
		    var grid = $('#' + gridID);
		    var rowIDList = grid.getDataIDs();
		    var row = grid.getRowData(rowIDList[0]);
		    var colNames = [];
		    var i = 0;
		    for(var cName in row) {
		        colNames[i++] = cName; // Capture Column Names
		    }
		    var html = "";
		    for(var j=0;j<rowIDList.length;j++) {
		        row = grid.getRowData(rowIDList[j]); // Get Each Row
		        for(var i = 0 ; i<colNames.length ; i++ ) {
		            html += row[colNames[i]] + ';'; // Create a CSV delimited with ;
		        }
		        html += '\n';
		    }
		    html += '\n';

		    var a         = document.createElement('a');
		    a.id = 'ExcelDL';
		    a.href        = 'data:application/vnd.ms-excel;' + html;
		    a.download    = filename ? filename + ".xls" : 'DataList.xls';
		    document.body.appendChild(a);
		    a.click(); // Downloads the excel document
		    document.getElementById('ExcelDL').remove();
		} */

		var createExcelFromGrid = function(gridID,filename) {
			var pGridObj = $("#jqgridField");
		    var mya = pGridObj.getDataIDs();
		    var data = pGridObj.getRowData(mya[0]);
		    var colNames = new Array();
		    var ii=0;
		    for(var d in data){colNames[ii++]=d;}

		    var columnHeader=pGridObj.jqGrid("getGridParam", "colNames")+"";
		    var arrHeader = columnHeader.split(",");
		    var html="<table border=1><tr>";
		    for(var y=1;y<arrHeader.length;y++){
		    	html = html +"<td><b>"+encodeURIComponent(arrHeader[y])+"</b></td>";
		    }

		    html = html+"</tr>";

		    for(var i=0;i<mya.length;i++){
		    	var datac = pGridObj.getRowData(mya[i]);
		    	html = html +"<tr>";
		    	for(var j=0; j< colNames.length; j++) {
		    		html = html+"<td>"+encodeURIComponent(datac[colNames[j]])+"</td>";
		    	}
		    	html = html+"</tr>";
		    }

			html=html+"</table>";


		    /* var a         = document.createElement('a');
		    a.id = 'ExcelDL';
		    a.href        = 'data:application/vnd.ms-excel,' + html;
		    a.download    = filename ? filename + ".xls" : 'DataList.xls';
		    document.body.appendChild(a);
		    a.click(); // Downloads the excel document
		    document.getElementById('ExcelDL').remove(); */


			document.EXCELFORM.csvBuffer.value = html;
			document.EXCELFORM.fileName.value = "exece.xls";
			document.EXCELFORM.target = "_new";

			document.EXCELFORM.submit();

		}



    </script>


    <form id="EXCELFORM" name="EXCELFORM" action="/isms/cmm/fms/gridExcelDown.do" method="">
    	<input type="hidden" name="csvBuffer" id="csvBuffer" value="">
    	<input type="hidden" name="fileName" id="fileName" value="">
    </form>






