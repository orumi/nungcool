<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">


<script type="text/javascript">
var selectInitUrl = "<c:url value='/eis/evalMng/selectInit.json'/>";
var selectOrgMeasUrl = "<c:url value='/eis/evalMng/selectOrgMeasure.json'/>";

var adjustOrgMeasUrl = "<c:url value='/eis/evalMng/adjustOrgMeasure.json'/>";
var deleteOrgMeasUrl = "<c:url value='/eis/evalMng/deleteOrgMeasure.json'/>";

var insertMeasComCdUrl = "<c:url value='/eis/evalMng/insertMeasComCd.json'/>";

var evalOrgYearCopyUrl = "<c:url value='/eis/evalMng/adjustEvalOrgYearCopy.json'/>";
var evalOrgMeasCopyUrl = "<c:url value='/eis/evalMng/adjustEvalOrgMeasCopy.json'/>";

var selectEvalOrgRstUrl = "<c:url value='/eis/evalMng/selectEvalOrgRst.json'/>";
var adjustEvalOrgRstUrl = "<c:url value='/eis/evalMng/adjustEvalOrgRst.json'/>";
var deleteEvalOrgRstUrl = "<c:url value='/eis/evalMng/deleteEvalOrgRst.json'/>";

var adjustEvalMeasRstUrl = "<c:url value='/eis/evalMng/adjustEvalMeasRst.json'/>";

//
</script>


<script type="text/javascript">
	$(document) .ready( function() {
		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		function funcSetDate(curYear) {
	        for (i=0,j=curYear-12; i<=13;i++,j++) {
	        	$("#selYear").append("<option value='"+j+"'>"+j+"</option>");
	        	$("#selFromYear").append("<option value='"+j+"'>"+j+"</option>");
	        	$("#selToYear").append("<option value='"+j+"'>"+j+"</option>");

	        }
	        $("#selYear").val(year-1);
	        $("#selFromYear").val(year-1);
	        $("#selToYear").val(year);

	    }

		selectInit();

		$("#selYear").change(function(){ selectInit(); });
		$("#selOrgMea").change(function(){ selectOrgMeasure(); });
		$("#selEvalOrg").change(function(){ selectEvalMeasRst(); });

	});

	function selectInit(){
    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectInitUrl, param)
    	.done(function(data){
    		setOrgMea(data.orgCd);
    		setMeasDiv(data.measDivCd);
    		setMeasGrp(data.measGrpCd);
    		setMeas(data.measCd);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}


	function setOrgMea(orgCd){
		$("#selOrgMea").empty();
		$("#selFromOrgCd").empty();
		$("#selToOrgCd").empty();

		for(var i in orgCd){
			$("#selOrgMea").append("<option value='"+orgCd[i].orgcd+"'>"+orgCd[i].orgnm+"</option>");
			$("#selFromOrgCd").append("<option value='"+orgCd[i].orgcd+"'>"+orgCd[i].orgnm+"</option>");
			$("#selToOrgCd").append("<option value='"+orgCd[i].orgcd+"'>"+orgCd[i].orgnm+"</option>");
			$("#selEvalOrg").append("<option value='"+orgCd[i].orgcd+"'>"+orgCd[i].orgnm+"</option>");
		}

		selectOrgMeasure();
		selectEvalOrgRst();
		selectEvalMeasRst();
	}

	function setMeasDiv(measDiv){
		$("#selMeasDiv").empty();
		for(var i in measDiv){
			$("#selMeasDiv").append("<option value='"+measDiv[i].measdivcd+"'>"+measDiv[i].measdivnm+"</option>");
		}
	}

	function setMeasGrp(measGrp){
		$("#selMeasGrp").empty();
		for(var i in measGrp){
			$("#selMeasGrp").append("<option value='"+measGrp[i].measgrpcd+"'>"+measGrp[i].measgrpnm+"</option>");
		}
	}

	function setMeas(meas){
		$("#selMeas").empty();
		for(var i in meas){
			$("#selMeas").append("<option value='"+meas[i].meascd+"'>"+meas[i].measnm+"</option>");
		}
	}

	function selectOrgMeasure(){
		var param = new Object();
    	param.year = $("#selYear option:selected").val();
		param.orgCd = $("#selOrgMea option:selected").val();

		_xAjax(selectOrgMeasUrl, param)
    	.done(function(data){
			displayOrgMeas(data.measList);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}

	var mHtml = "<tr role=\"row\" measCd=\"###measCd###\" measDivCd=\"###measDivCd###\" measGrpCd=\"###measGrpCd###\">";
	mHtml += "<td style=\"text-align: center;\">###measDivNm###</td>";
	mHtml += "<td style=\"text-align: left;\">###measGrpNm###</td>";
	mHtml += "<td style=\"text-align: left;\">###measNm###</td>";
	mHtml += "<td style=\"text-align: right;\">###weight###</td>";
	mHtml += "<td style=\"text-align: right;\">###dispOrd###</td>";
    mHtml += "</tr>";

    var curMea = null;
	function displayOrgMeas(meas){
		var curMea = null;
		$("#bd_orgMea").empty();

		for(var i in meas){
    		var aObj = meas[i];
    		var tmpHtml = mHtml.replace("###measCd###",aObj.measCd)
    		.replace("###measDivCd###",aObj.measDivCd)
    		.replace("###measGrpCd###",aObj.measGrpCd)
    		.replace("###measDivNm###",aObj.measDivNm?aObj.measDivNm:"")
    		.replace("###measGrpNm###",aObj.measGrpNm?aObj.measGrpNm:"")
    		.replace("###measNm###",aObj.measNm?aObj.measNm:"")
    		.replace("###weight###",aObj.weight?aObj.weight:"0")
    		.replace("###dispOrd###",aObj.dispOrd?aObj.dispOrd:"0")
			;
    		$("#bd_orgMea").append(tmpHtml);
    	}

		resetOrgMeas();

		$("#bd_orgMea tr").click(function(){
			actionClickOrgMea($(this));
		})
	}

	function actionClickOrgMea(rowObj){
    	$(curMea).removeClass("select_row");
    	curMea = $(rowObj)
    	$(curMea).addClass("select_row");
    	clickOrgMeasure();
    }


	function clickOrgMeasure(){
		var rwObj = $(curMea).children();
		var measDivCd = $(curMea).attr("measDivCd");
		var measGrpCd = $(curMea).attr("measGrpCd");
		var measCd = $(curMea).attr("measCd");

    	var weight = rwObj.eq(3).text();
    	var ord = rwObj.eq(4).text();

    	$("#selMeasDiv").val(measDivCd);
    	$("#selMeasGrp").val(measGrpCd);
    	$("#selMeas").val(measCd);

    	$("#txtWeight").val(weight);
    	$("#txtOrd").val(ord);

    	$("#selMeas").attr("disabled","disabled");

	}


	function actionAdjustOrgMeas(){

		if($("#txtWeight").val() == ""){
			alert("지표 배점을 입력하십시오.");
			return;
		}

		if($("#txtOrd").val() == ""){
			alert("정렬순서을 입력하십시오.");
			return;
		}



		var param = new Object();
    	param.year = $("#selYear option:selected").val();
		param.orgCd = $("#selOrgMea option:selected").val();

		$("#selMeas").removeAttr("disabled");
		param.measDivCd = $("#selMeasDiv").val();
		param.measGrpCd = $("#selMeasGrp").val();
		param.measCd = $("#selMeas").val();

		param.weight = $("#txtWeight").val();
		param.dispOrd = $("#txtOrd").val();

		_xAjax(adjustOrgMeasUrl, param)
    	.done(function(data){
			displayOrgMeas(data.measList);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}


	function actionDelOrgMeas(){
		if(confirm("선택한 지표를 삭제하시겠습니까?")){
			$("#selMeas").removeAttr("disabled");

			var param = new Object();
	    	param.year = $("#selYear option:selected").val();
			param.orgCd = $("#selOrgMea option:selected").val();

			param.measDivCd = $("#selMeasDiv").val();
			param.measGrpCd = $("#selMeasGrp").val();
			param.measCd = $("#selMeas").val();

			param.weight = $("#txtWeight").val();
			param.dispOrd = $("#txtOrd").val();

			_xAjax(deleteOrgMeasUrl, param)
	    	.done(function(data){
				displayOrgMeas(data.measList);
	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});
		}


	}


	function resetOrgMeas(){
		$("#selMeas").removeAttr("disabled");
		$("#txtWeight").val("");
		$("#txtOrd").val("");
	}











    function openMeasCdPopup(){
    	$("#div_properties").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closeMeasPopup(){
    	$("#div_properties").hide();
    	$(".overlay").remove();
    }



    function actionAddOrgMeas(){
    	var newOrgMeas = $("#txtNewOrgMeas").val();


    	var param = new Object();
		param.newOrgMeas = newOrgMeas;

		_xAjax(insertMeasComCdUrl, param)
    	.done(function(data){
    		closeMeasPopup();
    		setMeas(data.measCd);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }



    function openYearCopyPopup(){
    	$("#div_year_copy").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closeYearCopyPopup(){
    	$("#div_year_copy").hide();
    	$(".overlay").remove();
    }




    function openOrgMeasCopyPopup(){
    	$("#div_orgMeas_copy").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closeOrgMeasCopyPopup(){
    	$("#div_orgMeas_copy").hide();
    	$(".overlay").remove();
    }



    function actionYearCopy(){

		var param = new Object();
    	param.fromYear = $("#selFromYear option:selected").val();
		param.toYear = $("#selToYear option:selected").val();

		if(param.fromYear == param.toYear){
			alert("복사하고자 하는 연도가 같습니다.");
			return;
		}

		if(confirm("지표이관시 대상년도의 기존자료가 삭제 됩니다. \r\n지표이관작업을 진행하시겠습니까?")){
			_xAjax(evalOrgYearCopyUrl, param)
	    	.done(function(data){
				if(data.reCode == "SUCCESS"){
					alert("복사완료 되었습니다.");
					closeYearCopyPopup();
				}
	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});

		}
    }

    function actionOrgMeasCopy(){

		var param = new Object();
    	param.fromOrgCd = $("#selFromOrgCd option:selected").val();
    	param.toOrgCd = $("#selToOrgCd option:selected").val();
    	param.year = $("#selYear option:selected").val();

		if(param.fromOrgCd == param.toOrgCd){
			alert("복사하고자 하는 기관이 같습니다.");
			return;
		}

		if(confirm("지표이관시 대상년도의 기존자료가 삭제 됩니다. \r\n지표이관작업을 진행하시겠습니까?")){
			_xAjax(evalOrgMeasCopyUrl, param)
	    	.done(function(data){
				if(data.reCode == "SUCCESS"){
					alert("복사완료 되었습니다.");
					closeOrgMeasCopyPopup();
				}
	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});
		}

    }



    /* evalOrg eval  */

    function selectEvalOrgRst(){
    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	_xAjax(selectEvalOrgRstUrl, param)
    	.done(function(data){
    		displayEvalOrgRst(data.evalOrgRst);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }

    var orgHtml = "<tr role=\"row\" orgCd=\"###orgCd###\">";
    orgHtml += "<td style=\"\">###orgNm###</td>";
    orgHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###empBonus###\"/></td>";
    orgHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###chiefBonus###\"/></td>";
    orgHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###evalRank###\"/></td>";
    orgHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###evalScore###\"/></td>";
    orgHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###qtyMeas###\"/></td>";
    orgHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###qlyMeas###\"/></td>";
    orgHtml += "</tr>";

    function displayEvalOrgRst(evalOrgRst){
    	//bd_evalOrgRst
    	$("#bd_evalOrgRst").empty();

    	for(var i in evalOrgRst){
    		var aObj = evalOrgRst[i];
    		var tmpHtml = orgHtml.replace("###orgCd###",aObj.orgCd)
    		.replace("###orgNm###",  aObj.orgNm)
    		.replace("###empBonus###", aObj.empBonus?aObj.empBonus:"")
    		.replace("###chiefBonus###",aObj.chiefBonus?aObj.chiefBonus:"")
    		.replace("###evalRank###",aObj.evalRank?aObj.evalRank:"")
    		.replace("###evalScore###",aObj.evalScore?aObj.evalScore:"")
    		.replace("###qtyMeas###",aObj.qtyMeas?aObj.qtyMeas:"")
    		.replace("###qlyMeas###",aObj.qlyMeas?aObj.qlyMeas:"")
    		;

    		$("#bd_evalOrgRst").append(tmpHtml);
    	}

    }


    function adjustEvalOrgRst(){
    	var aParam = new Array();
    	$("#bd_evalOrgRst tr").each(function(i){
    		var trObj = $("#bd_evalOrgRst tr").eq(i);
    		var tdObj = trObj.children();
    		var pm = new Object();
			pm.year   = $("#selYear option:selected").val();
			pm.orgCd  = trObj.attr("orgCd");
			pm.empBonus  = tdObj.eq(1).find("input").val();
			pm.chiefBonus  = tdObj.eq(2).find("input").val();
			pm.evalRank  = tdObj.eq(3).find("input").val();
			pm.evalScore  = tdObj.eq(4).find("input").val();
			pm.qtyMeas  = tdObj.eq(5).find("input").val();
			pm.qlyMeas  = tdObj.eq(6).find("input").val();

			aParam.push(pm);
    	})


    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.evalOrgRst = JSON.stringify(aParam);

    	_xAjax(adjustEvalOrgRstUrl, param)
    	.done(function(data){
    		if(data.evalOrgRst.length > 0){
    			alert("저장되었습니다.");
    			displayEvalOrgRst(data.evalOrgRst);
    		}
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }

    function deleteEvalOrgRst(){
//deleteEvalOrgRstUrl

		if(confirm("결과정보를 삭제하시겠습니까?")){
			var param = new Object();
	    	param.year = $("#selYear option:selected").val();

	    	_xAjax(deleteEvalOrgRstUrl, param)
	    	.done(function(data){
    			alert("삭제 되었습니다.");
    			displayEvalOrgRst(data.evalOrgRst);
	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});
		}
    }









    function selectEvalMeasRst(){
    	//db_evalMeasRst
    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.orgCd = $("#selEvalOrg option:selected").val();

    	_xAjax(selectOrgMeasUrl, param)
    	.done(function(data){
    		displayEvalMeasRst(data.measList);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }

    var measHtml = "<tr role=\"row\" orgCd=\"###orgCd###\" measCd=\"###measCd###\" >";
	    measHtml += "<td style=\"\">###measDivNm###</td>";
	    measHtml += "<td style=\"\">###measGrpNm###</td>";
	    measHtml += "<td style=\"\">###measNm###</td>";
	    measHtml += "<td style=\"\">###weight###</td>";
	    measHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:left;\" value=\"###evalGrade###\"/></td>";
	    measHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###evalScore###\"/></td>";
	    measHtml += "</tr>";
    function displayEvalMeasRst(measList){
    	//db_evalMeasRst
    	$("#db_evalMeasRst").empty();
    	for(var i in measList){
    		var aObj = measList[i];
    		var tmpHtml = measHtml.replace("###orgCd###",aObj.orgCd)
    		.replace("###measCd###",  aObj.measCd)
    		.replace("###measDivNm###",  aObj.measDivNm)
    		.replace("###measGrpNm###", aObj.measGrpNm?aObj.measGrpNm:"")
    		.replace("###measNm###",aObj.measNm?aObj.measNm:"")
    		.replace("###weight###",aObj.weight?aObj.weight:"")
    		.replace("###evalScore###",aObj.evalScore?aObj.evalScore:"")
    		.replace("###evalGrade###",aObj.evalGrade?aObj.evalGrade:"")
    		.replace("###evalScore###",aObj.evalScore?aObj.evalScore:"")
    		;

    		$("#db_evalMeasRst").append(tmpHtml);
    	}
    }


    function adjustEvalMeasRst(){
    	//
    	var aParam = new Array();
    	$("#db_evalMeasRst tr").each(function(i){
    		var trObj = $("#db_evalMeasRst tr").eq(i);
    		var tdObj = trObj.children();
    		var pm = new Object();
			pm.year   = $("#selYear option:selected").val();
			pm.orgCd  = trObj.attr("orgCd");
			pm.measCd  = trObj.attr("measCd");
			pm.evalGrade  = tdObj.eq(4).find("input").val();
			pm.evalScore  = tdObj.eq(5).find("input").val();

			aParam.push(pm);
    	})


    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.orgCd = $("#selEvalOrg option:selected").val();
    	param.evalMeasRst = JSON.stringify(aParam);

    	_xAjax(adjustEvalMeasRstUrl, param)
    	.done(function(data){
    		if(data.measList.length > 0){
    			alert("저장되었습니다.");
    			displayEvalMeasRst(data.measList);
    		}
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
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
	bottom: 0px;
	overflow: scroll;
	border: 1px solid #c1c1c1;
}

#footer {
	position: absolute;
	display: block;
	right: 0px;
	left: 0px;
	bottom: 0px;
	height: 0px;
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
	top: 200px;
	left: 200px;
	right: 200px;
	z-index: 999999;
}

.jarviswidget>header {
    height: 39px;
}

.nc_td_grade{
	text-align: center;
	border-top: 1px solid #c1c1c1;
	border-right: 1px solid #c1c1c1;
	padding-top: 6px;
	padding-bottom: 6px;
}

.nc_inp {
	background-color: #e0e0e0;
    border: 1px solid #ababab;
}
.select_row {
	background-color: #8cc1e4 !important;
    color: #fff;
}

.table thead tr {
    background: #375f9c;
    background-color: #375f9c;
    background-image: -webkit-gradient(linear,0 0,0 100%,from(#375f9c),to(#395d9a));
	background-image: -webkit-linear-gradient(top,#375f9c 0,#395d9a 100%);
    color: #fff;
}
.table thead tr th{
    text-align: center;
}

#bd_orgMea tr{
	cursor:pointer;
}
#bd_sbuMapping tr{
	cursor:pointer;
}
#bd_bsc tr{
	cursor:pointer;
}
#bd_exceptEmp tr{
	cursor:pointer;
}
#bd_psnEmp tr{
	cursor:pointer;
}

#bd_psnJikgub input {
	border:1px solid #c1c1c1;
	height: 32px;
}

table td{
    text-overflow: ellipsis;
    overflow: hidden;
    /* white-space: nowrap; */
}
</style>
</head>
<body>
	<div class="wrap" id="paymentRateApp" >
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
				</div>
			</fieldset>
		</header>

		<section id="section">
			<div class="row">
				<article class="col-sm-12">
					<!-- new widget -->
					<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
						<!-- widget options:
						usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

						data-widget-colorbutton="false"
						data-widget-editbutton="false"
						data-widget-togglebutton="false"
						data-widget-deletebutton="false"
						data-widget-fullscreenbutton="false"
						data-widget-custombutton="false"
						data-widget-collapsed="true"
						data-widget-sortable="false"

						-->
						<header style="    margin-top: 12px;">
							<!-- <span class="widget-icon"> <i class="glyphicon glyphicon-th-list txt-color-darken"></i> </span>
							<h2>비전/전략 </h2> -->

							<ul class="nav nav-tabs pull-left in" id="myTab">
								<li class="active">
									<a data-toggle="tab" href="#s1"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">결과개요</span></a>
								</li>
								<li>
									<a data-toggle="tab" href="#s2"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">지표실적</span></a>
								</li>
								<li>
									<a data-toggle="tab" href="#s3"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">지표설정</span></a>
								</li>
							</ul>

						</header>

						<!-- widget div-->
						<div class="no-padding">
							<div class="widget-body" style="padding: 22px;">
								<!-- content -->
								<div id="myTabContent" class="tab-content" >


									<div class="tab-pane fade active in" id="s1">
										<div class="row no-space">
											<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
											<table width="100%" >
											<tr>

												<td style="text-align: right;">
													<a class="btn btn-primary btn-sm" onClick="javascript:adjustEvalOrgRst();">저장</a>
													<a class="btn btn-info btn-sm" onClick="javascript:deleteEvalOrgRst();">삭제</a>
												</td>
											</tr>
											</table>
											<table id="tb_evalOrgRst" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
												<thead>
													<tr role="row">
													<th rowspan="2" colspan="1" style="width:30%;vertical-align: middle;">그룹사</th>
													<th rowspan="2" colspan="1" style="width:15%;vertical-align: middle;">장려금 지급률</th>
													<th rowspan="2" colspan="1" style="width:15%;vertical-align: middle;">사장성과 지급률</th>
													<th rowspan="2" colspan="1" style="width:10%;vertical-align: middle;">평가순위</th>
													<th rowspan="1" colspan="3" style="width:30%;">득점</th>
													</tr>
													<tr role="row">
													<th rowspan="1" colspan="1" style="width:10%;">합계</th>
													<th rowspan="1" colspan="1" style="width:10%;">계량</th>
													<th rowspan="1" colspan="1" style="width:10%;">비계량</th>
													</tr>
												</thead>
												<tbody id="bd_evalOrgRst">

												</tbody>
											</table>

											</div>
										</div>
									</div>
									<!-- end s1 tab pane -->

									<div class="tab-pane fade" id="s2">
									<!-- 5등급 세부 배분표 -->

										<table width="100%" >
										<tr>
											<td style="text-align: left;">
												<label class="control-label col-md-2" for="prepend" style="padding-top: 6px;">그룹사 </label>
												<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;">
													<div class="icon-addon addon-md">
														<select class="form-control" id="selEvalOrg">
														</select>
													</div>
												</div>
											</td>
											<td style="text-align: right;">
												<a class="btn btn-primary btn-sm" onClick="javascript:adjustEvalMeasRst();">저장</a>
											</td>
										</tr>
										</table>

										<div id="" style="width:100%;height:450px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
										<table id="dt_basic" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
											<thead>
												<tr role="row">
												<th rowspan="1" colspan="1" style="width:10%;">구분</th>
												<th rowspan="1" colspan="1" style="width:10%;">부문</th>
												<th rowspan="1" colspan="1" style="width:20%;">지표명</th>
												<th rowspan="1" colspan="1" style="width:10%;">배점</th>
												<th rowspan="1" colspan="1" style="width:10%;">평가등급 및 순위</th>
												<th rowspan="1" colspan="1" style="width:10%;">득점</th>
												</tr>
											</thead>
											<tbody id="db_evalMeasRst">
											</tbody>
										</table>
										</div>


									</div>

									<div class="tab-pane fade" id="s3">
									<!-- 부서별 성과 지급률 -->

									<table width="100%" >
										<tr>
											<td style="text-align: left;">
												<label class="control-label col-md-2" for="prepend" style="padding-top: 6px;">그룹사 </label>
												<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;">
													<div class="icon-addon addon-md">
														<select class="form-control" id="selOrgMea">
														</select>
													</div>
												</div>
											</td>
											<td style="text-align: right;">
												<a class="btn btn-primary btn-sm" onClick="javascript:selectOrgMeasure();">조회</a>
											</td>
										</tr>
										</table>

										<div class="col-md-7" style="padding-right: 1px;padding-bottom: 30px;">
										<div id="" style="width:100%;height:450px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
										<table id="dt_orgMea" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
											<thead>
												<tr role="row">
												<th rowspan="1" colspan="1" style="width:10%;">구분</th>
												<th rowspan="1" colspan="1" style="width:10%;">부문</th>
												<th rowspan="1" colspan="1" style="width:24%;">지표명</th>
												<th rowspan="1" colspan="1" style="width:8%;">배점</th>
												<th rowspan="1" colspan="1" style="width:8%;">정렬순서</th>
												</tr>
											</thead>
											<tbody id="bd_orgMea">
											</tbody>
										</table>
										</div>
										</div>

										<div class="col-md-5" style="padding-right: 1px;padding-left: 40px;">
										<div class="row">
											<label class="control-label col-md-3" for="prepend" style="padding-top: 6px;">지표구분 </label>
											<div class="col-md-7" style="padding-right: 6px; padding-left: 1px; padding-bottom: 12px;">
												<div class="icon-addon addon-md">
													<select class="form-control" id="selMeasDiv">
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="control-label col-md-3" for="prepend" style="padding-top: 6px;">부 문 </label>
											<div class="col-md-7" style="padding-right: 6px; padding-left: 1px;padding-bottom: 12px;">
												<div class="icon-addon addon-md">
													<select class="form-control" id="selMeasGrp">
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="control-label col-md-3" for="prepend" style="padding-top: 6px;">지표 </label>
											<div class="col-md-9" style="padding-right: 6px; padding-left: 1px;padding-bottom: 12px;">
												<div class="icon-addon addon-md">
													<select class="form-control" id="selMeas">
													</select>
												</div>
											</div>
											<!-- <div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
												<a class="btn btn-primary btn-sm" onClick="javascript:seletePsnGrade();">...</a>
											</div> -->
										</div>
										<div class="row">
											<label class="control-label col-md-3" for="prepend" style="padding-top: 6px;">배점 </label>
											<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;padding-bottom: 12px;">
												<div class="icon-addon addon-md">
													<input class="form-control" id="txtWeight" />
												</div>
											</div>
										</div>
										<div class="row">
											<label class="control-label col-md-3" for="prepend" style="padding-top: 6px;">정렬순서 </label>
											<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;padding-bottom: 12px;">
												<div class="icon-addon addon-md">
													<input class="form-control" id="txtOrd" />
												</div>
											</div>
										</div>
										<br>
										<br>
										<br>
										<div class="row" style="margin-bottom: 24px;">
											<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;">
												<a class="btn btn-primary btn-sm" onClick="javascript:openMeasCdPopup();">지표코드 등록</a>
											</div>
											<div class="col-md-8" style="padding-right: 6px; padding-left: 1px;">
												<a class="btn btn-primary btn-sm" onClick="javascript:actionAdjustOrgMeas();">저장</a>
												<a class="btn btn-primary btn-sm" onClick="javascript:actionDelOrgMeas();">삭제</a>
												<a class="btn btn-primary btn-sm" onClick="javascript:resetOrgMeas();">취소</a>
											</div>
										</div>


										<div class="row" style="margin-bottom: 24px;">
											<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;">
												<a class="btn btn-primary btn-sm" onClick="javascript:openYearCopyPopup();">지표년도 복사</a>
											</div>
											<div class="col-md-8" style="padding-right: 6px; padding-left: 1px;">
												연도 변경시 지표복사를 통하여 일괄설정 후 그룹사별 지표를 추가, 수정, 삭제합니다.
											</div>
										</div>

										<div class="row" style="margin-bottom: 24px;">
											<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;">
												<a class="btn btn-primary btn-sm" onClick="javascript:openOrgMeasCopyPopup();">지표그룹사 복사</a>
											</div>
										</div>


										</div>
									</div>


									<!-- end s3 tab pane -->
								</div>

								<!-- end content -->
							</div>

						</div>
						<!-- end widget div -->
					</div>
					<!-- end widget -->

				</article>
			</div>
		</section>


	</div>







	<div class="" id="div_properties" name="div_properties" style="display: none;">
		<div class="popup">
			<form class="form-horizontal" id="form_meausre_updater_detail" name="form_meausre_updater_detail" style="padding:10px;">
			<section id="widget-yield" class="" >
				<div class="row">
					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget" id="wid-id-1" >
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
						<h2>평가지표 등록</h2>
					</header>

					<!-- widget div-->
					<div class="widget-content">
						<!-- widget content -->
						<div class="widget-body">
						<fieldset>
							<div class="col-md-10" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md">
									<input class="form-control" id="txtNewOrgMeas" />
								</div>
							</div>

						</fieldset>

						<fieldset style="margin-bottom: 20px;">
							<div class="form-group">
							   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
									<a onClick="closeMeasPopup()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
									<a onClick="actionAddOrgMeas()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">저장</a>

								</div>
							</div>
						</fieldset>
						</div>
					</div>
					</div>
					</article>

			    </div><!-- end of row   -->
			</section>

			</form>
		</div>
	</div>
		<!-- end of propertiy -->


	<div class="" id="div_year_copy" name="div_year_copy" style="display: none;">
		<div class="popup">
			<form class="form-horizontal" id="form_meausre_updater_detail" name="form_meausre_updater_detail" style="padding:10px;">
			<section id="widget-yield" class="" >
				<div class="row">
					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget" id="wid-id-1" >
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
						<h2>평가지표 등록</h2>
					</header>

					<!-- widget div-->
					<div class="widget-content">
						<!-- widget content -->
						<div class="widget-body">
						<fieldset>
						    <label class="control-label col-md-2" for="prepend" style="padding-top: 6px;">From </label>
							<div class="col-md-2" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md">
									<select class="form-control" id="selFromYear" >
									</select>
								</div>
							</div>
							<label class="control-label col-md-2" for="prepend" style="padding-top: 6px;">To </label>
							<div class="col-md-2" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md">
									<select class="form-control" id="selToYear" >
									</select>
								</div>
							</div>
						</fieldset>

						<fieldset style="margin-bottom: 20px;">
							<div class="form-group">
							   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
									<a onClick="closeYearCopyPopup()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
									<a onClick="actionYearCopy()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">저장</a>

								</div>
							</div>
						</fieldset>
						</div>
					</div>
					</div>
					</article>

			    </div><!-- end of row   -->
			</section>

			</form>
		</div>
	</div>
		<!-- end of year copy -->


<div class="" id="div_orgMeas_copy" name="div_orgMeas_copy" style="display: none;">
		<div class="popup">
			<form class="form-horizontal" id="form_meausre_updater_detail" name="form_meausre_updater_detail" style="padding:10px;">
			<section id="widget-yield" class="" >
				<div class="row">
					<!-- NEW WIDGET START -->
					<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget" id="wid-id-1" >
					<header>
						<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
						<h2>평가지표 등록</h2>
					</header>

					<!-- widget div-->
					<div class="widget-content">
						<!-- widget content -->
						<div class="widget-body">
						<fieldset>
							<label class="control-label col-md-2" for="prepend" style="padding-top: 6px;">From </label>
							<div class="col-md-3" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md">
									<select class="form-control" id="selFromOrgCd" >
									</select>
								</div>
							</div>
							<label class="control-label col-md-2" for="prepend" style="padding-top: 6px;">To </label>
							<div class="col-md-3" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md">
									<select class="form-control" id="selToOrgCd" >
									</select>
								</div>
							</div>

						</fieldset>

						<fieldset style="margin-bottom: 20px;">
							<div class="form-group">
							   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
									<a onClick="closeOrgMeasCopyPopup()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
									<a onClick="actionOrgMeasCopy()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">저장</a>

								</div>
							</div>
						</fieldset>
						</div>
					</div>
					</div>
					</article>

			    </div><!-- end of row   -->
			</section>

			</form>
		</div>
	</div>

</body>
</html>





