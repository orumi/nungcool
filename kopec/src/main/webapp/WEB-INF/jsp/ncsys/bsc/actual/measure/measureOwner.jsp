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
var selectMeasureListURL = "<c:url value='/actual/measure/selectMeasureList.json'/>";
var selectMeasureOwnerURL = "<c:url value='/actual/measure/selectMeasureOwner.json'/>";

var selectUserListURL = "<c:url value='/actual/measure/selectUserList.json'/>";
var adjustMeasureUpdaterURL = "<c:url value='/actual/measure/adjustMeasureUpdater.json'/>";

var adjustUpdaterWithToURL = "<c:url value='/actual/measure/adjustUpdaterWithTo.json'/>";
//adjustUpdaterWithTo
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




		 $("#searchText").keydown(function (key) {
	            if (key.keyCode == 13) {
	            	actionSearchUser();
	            }
	        });
	});


	function selectInit(){

		//$("#bd_list").empty();
		//$("#bd_detail").empty();

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
	mHtml += "<td style=\"\" >###snm###</td>";
	mHtml += "<td style=\"text-align: left;\">###bnm###</td>";
	mHtml += "<td style=\"text-align: left;\">###mnm###</td>";
	mHtml += "<td style=\"text-align: left;\">###freq###</td>";
	mHtml += "</tr>";

	var curMeasure = null;
	function dispalyMeasureList(measureList){
		curMeasure = null;
		$("#bd_measureList").empty();

		for(var i in measureList){
    		var aObj = measureList[i];
    		var tmpHtml = mHtml.replace("###mcid###",aObj.mcid)
    		.replace("###snm###",aObj.snm?aObj.snm:"")
    		.replace("###bnm###",aObj.bnm?aObj.bnm:"")
    		.replace("###mnm###",aObj.mnm?aObj.mnm:"")
    		.replace("###freq###",aObj.freq?aObj.freq:"0")
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
     	selectOwner();
	}

	function selectOwner(){
		$("#bd_updater").empty();
		$("#bd_authority").empty();

		$("#bd_userList").empty();
		curToUser = null

		$("#fromuserid").val("");
		$("#touserid").val("");

		var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.mcid = $(curMeasure).attr("mcid");

    	_xAjax(selectMeasureOwnerURL, param)
    	.done(function(data){

   			displayOwner(data.measureOwner);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}

	var oHtml ="<tr role=\"row\" usertype=\"###usertype###\">";
	oHtml += "<td style=\"\" >###usertypenm###</td>";
	oHtml += "<td style=\"text-align: left;\">###deptNm###</td>";
	oHtml += "<td style=\"text-align: left;\">###userid###</td>";
	oHtml += "<td style=\"text-align: left;\">###usernm###</td>";
	oHtml += "</tr>";

	function displayOwner(measureOwner){
		$("#bd_owner").empty();


		for(var i in measureOwner){
    		var aObj = measureOwner[i];
    		var tmpHtml = oHtml.replace("###usertypenm###",aObj.usertypenm)
    		.replace("###deptNm###",aObj.deptNm?aObj.deptNm:"")
    		.replace("###userid###",aObj.userid?aObj.userid:"")
    		.replace("###usernm###",aObj.usernm?aObj.usernm:"")
    		.replace("###usertype###",aObj.usertype?aObj.usertype:"")
			;

    		$("#bd_owner").append(tmpHtml);
    	}
		$("#bd_owner tr").click(function(){
			actionClickOwner($(this));
 		})

	}

	function refreshOwner(){
		$("#bd_owner").empty();
		$("#bd_updater tr").each(function(i){
			var trObj = $("#bd_updater tr").eq(i);
			var userid = $(trObj).attr("userid");

			var tdObj = $(trObj).children();
			var deptNm = tdObj.eq(0).text();
			var usernm = tdObj.eq(1).text();

			var tmpHtml = oHtml.replace("###usertypenm###","정")
    		.replace("###deptNm###",deptNm)
    		.replace("###userid###",userid)
    		.replace("###usernm###",usernm)
    		.replace("###usertype###","1")
			;

    		$("#bd_owner").append(tmpHtml);

		});

		$("#bd_authority tr").each(function(i){
			var trObj = $("#bd_authority tr").eq(i);
			var userid = $(trObj).attr("userid");

			var tdObj = $(trObj).children();
			var deptNm = tdObj.eq(0).text();
			var usernm = tdObj.eq(1).text();

			var tmpHtml = oHtml.replace("###usertypenm###","부")
    		.replace("###deptNm###",deptNm)
    		.replace("###userid###",userid)
    		.replace("###usernm###",usernm)
    		.replace("###usertype###","2")
			;

    		$("#bd_owner").append(tmpHtml);

		});

		$("#bd_owner tr").click(function(){
			actionClickOwner($(this));
 		})

		closeUpdaterPopup();
	}


	var curOwner = null;

	function actionClickOwner(rowObj){
		$(curOwner).removeClass("select_row");
		curOwner = $(rowObj)
     	$(curOwner).addClass("select_row");
     	clickOwner();
	}

	function clickOwner(){
		var tdObj = $(curOwner).children();
		$("#fromuserid").val(tdObj.eq(3).text());
	}











	function displayOwnerPopup(){
		/* popup */
		$("#bd_updater").empty();
		$("#bd_authority").empty();

		$("#bd_owner tr").each(function(i){
			var trObj = $("#bd_owner tr").eq(i);
			var usertype = $(trObj).attr("usertype");

			var tdObj = $(trObj).children();
			var deptNm = tdObj.eq(1).text();
			var userid = tdObj.eq(2).text();
			var usernm = tdObj.eq(3).text();

			if(usertype == 1){
				addUpdater(userid, deptNm, usernm);
			} else {
				addAuthority(userid, deptNm, usernm);
			}

		})

	}




	function adjustOwner(){
    	var aParam = new Array();
    	$("#bd_owner tr").each(function(i){
    		var trObj = $("#bd_owner tr").eq(i);

    		var pm = new Object();
    		pm.year = $("#selYear option:selected").val();

    		var usertype = $(trObj).attr("usertype");
			var tdObj = $(trObj).children();
			var userid = tdObj.eq(2).text();

    		pm.usertype = usertype;
    		pm.ownerId = userid;
			pm.mcid = $(curMeasure).attr("mcid");

    		aParam.push(pm);

    	});

    	var param = new Object();
    	param.owners = JSON.stringify(aParam);
    	param.year = $("#selYear option:selected").val();
    	param.mcid = $(curMeasure).attr("mcid");


    	_xAjax(adjustMeasureUpdaterURL, param)
    	.done(function(data){
    		if(data.reCode == "SUCCESS"){
    			alert("저장되었습니다.");
    		} else {
    			alert("실패하였습니다. 관리자에게 문의바랍니다.");
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}
















	var uHtml ="<tr style=\"padding: 4px 10px;\">"
	uHtml += "<td width=\"40%\" class=\"\" style=\"\">###deptNm###</td>"
	uHtml += "<td width=\"20%\" class=\"\" style=\"\">###username###</td>"
	uHtml += "<td width=\"20%\" class=\"\" style=\"text-align: center; \">"
	uHtml += "<button class=\"btn btn-default \" onclick=\"addUpdater('###userid###','###deptNm###','###username###');\" >추가</button>"
	uHtml += "</td>"
	uHtml += "<td width=\"20%\" class=\"\" style=\"text-align: center; \">"
	uHtml += "<button class=\"btn btn-default \" onclick=\"addAuthority('###userid###','###deptNm###','###username###');\" >추가</button>"
	uHtml += "</td>"
	uHtml += "</tr>"

	function selectUserList(){
		var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectUserListURL, param)
    	.done(function(data){

   			displayUserList(data.userList);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}

	function actionSearchUser(){
		var param = new Object();
    	param.year = $("#selYear option:selected").val();
		param.searchText = $("#searchText").val();

    	_xAjax(selectUserListURL, param)
    	.done(function(data){

   			displayUserList(data.userList);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}



	function displayUserList(userList){
		//bd_User
		$("#bd_User").empty();

		for(var i in userList){
    		var aObj = userList[i];
    		var tmpHtml = uHtml.replace("###deptNm###",aObj.deptNm)
    		.replace("###username###",aObj.username?aObj.username:"")
    		.replace("###userid###",aObj.userid?aObj.userid:"")
    		.replace("###deptNm###",aObj.deptNm?aObj.deptNm:"")
    		.replace("###username###",aObj.username?aObj.username:"")
    		.replace("###userid###",aObj.userid?aObj.userid:"")
    		.replace("###deptNm###",aObj.deptNm?aObj.deptNm:"")
    		.replace("###username###",aObj.username?aObj.username:"")
			;

    		$("#bd_User").append(tmpHtml);
    	}
	}


	var updaterHtml ="<tr id=\"tr_###userid###\" userid=\"###userid###\">"
	updaterHtml += "<td class=\"\" style=\"\">###deptNm###</td>"
	updaterHtml += "<td class=\"\" style=\"\">###username###</td>"
	updaterHtml += "<td class=\"\" style=\"text-align: center; \">"
	updaterHtml += "<button class=\"btn btn-default \" onclick=\"delUpdater('###userid###');\" >삭제</button>"
	updaterHtml += "</td>"
	updaterHtml += "</tr>"

	function addUpdater(userid, deptNm, username){
		$("#bd_updater").empty();

		var tmpHtml = updaterHtml.replace("###deptNm###", deptNm)
		.replace("###username###", username)
		.replace("###userid###", userid)
		.replace("###userid###", userid)
		.replace("###userid###", userid)
		;

		$("#bd_updater").append(tmpHtml);
	}


	function delUpdater(userid){
		$("#tr_"+userid).remove();
	}


	var authorityHtml ="<tr id=\"tr_a_###userid###\" userid=\"###userid###\">"
	authorityHtml += "<td class=\"\" style=\"\">###deptNm###</td>"
	authorityHtml += "<td class=\"\" style=\"\">###username###</td>"
	authorityHtml += "<td class=\"\" style=\"text-align: center; \">"
	authorityHtml += "<button class=\"btn btn-default \" onclick=\"delAuthority('###userid###');\" >삭제</button>"
	authorityHtml += "</td>"
	authorityHtml += "</tr>"

	function addAuthority(userid, deptNm, username){

		var tmpHtml = updaterHtml.replace("###deptNm###", deptNm)
		.replace("###username###", username)
		.replace("###userid###", userid)
		.replace("###userid###", userid)
		.replace("###userid###", userid)
		;

		$("#bd_authority").append(tmpHtml);
	}


	function delAuthority(userid){
		$("#tr_a_"+userid).remove();
	}



	function actionUpdateChange(){
		var fromTdObj = $(curOwner).children();
		var toTdObj = $(curToUser).children();

		var param = new Object();
    	param.year = $("#selYear option:selected").val();
		param.touserid = toTdObj.eq(1).text();
		param.fromuserid = fromTdObj.eq(2).text()

    	_xAjax(adjustUpdaterWithToURL, param)
    	.done(function(data){

    		if(data.reCode == "SUCCESS"){
    			alert("적용되었습니다.");
    		}

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

		//adjustUpdaterWithToURL
	}



	function actionSearchUserList(){
		var param = new Object();
    	param.year = $("#selYear option:selected").val();
		param.searchText = $("#searchTextList").val();

    	_xAjax(selectUserListURL, param)
    	.done(function(data){

    		displayToUser(data.userList);

    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}


	var utHtml ="<tr style=\"padding: 4px 10px;\">"
		utHtml += "<td width=\"40%\" class=\"\" style=\"\">###deptNm###</td>";
		utHtml += "<td width=\"20%\" class=\"\" style=\"\">###userid###</td>";
		utHtml += "<td width=\"20%\" class=\"\" style=\"\">###username###</td>";
		utHtml += "</tr>";

	var curToUser = null;
	function displayToUser(userList){
		//bd_User
		$("#bd_userList").empty();

		for(var i in userList){
    		var aObj = userList[i];
    		var tmpHtml = utHtml.replace("###deptNm###",aObj.deptNm?aObj.deptNm:"")
    		.replace("###username###",aObj.username?aObj.username:"")
    		.replace("###userid###",aObj.userid?aObj.userid:"")
			;

    		$("#bd_userList").append(tmpHtml);
    	}

		$("#bd_userList tr").dblclick(function(){
			actiondblClickTouser($(this));
 		})

	}


	function actiondblClickTouser(rowObj){


		$(curToUser).removeClass("select_row");
		curToUser = $(rowObj)
     	$(curToUser).addClass("select_row");

		var tdObj = $(curToUser).children();
		$("#touserid").val(tdObj.eq(2).text());

		closeUserListPopup();
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







	//div_updater

	function openUpdaterPopup(){

		if(curMeasure){
			$("#div_updater").show();
			$(".wrap").after("<div class='overlay'></div>");

			selectUserList();
			displayOwnerPopup();

		} else {
			alert("성과지표를 선택하십시오.");
		}

    }


    function closeUpdaterPopup(){
    	$("#div_updater").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
    }


//div_user_list

	function openUserListPopup(){
     	$("#div_user_list").show();
		$(".wrap").after("<div class='overlay'></div>");

		selectUserList();
		displayOwnerPopup();
    }


    function closeUserListPopup(){
    	$("#div_user_list").hide();
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

#bd_measureList tr{
	cursor:pointer;
}
#bd_owner tr{
	cursor:pointer;
}
#bd_userList tr{
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
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;">조직구분 </label>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selSBU">
							</select>

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
						<h2>지표담당자 변경 </h2>
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
																<th rowspan="1" colspan="1" style="width:20%;">주기</th>
																</tr>
															</thead>
															<tbody id="bd_measureList">

															</tbody>
									                    </table>
									                    </div>
												</div>

									            <div class="col-md-6" style="padding-right: 18px;;">

													<div id="" style="width:100%;height:260px;overflow-y:scroll; overflow-x: hidden">
													<table id="tb_onwer" class="table table-striped table-bordered table-hover dataTable" style="width: 100%; table-layout: fixed;">
								                    	<thead>
															<tr role="row">
															<th rowspan="1" colspan="1" style="width:10%;">구분</th>
															<th rowspan="1" colspan="1" style="width:30%;">부서</th>
															<th rowspan="1" colspan="1" style="width:20%;">사번</th>
															<th rowspan="1" colspan="1" style="width:30%;">담당자</th>
															</tr>
														</thead>
														<tbody id="bd_owner">

														</tbody>
								                    </table>
								                    </div>

								                    <div class="" style="text-align: center">
								                    	<a class="btn btn-default btn-sm" onClick="javascript:openUpdaterPopup();">편집</a>
								                    	<a class="btn btn-default btn-sm" onClick="javascript:adjustOwner();">저장</a>
								                    </div>
								                    <div id="" class="col-md-12">
								                    	<label class="control-label col-md-12" for="prepend"
														style="padding-top: 6px;">&nbsp;</label>
														<label class="control-label col-md-12" for="prepend"
														style="padding-top: 6px;">1. 지표 담당자는 지표 담당자(정/부)의 권한을 수정할 수 있습니다.</label>
														<label class="control-label col-md-12" for="prepend"
														style="padding-top: 6px;">2. 신규 지표 담당자는 이전 지표 담당자에게 권한의 수정을 요청합니다.<br>
														(조직별 성과조회 화면에서 지표정의서의 전임 지표담당자 확인 후 요청)
														</label>
														<label class="control-label col-md-12" for="prepend"
														style="padding-top: 6px;">3. 일괄변경은 선택된 담당자의 모든 지표권한을 신규 담당자에게 일괄 인계합니다.</label>
													<div class="col-md-12" style="padding-right: 6px; padding-left: 1px;">
														<div class="icon-addon addon-md">
															<label class="control-label col-md-2" for="prepend" style="padding-top: 6px;">From</label>
															<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
																<div class="icon-addon addon-md">
																	<input type="text" class="form-control" id="fromuserid" />
																</div>
															</div>
															<label class="control-label col-md-2" for="prepend" style="padding-top: 6px;">To</label>
															<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;">
																<div class="icon-addon addon-md">
																	<input type="text" class="form-control" id="touserid" />
																</div>
															</div>
															<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;">
																<a class="btn btn-default btn-sm" onClick="javascript:openUserListPopup();">...</a>
								                    			<a class="btn btn-default btn-sm" onClick="javascript:actionUpdateChange();">일괄변경</a>
															</div>
														</div>
													</div>
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




















<div class="" id="div_updater" name="div_updater" style="display: none;">
<div class="popup">

<form class="form-horizontal" id="form_meausre_updater_detail" name="form_meausre_updater_detail" style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>지표담당자</h2>
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

				<div class="col-md-6" style="padding-right: 1px;;">
					<div class="col-md-12" >
					<label class="control-label col-md-2" for="prepend" style="padding-top: 8px;padding-right: 8px;">담당자</label>
					<div class="col-md-6" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="searchText" />
						</div>
					</div>
					<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<a onClick="javascript:actionSearchUser();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
						</div>
					</div>
					</div>
					<div class="col-md-12" >
	                <div class="icon-addon addon-md" >
	                    <div id="" style="width:100%;height:460px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_bsc" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
		                    	<td width="40%" style="">
		                    		부서명
		                    	</td>
		                    	<td width="20%" style="">
		                    		사용자
		                    	</td>
		                    	<td width="20%" style="">
		                    		선택(정)
		                    	</td>
		                    	<td width="20%" style="">
		                    		선택(부)
		                    	</td>
		                    	</tr>
		                    </thead>
		                    <tbody id="bd_User">
		                    </tbody>

	                    </table>
	                    </div>
	                </div>
	                </div>
				</div>
				<div class="form-group">
	            <fieldset>
	            <label class="control-label col-md-2" for="prepend" style="">담당자(정) </label>
	            <div class="col-md-8" style="padding-right: 1px;;">
	                <div class="icon-addon addon-md" >
						<div id="" style="width:100%;height:100px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_updater" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
	                    	<tr role="row">
	                    	<td width="50%" class="" style="">
	                    		부서명
	                    	</td>
	                    	<td width="30%" class="" style="">
	                    		담당자
	                    	</td>
	                    	<td width="20%" class="" style="">
	                    		삭제
	                    	</td>
	                    	</tr>
	                    	</thead>
	                    	<tbody id="bd_updater">
		                    </tbody>
	                    </table>
	                    </div>
	                </div>
	            </div>
	            </fieldset>

	            <fieldset>
				<label class="control-label col-md-2" for="prepend" style="">담당자(부) </label>
	            <div class="col-md-8" style="padding-right: 1px;;">
	                <div class="icon-addon addon-md" >
					<div id="" style="width:100%;height:360px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_authority" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
	                    	<tr role="row">
	                    	<td width="50%" class="" style="">
	                    		부서명
	                    	</td>
	                    	<td width="30%" class="" style="">
	                    		담당자
	                    	</td>
	                    	<td width="20%" class="" style="">
	                    		삭제
	                    	</td>
	                    	</tr>
	                    	</thead>
	                    	<tbody id="bd_authority">
	                    	</tbody>
	                    </table>
	                    </div>
	                </div>
	            </div>
				</fieldset>

				</div>
				</div>
			</fieldset>


			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;">
						<a onClick="closeUpdaterPopup()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
						<a onClick="refreshOwner();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">적용</a>
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



<div class="" id="div_user_list" name="div_user_list" style="display: none;">
<div class="popup" style="left:100px;width:50%;">

<form class="form-horizontal" id="form_meausre_updater_detail" name="form_meausre_updater_detail" style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>지표담당자</h2>
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

				<div class="col-md-12" style="padding-right: 1px;;">
					<div class="col-md-12" >
					<label class="control-label col-md-2" for="prepend" style="padding-top: 8px;padding-right: 8px;">담당자</label>
					<div class="col-md-6" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="searchTextList" />
						</div>
					</div>
					<div class="col-md-4" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<a onClick="javascript:actionSearchUserList();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
						</div>
					</div>
					</div>
					<div class="col-md-12" >
	                <div class="icon-addon addon-md" >
	                    <div id="" style="width:100%;height:460px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_userList" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
		                    	<td width="40%" style="">
		                    		부서명
		                    	</td>
		                    	<td width="20%" style="">
		                    		아이디
		                    	</td>
		                    	<td width="20%" style="">
		                    		사용자
		                    	</td>
		                    	</tr>
		                    </thead>
		                    <tbody id="bd_userList">
		                    </tbody>

	                    </table>
	                    </div>
	                </div>
	                </div>
				</div>

				</div>
			</fieldset>


			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;">
						<a onClick="closeUserListPopup()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
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





