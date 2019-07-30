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


		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>

		<script type="text/javascript">

		var boardDetailURL = "<c:url value='/cool/bbs/boardArticleDetail.json'/>";

		var header = $("meta[name='_csrf_header']").attr("content");
		var token = $("meta[name='_csrf']").attr("content");

		</script>

		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/bbs/boardModule.js'/>"></script>

<!-- MAIN CONTENT -->
<div class="wrap" id="boardApp" ng-app="boardApp" ng-controller="boardController">
<div id="content" >
				<!-- LIST CONTENT -->
				<form class="form-horizontal" id="form_list" name="form_list">
				<input type="hidden" name="bbsId" id="bbsId" value="${boardVO.bbsId}">
				<input type="hidden" name="bbsAttrbCode" id="bbsAttrbCode" value="${boardVO.bbsAttrbCode}">

				<!-- widget grid -->
				<section id="widget-base" class="" >

					<!-- row -->
					<div class="row">

						<!-- NEW WIDGET START -->
						<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

							<div class="jarviswidget" id="wid-id-1" >

								<header>
									<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
									<h2>자료실</h2>
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
 					<popup-board-detail></popup-board-detail>
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

            $("#jqgrid").jqGrid({
                url : 'boardArticleList.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : {"bbsId":function() { return $("#bbsId").val(); }, "bbsAttrbCode":function() { return $("#bbsAttrbCode").val(); }  },

            	<c:if test="${boardVO.bbsAttrbCode == 'BBSA01'}">
            	colNames: ['번호', '제목', '게시시작','게시종료', '작성자', '작성일', '조회수'],
                colModel: [
					{ name: 'nttId',    width: "5%", align: 'center' },
                    { name: 'nttSj', width: "20%", align: 'left', formatter:actionOpenDetail },
                    { name: 'ntceBgnde', width: "10%", align: 'center' },
                    { name: 'ntceEndde', width: "10%", align: 'center' },
                    { name: 'frstRegisterNm', width: "10%", align: 'center' },
                    { name: 'frstRegisterPnttm', width: "10%",align: 'center' },
                    { name: 'inqireCo', width:"5%", align: "center"},
                ],
                </c:if>
            	<c:if test="${boardVO.bbsAttrbCode == 'BBSA03'}">
            	colNames: ['번호', '제목', '작성자', '작성일', '조회수'],
                colModel: [
					{ name: 'nttId',    width: "5%", align: 'center' },
                    { name: 'nttSj', width: "20%", align: 'left', formatter:actionOpenDetail },
                    { name: 'frstRegisterNm', width: "10%", align: 'center' },
                    { name: 'frstRegisterPnttm', width: "10%",align: 'center' },
                    { name: 'inqireCo', width:"5%", align: "center"},
                ],
                </c:if>

                cmTemplate: {sortable: false},
                rowNum: 10,
                rowList: [5, 10, 20],
                pager : '#pjqgrid',
                loadtext : ' 로딩중..',
                gridview: true,
                hoverrows: false,
                autoencode: true,
                autowidth: true,
                ignoreCase: true,
                viewrecords: true,
                height: '100%',
                caption : "통제목록 정보",
                /* rowNum  : 10000, */
                beforeSelectRow: function () {
                    return false;
                },
                jsonReader: {
	                root : 'reBoardVO',
	                id   : 'nttId',
 	                page : 'pageMaker.cri.crtPage',
	                total: 'pageMaker.totPage',
	                records: 'pageMaker.totCnt',
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

            function actionOpenDetail(cellValue, options, rowObject){
            	var str = "<div style='cursor:pointer;' onclick=\"javascript:actionEdit('" + rowObject.nttId + "');\">"+cellValue+"</div>";

            	return str;
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

		function actionEdit(nttId){
			$("#form_list").hide();
			$("#div_detail").show();

			$(".wrap").after("<div class='overlay'></div>");

			var scope = angular.element(document.getElementById("boardApp")).scope();

			if(oEditors.length ==0 ){
				createEditArea();
			}

			if(nttId != 0){
				scope.actionSelectDetail(nttId);
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



    </script>




