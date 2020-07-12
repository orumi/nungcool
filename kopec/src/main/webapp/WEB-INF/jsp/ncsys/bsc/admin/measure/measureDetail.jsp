<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<!-- VISION CONTENT -->
					<div class="popup">

					<form class="form-horizontal" id="form_detail" name="form_detail" style="padding:10px;" >
					<section id="widget-yield" class="" >
						<div class="row">
				<!-- NEW WIDGET START -->
				<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="jarviswidget" id="wid-id-1" >
						<header>
							<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
							<h2>지표정의서</h2>
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
						<label class="control-label col-md-1" for="prepend" style="">관점</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <select type="text" class="form-control"  ng-model="entity.measureDefine.pcid">
								<option ng-repeat="option in entity.pst" value="{{option.id}}">{{option.name}} [{{option.id}}]</option>
			                    </select>
			                </div>
			            </div>
			            <label class="control-label col-md-1" for="prepend" style="">전략목표</label>
			            <div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <select type="text" class="form-control"  ng-model="entity.measureDefine.ocid">
			                    <option ng-repeat="option in entity.object" value="{{option.id}}">{{option.name}} [{{option.id}}]</option>
			                    </select>
			                </div>
			            </div>
			        </div>
			        <div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">성과지표</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <select class="form-control" id="selMapImages" ng-model="entity.measureDefine.measureid" >
									<option ng-repeat="option in entity.measure" value="{{option.id}}">{{option.name}} [{{option.id}}]</option>
								</select>
			                </div>
			            </div>
			            <label class="control-label col-md-1" for="prepend" style="">ETLKEY</label>
						<div class="col-md-4" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                	<input type="text" class="form-control"  ng-model="entity.measureDefine.etlkey"/>
			                </div>
			            </div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">지표정의</label>
						<div class="col-md-9" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <input type="text" class="form-control"  ng-model="entity.measureDefine.mean"/>
			                </div>
			            </div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">세부설명</label>
						<div class="col-md-9" style="padding-right: 1px;;">
			                <div class="icon-addon addon-md" >
			                    <textarea type="text" rows="4" class="form-control"  ng-model="entity.measureDefine.detaildefine">
			                    </textarea>
			                </div>
			            </div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-1" for="prepend" style="">점수등급</label>
						<div class="col-md-7" style="padding-right: 1px;">
			                <div class="icon-addon addon-md" >
			                    <table width="100%" style="border:1px solid #c1c1c1;" border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="table-layout:fixed">
			                    	<tr>
			                    	<td width="10%" class="nc_th" style="">
			                    		S(100)
			                    	</td>
			                    	<td width="10%" class="nc_th" style="">
			                    		A+(95)
			                    	</td>
			                    	<td width="10%" class="nc_th" style="">
			                    		A(90)
			                    	</td>
			                    	<td width="10%" class="nc_th" style="">
			                    		B+(85)
			                    	</td>
			                    	<td width="10%" class="nc_th" style="">
			                    		B(80)
			                    	</td>
			                    	<td width="10%" class="nc_th" style="">
			                    		C+(75)
			                    	</td>
			                    	<td width="10%" class="nc_th" style="">
			                    		C(70)
			                    	</td>
			                    	<td width="10%" class="nc_th" style="">
			                    		D+(65)
			                    	</td>
			                    	<td width="10%" class="nc_th" style="">
			                    		D(60)
			                    	</td>

			                    	</tr>
			                    	<tr >
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.planned"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.plannedBasePlus"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.plannedBase"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.basePlus"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.base"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.baseLimitPlus"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.baseLimit"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.limitPlus"/>
			                    	</td>
			                    	<td width="10%" class="" style="">
			                    		<input type="text" class="form-control"  ng-model="entity.measureDefine.limit"/>
			                    	</td>
			                    	</tr>
			                    </table>
			                </div>
			            </div>
			            <div class="col-md-1" style="padding-right: 1px;">
			            	<div class="icon-addon addon-md" >
			            	등급구간
			                    <select type="text" class="form-control"  ng-model="entity.measureDefine.equationType">
			                    	<option value="A" selected>직접입력</option>
			                    	<option value="B">비계량</option>
			                    	<option value="C">계량 일반</option>
			                    	<option value="D">계량 5점</option>
			                    	<option value="E">계량 3~4점</option>
			                    	<option value="F">계량 105점</option>
			                    	<option value="G">계량 95점</option>
			                    </select>
			                </div>
			            </div>
			            <div class="col-md-1" style="padding-right: 1px;">
			            	<div class="icon-addon addon-md" >
			            	목표
			                    <select type="text" class="form-control"  ng-model="entity.measureDefine.plannedFlag">
			                    	<option value="U">구간이상</option>
			                    	<option value="O">구간초가</option>
			                    </select>
			                </div>
			            </div>
					</div>
				</fieldset>

					<div class="row">
					<div class="col-md-6">

					<header style="border-top:1px solid #c1c1c1;margin-top: 26px;padding-top: 8px;">지표산식</header>
					<legend style="padding: 5px 0;"></legend>
					<fieldset>
						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">한글산식</label>
							<div class="col-md-9" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  ng-model="entity.measureDefine.equationdefine"/>
				                </div>
				            </div>
				        </div>
				        <div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">실적산식</label>
							<div class="col-md-9" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  ng-model="entity.measureDefine.equation"/>
				                </div>
				            </div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">산식항목</label>
							<div class="col-md-9" style="padding-right: 1px;;">
				                <div class="icon-addon addon-md" >
				                    <div id="res" style="width:100%;height:160px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
									<table width="100%" style="border:1px solid #c1c1c1;" border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="table-layout:fixed">
				                    	<tr>
				                    	<td width="20%" class="nc_th" style="">
				                    		항목코드
				                    	</td>
				                    	<td width="60%" class="nc_th" style="">
				                    		항목명
				                    	</td>
				                    	<td width="10%" class="nc_th" style="">
				                    		계획
				                    	</td>
				                    	<td width="10%" class="nc_th" style="">
				                    		삭제
				                    	</td>
				                    	</tr>
				                    	<tr ng-repeat="option in entity.measureDefine.items">
				                    	<td width="20%" class="" style="">
				                    		<input type="text" class="form-control"  ng-model="option.code"/>
				                    	</td>
				                    	<td width="60%" class="" style="">
				                    		<input type="text" class="form-control"  ng-model="option.itemname"/>
				                    	</td>
				                    	<td width="10%" class="" style="">
				                    		<select type="text" class="form-control"  ng-model="option.itemfixed">
				                    			<option value='N'>N</option>
				                    			<option value='Y'>Y</option>
				                    		</select>
				                    	</td>
				                    	<td width="10%" class="" style="border: 1px solid #cccccc; text-align: center; background-color: #eaeaea;">
				                    		<button class="btn btn-danger" ng-click="actionItemDel(option);" >X</button>
				                    	</td>
				                    	</tr>
				                    </table>
				                    </div>
				                </div>
				            </div>
						</div>


						<div class="form-group">
							<div class="col-md-11" style="padding-right: 1px;">
				            <!-- <a ng-click=""  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;float:right;">추가</a>
				            <a ng-click=""  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;float:right;">수정</a> -->
				            <a ng-click="actionItemAdd();"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;float:right;">추가</a>
				            </div>
						</div>
					</fieldset>

					</div>
					<div class="col-md-6">

					<header style="border-top:1px solid #c1c1c1;margin-top: 26px;padding-top: 8px;">지표속성</header>
					<legend style="padding: 5px 0;"></legend>
					<fieldset style="padding-right:20px;">
						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">측정유형</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;">
				                <div class="icon-addon addon-md" >
				                    <select type="text" class="form-control"  ng-model="entity.measureDefine.measurement">
				                    	<option value="계량">계량</option>
				                    	<option value="비계량">비계량</option>
				                    </select>
				                </div>
				            </div>
				            <label class="control-label col-md-2" for="prepend" style="">방향성</label>
				            <div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <select type="text" class="form-control"  ng-model="entity.measureDefine.trend">
				                    	<option value="상향">상향</option>
				                    	<option value="하향">하향</option>
				                    </select>
				                </div>
				            </div>
				            <label class="control-label col-md-2" for="prepend" style="">측정주기</label>
				            <div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <select type="text" class="form-control"  ng-model="entity.measureDefine.frequency">
				                    	<option value="월">월</option>
				                    	<option value="분기">분기</option>
				                    	<option value="반기">반기</option>
				                    	<option value="년">년</option>
				                    </select>
				                </div>
				            </div>
				        </div>
				        <!-- <div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">평가주기</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <select class="form-control"  ng-model="entity.measureDefine.eval_frq">
				                    	<option value="월">월</option>
				                    	<option value="분기">분기</option>
				                    	<option value="반기">반기</option>
				                    	<option value="년">년</option>
				                    </select>
				                </div>
				            </div>
				            <label class="control-label col-md-2" for="prepend" style="">적용방식</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <select class="form-control"  ng-model="entity.measureDefine.evalmethod">
				                    	<option value="현재값">현재값</option>
				                    	<option value="평균값">평균값</option>
				                    	<option value="누적값">누적값</option>
				                    </select>
				                </div>
				            </div>
						</div> -->
						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">가중치</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  ng-model="entity.measureDefine.weight" />
				                </div>
				            </div>
				            <label class="control-label col-md-2" for="prepend" style="">측정단위</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <input type="text" class="form-control"  ng-model="entity.measureDefine.unit" />
				                </div>
				            </div>
						</div>
<!-- 										<div class="form-group">
											<label class="control-label col-md-2" for="prepend" style="">목표</label>
											<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
								                <div class="icon-addon addon-md" >
								                    <input type="text" class="form-control"  ng-model="entity.measureDefine.planned" />
								                </div>
								            </div>
								            <label class="control-label col-md-2" for="prepend" style="">기준</label>
											<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
								                <div class="icon-addon addon-md" >
								                    <input type="text" class="form-control"  ng-model="entity.measureDefine.base" />
								                </div>
								            </div>
								            <label class="control-label col-md-2" for="prepend" style="">하한</label>
											<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
								                <div class="icon-addon addon-md" >
								                    <input type="text" class="form-control"  ng-model="entity.measureDefine.limit" />
								                </div>
								            </div>
										</div> -->


						<div class="form-group">
							<label class="control-label col-md-2" for="prepend" style="">담당자(정)</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                	<div class="icon-addon addon-md" >
									<div id="res" style="width:100%;height:60px;overflow-y:auto; overflow-x: hidden">
									<table width="100%" style="" border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="table-layout:fixed">
				                    	<tr ng-repeat="selUdater in entity.measureUpdater">
				                    	<td width="100%" class="nc_auth" style="">
				                    		{{selUdater.username}}
				                    	</td>
				                    	</tr>
				                    </table>
				                    </div>
				                </div>
				            </div>
				            <label class="control-label col-md-2" for="prepend" style="">담당자(부)</label>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                   <div id="res" style="width:100%;height:120px;overflow-y:auto; overflow-x: hidden">
									<table width="100%" style="" border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="table-layout:fixed">
				                    	<tr ng-repeat="selUdater in entity.measureDefine.authority">
				                    	<td width="100%" class="nc_auth" style="">
				                    		{{selUdater.username}}
				                    	</td>
				                    	</tr>
				                    </table>
				                    </div>
				                </div>
				            </div>
							<div class="col-md-2" style="padding-right: 1px;padding-left: 4px;;">
				                <div class="icon-addon addon-md" >
				                    <a id="btn_delete_map" class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="openMeasureUser();">담당자</a>
				                </div>
				            </div>
						</div>


					</fieldset>
					</div>
					<!-- // end of row -->
					</div>

					<fieldset style="margin-bottom: 20px;">
						<div class="form-group">
						   	<div id="buttonContent" style="width:100%;padding-right:20px;">
								<a ng-click="closeProperties()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>

								<a id="btn_delete_measure" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('deleteMeasure');">삭제</a>

								<a id="btn_adjust_measure" class="btn btn-primary pull-right" style="padding: 6px 18px; margin: 0px 2px;" ng-click="actionPerformed('adjustMeasure');">저장</a>

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

    <script type="text/javascript">


    </script>
