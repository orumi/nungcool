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
		var regulationDetialInfoURL = "<c:url value='/hierarchy/regulationDetialInfo.json'/>";
		var certiDetailURL = "<c:url value='/certification/certiDetail.json'/>";
		var regulationFieldURL = "<c:url value='/hierarchy/regulationField.json'/>";
		var regulationURL = "<c:url value='/hierarchy/regulation.json'/>";
		var versionURL = "<c:url value='/hierarchy/version.json'/>";
		  
		var commonCdURL = "<c:url value='/certification/commonCd.json'/>";
		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/certification/certiManageModule.js'/>"></script>
	
	
<!-- MAIN CONTENT -->
<div class="wrap" id="certiMngApp" ng-app="certiMngApp" ng-controller="certiMngController">
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
 					<popup-certi-detail></popup-certi-detail>
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
                url : 'certiList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "versionId":function() { return $("#selVersion").val(); }, "fieldId":function() { return $("#selField").val(); }  },
                colNames: ['순번','분야', '통제항목', 'ISMS기준', '기준추가','수행자료[계획]', '수정', '수행주기','구분'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
                    { name: 'fldnm', width: "10%", align: 'center', cellattr: arrtSetting },
                    { name: 'rgldtlnm', width: "20%", align: 'center', cellattr: arrtSetting },
                    { name: 'ismsstd', width: "20%", cellattr: arrtSetting },
                    { name: 'rgldtlid', width:"10%", cellattr: arrtSetting, sortable : false, resizable:false, align: 'center', formatter:btnFormatter},
                    { name: 'proofitem', width: "20%" },
                    { name: 'proofid', width: "10%", sortable : false, resizable:false, align: "center", formatter:btnFormatterEdit },
                    { name: 'frequency', width: "5%" },
                    { name: 'proe', width: "5%" }
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
	                root : 'certiList',  
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
            	var btn = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:actionAddItem('" + cellValue + "');\"><i class='fa fa-pencil'></i> 자료추가</div>";
            	
            	return btn;
            }
            function btnFormatterEdit(cellValue, options, rowObject){
            	
            	var btn = "";
            	if(cellValue!=""){
            		btn = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:actionEditItem('" + rowObject.rgldtlid + "','" + cellValue + "');\"><i class='fa fa-pencil'></i> 수정</div>";
            	}
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
		
		function actionAddItem(rgldtlid){
            
			$("#form_list").hide();
			$("#div_detail").show();
  	   
			$(".wrap").after("<div class='overlay'></div>");
			
			var scope = angular.element(document.getElementById("certiMngApp")).scope();
			
			scope.actionSelectDetail(rgldtlid, 0);
			$("#btn_insert").show();
			$("#btn_update").hide();
			$("#btn_delete").hide();

      	}
		
		function actionEditItem(rgldtlid, itemSeq){
            
			$("#form_list").hide();
			$("#div_detail").show();
  	   
			$(".wrap").after("<div class='overlay'></div>");
			
			var scope = angular.element(document.getElementById("certiMngApp")).scope();

			scope.actionSelectDetail(rgldtlid, itemSeq);
			$("#btn_insert").hide();
			$("#btn_update").show();
			$("#btn_delete").show();
      	}
		
		function actionClose(){
    	   	$("#form_list").show();
	    	$("#div_detail").hide();
    	   
    	   	$(".overlay").remove();
    	   	
    	   	resizeGrid();
    	   	
		}
	       
		
    </script>




