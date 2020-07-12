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
	<script src="<c:url value='/js/ncsys/bsc/admin/hierarchyModule.js'/> "></script>

 	<!-- jqxTree  -->
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcore.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdata.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxtree.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdragdrop.js'/> "></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcheckbox.js'/> "></script>

<script type="text/javascript">

	var selectHerarchyUrl = "<c:url value='/admin/hierarchy/selectHierarchy.json'/>";
	var selectComponentUrl = "<c:url value='/admin/hierarchy/selectComponent.json'/>";

	var adjusttHierarchyUrl = "<c:url value='/admin/hierarchy/adjusttHierarchy.json'/>";


</script>


<script type="text/javascript">
	$(document)
			.ready(
					function() {
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

					});
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
</style>
</head>
<body>
	<div class="wrap" id="angularApp" ng-app="angularApp" ng-controller="angularController">
		<header id="header">
			<fieldset style="width: 100%;">
				<div class="form-group">
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;">기준년도 </label>
					<div class="col-md-1"
						style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
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
								<label class="control-label col-md-1" for="prepend" style="text-align: right; padding: 6px 11px;">조직단위</label>
								<div class="col-md-4" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<select id="selCom" class="form-control" ng-model="entity.selCompany">
											<option ng-repeat="option in entity.company" value="{{option.id}}">{{option.name}} [{{option.id}}]</option>
										</select>
									</div>
								</div>
								<label class="control-label col-md-1" for="prepend" style="text-align: right; padding: 6px 11px;">정렬순서</label>
								<div class="col-md-1" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" id="txtComOrder" class="form-control" style="text-align: right" ng-model="entity.hierarchy.crank">
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-1" for="prepend" style="text-align: right; padding: 6px 11px;">사업단위</label>
								<div class="col-md-4" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<select id="selSbu" class="form-control" ng-model="entity.selSbu">
											<option ng-repeat="option in entity.sbu" value="{{option.id}}">{{option.name}} [{{option.id}}]</option>
										</select>									</div>
								</div>
								<label class="control-label col-md-1" for="prepend" style="text-align: right; padding: 6px 11px;">정렬순서</label>
								<div class="col-md-1" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" id="txtComOrder" class="form-control" style="text-align: right" ng-model="entity.hierarchy.srank">
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-1" for="prepend" style="text-align: right; padding: 6px 11px;">부서단위</label>
								<div class="col-md-4" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<select id="selBsc" class="form-control" ng-model="entity.selBsc">
											<option ng-repeat="option in entity.bsc" value="{{option.id}}">{{option.name}} [{{option.id}}]</option>
										</select>									</div>
								</div>
								<label class="control-label col-md-1" for="prepend" style="text-align: right; padding: 6px 11px;">정렬순서</label>
								<div class="col-md-1" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" id="txtComOrder" class="form-control" style="text-align: right" ng-model="entity.hierarchy.brank">
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-12" for="prepend" style="text-align: left; padding: 6px 32px;">
									※ 신규 부서 추가시 같은 상위 노드가 존재하면 정렬순서는 기존 정렬순서로 저장됩니다.
								</label>
							</div>
						</div>

						<div class="row" style="margin-top: 4px;float:right;padding-right:24px;">
							<div class="form-group">
								<a id="btnCancel" class="btn btn-primary" style="width: 68px;height:28px;padding-top:4px;" ng-click="actionPerformed('cancel');">취소 </a>
								<a id="btnAdd" class="btn btn-primary" style="width: 68px;height:28px;padding-top:4px;" ng-click="actionPerformed('add');">조직추가 </a>
								<a id="btnMod" class="btn btn-primary" style="width: 68px;height:28px;padding-top:4px;" ng-click="actionPerformed('mod');">수정 </a>
								<a id="btnDel" class="btn btn-primary" style="width: 68px;height:28px;padding-top:4px;" ng-click="actionPerformed('del');">삭제 </a>
							</div>
						</div>
					</section>
				</fieldset>

			</form>
		</section>

		<footer id="footer">

		</footer>


	</div>

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





