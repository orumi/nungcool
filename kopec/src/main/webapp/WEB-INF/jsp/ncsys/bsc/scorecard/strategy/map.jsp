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


<script type="text/javascript">
var selectBSCURL = "<c:url value='/scorecard/score/selectBSC.json'/>";
var selectStrategyUrl = "<c:url value='/scorecard/strategy/selectStrategy.json'/>";
var selectMapImagesUrl = "<c:url value='/admin/organization/selectMapImages.json'/>";




</script>


<script type="text/javascript">

	$(document) .ready( function() {
		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		//actionInit();

		$("#selYear").change(function(){ selectBSC(); });
		$("#selMonth").change(function(){actionPerformed(); });
		$("#selSbu").change(function(){changeSbu(); });
		$("#selBsc").change(function(){actionPerformed(); });

		function funcSetDate(curYear) {
	        for (i=0,j=curYear-6; i<=6;i++,j++) {
	        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
	        }
	        $("#selYear").val("${config[0].showyear}");
	        $("#selMonth").val("${config[0].showmonth}");
	    }

        // display background - image

		function displayBackgroundImage(){
			svgCompus.css('background-image', 'url(../../mapImage/strategy.jpg)');
			svgCompus.css('background-repeat', 'no-repeat');
			svgCompus.css('background-color', '#cde2f3');
		}

		displayBackgroundImage();

		var aBsc = new Array();

		function addBsc(bid, sid, bcid, bname){
			var bsc = new Object();
			bsc.bid = bid;
			bsc.sid = sid;
			bsc.bcid = bcid;
			bsc.bname = bname;

			aBsc.push(bsc);
		}

		var tmpSid = 0;
		var sidIdx = 0;
		function adjustHierarchy(sid, scid, sname, bid, bcid, bname){
			if(tmpSid != sid){
				var option = $("<option value='"+sid+"'>"+sname+"</option>");
	            $('#selSbu').append(option);

	            tmpSid = sid;
	            sidIdx++
			}

			if(sidIdx == 1){
				var bOpt = $("<option value='"+bid+"'>"+bname+"</option>");
	            $('#selBsc').append(bOpt);
			}
			addBsc(bid, sid, bcid, bname);
		}

		function changeSbu(){
			var selId = $('#selSbu').val();
			$('#selBsc').empty();

			for(var i in aBsc){
				if(selId == aBsc[i].sid){
					var bOpt = $("<option value='"+aBsc[i].bid+"'>"+aBsc[i].bname+"</option>");
		            $('#selBsc').append(bOpt);
				}
			}

			actionPerformed();
		}


		<c:forEach var="bsc" items="${sbuBsc}" varStatus="status">
			adjustHierarchy('${bsc.sid}','${bsc.scid}','${bsc.sname}','${bsc.bid}','${bsc.bcid}','${bsc.bname}');
		</c:forEach>



		setTimeout(function(){
			actionPerformed();
		},1000);


		function selectBSC(){
	    	var param = new Object();
	    	param.year = $("#selYear option:selected").val();

	    	_xAjax(selectBSCURL, param)
	    	.done(function(data){
	    		adjustBSC(data.sbuBsc);
	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});
		}

		function adjustBSC(bsc){
			aBsc = new Array();
			$('#selSbu').empty();
			$('#selBsc').empty();
			tmpSid = 0;
			sidIdx = 0;

			for(var i in bsc){
	    		var aObj = bsc[i];
	    		adjustHierarchy(aObj.sid,aObj.scid,aObj.sname,aObj.bid,aObj.bcid,aObj.bname);
			}

			actionPerformed();
		}

	});





	function actionPerformed(){
		clearSVGObject();
		var param = new Object();
		param.year = $("#selYear option:selected").val();
		param.month = $("#selMonth option:selected").val();
		param.bid = $("#selBsc option:selected").val();

		_xAjax(selectStrategyUrl, param)
		.done(function(data){
			displayStrategicMap(data.selectStrategicMap);
		}).fail(function(error){
			console.log("actionInit error : "+error);
		});

	}



	function displayStrategicMap(map){
		var positionY = 10;
		var height = 120;
		var pid = 0;
		var rIdx = 0;

		for(var i in map){
			var mapObj = map[i];
			var xyObj = getXY(mapObj.orow, mapObj.rowidx, mapObj.rowsum);
			var pY = xyObj.y;
			if(pid != mapObj.pid){
				pid = mapObj.pid;
				positionY = positionY + height;
				rIdx = 0;

				var pst = new Object();
				pst.x = 10;
				pst.y = positionY-10;
				pst.width = 150;
				pst.height = 100;
				pst.text = mapObj.pname;
				addPst(pst);
			}
			if(rIdx != mapObj.rowidx){
				rIdx = mapObj.rowidx;
				positionY = positionY + height;
			}

			var color = getColor(mapObj.ocscore);
			var icon = new Object();
			icon.iconstyle = "e";
			icon.x = xyObj.x;
			icon.y = positionY;
			icon.width = "240";
			icon.height = "60";
			icon.showtext = "";
			icon.showscore = "";
			icon.fixed = "Y";
			icon.text = mapObj.oname;
			icon.background = color.bgColor;
			icon.txtColor = color.txtColor;
			addSVGObject(icon);

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
			} else {
				bgColor = "#fd0000";
			}
			reVal.bgColor = bgColor;
			reVal.txtColor = txtColor;
		}
    	return reVal;
	}


	var strPst    = '<svg id="id_svg" style="left:##posLeft##px;top:##posTop##px;width:##posWidth##px;height:##posHeight##px;position:absolute" class="mySvgs"> '
		+' <rect id="id_element" x=0 y=0 width=100% height=100% stroke="#969696" stroke-width="1" fill="#4067a2" /> '
		+' <text id="id_element_text" x="50%" y="55%" alignment-baseline="middle" text-anchor="middle" font-size="14" fill="#ffffff">##pname##</text> '
	+'</svg>';
	function addPst(pst){
		var tmpPst = strPst.replace("##pname##",pst.text).replace("##posLeft##",pst.x).replace("##posTop##",pst.y).replace("##posWidth##",pst.width).replace("##posHeight##",pst.height);
		svgCompus.append( tmpPst );
	}

	function getXY(row, rowIdx, rowSum){
		var obj = new Object();
		// x position
		switch(rowSum){
		case 1:
			obj.x=450
			break;
		case 2:
			switch(row){
			case 1:
				obj.x=325;
				break;
			case 2:
				obj.x=575;
				break;
			}
			break;
		case 3:
			switch(row){
			case 1:
				obj.x=200;
				break;
			case 2:
				obj.x=450;
				break;
			case 3:
				obj.x=700;
				break;
			}
			break;
		}
		obj.y = Number(rowIdx)*80;

		return obj;
	}








    function _xAjax(url, param){
    	var deferred = $.Deferred();
		$.ajax({
			url     :  url,
			type    : 'POST',
			data    : param,
			dataType: 'json',
			success : function(data){
				deferred.resolve(data);
			},
			error   : function(err){
		    	deferred.reject(err);
			}
		});
		return deferred.promise();
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
	<div class="wrap">
		<header id="header">
			<fieldset style="width: 100%;">
				<div class="form-group">
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;">기준년도 </label>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selYear">
							</select>
						</div>
					</div>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selMonth">
								<option value="03">1분기</option>
								<option value="06">2분기</option>
								<option value="09">3분기</option>
								<option value="12">4분기</option>
							</select>
						</div>
					</div>
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;text-align: right;">조직 </label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select type="text" class="form-control" id="selSbu" >
							</select>
						</div>
					</div>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select type="text" class="form-control" id="selBsc">
							</select>
						</div>
					</div>
					<div class="col-md-1" style="padding-left: 1px;">
						<a id="btnSave" class="btn btn-primary" style="width: 68px;" onclick="actionPerformed();"> 조 회 </a>
					</div>

				</div>
			</fieldset>
		</header>

		<section id="section" style="">
			<div id="divCompus" style="display: table-cell;"></div>
		</section>

	</div>
</body>
</html>





