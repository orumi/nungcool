<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">


<script type="text/javascript">
var selectScheduleURL = "<c:url value='/admin/config/selectSchedule.json'/>";

var adjustScheduleURL = "<c:url value='/admin/config/adjustSchedule.json'/>";
var adjustCopyScheduleURL = "<c:url value='/admin/config/adjustCopySchedule.json'/>";



</script>


<script type="text/javascript">
	$(document) .ready( function() {

		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);
		setFrToYear(year);

		actionInit();

		 $("#selYear").change(function(){ actionInit(); });

		// START AND FINISH DATE
		$('#startdate').datepicker({
			dateFormat : 'yymmdd',
			prevText : '<i class="fa fa-chevron-left"></i>',
			nextText : '<i class="fa fa-chevron-right"></i>',
			onSelect : function(selectedDate) {
				$('#finishdate').datepicker('option', 'minDate', selectedDate);
			}
		});

		$('#finishdate').datepicker({
			dateFormat : 'yymmdd',
			prevText : '<i class="fa fa-chevron-left"></i>',
			nextText : '<i class="fa fa-chevron-right"></i>',
			onSelect : function(selectedDate) {
				$('#startdate').datepicker('option', 'maxDate', selectedDate);
			}
		});


	});



    function funcSetDate(curYear) {
        for (i=0,j=curYear-6; i<=6;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear option:eq(5)").attr("selected", "selected");
    }

    function setFrToYear(curYear) {
    	for (i=0,j=curYear-6; i<=6;i++,j++) {
    		$("#selFrYear").append("<option value='"+j+"'>"+j+"</option>");
    		$("#selToYear").append("<option value='"+j+"'>"+j+"</option>");
       }
    	$("#selFrYear option:eq(5)").attr("selected", "selected");
    	$("#selToYear option:eq(5)").attr("selected", "selected");
    }



    function actionInit(){
    	/* select tblpsnbaseline */

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectScheduleURL, param)
    	.done(function(data){

   			displaySchedule(data.selectSchedule);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});


    }


    function actionReset(){
    	$(curSchedule).removeClass("select_row");
		setClear();
		curSchedule = null;
    }

     /* Schedule */
     var scheduleList = null;
     var curSchedule = null;

     var scheduleHtml = "<tr role=\"row\" divCd=\"###divCd###\">";
     scheduleHtml += "<td style=\"\">###divCd###</td>";
     scheduleHtml += "<td style=\"\">###divNm###</td>";
     scheduleHtml += "<td style=\"\">###startDt###</td>";
     scheduleHtml += "<td style=\"\">###endDt###</td>";
     scheduleHtml += "<td style=\"\">###divYn###</td>";
     scheduleHtml += "</tr>";

     function displaySchedule(schedule){
    	 setClear();
    	 curSchedule = null;
    	 scheduleList = null;
     	$("#bd_schedule").empty();

     	scheduleList = schedule;
     	for(var i in schedule){
     		var aSchedule = schedule[i];
     		var tmpHtml = scheduleHtml.replace("###divCd###",aSchedule.divCd)
     		.replace("###divCd###",aSchedule.divCd)
     		.replace("###divNm###",aSchedule.divNm)
     		.replace("###startDt###",aSchedule.startDt)
     		.replace("###endDt###",aSchedule.endDt)
     		.replace("###divYn###",aSchedule.divYn)
     		;

     		$("#bd_schedule").append(tmpHtml);
     	}

 		$("#bd_schedule tr").click(function(){
 			actionClick($(this));
 		})

     }
     function actionClick(rowObj){
     	$(curSchedule).removeClass("select_row");
     	curSchedule = $(rowObj)
     	$(curSchedule).addClass("select_row");
     	selectSchedule();
     }

     function adjustSchedule(){

     	var param = new Object();
     	param.year = $("#selYear option:selected").val();
     	param.div_cd = $("#div_cd").val();
     	param.div_nm = $("#div_nm").val();
     	param.start_dt = $("#startdate").val();
     	param.end_dt = $("#finishdate").val();

     	param.q1 = $("#q1").prop("checked")?"Y":"N";
     	param.q2 = $("#q2").prop("checked")?"Y":"N";
     	param.q3 = $("#q3").prop("checked")?"Y":"N";
     	param.q4 = $("#q4").prop("checked")?"Y":"N";
     	param.m01 = $("#m01").prop("checked")?"Y":"N";
     	param.m02 = $("#m02").prop("checked")?"Y":"N";
     	param.m03 = $("#m03").prop("checked")?"Y":"N";
     	param.m04 = $("#m04").prop("checked")?"Y":"N";
     	param.m05 = $("#m05").prop("checked")?"Y":"N";
     	param.m06 = $("#m06").prop("checked")?"Y":"N";
     	param.m07 = $("#m07").prop("checked")?"Y":"N";
     	param.m08 = $("#m08").prop("checked")?"Y":"N";
     	param.m09 = $("#m09").prop("checked")?"Y":"N";
     	param.m10 = $("#m10").prop("checked")?"Y":"N";
     	param.m11 = $("#m11").prop("checked")?"Y":"N";
     	param.m12 = $("#m12").prop("checked")?"Y":"N";


     	_xAjax(adjustScheduleURL, param)
     	.done(function(data){
     		if(data.selectSchedule.length > 0){
     			displaySchedule(data.selectSchedule);
     			alert("저장되었습니다.");
     		} else {

     		}

     	}).fail(function(error){
     		console.log("actionInit error : "+error);
     	});
     }










     function selectSchedule(){
    	 setClear();
    	 var divCd = $(curSchedule).attr("divCd");

    	 for(var s in scheduleList){
    		 if(divCd == scheduleList[s].divCd){
    			 var schedule = scheduleList[s];
    			 $("#div_cd").val(schedule.divCd);
    			 $("#div_nm").val(schedule.divNm);

    			 $("#startdate").val(schedule.startDt);
    			 $("#finishdate").val(schedule.endDt);

    			 if (schedule.m01=="Y") $("#m01").prop("checked","checked");
    			 if (schedule.m02=="Y") $("#m02").prop("checked","checked");
    			 if (schedule.m03=="Y") $("#m03").prop("checked","checked");
    			 if (schedule.m04=="Y") $("#m04").prop("checked","checked");
    			 if (schedule.m05=="Y") $("#m05").prop("checked","checked");
    			 if (schedule.m06=="Y") $("#m06").prop("checked","checked");
    			 if (schedule.m07=="Y") $("#m07").prop("checked","checked");
    			 if (schedule.m08=="Y") $("#m08").prop("checked","checked");
    			 if (schedule.m09=="Y") $("#m09").prop("checked","checked");
    			 if (schedule.m10=="Y") $("#m10").prop("checked","checked");
    			 if (schedule.m11=="Y") $("#m11").prop("checked","checked");
    			 if (schedule.m12=="Y") $("#m12").prop("checked","checked");

    			 if (schedule.q1=="Y") $("#q1").prop("checked","checked");
    			 if (schedule.q2=="Y") $("#q2").prop("checked","checked");
    			 if (schedule.q3=="Y") $("#q3").prop("checked","checked");
    			 if (schedule.q4=="Y") $("#q4").prop("checked","checked");
    		 }
    	 }
     }


     function setClear(){
    	 $("#div_cd").val("");
    	 $("#div_nm").val("");
    	 $("#q1").prop("checked","");
    	 $("#q2").prop("checked","");
    	 $("#q3").prop("checked","");
    	 $("#q4").prop("checked","");

    	 $("#m01").prop("checked","");
    	 $("#m02").prop("checked","");
    	 $("#m03").prop("checked","");
    	 $("#m04").prop("checked","");
    	 $("#m05").prop("checked","");
    	 $("#m06").prop("checked","");
    	 $("#m07").prop("checked","");
    	 $("#m08").prop("checked","");
    	 $("#m09").prop("checked","");
    	 $("#m10").prop("checked","");
    	 $("#m11").prop("checked","");
    	 $("#m12").prop("checked","");

     }


     function clickQ(tag){
    	 console.log("checked : "+$("#q1").prop("checked"));
    	 if(tag=="1"){
    		 if($("#q1").prop("checked")){
    			 $("#m01").prop("checked","checked");
            	 $("#m02").prop("checked","checked");
            	 $("#m03").prop("checked","checked");
    		 } else {
    			 $("#m01").prop("checked","");
            	 $("#m02").prop("checked","");
            	 $("#m03").prop("checked","");
    		 }
    	 } else if(tag=="2"){
    		 if($("#q2").prop("checked")){
	    		 $("#m04").prop("checked","checked");
	        	 $("#m05").prop("checked","checked");
	        	 $("#m06").prop("checked","checked");
    		 } else {
    			 $("#m04").prop("checked","");
	        	 $("#m05").prop("checked","");
	        	 $("#m06").prop("checked","");
    		 }
    	 } else if(tag=="3"){
    		 if($("#q3").prop("checked")){
	    		 $("#m07").prop("checked","checked");
	        	 $("#m08").prop("checked","checked");
	        	 $("#m09").prop("checked","checked");
    		 } else {
    			 $("#m07").prop("checked","");
	        	 $("#m08").prop("checked","");
	        	 $("#m09").prop("checked","");
    		 }
    	 } else if(tag=="4"){
    		 if($("#q4").prop("checked")){
	    		 $("#m10").prop("checked","checked");
	        	 $("#m11").prop("checked","checked");
	        	 $("#m12").prop("checked","checked");
    		 } else {
    			 $("#m10").prop("checked","");
	        	 $("#m11").prop("checked","");
	        	 $("#m12").prop("checked","");
    		 }
    	 }
     }


     function actionYearCopy(){
     	var param = new Object();

     	param.frYear = $("#selFrYear option:selected").val();
     	param.toYear = $("#selToYear option:selected").val();

     	_xAjax(adjustCopyScheduleURL, param)
     	.done(function(data){
     		alert("적용되었습니다.");

     	}).fail(function(error){
     		console.log("actionInit error : "+error);
     	});
     }



     function actionYearCopyOpen(){
     	$("#div_year").show();
 		$(".wrap").after("<div class='overlay'></div>");
     }


     function closePopup(){
     	$("#div_year").hide();
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

#bd_schedule tr{
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
					<div class="col-md-1">
					<a onClick="actionInit();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
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
						<h2>일정관리 </h2>
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
	                    <div id="" style="width:100%;height:260px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_bsc" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:20%;">일정코드</th>
								<th rowspan="1" colspan="1" style="width:50%;">일정명</th>
								<th rowspan="1" colspan="1" style="width:10%;">시작일자</th>
								<th rowspan="1" colspan="1" style="width:10%;">종료일자</th>
								<th rowspan="1" colspan="1" style="width:10%;">상태</th>
								</tr>
							</thead>
							<tbody id="bd_schedule">

							</tbody>
	                    </table>
	                    </div>
				</div>


			</fieldset>



			<fieldset>
				<div class="col-md-6" style="padding-right: 1px;margin-top: 15px;">
				<div class="form-group">
					<div class="row col-md-12" style="margin-bottom:4px;">
						<label class="control-label col-md-2" for="prepend"
							style="padding-top: 6px;">일정코드 </label>
						<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
							<div class="icon-addon addon-md">
								<input type="text" class="form-control" id="div_cd" name="div_cd" style=""/>
							</div>
						</div>
						<div class="col-md-8" style="padding-right: 6px; padding-left: 1px;">
							* 신규 일정코드 추가시 관련 프로그램의 수정이 필요합니다.
						</div>
					</div>
					<div class="row col-md-12" style="margin-bottom:4px;">
						<label class="control-label col-md-2" for="prepend"
							style="padding-top: 6px;">일정명 </label>
						<div class="col-md-10" style="padding-right: 6px; padding-left: 1px;">
							<div class="icon-addon addon-md">
								<input type="text" class="form-control" id="div_nm" name="div_nm" style=""/>
							</div>
						</div>
					</div>
					<div class="row col-md-12 smart-form" style="margin-bottom:4px;">
						<label class="control-label col-md-2" for="prepend"
							style="padding-top: 6px;width:12%;">시작일자 </label>
						<div class="col-md-10">
						<section class="col col-5">
							<label class="input"> <i class="icon-append fa fa-calendar"></i>
								<input type="text" name="startdate" id="startdate" placeholder="시작일자">
							</label>
						</section>
						<label class="control-label col-md-2" for="prepend"
							style="padding-top: 6px;">종료일자</label>
						<section class="col col-5">
							<label class="input"> <i class="icon-append fa fa-calendar"></i>
								<input type="text" name="finishdate" id="finishdate" placeholder="종료일자">
							</label>
						</section>
						</div>
					</div>
				</div>
				</div>

				<!-- 오른쪽 마감 영역   -->
				<div class="col-md-1" style="padding-right: 1px;margin-top: 15px;">
				<label class="control-label col-md-12" for="prepend" style="padding-top: 10px;">마감 </label>
				</div>
				<div class="col-md-5" style="padding-right: 1px;margin-top: 15px;">
				<div class="form-group">

					<div class="col-md-12" style="padding-right: 6px; padding-left: 1px;height: 30px;">
						<div class="checkbox" style="float:left;margin: 10px;">
							<label ><input type="checkbox" id="q1" onClick="javascript:clickQ(1);">1/4분기</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m01">1월</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m02">2월</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m03">3월</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12" style="padding-right: 6px; padding-left: 1px;height: 30px;">
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="q2" onClick="javascript:clickQ(2);">2/4분기</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m04">4월</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m05">5월</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m06">6월</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-12" style="padding-right: 6px; padding-left: 1px;height: 30px;">
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="q3" onClick="javascript:clickQ(3);">3/4분기</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m07">7월</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m08">8월</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m09">9월</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-md-10" style="padding-right: 6px; padding-left: 1px;height: 30px;">
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="q4" onClick="javascript:clickQ(4);">4/4분기</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m10">10월</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m11">11월</label>
						</div>
						<div class="checkbox" style="float:left;margin: 10px;">
							<label><input type="checkbox" id="m12">12월</label>
						</div>
					</div>
				</div>
				</div>

			</fieldset>
			<fieldset style="width: 100%;">
				<div class="form-group">
					<div class="col-md-12">
					<!-- <a onClick="adjustDeptMapping();"  class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;">삭제</a> -->
					<a onClick="adjustSchedule();"  class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;">저장</a>
					<a onClick="actionReset();"  class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;">초기화</a>
					<a onClick="actionYearCopyOpen();"  class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;">연도복사</a>

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
<div class="" id="div_year" name="div_year" style="display: none;">
		<div class="popup" style="width:400px;left:450px;top:200px;">
<form class="form-horizontal"  style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>평가일정 연도복사</h2>
		</header>

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">

			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-3" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">기준년도 </label>
					<div class="col-md-3" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selFrYear">
							</select>

						</div>
					</div>
					<label class="control-label col-md-3" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">복사년도 </label>
					<div class="col-md-3" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selToYear">
							</select>

						</div>
					</div>
				</div>
			</fieldset>



			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
						<a onClick="javascript:closePopup();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
						<a onClick="javascript:actionYearCopy();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">적용</a>

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





