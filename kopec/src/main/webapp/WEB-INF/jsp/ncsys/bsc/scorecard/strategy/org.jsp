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
	<script src="<c:url value='/js/ncsys/bsc/scorecard/organizationModule.js'/> "></script>

 	<!-- jqxTree  -->
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcore.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdata.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxtree.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdragdrop.js'/> "></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcheckbox.js'/> "></script>

<script type="text/javascript">

	var selectMapsUrl = "<c:url value='/scorecard/strategy/selectMaps.json'/>";
	var selectIconsUrl = "<c:url value='/scorecard/strategy/selectIconScore.json'/>";


	var selectMapImagesUrl = "<c:url value='/admin/organization/selectMapImages.json'/>";


	var setMapPropertyUrl = "<c:url value='/admin/organization/setMapProperty.json'/>";
	var setMapIconsUrl = "<c:url value='/admin/organization/setMapIcons.json'/>";

	var uploadFileURL = "<c:url value='/admin/organization/uploadFile.json'/>";


	var showyear = "${config[0].showyear}";
	var showmonth = "${config[0].showmonth}";

</script>


<script type="text/javascript">
	$(document)
			.ready(
					function() {


					});


	function changeMonth(){
		clearSVGObject();
		var scope = angular.element(document.getElementById("organizationApp")).scope();

		if(scope.entity.icons.length>0){

			var idxMonth = Number($("#selMonth").val())-1;
			for(var i=0;i<scope.entity.icons.length;i++){
				var icon = scope.entity.icons[i];

				var color = getColor(icon.score[idxMonth]);
				icon.background = color.bgColor;
				icon.txtColor = color.txtColor;

				addSVGObject(icon);
			}
		}
	}

	function getColor(scr){
		var reVal = new Object();
		if(scr){
			var bgColor = "#c3c3c3";
			var txtColor = "#ffffff";

			if(scr >= 96){
				bgColor = "#0019ff";
			} else if (scr >= 91){
				bgColor = "#33e800";
			} else if (scr >= 86){
				txtColor = "#4c4c4c";
				bgColor = "#fdf000";
			} else if (scr >= 81){
				bgColor = "#fd9300";
			} else if(scr >= 0){
				bgColor = "#fd0000";
			}
			reVal.bgColor = bgColor;
			reVal.txtColor = txtColor;
		}
    	return reVal;
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
	left: 0px;
	right: 0px;
	bottom: 5px;
	/* overflow: scroll; */
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
								ng-options="opt as opt for opt in entity.years"
								ng-change="changeYear()">
							</select>
						</div>
					</div>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selMonth" onChange="javascript:changeMonth();">
								<option value="03">1분기</option>
								<option value="06">2분기</option>
								<option value="09">3분기</option>
								<option value="12">4분기</option>
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
				</div>
			</fieldset>
		</header>

		<section id="section">
			<div id="divCompus" style="display: table-cell;"></div>
		</section>


	</div>
</body>
</html>





