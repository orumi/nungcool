<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">

<script type="text/javascript">

var selectMeasureList = "<c:url value='/analysis/meaRank/selectMeasureYear.json'/>";
var selectMeaRankUrl = "<c:url value='/analysis/meaRank/selectMeaRank.json'/>";

var selectMeasureDefineUrl = "<c:url value='/scorecard/score/selectMeasureDefine.json'/>";
var selectMeasureActualUrl = "<c:url value='/scorecard/score/selectMeasureActual.json'/>";



</script>


<script type="text/javascript">
	$(document) .ready( function() {

		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		$("#selYear").change(function(){reset();});
		$("#selMonth").change(function(){reset();});

	});


    function funcSetDate(curYear) {
        for (i=0,j=curYear-16; i<=17;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear").val("${config[0].showyear}");
        $("#selMonth").val("${config[0].showmonth}");
    }

    function selectMeaList(){
    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();
		param.searchText = $("#searchText").val();

    	_xAjax(selectMeasureList, param)
    	.done(function(data){
   			displayMeasure(data.meaList);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }


    function reset(){
    	$("#txtSelectMeasure").val("");
    	curMeasure = null;
    	$("#tb_measure").empty();

    	curRank = null;
		$("#bd_rank").empty();

    }






    var curMeasure = null;
    function actionClickMeasure(rowObj){
    	$(curMeasure).removeClass("select_row");
    	curMeasure = $(rowObj)
    	$(curMeasure).addClass("select_row");
    }

    function actionDblClickMeasure(rowObj){
    	$(curMeasure).removeClass("select_row");
    	curMeasure = $(rowObj)
    	$(curMeasure).addClass("select_row");

    	actionPerformed();
    }

    var meaHtml = "<tr role=\"row\" mid=\"###id###\">";
    meaHtml += "<td style=\"\">###id###</td>";
    meaHtml += "<td style=\"text-align:left\">###name###</td>";
    meaHtml += "</tr>";

	function displayMeasure(meaList){
		curMeasure = null;
    	$("#tb_measure").empty();
    	for(var i in meaList){
    		var obj = meaList[i];
    		var tmpHtml = meaHtml.replace("###id###",obj.id)
    		.replace("###id###",obj.id)
    		.replace("###name###",obj.name);

    		$("#tb_measure").append(tmpHtml);
    	}

    	$("#tb_measure tr").click(function(){
			actionClickMeasure($(this));
		})

		$("#tb_measure tr").dblclick(function(){
			actionDblClickMeasure($(this));
		})
	}

    function openMeasureListPopup(){
     	$("#div_property").show();
		$(".wrap").after("<div class='overlay'></div>");

		selectMeaList();
    }


    function closeMeasureListPopup(){
    	$("#div_property").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
    }


	function actionPerformed(){
		$("#txtSelectMeasure").val("");
		if(curMeasure == null){
			alert("조회하고자 하는 지표를 선택하십시오.");
			return;
		}



		var rdObj = $(curMeasure).children();
    	var meaid = $(curMeasure).attr("mid");

    	$("#txtSelectMeasure").val(rdObj.eq(1).text());

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();
    	param.meaid = meaid;

    	_xAjax(selectMeaRankUrl, param)
    	.done(function(data){
   			displayRank(data.meaRank);
   			closeMeasureListPopup();
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}


    var rankHtml = "<tr role=\"row\" mcid=\"###mcid###\">";
    rankHtml += "<td style=\"\">###sname###</td>";
    rankHtml += "<td style=\"text-align:left\">###bname###</td>";
    rankHtml += "<td style=\"text-align:center\">###mweight###</td>";
    rankHtml += "<td style=\"text-align:center\">###grade###</td>";
    rankHtml += "<td style=\"text-align:right\">###gradeScore###</td>";
    rankHtml += "<td style=\"text-align:right\">###grpAvg###</td>";
    rankHtml += "<td style=\"text-align:right\">###allAvg###</td>";
    rankHtml += "<td style=\"text-align:right\">###grpRank###</td>";
    rankHtml += "<td style=\"text-align:right\">###allRank###</td>";
    rankHtml += "</tr>";

    var curRank = null;
    function actionClickRank(rowObj){
    	$(curRank).removeClass("select_row");
    	curRank = $(rowObj)
    	$(curRank).addClass("select_row");
    }

	function displayRank(meaRank){
		curRank = null;
		$("#bd_rank").empty();

		for(var i in meaRank){
    		var obj = meaRank[i];
    		var tmpHtml = rankHtml.replace("###mcid###",obj.mcid)
    		.replace("###sname###",obj.sname)
    		.replace("###bname###",obj.bname)
			.replace("###mweight###",obj.mweight?obj.mweight:"")
			.replace("###grade###",obj.grade?obj.grade:"")
			.replace("###gradeScore###",obj.gradeScore?obj.gradeScore:"")
			.replace("###grpAvg###",obj.grpAvg?obj.grpAvg:"")
			.replace("###allAvg###",obj.allAvg?obj.allAvg:"")
			.replace("###grpRank###",obj.grpRank?obj.grpRank:"")
			.replace("###allRank###",obj.allRank?obj.allRank:"")
    		;

    		$("#bd_rank").append(tmpHtml);
    	}

		$("#bd_rank tr").click(function(){
			actionClickRank($(this));
		})

	}

	function actionEditMeasure(){
		if(curRank == null){
			alert("성과지표를 선택하십시오.");
			return;
		}

		var rdObj = $(curRank).children();
    	var mid = $(curRank).attr("mcid");


		openMeasurePopup();

		var param = new Object();
      	param.year = $("#selYear option:selected").val();
     	param.mid = mid;

     	_xAjax(selectMeasureDefineUrl, param)
     	.done(function(data){
 			if("ok_resend" == data.reVal){
				displayMeasureDefine(data.reMeasure);
				displayItem(data.reItem);
				displayUpdater(data.reUpdater);
 			}
     	}).fail(function(error){
     		console.log("actionEditMeasure error : "+error);
     	});


	}




	function displayMeasureDefine(measure){
		$("#pname").val(measure.pname);
		$("#oname").val(measure.oname);
		$("#mname").val(measure.mname);
		$("#etlkey").val(measure.etlkey);
		$("#mean").val(measure.mean);
		$("#detaildefine").val(measure.detaildefine);
		$("#planned").val(measure.planned);
		$("#plannedBasePlus").val(measure.plannedBasePlus);
		$("#plannedBase").val(measure.plannedBase);
		$("#basePlus").val(measure.basePlus);
		$("#base").val(measure.base);
		$("#baseLimitPlus").val(measure.baseLimitPlus);
		$("#baseLimit").val(measure.baseLimit);
		$("#limitPlus").val(measure.limitPlus);
		$("#limit").val(measure.limit);
		$("#equationType").val(measure.equationType);
		$("#plannedFlag").val(measure.plannedFlag);
		$("#equationdefine").val(measure.equationdefine);
		$("#equation").val(measure.equation);
		$("#measurement").val(measure.measurement);
		$("#trend").val(measure.trend);
		$("#frequency").val(measure.frequency);
		$("#weight").val(measure.weight);
		$("#unit").val(measure.unit);
	}

	var valHtml = "<tr role=\"row\" >";
     valHtml += "<td style=\"\">###itemcode###</td>";
     valHtml += "<td style=\"\">###itemname###</td>";
     valHtml += "</tr>";
	function displayItem(item){
		//bd_item
		$("#bd_item").empty();

     	for(var i in item){
     		var aObj = item[i];
     		var tmpHtml = valHtml.replace("###itemcode###",aObj.code)
     		.replace("###itemname###",aObj.itemname?aObj.itemname:"");

     		$("#bd_item").append(tmpHtml);
     	}
	}

	var uHtml = "<tr role=\"row\" >";
		uHtml += "<td style=\"\">###updater###</td>";
		uHtml += "</tr>";
	function displayUpdater(updater){
		//bd_updater

		$("#bd_updater").empty();

     	for(var i in updater){
     		var aObj = updater[i];
     		var tmpHtml = uHtml.replace("###updater###",aObj.username)
     		;

     		$("#bd_updater").append(tmpHtml);
     	}
	}

    function openMeasurePopup(){
     	$("#div_measure").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closeMeasurePopup(){
    	$("#div_measure").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
    }



	function actionViewActual(){
		if(curRank == null){
			alert("성과지표를 선택하십시오.");
			return;
		}

		var rdObj = $(curRank).children();
    	var mid = $(curRank).attr("mcid");


		openActualPopup();

		var param = new Object();
      	param.year = $("#selYear option:selected").val();
      	param.month = $("#selMonth option:selected").val();
     	param.mid = mid;

     	_xAjax(selectMeasureActualUrl, param)
     	.done(function(data){
 			if("ok_resend" == data.reVal){
				displayActualMeasureDefine(data.reMeasure);
				displayActualItem(data.selectItemActual);
				displayActual(data.selectMeasureActual);

 			}
     	}).fail(function(error){
     		console.log("actionEditMeasure error : "+error);
     	});
	}

	function displayActual(actual){
		console.log("actual[0].comments : "+actual[0].comments);
		$("#actual_comments").val(actual[0].comments);
	}

	function displayActualMeasureDefine(measure){
		$("#actual_pname").val(measure.pname);
		$("#actual_oname").val(measure.oname);
		$("#actual_mname").val(measure.mname);
		$("#actual_etlkey").val(measure.etlkey);
		$("#actual_equationdefine").val(measure.equationdefine);
		$("#actual_equation").val(measure.equation);
	}

	var valAHtml = "<tr role=\"row\" >";
	valAHtml += "<td style=\"\">###itemcode###</td>";
	valAHtml += "<td style=\"\">###itemname###</td>";
	valAHtml += "<td style=\"\">###itemactual###</td>";
	valAHtml += "</tr>";
	function displayActualItem(item){
		//bd_item
		$("#bd_actual_item").empty();

     	for(var i in item){
     		var aObj = item[i];
     		var tmpHtml = valAHtml.replace("###itemcode###",aObj.code)
     		.replace("###itemname###",aObj.itemname?aObj.itemname:"")
     		.replace("###itemactual###",aObj.actual?aObj.actual:"");

     		$("#bd_actual_item").append(tmpHtml);
     	}
	}



    function openActualPopup(){
     	$("#div_actual").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closeActualPopup(){
    	$("#div_actual").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
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



     //dt_psnBizHm
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
	top: 8px;
	left: 0%;
	z-index: 999999;
	width: 98%;
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

#tb_measure tr{
	cursor:pointer;
}
#bd_rank tr{
	cursor:pointer;
}
#bd_dept tr{
	/* cursor:pointer; */
}


table td{
    text-overflow: ellipsis;
    overflow: hidden;
    /* white-space: nowrap; */
}

.dataTable td{
	text-align: center;
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
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selMonth">
								<option value="03">1/4분기</option>
								<option value="06">2/4분기</option>
								<option value="09">3/4분기</option>
								<option value="12">4/4분기</option>
							</select>
						</div>
					</div>
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;text-align: right;">지표 </label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="txtSelectMeasure" />
						</div>
					</div>
					<div class="col-md-1" style="padding-left: 0px;">
					<a onClick="javascript:openMeasureListPopup();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">...</a>
					</div>

					<div class="col-md-2">
					<a onClick="javascript:actionPerformed();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
					<a onClick="javascript:actionDownloadCSV('tb_rank');"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a>
					</div>
					<div class="col-md-3">
					<a onClick="javascript:actionEditMeasure();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">지표정의서</a>
					<a onClick="javascript:actionViewActual();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">실적분석</a>
					</div>
				</div>
			</fieldset>
		</header>
	</div>

		<section id="section">
			<div class="row">
				<article class="col-sm-12">
					<!-- new widget -->
					<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false" style="padding: 6px;">
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
						<h2>지표별 조직순위 </h2>
						</header>
						<!-- widget div-->
						<div class="no-padding">
							<div class="widget-body" style="">

<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">
			<fieldset>
				<div class="col-md-12" style="padding-right: 1px;;">
	                    <div id="" style="width:100%;height:560px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_rank" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="2" colspan="1" style="width:20%;vertical-align: middle;">구분</th>
								<th rowspan="2" colspan="1" style="width:20%;vertical-align: middle;">조직명</th>
								<th rowspan="2" colspan="1" style="width:10%;vertical-align: middle;">가중치</th>
								<th rowspan="2" colspan="1" style="width:10%;vertical-align: middle;">평가등급</th>

								<th rowspan="1" colspan="3" style="width:20%;">점수</th>
								<th rowspan="1" colspan="2" style="width:20%;">조직순위</th>

								</tr>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:10%;">평가점수</th>
								<th rowspan="1" colspan="1" style="width:10%;">그룹평균</th>
								<th rowspan="1" colspan="1" style="width:10%;">전사평균</th>
								<th rowspan="1" colspan="1" style="width:10%;">그룹</th>
								<th rowspan="1" colspan="1" style="width:10%;border-width: 1px;">전사</th>
								</tr>
							</thead>
							<tbody id="bd_rank">

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


								<!-- end content -->
							</div>

						</div>
						<!-- end widget div -->
					</div>
					<!-- end widget -->

				</article>
			</div>
		</section>




<!-- popup  -->
<div class="" id="div_property" name="div_property" style="display: none;">
<div class="popup" style="width:700px;left:250px;top:100px;">
<form class="form-horizontal"  style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>성과지표 목록</h2>
		</header>

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">
			<input type="hidden" name="bid" id="bid" />

			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">성과지표</label>
					<div class="col-md-8" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="searchText"/>
						</div>
					</div>
					<div class="col-md-1" style="padding-right: 0px; padding-left: 3px;margin-bottom: 4px;">
					<a onClick="javascript:closeMeasurePopup();"  class="btn btn-default pull-right" style="padding: 6px 12px; margin: 0px 2px;">조회</a>
					</div>
				</div>
			</fieldset>
			<fieldset>

				<div class="form-group">
					<div class="col-md-12" style="padding-right: 24px;padding-left:24px;">
		                <div class="icon-addon addon-md" >
		                    <div id="res" style="width:100%;height:360px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
							<table id="tb_actual_item" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
		                    	<thead>
		                    	<tr>
		                    	<th width="20%" class="nc_th" style="">
		                    		지표번호
		                    	</th>
		                    	<th width="60%" class="nc_th" style="">
		                    		지표명
		                    	</th>
		                    	</tr>
		                    	</thead>

		                    	<tbody id="tb_measure">

								</tbody>
		                    </table>
		                    </div>
		                </div>
		            </div>
				</div>


			</fieldset>
			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
						<a onClick="javascript:closeMeasureListPopup();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
						<a onClick="javascript:actionPerformed();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">적용</a>
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
<!-- end of popup  -->




<div id="div_measure" name="div_measure" style="display: none;">
<div class="popup" style="">
					<form class="form-horizontal" id="form_detail_measure" name="form_detail" style="padding:10px;" >
					<section id="widget-yield" class="" >
						<div class="row">
				<!-- NEW WIDGET START -->
				<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget" id="wid-id-1" >
						<header>
							<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
							<h2>지표정의서</h2>
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
						<label class="control-label col-md-1" for="prepend" style="">관점</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input class="form-control" type="text" id="pname" />
			                </div>
			            </div>
			            <label class="control-label col-md-1" for="prepend" style="">전략목표</label>
			            <div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input class="form-control" type="text" id="oname" />
			                </div>
			            </div>
			        </div>
			        <div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">성과지표</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input class="form-control" type="text" id="mname" />
			                </div>
			            </div>
			            <label class="control-label col-md-1" for="prepend" style="">ETLKEY</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input class="form-control" type="text" id="etlkey" />
			                </div>
			            </div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">지표정의</label>
						<div class="col-md-9" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input type="text" class="form-control"  id="mean"/>
			                </div>
			            </div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">세부설명</label>
						<div class="col-md-9" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <textarea type="text" rows="4" class="form-control"  id="detaildefine"></textarea>
			                </div>
			            </div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">점수등급</label>
						<div class="col-md-7" style="padding-right: 1px;">
			                <div class="icon-addon addon-md" >
			                    <table id="tb_psnScore" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
			                    <thead>
			                    	<tr>
			                    	<th width="10%" class="" style="">
			                    		S(100)
			                    	</th>
			                    	<th width="10%" class="" style="">
			                    		A+(95)
			                    	</th>
			                    	<th width="10%" class="" style="">
			                    		A(90)
			                    	</th>
			                    	<th width="10%" class="" style="">
			                    		B+(85)
			                    	</th>
			                    	<th width="10%" class="" style="">
			                    		B(80)
			                    	</th>
			                    	<th width="10%" class="" style="">
			                    		C+(75)
			                    	</th>
			                    	<th width="10%" class="" style="">
			                    		C(70)
			                    	</th>
			                    	<th width="10%" class="" style="">
			                    		D+(65)
			                    	</th>
			                    	<th width="10%" class="" style="">
			                    		D(60)
			                    	</th>

			                    	</tr>
			                    </thead>
			                    	<tr >
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="planned"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="plannedBasePlus"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="plannedBase"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="basePlus"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="base"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="baseLimitPlus"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="baseLimit"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="limitPlus"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  id="limit"/>
			                    	</td>
			                    	</tr>
			                    </table>
			                </div>
			            </div>
			            <div class="col-md-1" style="padding-right: 1px;">
			            	<div class="icon-addon addon-md" >
			            	등급구간
			                    <select type="text" class="form-control"  id="equationType">
			                    	<option value="A" selected>직접입력</option>
			                    	<option value="B">비계량</option>
			                    	<option value="C">계량 일반</option>
			                    	<option value="D">계량 5점</option>
			                    	<option value="E">계량 3~4점</option>
			                    	<option value="F">계량 105점</option>
			                    	<option value="G">계량 95점</option>
			                    </select>
			                </div>
			            </div>
			            <div class="col-md-1" style="padding-right: 1px;">
			            	<div class="icon-addon addon-md" >
			            	목표
			                    <select type="text" class="form-control"  id="plannedFlag">
			                    	<option value="U">구간이상</option>
			                    	<option value="O">구간초가</option>
			                    </select>
			                </div>
			            </div>
					</div>
				</fieldset>

					<div class="row">
					<div class="col-md-6">

					<header style="border-top:1px solid #c1c1c1;margin-top: 26px;padding-top: 8px;">지표산식</header>
					<legend style="padding: 5px 0;"></legend>
					<fieldset>
						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">한글산식</label>
							<div class="col-md-9" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  id="equationdefine"/>
				                </div>
				            </div>
				        </div>
				        <div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">실적산식</label>
							<div class="col-md-9" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  id="equation"/>
				                </div>
				            </div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">산식항목</label>
							<div class="col-md-9" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md" >
				                    <div id="res" style="width:100%;height:160px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
									<table id="tb_item" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
				                    	<thead>
				                    	<tr>
				                    	<th width="20%" class="nc_th" style="">
				                    		항목코드
				                    	</th>
				                    	<th width="60%" class="nc_th" style="">
				                    		항목명
				                    	</th>
				                    	</tr>
				                    	</thead>

				                    	<tbody id="bd_item">

										</tbody>
				                    </table>
				                    </div>
				                </div>
				            </div>
						</div>


					</fieldset>

					</div>
					<div class="col-md-6">

					<header style="border-top:1px solid #c1c1c1;margin-top: 26px;padding-top: 8px;">지표속성</header>
					<legend style="padding: 5px 0;"></legend>
					<fieldset style="padding-right:20px;">
						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">측정유형</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  id="measurement" />
				                </div>
				            </div>
				            <label class="control-label col-md-2" for="prepend" style="">방향성</label>
				            <div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                	<input type="text" class="form-control"  id="trend" />
				                </div>
				            </div>
				            <label class="control-label col-md-2" for="prepend" style="">측정주기</label>
				            <div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  id="frequency" />
				                </div>
				            </div>
				        </div>

						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">가중치</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  id="weight" />
				                </div>
				            </div>
				            <label class="control-label col-md-2" for="prepend" style="">측정단위</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  id="unit" />
				                </div>
				            </div>
						</div>


						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">담당자</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                	<div class="icon-addon addon-md" >
									<div id="res" style="width:100%;height:60px;overflow-y:auto; overflow-x: hidden">
									<table id="tb_valuate" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
				                    	<tbody id="bd_updater">

										</tbody>
				                    </table>
				                    </div>
				                </div>
				            </div>

						</div>


					</fieldset>
					</div>
					<!-- // end of row -->
					</div>

					<fieldset style="margin-bottom: 20px;">
						<div class="form-group">
						   	<div id="buttonContent" style="width:100%;padding-right:20px;">
								<a onclick="closeMeasurePopup();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
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







<div id="div_actual" name="div_actual" style="display: none;">
<div class="popup" style="">
					<form class="form-horizontal" id="form_detail_actual" name="form_detail" style="padding:10px;" >
					<section id="widget-yield" class="" >
						<div class="row">
				<!-- NEW WIDGET START -->
				<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget" id="wid-id-1" >
						<header>
							<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
							<h2>지표실적</h2>
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
						<label class="control-label col-md-1" for="prepend" style="">관점</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input type="text" class="form-control"  id="actual_pname"/>
			                </div>
			            </div>
			            <label class="control-label col-md-1" for="prepend" style="">전략목표</label>
			            <div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input type="text" class="form-control"  id="actual_oname"/>
			                </div>
			            </div>
			        </div>
			        <div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">성과지표</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input type="text" class="form-control"  id="actual_mname"/>
			                </div>
			            </div>
			            <label class="control-label col-md-1" for="prepend" style="">ETLKEY</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                	<input type="text" class="form-control"  id="actual_etlkey"/>
			                </div>
			            </div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">지표산식</label>
						<div class="col-md-9" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input type="text" class="form-control"  id="actual_equationdefine"/>
			                </div>
			            </div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">실적산식</label>
						<div class="col-md-9" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input type="text" class="form-control"  id="actual_equation"/>
			                </div>
			            </div>
					</div>

				</fieldset>

					<div class="row">
					<div class="col-md-6">

					<header style="border-top:1px solid #c1c1c1;margin-top: 26px;padding-top: 8px;">항목실적</header>
					<legend style="padding: 5px 0;"></legend>
					<fieldset>

						<div class="form-group">
							<div class="col-md-11" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md" >
				                    <div id="res" style="width:100%;height:160px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
									<table id="tb_actual_item" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
				                    	<thead>
				                    	<tr>
				                    	<th width="20%" class="nc_th" style="">
				                    		항목코드
				                    	</th>
				                    	<th width="60%" class="nc_th" style="">
				                    		항목명
				                    	</th>
				                    	<th width="20%" class="nc_th" style="">
				                    		실적
				                    	</th>
				                    	</tr>
				                    	</thead>

				                    	<tbody id="bd_actual_item">

										</tbody>
				                    </table>
				                    </div>
				                </div>
				            </div>
						</div>


					</fieldset>

					</div>
					<div class="col-md-6">

					<header style="border-top:1px solid #c1c1c1;margin-top: 26px;padding-top: 8px;">내부분석의견</header>
					<legend style="padding: 5px 0;"></legend>
					<fieldset style="padding-right:20px;">
						<div class="form-group">
							<div class="col-md-12" style="padding-right: 1px;padding-left: 4px;">
				                <div class="icon-addon addon-md" >
				                    <textarea type="text" rows="6" class="form-control"  id="actual_comments"></textarea>
				                </div>
				            </div>

				        </div>

					</fieldset>
					</div>
					<!-- // end of row -->
					</div>

					<fieldset style="margin-bottom: 20px;">
						<div class="form-group">
						   	<div id="buttonContent" style="width:100%;padding-right:20px;">
								<a onclick="closeActualPopup();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
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





