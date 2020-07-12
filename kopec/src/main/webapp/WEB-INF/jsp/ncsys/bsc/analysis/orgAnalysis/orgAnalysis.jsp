<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">

<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>

<script src="<c:url value='/highcharts/highcharts.js'/> "></script>
<script src="<c:url value='/highcharts/highcharts-more.js'/> "></script>
<script src="<c:url value='/highcharts/modules/solid-gauge.js'/> "></script>
<script src="<c:url value='/highcharts/modules/accessibility.js'/> "></script>




<script type="text/javascript">
var selectBSCURL = "<c:url value='/scorecard/score/selectBSC.json'/>";
var selectMeasureDefineUrl = "<c:url value='/scorecard/score/selectMeasureDefineByTid.json'/>";
var selectMeasureActualUrl = "<c:url value='/scorecard/score/selectMeasureActualByTid.json'/>";

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

		$("#searchName").keydown(function (key) { //검색창에서 Enter눌렀을 때 검색
		          if (key.keyCode == 13) {
		          	searchEvaler();
		          }
		      });

		function funcSetDate(curYear) {
	        for (i=0,j=curYear-6; i<=6;i++,j++) {
	        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
	        }
	        $("#selYear").val("${config[0].showyear}");
	        $("#selMonth").val("${config[0].showmonth}");
	    }


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

    	//clearReset();
    	clearChart();
    	$("#tb_state").empty();

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();
    	param.bid = $("#selBsc option:selected").val();


    	reloadGrid();


    }

    function displayValue(score){
    	var val = score[0].bcscore;
    	resetChart(Number(val));
    }


    var sHtml = "<tr role=\"row\" >";
    sHtml += "<td style=\"\">###pname###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeS###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeA###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeB###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeC###</td>";
    sHtml += "<td style=\"text-align: right;\">###gradeD###</td>";
    sHtml += "<td style=\"text-align: right;\">###notinput###</td>";
    sHtml += "<td style=\"text-align: right;\">###total###</td>";
    sHtml += "</tr>";

    function displayState(state){
   	curValuate = null;
    	$("#bd_state").empty();

    	for(var i in state){
    		var aObj = state[i];
    		var tmpHtml = sHtml.replace("###pname###",aObj.pname)
    		.replace("###gradeS###",aObj.gradeS?aObj.gradeS:"0")
    		.replace("###gradeA###",aObj.gradeA?aObj.gradeA:"0")
    		.replace("###gradeB###",aObj.gradeB?aObj.gradeB:"0")
    		.replace("###gradeC###",aObj.gradeC?aObj.gradeC:"0")
    		.replace("###gradeD###",aObj.gradeD?aObj.gradeD:"0")
    		.replace("###notinput###",aObj.notinput?aObj.notinput:"0")
    		.replace("###total###",aObj.total?aObj.total:"0");

    		$("#bd_state").append(tmpHtml);
    	}

    }












    function openColorPopup(){
     	$("#div_property").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closeColorPopup(){
    	$("#div_property").hide();
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
					<!-- <div class="col-md-4">
					<a onClick="javascript:actionDownloadCSV('jqgrid');"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a>
					</div> -->
				</div>
			</fieldset>
		</header>
	</div>

		<section id="section">
			<div class="row">
				<article class="col-sm-12">
					<!-- new widget -->
					<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false" style="padding: 6px;">
						<header style="">
						<h2>성과내역</h2>
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
							                    	<div id="" style="width:100%;height:360px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">

														<div id="jqgridContent" style="" >
												    		<table id="jqgrid"><tr><td /></tr></table>
												    		<div id="pjqgrid"></div>
														</div>

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









					<!-- new widget -->
					<div class="jarviswidget col-xs-6 col-sm-6 col-md-6 col-lg-6" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false" style="padding: 6px;">
						<header style="">
						<h2>실적분석</h2>
						</header>
						<!-- body -->
						<div role="content">
							<div class="widget-body no-padding" style="">

								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
									<!-- widget div-->
									<div class="widget-content">
										<!-- widget content -->
										<div class="widget-body">
										<fieldset>
											<div class="col-md-12" style="padding-right: 1px;border-bottom: 1px solid #ececec;border-left: 1px solid #ececec;margin-bottom: 12px;">
								                    <div id="" style="width:100%;height:200px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
													<table id="t_state" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
								                    	<thead id="th_state">
															<tr role="row">
															<th rowspan="1" colspan="1" style="width:10%;">아이디</th>
															<th rowspan="1" colspan="1" style="width:40%;">항목</th>
															<th rowspan="1" colspan="1" style="width:10%;">점수</th>
															</tr>
														</thead>
														<tbody id="tb_state">

														</tbody>
								                    </table>
								                    </div>
											</div>
										</fieldset>
										</div>
									</div>
									<!-- end of col 12   -->
									</div>
							    </div><!-- end of row   -->


							</div>
							<!-- end widget-body -->
						</div>
						<!-- end content -->
					</div>
					<!-- end widget -->


					<!-- new widget -->
					<div class="jarviswidget col-xs-6 col-sm-6 col-md-6 col-lg-6" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false" style="padding: 6px;">
						<header style="">
						<h2>성과 차트</h2>
						</header>
						<!-- body -->
						<div role="content">
							<div class="widget-body no-padding" style="">

								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

									<!-- widget div-->
									<div class="widget-content">
										<!-- widget content -->
										<div class="widget-body">
										<fieldset>
											<div class="col-md-12" style="padding-right: 1px;border-bottom: 1px solid #ececec;border-left: 1px solid #ececec;margin-bottom: 12px;">
								                    <!-- widget content -->
												<div class="widget-body">

													<div class="">
										              <div class="" style="height:250px;" id="statisticsCharts"></div>
										            </div>

												</div>
												<!-- end widget content -->
											</div>


										</fieldset>
										</div>
									</div>

									</div>

							    </div><!-- end of row   -->


							</div>
							<!-- end widget-body -->
						</div>
						<!-- end content -->
					</div>
					<!-- end widget -->



				</article>
			</div>
		</section>



















	<script type="text/javascript">
       $(document).ready(function() {
			'use strict';


            $("#jqgrid").jqGrid({
                url : 'selectOrgScore.json',
            	datatype: 'local',
            	mtype: "POST",
            	postData : { "year":function() { return $("#selYear").val(); }
					       , "month":function() { return $("#selMonth").val(); }
					       , "bid":function() { return $("#selBsc").val(); }},
                colNames: ['스코어카드','성과','유형','주기','단위','가중치','S등급','평가등급','지표','실적','득점','','','',''],
                colModel: [
                	{ name: 'name', width: "20%", formatter:scoreFormatter },
                    { name: 'id',  width: "5%", sortable : false, resizable:false, align: 'center', formatter:btnFormatter},
                    { name: 'measurement', width: "5%", align: 'center' },
                    { name: 'frequency', width: "5%", align: 'center' },
                    { name: 'unit', width: "5%", align: 'left' },
                    { name: 'weight', width: "5%", align: 'right' },
                    { name: 'planned', width: "5%", align: 'center' },
                    { name: 'grade', width: "5%", align: 'right', formatter:btnGradeFormatter },
                    { name: 'id', width: "5%", sortable : false, resizable:false, align: 'center', formatter:btnMeasureFormatter },
                    { name: 'id',  width: "5%", sortable : false, resizable:false, align: 'center', formatter:btnActualFormatter },
                    { name: 'score', width: "5%", align: 'right', formatter:evalScoreFormatter },
                    { name: 'pid', width: "0%", hidden:true },
                    { name: 'id', width: "0%", hidden:true },
                    { name: 'name', width: "0%", hidden:true },
                    { name: 'score', width: "0%", hidden:true },
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
                caption : "조직 성과",
                rowNum: 10000,
                beforeSelectRow: function () {
                    return false;
                },
                jsonReader: {
	                root : 'selectOrgScore',
	                id   : 'id',
/* 	                page : 'pageMaker.cri.crtPage',
	                total: 'pageMaker.endPage',
	                records: 'pageMaker.totCnt', */
	                repeatitems: true
	            },
	            gridComplete : function() {
	            	resizeGrid();
                }
            });

			//#0019ff ,#33e800 , #fdf000, #fd9300, #fd0000, #c3c3c3
            function scoreFormatter(cellValue, options, rowObject){

				var reVal = "";
				var bgColor = "#c3c3c3";
				var txtColor = "#ffffff";

				var aScore = (String(rowObject.score)).split(',');
				var score =  aScore[ Number($("#selMonth").val())-1 ];

				var mleft = "0";

				if(rowObject.level == 5) mleft = "60";
				else if (rowObject.level == 4) mleft = "40";
				else if (rowObject.level == 3) mleft = "20";

				if(score > -1){
					if(score >= 96){
						bgColor = "#0019ff";
					} else if (score >= 91){
						bgColor = "#33e800";
					} else if (score >= 86){
						txtColor = "#4c4c4c";
						bgColor = "#fdf000";
					} else if (score >= 81){
						bgColor = "#fd9300";
					} else if (score >= 0){
						bgColor = "#fd0000";
					}

					reVal = "<span class=\"badge\" style=\"margin-left:"+mleft+"px;color:"+txtColor+";background-color: "+bgColor+"!important;\" >"+score+"</span> "+rowObject.name;
				} else {
					reVal = "<span class=\"badge\" style=\"margin-left:"+mleft+"px;color:"+txtColor+";background-color: "+bgColor+"!important;\" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> "+rowObject.name;
				}

				var year = rowObject.year;
            	var mcid = rowObject.mcid;


				return reVal;

            }


            function btnFormatter(cellValue, options, rowObject){
            	var year = $("#selYear option:selected").val();
            	var id = rowObject.id;

            	if(rowObject.level==5){
            		var writer = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:adjustMeasureDetail('" + rowObject.score + "','" + rowObject.actual +"','" + rowObject.grade + "','" + id + "');\"><i class='fa fa-pencil'></i>"+"보기"+"</div>";
                	return writer;
            	} else {
            		var writer = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:adjustDetail('" + rowObject.score + "','" + id + "');\"><i class='fa fa-pencil'></i>"+"보기"+"</div>";
                	return writer;
            	}

            }

			function evalScoreFormatter(cellValue, options, rowObject){
				if(rowObject.level==5){
					if(cellValue){
						//console.log("cellValue : "+cellValue);

						var aVal = (String(cellValue)).split(',');

						var val =  aVal[ Number($("#selMonth").val())-1 ]

						if(val == -1){
							return "0";
						} else {
							val = val*rowObject.weight/100;
							return val;
						}
					} else {
						return 0;
					}

				} else {
					return "";
				}
							}

			function btnGradeFormatter(cellValue, options, rowObject){
				if(cellValue){
					//console.log("cellValue : "+cellValue);

					var aVal = (String(cellValue)).split(',');

					var val =  aVal[ Number($("#selMonth").val())-1 ]

					if(val == -1){
						return "";
					} else {
						return val;
					}
				} else {
					return "";
				}
			}

            function btnMeasureFormatter(cellValue, options, rowObject){

            	if(rowObject.level == 5){
                	var year = $("#selYear option:selected").val();
                	var id = rowObject.id;

                	var writer = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:actionEditMeasure('" + year + "','" + id + "');\"><i class='fa fa-pencil'></i>"+"보기"+"</div>";
                	return writer;
            	} else {
            		return "";
            	}

            }



            function btnActualFormatter(cellValue, options, rowObject){
            	if(rowObject.level == 5){
                	var year = $("#selYear option:selected").val();
                	var id = rowObject.id;

                	var writer = "<div class='btn btn-xs btn-default' data-original-title='Edit Row' onclick=\"javascript:actionViewActual('" + year + "','" + id + "');\"><i class='fa fa-pencil'></i>"+"보기"+"</div>";
                	return writer;
            	} else {
            		return "";
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


		function actionEditMeasure(year, id){
			openMeasurePopup();

			var param = new Object();
	      	param.year = year
	     	param.id = id;

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


		function actionViewActual(year, id){
			openActualPopup();

			var param = new Object();
	      	param.year = year
	      	param.month = $("#selMonth option:selected").val();
	     	param.id = id;

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

	    var stHtml = "<tr role=\"row\">"
		stHtml += "<th rowspan=\"1\" colspan=\"1\" style=\"width:10%;\">아이디</th>";
		stHtml += "<th rowspan=\"1\" colspan=\"1\" style=\"width:40%;\">항목</th>";
		stHtml += "<th rowspan=\"1\" colspan=\"1\" style=\"width:10%;\">점수</th>";
		stHtml += "</tr>";

		var sbHtml = "<tr role=\"row\" >";
		sbHtml += "<td style=\"\">###id###</td>";
		sbHtml += "<td style=\"\">###name###</td>";
		sbHtml += "<td style=\"text-align:right;\">###score###</td>";
		sbHtml += "</tr>";

        function adjustDetail(scr, id){
			$("#th_state").empty();
			$("#th_state").append(stHtml);

        	var rowDatas = $("#jqgrid").getRowData();
        	$("#tb_state").empty();
        	for(var i in rowDatas){
        		if(id == rowDatas[i].pid){
        			var aScore = (String(rowDatas[i].score)).split(',');
        			var score =  aScore[ Number($("#selMonth").val())-1 ];
        			if(score>-1){
        			} else {
        				score = 0;
        			}
        			var tmpHtml = sbHtml.replace("###id###",rowDatas[i].id)
	        			.replace("###name###",rowDatas[i].name)
	        			.replace("###score###",score)
        			;
        			$("#tb_state").append(tmpHtml);
        			//console.log("rowData : "+i+" id : "+rowDatas[i].id+" // "+rowDatas[i].name+"//"+score);
        		}
        	}

        	var aScr = String(scr).split(",");
        	var aVal = new Array();
        	for(var v in aScr){
        		var val = aScr[v];
        		if(val == -1){
        			aVal[v] = 0;
        		} else {
        			aVal[v] = Number(val);
        		}
        	}

        	updateChart(aVal);
        }

        var stHtml2 = "<tr role=\"row\">"
    		stHtml2 += "<th rowspan=\"1\" colspan=\"1\" style=\"width:20%;\">주기</th>";
    		stHtml2 += "<th rowspan=\"1\" colspan=\"1\" style=\"width:10%;\">등급</th>";
    		stHtml2 += "<th rowspan=\"1\" colspan=\"1\" style=\"width:10%;\">실적</th>";
    		stHtml2 += "<th rowspan=\"1\" colspan=\"1\" style=\"width:10%;\">점수</th>";
    		stHtml2 += "</tr>";

    		var sbHtml2 = "<tr role=\"row\" >";
    		sbHtml2 += "<td style=\"\">###date###</td>";
    		sbHtml2 += "<td style=\"text-align:right;\">###grade###</td>";
    		sbHtml2 += "<td style=\"text-align:right;\">###actual###</td>";
    		sbHtml2 += "<td style=\"text-align:right;\">###score###</td>";
    		sbHtml2 += "</tr>";

        function adjustMeasureDetail(score, actual, grade, id){
        	$("#th_state").empty();
			$("#th_state").append(stHtml2);

        	var rowDatas = $("#jqgrid").getRowData();

			var acts = new Array();

        	var aScr = String(score).split(",");
        	var aVal = new Array();
        	for(var v in aScr){
        		var val = aScr[v];
        		if(val == -1){
        			aVal[v] = 0;
        		} else {
        			aVal[v] = Number(val);
        		}
        		if(v==2){
        			var obj = new Object();
        			obj.score = aVal[v];
        			obj.date = $("#selYear").val()+"년 "+"03월";
        			acts[0] = obj;
        		} else if (v==5) {
        			var obj = new Object();
        			obj.score = aVal[v];
        			obj.date = $("#selYear").val()+"년 "+"06월";
        			acts[1] = obj;
        		} else if (v==8) {
        			var obj = new Object();
        			obj.score = aVal[v];
        			obj.date = $("#selYear").val()+"년 "+"09월";
        			acts[2] = obj;
        		} else if (v==11) {
        			var obj = new Object();
        			obj.score = aVal[v];
        			obj.date = $("#selYear").val()+"년 "+"12월";
        			acts[3] = obj;
        		}
        	}

        	var aAtl = String(actual).split(",");
        	var aAct = new Array();
        	for(var v in aAtl){
        		var val = aAtl[v];
        		if(val == -1){
        			aAct[v] = 0;
        		} else {
        			aAct[v] = Number(val);
        		}
        		if(v==2){
        			acts[0].actual = aAct[v];
        		} else if (v==5) {
        			acts[1].actual = aAct[v];
        		} else if (v==8) {
        			acts[2].actual = aAct[v];
        		} else if (v==11) {
        			acts[3].actual = aAct[v];
        		}
        	}

        	var aGrds = String(actual).split(",");
        	for(var v in aGrds){
        		var val = aGrds[v];
        		if(val == -1){
        			val = 0;
        		} else {
        			val = Number(val);
        		}
        		if(v==2){
        			acts[0].grade = val;
        		} else if (v==5) {
        			acts[1].grade = val;
        		} else if (v==8) {
        			acts[2].grade = val;
        		} else if (v==11) {
        			acts[3].grade = val;
        		}
        	}




        	$("#tb_state").empty();

        	for(var i in acts){
        		var tmpHtml = sbHtml2.replace("###date###",acts[i].date)
    			.replace("###score###",acts[i].score)
    			.replace("###actual###",acts[i].actual)
    			.replace("###grade###",acts[i].grade)
				;
				$("#tb_state").append(tmpHtml);
        	}



        	updateMeasureChart(aVal, aAct);
        }

	</script>




		<script type="text/javascript">


	      // charts
	      var categories = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
	      var chart = Highcharts.chart('statisticsCharts', {
	        chart: {
	          marginTop: 55,
	          spacingBottom: 0,
	          spacingTop: 10,
	          spacingLeft: 20,
	          spacingRight: 20
	        },
	        colors: ['#12d2ff', '#602aec'],
	        title: {
	          text: ''
	        },
	        xAxis: {
	          /* min: 0.3,
	          max: categories.length - 1.3, */
	          categories: categories
	        },
	        yAxis: [{
	            title: {
	              text: '점수'
	            }
	          }, {
	            title: {
	              text: '실적'
	            },
	            opposite: true
	          }],
	        legend: {
	          align: 'right',
	          verticalAlign: 'top',
	          x: -55,
	          itemStyle: {
	            fontWeight: 'normal'
	          }
	        },
	        series: [
	          {
	            name: '점수',
	            yAxis: 0,
	            /* data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], */
	            type: 'line',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '실적',
	            yAxis: 1,
	            /* data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], */
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },

	        ],
	        credits: {
	          enabled: false
	        }

	      });


	      function updateChart(aVal){
	    	  chart.update({
	    		  colors: ['#12d2ff'],
	    	      series:
	    	        {
	    	        	name: '점수',
	    	            yAxis: 0,
	    	            data: aVal,
	    	            type: 'line',
	    	            marker: {
	    	              enabled: false
	    	            }
	    	        }
	    	    });
	      }

	      function updateMeasureChart(aVal, aAct){
	    	  chart.update({
	    		  colors: ['#12d2ff', '#602aec'],
	    	      series:[
	    	    	  {
    		            name: '점수',
    		            yAxis: 0,
    		            data: aVal,
    		            type: 'line',
    		            marker: {
    		              enabled: false
    		            }
    		          },
    		          {
    		            name: '실적',
    		            yAxis: 1,
    		            data: aAct,
    		            type: 'column',
    		            marker: {
    		              enabled: false
    		            }
    		          }
	    	        ]
	    	    });
	      }

	      function clearChart(){
	    	  chart.update({
	    		  colors: ['#c1c1c1'],
	    	      series:
	    	        {
	    	        	name: '',
	    	            yAxis: 0,
	    	            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	    	            type: 'line',
	    	            marker: {
	    	              enabled: false
	    	            }
	    	        }
	    	    });
	      }

</script>






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





