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

		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/> ">
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/css/fileupload/jquery.fileupload.css'/> ">
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/css/fileupload/jquery.fileupload-ui.css'/> ">
		 
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>
		
		<script type="text/javascript">
		var initInfoURL = "<c:url value='/actualPimes/initInfo.json'/>";
		var selectDiagnosisListURL = "<c:url value='/actualPimes/selectDiagnosisList.json'/>";
		var actualDetailURL = "<c:url value='/actualPimes/actualDetail.json'/>";
		
		var uploadFileURL = "<c:url value='/actualPimes/uploadFile.json'/>";
		var deleteFileURL = "<c:url value='/actualPimes/deleteFile.json'/>";
		
		var attachURL = "<c:url value='/cmm/fms/AttachFileDown.do'/>";
		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/actual/actualPimesModule.js'/>"></script>
	
	
<!-- MAIN CONTENT -->
<div class="wrap" id="actualPimesApp" ng-app="actualPimesApp" ng-controller="actualPimesController">
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
									<h2>진단자료 등록</h2>
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
													<label class="control-label col-md-1" for="prepend">진단운영</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select class="form-control" id="selDiagnosis" ng-model="selDiagnosis">
										                        <option  ng-repeat="option in diagnosis" value="{{option.dgsid}}">{{option.dgsname}}</option>
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
        
            $("#jqgrid").jqGrid({
                url : 'selectDiagnosisList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "year":function() { return angular.element(document.getElementById("actualPimesApp")).scope().selYear.value; }, "dgsid":function() { return $("#selDiagnosis").val(); } },
            	colNames: ['순번','분야', '진단지표', '진단항목', '가중치', '등록', '진척율', '양식','실적','취합'],
                colModel: [
       					{ name: 'rowidx',   width: "5%",  align: 'center' },
                        { name: 'pifldnm',  width: "10%", align: 'left', cellattr: arrtSetting },
                        { name: 'msrname',  width: "20%", align: 'left', cellattr: arrtSetting },
                        { name: 'msrdtlnm', width: "30%" },
                        { name: 'weight',   width:"5%", align: "right" },
                        { name: 'msrdtlid', sortable : false, width:"5%", align: "center", formatter:btnFormatter },
                        { name: 'actual', width: "5%", align: 'right', formatter:scrFormatter  },
                        { name: 'cntpln', width: "5%", align: 'right'},
	                    { name: 'cntact', width: "5%", align: 'right'},
	                    { name: 'cntagg', width: "5%", align: 'right'},
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
	                root : 'actualPimesList',  
	                id   : 'rgldtlid', 
/* 	                page : 'pageMaker.cri.crtPage',
	                total: 'pageMaker.endPage',
	                records: 'pageMaker.totCnt', */
	                repeatitems: true  
	            },
	            gridComplete : function() {
					$("#jqgrid").jqGrid('setGridWidth', $("#jqgridContent").width());
                }
            });
            
            
            function btnFormatter(cellValue, options, rowObject){
            	
            	//var colNm = options.colModel.name;
            	var writer = "";
            	if(rowObject.weight > 0){
            		writer = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:actionEditActual('" + rowObject.dgsid + "','" + rowObject.msrdtlid + "','C');\"><i class='fa fa-pencil'></i> </div>";
            	}
            	return writer;
            }
            
            function scrFormatter(cellValue, options, rowObject){
            	
            	var colNm = options.colModel.name;
            	
            	var writer = "";
            	
            		
           		if(cellValue!=""){
           			if(cellValue >=80 ){
           				writer = "<div class='btn btn-default score_green' data-original-title='Edit Row' onclick=\"javascript:actionEditActual('" + rowObject.dgsid + "','" + rowObject.msrdtlid + "','C');\">"+cellValue+"</div>";
           			} else if (cellValue >=60) {
           				writer = "<div class='btn btn-default score_yellow' data-original-title='Edit Row' onclick=\"javascript:actionEditActual('" + rowObject.dgsid + "','" + rowObject.msrdtlid + "','C');\">"+cellValue+"</div>";
           			} else {
           				writer = "<div class='btn btn-default score_red' data-original-title='Edit Row' onclick=\"javascript:actionEditActual('" + rowObject.dgsid + "','" + rowObject.msrdtlid + "','C');\">"+cellValue+"</div>";
           			}
           		} else {
           			if(rowObject.weight > 0){
           				writer = ""+"-"+"";
           			} else {
           				
           			}
           		}
            	
            	return writer;
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
			$("#selYear").change(function(){ $("#jqgrid").jqGrid('clearGridData'); (angular.element(document.getElementById("actualPimesApp")).scope()).selectInitInfo(); });
			
        });

		$(window).on('resize.jqGrid', function() {
			$("#jqgrid").jqGrid('setGridWidth', $("#jqgridContent").width());
		})

		function reloadGrid(){
			
			if( $("#selDiagnosis").val() > 0 ){
				$("#jqgrid").jqGrid('setGridParam',{
					datatype: 'json',
				 });
				$("#jqgrid").trigger("reloadGrid");
			}
		}
		function actionEditActual(dgsid, msrdtlid, crud){
            
			$("#form_list").hide();
			$("#div_detail").show();
  	   
			$(".wrap").after("<div class='overlay'></div>");
			
			var scope = angular.element(document.getElementById("actualPimesApp")).scope();
			
			scope.actionSelectDetail(dgsid, msrdtlid);

      	} 
		
		function actionClose(){
    	   	$("#form_list").show();
	    	$("#div_detail").hide();
    	   
    	   	$(".overlay").remove();
    	   	
    	   	reloadGrid();
    	   	//$("#jqgrid").jqGrid('setGridWidth', $("#jqgridContent").width());
		}
	       
		
    </script>



