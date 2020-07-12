<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

	<link rel="stylesheet" href="../../resource/jqwidgets/styles/jqx.base.css" type="text/css" />
	<link rel="stylesheet" href="../../resource/jqwidgets/styles/jqx.light.css" type="text/css" />

	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/> ">


	<!-- 도움되는 콘솔 경고를 포함한 개발 버전 -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script> -->
	<!-- 상용버전, 속도와 용량이 최적화됨. -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/vue"></script> -->


	<!-- angular 1.6.7 -->
	<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
	<script src="<c:url value='/js/ncsys/bsc/admin/measureModule.js?V=0.0.1'/> "></script>

 	<!-- jqxTree  -->
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcore.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdata.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxtree.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdragdrop.js'/> "></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcheckbox.js'/> "></script>

	<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>
	<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>

<script type="text/javascript">

	var selectHerarchyUrl = "<c:url value='/admin/hierarchy/selectHierarchy.json'/>";
	var selectComponentUrl = "<c:url value='/admin/measure/selectComponent.json'/>";

	var selectMeasureDefineUrl = "<c:url value='/admin/measure/selectMeasureDefine.json'/>";
	var adjustMeasureDefineUrl = "<c:url value='/admin/measure/adjustMeasureDefine.json'/>";

	var selectMeasureUserUrl = "<c:url value='/admin/measure/selectMeasureUser.json'/>";
	var selectMeasureUpdaterUrl = "<c:url value='/admin/measure/selectMeasureUpdater.json'/>";

	var deleteMeasureDefineUrl = "<c:url value='/admin/measure/deleteMeasureDefine.json'/>";


</script>


	<script type="text/javascript">
		$(document).ready(function() {
				'use strict';
				// Create jqxTree

				// prepare the data

				// create jqxTree
				$('#jqxTree').jqxTree({
					allowDrag : false,
					allowDrop : false,
					source : null,
					width : '250px',
					dragStart : function(item) {
						if (item.label == "Community")
							return false;
					}
				});


				// on to 'expand', 'collapse' and 'select' events.
				$('#jqxTree').on('expand', function(event) {
							var args = event.args;
							var item = $('#jqxTree').jqxTree('getItem', args.element);

							//console.log("item.label : "+item.label);
							//$('#Events').jqxPanel('prepend', '<div style="margin-top: 5px;">Expanded: ' + item.label + '</div>');
						});
				$('#jqxTree').on('collapse', function(event) {
							var args = event.args;
							var item = $('#jqxTree').jqxTree('getItem', args.element);

							//console.log("item.label : "+item.label);
							//$('#Events').jqxPanel('prepend', '<div style="margin-top: 5px;">Collapsed: ' + item.label + '</div>');
						});
				$('#jqxTree').on('select', function(event) {
							var args = event.args;
							var item = $('#jqxTree').jqxTree('getItem', args.element);

							var scope = angular.element(document.getElementById("angularApp")).scope();

							var childCount = item.subtreeElement?item.subtreeElement.childElementCount:0;
							scope.changeTreeNode(item.level, item.id, item.value, item.parentId, childCount);

							//console.log("child count : "+childCount);
							//console.log("item property label:" + item.label + " level:" + item.level + " id:" + item.id + " contentid:" + item.value+" pid:" + item.parentId);
							//$('#Events').jqxPanel('prepend', '<div style="margin-top: 5px;">Selected: ' + item.label + '</div>');


						});

				function loadTree(year) {

					$('#jqxTree').jqxTree('clear');

					$('#jqxTree').jqxTree('render');

				}

				function refreshTree() {
					$('#jqxTree').jqxTree("refresh");
				}

				/* $("#btnSave").click(function() {

				})

				$("#btnAttr").click(function() {
					$(".wrap").after("<div class='overlay'></div>");

				}) */





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
	                url : 'selectMeasureList.json',
	            	datatype: 'local',
	            	mtype: "POST",
	            	postData : { "year":function() { return angular.element(document.getElementById("angularApp")).scope().entity.selYear.value; }
								,"bid":function() { return angular.element(document.getElementById("angularApp")).scope().entity.hierarchy.tId; } },
	                colNames: ['순번','관점','전략목표','성과지표','편집','가중치','주기','계량','단위','목표'],
	                colModel: [
						{ name: 'rowidx', width: "5%", align:'center' },
	                    { name: 'pname', width: "10%", align:'left', cellattr: arrtSetting },
	                    { name: 'oname', width: "20%", align:'left', cellattr: arrtSetting },
	                    { name: 'mname', width: "20%" },
	                    { name: 'mid', width: "5%", align:'center', formatter:btnFormatter },
	                    { name: 'weight', width: "5%", align:'right' },
	                    { name: 'frequency', width: "5%", align:'center'},
	                    { name: 'measurement', width: "5%", align: 'left'},
	                    { name: 'unit', width: "5%", align: 'left'},
	                    { name: 'planned', width: "5%", align: 'right'},
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
	                caption : "성과지표 목록",
	                rowNum  : 10000,
	                beforeSelectRow: function () {
	                    return false;
	                },
	                jsonReader: {
		                root : 'list',
		                id   : 'mid',
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

	            	var year = rowObject.year;
	            	var mcid = rowObject.mcid;


	            	var writer = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:actionEditMeasure('" + rowObject.year + "','" + mcid + "');\"><i class='fa fa-pencil'></i>"+"편집"+"</div>";


	            	return writer;
	            }

	            function isWritable(frq, mth){
	            	if(frq=="월") {
	            		return true;
	            	} else if (frq=="분기"){
	            		if(mth=="a03"||mth=="a06"||mth=="a09"||mth=="a12") return true;
	            		else return false;
	            	} else if (frq=="반기"){
	            		if(mth=="a06"||mth=="a12") return true;
	            		else return false;
	            	} else if (frq=="년"){
	            		if(mth=="a12") return true;
	            		else return false;
	            	}
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
				$("#selYear").change(function(){ reloadGrid(); });





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

	</script>



<title>Document</title>
<style type="text/css">
html, body {
	height: 100%;
	padding: 0;
	margin: 0;
	overflow: hidden;
}

#header {
	position: relative;
	display: block;
	height: 50px;
	margin: 0;
	z-index: 909;
	border: 1px solid #c1c1c1;
	background-color: #f6f6f6;
	padding-top: 8px;
}

#aside {
	position: absolute;
	display: block;
	top: 0;
	left: 0;
	bottom: 0;
	width: 250px;
	z-index: 901;
	padding-top: 50px;
	border: 0px solid #c1c1c1;
}

#section {
	position: absolute;
	top: 50px;
	left: 250px;
	right: 0px;
	/* bottom: 140px; */
	bottom: 0px;
	overflow: scroll;
	border: 1px solid #c1c1c1;
}

#footer {
	position: absolute;
	display: block;
	right: 0px;
	left: 250px;
	bottom: 0px;
	/* height: 140px; */
	height:0px;
	z-index: 900;
	border: 1px solid #c1c1c1;
}

.overlay {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 999;
	background: #eaeaea;
	opacity: 1.0;
	-ms- filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=30)";
}

.popup {
	position: absolute;
	top: 8px;
	left: 0%;
	z-index: 999999;
	width: 98%;
}

.jqx-tree {
float: left;
    width: 250px;
    display: block;
    position: absolute;
    left: 0;
    top: 50px;
    bottom: 23px;
    height:auto !important;
}

.ui-jqgrid .ui-jqgrid-htable th {
    background-color: #305086;
    color: #fff;
    background-image: none !important;;

}

.nc_th {
	height:28px;text-align:center;border:1px solid #c1c1c1;background-color:#4e6894;color:#fff;
}

.nc_auth {
	float: left;
    font-weight: 400;
    background-color: #eaeaea;
    border: 1px solid #ccc;
    height: 32px;
    padding-top: 6px;

}

.btn_padding_2{
	padding-top:2px;
	padding_bottom:2px;
}

#jqgridContent {
	margin : 10px;
}

</style>
</head>
<body>
	<div class="wrap" id="angularApp" ng-app="angularApp" ng-controller="angularController">
		<header id="header">
			<fieldset style="width: 100%;">
				<div class="form-group">
					<label class="control-label col-md-1" for="prepend" style="float:left; padding-top: 6px;">기준년도 </label>
					<div class="" style="position:relative; float:left; width:100px; padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md" style="width:100px;">
							<select class="form-control" id="selYear"
								ng-model="entity.selYear"
								ng-options="opt.value for opt in entity.years"
								ng-change="changeYear()">
							</select>
						</div>
					</div>

					<!-- <div class="col-md-1" style="padding-left: 0px;">
						<a ng-click="openProperties('C')" type="submit"
							class="btn btn-primary" style="width: 120px;"> 성과지표 추가 </a>
					</div> -->
				</div>
			</fieldset>
		</header>

		<aside id="aside">
			<!-- <a href="javascript:addSVGObject();">addIcon</a>	 -->
			<div id='jqxTree' style=''></div>
		</aside>

		<section id="section">
			<form action class="smart-form">
				<fieldset style="padding-top: 4px;">
					<section>
						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<div id="jqgridContent" style="" >
								    <table id="jqgrid"><tr><td /></tr></table>
								    <div id="pjqgrid"></div>
								</div>
							</div>
						</div>

						<div class="row" style="margin-top: 4px;float:right;padding-right:24px;">
							<div class="form-group">
								<a id="btnAdd" class="btn btn-primary" style="width: 98px;height:28px;padding-top:4px;" ng-click="openProperties('add');">성과지표추가 </a>
							</div>
						</div>
					</section>
				</fieldset>

			</form>
		</section>

		<footer id="footer">

		</footer>

		<div class="" id="div_properties" name="div_properties" style="display: none;">
			<popup-detail-properties></popup-detail-properties>
		</div>



		<div class="" id="div_measureUser" name="div_measureUser" style="display: none;">
			<popup-detail-measureuser></popup-detail-measureuser>
		</div>



	</div>

<script>
	function actionEditMeasure(year, mid){
		var scope = angular.element(document.getElementById("angularApp")).scope();
		scope.openProperties(mid);
	}
</script>



<!-- <script>
	var app = new Vue({
	  el: '#app',
	  data: {
	    message: '안녕하세요 Vue!'
	  }
	})
</script> -->
</body>
</html>





