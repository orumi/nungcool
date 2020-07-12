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
var selectInitURL = "<c:url value='/admin/config/selectInit.json'/>";

var adjustConfigURL = "<c:url value='/admin/config/adjustConfig.json'/>";



</script>


<script type="text/javascript">
	$(document) .ready( function() {
		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);
		actionInit();
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
    	param.sysid = "BSC";

    	_xAjax(selectInitURL, param)
    	.done(function(data){
   			displayInit(data);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

    }

    function displayInit(data) {

    	if(data.selectConfig){
    		$("#selYear").val(data.selectConfig[0].fixedyr);
    		$("#selMonth").val(data.selectConfig[0].fixedmt);

    		if("Y" == data.selectConfig[0].curymyn){
    			$("#curym").prop("checked", "checked");
    		} else {
    			$("#curym").prop("checked", "");
    		}
    		actionCurYmCheck();
    	} else {

    	}
    }


    function actionCurYmCheck(){
    	if($("#curym").prop("checked")){
    		$("#selYear").prop("disabled","disabled");
    		$("#selMonth").prop("disabled","disabled");
    	} else {
    		$("#selYear").prop("disabled","");
    		$("#selMonth").prop("disabled","");
    	}
    }


    function adjustConfig(){
    	var param = new Object();
    	param.sysid = "BSC";
    	param.fixedym = $("#selYear").val()+$("#selMonth").val();
    	if($("#curym").prop("checked")){
    		param.curymyn = "Y";
    	} else {
    		param.curymyn = "N";
    	}

    	_xAjax(adjustConfigURL, param)
    	.done(function(data){
    		alert("저장되었습니다.");
   			displayInit(data);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});

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
	<div class="wrap" id="" >
			<fieldset style="border: 1px solid #c1c1c1;padding: 12px;margin: 13px;">
				<div class="form-group smart-form">
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;">연월고정 </label>
					<div class="col-md-4" style="padding-right: 6px; padding-left: 1px; width:260px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selYear" style="width:120px;">
							</select>
							<select class="form-control" id="selMonth"  style="width:120px;margin-left:4px;">
								<option value="03">1/4분기</option>
								<option value="06">2/4분기</option>
								<option value="09">3/4분기</option>
								<option value="12">4/4분기</option>
							</select>


						</div>
					</div>
					<div class="col-md-2" style="padding-right: 6px; padding-left: 1px;padding-top: 5px;">
					<label class="checkbox"><input type="checkbox" name="curym" id="curym" onClick="javascript:actionCurYmCheck();"><i></i> 현재년월 적용</label>
					</div>
					<div class="col-md-2">
					<a onClick="adjustConfig();"  class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;">저장</a>

					</div>
				</div>
				<div class="col-md-12">
					<label class="control-label col-md-12" for="prepend"
						style="padding-top: 6px;">성과관리 등록 및 조회 화면에 보여지는 연도와 월을 설정합니다. </label>
				</div>
			</fieldset>
	</div>

</body>
</html>





