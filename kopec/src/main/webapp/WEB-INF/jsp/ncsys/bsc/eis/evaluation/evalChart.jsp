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
var selectEvalOrgRstURL = "<c:url value='/eis/evaluation/selectEvalOrgRst.json'/>";


</script>


<script type="text/javascript">



$(document) .ready( function() {
	$('form').bind('submit', function () {return false})
	var date = new Date();
	var year = date.getFullYear();
	funcSetDate(year);
	//actionInit();

	$("#selYear").change(function(){ actionPerformed(); });
	$(":input:radio[name=rdoDiv]").click(function(){ clickDiv(); });
	$("#btnSearch").click(function(){ actionPerformed(); });
	$("#btnExcel").click(function(){ actionDownloadCSV('tb_evalOrgRst'); });


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

        actionPerformed();
    }

    function actionPerformed(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectEvalOrgRstURL, param)
    	.done(function(data){

			displayEvalOrgRst(data.evalOrgRst);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }

    var sHtml = "<tr role=\"row\" >";
    sHtml += "<td style=\"\">###padep###</td>";
    sHtml += "<td style=\"text-align: right;\">###divNm###</td>";
    sHtml += "<td style=\"text-align: right;\">###empBonus3###</td>";
    sHtml += "<td style=\"text-align: right;\">###empBonus4###</td>";
    sHtml += "<td style=\"text-align: right;\">###empBonus5###</td>";
    sHtml += "<td style=\"text-align: right;\">###empBonus6###</td>";
    sHtml += "<td style=\"text-align: right;\">###empBonus7###</td>";
    sHtml += "<td style=\"text-align: right;\">###empBonus8###</td>";
    sHtml += "</tr>";

    var curRst = null;
    function displayEvalOrgRst(evalOrgRst){
    	//bd_evalOrgRst
    	$("#bd_evalOrgRst").empty();

    	/* setting header */
		curRst = evalOrgRst

		var curYear = $("#selYear").val();

		$("#bonusYear3").text(curYear-5);
		$("#bonusYear4").text(curYear-4);
		$("#bonusYear5").text(curYear-3);
		$("#bonusYear6").text(curYear-2);
		$("#bonusYear7").text(curYear-1);
		$("#bonusYear8").text(curYear-0);

    	for(var i in evalOrgRst){
    		var aObj = evalOrgRst[i];
    		var tmpHtml = sHtml.replace("###padep###",aObj.padep)
    		.replace("###divNm###",aObj.divNm?aObj.divNm:"0")
    		.replace("###empBonus3###",aObj.empBonus3?aObj.empBonus3:"0")
    		.replace("###empBonus4###",aObj.empBonus4?aObj.empBonus4:"0")
    		.replace("###empBonus5###",aObj.empBonus5?aObj.empBonus5:"0")
    		.replace("###empBonus6###",aObj.empBonus6?aObj.empBonus6:"0")
    		.replace("###empBonus7###",aObj.empBonus7?aObj.empBonus7:"0")
    		.replace("###empBonus8###",aObj.empBonus8?aObj.empBonus8:"0");

    		$("#bd_evalOrgRst").append(tmpHtml);


    	}
    	updateChart();
    }


    function updateChart(){
    	var bonus8 = new Array();
    	var bonus7 = new Array();
    	var bonus6 = new Array();
    	var bonus5 = new Array();
    	var bonus4 = new Array();
    	var bonus3 = new Array();

    	var org = new Array();
    	var j = 0;

    	var st = $(":input:radio[name=rdoDiv]:checked").val();

    	for(var i in curRst){
    		var aObj = curRst[i];
    		if( aObj.padepNum == st ){
    			var sObj = new Object();

    			sObj.divNm = aObj.divNm;

    			var bonus = new Array();

    			bonus.push(aObj.empBonus3?Number(aObj.empBonus3):0);
    			bonus.push(aObj.empBonus4?Number(aObj.empBonus4):0);
    			bonus.push(aObj.empBonus5?Number(aObj.empBonus5):0);
    			bonus.push(aObj.empBonus6?Number(aObj.empBonus6):0);
    			bonus.push(aObj.empBonus7?Number(aObj.empBonus7):0);
    			bonus.push(aObj.empBonus8?Number(aObj.empBonus8):0);

    			sObj.bonus = bonus;

    			org[j] = sObj;
    			j = j+1;
    		}
    	}

    	var cate = new Array();
    	cate.push($("#bonusYear3").text());
    	cate.push($("#bonusYear4").text());
    	cate.push($("#bonusYear5").text());
    	cate.push($("#bonusYear6").text());
    	cate.push($("#bonusYear7").text());
    	cate.push($("#bonusYear8").text());


    	chart.update({
			xAxis: {
			       categories: cate
			     },
			     colors: ['#602aec','#12d2ff','#9265ff','#12d2ff', '#65fff8','#65ff86','#ffec65','#f665ff','#84ff65','#ffac65'],
			    series:[
			  	  	  {
			          name: org[0].divNm,
			          yAxis: 0,
			          data: org[0].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			          }
			       },
			       {
			          name: org[1].divNm,
			          yAxis: 0,
			          data: org[1].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			         	}
			       }
			       ,
			       {
			          name: org[2].divNm,
			          yAxis: 0,
			          data: org[2].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			         	}
			       },
			       {
			          name: org[3].divNm,
			          yAxis: 0,
			          data: org[3].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			          }
			    },
			       {
			          name: org[4].divNm,
			          yAxis: 0,
			          data: org[4].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			          }
			       },
			       {
			          name: org[5].divNm,
			          yAxis: 0,
			          data: org[5].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			          }
			       },
			       {
			          name: org[6].divNm,
			          yAxis: 0,
			          data: org[6].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			          }
			       },
			       {
			          name: org[7].divNm,
			          yAxis: 0,
			          data: org[7].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			          }
			       },
			       {
			          name: org[8].divNm,
			          yAxis: 0,
			          data: org[8].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			          }
			       },
			       {
			          name: org[9].divNm,
			          yAxis: 0,
			          data: org[9].bonus,
			          type: 'column',
			          marker: {
			            enabled: false
			          }
			       }
			      ]
  	    });

    }


    function clickDiv(){
    	//h2Title
    	var st = $(":input:radio[name=rdoDiv]:checked").val();

    	if(st == "01") {
    		$("#h2Title").empty();
    		$("#h2Title").append("장려금 지급률");

    		updateChart();

    	} else if(st == "02") {

    		$("#h2Title").empty();
    		$("#h2Title").append("사장성과 지급률");

    		updateChart();

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


})
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
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;text-align: right;"></label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md" style="padding-top: 6px;" >
							<input type="radio" style="" name="rdoDiv" value="01" checked="checked" /> 장려금 지급률
						</div>
					</div>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md" style="padding-top: 6px;">
							<input type="radio" style="" name="rdoDiv" value="02" /> 사장성과 지급률
						</div>
					</div>
					<div class="col-md-4">
					<a id="btnSearch"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
					<a id="btnExcel"   class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a>
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
						<header style="">
						<h2 id="h2Title">장려급지급률</h2>
						</header>
						<!-- body -->
						<div role="content">
							<div class="widget-body no-padding" style="">

	<div class="row">
		<!-- NEW WIDGET START -->
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="min-width:240px;">
			<div class="col-md-12" style="height:340px;">

				<div class="" style="height:320px;" id="statisticsCharts"></div>

			</div>
		</div>


    </div><!-- end of row   -->


							</div>
							<!-- end widget-body -->
						</div>
						<!-- end content -->
					</div>
					<!-- end widget -->













					<!-- new widget -->
					<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false" style="padding: 6px;">
						<header style="">
						<h2>그룹사별 성과추이</h2>
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
								                    <div id="" style="width:100%;height:360px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">

														<table id="tb_evalOrgRst" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
															<thead>
																<tr role="row">
																<th rowspan="1" colspan="1" style="width:15%;vertical-align: middle;">구분</th>
																<th rowspan="1" colspan="1" style="width:15%;vertical-align: middle;">그룹사</th>
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;" id="bonusYear3"></th>
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;" id="bonusYear4"></th>
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;" id="bonusYear5"></th>
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;" id="bonusYear6"></th>
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;" id="bonusYear7"></th>
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;" id="bonusYear8"></th>
																</tr>
															</thead>
															<tbody id="bd_evalOrgRst">

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















		<script type="text/javascript">


	      // charts
	      var categories = ['','', '', '', '', ''];
	      var chart = Highcharts.chart('statisticsCharts', {
	        chart: {
	          marginTop: 15,
	          spacingBottom: 0,
	          spacingTop: 10,
	          spacingLeft: 10,
	          spacingRight: 10
	        },
	        colors: ['#602aec','#12d2ff','#9265ff','#12d2ff', '#65fff8','#65ff86','#ffec65','#f665ff','#84ff65','#ffac65'],
	        title: {
	          text: ''
	        },
	        xAxis: {
	          categories: categories
	        },
	        yAxis: {
	            title: {
	              text: '점수'
	            }
	          },
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
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	          {
	            name: '',
	            yAxis: 0,
	            data: [0, 0, 0, 0, 0, 0],
	            type: 'column',
	            marker: {
	              enabled: false
	            }
	          },
	        ],
	        credits: {
	          enabled: false
	        },
	        legend: {
	        	   layout: 'vertical',
	        	   align: 'right',
	        	   verticalAlign: 'middle',
	        	   itemMarginTop: 0,
	        	   itemMarginBottom: 10
	        	 },

	      });



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






</body>
</html>





