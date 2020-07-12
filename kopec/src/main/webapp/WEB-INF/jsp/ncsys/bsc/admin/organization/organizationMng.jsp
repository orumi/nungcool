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
	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/css/fileupload/jquery.fileupload.css'/> ">
	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/css/fileupload/jquery.fileupload-ui.css'/> ">

    <!-- Move&ResizeTool   -->
	<script src="<c:url value='/jsp/svg/js/MoveAndResizeTool.js'/>"></script>
	<script src="<c:url value='/jsp/svg/js/svgController.js'/> "></script>

	<!-- angular 1.6.7 -->
	<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
	<script src="<c:url value='/js/ncsys/bsc/admin/organizationModule.js'/> "></script>

 	<!-- jqxTree  -->
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcore.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdata.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxtree.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdragdrop.js'/> "></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcheckbox.js'/> "></script>

<script type="text/javascript">
	var selectHerarchyUrl = "<c:url value='/admin/organization/selectHierarchy.json'/>";
	var setMapPropertyUrl = "<c:url value='/admin/organization/setMapProperty.json'/>";
	var setMapIconsUrl = "<c:url value='/admin/organization/setMapIcons.json'/>";
	var selectIconsUrl = "<c:url value='/admin/organization/selectIcons.json'/>";

	var selectMapImagesUrl = "<c:url value='/admin/organization/selectMapImages.json'/>";


	var uploadFileURL = "<c:url value='/admin/organization/uploadFile.json'/>";


</script>


<script type="text/javascript">
	$(document)
			.ready(
					function() {
						// Create jqxTree

						// prepare the data

						// create jqxTree
						$('#jqxTree').jqxTree({
							allowDrag : true,
							allowDrop : true,
							source : null,
							width : '250px',
							dragStart : function(item) {
								if (item.label == "Community")
									return false;
							}
						});

						$("#jqxTree").on('dragStart', function(event) {
							console.log("dragStart :" + event.args.label);
							//var data = event.getData("text");

							//console.log("data : "+data);
						});

						$("#jqxTree").on('dragEnd',function(event) {
											if (event.args.label) {
												var srcItem = event.owner._dragItem;
												var ev = event.args.originalEvent;
												var x = ev.pageX;
												var y = ev.pageY;

												if (event.args.originalEvent
														&& event.args.originalEvent.originalEvent
														&& event.args.originalEvent.originalEvent.touches) {
													var touch = event.args.originalEvent.originalEvent.changedTouches[0];
													x = touch.pageX;
													y = touch.pageY;
												}

												console.log("X:" + x);

												var offset = $("#section").offset();
												var width = $("#section").width();
												var height = $("#section").height();
												var right = parseInt(offset.left) + width;
												var bottom = parseInt(offset.top) + height;

												//console.log("offset :: left : " + parseInt(offset.left) + " top : " + parseInt(offset.top) + " label : " + event.args.label);
												//console.log("offset :: width : " + width + " height : " + height + " label : " + event.args.label);
												//console.log("offset :: right : " + right + " bottom : " + bottom + " label : " + event.args.label);

												var scope = angular.element(document.getElementById("organizationApp")).scope();
												var curMap = scope.entity.curMap;

												//console.log("scope width : "+scope.entity.map.iconWidth);

												if (x >= parseInt(offset.left) && x <= right) {
													if (y >= parseInt(offset.top) && y <= bottom) {
														var ix = x - parseInt(offset.left);
														var iy = y - parseInt(offset.top);

														var icon = new Object();
														icon.treeid = srcItem.id;
														icon.treelevel = srcItem.level;
														icon.x = ix;
														icon.y = iy;
														icon.width = curMap.iconWidth;
														icon.height = curMap.iconHeight;
														icon.iconstyle = curMap.iconShape;
														icon.showtext = curMap.showtext;
														icon.showscore = curMap.showscore;
														icon.icontext = event.args.label;

														addSVGObject(icon);
													}
												}

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

									//console.log("item property label:" + item.label + " value:" + item.id + " id:" + item.id + " pid:" + item.parentElement.id);
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
	bottom: 140px;
	overflow: scroll;
	border: 1px solid #c1c1c1;
}

#footer {
	position: absolute;
	display: block;
	right: 0px;
	left: 250px;
	bottom: 0px;
	height: 140px;
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
</style>
</head>
<body>
	<div class="wrap" id="organizationApp" ng-app="organizationApp" ng-controller="organizationController">
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

					<div class="col-md-4" style="padding-right: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selMaps" ng-model="entity.selMapId" ng-change="changeMapList()">
								<option ng-repeat="option in entity.maps" value="{{option.id}}">{{option.mapname}}</option>
							</select>
						</div>
					</div>
					<div class="col-md-1" style="padding-left: 1px;">
						<a id="btnSave" class="btn btn-primary" style="width: 68px;" ng-click="actionPerformed('updateIcons');"> 저 장 </a>
					</div>

					<div class="col-md-1" style="padding-left: 12px;">
						<a id="btnAttr" ng-click="openProperties('U')" type="submit" class="btn btn-primary"
							style="width: 68px;"> 속 성 </a>
					</div>
					<div class="col-md-1" style="padding-left: 0px;">
						<a ng-click="openProperties('C')" type="submit"
							class="btn btn-primary" style="width: 120px;"> 새로만들기 </a>
					</div>
				</div>
			</fieldset>
		</header>

		<aside id="aside">
			<!-- <a href="javascript:addSVGObject();">addIcon</a>	 -->
			<div id='jqxTree' style='float: left;'></div>
		</aside>

		<section id="section">

			<div id="divCompus" style="display: table-cell;"></div>
		</section>

		<footer id="footer">
			<form action class="smart-form">
				<fieldset style="padding-top: 4px;">
					<section>
						<div class="row">
							<div class="form-group">
								<label class="control-label col-md-1" for="prepend"
									style="text-align: right; padding: 6px 11px;">아이콘TEXT</label>
								<div class="col-md-4" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control"
											ng-model="entity.icon.icontext" />
									</div>
								</div>
								<label class="control-label col-md-1" for="prepend"
									style="text-align: right; padding: 6px 11px;">모양</label>
								<div class="col-md-1" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<select type="text" class="form-control" ng-model="entity.icon.iconstyle">
											<option value="e">타원형</option>
											<option value="r">사각형</option>
										</select>
									</div>
								</div>
								<!-- <div class="col-md-1"
									style="padding-top: 4px; padding-left: 40px;">
									<label class="checkbox"> <input type="checkbox"
										class="form-control" ng-model="entity.icon.showtext" /> <i></i>
										글자표시
									</label>
								</div>
								<div class="col-md-1"
									style="padding-top: 4px; padding-left: 40px;">
									<label class="checkbox"> <input type="checkbox"
										class="form-control" ng-model="entity.icon.showscore" /> <i></i>
										점수표시
									</label>
								</div> -->
							</div>
						</div>
						<div class="row" style="margin-top: 4px;">
							<div class="form-group">
								<label class="control-label col-md-1" for="prepend"
									style="text-align: right; padding: 6px 11px;">넓이</label>
								<div class="col-md-1" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control"
											ng-model="entity.icon.width" />
									</div>
								</div>
								<label class="control-label col-md-1" for="prepend"
									style="text-align: right; padding: 6px 11px;">높이</label>
								<div class="col-md-1" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control"
											ng-model="entity.icon.height" />
									</div>
								</div>
								<label class="control-label col-md-1" for="prepend"
									style="text-align: right; padding: 6px 11px;">위치(X)</label>
								<div class="col-md-1" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control"
											ng-model="entity.icon.x" />
									</div>
								</div>
								<label class="control-label col-md-1" for="prepend"
									style="text-align: right; padding: 6px 11px;">위치(Y)</label>
								<div class="col-md-1" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control"
											ng-model="entity.icon.y" />
									</div>
								</div>

							</div>
						</div>
						<div class="row" style="margin-top: 4px;float:right;padding-right:24px;">
							<div class="form-group">
								<a id="btnIconSave" class="btn btn-primary" style="width: 68px;height:28px;" ng-click="actionPerformed('iconSave');">선택적용 </a>
								<a id="btnIconAllSave" class="btn btn-primary" style="width: 68px;height:28px;" ng-click="actionPerformed('iconAllSave');">전체적용 </a>
								<a id="btnIconDelete" class="btn btn-primary" style="width: 68px;height:28px;" ng-click="actionPerformed('iconDelete');">삭제 </a>
							</div>
						</div>
					</section>
				</fieldset>

			</form>
		</footer>

		<div class="" id="div_properties" name="div_properties" style="display: none;">
			<popup-map-properties></popup-map-properties>
		</div>

	</div>
</body>
</html>





