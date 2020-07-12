<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">

<script type="text/javascript">
var selectInitURL = "<c:url value='/admin/valuate/selectInit.json'/>";

var selectValuateURL = "<c:url value='/admin/valuate/selectValuate.json'/>";
var selectEvalerURL = "<c:url value='/admin/valuate/selectEvaler.json'/>";

var adjustValuteURL = "<c:url value='/admin/valuate/adjustValute.json'/>";

var deleteValuateURL = "<c:url value='/admin/valuate/deleteValuate.json'/>";

</script>


<script type="text/javascript">
	$(document) .ready( function() {
		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		actionInit();

		$("#selYear").change(function(){ actionInit(); });

		$("#selMonth").change(function(){ actionInit(); });

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
        $("#selYear option:eq(5)").attr("selected", "selected");
    }


    function actionInit(){
    	/* select tblpsnbaseline */

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.month = $("#selMonth option:selected").val();

    	_xAjax(selectInitURL, param)
    	.done(function(data){

   			displayValuate(data.selectValuate);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});


    }




    /* curValuate */
     var curValuate = null;

     var valHtml = "<tr role=\"row\" bcid=\"###bcid###\" grpid=\"###grpid###\" >";
     valHtml += "<td style=\"\">###sname###</td>";
     valHtml += "<td style=\"\">###bname###</td>";
     valHtml += "<td style=\"\" empno=\"###empno###\">###empnm###</td>";
     valHtml += "</tr>";

     function displayValuate(selectValuate){
    	curValuate = null;
     	$("#bd_valuate").empty();


     	for(var i in selectValuate){
     		var aObj = selectValuate[i];
     		var tmpHtml = valHtml.replace("###bcid###",aObj.bcid)
     		.replace("###grpid###",aObj.grpid?aObj.grpid:"")
     		.replace("###sname###",aObj.sname)
     		.replace("###bname###",aObj.bname)
     		.replace("###empno###",aObj.empno?aObj.empno:"")
     		.replace("###empnm###",aObj.empnm?aObj.empnm:"");

     		$("#bd_valuate").append(tmpHtml);
     	}

 		$("#bd_valuate tr").click(function(){
 			actionClick($(this));
 		})

     }
     function actionClick(rowObj){
     	$(curValuate).removeClass("select_row");
     	curValuate = $(rowObj)
     	$(curValuate).addClass("select_row");
     	//selectDeptMapping();
     }




     function searchEvaler(){
     	var param = new Object();
    	param.searchName = $("#searchName").val();

    	_xAjax(selectEvalerURL, param)
    	.done(function(data){
   			displayEvaler(data.selectEvaler);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

     }


     var curEvaler = null;

     var evalerHtml = "<tr role=\"row\">";
     evalerHtml += "<td style=\"\">###deptnm###</td>";
     evalerHtml += "<td style=\"\">###userid###</td>";
     evalerHtml += "<td style=\"\">###usernm###</td>";
     evalerHtml += "</tr>";

     function displayEvaler(evaler){
    	 curEvaler = null;
     	$("#bd_evaler").empty();
     	for(var i in evaler){
     		var aObj = evaler[i];
     		var tmpHtml = evalerHtml.replace("###deptnm###",aObj.deptnm)
     		.replace("###userid###",aObj.userid)
     		.replace("###usernm###",aObj.usernm);

     		$("#bd_evaler").append(tmpHtml);
     	}

 		$("#bd_evaler tr").click(function(){
 			actionClickEvaler($(this));
 		})

     }
     function actionClickEvaler(rowObj){
     	$(curEvaler).removeClass("select_row");
     	curEvaler = $(rowObj)
     	$(curEvaler).addClass("select_row");
     }



     function adjustValute(){
    	if(!curValuate){
    		alert("평가기관정보를 선택하십시오.");
    		return;
    	}
    	if(!curEvaler){
    		alert("평가자를 선택하십시오.");
    		return;
    	}
		var rdValute = $(curValuate).children();
    	var rdEvaler = $(curEvaler).children();

     	var param = new Object();
     	param.year = $("#selYear option:selected").val();
     	param.month = $("#selMonth option:selected").val();

    	param.evaldeptid = $(curValuate).attr("bcid");
    	param.grpid = $(curValuate).attr("grpid");
    	param.grpnm = rdValute.eq(1).text();
    	param.evalrid = rdEvaler.eq(1).text();

    	_xAjax(adjustValuteURL, param)
    	.done(function(data){
    		displayValuate(data.selectValuate);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

     }

	function deleteValute(){
		if(!curValuate){
    		alert("평가자를 선택하십시오.");
    		return;
    	}
		var rdValute = $(curValuate).children();
		var evalrid = rdValute.eq(2).attr("empno");

		if(evalrid){
	     	var param = new Object();
	     	param.year = $("#selYear option:selected").val();
	     	param.month = $("#selMonth option:selected").val();

	    	param.evaldeptid = $(curValuate).attr("bcid");
	    	param.grpid = $(curValuate).attr("grpid");
	    	param.evalrid = evalrid

	    	_xAjax(deleteValuateURL, param)
	    	.done(function(data){
	    		displayValuate(data.selectValuate);
	    	}).fail(function(error){
	    		console.log("actionInit error : "+error);
	    	});
		} else {
			alert("삭제하고자하는 평가자를 선택하십시오.");
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
					<!-- <label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;">조직구분 </label>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selQ">
								<option value="1">1/4분기</option>
								<option value="2">2/4분기</option>
								<option value="3">3/4분기</option>
								<option value="4">4/4분기</option>
							</select>
						</div>
					</div> -->
					<div class="col-md-4">
					<a onClick="javascript:actionInit();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
					<a onClick="javascript:actionDownloadCSV('tb_valuate');"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a>
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
						<h2>평가기관 </h2>
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
						<table id="tb_valuate" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:30%;">조직구분</th>
								<th rowspan="1" colspan="1" style="width:40%;">조직명</th>
								<th rowspan="1" colspan="1" style="width:30%;">평가자</th>
								</tr>
							</thead>
							<tbody id="bd_valuate">

							</tbody>
	                    </table>
	                    </div>
				</div>

	            <div class="col-md-1" style="padding-right: 1px;width: 52px; text-align: center">
	            <br><br><br><br><br>
					<!-- <a class="btn btn-default btn-sm" onClick="javascript:delDeptMapping();"><<</a><br><br> -->
					<a class="btn btn-default btn-sm" onClick="javascript:adjustValute();"><</a><br><br>
					<a class="btn btn-default btn-sm" onClick="javascript:deleteValute();">></a><br><br>
					<!-- <a class="btn btn-default btn-sm" onClick="javascript:delAll();">>></a><br><br> -->
	            </div>

	            <div class="col-md-5" style="padding-right: 1px;width: 44%;">
	                <div class="">평가위원</div>
                    <div class=""><input type=text id="searchName" style="width:70%"/>
                    <a class="btn btn-default btn-sm" onClick="javascript:searchEvaler();">조회</a>
                    </div>
						<div id="" style="width:100%;height:560px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_evaler" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:30%;">부서명</th>
								<th rowspan="1" colspan="1" style="width:30%;">아이디</th>
								<th rowspan="1" colspan="1" style="width:40%;">평가위원</th>
								</tr>
							</thead>
							<tbody id="bd_evaler">

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



</body>
</html>





