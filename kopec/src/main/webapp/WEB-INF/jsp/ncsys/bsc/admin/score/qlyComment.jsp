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


var selectCommentURL = "<c:url value='/admin/score/selectComment.json'/>";
var selectCommentDetailURL = "<c:url value='/admin/score/selectCommentDetail.json'/>";


</script>


<script type="text/javascript">
	$(document) .ready( function() {

		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		$("#selYear").change(function(){selectBSC(); reset();});
		$("#selSbu").change(function(){changeSbu(); reset();});
		$("#selBsc").change(function(){actionPerformed(); });

		selectBSC();

	});

    function funcSetDate(curYear) {
        for (i=0,j=curYear-16; i<=17;i++,j++) {
        	 $("#selYear").append("<option value='"+j+"'>"+j+"</option>");
        }
        $("#selYear").val("${config[0].showyear}");
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



	function actionPerformed(){

    	var param = new Object();
    	param.year = $("#selYear option:selected").val();
    	param.sid = $("#selSbu option:selected").val();
    	var bid = $("#selBsc option:selected").val();
    	if(bid != 0){
    		param.bid = bid;
    	}

    	_xAjax(selectCommentURL, param)
    	.done(function(data){
   			displayList(data.qlyComment);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}



    var lHtml = "<tr role=\"row\" mcid=\"###mcid###\">";
    lHtml += "<td style=\"\">###sname###</td>";
    lHtml += "<td style=\"text-align:left\">###bname###</td>";
    lHtml += "<td style=\"text-align:center\">###pname###</td>";
    lHtml += "<td style=\"text-align:center\">###mname###</td>";
    lHtml += "<td style=\"text-align:right\">###mweight###</td>";
    lHtml += "<td style=\"text-align:right\">###frequency###</td>";
    lHtml += "<td style=\"text-align:right\">###ym###</td>";
    lHtml += "<td style=\"text-align:right\">###evalcomment###</td>";
    lHtml += "</tr>";

    var curList = null;
    function actionClickList(rowObj){
    	$(curList).removeClass("select_row");
    	curList = $(rowObj)
    	$(curList).addClass("select_row");
    }

	function displayList(qlyComment){
		curList = null;
		$("#bd_list").empty();

		for(var i in qlyComment){
    		var obj = qlyComment[i];
    		var tmpHtml = lHtml.replace("###mcid###",obj.mcid)
    		.replace("###sname###",obj.sname)
    		.replace("###bname###",obj.bname)
			.replace("###pname###",obj.pname?obj.pname:"")
			.replace("###mname###",obj.mname?obj.mname:"")
			.replace("###mweight###",obj.mweight?obj.mweight:"")
			.replace("###frequency###",obj.frequency?obj.frequency:"")
			.replace("###ym###",obj.ym?obj.ym:"")
			.replace("###evalcomment###",obj.evalcomment?obj.evalcomment:"")
    		;

    		$("#bd_list").append(tmpHtml);
    	}

		$("#bd_list tr").click(function(){
			actionClickList($(this));
		})

	}



    function openDetailPopup(){
     	$("#div_property").show();
		$(".wrap").after("<div class='overlay'></div>");
    }


    function closeDetailPopup(){
    	$("#div_property").hide();
    	$(".wrap").after("<div class='overlay'></div>");

    	$(".overlay").remove();
    }




    function selectDetail(){
		if(curList == null){
			alert("성과지표를 선택하십시오.");
			return;
		}

		reset();

		var rdObj = $(curList).children();
    	var mcid = $(curList).attr("mcid");


    	openDetailPopup();

		var param = new Object();
      	param.year = $("#selYear option:selected").val();
     	param.mcid = mcid;

     	_xAjax(selectCommentDetailURL, param)
     	.done(function(data){
			displayDetail(data.qlyCommentDtl);
     	}).fail(function(error){
     		console.log("actionEditMeasure error : "+error);
     	});
    }

    var dHtml = "<tr role=\"row\" >";
    dHtml += "<td style=\"\">###evalplan###</td>";
    dHtml += "<td style=\"\">###evaldetail###</td>";
    dHtml += "<td style=\"\">###evalestimate###</td>";
    dHtml += "<td style=\"\">###evalcomment###</td>";
    dHtml += "</tr>";

	function displayDetail(qlyCommentDtl){

		var dtl = qlyCommentDtl[0]
		$("#txtMname").val(dtl.mname);
		$("#txtMean").val(dtl.mean);
		$("#txtBname").val(dtl.bname);
		$("#txtEvalGrade").val(dtl.evalgrade);
		$("#txtYm").val(dtl.ym);
		$("#txtEvalrNm").val(dtl.evalrnm);

		$("#bd_detail").empty();

   		var tmpHtml = dHtml
   		.replace("###evalplan###",dtl.evalplan?dtl.evalplan:"")
   		.replace("###evaldetail###",dtl.evaldetail?dtl.evaldetail:"")
   		.replace("###evalestimate###",dtl.evalestimate?dtl.evalestimate:"")
   		.replace("###evalcomment###",dtl.evalcomment?dtl.evalcomment:"")
   		;

   		$("#bd_detail").append(tmpHtml);

	}



	function reset(){
		$("#txtMname").val("");
		$("#txtMean").val("");
		$("#txtBname").val("");
		$("#txtEvalGrade").val("");
		$("#txtYm").val("");
		$("#txtEvalrNm").val("");

		$("#bd_detail").empty();
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

#tb_list tr{
	cursor:pointer;
}
#bd_rank tr{
	cursor:pointer;
}
#bd_dept tr{
	/* cursor:pointer; */
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

					<div class="col-md-2">
					<a onClick="javascript:actionPerformed();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
					<a onClick="javascript:actionDownloadCSV('tb_list');"  class="btn btn-default pull-left" style="padding: 6px 18px; margin: 0px 2px;">엑셀</a>
					</div>
					<div class="col-md-3">
					<a onClick="javascript:selectDetail();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">평가의견보기</a>
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
						<h2>지표별 조직순위 </h2>
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
						<table id="tb_list" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">구분</th>
								<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">조직명</th>
								<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">관점</th>
								<th rowspan="1" colspan="1" style="width:10%;vertical-align: middle;">성과지표</th>
								<th rowspan="1" colspan="1" style="width:5%;vertical-align: middle;">가중치</th>
								<th rowspan="1" colspan="1" style="width:5%;">주기</th>
								<th rowspan="1" colspan="1" style="width:5%;">년월</th>
								<th rowspan="1" colspan="1" style="width:20%;">평가의견</th>

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
			<h2>비계량 지표 평가자 평가의견</h2>
		</header>

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">
			<input type="hidden" name="bid" id="bid" />

			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">성과지표</label>
					<div class="col-md-8" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="txtMname"/>
						</div>
					</div>
					<div class="col-md-2" style="padding-right: 0px; padding-left: 3px;margin-bottom: 4px;">
					<a onClick="javascript:closeDetailPopup();"  class="btn btn-default pull-right" style="padding: 6px 12px; margin: 0px 2px;">닫기</a>
					</div>
				</div>
			</fieldset>

			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">지표정의</label>
					<div class="col-md-10" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="txtMean"/>
						</div>
					</div>
				</div>
			</fieldset>
			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">평가부서</label>
					<div class="col-md-5" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="txtBname"/>
						</div>
					</div>
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">평가등급</label>
					<div class="col-md-3" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="txtEvalGrade"/>
						</div>
					</div>
				</div>
			</fieldset>
			<fieldset style="width: 100%;">
				<div class="form-group" style="padding-right:18px;">
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">평가시기</label>
					<div class="col-md-5" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="txtYm"/>
						</div>
					</div>
					<label class="control-label col-md-2" for="prepend"
						style="padding-top: 6px;padding-right: 12px;">평가자</label>
					<div class="col-md-3" style="padding-right: 6px; padding-left: 1px;margin-bottom: 4px;">
						<div class="icon-addon addon-md">
							<input type="text" class="form-control" id="txtEvalrNm"/>
						</div>
					</div>
				</div>
			</fieldset>


			<fieldset>

				<div class="form-group">
					<div class="col-md-12" style="padding-right: 24px;padding-left:24px;">
		                <div class="icon-addon addon-md" >
		                    <div id="res" style="width:100%;height:360px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
							<table id="tb_detail" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
		                    	<thead>
		                    	<tr>
		                    	<th width="25%" class="nc_th" style="">
		                    		계획
		                    	</th>
		                    	<th width="25%" class="nc_th" style="">
		                    		실적
		                    	</th>
		                    	<th width="25%" class="nc_th" style="">
		                    		내부분석의견
		                    	</th>
		                    	<th width="25%" class="nc_th" style="">
		                    		평가의견
		                    	</th>
		                    	</tr>
		                    	</thead>

		                    	<tbody id="bd_detail">

								</tbody>
		                    </table>
		                    </div>
		                </div>
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





