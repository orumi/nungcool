<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">

 	<!-- jqxTree  -->

<script type="text/javascript">


var selectSBUURL = "<c:url value='/actual/measure/selectSBU.json'/>";
var selectMeasureListURL = "<c:url value='/actual/qtyActual/selectMeasureList.json'/>";
var selectMeasureItemURL = "<c:url value='/actual/qtyActual/selectMeasureItem.json'/>";
var selectMeasurePlannedURL = "<c:url value='/actual/qtyActual/selectMeasurePlanned.json'/>";

var adjustItemPlannedURL = "<c:url value='/actual/qtyActual/adjustItemPlanned.json'/>";

var deleteItemPlannedURL = "<c:url value='/actual/qtyActual/deleteItemPlanned.json'/>";

//deleteItemPlanned



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

	        selectInit();
	    }

		$("#selYear").change(function(){
			reset();
			selectInit();
		});

		$("#selSBU").change(function(){
			reset();
			actionPerformed();
		});


	});


	function selectInit(){
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
		var option = $("<option value='0'>::전체::</option>");
        $('#selSBU').append(option);
		for(var i in sbu){
			var obj = sbu[i];
			var option = $("<option value='"+obj.sid+"'>"+obj.sname+"</option>");
	        $('#selSBU').append(option);
		}

		actionPerformed();

	}

	function actionPerformed(){
		var param = new Object();
		param.year = $("#selYear option:selected").val();
		param.sid = $("#selSBU option:selected").val();

		if($("#chkItemfixed").prop("checked")){
			param.itemFixed = "Y";
		}

		_xAjax(selectMeasureListURL, param)
    	.done(function(data){
    		if(data.reCode == "SUCCESS"){
    			dispalyMeasureList(data.measureList);
    		} else {

    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

	}

	var mHtml ="<tr role=\"row\" mcid=\"###mcid###\">";
	mHtml += "<td style=\"\" >###sname###</td>";
	mHtml += "<td style=\"text-align: left;\">###bname###</td>";
	mHtml += "<td style=\"text-align: left;\">###mname###</td>";
	mHtml += "<td style=\"text-align: left;\">###itemcount###</td>";
	mHtml += "<td style=\"text-align: left;\">###itemfixed###</td>";
	mHtml += "</tr>";

	var curMeasure = null;
	function dispalyMeasureList(measureList){
		curMeasure = null;
		$("#bd_measureList").empty();

		for(var i in measureList){
    		var aObj = measureList[i];
    		var tmpHtml = mHtml.replace("###mcid###",aObj.mcid)
    		.replace("###sname###",aObj.sname?aObj.sname:"")
    		.replace("###bname###",aObj.bname?aObj.bname:"")
    		.replace("###mname###",aObj.mname?aObj.mname:"")
    		.replace("###itemcount###",aObj.itemcount?aObj.itemcount:"0")
    		.replace("###itemfixed###",aObj.itemfixed?aObj.itemfixed:"0")
			;

    		$("#bd_measureList").append(tmpHtml);
    	}

		$("#bd_measureList tr").click(function(){
 			actionClickMeasure($(this));
 		})
	}


	function actionClickMeasure(rowObj){
		$(curMeasure).removeClass("select_row");
		curMeasure = $(rowObj)
     	$(curMeasure).addClass("select_row");
     	selectItem();
	}

	function selectItem(){
		$("#bd_item").empty();
		$("#bd_planned").empty();

		var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.mcid = $(curMeasure).attr("mcid");

    	_xAjax(selectMeasureItemURL, param)
    	.done(function(data){

   			displayItem(data.measureItem);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}

	var oHtml ="<tr role=\"row\" code=\"###code###\">";
	oHtml += "<td style=\"\" >###code###</td>";
	oHtml += "<td style=\"text-align: left;\">###itemname###</td>";
	oHtml += "<td style=\"text-align: left;\">###itemfixed###</td>";
	oHtml += "<td style=\"text-align: left;\">###itementry###</td>";
	oHtml += "</tr>";

	function displayItem(measureOwner){
		$("#bd_item").empty();


		for(var i in measureOwner){
    		var aObj = measureOwner[i];
    		var tmpHtml = oHtml.replace("###code###",aObj.code)
    		.replace("###code###",aObj.code?aObj.code:"")
    		.replace("###itemname###",aObj.itemname?aObj.itemname:"")
    		.replace("###itemfixed###",aObj.itemfixed?aObj.itemfixed:"")
    		.replace("###itementry###",aObj.itementry?aObj.itementry:"")
			;

    		$("#bd_item").append(tmpHtml);
    	}
		$("#bd_item tr").click(function(){
			actionClickItem($(this));
 		})

	}

	var curItem = null;
	function actionClickItem(rowObj){
		$(curItem).removeClass("select_row");
		curItem = $(rowObj)
     	$(curItem).addClass("select_row");

		var rwObj = $(curItem).children();
		var itemfixed = rwObj.eq(2).text();

		if("Y" == itemfixed){
			selectPlanned();
		} else {
			$("#bd_planned").empty();

			alert("계획값 항목을 선택하십시오.");
		}

	}

	function selectPlanned(){
		$("#bd_planned").empty();

		var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.mcid = $(curMeasure).attr("mcid");
    	param.itemcode = $(curItem).attr("code");

    	_xAjax(selectMeasurePlannedURL, param)
    	.done(function(data){

   			displayPlanned(data.itemActual);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}

	var pHtml ="<tr role=\"row\" code=\"###code###\" strdate=\"###strdate###\">";
	pHtml += "<td style=\"\" >###strdate###</td>";
	pHtml += "<td class=\"\"><input type=\"text\" style=\"width:100%;text-align:right;\" value=\"###actual###\"/></td>";
	pHtml += "</tr>";

	function displayPlanned(itemActual){
		$("#bd_planned").empty();

		for(var i in itemActual){
    		var aObj = itemActual[i];
    		var tmpHtml = pHtml.replace("###code###",aObj.code)
    		.replace("###strdate###",aObj.strdate?aObj.strdate:"")
    		.replace("###strdate###",aObj.strdate?aObj.strdate:"")
    		.replace("###actual###",aObj.actual?aObj.actual:"")
			;

    		$("#bd_planned").append(tmpHtml);
    	}

	}


	function actionAdjust(){
		var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.mcid = $(curMeasure).attr("mcid");
    	param.itemcode = $(curItem).attr("code");

    	var aParam = new Array();
    	$("#bd_planned tr").each(function(i){
    		var trObj = $("#bd_planned tr").eq(i);
    		var tdObj = trObj.children();

    		var pm = new Object();
			pm.year   = $("#selYear option:selected").val();
			pm.mcid  = $(curMeasure).attr("mcid");
			pm.itemcode  =trObj.attr("code");;
			pm.strdate  = trObj.attr("strdate");

			pm.actual  = tdObj.eq(1).find("input").val();

			aParam.push(pm);
    	})

    	if(aParam.length>0){
	    	param.itemactuals = JSON.stringify(aParam);


	    	_xAjax(adjustItemPlannedURL, param)
	    	.done(function(data){

	   			if(data.reCode=="SUCCESS"){
	   				displayPlanned(data.itemActual);
	   				alert("저장되었습니다.");
	   			} else {
	   				alert("저장하는데 실패하였습니다. 관리자에게 문의바랍니다.");
	   			}

	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});

    	} else {
    		alert("계획값 항목을 선택하십시오.");
    	}
	}


	//deleteItemPlannedURL


	function actionDelete(){

		if(confirm("선택한 항목계획값을 삭제하시겠습니까?")){

			var param = new Object();
	    	param.year = $("#selYear option:selected").val();
	    	param.mcid = $(curMeasure).attr("mcid");
	    	param.itemcode = $(curItem).attr("code");

	    	_xAjax(deleteItemPlannedURL, param)
	    	.done(function(data){

	   			if(data.reCode=="SUCCESS"){
	   				displayPlanned(data.itemActual);
	   				alert("삭제되었습니다.");
	   			} else {
	   				alert("삭제하는데 실패하였습니다. 관리자에게 문의바랍니다.");
	   			}

	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});

		}
	}



	function reset(){
		curMeasure = null;
		$("#bd_measureList").empty();

		curOwner = null;
		$("#bd_owner").empty();

		$("#bd_updater").empty();
		$("#bd_authority").empty();

		$("#bd_userList").empty();
		curToUser = null

		$("#fromuserid").val("");
		$("#touserid").val("");
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

#bd_measureList tr{
	cursor:pointer;
}
#bd_item tr{
	cursor:pointer;
}
#bd_planned tr{
	/* cursor:pointer; */
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
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;">조직구분 </label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selSBU">
							</select>
						</div>
					</div>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<input type="checkbox" class="form-control" id="chkItemfixed" checked="checked" style="width:16px;" /><font style="position:fixed;padding-left:6px;padding-top:12px;"> 계획값 항목</font>
						</div>
					</div>
					<div class="col-md-2">
					<a onClick="javascript:actionDownloadCSV('tb_measureList');"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a>
					<a onClick="actionPerformed();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
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
						<h2>성과지표 목록</h2>
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
												<div class="col-md-6" style="padding-right: 1px;;">
									                <!-- <div class="">평가기관</div> -->
									                    <div id="" style="width:100%;height:560px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
														<table id="tb_measureList" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
									                    	<thead>
																<tr role="row">
																<th rowspan="1" colspan="1" style="width:20%;">조직구분</th>
																<th rowspan="1" colspan="1" style="width:20%;">조직명</th>
																<th rowspan="1" colspan="1" style="width:40%;">지표명</th>
																<th rowspan="1" colspan="1" style="width:20%;">항목수</th>
																<th rowspan="1" colspan="1" style="width:20%;">계획값</th>
																</tr>
															</thead>
															<tbody id="bd_measureList">

															</tbody>
									                    </table>
									                    </div>
												</div>

									            <div class="col-md-6" style="padding-right: 18px;;">

													<div id="" style="width:100%;height:260px;overflow-y:scroll; overflow-x: hidden">
													<table id="tb_item" class="table table-striped table-bordered table-hover dataTable" style="width: 100%; table-layout: fixed;">
								                    	<thead>
															<tr role="row">
															<th rowspan="1" colspan="1" style="width:10%;">코드</th>
															<th rowspan="1" colspan="1" style="width:40%;">항목명</th>
															<th rowspan="1" colspan="1" style="width:20%;">계획값</th>
															<th rowspan="1" colspan="1" style="width:20%;">입력유형</th>
															</tr>
														</thead>
														<tbody id="bd_item">

														</tbody>
								                    </table>
								                    </div>



													<div id="" style="width:100%;height:260px;overflow-y:scroll; overflow-x: hidden">
													<table id="tb_planned" class="table table-striped table-bordered table-hover dataTable" style="width: 100%; table-layout: fixed;">
								                    	<thead>
															<tr role="row">
															<th rowspan="1" colspan="1" style="width:50%;">년월</th>
															<th rowspan="1" colspan="1" style="width:50%;">계획값(누계)</th>
															</tr>
														</thead>
														<tbody id="bd_planned">

														</tbody>
								                    </table>
								                    </div>

													<div class="" style="text-align: center">
								                    	<a class="btn btn-default btn-sm" onClick="javascript:actionDelete();">삭제</a>
								                    	<a class="btn btn-default btn-sm" onClick="javascript:actionAdjust();">저장</a>
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





















</body>
</html>





