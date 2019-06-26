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
		var assetInitURL = "<c:url value='/asset/assetInit.json'/>";
		
 		var assetDetailURL = "<c:url value='/asset/assetDetail.json'/>";
		var assetVersionURL = "<c:url value='/asset/assetVersion.json'/>";
		
		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/asset/assetMngModule.js'/>"></script>
	
<!-- MAIN CONTENT -->
<div class="wrap" id="assetMnglApp" ng-app="assetMngApp" ng-controller="assetMngController">
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
									<h2>자산등록 관리</h2>
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
													<label class="control-label col-md-2" for="prepend">자산관리버전</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selVersion" ng-model="entity.selAstVerId" >
										                    	<option ng-repeat="option in entity.selAstVers" value="{{option.astverid}}">{{option.astvernm}}</option>
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
													<label class="control-label col-md-2" for="prepend">자산구분 </label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selAstGroup" ng-model="entity.selAstGrpId">
										                    	<option  value="0">::전체::</option>
										                        <option  ng-repeat="option in entity.selAstGrps" value="{{option.astgrpid}}">{{option.astgrpnm}}</option>
										                    </select>
										                </div>
										            </div>    
										            <div class="col-md-1" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-primary" style="width:68px;" onclick="javascript:reloadGrid();">
															조 회
														</a>
													</div>
													<div class="col-md-1" style="padding-left:0px;">    
										                <a class="btn btn-primary" style="width:88px;" onclick="javascript:actionEdit(0);">
															자산 등록
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
 					<popup-asset-detail></popup-asset-detail>
			   	</div>

				<div class="" id="div_version" name="div_version" style="display: none;">
					<popup-asset-version></popup-asset-version>
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
                url : 'assetList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "astverid":function() { return $("#selVersion").val(); },"astgrpid":function() { return $("#selAstGroup").val(); } },
                colNames: ['순번','자산구분', '관리번호', '자산명(호스트)', '설명','자산번호', '편집','C','I','A','인증대상','위약점대상','정렬순서'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
                    { name: 'astgrpnm', width: "10%", align: 'center' },
                    { name: 'mgnno', width: "20%", align: 'center'},
                    { name: 'assetnm', width: "20%" },
                    { name: 'assetdfn', width: "20%"},
                    { name: 'astno', width: "20%" },
                    { name: 'assetid', sortable : false, resizable:false,width:"10%", align: "center", formatter:btnFormatter },
                    { name: 'imptc', width: "5%", align: 'center' },
                    { name: 'impti', width: "5%", align: 'center' },
                    { name: 'impta', width: "5%", align: 'center' },
                    { name: 'certiyn', width: "10%" },
                    { name: 'wktstyn', width: "10%" },
                    { name: 'sortby', width: "10%" }
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
	                root : 'reAssetList',  
	                id   : 'assetid', 
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
			$("#selAstGroup").change(function(){ reloadGrid(); });
			
			
		// end of document ready	
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
		
		function actionEdit(assetid){
			$("#form_list").hide();
			$("#div_detail").show();
  	   
			$(".wrap").after("<div class='overlay'></div>");
			
			//version
			//console.log($("#selVersion").text());
			$("#txtVersion").val($("#selVersion option:selected").text());
			
			var scope = angular.element(document.getElementById("assetMnglApp")).scope();
			  
			if(assetid != 0){
				scope.actionSelectDetail(assetid);
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
	       
		function actionEditVersion(){
			$("#form_list").hide();
			$("#div_version").show();
			
			$(".wrap").after("<div class='overlay'></div>");
			
			//clear
    	   	var scope = angular.element(document.getElementById("assetMnglApp")).scope();
    	   	scope.entity.selAstVer = null;
    	   	scope.$apply();
	    	   
			$("#btn_insert_version").show();
    	   	$("#btn_update_version").hide();
    	   	$("#btn_delete_version").hide();
		}
		
		function closeEditVersion(){
			$("#form_list").show();
	    	$("#div_version").hide();
    	   
    	   	$(".overlay").remove();
    	   	
    	   	resizeGrid();
		}
		
    </script>




