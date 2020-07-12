<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

	<link rel="stylesheet" href="../../resource/jqwidgets/styles/jqx.base.css" type="text/css" />
	<link rel="stylesheet" href="../../resource/jqwidgets/styles/jqx.light.css" type="text/css" />

	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/> ">


	<!-- 도움되는 콘솔 경고를 포함한 개발 버전 -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script> -->
	<!-- 상용버전, 속도와 용량이 최적화됨. -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/vue"></script> -->


 	<!-- jqxTree  -->
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcore.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdata.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxtree.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdragdrop.js'/> "></script>
	<script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcheckbox.js'/> "></script>

<script type="text/javascript">

var selectTreeRootUrl = "<c:url value='/scorecard/perform/selectTargetTreeRoot.json'/>";

var selectTreeListUrl = "<c:url value='/scorecard/perform/selectTargetTreeList.json'/>";

var selectTargetDetailUrl = "<c:url value='/scorecard/perform/selectTargetDetail.json'/>";

</script>


<script type="text/javascript">

	$(document).ready(function () {
		$('form').bind('submit', function () {return false})
		var date = new Date();
		var year = date.getFullYear();
		funcSetDate(year);

		function funcSetDate(curYear) {
	        for (i=0,j=curYear-12; i<=13;i++,j++) {
	        	$("#selYear").append("<option value='"+j+"'>"+j+"</option>");
	        }
	        $("#selYear").val(year-1);

	        selectInit();
	    }


		$("#selYear").change(function(){
			refreshTree();
			selectInit();
		});


	    // Create jqxTree

	    // var source = jQuery.parseJSON(data);;
	    /* $.ajax({
	        async: false,
	        url: "ajaxroot.htm",
	        success: function (data, status, xhr) {
	            source = jQuery.parseJSON(data);
	        }
	    }); */

	    /* tree.jqxTree({ source: source,  height: 300, width: 500 }); */

	});

	function refreshTree() {
		$('#jqxTree').jqxTree('destroy');
	}

	function selectInit(){

		$("#txtEmpNm").val("");
		$("#txtAccountNm").val("");
		$("#txtSuccessKey1").val("");
		$("#txtSuccessKey2").val("");
		$("#txtSuccessKey3").val("");
		$("#txtObjectNm").val("");
		$("#txtObjectNm2").val("");
		$("#txtPlan").val("");
		$("#txtResult").val("");



    	var param = new Object();
    	param.year = $("#selYear option:selected").val();

    	_xAjax(selectTreeRootUrl, param)
    	.done(function(data){
    		initTree(data.root);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}


	function initTree(root){

		var tmp = "<div id='jqxTree' style=''></div>";
		$("#aside").append(tmp);


		var tree = $('#jqxTree');


		tree.jqxTree({ source: root,  height: 300, width: 500 });

		tree.on('expand', function (event) {
	        var label = tree.jqxTree('getItem', event.args.element).label;
	        var $element = $(event.args.element);
	        var loader = false;
	        var loaderItem = null;
	        var children = $element.find('ul:first').children();
	        $.each(children, function () {
	            var item = tree.jqxTree('getItem', this);
	            // item <= 첫번째 자식 임시로 표현된 ....
	            if (item && item.label == 'Loading...') {
	                loaderItem = item;   // 자식 아이템
	                loader = true;
	                return false
	            };
	        });

	        if (loader) {
	        	console.log("item value : "+loaderItem.value);
	        	var itemVal = loaderItem.value.split("|");
	        	console.log("length : "+itemVal.length);

	        	var param = new Object();
	        	param.year = $("#selYear").val();
	        	param.inSabun = itemVal[0];
	        	param.inSeq = itemVal[1];
	        	param.inRev = itemVal[2];
	        	param.aNo   = itemVal[3];
	        	param.oNo   = itemVal[4];

	        	//var items = jQuery.parseJSON(data2);
                //tree.jqxTree('addTo', items, $element[0]);
                //tree.jqxTree('removeItem', loaderItem.element);
	            $.ajax({
	                url     : selectTreeListUrl,
	                type    : 'POST',
	    			data    : param,
	    			dataType: 'json',
	                success: function (data, status, xhr) {
	                    /* var items = jQuery.parseJSON(data); */
	                    tree.jqxTree('addTo', data.targetList, $element[0]);
	                    tree.jqxTree('removeItem', loaderItem.element);
	                }
	            });
	        }
	    });

		tree.on('select', function (event) {
			var args = event.args;
			var item = $('#jqxTree').jqxTree('getItem', args.element);

			console.log("item value : "+item.value);

			var itemVal = item.value.split("|");

        	var param = new Object();
        	param.year = $("#selYear").val();
        	param.inSabun = itemVal[0];
        	param.inSeq = itemVal[1];
        	param.inRev = itemVal[2];
        	param.aNo   = itemVal[3];
        	param.oNo   = itemVal[4];


        	var parentElement = event.args.element.parentElement.parentElement;
            var parent = $('#jqxTree').jqxTree('getItem', parentElement);
            if (parent) {
                console.log("parent label"+parent.label);
                var parentVal = parent.value.split("|");
                param.pInSabun = parentVal[0];
                $("#txtObjectNm").val(parent.label);


            } else {
            	param.pInSabun = null;
            	$("#txtObjectNm").val("");
            };



			selectTargetDetail(param);


	    });

	}


	function selectTargetDetail(param){

		$("#txtEmpNm").val("");
		$("#txtAccountNm").val("");
		$("#txtSuccessKey1").val("");
		$("#txtSuccessKey2").val("");
		$("#txtSuccessKey3").val("");
		$("#txtObjectNm2").val("");
		$("#txtPlan").val("");
		$("#txtResult").val("");

    	_xAjax(selectTargetDetailUrl, param)
    	.done(function(data){
    		dispalyDetail(data);
    	}).fail(function(error){
    		console.log("actionInit error : "+error);
    	});
	}


	function dispalyDetail(data){
		var obj = data.targetDetail[0];

		$("#txtEmpNm").val("");
		$("#txtAccountNm").val("");
		$("#txtSuccessKey1").val("");
		$("#txtSuccessKey2").val("");
		$("#txtSuccessKey3").val("");
		/* $("#txtObjectNm").val(""); */
		$("#txtObjectNm2").val("");
		$("#txtPlan").val("");
		$("#txtResult").val("");

		$("#txtEmpNm").val((obj.empNm?obj.empNm:"") +"("+(obj.empNo?obj.empNo:"")+")");
		$("#txtAccountNm").val((obj.accountability?obj.accountability:"") +"("+(obj.AWeight?obj.AWeight:"")+")");
		$("#txtSuccessKey1").val((obj.successKey?obj.successKey:""));
		$("#txtSuccessKey2").val((obj.successKey2?obj.successKey2:""));
		$("#txtSuccessKey3").val((obj.successKey3?obj.successKey3:""));

		$("#txtObjectNm2").val((obj.object?obj.object:""));
		$("#txtPlan").val((obj.plan?obj.plan:""));
		$("#txtResult").val((obj.result?obj.result:""));

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
	width: 500px;
	z-index: 901;
	padding-top: 50px;
	border: 0px solid #c1c1c1;
}

#section {
	position: absolute;
	top: 50px;
	left: 500px;
	right: 0px;
	/* bottom: 140px; */
	bottom: 0px;
	overflow: scroll;
	border: 1px solid #c1c1c1;
}

#footer {
	position: absolute;
	display: block;
	right: 0px;
	left: 250px;
	bottom: 0px;
	/* height: 140px; */
	height:0px;
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

.jqx-tree {
	float: left;
    width: 500px;
    display: block;
    position: absolute;
    left: 0;
    top: 50px;
    bottom: 20px;
    height:auto !important;
    overflow-x: auto;
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
					<div class="col-md-1"
						style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selYear">
							</select>
						</div>
					</div>

				</div>
			</fieldset>
		</header>

		<aside id="aside">
			<!-- <div id='jqxTree' style=''></div> -->
		</aside>

		<section id="section">
			<form action class="smart-form">
				<fieldset style="padding-top: 4px;">
					<section>
						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									1.성명</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control" name="txtEmpNm" id="txtEmpNm" />
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									2.성과책임</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<textarea rows="3" id="txtAccountNm" name="txtAccountNm" class="form-control" ></textarea>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									3.핵심성공요인</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control" name="txtSuccessKey1" id="txtSuccessKey1" />
									</div>
								</div>
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									&nbsp;</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control" name="txtSuccessKey2" id="txtSuccessKey2" />
									</div>
								</div>
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									&nbsp;</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<input type="text" class="form-control" name="txtSuccessKey3" id="txtSuccessKey3" />
									</div>
								</div>

							</div>
						</div>


						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									4.성과목표<br>(상위자)</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<textarea rows="3" id="txtObjectNm" name="txtObjectNm" class="form-control" ></textarea>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									(본인)</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<textarea rows="3" id="txtObjectNm2" name="txtObjectNm2" class="form-control" ></textarea>
									</div>
								</div>
							</div>
						</div>


						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									5.실행계획</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<textarea rows="8" id="txtPlan" name="txtPlan" class="form-control" ></textarea>
									</div>
								</div>
							</div>
						</div>

						<div class="row" style="padding: 3px 0 4px 0;">
							<div class="form-group">
								<label class="control-label col-md-2" for="prepend" style="text-align: left; padding: 6px 11px;">
									6.추진실적</label>
								<div class="col-md-9" style="padding-right: 1px;">
									<div class="icon-addon addon-md">
										<textarea rows="8" id="txtResult" name="txtResult" class="form-control" ></textarea>
									</div>
								</div>
							</div>
						</div>

					</section>
				</fieldset>

			</form>
		</section>

		<footer id="footer">

		</footer>


	</div>



<!-- popup  -->
<div class="" id="div_list" name="div_list" style="display: none;">
<div class="popup" style="width:1000px;left:50px;top:60px;">
<form class="form-horizontal"  style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>성과책임</h2>
		</header>

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
								<th rowspan="1" colspan="1" style="width:10%;">번호</th>
								<th rowspan="1" colspan="1" style="width:40%;">성과책임</th>
								<th rowspan="1" colspan="1" style="width:10%;">가중치</th>
								<th rowspan="1" colspan="1" style="width:40%;">핵심성공요인</th>
								</tr>
							</thead>
							<tbody id="bd_list">

							</tbody>
	                    </table>
	                    </div>
				</div>
			</fieldset>


			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
						<a onClick="javascript:closeListPopup();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
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


<!-- popup  -->
<div class="" id="div_detail" name="div_detail" style="display: none;">
<div class="popup" style="width:1100px;left:50px;top:60px;">
<form class="form-horizontal"  style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>성과책임</h2>
		</header>

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">

			<fieldset>
				<div class="col-md-12" style="padding-right: 1px;;">
	                    <div id="" style="width:100%;height:560px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_detail" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:5%;">번호</th>
								<th rowspan="1" colspan="1" style="width:20%;">성과목표</th>
								<th rowspan="1" colspan="1" style="width:5%;">가중치</th>
								<th rowspan="1" colspan="1" style="width:20%;">달성수준</th>
								<th rowspan="1" colspan="1" style="width:20%;">실행계획</th>
								<th rowspan="1" colspan="1" style="width:20%;">실행결과</th>
								</tr>
							</thead>
							<tbody id="bd_detail">

							</tbody>
	                    </table>
	                    </div>
				</div>
			</fieldset>


			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
						<a onClick="javascript:closeDetailPopup();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
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



<!-- <script>
	var app = new Vue({
	  el: '#app',
	  data: {
	    message: '안녕하세요 Vue!'
	  }
	})
</script> -->
</body>
</html>





