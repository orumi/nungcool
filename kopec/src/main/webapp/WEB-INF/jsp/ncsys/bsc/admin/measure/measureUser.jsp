<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<!-- VISION CONTENT -->
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
				<label class="control-label col-md-1" for="prepend" style="">사용자</label>
				<div class="col-md-5" style="padding-right: 1px;;">
	                <div class="icon-addon addon-md" >
	                    <div id="" style="width:100%;height:460px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table width="100%" style="border:1px solid #c1c1c1;" border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="table-layout:fixed">
	                    	<tr>
	                    	<td width="30%" class="nc_th" style="">
	                    		부서명
	                    	</td>
	                    	<td width="30%" class="nc_th" style="">
	                    		사용자
	                    	</td>
	                    	<td width="20%" class="nc_th" style="">
	                    		선택(정)
	                    	</td>
	                    	<td width="20%" class="nc_th" style="">
	                    		선택(부)
	                    	</td>
	                    	</tr>
	                    	<tr ng-repeat="users in entity.measureUsers">
	                    	<td width="30%" class="" style="">
	                    		<input type="text" class="form-control"  ng-model="users.deptnm"/>
	                    	</td>
	                    	<td width="30%" class="" style="">
	                    		<input type="text" class="form-control"  ng-model="users.username"/>
	                    	</td>
	                    	<td width="20%" class="" style="border: 1px solid #cccccc; text-align: center; background-color: #eaeaea;">
	                    		<button class="btn btn-default btn_padding_2" ng-click="addUpdater(users);" >추가</button>
	                    	</td>
	                    	<td width="20%" class="" style="border: 1px solid #cccccc; text-align: center; background-color: #eaeaea;">
	                    		<button class="btn btn-default btn_padding_2" ng-click="addAuthority(users);" >추가</button>
	                    	</td>
	                    	</tr>
	                    </table>
	                    </div>
	                </div>
				</div>
				<div class="form-group">
	            <fieldset>
	            <label class="control-label col-md-2" for="prepend" style="">담당자(정) </label>
	            <div class="col-md-8" style="padding-right: 1px;;">
	                <div class="icon-addon addon-md" >
						<div id="" style="width:100%;height:80px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table width="100%" style="border:1px solid #c1c1c1;" border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="table-layout:fixed">
	                    	<tr>
	                    	<td width="50%" class="nc_th" style="">
	                    		부서명
	                    	</td>
	                    	<td width="30%" class="nc_th" style="">
	                    		담당자
	                    	</td>
	                    	<td width="20%" class="nc_th" style="">
	                    		삭제
	                    	</td>
	                    	</tr>
	                    	<tr ng-repeat="updater in entity.measureUpdater">
	                    	<td width="50%" class="" style="">
	                    		<input type="text" class="form-control"  ng-model="updater.deptnm"/>
	                    	</td>
	                    	<td width="30%" class="" style="">
	                    		<input type="text" class="form-control"  ng-model="updater.username"/>
	                    	</td>
	                    	<td width="20%" class="" style="border: 1px solid #cccccc; text-align: center; background-color: #eaeaea;">
	                    		<button class="btn btn-default btn_padding_2" ng-click="delUpdater(updater);" >삭제</button>
	                    	</td>

	                    	</tr>
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
						<table width="100%" style="border:1px solid #c1c1c1;" border="0" cellspacing="1" cellpadding="0" class="bg_gray01" style="table-layout:fixed">
	                    	<tr>
	                    	<td width="50%" class="nc_th" style="">
	                    		부서명
	                    	</td>
	                    	<td width="30%" class="nc_th" style="">
	                    		담당자
	                    	</td>
	                    	<td width="20%" class="nc_th" style="">
	                    		삭제
	                    	</td>
	                    	</tr>
	                    	<tr ng-repeat="authority in entity.measureDefine.authority">
	                    	<td width="50%" class="" style="">
	                    		<input type="text" class="form-control"  ng-model="authority.deptnm"/>
	                    	</td>
	                    	<td width="30%" class="" style="">
	                    		<input type="text" class="form-control"  ng-model="authority.username"/>
	                    	</td>
	                    	<td width="20%" class="" style="border: 1px solid #cccccc; text-align: center; background-color: #eaeaea;">
	                    		<button class="btn btn-default btn_padding_2" ng-click="delAuthority(authority);" >삭제</button>
	                    	</td>

	                    	</tr>
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
						<a ng-click="closeMeasureUser()"  class="btn btn-default pull-right" style="padding: 6px 18px; margin: 0px 2px;">닫기</a>
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
