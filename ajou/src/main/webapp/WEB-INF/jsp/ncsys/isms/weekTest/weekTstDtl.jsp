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
		
		
			#jqgridDtl td {
				vertical-align:middle;
			}
			
			.font_red {
				color:red;
			}
		</style>
 
 
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>
		
		<script type="text/javascript">
		var weekTestDtlInitURL = "<c:url value='/weekTest/weekTestDtlInit.json'/>";
		var weekTestDtlDetailURL = "<c:url value='/weekTest/weekTestDtlDetail.json'/>";
		
		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/weekTest/weekTestDtlModule.js'/>"></script>
	
<!-- MAIN CONTENT -->
<div class="wrap" id="weekTestDtlApp" ng-app="weekTestDtlApp" ng-controller="weekTestDtlController">
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
													<label class="control-label col-md-1" for="prepend">자산관리버전</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selAstVer" ng-model="entity.selAstVerId" >
										                    	<option ng-repeat="option in entity.selAstVers" value="{{option.astverid}}">{{option.astvernm}}</option>
										                    </select>
										                </div>
										            </div>    
												</div>
											</fieldset>
											
											<fieldset>
												<div class="form-group">
													<label class="control-label col-md-1" for="prepend">자산구분</label>
													<div class="col-md-4" style="padding-right: 1px;;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" id="selAstGroup" ng-model="entity.selAstGroupId" >
										                    	<option ng-repeat="option in entity.selAstGroups" value="{{option.astgrpid}}">{{option.astgrpnm}}</option>
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
											
											<div id="jqgridDiv" class="col-md-12" style="padding-left:0px; padding-bottom: 32px;">    
												<div id="jqgridContentAst" style="float:left;" >
												    <table id="jqgridAst"><tr><td /></tr></table>
												    <div id="pjqgridAst"></div>
												</div>
												<div id="jqgridContentDtl" style="float:left; padding-left:20px;" >
													<fieldset style="border: 1px solid #cccccc;padding: 12px 4px 6px 4px;;margin-bottom: 4px;">
													
														<div class="form-group">
															<label class="control-label col-md-2" for="prepend">자산정보</label>
															<div class="col-md-4" style="padding-right: 1px;;">
												                <div class="icon-addon addon-md" >
												                    <input type="hidden" id="txtAssetId" />
												                    <input type="text" class="form-control" id="txtAssetMngNo" />
												                </div>
												            </div>
												            <div class="col-md-4" style="padding-right: 1px;;">
												                <div class="icon-addon addon-md" >
												                    <input type="text" class="form-control" id="txtAssetNm"  />
												                </div>
												            </div>    
												            <div class="col-md-1" style="padding-left:0px;">    
												                <a type="submit" id="btnSubmit" class="btn btn-primary" style="width:68px;" >
																	저장
																</a>
															</div>
														</div>
													</fieldset>
												    <table id="jqgridDtl"><tr><td /></tr></table>
												    <div id="pjqgridDtl"></div>
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
 		    	if (!$(event.target).closest('#jqgridDtl').length) {
		    		renderAfterEdit(lastsel)
		    		lastsel = null;
		    		//console.log(" closest"+event.target);
				} else {
					//console.log(" closest else "+event.target);
				} 
		    	
		    });
 		    
            $("#jqgridAst").jqGrid({
                url : 'weekTestDtlAsset.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "astverid":function() { return $("#selAstVer").val(); }, "astgrpid":function(){return $("#selAstGroup").val(); } },
                colNames: ['순번','구분','관리번호','호스트명','중요도','등급','보안수준','선택'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
                    { name: 'astgrpnm', width: "10%", align: 'center' },
                    { name: 'mgnno', width: "10%"},
                    { name: 'assetnm', width: "20%" },
                    { name: 'impt', width: "10%", align: 'right' },
                    { name: 'impgrd', width: "10%", align: 'center' },
                    { name: 'tstavg', width: "10%", align: 'right', formatter:tstFormatter },
                    { name: 'assetid', sortable : false, resizable:false, width:"6%", align: "center", formatter:btnFormatter }
                ],
                cmTemplate: {sortable: false},
                loadtext : ' 로딩중..',
                gridview: true,
                hoverrows: false,
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
	                root : 'reWeekTestDtlAsset',  
	                id   : 'assetid', 
	                repeatitems: true  
	            },
	            gridComplete : function() {
	            	$("#jqgridAst").jqGrid('setGridWidth', 500);
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
            $("#jqgridDtl").jqGrid({
                url : 'weekTestDtlDetailList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : {  },
                colNames: ['영역','CODE','점검항목','중요도','점수','설정 현황','진단결과','진단점수'],
                colModel: [
					{ name: 'wktstfieldnm', width: "10%", align: 'center' },
					{ name: 'tstitemcd', width: "10%"},
					{ name: 'tstitemnm', width: "30%"},
                    { name: 'importance', sortable : false, width:"5%", align: "center" },
                    { name: 'tstscr', width: "5%", align: 'right' },
                    { name: 'settingenv', width: "20%", editable:true, edittype:"textarea", editoptions:{rows:"3",cols:"20",width:"100%",style:"width:98%;"} },
                    { name: 'tstrst', width: "10%", align:'center', editable: true, edittype:"select", editoptions:{value:"X:취약;O:양호;N:N/A;P:P"}, cellattr:rstCellattr  },
                    { name: 'tstresult', width: "10%", align:'right'}
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
                /* cellEdit : true, */
                beforeSelectRow: function () {
                	//jQuery('#jqgridDtl').jqGrid('restoreRow',lastsel);
                    return true;  // editable 
                },
                onSelectRow: function(id){
                	if(id && id!==lastsel){
            			//jQuery('#jqgridDtl').jqGrid('restoreRow',lastsel);
            			if(lastsel){
	            			//$('#jqgridDtl').jqGrid('saveRow',lastsel);
	            			renderAfterEdit(lastsel)
            			}
            			jQuery('#jqgridDtl').jqGrid('editRow',id,true);
            			lastsel = id;
            		}
            	},
            	afterEditCell: function(id,name,val,iRow,iCol){
            		//console.log("name : "+name);
            	},
                jsonReader: {  
	                root : 'reWeekTestDtlDetail',  
	                id   : 'tstitemcd', 
	                repeatitems: true  
	            },
	            gridComplete : function() {
	            	gridReSize();
                }
            });
            
            function rstCellattr(rowId, cellValue, rowObject, cm, rdata){
            	//console.log("rowData.cellValue : "+cellValue)
            	if("취약" == cellValue){
            		return " style= 'color:red'";
            	}
            }
            function tstFormatter(cellValue, options, rowObject){
            	
            	return cellValue+" %";
            }
            
            function btnFormatter(cellValue, options, rowObject){
            	var btn = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:reloadGridDtl('" + cellValue + "');\"><i class='fa fa-pencil'></i></div>";
            	
            	return btn;
            }
            
            function resultCalculator(rowObj){
            	
            	$('#jqgridDtl').setCell(rowObj.tstitemcd, 'tstrst', '', { color: '#404040;' });
            	
				//console.log("test result : "+rowObj.tstrst);
            	var rstVal = "0";
            	if(rowObj.tstrst == "취약"){
            		rstVal = "0";
            		//$(selCell).addClass("font_red");	
            		$('#jqgridDtl').setCell(rowObj.tstitemcd, 'tstrst', '', { color: 'red' });
            	} else if(rowObj.tstrst == "양호"){
            		rstVal = 1 * rowObj.tstscr;
            	} else if(rowObj.tstrst == "P"){
            		rstVal = 0.5 * rowObj.tstscr;
            	} else if(rowObj.tstrst == "N/A"){
            		rstVal = "N";
            	}
            	return rstVal;
            }

    		function renderAfterEdit(rowIdx){
    			if(rowIdx){
    				$('#jqgridDtl').jqGrid('saveRow',rowIdx);
    	    		var rowData = $('#jqgridDtl').jqGrid('getRowData',rowIdx);
    	    		
    	    		$("#jqgridDtl").jqGrid("setCell",lastsel,"tstresult", resultCalculator(rowData));
        		}
    		}
    		
            function actionPerformed(){
            	/* getDataIDs  */
            	//var ids = $("#jqgridDtl").jqGrid("getDataIDs");
    			// for eachs id get rowData
            	/*   */
            	
            	//var gridData = $("#jqgridDtl").getRowData();
            	//console.log("gridDta : "+gridData[0].result);
            	
            	renderAfterEdit(lastsel);
            	
            	var scope = angular.element(document.getElementById("weekTestDtlApp")).scope();
            	scope.entity.wkTstDtls = $("#jqgridDtl").getRowData();
            	var pm = {"actionmode":"modify", "astverid":scope.entity.selAstVerId , "astgrpid":scope.entity.selAstGroupId, "assetid":$("#txtAssetId").val() };
            	scope.actionPerformed(pm);
            	
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

			
			$("#selAstVer").change(function(){ reloadGrid(); });
			$("#selAstGroup").change(function(){ reloadGrid(); });
			$("#btnSubmit").click(function(){ actionPerformed(); });

			// end of document ready	
        });
       

       
       
       
       
       
       
       
       
       
       
       
       
       
		$(window).on('resize.jqGrid', function() {
			gridReSize();
		})

		function gridReSize(){
			$("#jqgridDtl").jqGrid('setGridWidth', $("#jqgridDiv").width()-540);
		}
		

		
		function reloadGrid(){
			$("#jqgridDtl").jqGrid("clearGridData", true);
			$("#txtAssetMngNo").val("");
			$("#txtAssetNm").val("");
			reloadGridAst();
		}
		
		function reloadGridAst(){
			$("#jqgridAst").jqGrid('setGridParam',{
				datatype: 'json',
			 });
			$("#jqgridAst").trigger("reloadGrid");
		}
		
		function reloadGridDtl(assetid){
			var rowData = $("#jqgridAst").jqGrid("getRowData", assetid);
			if(rowData){
				$("#txtAssetMngNo").val(rowData.mgnno);
				$("#txtAssetNm").val(rowData.assetnm);
				$("#txtAssetId").val(assetid);
			}
			$("#jqgridDtl").jqGrid('setGridParam',{
				datatype: 'json',
				postData : { "astverid":function() { return $("#selAstVer").val(); }, 
							 "astgrpid":function(){return $("#selAstGroup").val(); }, 
							 "assetid":assetid }
				
			 }).trigger("reloadGrid");
		}
		
		
        function selectResult(rowId){
        	console.log("selectResult : rowId : "+rowId)
            
        	/* jqgrid select row Object  */
        	//var rowid  = $("#jqgridDtl").jqGrid("getGridParam", "selrow" );
        	//console.log("selectResult : rowId : "+rowid)
        	
        	/* select rowData by id   */
        	//var rowData = $("#jqgridDtl").jqGrid("getRowData", rowId);
        	//$("#jqgridDtl").jqGrid("setCell",rowId,"진단점수","1");
        	//$("#jqgridDtl").jqGrid("setCell",rowId,"result","1");
        	//rowData.tstscr = 1;
			//rowData.tstrst = "";
			
        	/* set rowData   */
        	//$("#jqgridDtl").jqGrid('setRowData', rowId, rowData); 
        	
        }
        

        
        
        
    </script>




