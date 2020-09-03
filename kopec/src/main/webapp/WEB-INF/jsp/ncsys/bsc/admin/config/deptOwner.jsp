<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />


	<!-- 도움되는 콘솔 경고를 포함한 개발 버전 -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script> -->
	<!-- 상용버전, 속도와 용량이 최적화됨. -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/vue"></script> -->

	<!-- local -->
	<script src="<c:url value='/js/vue/vue.js'/>"></script>


	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">

	<script src="<c:url value='/js/ncsys/bsc/admin/deptOwnerModule.js?version=1.1.0'/>"></script>




<script type="text/javascript">

var selectSBUURL = "<c:url value='/admin/config/selectHierachySBU.json'/>";
var selectUserListURL = "<c:url value='/admin/config/selectUserList.json'/>";

var selectOwnerBySbuIdURL = "<c:url value='/admin/config/selectOwnerBySbuId.json'/>";



var adjustOwnersURL = "<c:url value='/admin/config/adjustOwners.json'/>";




</script>


<script type="text/javascript">
	$(document) .ready( function() {



	});
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
	<div class="wrap" id="vueApp" >
		<header id="header">
			<fieldset style="width: 100%;">
				<div class="form-group">
					<label class="control-label col-md-1" for="prepend"
						style="padding-top: 6px;">기준년도 </label>
					<div class="col-md-1" style="padding-right: 6px; padding-left: 1px;">
						<div class="icon-addon addon-md">
							<select class="form-control" id="selYear" v-model="selYear" v-on:change="selectSBU();">
								<option v-for="item in years">{{item}}</option>
							</select>
						</div>
					</div>
					<div class="col-md-1">
					<a v-on:click="selectSBU();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">조회</a>
					</div>
					<div class="col-md-4">
					<a v-on:click="actionPerformed();"  class="btn btn-primary pull-left" style="padding: 6px 18px; margin: 0px 2px;">저장</a>
					</div>
				</div>
			</fieldset>
		</header>


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
						<h2>조직 배정 </h2>
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
				<div class="col-md-4" style="padding-right: 1px;;">
	                <div class="">사업단위</div>
	                    <div id="" style="width:100%;height:560px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_bsc" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:40%;">조직</th>
								<th rowspan="1" colspan="1" style="width:40%;">사업단위</th>
								<th rowspan="1" colspan="1" style="width:20%;">배정</th>
								</tr>
							</thead>
							<tbody id="bd_bsc">
								<tr role="row" v-for="sbu in SBUs" :key="sbu.bcid" :class="{select_row : curSBU == sbu }" v-on:click="clickSBU(sbu)" >
								    <td style="">{{sbu.cname}}</td>
								    <td style="">{{sbu.sname}}</td>
								    <td style="text-align: right;">{{sbu.cnt}}</td>
							    </tr>
							</tbody>
	                    </table>
	                    </div>
				</div>

	            <div class="col-md-4" style="padding-right: 1px;;">
	                <div class="">배정된 담당자</div>
						<div id="" style="width:100%;height:560px;overflow-y:scroll; overflow-x: hidden">
						<table id="tb_deptMapping" class="table table-striped table-bordered table-hover dataTable" style="width: 100%; table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:50%;">사업단위</th>
								<th rowspan="1" colspan="1" style="width:50%;">담당자</th>
								</tr>
							</thead>
							<tbody id="bd_deptMapping">
								<tr role="row" v-for="owner in sbuOwners" :class="{select_row : curOwner == owner }" v-on:click="clickOwner(owner)" >
								    <td style="">{{owner.sname}}</td>
								    <td style="">{{owner.username}}</td>
							    </tr>
							</tbody>
	                    </table>
	                    </div>
	            </div>
	            <div class="col-md-1" style="padding-right: 1px;width: 52px; text-align: center">
	            <br><br><br><br><br>
					<a class="btn btn-default btn-sm" v-on:click="delOwner();">></a><br><br>
					<a class="btn btn-default btn-sm" v-on:click="addOwner();"><</a><br><br>
					<a class="btn btn-default btn-sm" v-on:click="clearOwner();">>></a><br><br>
	            </div>

	            <div class="col-md-3" style="padding-right: 1px;width: 28%;">
	                <div class="">담당자 목록</div>
						<div id="" style="width:100%;height:560px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_dept" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:30%;">코드</th>
								<th rowspan="1" colspan="1" style="width:30%;">상위부서</th>
								<th rowspan="1" colspan="1" style="width:40%;">부서명</th>
								</tr>
							</thead>
							<tbody id="bd_dept">
								<tr role="row" v-for="user in users" :key="user.userid" :class="{select_row : curUser == user }" v-on:click="clickUserList(user)" >
								    <td style="">{{user.userid}}</td>
								    <td style="">{{user.username}}</td>
								    <td style="">{{user.deptNm}}</td>
							    </tr>
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

</div>
</body>
</html>





