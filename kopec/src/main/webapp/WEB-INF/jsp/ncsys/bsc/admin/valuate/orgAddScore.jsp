<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">

<script type="text/javascript">
var selectInitURL = "<c:url value='/admin/valuate/selectOrgAddScrInit.json'/>";

var selectOrgAddScoreDetailURL = "<c:url value='/admin/valuate/selectOrgAddScoreDetail.json'/>";


var adjustOrgAddScrURL = "<c:url value='/admin/valuate/adjustOrgAddScr.json'/>";
var deleteOrgAddScoreURL = "<c:url value='/admin/valuate/deleteOrgAddScore.json'/>";

var selectSBUURL = "<c:url value='/actual/measure/selectSBU.json'/>";


</script>


<script type="text/javascript">
	$(document) .ready( function() {

		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		actionInit();

		$("#selYear").change(function(){ actionInit(); });
		$("#selMonth").change(function(){ selectList(); });

		$("#selSBU").change(function(){ selectList(); });

	});


    function funcSetDate(curYear) {
        for (i=0,j=curYear-6; i<=6;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear option:eq(5)").attr("selected", "selected");
    }

    function actionInit(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectSBUURL, param)
    	.done(function(data){
    		setSBU(data.selectSBU);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }

	function setSBU(sbu){
		$('#selSBU').empty();

		var option = $("<option value='-1'>::전체::</option>");
        $('#selSBU').append(option);

        for(var i in sbu){
			var obj = sbu[i];
			var option = $("<option value='"+obj.sid+"'>"+obj.sname+"</option>");
	        $('#selSBU').append(option);
		}

		selectList();
	}


    function selectList(){
    	/* select tblpsnbaseline */

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();
    	if("-1" != $("#selSBU option:selected").val()){
			param.sid = $("#selSBU option:selected").val();
		}

    	_xAjax(selectInitURL, param)
    	.done(function(data){

   			displayOrgAddScore(data.selectOrgAddScore);
   			//displayDept(data.selectDept);


    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }



    /* bsc */
     var curBsc = 0;

     var bscHtml = "<tr role=\"row\" bid=\"###bid###\">";
     bscHtml += "<td style=\"\">###sname###</td>";
     bscHtml += "<td style=\"\">###bname###</td>";
     bscHtml += "<td style=\"\">###mweight1###</td>";
     bscHtml += "<td style=\"\">###mscore1###</td>";
     bscHtml += "<td style=\"\">###mweight2###</td>";
     bscHtml += "<td style=\"\">###mscore2###</td>";
     bscHtml += "<td style=\"\">###scoresum###</td>";
     bscHtml += "<td style=\"\">###scoreadd###</td>";
     bscHtml += "<td style=\"\">###calgrd###</td>";
     bscHtml += "<td style=\"\">###scoretot###</td>";
     bscHtml += "<td style=\"\">###grpRank###</td>";
     bscHtml += "</tr>";

     function displayOrgAddScore(bsc){
     	curBsc = null;
     	$("#bd_bsc").empty();

     	for(var i in bsc){
     		var aBsc = bsc[i];
     		var tmpHtml = bscHtml.replace("###bid###",aBsc.bid)
     		.replace("###sname###",aBsc.sname)
     		.replace("###bname###",aBsc.bname)
     		.replace("###mweight1###",aBsc.mweight1?aBsc.mweight1:"")
     		.replace("###mscore1###",aBsc.mscore1?aBsc.mscore1:"")
     		.replace("###mweight2###",aBsc.mweight2?aBsc.mweight2:"")
     		.replace("###mscore2###",aBsc.mscore2?aBsc.mscore2:"")
     		.replace("###scoresum###",aBsc.scoresum?aBsc.scoresum:"")
     		.replace("###scoreadd###",aBsc.scoreadd?aBsc.scoreadd:"")
     		.replace("###calgrd###",aBsc.calgrd?aBsc.calgrd:"")
     		.replace("###scoretot###",aBsc.scoretot?aBsc.scoretot:"")
     		.replace("###grpRank###",aBsc.grpRank?aBsc.grpRank:"")
     		;

     		$("#bd_bsc").append(tmpHtml);
     	}

 		$("#bd_bsc tr").click(function(){
 			actionClickBsc($(this));
 		})

     }
     function actionClickBsc(rowObj){
     	$(curBsc).removeClass("select_row");
     	curBsc = $(rowObj)
     	$(curBsc).addClass("select_row");
     	selectDept();
     }


     function selectDept(){
     	$("#div_property").show();
		$(".wrap").after("<div class='overlay'></div>");
		selectOrgAddScoreDetail();
    }


    function closePopup(){
    	$("#div_property").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
    }

	function selectOrgAddScoreDetail(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();

    	param.bid = $(curBsc).attr("bid");

    	_xAjax(selectOrgAddScoreDetailURL, param)
    	.done(function(data){

   			displayOrgAddScoreDetail(data.selectOrgAddScoreDetail);
   			//displayDept(data.selectDept);


    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}

    function displayOrgAddScoreDetail(detail){
    	$("#bid").val(detail.bid);
    	$("#sname").val(detail.sname);
    	$("#bname").val(detail.bname);
    	$("#scoresum").val(detail.scoresum);
    	$("#inputscr").val(detail.inputscr);
    	$("#calgrd").val(detail.calgrd);
    	$("#calgrdscr").val(detail.calgrdscr);
    	$("#scoreadd").val(detail.scoreadd);
    	$("#scoretot").val(detail.scoretot);
    	$("#addscrCmt").val(detail.addscrCmt);
    }

    var scr_s = 100;
    var scr_ap = 95;
    var scr_a = 90;
    var scr_bp = 85;
    var scr_b = 80;
    var scr_cp = 75;
    var scr_c = 70;
    var scr_dp = 65;
    var scr_d = 65;
    function actionPerformed(){
    	console.log("bid : "+$("#bid").val());
    	//scoresum
    	var calgrd = "";
    	var calgrdscr = 0;
    	var scoreadd = 0;
		var inputscr = $("#inputscr").val();

		if(inputscr>=scr_s){
			calgrd = "S";
	    	calgrdscr = 100;
		} else if (inputscr>=scr_ap){
			calgrd = "A+";
	    	calgrdscr = 87.5;
		} else if (inputscr>=scr_a){
			calgrd = "A";
	    	calgrdscr = 75;
		} else if (inputscr>=scr_bp){
			calgrd = "B+";
	    	calgrdscr = 62.5;
		} else if (inputscr>=scr_b){
			calgrd = "B";
	    	calgrdscr = 50;
		} else if (inputscr>=scr_cp){
			calgrd = "C+";
	    	calgrdscr = 37.5;
		} else if (inputscr>=scr_c){
			calgrd = "C";
	    	calgrdscr = 25;
		} else if (inputscr>=scr_dp){
			calgrd = "D+";
	    	calgrdscr = 12.5;
		} else {
			calgrd = "D";
	    	calgrdscr = 0;
		}

		scoreadd = Number(calgrdscr)*Number(0.05);
    	scoretot = Number($("#scoresum").val())+scoreadd;

    	$("#calgrd").val(calgrd);
    	$("#calgrdscr").val(calgrdscr);
    	$("#scoreadd").val(scoreadd);
    	$("#scoretot").val(scoretot);

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();

    	param.bid = $("#bid").val();

    	param.inputscr = inputscr;
    	param.scoresum = $("#scoresum").val();
    	param.calgrd = calgrd;
    	param.calgrdscr = calgrdscr;
    	param.addscr = scoreadd;
    	param.totalscr = scoretot;
    	param.addscrCmt = $("#addscrCmt").val();

    	if("-1" != $("#selSBU option:selected").val()){
			param.sid = $("#selSBU option:selected").val();
		}

    	_xAjax(adjustOrgAddScrURL, param)
    	.done(function(data){

    		displayOrgAddScore(data.selectOrgAddScore);
    		closePopup();

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }


    function actionDeletePerformed(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();

    	param.bid = $("#bid").val();

    	if("-1" != $("#selSBU option:selected").val()){
			param.sid = $("#selSBU option:selected").val();
		}

    	_xAjax(deleteOrgAddScoreURL, param)
    	.done(function(data){

    		displayOrgAddScore(data.selectOrgAddScore);
    		closePopup();

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

#bd_bsc tr{
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
						style="padding-top: 6px;">조직구분 </label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selSBU">
							</select>

						</div>
					</div>

					<div class="col-md-4">
					<a onClick="javascript:selectList();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
					<a onClick="javascript:actionDownloadCSV('tb_bsc');"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a>
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
						<h2>평가결과반영 </h2>
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
						<table id="tb_bsc" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="2" colspan="1" style="width:20%;">구분</th>
								<th rowspan="2" colspan="1" style="width:20%;">조직명</th>
								<th rowspan="1" colspan="2" style="width:20%;">계량</th>
								<th rowspan="1" colspan="2" style="width:20%;">비계량</th>
								<th rowspan="2" colspan="1" style="width:10%;">득점합계</th>
								<th rowspan="2" colspan="1" style="width:10%;">가감점</th>
								<th rowspan="2" colspan="1" style="width:10%;">가감등급</th>
								<th rowspan="2" colspan="1" style="width:10%;">최종득점</th>
								<th rowspan="2" colspan="1" style="width:10%;">순위</th>
								</tr>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:10%;">가중치</th>
								<th rowspan="1" colspan="1" style="width:10%;">득점</th>
								<th rowspan="1" colspan="1" style="width:10%;">가중치</th>
								<th rowspan="1" colspan="1" style="width:10%;border-width: 1px;">득점</th>
								</tr>
							</thead>
							<tbody id="bd_bsc">

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
			<h2>가감점 등록</h2>
		</header>

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">
			<input type="hidden" name="bid" id="bid" />

			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">조직구분 </label>
					<div class="col-md-10" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="sname"/>
						</div>
					</div>
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">조직명</label>
					<div class="col-md-10" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="bname"/>
						</div>
					</div>
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">득점합계 </label>
					<div class="col-md-3" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="scoresum"/>
						</div>
					</div>
					<label class="control-label col-md-4" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">가감점(100점기준) </label>
					<div class="col-md-3" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="inputscr" style="background-color: #fff;"/>
						</div>
					</div>
				</div>
			</fieldset>
			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">등급구간 </label>
					<div class="col-md-10" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<table class="table table-striped table-bordered table-hover dataTable " style="width: 100%; table-layout: fixed;">
							<thead>
								<tr role="row">
								<th>S</th><th>A+</th><th>A</th><th>B+</th><th>B</th><th>C+</th><th>C</th><th>D+</th><th>D</th>
								</tr>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>100</td><td>95</td><td>90</td><td>85</td><td>80</td><td>75</td><td>70</td><td>65</td><td>65</td>
							</tr>
							<tr>
								<td>100</td><td>87.5</td><td>75</td><td>62.5</td><td>50</td><td>37.5</td><td>25</td><td>12.5</td><td>0</td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>

				</div>
			</fieldset>


			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">등급 </label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="calgrd"/>
						</div>
					</div>
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">등급점수</label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="calgrdscr"/>
						</div>
					</div>
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">가감점(5%) </label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="scoreadd"/>
						</div>
					</div>
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">최종득점</label>
					<div class="col-md-10" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="row">
						<div class="icon-addon addon-md col-md-4">
							<input type="text" class="form-control" id="scoretot"/>
						</div>
						</div>
					</div>
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">내용</label>
					<div class="col-md-10" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<textarea class="form-control" id="addscrCmt" style="height:80px;"></textarea>
						</div>
					</div>
				</div>
			</fieldset>

			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
						<a onClick="javascript:closePopup();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
						<a onClick="javascript:actionDeletePerformed();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">삭제</a>
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


</body>
</html>





