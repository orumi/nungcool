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
		
 		<!-- excel import  -->
		<script src="<c:url value='/js-xlsx-master/dist/cpexcel.js'/>"></script>
		<script src="<c:url value='/js-xlsx-master/shim.js'/>"></script>
		<script src="<c:url value='/js-xlsx-master/jszip.js'/>"></script>
		<script src="<c:url value='/js-xlsx-master/xlsx.js'/>"></script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/cool/importExlCcnModule.js'/>"></script>
	    
	    
	    <script type="text/javascript">
			var rgstrExlAstURL = "<c:url value='/cool/import/rgstrExlCcn.json'/>";
		</script>
	    
	    
	    
<!-- MAIN CONTENT -->
<div class="wrap" id="exlApp" ng-app="exlApp" ng-controller="exlController">
<div id="content" >
			<!-- LIST CONTENT -->
			<form class="form-horizontal" id="formList" name="formList">
				<!-- widget grid -->
				<section id="widget-base" class="">

					<!-- row -->
					<div class="row">

						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							
				
							<div class="jarviswidget" id="" 
								data-widget-colorbutton="false"
								data-widget-editbutton="false"
								data-widget-togglebutton="false"
								data-widget-deletebutton="false"
								data-widget-fullscreenbutton="false"
							>

								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>체계관리 엑셀등록</h2>
									
									<ul id="widget-tab-1" class="nav nav-tabs pull-right">
										<li class="active">
											<a data-toggle="tab" href="#" onclick="changeView('rgl');" aria-expanded="false"> 
												<span class="hidden-mobile hidden-tablet">1. 관리체계 위험정보</span> 
											</a>
										</li>
										<li>
											<a data-toggle="tab" href="#" onclick="changeView('ctr');" aria-expanded="true"> 
												<span class="hidden-mobile hidden-tablet">2. 법적준거성 평가</span>
											</a>
										</li>
										<li>
											<a data-toggle="tab" href="#" onclick="changeView('ccn');" aria-expanded="true"> 
												<span class="hidden-mobile hidden-tablet">3. 위협진단 항목</span>
											</a>
										</li>
										<li>
											<a data-toggle="tab" href="#" onclick="changeView('rst');" aria-expanded="true"> 
												<span class="hidden-mobile hidden-tablet">4. 위협진단 결과</span>
											</a>
										</li>
									</ul>									
								</header>
								<!-- widget div-->
								<div class="widget-content">
									<div class="row">
										<div class="col-md-12">	
											<div style="display:none;">
												<select name="format" onchange="setfmt()">
												<option value="json" selected> JSON</option>
												<option value="csv" > CSV</option>
												<option value="form"> FORMULAE</option>
												<option value="html"> HTML</option>
												</select>
											</div>
										</div>
										<div class="col-md-12">
											<table class="table table-bordered">
												<tr>
													<th width="10%" style="font-size:14px;">엑셀등록 (xlsx)</th>
													<td width="60%">
													<input type="file" name="xlfile" id="xlf" accept=".xlsx"
														style="    
															background: #3276b1;
										    				color: #fff;
										    				border: 1px solid #3579a9;
										    				font-size: 12px;"/>
										    		</td>		
										    		<td width="20%">
													<div >
														<button class="btn btn-xs btn-info" > 엑셀등록 양식 다운로드 </button>
													</div>										    				
													</td>
												</tr>
											</table>			
											 
										</div>
										
										<div class="col-md-12">	
										<b>엑셀기능 체크 : </b>
										&nbsp;엑셀기능: (체크일때 가능) <input type="checkbox" name="useworker" checked disabled="disabled">
										&nbsp;&nbsp;데이터 전환기능: (체크일때 가능) <input type="checkbox" name="xferable" checked disabled="disabled">
										&nbsp;&nbsp;바이러리 형태: (체크일때 바이러리) <input type="checkbox" name="userabs" checked disabled="disabled">	
										
										</div>
										<div class="col-md-12" style="margin-top: 9px;">
											<pre id="out"></pre>
											<div id="htmlout"></div>
										</div>
										
										<div class="col-md-12" style="margin-top: 9px;">
										</div>
									</div>
								</div>
							</div>		
				

							<table id="jqgrid"></table>
							<div id="pjqgrid"></div>




							<div class="col-md-12" id="jqgridContentDtl" style="padding:0px;" >
								<fieldset style="border: 1px solid #cccccc;padding: 12px 4px 6px 4px;;margin-bottom: 4px;margin-top:8px;">
									<div class="form-group">
							            <div class="col-md-1" style="padding-left:0px;float:right;">    
							                <button class="btn btn-primary" type="submit" id="btn_save" ng-click="actionPerformed()">
												<i class="fa fa-save"></i>
												일괄저장
											</button>
										</div>
									</div>
								</fieldset>
							</div>

						</article>
						<!-- WIDGET END -->

					</div>

					<!-- end row -->

				</section>
				<!-- end widget grid -->

			</form>
			<!-- END form CONTENT -->


</div>
</div>
<!-- END MAIN CONTENT -->


 		<script type="text/javascript">
			$(document).ready(function() {
				'use strict';
				
				/* pageSetUp(); */
				var aColModel = new Array();
				var aColNames = new Array();
				
				aColNames.push('체계버전');
				aColModel.push({name : 'vernm', sortable : false, resizable:true, width:"10%"});
				aColNames.push('분야');
				aColModel.push({name : 'fldnm', sortable : false, resizable:true, width:"10%"});
				aColNames.push('통제'); 
				aColModel.push({name : 'rglnm', sortable : false, resizable:true, width:"10%"});
				aColNames.push('통제항목');
				aColModel.push({name : 'rgldtlnm', sortable : false, resizable:true, width:"10%"});
				aColNames.push('현황 취약점');
				aColModel.push({name : 'weekpoint', sortable : false, resizable:true, width:"10%"});
				aColNames.push('우려사항');
				aColModel.push({name : 'concernpoint', sortable : false, resizable:true, width:"10%"});
				aColNames.push('우려수준');
				aColModel.push({name : 'concernlevel', sortable : false, resizable:true, width:"10%", align: 'center'});
				aColNames.push('보호대책');
				aColModel.push({name : 'planyn', sortable : false, resizable:true, width:"10%", align: 'center'});
				aColNames.push('대책계획');
				aColModel.push({name : 'plandetail', sortable : false, resizable:true, width:"10%"});
				
				jQuery("#jqgrid").jqGrid({
		            datatype: "local",
		            height: '400',
					loadtext : ' 로딩중..',
					colNames : aColNames,
					colModel : aColModel,
					/* pager : jQuery('#pjqgrid'), */
					sortname : 'productsn',
					viewrecords : true,
 					shrinkToFit: true, 
					gridview: true,
	                hoverrows: false,
	                autoencode: true,
	                autowidth: true,
	                ignoreCase: true,
	                
					caption : "통제항목",
					/* multiselect : true, */
		            gridComplete : function() {
		            	$("#jqgrid").jqGrid('setGridWidth', $("#content").width());
	                }
				});
				
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

				
			})

			$(window).on('resize.jqGrid', function() {
				$("#jqgrid").jqGrid('setGridWidth', $("#content").width());
				
			})
			

			function loadJqGrid(output){
				var exlData = JSON.parse(output);
				
				if(exlData.Sheet1){
					
					jQuery("#jqgrid").jqGrid("clearGridData", true);
					
					var gridData = exlData.Sheet1; 
					console.log("length : "+gridData.length);
					for(var i=0; i < gridData.length; i++){
						$("#jqgrid").jqGrid('addRowData',i+1,gridData[i]);
					}

					var scope = angular.element(document.getElementById("exlApp")).scope();
				    scope.$apply( function() { scope.setGridData(gridData);} );
				}
			}
			
			var currentView = "rgl";
			
			function changeView(tag){
				jQuery("#jqgrid").jqGrid("clearGridData", true);
				$("#jqgrid").jqGrid('GridUnload');
				
				$("#xlf").val("");
				
				var aColModel = new Array();
				var aColNames = new Array();
				
				if("rgl" == tag){
					currentView = tag;
					//console.log("currentView : "+currentView);
					$("#out").html("- 엑셀등록양식을 다운로드 받을 수 있습니다.");	
					$("#out").append("<br>- 체계정보를 이미 등록되어 있어야 합니다.");
					
					aColNames.push('체계버전');
					aColModel.push({name : 'vernm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('분야');
					aColModel.push({name : 'fldnm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('통제'); 
					aColModel.push({name : 'rglnm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('통제항목');
					aColModel.push({name : 'rgldtlnm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('현황 취약점');
					aColModel.push({name : 'weekpoint', sortable : false, resizable:true, width:"10%"});
					aColNames.push('우려사항');
					aColModel.push({name : 'concernpoint', sortable : false, resizable:true, width:"10%"});
					aColNames.push('우려수준');
					aColModel.push({name : 'concernlevel', sortable : false, resizable:true, width:"10%", align: 'center'});
					aColNames.push('보호대책');
					aColModel.push({name : 'planyn', sortable : false, resizable:true, width:"10%", align: 'center'});
					aColNames.push('대책계획');
					aColModel.push({name : 'plandetail', sortable : false, resizable:true, width:"10%"});
					
					
				} else if ("ctr" == tag){
					currentView = tag;
					//console.log("currentView : "+currentView);
					$("#out").html("- 엑셀등록양식을 다운로드 받을 수 있습니다.");	
					$("#out").append("<br>- 법적준거성정보는 신규로 등록됩니다.");
					
					aColNames.push('법적준거성 버전');
					aColModel.push({name : 'ctrvernm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('법령지침');
					aColModel.push({name : 'guideline', sortable : false, resizable:true, width:"10%"});
					aColNames.push('관련조항');
					aColModel.push({name : 'currentstate', sortable : false, resizable:true, width:"10%"});
					aColNames.push('내용');
					aColModel.push({name : 'ctrcnt', sortable : false, resizable:true, width:"10%"});
					aColNames.push('현황');
					aColModel.push({name : 'article', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('우려사항');
					aColModel.push({name : 'ctrccn', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('법령여부');
					aColModel.push({name : 'legal', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('보호대책여부');
					aColModel.push({name : 'protect', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('대응방안');
					aColModel.push({name : 'actionplan', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('정렬순서');
					aColModel.push({name : 'sortby', sortable : false, resizable:true, width:"10%",align: 'center'});
					
				} else if ("ccn" == tag){
					currentView = tag;
					//console.log("currentView : "+currentView);
					$("#out").html("- 엑셀등록양식을 다운로드 받을 수 있습니다.");	
					$("#out").append("<br>- 자산구분은 이미 등록되어 있어야 합니다.");
					$("#out").append("<br>- 발생가능성은 1~6, 조치일정은 단기/중기/장기중 하나를 선택해야 합니다.");
					
					aColNames.push('자산구분');
					aColModel.push({name : 'astgrpnm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('CONCERN코드');
					aColModel.push({name : 'ccnitemcd', sortable : false, resizable:true, width:"10%"});
					aColNames.push('취약점 위협');
					aColModel.push({name : 'ccnitemnm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('조치방안');
					aColModel.push({name : 'actionplan', sortable : false, resizable:true, width:"10%"});
					aColNames.push('발생가능성');
					aColModel.push({name : 'ccnvalue', sortable : false, resizable:true, width:"10%", align: 'center'});
					aColNames.push('사용여부');
					aColModel.push({name : 'useyn', sortable : false, resizable:true, width:"10%", align: 'center'});
					aColNames.push('조치일정');
					aColModel.push({name : 'actionperiod', sortable : false, resizable:true, width:"10%", align: 'center'});
					aColNames.push('정렬순서');
					aColModel.push({name : 'sortby', sortable : false, resizable:true, width:"10%", align: 'center'});
					
				} else if ("rst" == tag){
					currentView = tag;
					//console.log("currentView : "+currentView);
					$("#out").html("- 엑셀등록양식을 다운로드 받을 수 있습니다.");	
					$("#out").append("<br>- 자산정보와 위협항목은 이미 등록되어 있어야 합니다.");
					
					aColNames.push('자산버전');
					aColModel.push({name : 'astvernm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('자산구분');
					aColModel.push({name : 'astgrpnm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('관리번호');
					aColModel.push({name : 'mgnno', sortable : false, resizable:true, width:"10%"});
					aColNames.push('대분류');
					aColModel.push({name : 'cate01', sortable : false, resizable:true, width:"10%"});
					aColNames.push('소분류');
					aColModel.push({name : 'cate02', sortable : false, resizable:true, width:"10%"});
					aColNames.push('자산명');
					aColModel.push({name : 'assetnm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('기밀성');
					aColModel.push({name : 'imptc', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('무결성');
					aColModel.push({name : 'impti', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('가용성');
					aColModel.push({name : 'impta', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('인증대상');
					aColModel.push({name : 'certiyn', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('취약점대상');
					aColModel.push({name : 'wktstyn', sortable : false, resizable:true, width:"10%",align: 'center'});
					aColNames.push('CONCERN코드');
					aColModel.push({name : 'ccnitemcd', sortable : false, resizable:true, width:"10%"});
					aColNames.push('취약점 위협');
					aColModel.push({name : 'ccnitemnm', sortable : false, resizable:true, width:"10%"});
					aColNames.push('발생가능성');
					aColModel.push({name : 'ccnvalue', sortable : false, resizable:true, width:"10%"});
					aColNames.push('진단결과');
					aColModel.push({name : 'ccnrst', sortable : false, resizable:true, width:"10%", align: 'center'});
					aColNames.push('조치여부');
					aColModel.push({name : 'completeyn', sortable : false, resizable:true, width:"10%", align: 'center'});
					aColNames.push('조치일자');
					aColModel.push({name : 'actiondt', sortable : false, resizable:true, width:"10%", align: 'center'});
					aColNames.push('수용내용');
					aColModel.push({name : 'acceptcnt', sortable : false, resizable:true, width:"10%"});
				}
				
				jQuery("#jqgrid").jqGrid({
		            datatype: "local",
		            height: '400',
					loadtext : ' 로딩중..',
					colNames : aColNames,
					colModel : aColModel,
					sortname : 'productsn',
					viewrecords : true,
 					shrinkToFit: true, 
					gridview: true,
	                hoverrows: false,
	                autoencode: true,
	                autowidth: true,
	                ignoreCase: true,
	                
					caption : "통제항목",
		            gridComplete : function() {
		            	$("#jqgrid").jqGrid('setGridWidth', $("#content").width());
	                }
				});
				
				$("#jqgrid").trigger("reloadGrid");
				
			}
			

		</script>

	<script>
		/*global XLSX */
		var X = XLSX;
		var XW = {
			/* worker message */
			msg: 'xlsx',
			/* worker scripts */
			rABS: "<c:url value='/js-xlsx-master/xlsxworker2.js'/>",
			norABS: "<c:url value='/js-xlsx-master/xlsxworker1.js'/>",
			noxfer: "<c:url value='/js-xlsx-master/xlsxworker.js'/>"
		};
	
	</script>
<script src="<c:url value='/js/ncsys/isms/cool/importExlAst.js'/>"></script>
	


