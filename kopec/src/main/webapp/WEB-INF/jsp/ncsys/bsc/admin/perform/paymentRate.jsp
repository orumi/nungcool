<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

	<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css'/>">

	<script src="<c:url value='/js/ncsys/bsc/admin/paymentRate.js?version=1.0.0'/>"></script>
	<script src="<c:url value='/js/ncsys/bsc/admin/paymentSet.js?version=1.0.0'/>"></script>

 	<!-- jqxTree  -->

<script type="text/javascript">
var selectInit = "<c:url value='/admin/perform/selectInit.json'/>";
var psnBaseLine = "<c:url value='/admin/perform/psnBaseLine.json'/>";
var deletePsnBaseLine = "<c:url value='/admin/perform/deletePsnBaseLine.json'/>";

var psnJikgub = "<c:url value='/admin/perform/psnJikgub.json'/>";

var psnSbuMapping = "<c:url value='/admin/perform/psnSubMapping.json'/>";


var psnExceptInit = "<c:url value='/admin/perform/psnExceptInit.json'/>";
var psnExceptEmpURL = "<c:url value='/admin/perform/psnExceptEmp.json'/>";
var adjustPsnExceptEmpURL = "<c:url value='/admin/perform/adjustPsnExceptEmp.json'/>";


var psnLaborInitURL = "<c:url value='/admin/perform/psnLaborInit.json'/>";
var adjustPsnLaborEmpURL = "<c:url value='/admin/perform/adjustPsnLaborEmp.json'/>";


var psnBscScoreURL = "<c:url value='/admin/perform/psnBscScore.json'/>";
var psnBizMhURL = "<c:url value='/admin/perform/psnBizMh.json'/>";
var psnScoreURL = "<c:url value='/admin/perform/psnScore.json'/>";


var psnGradeURL = "<c:url value='/admin/perform/selectPsnGrade.json'/>";
var adjustPsnGradeURL = "<c:url value='/admin/perform/adjustPsnGrade.json'/>";



var psnBscGradeURL = "<c:url value='/admin/perform/selectPsnBscGrade.json'/>";
var adjustPsnBscGradeURL = "<c:url value='/admin/perform/adjustPsnBscGrade.json'/>";



var psnBizMhURL = "<c:url value='/admin/perform/selectPsnBizMh.json'/>";

var psnScoreURL = "<c:url value='/admin/perform/selectPsnScore.json'/>";
var psnScoreListURL = "<c:url value='/admin/perform/selectPsnScoreList.json'/>";




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

#bd_bscMapping tr{
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
	<div class="wrap" id="paymentRateApp" >
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



					<!-- <div class="col-md-1" style="padding-left: 12px;">
						<a id="btnAttr" type="submit" class="btn btn-primary"
							style="width: 68px;"> 조회 </a>
					</div>
					<div class="col-md-1" style="padding-left: 0px;">
						<a type="submit" class="btn btn-primary" style="width: 60px;"> 엑셀 </a>
					</div> -->
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
									<a data-toggle="tab" href="#s1"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">기준설정 및 지급률 계산</span></a>
								</li>
								<li>
									<a data-toggle="tab" href="#s2"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">5등급 세부 배분표</span></a>
								</li>
								<li>
									<a data-toggle="tab" href="#s3"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">부서별 성과 지급률</span></a>
								</li>
								<li>
									<a data-toggle="tab" href="#s4"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">개인별 사업부서 M/H</span></a>
								</li>
								<li>
									<a data-toggle="tab" href="#s5"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">기준 성과지급률 상세내역</span></a>
								</li>
								<li>
									<a data-toggle="tab" href="#s6"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">기준 성과지급률</span></a>
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
											<div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
											<table class="table">
												<tr>
													<td>
														<table style="width:100%;">
														<tr><td>
														1. 평가년도 지급률 설정
														</td></tr>
														</table>
													</td>
												</tr>
												<tr>
													<td style="padding:0px;padding-top:4px;">
														<table style="width:100%;">
														<tr>
															<td style="width:70%;">
																<table width="100%" style="border:1px solid #c1c1c1;" >
																<tr>
																	<td style="width:120px;padding:12px;">회사 지급률(%) </td>
																	<td style="width:100px;">
																		<input type="text" class="form-control nc_inp" id="rCo" style="text-align: right"/>
																	</td>
																	<td></td>
																</tr>
																</table>
																<br>
																<table width="100%" style="border:1px solid #c1c1c1;" >
											                    	<tr>
											                    	<td colspan="5" style="padding:4px;">1단계 지급률</td></tr>
											                    	<tr>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		S
											                    	</td>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		A
											                    	</td>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		B
											                    	</td>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		C
											                    	</td>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		D
											                    	</td>
											                    	</tr>
											                    	<tr >
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r1S" style="text-align: right"/>
											                    	</td>
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r1A" style="text-align: right"/>
											                    	</td>
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r1B" style="text-align: right"/>
											                    	</td>
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r1C" style="text-align: right"/>
											                    	</td>
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r1D" style="text-align: right"/>
											                    	</td>
											                    	</tr>
											                    </table>
																<br>
																<table width="100%" style="border:1px solid #c1c1c1;" border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="table-layout:fixed">
											                    	<tr><td colspan="5" style="padding:4px;">2단계 지급률</td></tr>
											                    	<tr>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		S
											                    	</td>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		A
											                    	</td>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		B
											                    	</td>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		C
											                    	</td>
											                    	<td width="10%" class="nc_th nc_td_grade" style="">
											                    		D
											                    	</td>
											                    	</tr>
											                    	<tr >
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r2S" style="text-align: right"/>
											                    	</td>
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r2A" style="text-align: right"/>
											                    	</td>
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r2B" style="text-align: right"/>
											                    	</td>
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r2C" style="text-align: right"/>
											                    	</td>
											                    	<td width="10%" class="" style="">
											                    		<input type="text" class="form-control nc_inp"  id="r2D" style="text-align: right"/>
											                    	</td>
											                    	</tr>
											                    </table>
											                    <br>
											                    <table width="100%" style="border:1px solid #c1c1c1;">
																<tr>
																	<td style="width:120px;padding:12px;">평가부서 M/H</td>
																	<td style="width:100px;"><input type="text" class="form-control nc_inp" id="exceptBscmh" style="text-align: right" />
																	</td>
																	<td> 미만 제외
																	</td>
																	<td>
																	</td>
																</tr>
																<tr>
																	<td style="width:120px;padding:12px;">M/H</td>
																	<td style="width:100px;"><input type="text" class="form-control nc_inp"  id="exceptMh" style="text-align: right" />
																	</td>
																	<td> 미만 제외
																	</td>
																	<td>
																	<a class="btn btn-default btn-sm" onClick="javascript:actionPsnBaseLine();">저장</a>
																	<a class="btn btn-default btn-sm" onClick="javascript:actionPsnBaseLineDelete();">삭제</a>
																	</td>
																</tr>
																</table>
															</td>
															<td style="width:4px;"></td>
															<td style="padding-left:4px;width:29%; border:1px solid #c1c1c1; vertical-align: top;">
			<table id="tb_psnJikgub" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
				<thead>
					<tr role="row">
					<th rowspan="1" colspan="1" style="width:30%;">코드</th>
					<th rowspan="1" colspan="1" style="width:40%;">직급명</th>
					<th rowspan="1" colspan="1" style="width:30%;">적용</th>
					</tr>
				</thead>
				<tbody id="bd_psnJikgub">

				</tbody>
			</table>
																	<table width="100%" style="text-align: right;">
																	<tr>
																		<td>
																		    <a class="btn btn-default btn-sm" onClick="javascript:addPsnJikgub();">+</a>&nbsp;&nbsp;
																			<a class="btn btn-default btn-sm" onClick="javascript:actionPsnJikgub();">직급저장</a>
																		</td>
																	</tr>
																	</table>
															</td>
														</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table style="width:100%;">
														<tr><td>
														단본부 설정 (우측 -> 좌측)
														</td></tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table style="width:100%">
															<tr>
																<td style="width:45%;vertical-align: top;">
			<table id="tb_sbuMapping" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
				<thead>
					<tr role="row">
					<th rowspan="1" colspan="1" style="width:50%;">평가군</th>
					<th rowspan="1" colspan="1" style="width:50%;">단/본부</th>
					</tr>
				</thead>
				<tbody id="bd_sbuMapping">

				</tbody>
			</table>
																</td>
																<td style="text-align: center">
																	<a class="btn btn-default btn-sm" onClick="javascript:delBscMapping();">></a><br><br>
																	<a class="btn btn-default btn-sm" onClick="javascript:addBscMapping();"><</a><br><br>

																	<a class="btn btn-default btn-sm" onClick="javascript:actionPsnSbuMapping();">저장</a>
																</td>
																<td style="width:45%;vertical-align: top;">
			<table id="tb_bscMapping" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
				<thead>
					<tr role="row">
					<th rowspan="1" colspan="1" style="width:30%;">ID</th>
					<th rowspan="1" colspan="1" style="width:70%;">단/본부</th>
					</tr>
				</thead>
				<tbody id="bd_bscMapping">

				</tbody>
			</table>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>

											</div>
											<div class="col-xs-12 col-sm-12 col-md-5 col-lg-5" style="padding-left:6px;">
												<table class="table">
												<tr>
													<td>
														<table style="width:100%;">
														<tr><td>
														2. 예외사항 설정
														</td></tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table class=" table-bordered" style="width:100%">
															<tr>
																<td style="text-align: center;padding: 8px;">
																	<a class="btn btn-info btn-sm" style="width: 260px;" onClick="javascript:openExceptUser();">평가부서 평가등급 적용 대상자 설정</a><br><br>
																	<a class="btn btn-info btn-sm" style="width: 260px;" onClick="javascript:openExceptLabor();">노조전임 등 예외자 설정</a><br><br>
																	*예외자는 기준지급률에 대하여 옉셀 수작업 필요함
																</td>
															</tr>
														</table>
													</td>
												</tr>
												</table>
												<table class="table">
												<tr>
													<td>
														<table style="width:100%;">
														<tr><td>
														3. 성과지급률 및 개인 M/H 집계
														</td></tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table class=" table-bordered" style="width:100%">
															<tr>
																<td style="text-align: center;padding: 8px;">
																	<a class="btn btn-info btn-sm" style="width: 260px;" onClick="javascript:actionPsnBscScore();">평가조직별 성과지급률 계산</a><br><br>
																	<a class="btn btn-info btn-sm" style="width: 260px;" onClick="javascript:actionPsnBizMh();">개인 M/H 집계</a><br><br>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												</table>

												<table class="table">
												<tr>
													<td>
														<table style="width:100%;">
														<tr><td>
														4. 개인 성과급 지급률 계산
														</td></tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table class=" table-bordered" style="width:100%">
															<tr>
																<td style="text-align: center;padding: 8px;">
																	<a class="btn btn-info btn-sm" style="width: 260px;" onClick="javascript:actionPsnScore();">개인 성과급 기준지급률 계산</a><br><br>
																</td>
																</tr>
																<tr><td style="text-align: left;padding: 8px;border-top: none;padding-left: 36px;">
																	*회사지급률 지급 <br>
																	1. 평가소속군이 아닌 직원 (노조전임 등) <br>
																	2. 소속구분이 곤란한 직원 (전전년 12월 및 전년도 정규입사자) <br>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												</table>
											</div>
										</div>


									</div>
									<!-- end s1 tab pane -->



									<div class="tab-pane fade" id="s2">
									<!-- 5등급 세부 배분표 -->

			<table width="100%" >
			<tr>

				<td style="text-align: right;">
					<a class="btn btn-primary btn-sm" onClick="javascript:seletePsnGrade();">조회</a>
					<a class="btn btn-info btn-sm" onClick="javascript:addPsnGrade();">추가</a>
					<a class="btn btn-info btn-sm" onClick="javascript:adjustPsnGrade();">저장</a>
				</td>
			</tr>
			</table>

			<table style="width:100%;">
			<tr><td>
			<참고> 5등급 세부 배분표
			</td></tr>
			</table>

			<table id="dt_basic" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
				<thead>
					<tr role="row">
					<th rowspan="2" colspan="1" style="width:25%;">부서수</th>
					<th rowspan="1" colspan="5" style="width:75%;">평가등급</th>
					</tr>
					<tr>
					<th rowspan="1" colspan="1" style="width:15%;">A</th>
					<th rowspan="1" colspan="1" style="width:15%;">B</th>
					<th rowspan="1" colspan="1" style="width:15%;">C</th>
					<th rowspan="1" colspan="1" style="width:15%;">D</th>
					<th rowspan="1" colspan="1" style="width:15%;">E</th>
					</tr>
				</thead>
				<tbody id="db_psnGrade">
<!-- 				<tr role="row" class="">
					<td class=""><input type="text" style="width:100%;text-align:right;" value=""/></td>
					<td class=""><input type="text" style="width:100%;text-align:right;" value=""/></td>
					<td class=""><input type="text" style="width:100%;text-align:right;" value=""/></td>
					<td class=""><input type="text" style="width:100%;text-align:right;" value=""/></td>
					<td class=""><input type="text" style="width:100%;text-align:right;" value=""/></td>
					<td class=""><input type="text" style="width:100%;text-align:right;" value=""/></td>
	 			</tr> -->
				</tbody>
			</table>



									</div>

									<div class="tab-pane fade" id="s3">
									<!-- 부서별 성과 지급률 -->

			<table width="100%" >
			<tr>
				<td style="text-align: left;">
				 <!-- <select style="width:200px;">
				 </select> -->
				</td>
				<td style="text-align: right;">
					<a class="btn btn-primary btn-sm" onClick="javascript:selectPsnBscGrade();">조회</a>
					<a class="btn btn-info btn-sm" onClick="javascript:adjustPsnBscGrade();">저장</a>
				</td>
			</tr>
			</table>

			<table style="width:100%;">
			<tr><td>
			부서별 성과순위
			</td></tr>
			</table>

			<table id="dt_basic" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
				<thead>
					<tr role="row">
					<th rowspan="2" colspan="1" style="width:10%;">조직구분</th>
					<th rowspan="2" colspan="1" style="width:10%;">부서명</th>
					<th rowspan="1" colspan="3" style="width:24%;">득점</th>
					<th rowspan="2" colspan="1" style="width:8%;">가감점</th>
					<th rowspan="2" colspan="1" style="width:8%;">최종득점</th>
					<th rowspan="2" colspan="1" style="width:8%;">순위</th>
					<th rowspan="1" colspan="2" style="width:16%;">지급률 등급</th>
					<th rowspan="1" colspan="2" style="width:16%;">차등지급률</th>
					</tr>
					<tr>
					<th rowspan="1" colspan="1" style="width:8%;">계량</th>
					<th rowspan="1" colspan="1" style="width:8%;">비계량</th>
					<th rowspan="1" colspan="1" style="width:8%;">합계</th>
					<th rowspan="1" colspan="1" style="width:8%;">1단계</th>
					<th rowspan="1" colspan="1" style="width:8%;">2단계</th>
					<th rowspan="1" colspan="1" style="width:8%;">1단계</th>
					<th rowspan="1" colspan="1" style="width:8%;">2단계</th>
					</tr>
				</thead>
				<tbody id="bd_psnBscGrade">
				<!-- <tr role="row" class="">
					<td class="">1</td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
					<td class=""></td>
	 			</tr> -->
				</tbody>
			</table>



									</div>

									<div class="tab-pane fade" id="s4">
									<!-- 개인별 사업 부서 -->
			<table width="100%" >
			<tr>
				<td style="text-align: left;width:70px;">
				성명 :
				</td>
				<td style="text-align: left;">
				 <input type="text" id="txtEmpNm" style="width:100px;" />
				</td>
				<td style="text-align: right;">
					<a class="btn btn-primary btn-sm" onClick="javascript:actionDownloadCSV('dt_psnBizHm');">엑셀</a>
					<a class="btn btn-primary btn-sm" onClick="javascript:selectPsnBizMh();">조회</a>
				</td>
			</tr>
			</table>

			<table style="width:100%;">
			<tr><td>
			개인별 M/H확인
			</td></tr>
			</table>

			<table id="dt_psnBizHm" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
				<thead>
					<tr>
					<th rowspan="1" colspan="1" style="width:8%;">사번</th>
					<th rowspan="1" colspan="1" style="width:8%;">성명</th>
					<th rowspan="1" colspan="1" style="width:8%;">직급</th>
					<th rowspan="1" colspan="1" style="width:8%;">사업부서코드</th>
					<th rowspan="1" colspan="1" style="width:8%;">사업부서명</th>
					<th rowspan="1" colspan="1" style="width:8%;">M/H</th>
					<th rowspan="1" colspan="1" style="width:8%;">예외사항</th>
					</tr>
				</thead>
				<tbody id="bd_psnBizMh">

				</tbody>
			</table>
									</div>

									<div class="tab-pane fade" id="s5">
									<!-- 기준 성과지급률 상세 -->
			<table width="100%" >
			<tr>
				<td style="text-align: left;width:70px;">
				성명 :
				</td>
				<td style="text-align: left;">
				 <input type="text" id="txtEmpNm2" style="width:100px;" />
				</td>
				<td style="text-align: right;">
				    <a class="btn btn-primary btn-sm" onClick="javascript:actionDownloadCSV('dt_psnScore');">엑셀</a>
					<a class="btn btn-primary btn-sm" onClick="javascript:selectPsnScore();">조회</a>
				</td>
			</tr>
			</table>

			<table style="width:100%;">
			<tr><td>
			개인별 성과 기준지급률 상세내역
			</td></tr>
			</table>

			<table id="dt_psnScore" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
				<thead>
					<tr>
					<th rowspan="1" colspan="1" style="width:7%;">사번</th>
					<th rowspan="1" colspan="1" style="width:7%;">성명</th>
					<th rowspan="1" colspan="1" style="width:6%;">직급</th>
					<th rowspan="1" colspan="1" style="width:7%;">기준지급률</th>
					<th rowspan="1" colspan="1" style="width:7%;">조직구분</th>
					<th rowspan="1" colspan="1" style="width:6%;">평가등급</th>
					<th rowspan="1" colspan="1" style="width:7%;">평가부서</th>
					<th rowspan="1" colspan="1" style="width:6%;">평가등급</th>
					<th rowspan="1" colspan="1" style="width:7%;">성과지급률</th>
					<th rowspan="1" colspan="1" style="width:7%;">평가M/H</th>
					<th rowspan="1" colspan="1" style="width:7%;">평가배분률</th>
					<th rowspan="1" colspan="1" style="width:7%;">평가M/H합계</th>
					<th rowspan="1" colspan="1" style="width:6%;">코드</th>
					<th rowspan="1" colspan="1" style="width:7%;">사업부서명</th>
					<th rowspan="1" colspan="1" style="width:7%;">사업M/H</th>
					</tr>
				</thead>
				<tbody id="bd_psnScore">

				</tbody>
			</table>
									</div>

									<div class="tab-pane fade" id="s6">
									<!-- 기준 성과지급률 -->

			<table width="100%" >
			<tr>
				<td style="text-align: left;width:70px;">
				성명 :
				</td>
				<td style="text-align: left;">
				 <input type="text" id="txtEmpNm3" style="width:100px;" />
				</td>
				<td style="text-align: right;">
				    <a class="btn btn-primary btn-sm" onClick="javascript:actionDownloadCSV('dt_psnScoreList');">엑셀</a>
					<a class="btn btn-primary btn-sm" onClick="javascript:selectPsnScoreList();">조회</a>
				</td>
			</tr>
			</table>

			<table style="width:100%;">
			<tr><td>
			개인별 성과 기준지급률 상세내역
			</td></tr>
			</table>

			<table id="dt_psnScoreList" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;">
				<thead>
					<tr>
					<th rowspan="1" colspan="1" style="width:7%;">사번</th>
					<th rowspan="1" colspan="1" style="width:7%;">성명</th>
					<th rowspan="1" colspan="1" style="width:6%;">직급</th>
					<th rowspan="1" colspan="1" style="width:7%;">기준지급률</th>
					<th rowspan="1" colspan="1" style="width:7%;">조직구분</th>
					<th rowspan="1" colspan="1" style="width:6%;">평가등급</th>
					<th rowspan="1" colspan="1" style="width:7%;">평가부서</th>
					<th rowspan="1" colspan="1" style="width:6%;">평가등급</th>
					<th rowspan="1" colspan="1" style="width:7%;">성과지급률</th>
					<th rowspan="1" colspan="1" style="width:7%;">평가M/H</th>
					<th rowspan="1" colspan="1" style="width:7%;">평가배분률</th>
					<th rowspan="1" colspan="1" style="width:7%;">평가M/H합계</th>
					</tr>
				</thead>
				<tbody id="bd_psnScoreList">

				</tbody>
			</table>

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

		<div class="" id="div_properties" name="div_properties" style="display: none;">
		<div class="popup">
<form class="form-horizontal" id="form_meausre_updater_detail" name="form_meausre_updater_detail" style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>평가조직별 대상자 선택</h2>
		</header>

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">
			<fieldset>
				<div class="col-md-4" style="padding-right: 1px;;">
	                <div class="icon-addon addon-md" >
	                    <div id="" style="width:100%;height:460px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_bsc" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:40%;">조직구분</th>
								<th rowspan="1" colspan="1" style="width:40%;">부서</th>
								<th rowspan="1" colspan="1" style="width:20%;">배정</th>
								</tr>
							</thead>
							<tbody id="bd_bsc">

							</tbody>
	                    </table>
	                    </div>
	                </div>
				</div>

	            <div class="col-md-4" style="padding-right: 1px;;">
	                <div class="icon-addon addon-md" >
						<div id="" style="width:100%;height:460px;overflow-y:scroll; overflow-x: hidden">
						<table id="tb_exceptEmp" class="table table-striped table-bordered table-hover dataTable" style="width: 100%; table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:20%;">구분</th>
								<th rowspan="1" colspan="1" style="width:30%;">평가부서</th>
								<th rowspan="1" colspan="1" style="width:25%;">사번</th>
								<th rowspan="1" colspan="1" style="width:25%;">성명</th>
								</tr>
							</thead>
							<tbody id="bd_exceptEmp">

							</tbody>
	                    </table>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-1" style="padding-right: 1px;width: 42px;">
	            <br><br><br><br><br>
					<a class="btn btn-default btn-sm" onClick="javascript:delExceptEmp();">></a><br><br>
					<a class="btn btn-default btn-sm" onClick="javascript:addExceptEmp();"><</a><br><br>
	            </div>

	            <div class="col-md-3" style="padding-right: 1px;width: 28%;">
	                <div class="icon-addon addon-md" >
						<div id="" style="width:100%;height:460px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_psnEmp" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:30%;">사번</th>
								<th rowspan="1" colspan="1" style="width:40%;">성명</th>
								<th rowspan="1" colspan="1" style="width:30%;">직급</th>
								</tr>
							</thead>
							<tbody id="bd_psnEmp">

							</tbody>
	                    </table>
	                    </div>
	                </div>
	            </div>

			</fieldset>





			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
						<a onClick="closeExceptUser()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
						<a onClick="actionExceptEmp()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">저장</a>

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
		<!-- end of propertiy -->




		<div class="" id="div_labor" name="div_labor" style="display: none;">
		<div class="popup">
<form class="form-horizontal" id="form_meausre_updater_detail" name="form_meausre_updater_detail" style="padding:10px;">
<section id="widget-yield" class="" >
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="jarviswidget" id="wid-id-1" >
		<header>
			<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
			<h2>노조원 선택</h2>
		</header>

		<!-- widget div-->
		<div class="widget-content">
			<!-- widget content -->
			<div class="widget-body">
			<fieldset>

	            <div class="col-md-6" style="padding-right: 1px;;">
	                <div class="icon-addon addon-md" >
						<div id="" style="width:100%;height:460px;overflow-y:scroll; overflow-x: hidden">
						<table id="tb_laborUser" class="table table-striped table-bordered table-hover dataTable" style="width: 100%; table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:30%;">사번</th>
								<th rowspan="1" colspan="1" style="width:40%;">성명</th>
								<th rowspan="1" colspan="1" style="width:30%;">직급</th>
								</tr>
							</thead>
							<tbody id="bd_laborUser">

							</tbody>
	                    </table>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-1" style="padding-right: 1px;width: 42px;">
	            <br><br><br><br><br>
					<a class="btn btn-default btn-sm" onClick="javascript:addLaborEmp();">></a><br><br>
					<a class="btn btn-default btn-sm" onClick="javascript:delLaborEmp();"><</a><br><br>
	            </div>

	            <div class="col-md-5" style="padding-right: 1px;width: 45%;">
	                <div class="icon-addon addon-md" >
						<div id="" style="width:100%;height:460px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table id="tb_laborEmp" class="table table-striped table-bordered table-hover dataTable " style="width: 100%;table-layout: fixed;">
	                    	<thead>
								<tr role="row">
								<th rowspan="1" colspan="1" style="width:50%;">사번</th>
								<th rowspan="1" colspan="1" style="width:50%;">성명</th>
								</tr>
							</thead>
							<tbody id="bd_laborEmp">

							</tbody>
	                    </table>
	                    </div>
	                </div>
	            </div>

			</fieldset>





			<fieldset style="margin-bottom: 20px;">
				<div class="form-group">
				   	<div id="buttonContent" style="width:100%;padding-right:20px;padding-top: 20px;">
						<a onClick="closeExceptLabor()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
						<a onClick="actionLaborEmp()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">저장</a>

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





