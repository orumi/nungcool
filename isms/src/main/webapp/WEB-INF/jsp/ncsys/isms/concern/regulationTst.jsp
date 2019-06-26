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
		var regulationTstInitURL = "<c:url value='/concern/regulationTstInit.json'/>";
		
		
		var regulationTstDetailURL = "<c:url value='/concern/regulationTstDetail.json'/>";
		
		
		
		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/concern/regulationTstModule.js'/>"></script>
	
<!-- MAIN CONTENT -->
<div class="wrap" id="regulationTstApp" ng-app="regulationTstApp" ng-controller="regulationTstController">
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
										                    <select  class="form-control" id="selVerId" ng-model="entity.selVerId" >
										                    	<option ng-repeat="option in entity.selVers" value="{{option.verid}}">{{option.vernm}}</option>
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
										                    <select class="form-control" id="selFieldId" ng-model="entity.selFieldId">
										                        <!-- <option  value="0">::전체::</option> -->
										                        <option  ng-repeat="option in entity.selFields" value="{{option.fldid}}">{{option.fldnm}}</option>
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

											<div class="widget-body">
											<fieldset>
												<div class="form-group" style="float:right;padding-top: 12px;">
													<div class="col-md-1" style="padding-left:0px;">    
										                <a class="btn btn-primary" id="btnSubmit" style="width:88px;" >
															등록
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




</div>
</div>
<!-- END MAIN CONTENT -->


    <script type="text/javascript">
       $(document).ready(function() {
			'use strict';

			
			$(window).on("click", function(evt) {
 		    	if (!$(event.target).closest('#jqgrid').length) {
		    		renderAfterEdit(lastsel)
		    		lastsel = null;
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
        
            var lastsel;
            $("#jqgrid").jqGrid({
                url : 'regulationTstList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "verid":function() { return $("#selVerId").val(); }, "fldid":function() { return $("#selFieldId").val(); }  },
                colNames: ['순번','id','분야', '통제', '통제항목', '현황 및 취약점','우려사항', '우려수준', '보호대책','대책계획'],
                colModel: [
                	{ name: 'rowidx', width: "5%", align: 'center' },
                	{ name: 'rgldtlid', width: "1%", hidden:true },
                    { name: 'fldnm', width: "10%", cellattr: arrtSetting },
                    { name: 'rglnm', width: "10%", cellattr: arrtSetting },
                    { name: 'rgldtlnm', width: "20%" },
                    { name: 'weekpoint', width:"15%", align: "left", editable:true, edittype:"textarea", editoptions:{rows:"3",cols:"20",width:"100%",style:"width:98%;"} },
                    { name: 'concernpoint', width: "15%", align: "left", editable:true, edittype:"textarea", editoptions:{rows:"3",cols:"20",width:"100%", style:"width:98%;"} },
                    { name: 'concernlevel', width: "5%", align: 'center', editable: true, edittype:"select", editoptions:{value:"H:H;M:M;L:L"} },
                    { name: 'planyn', width: "5%", align: 'center', editable: true, edittype:"select", editoptions:{value:"Y:Y;P:P;N:N;N/A:N/A"} },
                    { name: 'plandetail', width: "15%", align: "left", editable:true, edittype:"textarea", editoptions:{rows:"3",cols:"20",width:"100%", style:"width:98%;"} }
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
                	return true;  // editable 
                },
                onSelectRow: function(id){
                	if(id && id!==lastsel){
            			if(lastsel){
	            			renderAfterEdit(lastsel)
            			}
            			jQuery('#jqgrid').jqGrid('editRow',id, true);
            			lastsel = id;
            		}
            	},
                jsonReader: {  
	                root : 'reRegulationTstList',  
	                id   : 'rgldtlid', 
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

			
			$("#selVerId").change(function(){ reloadGrid(); });
			$("#selFieldId").change(function(){ reloadGrid(); });
			$("#btnSubmit").click(function(){ actionPerformed(); });
			
	        function renderAfterEdit(rowIdx){
				if(rowIdx){
					$('#jqgrid').jqGrid('saveRow',rowIdx);
		    		
					//var rowData = $('#jqgridDtl').jqGrid('getRowData',rowIdx);
		    		//$("#jqgridDtl").jqGrid("setCell",lastsel,"tstresult", resultCalculator(rowData));
	    		}
			}
	        
	        function actionPerformed(){
	        	renderAfterEdit(lastsel);
	        	
	        	var scope = angular.element(document.getElementById("regulationTstApp")).scope();
	        	scope.entity.regulationTsts = $("#jqgrid").getRowData();
	        	var pm = {"actionmode":"modify", "verid":scope.entity.selVerId , "fldid":scope.entity.selFieldId };
	        	scope.actionPerformed(pm);
	        	
	        }
			
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
		
		

        
		
    </script>




