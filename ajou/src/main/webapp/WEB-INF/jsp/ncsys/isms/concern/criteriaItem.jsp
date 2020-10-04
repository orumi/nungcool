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
		
		
		
		var criteriaItemInitURL = "<c:url value='/concern/criteriaItemInit.json'/>";
		var criteriaVersionDetailURL = "<c:url value='/concern/criteriaVersionDetail.json'/>";
		var criteriaItemDetailURL = "<c:url value='/concern/criteriaItemDetail.json'/>";
		
		
		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/concern/criteriaItemModule.js'/>"></script>
	
<!-- MAIN CONTENT -->
<div class="wrap" id="criteriaItemApp" ng-app="criteriaItemApp" ng-controller="criteriaItemController">
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
									<h2>통제항목 관리</h2>
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
										                    <select  class="form-control" id="selVersion" ng-model="entity.selCriteriaVerId" >
										                    	<option ng-repeat="option in entity.selCriteriaVers" value="{{option.ctrverid}}">{{option.ctrvernm}}</option>
										                    </select>
										                </div>
										            </div>    
										            <div class="col-md-1" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-default" onclick="javascript:actionEditVersion();">
															...
														</a>
													</div>
										            <div class="col-md-1" style="padding-left:0px;">    
										                <a type="submit" class="btn btn-primary" style="width:68px;" onclick="javascript:reloadGrid();">
															조 회
														</a>
													</div>
													
													<div class="col-md-1" style="padding-left:0px;">    
										                <a class="btn btn-primary" style="width:68px;" onclick="javascript:actionEdit(0);">
															등록
														</a>
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
 					<popup-criteriaitem-detail></popup-criteriaitem-detail>
			   	</div>
			   	
			   	<div class="" id="div_version" name="div_version" style="display: none;">
					<popup-criteria-version></popup-criteria-version>
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
                url : 'criteriaItemList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "ctrverid":function() { return $("#selVersion").val(); }  },
                colNames: ['순번','법령지침', '관련조항', '내용', '현황','우려사항', '법령여부', '보호대책','위협발생값','대응방안','편집'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
                    { name: 'guideline', width: "10%", align: 'center' },
                    { name: 'article', width: "10%", align: 'center' },
                    { name: 'ctrcnt', width: "10%" },
                    { name: 'currentstate', width:"10%", align: "center"},
                    { name: 'ctrccn', width: "5%" },
                    { name: 'legal', width: "5%", align: 'center' },
                    { name: 'protect', width: "5%" },
                    { name: 'rmk', width: "10%" },
                    { name: 'actionplan', width: "10%" },
                    { name: 'ctritemid', sortable : false, resizable:false,width:"5%", align: "center", formatter:btnFormatter }
                ],
                cmTemplate: {sortable: false},
                //rowNum: 10,
                //rowList: [5, 10, 20],
                //pager : '#pjqgrid',
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
	                root : 'reCriteriaItem',  
	                id   : 'ctritemid', 
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
			
			
			/* jQuery("#jqgrid").navGrid('#pjqgrid',{ add: false, edit: false, view: false, del: false, refresh: false, search: false})
			.navButtonAdd('#pjqgrid',
				{
				   caption:"추가", 
				   buttonicon:"ui-icon-plus",
				   id:"addId",
				   onClickButton: function(){ 
					   //var newRowid = makeNewRowId($("#jqgrid").getDataIds());
					   $("#jqgrid").jqGrid("addRowData", "156", {}, 'last'); 
					   //$("#jqgrid").jqGrid("addRowData", 1, {rowidx:1,fldnm:"new",}, 'last');
					   /* jQuery("#jqgrid").jqGrid('editGridRow',"new",{height:280,reloadAfterSubmit:false}); * /
					   //jQuery("#jqgrid").jqGrid('inlineNav',"#pjqgrid");
				   }, 
				   position:"last"
				})
			.navButtonAdd('#pjqgrid',{
				   caption:"적용", 
				   buttonicon:"ui-icon-disk", 
				   onClickButton: function(){ 
				     alert("Adjust data");
				   }, 
				   position:"last"
				}); */
			
			
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
		
		function actionEdit(ctritemid){
			$("#form_list").hide();
			$("#div_detail").show();
  	   
			$(".wrap").after("<div class='overlay'></div>");
			
			$("#selCtrVerNM").val($("#selVersion option:selected").text());
			
			var scope = angular.element(document.getElementById("criteriaItemApp")).scope();
			  
			if(ctritemid != 0){
				scope.actionSelectDetail(ctritemid);
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
    	   	var scope = angular.element(document.getElementById("criteriaItemApp")).scope();
    	   	scope.entity.criteriaVer = null;
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




