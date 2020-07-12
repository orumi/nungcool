<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">

<script type="text/javascript">
var selectInitURL = "<c:url value='/admin/psn/selectInit.json'/>";

var selectPsnEmpScoreURL = "<c:url value='/admin/psn/selectPsnEmpScore.json'/>";
var selectEmployeeURL = "<c:url value='/admin/psn/selectEmployee.json'/>";

</script>


<script type="text/javascript">
	$(document) .ready( function() {
		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		actionInit();

		$("#selYear").change(function(){ actionInit(); });

		$("#searchName").keydown(function (key) { //검색창에서 Enter눌렀을 때 검색
		          if (key.keyCode == 13) {
		          	searchEvaler();
		          }
		      });

	});


	function funcSetDate(curYear) {
        for (i=0,j=curYear-6; i<=6;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear").val("${config[0].showyear}");
    }


	var divYn = "";

    function actionInit(){
    	/* select tblpsnbaseline */

    	clearReset();
    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectInitURL, param)
    	.done(function(data){

    		divYn = data.selectPeriod[0].divYn;
			if("N" == divYn){
				alert("개인성과 기준지급률 조회 기간이 아닙니다.");
			} else {
				actionPsnEmpScore();
			}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});


    }

	function clearReset(){
		$("#bscRate").val("");
 		$("#jikgbNm").val("");
 		/* $("#empNm").val("");
 		$("#empNo").val(""); */

		$("#bd_psnScore").empty();
		$("#bd_psnBizmh").empty();
		curEmp = null;
	    $("#bd_emp").empty();
	}



    function actionPsnEmpScore(){
    	if("N" == divYn){
			alert("개인성과 기준지급률 조회 기간이 아닙니다.");
			return;
		}

    	var param = new Object();
     	param.year = $("#selYear option:selected").val();
    	param.empNo = "${userId}";

    	_xAjax(selectPsnEmpScoreURL, param)
    	.done(function(data){
			if("SUCCESS" == data.reCode){
				displayPsnEmpScore(data.selectPsnScore);
				displayPsnBizmh(data.selectPsnBizmh)
				closePopup();
			} else if("PSNLABOR"== data.reCode) {
				alert("노조 및 예외자입니다.");
			}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
    }





     var scrHtml = "<tr role=\"row\">";
     scrHtml += "<td style=\"\">###sbunm###</td>";
     scrHtml += "<td style=\"\">###sbuGrade###</td>";
     scrHtml += "<td style=\"\">###bscnm###</td>";
     scrHtml += "<td style=\"\">###bscGrade###</td>";
     scrHtml += "<td style=\"\">###bscRate###</td>";
     scrHtml += "<td style=\"\">###bscMh###</td>";
     scrHtml += "<td style=\"\">###bscMhRate###</td>";
     scrHtml += "</tr>";

     function displayPsnEmpScore(psnScore){
    	$("#bscRate").val("");

     	$("#bd_psnScore").empty();

     	for(var i in psnScore){
     		var aObj = psnScore[i];
     		var tmpHtml = scrHtml.replace("###sbunm###",aObj.sbunm)
     		.replace("###sbuGrade###",aObj.sbuGrade?aObj.sbuGrade:"")
     		.replace("###bscnm###",aObj.bscnm?aObj.bscnm:"")
     		.replace("###bscGrade###",aObj.bscGrade?aObj.bscGrade:"")
     		.replace("###bscRate###",aObj.bscRate?aObj.bscRate:"")
     		.replace("###bscMh###",aObj.bscMh?aObj.bscMh:"")
     		.replace("###bscMhRate###",aObj.bscMhRate?aObj.bscMhRate:"")
     		;

     		$("#bd_psnScore").append(tmpHtml);

     		$("#bscRate").val(aObj.bscRate);

     	}


     }


     var mhHtml = "<tr role=\"row\">";
     mhHtml += "<td style=\"\">###bscnm###</td>";
     mhHtml += "<td style=\"\">###deptCd###</td>";
     mhHtml += "<td style=\"\">###deptNm###</td>";
     mhHtml += "<td style=\"\">###mh###</td>";
     mhHtml += "<td style=\"\">###exceptCmt###</td>";
     mhHtml += "</tr>";

     function displayPsnBizmh(psnBizmh){
     	$("#bd_psnBizmh").empty();

     	for(var i in psnBizmh){
     		var aObj = psnBizmh[i];
     		var tmpHtml = mhHtml.replace("###bscnm###",aObj.bscnm)
     		.replace("###deptCd###",aObj.deptCd?aObj.deptCd:"")
     		.replace("###deptNm###",aObj.deptNm?aObj.deptNm:"")
     		.replace("###mh###",aObj.mh?aObj.mh:"")
     		.replace("###exceptCmt###",aObj.exceptCmt?aObj.exceptCmt:"");

     		$("#bd_psnBizmh").append(tmpHtml);
     	}


     }






     function searchEmp(){
     	var param = new Object();
     	param.year = $("#selYear option:selected").val();
    	param.empNm = $("#searchName").val();

    	_xAjax(selectEmployeeURL, param)
    	.done(function(data){
   			displayEmp(data.selectEmp);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

     }


     var curEmp = null;

     var empHtml = "<tr role=\"row\">";
     empHtml += "<td style=\"\">###userid###</td>";
     empHtml += "<td style=\"\">###usernm###</td>";
     empHtml += "<td style=\"\">###jikgbNm###</td>";
     empHtml += "</tr>";

     function displayEmp(emp){
    	 curEmp = null;
     	$("#bd_emp").empty();
     	for(var i in emp){
     		var aObj = emp[i];
     		var tmpHtml = empHtml.replace("###jikgbNm###",aObj.jikgbNm?aObj.jikgbNm:"")
     		.replace("###userid###",aObj.userid)
     		.replace("###usernm###",aObj.usernm);

     		$("#bd_emp").append(tmpHtml);
     	}

     	$("#bd_emp tr").click(function(){
 			actionClickEmp($(this));
 		});

     	$("#bd_emp tr").dblclick(function(){
     		actionDBClickEmp($(this));
 		});

     }
     function actionClickEmp(rowObj){
     	$(curEmp).removeClass("select_row");
     	curEmp = $(rowObj)
     	$(curEmp).addClass("select_row");
     }

     function actionDBClickEmp(rowObj){
    	 $(curEmp).removeClass("select_row");
      	curEmp = $(rowObj)
      	$(curEmp).addClass("select_row");

      	actionPsnEmpScore();
     }






    function openUserPopup(){
     	$("#div_property").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closePopup(){
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
		<header id="header" style="height:84px;">
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
						style="padding-top: 6px;text-align: right;">성명 </label>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="empNo" value="${userId}"/>
						</div>
					</div>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="empNm" value="${userName}"/>
						</div>
					</div>
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;text-align: right;width:13%">기준지급률(%) </label>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="bscRate" />
						</div>
					</div>
				</div>
			</fieldset>
			<fieldset style="width: 100%;">
				<div class="form-group">
					<label class="control-label col-md-12" for="prepend"
						style="padding-top: 6px;">* 조직별 인원 수의 차이로 기준지급률은 본부(단)별 지급액 범위내에서 what-if 분석도구 방식(목표값 찾기)으로 조정됨
						(최종지급률 : 급여명세서 표기) </label>

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
						<header style="    margin-top: 32px;">
						<h2>성과급 기준지급률 산정기준 [개인성과급 기준지급률 = SUM(성과지급류 * M/H 평가배분류)/SUM(M/H 평가배분률)] </h2>
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
				<div class="col-md-12" style="padding-right: 1px;border-bottom: 1px solid #c1c1c1;margin-bottom: 12px;">
	                <!-- <div class="">평가기관</div> -->
	                    <div id="" style="width:100%;height:260px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_psnScore" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:15%;">조직구분</th>
								<th rowspan="1" colspan="1" style="width:10%;">평가등급</th>
								<th rowspan="1" colspan="1" style="width:15%;">평가부서명</th>
								<th rowspan="1" colspan="1" style="width:10%;">평가등급</th>
								<th rowspan="1" colspan="1" style="width:10%;">성과지급률</th>
								<th rowspan="1" colspan="1" style="width:15%;">평가부서 M/H</th>
								<th rowspan="1" colspan="1" style="width:15%;">M/H 평가배분률</th>
								</tr>
							</thead>
							<tbody id="bd_psnScore">

							</tbody>
	                    </table>
	                    </div>
				</div>



	            <div class="col-md-12" style="padding-right: 1px;">
	                <div class="">평가부서별 M/H 확인</div>
					<div id="" style="width:100%;height:260px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_psnBizmh" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:20%;">평가부서명</th>
								<th rowspan="1" colspan="1" style="width:15%;">사업부서코드</th>
								<th rowspan="1" colspan="1" style="width:20%;">사업부서명</th>
								<th rowspan="1" colspan="1" style="width:15%;">M/H</th>
								<th rowspan="1" colspan="1" style="width:20%;">예외사항</th>
								</tr>
							</thead>
							<tbody id="bd_psnBizmh">

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
<div class="popup" style="width:600px;left:300px;top:100px;">
<form class="form-horizontal"  style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>평가년도 사원 선택</h2>
		</header>

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">

			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">성명  </label>
					<div class="col-md-8" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="searchName" name="searchName"/>
						</div>
					</div>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<a onClick="javascript:searchEmp();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
						</div>
					</div>

				</div>
			</fieldset>
			<fieldset>
				<div class="col-md-12" style="padding-right: 1px;;">
	                    <div id="" style="width:100%;height:360px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_emp" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:20%;">사번</th>
								<th rowspan="1" colspan="1" style="width:20%;">성명</th>
								<th rowspan="1" colspan="1" style="width:20%;">직급</th>
								</tr>
							</thead>
							<tbody id="bd_emp">

							</tbody>
	                    </table>
	                    </div>
				</div>
			</fieldset>


			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
						<a onClick="javascript:closePopup();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
						<a onClick="javascript:actionPsnEmpScore();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">선택</a>
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




