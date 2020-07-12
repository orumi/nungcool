<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">



<script type="text/javascript">
	var selectOrgCodeURL = "<c:url value='/eis/evaluation/selectOrgCode.json'/>";

	var selectEvalMeaRstURL = "<c:url value='/eis/evaluation/selectEvalMeaRst.json'/>";

	var selectEvalMeasQtyRstURL = "<c:url value='/eis/evaluation/selectEvalMeasQtyRst.json'/>";

</script>


<script type="text/javascript">



$(document) .ready( function() {
	$('form').bind('submit', function () {return false})
	var date = new Date();
	var year = date.getFullYear();
	funcSetDate(year);
	//actionInit();

	$("#selYear").change(function(){ actionPerformed(); });
	$("#btnExcel").click(function(){ actionDownloadCSVWithHeader('tb_evalMeasRst'); });


	$("#searchName").keydown(function (key) { //검색창에서 Enter눌렀을 때 검색
	          if (key.keyCode == 13) {
	          	searchEvaler();
	          }
	      });

	function funcSetDate(curYear) {
        for (i=0,j=curYear-12; i<=12;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear").val(curYear-1);

        actionInit();
        actionPerformed();
    }

	function actionInit(){
		//selectOrgCodeURL
		//selOrgCd
		var param = new Object();

    	_xAjax(selectOrgCodeURL, param)
    	.done(function(data){
			setOrgCd(data.orgCd);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

	}

	function setOrgCd(orgCd){
		$("#selOrgCd").empty();
		for(var i in orgCd){
			$("#selOrgCd").append("<option value='"+orgCd[i].orgcd+"'>"+orgCd[i].orgnm+"</option>");
		}
	}

    function actionPerformed(){
    	$("#db_evalMeasQty").empty();

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectEvalMeaRstURL, param)
    	.done(function(data){

			displayEvalMeaRst(data.evalOrgRst);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }

    var sHtml = "<tr role=\"row\" >";
    sHtml += "<td style=\"\">###measDivNm###</td>";
    sHtml += "<td style=\"text-align: left;\">###measGrpNm###</td>";
    sHtml += "<td style=\"text-align: left;\">###measNm###</td>";
    sHtml += "<td style=\"text-align: right;\">###weight###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade00###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore00###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade01###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore01###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade02###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore02###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade03###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore03###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade07###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore07###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade08###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore08###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade09###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore09###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade10###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore10###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade11###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore11###</td>";
    sHtml += "<td style=\"text-align: right;\">###evalGrade12###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeScore12###</td>";
    sHtml += "</tr>";


    function displayEvalMeaRst(evalOrgRst){
    	//bd_evalOrgRst
    	$("#bd_evalMeasRst").empty();

    	var totObj = new Object();
    	totObj.weight = 0;
    	totObj.evalGrade00 = 0;
    	totObj.gradeScore00 = 0;
    	totObj.evalGrade01 = 0;
    	totObj.gradeScore01 = 0;
    	totObj.evalGrade02 = 0;
    	totObj.gradeScore02 = 0;
    	totObj.evalGrade03 = 0;
    	totObj.gradeScore03 = 0;
    	totObj.evalGrade07 = 0;
    	totObj.gradeScore07 = 0;
    	totObj.evalGrade08 = 0;
    	totObj.gradeScore08 = 0;
    	totObj.evalGrade09 = 0;
    	totObj.gradeScore09 = 0;
    	totObj.evalGrade10 = 0;
    	totObj.gradeScore10 = 0;
    	totObj.evalGrade11 = 0;
    	totObj.gradeScore11 = 0;
    	totObj.evalGrade12 = 0;
    	totObj.gradeScore12 = 0;
    	for(var i in evalOrgRst){
    		var aObj = evalOrgRst[i];
    		var tmpHtml = sHtml.replace("###measDivNm###",aObj.measDivNm)
    		.replace("###measGrpNm###",aObj.measGrpNm?aObj.measGrpNm:"")
    		.replace("###measNm###",aObj.measNm?aObj.measNm:"")
    		.replace("###weight###",aObj.weight?aObj.weight:"0")
    		.replace("###evalGrade00###",aObj.evalGrade00?aObj.evalGrade00:"")
    		.replace("###gradeScore00###",aObj.gradeScore00?aObj.gradeScore00:"")
    		.replace("###evalGrade01###",aObj.evalGrade01?aObj.evalGrade01:"")
    		.replace("###gradeScore01###",aObj.gradeScore01?aObj.gradeScore01:"")
    		.replace("###evalGrade02###",aObj.evalGrade02?aObj.evalGrade02:"")
    		.replace("###gradeScore02###",aObj.gradeScore02?aObj.gradeScore02:"")
    		.replace("###evalGrade03###",aObj.evalGrade03?aObj.evalGrade03:"")
    		.replace("###gradeScore03###",aObj.gradeScore03?aObj.gradeScore03:"")
    		.replace("###evalGrade07###",aObj.evalGrade07?aObj.evalGrade07:"")
    		.replace("###gradeScore07###",aObj.gradeScore07?aObj.gradeScore07:"")
    		.replace("###evalGrade08###",aObj.evalGrade08?aObj.evalGrade08:"")
    		.replace("###gradeScore08###",aObj.gradeScore08?aObj.gradeScore08:"")
    		.replace("###evalGrade09###",aObj.evalGrade09?aObj.evalGrade09:"")
    		.replace("###gradeScore09###",aObj.gradeScore09?aObj.gradeScore09:"")
    		.replace("###evalGrade10###",aObj.evalGrade10?aObj.evalGrade10:"")
    		.replace("###gradeScore10###",aObj.gradeScore10?aObj.gradeScore10:"")
    		.replace("###evalGrade11###",aObj.evalGrade11?aObj.evalGrade11:"")
    		.replace("###gradeScore11###",aObj.gradeScore11?aObj.gradeScore11:"")
    		.replace("###evalGrade12###",aObj.evalGrade12?aObj.evalGrade12:"")
    		.replace("###gradeScore12###",aObj.gradeScore12?aObj.gradeScore12:"")
    		;

    		totObj.weight = Number(totObj.weight) + (aObj.weight?Number(aObj.weight):0);
    		totObj.evalGrade00 = Number(totObj.evalGrade00)+(aObj.evalGrade00?Number(aObj.evalGrade00):0);
        	totObj.gradeScore00 = Number(totObj.gradeScore00)+(aObj.gradeScore00?Number(aObj.gradeScore00):0);
        	totObj.evalGrade01 = Number(totObj.evalGrade01)+(aObj.evalGrade01?Number(aObj.evalGrade01):0);
        	totObj.gradeScore01 = Number(totObj.gradeScore01)+(aObj.gradeScore01?Number(aObj.gradeScore01):0);
        	totObj.evalGrade02 = Number(totObj.evalGrade02)+(aObj.evalGrade02?Number(aObj.evalGrade02):0);
        	totObj.gradeScore02 = Number(totObj.gradeScore02)+(aObj.gradeScore02?Number(aObj.gradeScore02):0);
        	totObj.evalGrade03 = Number(totObj.evalGrade03)+(aObj.evalGrade03?Number(aObj.evalGrade03):0);
        	totObj.gradeScore03 = Number(totObj.gradeScore03)+(aObj.gradeScore03?Number(aObj.gradeScore03):0);
        	totObj.evalGrade07 = Number(totObj.evalGrade07)+(aObj.evalGrade07?Number(aObj.evalGrade07):0);
        	totObj.gradeScore07 = Number(totObj.gradeScore07)+(aObj.gradeScore07?Number(aObj.gradeScore07):0);
        	totObj.evalGrade08 = Number(totObj.evalGrade08)+(aObj.evalGrade08?Number(aObj.evalGrade08):0);
        	totObj.gradeScore08 = Number(totObj.gradeScore08)+(aObj.gradeScore08?Number(aObj.gradeScore08):0);
        	totObj.evalGrade09 = Number(totObj.evalGrade09)+(aObj.evalGrade09?Number(aObj.evalGrade09):0);
        	totObj.gradeScore09 = Number(totObj.gradeScore09)+(aObj.gradeScore09?Number(aObj.gradeScore09):0);
        	totObj.evalGrade10 = Number(totObj.evalGrade10)+(aObj.evalGrade10?Number(aObj.evalGrade10):0);
        	totObj.gradeScore10 = Number(totObj.gradeScore10)+(aObj.gradeScore10?Number(aObj.gradeScore10):0);
        	totObj.evalGrade11 = Number(totObj.evalGrade11)+(aObj.evalGrade11?Number(aObj.evalGrade11):0);
        	totObj.gradeScore11 = Number(totObj.gradeScore11)+(aObj.gradeScore11?Number(aObj.gradeScore11):0);
        	totObj.evalGrade12 = Number(totObj.evalGrade12)+(aObj.evalGrade12?Number(aObj.evalGrade12):0);
        	totObj.gradeScore12 = Number(totObj.gradeScore12)+(aObj.gradeScore12?Number(aObj.gradeScore12):0);

    		$("#bd_evalMeasRst").append(tmpHtml);

    	}
    	// 합계
    	var tmpHtml = sHtml.replace("###measDivNm###","")
		.replace("###measGrpNm###","합계")
		.replace("###measNm###","")
		.replace("###weight###",totObj.weight)
		.replace("###evalGrade00###",totObj.evalGrade00?totObj.evalGrade00:0)
		.replace("###gradeScore00###",totObj.gradeScore00?totObj.gradeScore00:0)
		.replace("###evalGrade01###",totObj.evalGrade01?totObj.evalGrade01:0)
		.replace("###gradeScore01###",totObj.gradeScore01?totObj.gradeScore01:0)
		.replace("###evalGrade02###",totObj.evalGrade02?totObj.evalGrade02:0)
		.replace("###gradeScore02###",totObj.gradeScore02?totObj.gradeScore02:0)
		.replace("###evalGrade03###",totObj.evalGrade03?totObj.evalGrade03:0)
		.replace("###gradeScore03###",totObj.gradeScore03?totObj.gradeScore03:0)
		.replace("###evalGrade07###",totObj.evalGrade07?totObj.evalGrade07:0)
		.replace("###gradeScore07###",totObj.gradeScore07?totObj.gradeScore07:0)
		.replace("###evalGrade08###",totObj.evalGrade08?totObj.evalGrade08:0)
		.replace("###gradeScore08###",totObj.gradeScore08?totObj.gradeScore08:0)
		.replace("###evalGrade09###",totObj.evalGrade09?totObj.evalGrade09:0)
		.replace("###gradeScore09###",totObj.gradeScore09?totObj.gradeScore09:0)
		.replace("###evalGrade10###",totObj.evalGrade10?totObj.evalGrade10:0)
		.replace("###gradeScore10###",totObj.gradeScore10?totObj.gradeScore10:0)
		.replace("###evalGrade11###",totObj.evalGrade11?totObj.evalGrade11:0)
		.replace("###gradeScore11###",totObj.gradeScore11?totObj.gradeScore11:0)
		.replace("###evalGrade12###",totObj.evalGrade12?totObj.evalGrade12:0)
		.replace("###gradeScore12###",totObj.gradeScore12?totObj.gradeScore12:0)
		;

    	$("#bd_evalMeasRst").append(tmpHtml);

    }








})







    function openMeasQtyPopup(){
    	$("#div_properties").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closeMeasQtyPopup(){
    	$("#div_properties").hide();
    	$(".overlay").remove();
    }


    function actionMeasQty(){
    	//selOrgCd
    	//db_evalMeasQty

    	//selectEvalMeasQtyRstURL

    	var param = new Object();
		param.year = $("#selYear option:selected").val();
		param.orgCd = $("#selOrgCd option:selected").val();


    	_xAjax(selectEvalMeasQtyRstURL, param)
    	.done(function(data){
			displayQtyRst(data.evalQtyRst);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }


    var mHtml = "<tr role=\"row\" >";
    mHtml += "<td style=\"\">###measGrpNm###</td>";
    mHtml += "<td class=\"\">###measNm###</td>";
    mHtml += "<td class=\"\">###weight###</td>";
    mHtml += "<td class=\"\">###evalGrade###</td>";
    mHtml += "<td class=\"\">###gradeScore###</td>";
    mHtml += "<td class=\"\">###evalScore###</td>";
    mHtml += "</tr>";


    function displayQtyRst(evalQtyRst){
    	$("#db_evalMeasQty").empty();

    	for(var i in evalQtyRst){
    		var aObj = evalQtyRst[i];
    		var tmpHtml = mHtml.replace("###measGrpNm###",aObj.measGrpNm)
    		.replace("###measNm###",  aObj.measNm)
    		.replace("###weight###", aObj.weight?aObj.weight:"")
    		.replace("###evalGrade###",aObj.evalGrade?aObj.evalGrade:"")
    		.replace("###gradeScore###",aObj.gradeScore?aObj.gradeScore:"")
    		.replace("###evalScore###",aObj.evalScore?aObj.evalScore:"")
    		;

    		$("#db_evalMeasQty").append(tmpHtml);
    	}


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

    function actionDownloadCSV(tblNm){

    	var tblObj = $("#"+tblNm);
    	var csvCntnt = "";
    	$("#"+tblNm+" thead tr th").each(function(i){
    		csvCntnt += $(this).text().replace(/"/g, '""').replace(/,/g , '\\,')+",";
    	});
    	csvCntnt += "\r\n";

    	$("#"+tblNm+" tbody tr").each(function(i){
    		$(this).find("td").each(function(j){
    			/*console.log(","+$(this).text());*/
    			csvCntnt += $(this).text()
    			.replace(/(\r\n|\n|\r|\s+|\t|&nbsp;)/gm,' ')
    			.replace(/"/g, '""')
    			.replace(/,/g, ' ') +",";
    		});
    		csvCntnt += "\r\n";
    	});


    	if ( window.navigator.msSaveOrOpenBlob && window.Blob ) {
    	    var blob = new Blob( [ "\ufeff"+csvCntnt ], { type: "text/csv" } );
    	    navigator.msSaveOrOpenBlob( blob, tblNm+".csv" );
    	} else {
    		var downloadLink = document.createElement("a");
    		var csvFile = new Blob(["\ufeff"+csvCntnt], {type: 'text/csv;charset=utf-8;'});

    		downloadLink.download = tblNm+".csv";
    		downloadLink.href = window.URL.createObjectURL(csvFile);
    		downloadLink.style.display = "none";

    		document.body.appendChild(downloadLink);
    		downloadLink.click();

    	}
    }

    function actionDownloadCSVWithHeader(tblNm){

    	var tblObj = $("#"+tblNm);
    	var csvCntnt = "";
		var header = ["구분","부문","지표명","배점"
			,"한국전력기술 평점","한국전력기술 득점"
			,"한전KPS 평점","한전KPS 득점"
			,"한전KDN 평점","한전KDN 득점"
			,"한전원전연료 평점","한전원전연료 득점"
			,"한국동서발전 평점","한국동서발전 득점"
			,"한국남동발전 평점","한국남동발전 득점"
			,"한국중부발전 평점","한국중부발전 득점"
			,"한국남부발전 평점","한국남부발전 득점"
			,"한국서부발전 평점","한국서부발전 득점"
			,"한국수력원자력 평점","한국수력원자력 득점"];
    	for(var h in header){
    		csvCntnt += header[h].replace(/"/g, '""').replace(/,/g , '\\,')+",";
    	}

    	csvCntnt += "\r\n";

    	$("#"+tblNm+" tbody tr").each(function(i){
    		$(this).find("td").each(function(j){
    			/*console.log(","+$(this).text());*/
    			csvCntnt += $(this).text()
    			.replace(/(\r\n|\n|\r|\s+|\t|&nbsp;)/gm,' ')
    			.replace(/"/g, '""')
    			.replace(/,/g, ' ') +",";
    		});
    		csvCntnt += "\r\n";
    	});


    	if ( window.navigator.msSaveOrOpenBlob && window.Blob ) {
    	    var blob = new Blob( [ "\ufeff"+csvCntnt ], { type: "text/csv" } );
    	    navigator.msSaveOrOpenBlob( blob, tblNm+".csv" );
    	} else {
    		var downloadLink = document.createElement("a");
    		var csvFile = new Blob(["\ufeff"+csvCntnt], {type: 'text/csv;charset=utf-8;'});

    		downloadLink.download = tblNm+".csv";
    		downloadLink.href = window.URL.createObjectURL(csvFile);
    		downloadLink.style.display = "none";

    		document.body.appendChild(downloadLink);
    		downloadLink.click();

    	}
    }

</script>

<title>Document</title>
<style type="text/css">


.ui-jqgrid .ui-jqgrid-htable th {
    background-color: #385f9c;
    color: #ddd;
    background-image: none !important;;

}


.highcharts-figure .chart-container {
	width: 300px;
	height: 200px;
	float: left;
}

.highcharts-figure, .highcharts-data-table table {
	width: 600px;
	margin: 0 auto;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #EBEBEB;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}

@media (max-width: 600px) {
	.highcharts-figure, .highcharts-data-table table {
		width: 100%;
	}
	.highcharts-figure .chart-container {
		width: 300px;
		float: none;
		margin: 0 auto;
	}

}


html, body {
	height: 100%;
	padding: 0;
	margin: 0;
	overflow: hidden;
}

#gauge {
    height: 240px;
    width: 40%;
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
	top: 20px;
	left: 10%;
	z-index: 999999;
	width: 80%;
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

#bd_emp tr{
	cursor:pointer;
}
#bd_deptMapping tr{
	cursor:pointer;
}
#bd_dept tr{
	cursor:pointer;
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
		<header id="header" style="">
			<fieldset style="width: 100%;">
				<div class="form-group">
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;text-align: right;">기준년도 </label>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selYear">
							</select>
						</div>
					</div>
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;text-align: right;"></label>
					<div class="col-md-3">
					<a id="btnSearch"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
					<a id="btnExcel"   class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a>
					</div>
					<div class="col-md-1">
					<a id="btnDetail" onclick="javascript:openMeasQtyPopup();" class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">계량지표 상세보기</a>
					</div>
				</div>
			</fieldset>
		</header>


		<section id="section">
			<div class="row">
				<article class="col-sm-12">
					<!-- new widget -->
					<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false" style="padding: 6px;">
						<header style="">
						<h2>그룹사별 지표결과</h2>
						</header>
						<!-- body -->
						<div role="content">
							<div class="widget-body no-padding" style="">

							<section id="widget-yield" class="" >
								<div class="row">
									<!-- NEW WIDGET START -->
									<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

									<!-- widget div-->
									<div class="widget-content">
										<!-- widget content -->
										<div class="widget-body">
										<fieldset>
											<div class="col-md-12" style="padding-right: 1px;border-bottom: 1px solid #c1c1c1;margin-bottom: 12px;">
								                <!-- <div class="">평가기관</div> -->
								                    <div id="" style="width:100%;height:600px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">

														<table id="tb_evalMeasRst" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
															<thead>
																<tr role="row">
																<th rowspan="2" colspan="1" style="width:10%;vertical-align: middle;">구분</th>
																<th rowspan="2" colspan="1" style="width:10%;vertical-align: middle;">부문</th>
																<th rowspan="2" colspan="1" style="width:15%;vertical-align: middle;">지표명</th>
																<th rowspan="2" colspan="1" style="width:5%;vertical-align: middle;">배점</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_00">한국전력기술</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_01">한전KPS</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_02">한전KDN</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_03">한전원전연료</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_07">한국동서발전</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_08">한국남동발전</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_09">한국중부발전</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_10">한국남부발전</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_11">한국서부발전</th>
																<th rowspan="1" colspan="2" style="width:10%;vertical-align: middle;" id="org_12">한국수력원자력</th>
																</tr>
																<tr>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평점</th>
																	<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																</tr>
															</thead>
															<tbody id="bd_evalMeasRst">

															</tbody>
														</table>

								                    </div>
											</div>


										</fieldset>
										</div>
									</div>


									</article>

							    </div><!-- end of row   -->
							</section>


							</div>
							<!-- end widget-body -->
						</div>
						<!-- end content -->
					</div>
					<!-- end widget -->


				</article>
			</div>
		</section>


	</div>












	<script type="text/javascript">




	</script>




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
						<h2>계량지표 상세</h2>
					</header>

					<!-- widget div-->
					<div class="widget-content">
						<!-- widget content -->
						<div class="widget-body">
						<fieldset>
							<div class="col-md-3" style="padding-right: 1px;">
				                <div class="icon-addon addon-md">
									<select class="form-control" id="selOrgCd" >
									</select>
								</div>
							</div>

							<div class="col-md-3" style="padding-right: 1px;">
								<a onClick="closeMeasQtyPopup()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
								<a onClick="actionMeasQty()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
							</div>
						</fieldset>

						<div id="" style="width:100%;height:450px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
							<table id="dt_evalMeasQty" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
								<thead>
									<tr role="row">
									<th rowspan="1" colspan="1" style="width:20%;">부문</th>
									<th rowspan="1" colspan="1" style="width:20%;">지표명</th>
									<th rowspan="1" colspan="1" style="width:5%;">배점</th>
									<th rowspan="1" colspan="1" style="width:10%;">평가등급</th>
									<th rowspan="1" colspan="1" style="width:10%;">평점</th>
									<th rowspan="1" colspan="1" style="width:10%;">득점</th>
									</tr>
								</thead>
								<tbody id="db_evalMeasQty">
								</tbody>
							</table>
						</div>


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



</body>
</html>





