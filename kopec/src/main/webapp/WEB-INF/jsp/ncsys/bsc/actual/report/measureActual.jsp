<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">


<script type="text/javascript">
var selectBSCURL = "<c:url value='/scorecard/score/selectBSC.json'/>";


var selectMeasureActualUrl = "<c:url value='/actual/report/selectMeasureActual.json'/>";

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
	        }
	        $("#selYear").val("${config[0].showyear}");

	    }

		$("#selYear").change(function(){ selectBSC(); });
		$("#selSbu").change(function(){changeSbu(); });
		$("#selBsc").change(function(){actionPerformed(); });


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

			var bOpt = $("<option value='0'>:::전체:::</option>");
            $('#selBsc').append(bOpt);
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



		/* setTimeout(function(){
			actionPerformed();
		},1000); */


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

			var bOpt = $("<option value='0'>:::전체:::</option>");
            $('#selBsc').append(bOpt);
			for(var i in bsc){
	    		var aObj = bsc[i];
	    		adjustHierarchy(aObj.sid,aObj.scid,aObj.sname,aObj.bid,aObj.bcid,aObj.bname);
			}

			actionPerformed();
		}


		selectBSC();
	});







    function actionPerformed(){

    	//selFrq

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
		param.sid = $("#selSbu option:selected").val();
		var bid = $("#selBsc option:selected").val();
    	if(bid != 0){
    		param.bid = bid;
    	}
    	var frequency = $("#selFrq option:selected").val()
    	if(frequency != 0){
    		param.frequency = frequency;
    	}


    	_xAjax(selectMeasureActualUrl, param)
    	.done(function(data){
    		displayMeasureQty(data.measureQty);
    		displayMeasureQly(data.measureQly);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }





	var mHtml = "<tr role=\"row\" >";
	mHtml += "<td style=\"text-align: center;\">###bname###</td>";
	mHtml += "<td style=\"text-align: left;\">###pname###</td>";
	mHtml += "<td style=\"text-align: left;\">###mname###</td>";
	mHtml += "<td style=\"text-align: right;\">###empnm###</td>";
	mHtml += "<td style=\"text-align: right;\">###mweight###</td>";
	mHtml += "<td style=\"text-align: center;\">###frequency###</td>";
	mHtml += "<td style=\"text-align: center;\">###itemcode###</td>";
	mHtml += "<td style=\"text-align: left;\">###itemname###</td>";
	mHtml += "<td style=\"text-align: center;\">###itemfixed###</td>";
	mHtml += "<td style=\"text-align: right;\">###mm03###</td>";
	mHtml += "<td style=\"text-align: right;\">###mm06###</td>";
	mHtml += "<td style=\"text-align: right;\">###mm09###</td>";
	mHtml += "<td style=\"text-align: right;\">###mm12###</td>";
    mHtml += "</tr>";

    var curMeas = null;
	function displayMeasureQty(meas){
		$("#bd_qty").empty();

		curMeas = meas;
		for(var i in meas){
    		var aObj = meas[i];
    		var tmpHtml = mHtml.replace("###bname###",aObj.bname)
    		.replace("###pname###",aObj.pname)
    		.replace("###mname###",aObj.mname)
    		.replace("###empnm###",aObj.empnm?aObj.empnm:"")
    		.replace("###mweight###",aObj.mweight?aObj.mweight:"")
    		.replace("###frequency###",aObj.frequency?aObj.frequency:"")
    		.replace("###itemcode###",aObj.itemcode?aObj.itemcode:"")
    		.replace("###itemname###",aObj.itemname?aObj.itemname:"")
    		.replace("###itemfixed###",aObj.itemfixed=='Y'?aObj.itemfixed:"")
    		.replace("###mm03###",aObj.mm03?aObj.mm03:"")
    		.replace("###mm06###",aObj.mm06?aObj.mm06:"")
    		.replace("###mm09###",aObj.mm09?aObj.mm09:"")
    		.replace("###mm12###",aObj.mm12?aObj.mm12:"")
			;
    		$("#bd_qty").append(tmpHtml);
    	}

		/* $('#tb_qty').rowspan(0);
		$('#tb_qty').rowspan(1);
		$('#tb_qty').rowspan(2); */


		//mergeCell(tbl, startRow, cNum, length, add)
		// cNum : 비교시작 column
		mergeCell(document.getElementById('tb_qty'), '1', '2', '5','0');
		mergeCell(document.getElementById('tb_qty'), '1', '1', '1','0');
		mergeCell(document.getElementById('tb_qty'), '1', '0', '1','0');

	}



    var qHtml = "<tr role=\"row\" >";
    qHtml += "<td style=\"\">###bname###</td>";
    qHtml += "<td style=\"\">###pname###</td>";
    qHtml += "<td style=\"\">###mname###</td>";
    qHtml += "<td style=\"\">###empnm###</td>";
    qHtml += "<td style=\"\">###mweight###</td>";
    qHtml += "<td style=\"\">###frequency###</td>";
    qHtml += "<td style=\"\">###ym###</td>";
    qHtml += "<td style=\"\">###evalplan###</td>";
    qHtml += "<td style=\"\">###evalactual###</td>";
    qHtml += "<td style=\"\">###evalself###</td>";
    qHtml += "</tr>";

    var curMeasQly = null;
    function displayMeasureQly(meas){
    	$("#db_qly").empty();

    	curMeasQly = meas;
    	for(var i in meas){
    		var aObj = meas[i];
    		var tmpHtml = qHtml.replace("###bname###",aObj.bname)
    		.replace("###pname###",  aObj.pname)
    		.replace("###mname###", aObj.mname?aObj.mname:"")
    		.replace("###empnm###",aObj.empnm?aObj.empnm:"")
    		.replace("###mweight###",aObj.mweight?aObj.mweight:"")
    		.replace("###frequency###",aObj.frequency?aObj.frequency:"")
    		.replace("###ym###",aObj.ym?aObj.ym:"")
    		.replace("###evalplan###",aObj.evalplan?aObj.evalplan:"")
    		.replace("###evalactual###",aObj.evalactual?aObj.evalactual:"")
    		.replace("###evalself###",aObj.evalself?aObj.evalself:"")
    		;

    		$("#db_qly").append(tmpHtml);
    	}

    	//mergeCell(tbl, startRow, cNum, length, add)
		// cNum : 비교시작 column
    	mergeCell(document.getElementById('tb_qly'), '1', '2', '4','0');
		mergeCell(document.getElementById('tb_qly'), '1', '1', '1','0');
		mergeCell(document.getElementById('tb_qly'), '1', '0', '1','0');

    }


	function actionDownloadQty(){
		//actionDownloadCSV('tb_qty')

		$("#bd_qty").empty();

		for(var i in curMeas){
    		var aObj = curMeas[i];
    		var tmpHtml = mHtml.replace("###bname###",aObj.bname)
    		.replace("###pname###",aObj.pname)
    		.replace("###mname###",aObj.mname)
    		.replace("###empnm###",aObj.empnm?aObj.empnm:"")
    		.replace("###mweight###",aObj.mweight?aObj.mweight:"")
    		.replace("###frequency###",aObj.frequency?aObj.frequency:"")
    		.replace("###itemcode###",aObj.itemcode?aObj.itemcode:"")
    		.replace("###itemname###",aObj.itemname?aObj.itemname:"")
    		.replace("###itemfixed###",aObj.itemfixed=='Y'?aObj.itemfixed:"")
    		.replace("###mm03###",aObj.mm03?aObj.mm03:"")
    		.replace("###mm06###",aObj.mm06?aObj.mm06:"")
    		.replace("###mm09###",aObj.mm09?aObj.mm09:"")
    		.replace("###mm12###",aObj.mm12?aObj.mm12:"")
			;
    		$("#bd_qty").append(tmpHtml);
    	}

		actionDownloadCSV('tb_qty');

		displayMeasureQty(curMeas);

	}


	function actionDownloadQly(){

    	$("#db_qly").empty();

    	for(var i in curMeasQly){
    		var aObj = curMeasQly[i];
    		var tmpHtml = qHtml.replace("###bname###",aObj.bname)
    		.replace("###pname###",  aObj.pname)
    		.replace("###mname###", aObj.mname?aObj.mname:"")
    		.replace("###empnm###",aObj.empnm?aObj.empnm:"")
    		.replace("###mweight###",aObj.mweight?aObj.mweight:"")
    		.replace("###frequency###",aObj.frequency?aObj.frequency:"")
    		.replace("###ym###",aObj.ym?aObj.ym:"")
    		.replace("###evalplan###",aObj.evalplan?aObj.evalplan:"")
    		.replace("###evalactual###",aObj.evalactual?aObj.evalactual:"")
    		.replace("###evalself###",aObj.evalself?aObj.evalself:"")
    		;

    		$("#db_qly").append(tmpHtml);
    	}


		actionDownloadCSV('tb_qly');

		displayMeasureQly(curMeasQly);

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
	<div class="wrap" id="" >
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
							<option value='0'>:::전체:::</option>
							</select>
						</div>
					</div>
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;text-align: right;">주기 </label>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select type="text" class="form-control" id="selFrq" >
								<option value="0">전체</option>
								<option value="분기">분기</option>
								<option value="반기">반기</option>
								<option value="년">년</option>
							</select>
						</div>
					</div>

					<div class="col-md-2">
					<a onClick="javascript:actionPerformed();"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
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
									<a data-toggle="tab" href="#s1"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">계량</span></a>
								</li>
								<li>
									<a data-toggle="tab" href="#s2"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">비계량</span></a>
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
													<a class="btn btn-primary btn-sm" onClick="javascript:actionDownloadQty();">엑셀</a>
												</td>
											</tr>
											</table>
											<div id="" style="width:100%;height:550px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
											<table id="tb_qty" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
												<thead>
													<tr role="row">
													<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">조직명</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">관점</th>
													<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">성과지표</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">담당자</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">가중치</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">주기</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">코드</th>
													<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">지표항목명</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">계획값</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">3월</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">6월</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">9월</th>
													<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">12월</th>
													</tr>
												</thead>
												<tbody id="bd_qty">

												</tbody>
											</table>
											</div>
											</div>
										</div>
									</div>
									<!-- end s1 tab pane -->

									<div class="tab-pane fade" id="s2">
									<!-- 5등급 세부 배분표 -->

										<table width="100%" >
											<tr>
												<td style="text-align: right;">
													<a class="btn btn-primary btn-sm" onClick="javascript:actionDownloadQly();">엑셀</a>
												</td>
											</tr>
										</table>

										<div id="" style="width:100%;height:550px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
										<table id="tb_qly" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
											<thead>
												<tr role="row">
												<th rowspan="1" colspan="1" style="width:10%;">조직명</th>
												<th rowspan="1" colspan="1" style="width:10%;">관점</th>
												<th rowspan="1" colspan="1" style="width:10%;">성과지표</th>
												<th rowspan="1" colspan="1" style="width:5%;">담당자</th>
												<th rowspan="1" colspan="1" style="width:5%;">가중치</th>
												<th rowspan="1" colspan="1" style="width:5%;">주기</th>
												<th rowspan="1" colspan="1" style="width:5%;">년월</th>
												<th rowspan="1" colspan="1" style="width:10%;">계획</th>
												<th rowspan="1" colspan="1" style="width:10%;">실적</th>
												<th rowspan="1" colspan="1" style="width:10%;">내부분석</th>
												</tr>
											</thead>
											<tbody id="db_qly">
											</tbody>
										</table>
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






</body>
</html>

<script>

function mergeCell(tbl, startRow, cNum, length, add)
{
	var isAdd = false;
	if(tbl == null) return;
	if(startRow == null || startRow.length == 0) startRow = 1;
	if(cNum == null || cNum.length == 0) return ;
	if(add  == null || add.length == 0) {
		isAdd = false;
	}else {
		isAdd = true;
		add   = parseInt(add);
	}
	cNum   = parseInt(cNum);
	length = parseInt(length);

	rows   = tbl.rows;
	rowNum = rows.length;

	tempVal  = '';
	cnt      = 0;
	startRow = parseInt(startRow);

	for( i = startRow; i < rowNum; i++ ) {
		curVal = rows[i].cells[cNum].innerHTML;
		if(isAdd) curVal += rows[i].cells[add].innerHTML;
		if( curVal == tempVal ) {
			if(cnt == 0) {
				cnt++;
				startRow = i - 1;
			}
			cnt++;
		}else if(cnt > 0) {
			merge(tbl, startRow, cnt, cNum, length);
			startRow = endRow = 0;
			cnt = 0;
		}else {
		}
		tempVal = curVal;
	}

	if(cnt > 0) {
		merge(tbl, startRow, cnt, cNum, length);
	}
}

function merge(tbl, startRow, cnt, cellNum, length)
{
	rows = tbl.rows;
	row  = rows[startRow];

	for( i = startRow + 1; i < startRow + cnt; i++ ) {
		for( j = 0; j < length; j++) {
			rows[i].deleteCell(cellNum);
		}
	}
	for( j = 0; j < length; j++) {
		row.cells[cellNum + j].rowSpan = cnt;
	}
}


/*
*
* 같은 값이 있는 열을 병합함
*
* 사용법 : $('#테이블 ID').rowspan(0);
*   $('#resultTb').rowspan(0);
*   $('#resultTb').rowspan(1);
*/

$.fn.rowspan = function(colIdx, isStats) {
   return this.each(function(){
       var that;
       $('tr', this).each(function(row) {
           $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
               if ($(this).html() == $(that).html() && ((!isStats || isStats && $(this).prev().html() == $(that).prev().html())
                                                                   && $(this).html() !="소계" )) { // 값이 '소계' 이면 rowspan 안함.
                   rowspan = $(that).attr("rowspan") || 1;
                   rowspan = Number(rowspan)+1;

                   $(that).attr("rowspan",rowspan);
                   // do your action for the colspan cell here
                   $(this).hide();
                   //$(this).remove();
                   // do your action for the old cell here
               } else {
                   that = this;
               }

               $('#resultTb').colspan(row); // row 돌때 마다 colspan

               // set the that if not already set
               that = (that == null) ? this : that;

           });
       });
   });
};



/*
*
* 같은 값이 있는 행을 병합함
*
* 사용법 : $('#테이블 ID').colspan (0);
*
*/
$.fn.colspan = function(rowIdx) {

// alert("col  :  "+rowIdx);

   return this.each(function(){

       var that;
       $('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
           $(this).find('td').filter(':visible').each(function(col) {
               if ($(this).html() == $(that).html()) {
                   colspan = $(that).attr("colSpan") || 1;
                   colspan = Number(colspan)+1;

                   $(that).attr("colSpan",colspan);
                   $(this).hide(); // .remove();
               } else {
                   that = this;
               }

               // set the that if not already set
               that = (that == null) ? this : that;

           });
       });
   });
}


</script>



