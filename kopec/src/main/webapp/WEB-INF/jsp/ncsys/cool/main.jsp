<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>


	.alert {
    	margin-bottom: 15px;
    }
    
    table tr td {
    	vertical-align: middle !important;
    	font-size: 14px;
    	color: #545454;
    	padding-top: 0px;
    	padding-bottom: 0px;
    	background-color: #f5f5f5;
    }
    
    .table-bordered> tbody>tr>td{
    	border: 1px solid #d0cfcf;
    }
    
    .table_td_clr {
    	background-color: #fff;
    }
</style>


	
			<section id="widget-grid" class="">

					<!-- row -->
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
									<span class="widget-icon"> <i class="glyphicon glyphicon-th-list txt-color-darken"></i> </span>
									<h2>비전/전략 </h2>

									<ul class="nav nav-tabs pull-right in" id="myTab">
										<li class="active">
											<a data-toggle="tab" href="#s1"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">미션 및 비전</span></a>
										</li>
										<li>
											<a data-toggle="tab" href="#s2"><i class="fa fa-recycle"></i> <span class="hidden-mobile hidden-tablet">전략방향</span></a>
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
															<td style="font-size:16px;font-weight:600; width:20%;background-color:#cde0c4;color:#356635;border-bottom: 18px solid #fff;border-left:5px solid #8ac38b;padding:20px 0 20px 6px;">
																설립목적
															</td>
															<td style="font-size:16px;width:75%;background-color:#cde0c4;color:#356635;border-bottom: 18px solid #fff;border-left:8px solid #fff;border-right: 12px solid #fff;">
																<i class="fa fa-check"></i> 시설물 안전 유지관리 
																<i class="fa fa-check"></i> 공중의 안전확보 
																<i class="fa fa-check"></i> 국민의 복리증진
															</td>
														</tr>
														<tr>
															<td style="font-size:16px;font-weight:600;width:20%;background-color:#efe1b3;color:#826430;border-bottom: 18px solid #fff;border-left:5px solid #dfb56c;padding:20px 0 20px 6px;">
																미션
															</td>
															<td style="font-size:16px;width:75%;background-color:#efe1b3;color:#826430;border-bottom: 18px solid #fff;border-left:8px solid #fff;border-right: 12px solid #fff;">
																시설물 안전 및 성능증진으로 복지사회 구현
															</td>
														</tr>
														<tr>
															<td style="font-size:16px;font-weight:600;width:20%;background-color:#d6dde7;color:#305d8c;border-left:5px solid #9cb4c5;padding:20px 0 20px 6px;">
																비전
															</td>
															<td style="font-size:16px;width:75%;background-color:#d6dde7;color:#305d8c;border-left:8px solid #fff;border-right: 12px solid #fff;">
																국민행복을 지키는 시설물 안전 및 성능관리 종합전문기관
															</td>
														</tr>
													</table>		

													</div>
													<div class="col-xs-12 col-sm-12 col-md-5 col-lg-5">
														<table class="table table-bordered">
															<tr>
																<td style="width:25%" rowspan="6">공유가치</td>
																<td style="width:25%" rowspan="3">핵심가치</td>
																<td style="width:50%" class="table_td_clr">전문성</td>
															</tr>
															<tr>
																<td style="width:50%" class="">생명존중</td>
															</tr>
															<tr>
																<td style="width:50%" class="table_td_clr">신뢰성</td>
															</tr>
															<tr>
																<td style="width:25%" class="table_td_clr" rowspan="3">경영방침</td>
																<td style="width:50%" class="">New Equilibrium(적응)</td>
															</tr>
															<tr>
																<td style="width:50%" class="table_td_clr">Let's 動 (발전)</td>
															</tr>
															<tr>
																<td style="width:50%" class="">KISTEC, The Clean Pride! (청렴)</td>
															</tr>
														</table>
													</div>
												</div>


											</div>
											<!-- end s1 tab pane -->

											

											<div class="tab-pane fade" id="s2">

												<div class="widget-body-toolbar bg-color-white smart-form" id="rev-toggles">

													<div class="inline-group">

														<label for="gra-0" class="checkbox">
															<input type="checkbox" name="gra-0" id="gra-0" checked="checked">
															<i></i> Target </label>
														<label for="gra-1" class="checkbox">
															<input type="checkbox" name="gra-1" id="gra-1" checked="checked">
															<i></i> Actual </label>
														<label for="gra-2" class="checkbox">
															<input type="checkbox" name="gra-2" id="gra-2" checked="checked">
															<i></i> Signups </label>
													</div>

													<div class="btn-group hidden-phone pull-right">
														<a class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown"><i class="fa fa-cog"></i> More <span class="caret"> </span> </a>
														<ul class="dropdown-menu pull-right">
															<li>
																<a href="javascript:void(0);"><i class="fa fa-file-text-alt"></i> Export to PDF</a>
															</li>
															<li>
																<a href="javascript:void(0);"><i class="fa fa-question-sign"></i> Help</a>
															</li>
														</ul>
													</div>

												</div>

												<div class="padding-10">
													<div id="flotcontainer" class="chart-large has-legend-unique"></div>
												</div>
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

					<!-- end row -->
					
					
					<div class="row">
						<article class="col-sm-6">
							<!-- new widget -->
							<div class="jarviswidget" id="wid-id-11" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
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
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2>부서성과 현황 </h2>

								</header>
								
								<div role="content">
									<div class="widget-body">
										<div class="row">
											<iframe id="pstChart" name="pstChart" src="<c:url value='/jsp/flex/main/pstChart.jsp'/>" style="width:100%;height:200px;padding:6px;" frameborder="0" scrolling="no">
											</iframe>
										</div>
									</div>
								</div>
						</article>
						<article class="col-sm-6">
							<!-- new widget -->
							<div class="jarviswidget" id="wid-id-22" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
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
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2>부서성과지표 실적점수 </h2>

								</header>
								
								<div role="content">
									<div class="widget-body">
										<div class="row">
											<iframe id="measureDetail" name="measureDetail" src="<c:url value='/jsp/web/pds/idx/idx_measure.jsp'/>" style="width:100%;height:200px;padding:6px;" frameborder="0" scrolling="no">
											</iframe>
										</div>
									</div>
								</div>
						</article>
					</div>

					<!-- end row -->
					
					<div class="row">
						<article class="col-sm-6">
							<!-- new widget -->
							<div class="jarviswidget" id="wid-id-33" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
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
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2>공지사항 </h2>

								</header>
								
								<div role="content">
									<div class="widget-body">
										<div class="row">
											<iframe src="<c:url value='/cop/bbs/selectBoardLatestList.do?bbsId=BBSMSTR_000000000001'/>" style="width:100%;height:250px;padding:0 8px;" frameborder="0">
											</iframe>
										</div>
									</div>
								</div>
						</article>
						<article class="col-sm-6">
							<!-- new widget -->
							<div class="jarviswidget" id="wid-id-44" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
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
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2>자료실 </h2>

								</header>
								
								<div role="content">
									<div class="widget-body">
										<div class="row">
											<iframe src="<c:url value='/cop/bbs/selectBoardLatestList.do?bbsId=BBSMSTR_000000000011'/>" style="width:100%;height:250px;padding:0 8px;" frameborder="0" >
											</iframe>
										</div>
									</div>
								</div>
						</article>
					</div>

					<!-- end row -->					
</section>					