<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Calendar date = Calendar.getInstance();
	SimpleDateFormat today = new SimpleDateFormat("yyyy.mm.dd");
	
%>
<script>

</script>

			<div class="row">

				<!-- ------------------------------------------------------------------------------------------------------ -->
				
				<!-- 좌측 테이블 영역 -->
				<div class="col-sm-12 col-md-12 col-lg-10 " style="padding-right: 0px; padding-left: 0px; margin-bottom: 20px;"> 


					<!-- 탭 박스 -->	
						<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable">
	
							<div class="widget-body">
	
	
								<ul id="myTab1" class="nav nav-tabs bordered">
									<li class="active"><a href="#s1" data-toggle="tab" aria-expanded="true"> 시험(일반) </a></li>
									<li><a href="#s2" data-toggle="tab" aria-expanded="true"> 법정(공인) </a></li>
									<li><a href="#s3" data-toggle="tab" aria-expanded="true">&nbsp;&nbsp;&nbsp;교&nbsp;육&nbsp;&nbsp;&nbsp; </a></li>
									<li><a href="#s4" data-toggle="tab" aria-expanded="true">e-KOLAS
									</a></li>
								</ul>
	
	
								<!-- 1번 탭 컨텐츠 -->
								<div id="myTabContent1" class="tab-content padding-10">
									<div class="tab-pane fade active in" id="s1">
										
										<div class="row">
										
											<!-- 테이블 1라인 좌측 -->
											<article class="col-sm-12 col-md-12 col-lg-7 sortable-grid ui-sortable">
	
												<!-- Widget ID (each widget will need unique ID)-->
													<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-10"  role="widget">
													
													<header role="heading">
														
														<span class="widget-icon"> <i class="fa  fa-database"></i>
														</span>
														<h2>의뢰시험 접수내역</h2>
	
														<span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
													</header>
	
													<!-- widget div-->
													<div role="content">
	
														<!-- widget edit box -->
														<div class="jarviswidget-editbox">
															<!-- This area used as dropdown edit box -->
	
														</div>
														<!-- end widget edit box -->
	
														<!-- widget content -->
														<div class="widget-body no-padding">
	
															
															<div class="table-responsive">
	
																<table class="table table-striped table-bordered">
																	<thead>
																		<tr>
																			<th>신청일</th>
																			<th>업체명</th>
																			<th>신청자</th>
																			<th>진행상태</th>
																			<th class="width45">시료</th>
																			<th class="width45">항목</th>
																			<th>견적서</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td>15.10.23</td>
																			<td class="cutStringL">(주)티젠</td>
																			<td>이태의</td>
																			<td class="text-center"><span class="label label-default">접수대기</span></td>
																			<td class="text-right">1</td>
																			<td class="text-right">1</td>
																			<td class="text-center"><a href="javascript:void(0);" class="btn bg-color-blueLight txt-color-white btn-xs"><i class="fa fa-krw"></i></a></td>
																		</tr>
																		<tr>
																			<td>15.10.12</td>
																			<td class="cutStringL">아노텐금산주식회사</td>
																			<td>유원장</td>
																			<td class="text-center"><span class="label label-primary">접수완료</span></td>
																			<td class="text-right">2</td>
																			<td class="text-right">2</td>
																			<td class="text-center"><a href="javascript:void(0);" class="btn bg-color-blueLight txt-color-white btn-xs"><i class="fa fa-krw"></i></a></td>
																		</tr>
																		<tr>
																			<td>15.10.06</td>
																			<td class="cutStringL">(주)오션마린서비스</td>
																			<td>정은</td>
																			<td class="text-center"><span class="label label-success">분석승인</span></td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																			<td class="text-center"><a href="javascript:void(0);" class="btn bg-color-blueLight txt-color-white btn-xs"><i class="fa fa-krw"></i></a></td>
																		</tr>
																		<tr>
																			<td>15.10.05</td>
																			<td class="cutStringL">주식회사 대유플러스 순...</td>
																			<td>양성열</td>
																			<td class="text-center"><span class="label label-info">분석진행</span></td>
																			<td class="text-right">4</td>
																			<td class="text-right">4</td>
																			<td class="text-center"><a href="javascript:void(0);" class="btn bg-color-blueLight txt-color-white btn-xs"><i class="fa fa-krw"></i></a></td>
																		</tr>
																		<tr>
																			<td>15.10.01</td>
																			<td class="cutStringL">(주)대림</td>
																			<td>장정주</td>
																			<td class="text-center"><span class="label label-warning">시험완료</span></td>
																			<td class="text-right">30</td>
																			<td class="text-right">30</td>
																			<td class="text-center"><a href="javascript:void(0);" class="btn bg-color-blueLight txt-color-white btn-xs"><i class="fa fa-krw"></i></a></td>
																		</tr>
																		<tr>
																			<td>15.10.05</td>
																			<td class="cutStringL">한국지역난방공사 청주지...</td>
																			<td>신청자</td>
																			<td class="text-center"><span class="label label-danger">발급승인</span></td>
																			<td class="text-right">999</td>
																			<td class="text-right">999</td>
																			<td class="text-center"><a href="javascript:void(0);" class="btn bg-color-blueLight txt-color-white btn-xs"><i class="fa fa-krw"></i></a></td>
																		</tr>
																		<tr>
																			<td>15.09.30</td>
																			<td>한국남부발전(주) 영월천...</td>
																			<td>태윤환</td>
																			<td class="text-center"><span class="label bg-color-pink">발급완료</span></td>
																			<td class="text-right">9</td>
																			<td class="text-right">9</td>
																			<td class="text-center"><a href="javascript:void(0);" class="btn bg-color-blueLight txt-color-white btn-xs"><i class="fa fa-krw"></i></a></td>
																		</tr>
																		<tr>
																			<td>15.09.11</td>
																			<td>OCI</td>
																			<td>이신우</td>
																			<td class="text-center"><span class="label bg-color-pink">발급완료</span></td>
																			<td class="text-right">15</td>
																			<td class="text-right">15</td>
																			<td class="text-center"><a href="javascript:void(0);" class="btn bg-color-blueLight txt-color-white btn-xs"><i class="fa fa-krw"></i></a></td>
																		</tr>
																	</tbody>
																</table>
	
															</div>
														</div>
														<!-- end widget content -->
	
													</div>
													<!-- end widget div -->
	
												</div>
												<!-- end widget -->
	
											</article>
											<!-- ./테이블 1라인 좌측 -->
											
											<!-- 테이블 1라인 우측 -->
											<article class="col-sm-12 col-md-12 col-lg-5 sortable-grid ui-sortable">
	
												<!-- Widget ID (each widget will need unique ID)-->
													<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-10"  role="widget">
													
													<header role="heading">
														
														<span class="widget-icon"> <i class="fa fa-table"></i>
														</span>
														<h2>진행현황 정보</h2>
	
														<span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
													</header>
	
													<!-- widget div-->
													<div role="content">
	
														<!-- widget edit box -->
														<div class="jarviswidget-editbox">
															<!-- This area used as dropdown edit box -->
	
														</div>
														<!-- end widget edit box -->
	
														<!-- widget content -->
														<div class="widget-body no-padding">
	
															
															<div class="table-responsive">
	
																<table class="table table-striped table-bordered">
																	<thead>
																		<tr>
																			<th>진행구분</th>
																			<th>구분</th>
																			<th colspan="2" class="width45">건수</th>
																			<th class="width45">반려</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td rowspan="3">접수</td>
																			<td>일반(협조)</td>
																			<td class="text-right">28</td>
																			<td class="text-right">(2)</td>
																			<td class="text-right">5</td>
																		</tr>
																		<tr>
																			<td>등본</td>
																			<td class="text-right">3</td>
																			<td class="text-right"></td>
																			<td class="text-right"></td>
																		</tr>
																		<tr>
																			<td>통합</td>
																			<td class="text-right">1</td>
																			<td class="text-right"></td>
																			<td class="text-right">2</td>
																		</tr>
																		<tr>
																			<td rowspan="2">결과미등록</td>
																			<td>시료(협조)</td>
																			<td class="text-right">15</td>
																			<td class="text-right">(2)</td>
																			<td class="text-right"></td>
																		</tr>
																		<tr>
																			<td>항목(협조)</td>
																			<td class="text-right">56</td>
																			<td class="text-right">(6)</td>
																			<td class="text-right"></td>
																		</tr>
																		<tr>
																			<td rowspan="3">결재</td>
																			<td>접수(협조)</td>
																			<td class="text-right">45</td>
																			<td class="text-right">(3)</td>
																			<td class="text-right"></td>
																		</tr>
																		<tr>
																			<td>발급</td>
																			<td class="text-right">34</td>
																			<td class="text-right"></td>
																			<td class="text-right"></td>
																		</tr>
																		<tr>
																			<td>기타</td>
																			<td class="text-right">1</td>
																			<td class="text-right"></td>
																			<td class="text-right">2</td>
																		</tr>
																	</tbody>
																</table>
	
															</div>
														</div>
														<!-- end widget content -->
	
													</div>
													<!-- end widget div -->
	
												</div>
												<!-- end widget -->
	
											</article>
											<!-- ./테이블 1라인 우측 -->
		
	
											<!-- 테이블 2라인 좌측 -->
											<article
												class="col-sm-12 col-md-12 col-lg-7 sortable-grid ui-sortable">
	
												<!-- Widget ID (each widget will need unique ID)-->
													<div class="jarviswidget jarviswidget-color-blueLight" id="wid-id-10"  role="widget">
													
													<header role="heading">
														
														<span class="widget-icon"> <i class="fa fa-database"></i>
														</span>
														<h2>진행상태 현황</h2>
	
														<span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
													</header>
	
													<!-- widget div-->
													<div role="content">
	
														<!-- widget edit box -->
														<div class="jarviswidget-editbox">
															<!-- This area used as dropdown edit box -->
	
														</div>
														<!-- end widget edit box -->
	
														<!-- widget content -->
														<div class="widget-body no-padding">
	
															
															<div class="table-responsive">
	
																<table class="table table-striped table-bordered">
																	<thead>
																		<tr>
																			<th>접수번호</th>
																			<th>접수일</th>
																			<th>업체명</th>
																			<th>신청자</th>
																			<th class="width45">시료</th>
																			<th class="width45">항목</th>
																			<th>진행상태</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td class="cutStringL">TSC2015-2993</td>
																			<td class="cutStringL">15.10.30</td>
																			<td class="cutStringL">주식회사 대유플러스 순...</td>
																			<td>양성열</td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																			<td class="text-center"><span class="label label-default">접수대기</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">TSC2015-2991</td>
																			<td class="cutStringL">15.09.28</td>
																			<td class="cutStringL">한국지역난방공사 청주지...</td>
																			<td>이태의</td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																			<td class="text-center"><span class="label label-primary">접수완료</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">TSC2015-2988</td>
																			<td class="cutStringL">15.07.11</td>
																			<td class="cutStringL">한국남부발전(주) 영월천...</td>
																			<td>방성호</td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																			<td class="text-center"><span class="label label-success">분석승인</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">전우2015-0364</td>
																			<td class="cutStringL">15.01.31</td>
																			<td class="cutStringL">(주)티젠</td>
																			<td>김경태</td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																			<td class="text-center"><span class="label label-info">분석진행</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">TSC2015-2993</td>
																			<td class="cutStringL">15.10.30</td>
																			<td class="cutStringL">아노텐금산주식회사</td>
																			<td>양성열</td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																			<td class="text-center"><span class="label label-warning">시험완료</span></td>
																		</tr>
																	</tbody>
																</table>
	
															</div>
														</div>
														<!-- end widget content -->
	
													</div>
													<!-- end widget div -->
	
												</div>
												<!-- end widget -->
	
											</article>
											<!-- ./테이블 2라인 좌측 -->
											
											<!-- 테이블 2라인 우측 -->
											<article
												class="col-sm-12 col-md-12 col-lg-5 sortable-grid ui-sortable">
	
												<!-- Widget ID (each widget will need unique ID)-->
													<div class="jarviswidget jarviswidget-color-blueLight" id="wid-id-10"  role="widget">
													
													<header role="heading">
														
														<span class="widget-icon"> <i class="fa fa-table"></i>
														</span>
														<h2>회원제 현황</h2>
	
														<span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
													</header>
	
													<!-- widget div-->
													<div role="content">
	
														<!-- widget edit box -->
														<div class="jarviswidget-editbox">
															<!-- This area used as dropdown edit box -->
	
														</div>
														<!-- end widget edit box -->
	
														<!-- widget content -->
														<div class="widget-body no-padding">
	
															
															<div class="table-responsive">
	
																<table class="table table-striped table-bordered">
																	<thead>
																		<tr>
																			<th>회원번호</th>
																			<th>업체명</th>
																			<th>가입일</th>
																			<th>종료일</th>
																			<th>상태</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td class="cutStringL">회원특2015-022</td>
																			<td class="cutStringL">(주)신승케미칼</td>
																			<td class="cutStringL">15.09.18</td>
																			<td class="cutStringL">16.09.17</td>
																			<td class="text-center"><span class="label bg-color-pink">진행</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">회원특2015-017</td>
																			<td class="cutStringL">주식회사 대유플러스 순...</td>
																			<td>15.07.22</td>
																			<td>16.07.21</td>
																			<td class="text-center"><span class="label bg-color-pink">진행</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">회원특2015-012</td>
																			<td class="cutStringL">(주)동신화학</td>
																			<td>15.05.15</td>
																			<td>16.07.05</td>
																			<td class="text-center"><span class="label label-default">대기</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">회원특2015-010</td>
																			<td class="cutStringL">대성나찌유압공업</td>
																			<td>15.05.15</td>
																			<td>16.07.05</td>
																			<td class="text-center"><span class="label label-default">대기</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">회원특2015-022</td>
																			<td class="cutStringL">(주)신승케미칼</td>
																			<td>15.09.18</td>
																			<td>16.09.17</td>
																			<td class="text-center"><span class="label label-default">대기</span></td>
																		</tr>
																	</tbody>
																</table>
	
															</div>
														</div>
														<!-- end widget content -->
	
													</div>
													<!-- end widget div -->
	
												</div>
												<!-- end widget -->
	
											</article>
											<!-- ./테이블 2라인 우측 -->
		
											
													
											<!-- 테이블 3라인 좌측 -->
											<article
												class="col-sm-12 col-md-12 col-lg-7 sortable-grid ui-sortable">
	
												<!-- Widget ID (each widget will need unique ID)-->
													<div class="jarviswidget jarviswidget-color-blueDark " id="wid-id-10"  role="widget">
													
													<header role="heading">
														
														<span class="widget-icon"> <i class="fa fa-database"></i>
														</span>
														<h2>품질검사 접수내역</h2>
	
														<span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
													</header>
	
													<!-- widget div-->
													<div role="content">
	
														<!-- widget edit box -->
														<div class="jarviswidget-editbox">
															<!-- This area used as dropdown edit box -->
	
														</div>
														<!-- end widget edit box -->
	
														<!-- widget content -->
														<div class="widget-body no-padding">
	
															
															<div class="table-responsive">
	
																<table class="table table-striped table-bordered">
																	<thead>
																		<tr>
																			<th>신청일자</th>
																			<th>업체명</th>
																			<th>담당지사</th>
																			<th>진행상태</th>
																			<th class="width45">시료</th>
																			<th class="width45">항목</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td class="cutStringL">15.10.30</td>
																			<td class="cutStringL">주식회사 대유플러스 순...</td>
																			<td>본사</td>
																			<td class="text-center"><span class="label label-default">접수대기</span></td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																		</tr>
																		<tr>
																			<td class="cutStringL">15.09.28</td>
																			<td class="cutStringL">한국지역난방공사 청주지...</td>
																			<td>강원</td>
																			<td class="text-center"><span class="label label-primary">접수완료</span></td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																		</tr>
																		<tr>
																			<td class="cutStringL">15.07.11</td>
																			<td class="cutStringL">한국남부발전(주) 영월천...</td>
																			<td>연구소</td>
																			<td class="text-center"><span class="label label-success">분석승인</span></td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																		</tr>
																		<tr>
																			<td class="cutStringL">15.01.31</td>
																			<td class="cutStringL">(주)티젠</td>
																			<td>영남</td>
																			<td class="text-center"><span class="label label-info">분석진행</span></td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																		</tr>
																		<tr>
																			<td class="cutStringL">15.10.30</td>
																			<td class="cutStringL">아노텐금산주식회사</td>
																			<td>강원</td>
																			<td class="text-center"><span class="label label-warning">시험완료</span></td>
																			<td class="text-right">3</td>
																			<td class="text-right">3</td>
																		</tr>
																	</tbody>
																</table>
	
															</div>
														</div>
														<!-- end widget content -->
	
													</div>
													<!-- end widget div -->
	
												</div>
												<!-- end widget -->
	
											</article>
											<!-- ./테이블 3라인 좌측 -->
											
											<!-- 테이블 3라인 우측 -->
											<article
												class="col-sm-12 col-md-12 col-lg-5 sortable-grid ui-sortable">
	
												<!-- Widget ID (each widget will need unique ID)-->
													<div class="jarviswidget jarviswidget-color-blueDark " id="wid-id-10"  role="widget">
													
													<header role="heading">
														
														<span class="widget-icon"> <i class="fa fa-table"></i>
														</span>
														<h2>설비계약 현황</h2>
	
														<span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
													</header>
	
													<!-- widget div-->
													<div role="content">
	
														<!-- widget edit box -->
														<div class="jarviswidget-editbox">
															<!-- This area used as dropdown edit box -->
	
														</div>
														<!-- end widget edit box -->
	
														<!-- widget content -->
														<div class="widget-body no-padding">
	
															
															<div class="table-responsive">
	
																<table class="table table-striped table-bordered">
																	<thead>
																		<tr>
																			<th>계약번호</th>
																			<th>업체명</th>
																			<th>가입일</th>
																			<th>종료일</th>
																			<th>상태</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td class="cutStringL">설비2015-022</td>
																			<td class="cutStringL">(주)신승케미칼</td>
																			<td>15.09.18</td>
																			<td><span class="label label-success">16.09.17</td>
																			<td class="text-center"><span class="label bg-color-pink">진행</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">설비2015-017</td>
																			<td class="cutStringL">주식회사 대유플러스 순...</td>
																			<td>15.07.22</td>
																			<td>16.07.21</td>
																			<td class="text-center"><span class="label bg-color-pink">진행</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">설비2015-012</td>
																			<td class="cutStringL">(주)동신화학</td>
																			<td>15.05.15</td>
																			<td>16.07.05</td>
																			<td class="text-center"><span class="label bg-color-pink">진행</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">설비2015-010</td>
																			<td class="cutStringL">대성나찌유압공업</td>
																			<td>15.05.15</td>
																			<td>16.07.05</td>
																			<td class="text-center"><span class="label label-default">대기</span></td>
																		</tr>
																		<tr>
																			<td class="cutStringL">회원특2015-022</td>
																			<td class="cutStringL">(주)신승케미칼</td>
																			<td>15.09.18</td>
																			<td>16.09.17</td>
																			<td class="text-center"><span class="label label-default">대기</span></td>
																		</tr>
																	</tbody>
																</table>
	
															</div>
														</div>
														<!-- end widget content -->
	
													</div>
													<!-- end widget div -->
	
												</div>
												<!-- end widget -->
	
											</article>
											<!-- ./테이블 3라인 우측 -->
		
											
											
										</div>
									</div>
									<div class="tab-pane fade" id="s2">
										<p>Food truck fixie locavore, accusamus mcsweeney's marfa
											nulla single-origin coffee squid. Exercitation +1 labore
											velit, blog sartorial PBR leggings next level wes anderson
											artisan four loko farm-to-table craft beer twee.</p>
									</div>
									<div class="tab-pane fade" id="s3">
										<p>Etsy mixtape wayfarers, ethical wes anderson tofu before
											they sold out mcsweeney's organic lomo retro fanny pack lo-fi
											farm-to-table readymade. Messenger bag gentrify pitchfork
											tattooed craft beer, iphone skateboard locavore carles etsy
											salvia banksy hoodie helvetica. DIY synth PBR banksy irony.</p>
									</div>
									<div class="tab-pane fade" id="s4">
										<p>Trust fund seitan letterpress, keytar raw denim keffiyeh
											etsy art party before they sold out master cleanse gluten-free
											squid scenester freegan cosby sweater. Fanny pack portland
											seitan DIY, art party locavore wolf cliche high life echo park
											Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before
											they sold out farm-to-table.</p>
									</div>
								</div>
								<!-- ./1번 탭 컨텐츠 -->
							</div>
	
						</article>
					<!-- ./탭 박스 -->	
					
				</div>
				<!-- ./좌측 테이블 영역 -->
				
			
				
				<!-- 우측 공지,자료실 영역 -->
				<div class="col-sm-12 col-md-12 col-lg-2"> 
					
					<!--  공지사항 -->
					<div class="well well-light col-sm-12 col-md-12 col-lg-12 padding-bottom-0">
						<h6 class="margin-top-0"><i class="fa fa-fire text-info" ></i> 공지사항:</h6>
						<table class="table table-striped">
							<tbody>
								<tr>
									<td>광복절 전일(8월 14일) 임시공휴일로…</td>
									<td>15.08.11</td>
								</tr>
								<tr>
									<td>2015년 2분기 신청내역 삭제를 알려…</td>
									<td>15.08.03</td>
								</tr>
								<tr>
									<td>신규장비 추가 등록 </td>
									<td>15.03.05</td>
								</tr>
								<tr>
									<td>통합접수시스템 관련 설문조사 부탁드…</td>
									<td>13.12.20</td>
								</tr>
								<tr>
									<td>의뢰시험 이용자 만족도 평가를위한 설…</td>
									<td>14.01.10</td>
								</tr>
								<tr>
									<td>연구장비 공동활용 지원사업 주관기관…</td>
									<td>14.02.06</td>
								</tr>
								<tr>
									<td>온라인 의뢰시험 접수 방법</td>
									<td>14.03.27</td>
								</tr>
							</tbody>
						</table>
						
					</div>
					<!-- ./공지사항 -->
					
					
					<!--  자료실 -->
					<div class="well well-light col-sm-12 col-md-12 col-lg-12 padding-bottom-0">
						<h6 class="margin-top-0"><i class="fa fa-fire text-primary"></i> 자료실:</h6>
						<table class="table table-striped">
							<tbody>
								<tr>
									<td>광복절 전일(8월 14일) 임시공휴일로…</td>
									<td>15.08.11</td>
								</tr>
								<tr>
									<td>2015년 2분기 신청내역 삭제를 알려…</td>
									<td>15.08.03</td>
								</tr>
								<tr>
									<td>신규장비 추가 등록 </td>
									<td>15.03.05</td>
								</tr>
								<tr>
									<td>통합접수시스템 관련 설문조사 부탁드…</td>
									<td>13.12.20</td>
								</tr>
								<tr>
									<td>의뢰시험 이용자 만족도 평가를위한 설…</td>
									<td>14.01.10</td>
								</tr>
								<tr>
									<td>연구장비 공동활용 지원사업 주관기관…</td>
									<td>14.02.06</td>
								</tr>
								<tr>
									<td>온라인 의뢰시험 접수 방법</td>
									<td>14.03.27</td>
								</tr>
							</tbody>
						</table>
						
					</div>
					<!-- ./자료실 -->

				
				</div>
				<!-- ./우측 공지,자료실 영역 -->

			</div>
			<!-- end row -->
