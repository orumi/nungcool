<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
%>

		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/jquery.jqGrid.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/plugin/jqgrid/grid.locale-en.min.js'/>"></script>
		
		<script type="text/javascript">
		var regulationDetialInfoURL = "<c:url value='/hierarchy/regulationDetialInfo.json'/>";
		var regulationFieldURL = "<c:url value='/hierarchy/regulationField.json'/>";
		var regulationURL = "<c:url value='/hierarchy/regulation.json'/>";
		var versionURL = "<c:url value='/hierarchy/version.json'/>";
		
		var radarInforURL = "<c:url value='/main/radarInfor.json'/>";
		var plannedScheduleURL = "<c:url value='/main/plannedSchedule.json'/>";
		
		var commonCdURL = "<c:url value='/certification/commonCd.json'/>";
		
		</script>

 		<script src="<c:url value='/js/ajax/libs/angularjs/1.6.7/angular.min.js'/>"></script>
		<script src="<c:url value='/js/ncsys/isms/main/mainManageModule.js'/>"></script>


<script>

	function actionMenu(aObject){
		//console.log($(aObject).parent().parent().attr("planid"));
		parent.actionMenu("plannedSchedule", $(aObject).parent().parent().attr("planid"));
	}

</script>


<style>
<!--
	#sortable1 {
	    border-bottom: 1px solid #ececec;
	}
-->
</style>


	<!-- row -->
			<!-- MAIN CONTENT -->
			<div class="wrap"  style="padding: 14px;" id="mainMngApp" ng-app="mainMngApp" ng-controller="mainMngController">

				<div class="row">
					<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
						<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i> ISMS Admin <span> >> 운영현황</span></h1>
					</div>
					<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
						<ul id="sparks" class="">
							<li class="sparks-info">
								<h5 style="font-size:14px;margin:0px;text-align:right;width:100%;padding-right: 6px;"> 체계 버전 
								<span class="txt-color-blue" style="font-size:17px;"><i class="fa fa-check-circle-o"></i> 2</span></h5>
							</li>
							<li class="sparks-info">
								<h5 style="font-size:14px;margin:0px;text-align:right;width:100%;padding-right: 6px;"> 점검 분야 
								<span class="txt-color-blue" style="font-size:17px;"><i class="fa fa-check-circle-o"></i> 8</span></h5>
							</li>
							<li class="sparks-info">
								<h5 style="font-size:14px;margin:0px;text-align:right;width:100%;padding-right: 6px;"> 점검 통제
								<span class="txt-color-blue" style="font-size:17px;"><i class="fa fa-check-circle-o"></i> 447</span></h5>
							</li>
						</ul>
					</div>
				</div>
				<!-- widget grid -->
				<section id="widget-grid" class="">

					<!-- row1 -->
					<div class="row">
					
						<!-- article1   -->						
						<article class="col-sm-12 col-md-6 col-lg-6">

							<!-- new widget -->
							<div class="jarviswidget jarviswidget-color-blue" id="jwd-id-01" 
								data-widget-colorbutton="false" 
								data-widget-editbutton="false" 
								data-widget-togglebutton="false" 
								data-widget-fullscreenbutton="false" 
								data-widget-sortable="false" role="widget">
								<header>
									<span class="widget-icon"> <i class="fa fa-check txt-color-white"></i> </span>
									<h2> 운영일정 (계획) </h2>
								</header>
								<!-- widget div-->
								<div>
									<div class="widget-body no-padding smart-form" style="height:340px;overflow-y: auto">
									<div ng-repeat="planned in plannedSchedule">
									<div ng-if="planned.remaintype == 'INCOMPLETE'">
									<!-- 미완료   -->
										<div ng-if="planned.prnm == '1'">
										<h5 class="todo-group-title" style="color:red;font-weight: 400;"><i class="fa fa-exclamation"></i> 미완료 (<small class="num-of-tasks" style="color:red;">{{planned.pcnt}}</small>)</h5>
										</div>
										<ul id="sortable1" class="todo">
											<li planid={{planned.planid}} >
												<span class="handle"><i class="fa fa-check-square-o" style="font-size: 16px;padding: 6px 0;"> </i></span>
												<p>
													<strong>수행일자 : {{planned.plandt}}</strong> - {{planned.plantitle}}
													[<a href="#" onclick="javascript:actionMenu(this);" class="font-xs">상세정보</a>] 
													<span class="text-muted" style="font-size:14px; padding: 6px 0;">{{planned.plancontent}}</span>
													<span class="date" style="font-size: 11px;">기간일수 : {{planned.period}}일</span>
												</p>
											</li>
										</ul>
									</div>
									<div ng-if="planned.remaintype == 'LIMIT'">
									<!-- 임계일정   -->
										<div ng-if="planned.prnm == '1'">
										<h5 class="todo-group-title"><i class="fa fa-warning"></i> 임계일정 (<small class="num-of-tasks">{{planned.pcnt}}</small>)</h5>
										</div>
										<ul id="sortable1" class="todo">
											<li planid={{planned.planid}} >
												<span class="handle"><i class="fa fa-check-square-o" style="font-size: 16px;padding: 6px 0;"> </i></span>
												<p>
													<strong>수행일자 : {{planned.plandt}}</strong> - {{planned.plantitle}}
													[<a href="#" onclick="javascript:actionMenu(this);" class="font-xs">상세정보</a>] 
													<span class="text-muted" style="font-size:14px; padding: 6px 0;">{{planned.plancontent}}</span>
													<span class="date" style="font-size: 11px;">남은일수 : {{planned.remain}}일, 기간일수 : {{planned.period}}일</span>
												</p>
											</li>
										</ul>
									</div>
									<div ng-if="planned.remaintype == 'SCHEDULE'">
									<!-- 주요계획   -->
										<div ng-if="planned.prnm == '1'">
										<h5 class="todo-group-title"><i class="fa fa-exclamation"></i> 주요계획 (<small class="num-of-tasks">{{planned.pcnt}}</small>)</h5>
										</div>
										<ul id="sortable1" class="todo">
											<li planid={{planned.planid}} >
												<span class="handle"><i class="fa fa-check-square-o" style="font-size: 16px;padding: 6px 0;"> </i></span>
												<p>
													<strong>수행일자 : {{planned.plandt}}</strong> - {{planned.plantitle}}
													[<a href="#" onclick="javascript:actionMenu(this);" class="font-xs">상세정보</a>] 
													<span class="text-muted" style="font-size:14px; padding: 6px 0;">{{planned.plancontent}}</span>
													<span class="date" style="font-size: 11px;">남은일수 : {{planned.remain}}일, 기간일수 : {{planned.period}}일</span>
												</p>
											</li>
										</ul>
									</div>
									
									<div ng-if="planned.remaintype == 'COMPLETE'">
									<!-- 완료일정   -->
										<div ng-if="planned.prnm == '1'">
										<h5 class="todo-group-title"><i class="fa fa-check"></i> 완료일정 (<small class="num-of-tasks">{{planned.pcnt}}</small>)</h5>
										</div>
										<ul id="sortable1" class="todo">
											<li planid={{planned.planid}} >
												<span class="handle"><i class="fa fa-check-square-o" style="font-size: 16px;padding: 6px 0;"> </i></span>
												<p>
													<strong>수행일자 : {{planned.plandt}}</strong> - {{planned.plantitle}}
													[<a href="#" onclick="javascript:actionMenu(this);" class="font-xs">상세정보</a>] 
													<span class="text-muted" style="font-size:14px; padding: 6px 0;">{{planned.plancontent}}</span>
													<span class="date" style="font-size: 11px;">기간일수 : {{planned.period}}일</span>
												</p>
											</li>
										</ul>
									</div>
									
										
									</div>
										<!-- end content -->
									</div>

								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
						</article>	
						
						
						<!-- article2   -->						
						<article class="col-sm-12 col-md-6 col-lg-6">

							<!-- new widget -->
							<div class="jarviswidget" id="jwd-id-02" data-widget-togglebutton="false" data-widget-sortable="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2>분야별 ISMS 현황 </h2>
								</header>

								<!-- widget div-->
								<div class="no-padding">

									<div class="widget-body" style="padding-top: 12px;">
										<!-- content -->

											<fieldset style="margin-bottom: 10px;"> 
												<div class="form-group">
													<label class="control-label col-md-2" for="prepend" style="width:10%;padding-right: 1px;">년도</label>
													<div class="col-md-2" style="padding-right: 1px;padding-left:0px;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" style="height: 24px;" id="selYear" ng-model="selYear" ng-options="opt.value for opt in years" ng-change="selectRadarInfor();">
										                    </select>
										                </div>
										            </div>     
										            <label class="control-label col-md-2" for="prepend" style="width:10%;padding-right: 1px;">버전</label>
										            <div class="col-md-5" style="padding-right: 1px;padding-left:0px;">
										                <div class="icon-addon addon-md" >
										                    <select  class="form-control" style="height: 24px;" id="selVersion" ng-model="verid" ng-change="selectRadarInfor();">
										                    	<option ng-repeat="option in version" value="{{option.verid}}">{{option.vernm}}</option>
										                    </select>
										                    
										                </div>
										            </div>
										            <div class="col-md-2" style="padding-right: 1px;padding-left:0px;width:10%;">
										            	<a class="btn btn-default pull-right" style="padding: 2px 8px; margin: 0px 0px;" ng-click="selectRadarInfor();" >조회</a>
										            </div> 
												</div>
											</fieldset>
										<!-- this is what the user will see -->
										<div style="border-top: 1px solid #e4e4e4;padding-top: 6px; height:280px;overflow-y:auto">
										<canvas id="radarChart01" height="140px"></canvas>
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

					<!-- row2 -->
					<div class="row">

						<article class="col-sm-12 col-md-12 col-lg-12">
						<!-- new widget -->
							<div class="jarviswidget" id="jwd-id-11" data-widget-togglebutton="false" data-widget-sortable="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
								<header>
									<span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
									<h2> 수행현황 </h2>
								</header>
								<div role="content">
									<div class="widget-body">
										<div class="row" style="overflow-x:hidden; overflow-y:hidden;" >
											<iframe src="<c:url value='/actual/actualMain.do'/>" style="width:100%;height:400px;padding:0 8px;overflow:hidden;" scrolling="no" border="no" maginwidth="0" marginheight="0" frameborder="0" >
											</iframe>
										</div>
									</div>
								</div>
								
							</div>		
						
						
						</article>
					</div>	




					<!-- row3 -->
					<div class="row">

						<article class="col-sm-12 col-md-6 col-lg-6">

							<!-- new widget -->
							<div class="jarviswidget jarviswidget-color-blueDark" id="jwd-id-31" data-widget-sortable="false" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">

								

								<header>
									<span class="widget-icon"> <i class="fa fa-reorder txt-color-white"></i> </span>
									<h2> 자료실 </h2>
								</header>

								<div role="content">
									<div class="widget-body">
										<div class="row">
											<iframe src="<c:url value='/cop/bbs/selectBoardLatestList.do?bbsId=BBSMSTR_000000000006&bbsAttrbCode=BBSA03'/>" style="width:100%;height:250px;padding:0 8px;" frameborder="0">
											</iframe>
										</div>
									</div>
								</div>
							</div>
							<!-- end widget -->

						</article>

						<article class="col-sm-12 col-md-6 col-lg-6">
							<!-- new widget -->
							<div class="jarviswidget jarviswidget-color-blueDark" id="jwd-id-32" data-widget-sortable="false" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">

								

								<header>
									<span class="widget-icon"> <i class="fa fa-reorder txt-color-white"></i> </span>
									<h2> 공지사항 </h2>
								</header>

								<div role="content">
									<div class="widget-body">
										<div class="row">
											<iframe src="<c:url value='/cop/bbs/selectBoardLatestList.do?bbsId=BBSMSTR_000000000003&bbsAttrbCode=BBSA01'/>" style="width:100%;height:250px;padding:0 8px;" frameborder="0">
											</iframe>
										</div>
									</div>
								</div>
							</div>
							<!-- end widget -->


						</article>

					</div>

					<!-- end row -->

				</section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->
			
			

