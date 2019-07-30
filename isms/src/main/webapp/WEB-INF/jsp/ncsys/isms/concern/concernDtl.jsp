
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
		var concernDtlInitURL = "<c:url value='/concern/concernDtlInit.json'/>";
		var concernDtlDetailURL = "<c:url value='/concern/concernDtlDetail.json'/>";

		var header = $("meta[name='_csrf_header']").attr("content");
		var token = $("meta[name='_csrf']").attr("content");

		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/concern/concernDtlModule.js'/>"></script>

<!-- MAIN CONTENT -->
<div class="wrap" id="concernDtlApp" ng-app="concernDtlApp" ng-controller="concernDtlController">
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
					<div class="popup">

						<form class="form-horizontal" id="form_detail" name="form_detail" >

						<section id="widget-base" class="" >
							<div class="row" >

								<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<div class="jarviswidget" id="wid-id-1" >
										<header>
											<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
											<h2>진단항목 상세</h2>
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



												<div id="jqgridDivDetail" class="col-md-12" style="padding-left:0px; padding-bottom: 32px;">
													<div id="jqgridContentDtl" style="" >
														<fieldset style="border: 1px solid #cccccc;padding: 12px 4px 6px 4px;;margin-bottom: 4px;">

															<div class="form-group">
																<label class="control-label col-md-1" for="prepend">자산정보</label>
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
																<div class="col-md-1" style="padding-left:0px;">
													                <a class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;" onclick="javascript:actionClose();" >닫기</a>
																</div>
															</div>
														</fieldset>
													    <table id="jqgridDtl"><tr><td /></tr></table>
													    <div id="pjqgridDtl"></div>
													</div>
												</div>

											</div>
										</div>
									</div>

								</article>

							</div>
						</section>
						</form>
					</div>
			   	</div>



</div>
</div>
<!-- END MAIN CONTENT -->


    <script type="text/javascript">

       $(document).ready(function() {
			'use strict';

			 $(".date").mask("yyyy/mm/dd");    //123456  =>  ___.__1.234,56

	  	     $(window).on("click", function(evt) {
 		    	/* if (!$(event.target).closest('#jqgridDtl').length) {
		    		renderAfterEdit(lastsel)
		    		lastsel = null;
		    		//console.log(" closest"+event.target);
				} else {
					//console.log(" closest else "+event.target);
				}  */

		    });


	  	   var options = {
			         dateFormat: "yy/mm/dd"
			        ,prevText : '<i class="fa fa-chevron-left"></i>'
					,nextText : '<i class="fa fa-chevron-right"></i>'
					,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	                ,changeYear: true        //콤보박스에서 년 선택 가능
	                ,changeMonth: true //콤보박스에서 월 선택 가능
	                ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
	                ,yearSuffix: "년"  //달력의 년도 부분 뒤에 붙는 텍스트
	                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
			}


	  	    /* csrf */
            $.ajaxSetup({
			    headers : {
			    	'X-CSRF-TOKEN': token
			    }
			});

            $("#jqgridAst").jqGrid({
                url : 'concernDtlAsset.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "astverid":function() { return $("#selAstVer").val(); }, "astgrpid":function(){return $("#selAstGroup").val(); } },
                colNames: ['순번','구분','관리번호','호스트명','중요도','등급',   '전체항목','양호','취약','단기','중기','장기','위험수용','조치율','조치','미조치','등록'],
                colModel: [
					{ name: 'rowidx', width: "5%", align: 'center' },
                    { name: 'astgrpnm', width: "10%", align: 'center' },
                    { name: 'mgnno', width: "10%"},
                    { name: 'assetnm', width: "20%" },
                    { name: 'impt', width: "10%", align: 'right' },
                    { name: 'impgrd', width: "10%", align: 'center' },

                    { name: 'cntitem', width: "5%", align: 'center' },
                    { name: 'cnty', width: "5%", align: 'center' },
                    { name: 'cntn', width: "10%", align: 'center' },
                    { name: 'cntshort', width: "10%", align: 'center' },
                    { name: 'cntmiddle', width: "10%", align: 'center' },
                    { name: 'cntlong', width: "10%", align: 'center' },
                    { name: 'cntacp', width: "10%", align: 'center' },


                    { name: 'competert', width: "10%", align: 'right', formatter:tstFormatter },
                    { name: 'cntok', width: "10%", align: 'center' },
                    { name: 'cntnotyet', width: "10%", align: 'center' },

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
	                root : 'reconcernDtlAsset',
	                id   : 'assetid',
	                repeatitems: true
	            },
	            gridComplete : function() {
	            	$("#jqgridAst").jqGrid('setGridWidth', $("#jqgridDiv").width()-5);
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

            $("#jqgridDtl").jqGrid({
                url : 'concernDtlDetailList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : {  },
                colNames: ['CODE','취약점/위협','조치방안','위험도','진단결과','위험관리','조치일정','조치여부','조치일자','수용내용'],
                colModel: [
					{ name: 'ccnitemcd', width: "10%", align: 'center' },
					{ name: 'ccnitemnm', width: "20%"},
					{ name: 'actionplan', width: "20%"},
                    { name: 'riskvalue', width:"5%", align: "center" },
                    { name: 'ccnrst', width: "7%", align: 'center', formatter:renderSelect },   //editable: true, edittype:"select", editoptions:{value:"양호:양호;취약:취약;N/A:N/A"}, cellattr:rstCellattr },
                    { name: 'risktxt', width: "7%", align: 'center' },
                    { name: 'actionperiod', width: "5%", align:"center" },
                    { name: 'completeyn', width: "5%", align:'center', formatter:renderSelectComplete },
                    { name: 'actiondt', width: "10%", align:'center', formatter:renderTextbox },
                    { name: 'acceptcnt', width: "10%", align:'center', formatter:renderTextarea }
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
                    return false;
                },
                jsonReader: {
	                root : 'reConcernDtlDetail',
	                id   : 'tstitemcd',
	                repeatitems: true
	            },
	            gridComplete : function() {
	            	gridReSize();
	            	$(document).find("input[name=txtDate]").removeClass('hasDatepicker').datepicker(options);
                }
            });


            function renderSelect(cellValue, options, rowObject){
            	var code = rowObject.ccnitemcd;
            	var id = "sel_"+code;

				var reVal = "<select id='"+id+"' onchange='changeResult(this);' ccnitemcd='"+code+"' rowid='"+options.rowId+"' >";
				reVal = reVal+"<option value='Y' "+(cellValue=="Y"?"selected":"")+">양호</option>";
				reVal = reVal+"<option value='N' "+(cellValue=="N"?"selected":"")+">취약</option>";
				reVal = reVal+"<option value='N/A' "+(cellValue=="N/A"?"selected":"")+">N/A</option>";
				reVal = reVal+"<option value='' "+(cellValue==""?"selected":"")+">###</option>";
				reVal = reVal+"</select>";

            	return reVal;
            }

            function renderSelectComplete(cellValue, options, rowObject){
            	var code = rowObject.ccnitemcd;
            	var id = "selCom_"+rowObject.ccnitemcd;

            	var isDisabled = "";
            	if(rowObject.ccnrst != "N"){ isDisabled="disabled";}

            	var reVal = "<select id='"+id+"' onchange='changeComplete(this);' ccnitemcd='"+code+"' rowid='"+options.rowId+"' "+isDisabled+">";
				reVal = reVal+"<option value='Y' "+(cellValue=="Y"?"selected":"")+">조치</option>";
				reVal = reVal+"<option value='A' "+(cellValue=="A"?"selected":"")+">수용</option>";
				reVal = reVal+"<option value='N' "+(cellValue=="N"?"selected":"")+">예정</option>";
				reVal = reVal+"<option value='' "+(cellValue==""?"selected":"")+">###</option>";
				reVal = reVal+"</select>";

            	return reVal;
            }

            function renderTextarea(cellValue, options, rowObject){
            	var id = "txtArea_"+rowObject.ccnitemcd;

            	var reVal = "";
            	if(rowObject.ccnrst == "N"){
            		reVal = "<textarea id='"+id+"' style='width:100%' row=3>"+cellValue+"</textarea>";
            	} else {
            		reVal = "<textarea id='"+id+"' style='width:100%' row=3 disabled=disabled>"+cellValue+"</textarea>";
            	}

            	return reVal;
            }

            function renderTextbox(cellValue, options, rowObject){
            	var id = "txt_"+rowObject.ccnitemcd;
            	var reVal = "";
            	if(rowObject.ccnrst == "N"){
            		reVal = "<input name='txtDate' type='text' id='"+id+"' style='width:80px;text-align: right;' placeholder='YYYY/MM/DD'  value='"+cellValue+"'/>";
            	} else {
            		reVal = "<input name='txtDate' type='text' id='"+id+"' style='width:80px;text-align: right;' placeholder='YYYY/MM/DD'  disabled />";
            	}

            	return reVal;
            }





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


    		function renderAfterEdit(rowIdx){
    			if(rowIdx){
    				$('#jqgridDtl').jqGrid('saveRow',rowIdx);


    	    		var rowData = $('#jqgridDtl').jqGrid('getRowData',rowIdx);


                	if(rowData.ccnrst == "취약"){
                		$('#jqgridDtl').setCell(rowIdx, 'ccnrst', '', { color: 'red' });

                		if(rowData.riskvalue >= 6){
                			$("#jqgridDtl").jqGrid("setCell",rowIdx,"risktxt", '위험조치');
                		} else {
                			$("#jqgridDtl").jqGrid("setCell",rowIdx,"risktxt", '위험수용');
                		}
                	} else if(rowData.ccnrst == "양호"){
                		$('#jqgridDtl').setCell(rowIdx, 'ccnrst', '', { color: '#404040;' });
                		$("#jqgridDtl").jqGrid("setCell",rowIdx,"completeyn", '-');
                	} else if(rowData.ccnrst == "N/A"){
                		$('#jqgridDtl').setCell(rowIdx, 'ccnrst', '', { color: '#404040;' });
                		$("#jqgridDtl").jqGrid("setCell",rowIdx,"completeyn", '-');
                	} else {
                		$('#jqgridDtl').setCell(rowIdx, 'ccnrst', '', { color: '#404040;' });
                		$("#jqgridDtl").jqGrid("setCell",rowIdx,"completeyn", '-');
                	}

    	    		//$("#jqgridDtl").jqGrid("setCell",rowIdx,"risktxt", resultCalculator(rowData));
        		}
    		}

            function actionPerformed(){

            	var scope = angular.element(document.getElementById("concernDtlApp")).scope();
            	scope.entity.concernDtls = $("#jqgridDtl").getRowData();

            	/* adjust date information  */
            	for(var idx=0; idx<scope.entity.concernDtls.length;idx++){
            		var entity = scope.entity.concernDtls[idx];
            		/* result   */
            		var selRst = $("#sel_"+entity.ccnitemcd).val();
            		if(selRst==""){
            			alert("진단결과 값을 입력하십시오.");
            			return;
            		}

            		entity.ccnrst = selRst;

            		/* complete   */
            		var chkRst = $("#selCom_"+entity.ccnitemcd).val();
            		entity.completeyn = chkRst;

            		/* action date  */
            		var txtRst = $("#txt_"+entity.ccnitemcd).val();
            		entity.actiondt = txtRst;

            		/* accept content   */
            		var txtArea = $("#txtArea_"+entity.ccnitemcd).val();
            		entity.acceptcnt = txtArea;

            	}

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


		function changeResult(obj){
    		var code = $(obj).attr("ccnitemcd");
    	    var rowid = $(obj).attr("rowid");
    		var val = $(obj).val();

    	    var rowData = $('#jqgridDtl').jqGrid('getRowData', rowid);

			if(val=="N"){
    			$("#selCom_"+code).removeAttr("disabled");
    			$("#txt_"+code).removeAttr("disabled");
    			$("#txtArea_"+code).removeAttr("disabled");

				if(rowData.riskvalue >= 6){
					$("#jqgridDtl").jqGrid("setCell", rowid, "risktxt", '위험조치');
				} else {
					$("#jqgridDtl").jqGrid("setCell", rowid, "risktxt", '위험수용');
				}
    	    } else {
    		   	$("#selCom_"+code).val("");
    		   	$("#selCom_"+code).attr("disabled","disabled");

    		   	$("#txt_"+code).val("");
    		   	$("#txt_"+code).attr("disabled","disabled");

    		   	$("#txtArea_"+code).val("");
    		   	$("#txtArea_"+code).attr("disabled","disabled");


    		   	$("#jqgridDtl").jqGrid("setCell", rowid, "risktxt", '-');
    	    }


		}

		function changeComplete(obj){

		}



		$(window).on('resize.jqGrid', function() {
			gridReSize();
		})

		function gridReSize(){
			$("#jqgridAst").jqGrid('setGridWidth', $("#jqgridDiv").width()-5);
			$("#jqgridDtl").jqGrid('setGridWidth', $("#jqgridDivDetail").width()-5);
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

			$("#form_list").hide();
			$("#div_detail").show();

			$(".wrap").after("<div class='overlay'></div>");

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

			gridReSize();
		}

		function actionClose(){
    	   	$("#form_list").show();
	    	$("#div_detail").hide();

    	   	$(".overlay").remove();

    	   	gridReSize();
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







