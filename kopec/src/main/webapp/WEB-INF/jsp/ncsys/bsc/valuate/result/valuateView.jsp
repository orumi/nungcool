<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">



<script type="text/javascript">

var selectEvalGrpURL = "<c:url value='/valuate/result/selectEvalGrp.json'/>";
var selectEvalViewURL = "<c:url value='/valuate/result/selectEvalView.json'/>";

</script>


<script type="text/javascript">



$(document) .ready( function() {
	$('form').bind('submit', function () {return false})
	var date = new Date();
	var year = date.getFullYear();
	funcSetDate(year);

	$("#selYear").change(function(){ actionInit(); });
	$("#selMonth").change(function(){ actionPerformed(); });
	$("#selGrp").change(function(){ actionPerformed(); });
	$("#btnSearch").click(function(){ actionPerformed(); });
	/* $("#btnExcel").click(function(){ actionDownloadCSVWithHeader('tb_status'); }); */



	function funcSetDate(curYear) {
        for (i=0,j=curYear-12; i<=12;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear").val("${config[0].showyear}");
        $("#selMonth").val("${config[0].showmonth}");

        actionInit();
    }



	function actionInit(){
		var param = new Object();
		param.year = $("#selYear option:selected").val();
		param.month = $("#selMonth option:selected").val();

    	_xAjax(selectEvalGrpURL, param)
    	.done(function(data){

			setGrp(data.evalGrp);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

	}


	function setGrp(evalGrp){
		$("#selGrp").empty();

		for(var i in evalGrp){
			var grp = evalGrp[i];
			var option = $("<option value='"+grp.grpid+"'>"+grp.grpnm+"</option>");
            $('#selGrp').append(option);
		}

		actionPerformed();
	}


    function actionPerformed(){

    	$("#db_list").empty();

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();
    	param.grpid = $("#selGrp option:selected").val();


    	_xAjax(selectEvalViewURL, param)
    	.done(function(data){

			displayList(data.evalView);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }

    var sHtml = "<tr role=\"row\" >";
    sHtml += "<td style=\"\">###mname###</td>";
    sHtml += "<td style=\"text-align: left;\">###sname###</td>";
    sHtml += "<td style=\"text-align: right;\">###bname###</td>";
    sHtml += "<td style=\"text-align: right;\">###avgScore###</td>";
    sHtml += "<td style=\"text-align: right;\">###grade###</td>";
    sHtml += "<td style=\"text-align: right;\">###mweight###</td>";
    sHtml += "<td style=\"text-align: right;\">###measScore###</td>";
    sHtml += "</tr>";


    function displayList(evalView){
    	$("#bd_list").empty();

    	for(var i in evalView){
    		var aObj = evalView[i];
    		var tmpHtml = sHtml.replace("###mname###",aObj.mname)
    		.replace("###sname###",aObj.sname?aObj.sname:"")
    		.replace("###bname###",aObj.bname?aObj.bname:"")
    		.replace("###avgScore###",aObj.avgScore?aObj.avgScore:"0")
    		.replace("###grade###",aObj.grade?aObj.grade:"")
    		.replace("###mweight###",aObj.mweight?aObj.mweight:"0")
    		.replace("###measScore###",aObj.measScore?aObj.measScore:"0")
    		;


    		$("#bd_list").append(tmpHtml);

    	}

    }








})

















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
		var header = ["구분","조직명","재무성과","고객지향"
			,"내부프로세스","학습과성장"
			,"계량","비계량"
			,"합계"];
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
						style="padding-top: 6px;text-align: right;">그룹선택 </label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select type="text" class="form-control" id="selGrp" >
							</select>
						</div>
					</div>
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;text-align: right;"></label>
					<div class="col-md-3">
					<a id="btnSearch"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
					<!-- <a id="btnExcel"   class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a> -->
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
						<h2>비계량 성과지표</h2>
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

														<table id="tb_list" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
															<thead>
																<tr role="row">
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">지표</th>
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">구분</th>
																<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">조직명</th>
																<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평균점수</th>
																<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">평균등급</th>
																<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">가중치</th>
																<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">득점</th>
																</tr>
															</thead>
															<tbody id="bd_list">

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



</body>
</html>





