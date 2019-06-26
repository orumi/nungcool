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
		var assetGrpInitURL = "<c:url value='/asset/assetGrpInit.json'/>";
		var assetGrpDetailURL = "<c:url value='/asset/assetGrpDetail.json'/>";
		
		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/asset/assetGrpModule.js'/>"></script>
	
<!-- MAIN CONTENT -->
<div class="wrap" id="assetGrplApp" ng-app="assetGrpApp" ng-controller="assetGrpController">
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
										                <a type="submit" class="btn btn-primary" style="width:68px;" onclick="javascript:reloadGrid();">
															조 회
														</a>
													</div>
													<div class="col-md-1" style="padding-left:0px;">    
										                <a class="btn btn-primary" style="width:140px;" onclick="javascript:actionEdit(0);">
															자산분류 기준 등록
														</a>
													</div>
												</div>
											</fieldset>
											
											
											<legend></legend>
											
											<div id="jqgridDiv" class="col-md-12" style="padding-left:0px; padding-bottom: 32px;">    
												<div id="jqgridContent" style="float:left;" >
												    <table id="jqgrid"><tr><td /></tr></table>
												    <div id="pjqgrid"></div>
												</div>
												<div id="jqgridContentGrp" style="float:left;padding-left:20px;" >
												    <table id="jqgridGrp"><tr><td /></tr></table>
												    <div id="pjqgridGrp"></div>
												</div>
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
 					<popup-assetgrp-detail></popup-assetgrp-detail>
			   	</div>

</div>
</div>
<!-- END MAIN CONTENT -->


    <script type="text/javascript">
       $(document).ready(function() {
			'use strict';

            $("#jqgrid").jqGrid({
                url : 'assetAstCntList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "astverid":function() { return $("#selVersion").val(); } },
                colNames: ['순번','구분', '자산범위', '인증범위대상', '취약점대상'],
                colModel: [
					{ name: 'rowidx', width: "10%", align: 'center' },
                    { name: 'astgrpnm', width: "10%", align: 'center' },
                    { name: 'assetcnt', width: "20%", align: 'center'},
                    { name: 'certicnt', width: "20%" },
                    { name: 'wktstcnt', width: "20%"}
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
	                root : 'reAssetGrpCnt',  
	                id   : 'astgrpkind', 
	                repeatitems: true  
	            },
	            gridComplete : function() {
	            	$("#jqgrid").jqGrid('setGridWidth', 400);
                }
            });
            
            
            var arrtSetting = function (rowId, val, rawObject, cm) {
                var attr = rawObject.attr[cm.name], result;
                if (attr.rowspan) {
                    result = ' rowspan=' + '"' + attr.rowspan + '"';
                } else if (attr.display) {
                    result = ' style="display:' + attr.display + '"';
                }
                return result;
  			};
  
  
            $("#jqgridGrp").jqGrid({
                url : 'assetGrpList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : {  },
                colNames: ['순번','자산분류','구분', '편집','분류 기준','정렬순서'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
					{ name: 'astgrpkindnm', width: "10%", align: 'center', cellattr: arrtSetting },
					{ name: 'astgrpnm', width: "10%", align: 'center' },
                    { name: 'astgrpid', sortable : false, resizable:false,width:"10%", align: "center", formatter:btnFormatter },
                    { name: 'astgrpdfn', width: "30%" },
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
	                root : 'reAssetGroupList',  
	                id   : 'assetgrpid', 
/* 	                page : 'pageMaker.cri.crtPage',
	                total: 'pageMaker.endPage',
	                records: 'pageMaker.totCnt', */
	                repeatitems: true  
	            },
	            gridComplete : function() {
	            	gridReSize();
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

			
			$("#selVersion").change(function(){ reload(); });
			
			
		// end of document ready	
        });
       

		$(window).on('resize.jqGrid', function() {
			gridReSize();
		})

		function gridReSize(){
			$("#jqgridGrp").jqGrid('setGridWidth', $("#jqgridDiv").width()-420);
		}
		
		
		function reload(){
			reloadGrid();
			reloadGridGrp();
		}
		
		function reloadGrid(){
			$("#jqgrid").jqGrid('setGridParam',{
				datatype: 'json',
			 });
			$("#jqgrid").trigger("reloadGrid");
		}
		
		function reloadGridGrp(){
			$("#jqgridGrp").jqGrid('setGridParam',{
				datatype: 'json',
			 });
			$("#jqgridGrp").trigger("reloadGrid");
		}
		
		function actionEdit(astgrpid){
			$("#form_list").hide();
			$("#div_detail").show();
  	   
			$(".wrap").after("<div class='overlay'></div>");
			
			var scope = angular.element(document.getElementById("assetGrplApp")).scope();
			  
			if(astgrpid != 0){
				scope.actionSelectDetail(astgrpid);
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
    	   	
    	   	gridReSize();
		}
	       
		
		
    </script>




