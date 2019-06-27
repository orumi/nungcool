<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%
	LoginUserVO nLoginVO = (LoginUserVO)session.getAttribute("loginUserVO");
%>        
<script>
	var historyView;
	var historyProvider;
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
		RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	   	historyProvider = new RealGridJS.LocalDataProvider();
		historyView = new RealGridJS.GridView("historygrid");
	    historyView.setDataSource(historyProvider);
	    
	    //의뢰승인요청 팝업 그리드 (왼쪽) 
		   var fields = [
				{fieldName: "rltcnt"},
				{fieldName: "reportprice"},
				{fieldName: "pricechargetype"},
				{fieldName: "pricedate"},
				{fieldName: "reqstate"},
				{fieldName: "pricechargetypenm"},
				{fieldName: "taxcompany"},
				{fieldName: "apprstatenm"},
				{fieldName: "mngphone"},
				{fieldName: "signappr"},
				{fieldName: "statenm"},
				{fieldName: "smpcnt"},
				{fieldName: "memname"},
				{fieldName: "pricetype"},
				{fieldName: "pricetypenm"},
				{fieldName: "reqid"},
				{fieldName: "comname"},
				{fieldName: "requestcdate"},
				{fieldName: "taxissuedate"},
				{fieldName: "receiptdate"},
				{fieldName: "issuedatecmpl"}
		    ];
		    
		    var columns = [
	    		{
	    			name: "comname",
	    			fieldName: "comname",
	    			header : {
	    				text: "업체명"
	    			},
	    			width: 200
	    		},
	    		{
	    			name: "memname",
	    			fieldName: "memname",
	    			header : {
	    				text: "신청자"
	    			},
	    			width: 100
	    		},
	    		{
	    			name: "mngphone",
	    			fieldName: "mngphone",
	    			header : {
	    				text: "전화번호"
	    			},
	    			width: 100
	    		},
	    		{
	    			name: "smpcnt",
	    			fieldName: "cmpcnt",
	    			header : {
	    				text: "시료건수"
	    			},
	    			width: 100
	    		},
	    		{
	    			name: "rltcnt",
	    			fieldName: "rltcnt",
	    			header : {
	    				text: "항목건수"
	    			},
	    			width: 100
	    		},
	    		{
	    			name: "receiptdate",
	    			fieldName: "receiptdate",
	    			header : {
	    				text: "접수일"
	    			},
	    			width: 100
	    		},
	    		{
	    			name: "issuedatecmpl",
	    			fieldName: "issuedatecmpl",
	    			header : {
	    				text: "발송일"
	    			},
	    			width: 100
	    		}
		    ];
	    
	    
	    ////////////////////컬럼 셋팅 끝////////////////////
	    
	    historyProvider.setFields(fields);
	    historyView.setColumns(columns);
	    
	    historyView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	display : { fitStyle : "evenFill" }
	    });
	    
	    historyView.setHeader({
	    	height: 35
	    }); 
	    
	    
	    historyView.setStyles(smart_style);
	    
	    ////////////////////////////////////
	    
	});
	
	function selReqComHistoryModal(reqid){
		alert(reqid);
		$("#reqComHistoryModal").modal();
		$("#reqComHistoryModal").on('shown.bs.modal', function () {
			historyView.resetSize();
    	});
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"reqid":reqid},
            url: "<c:url value='/exam/req/selRequestHistory.json'/>",
            success: function (data) {
                historyProvider.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	
            },
            cache: false
        });
	}
</script>


<!-- 의뢰승인요청 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="reqComHistoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
	        <h4 class="modal-title" id="myModalLabel">접수이력정보</h4>
	      </div>
	      <div class="modal-body requestBody">
	      	<div style="width:100%;float:left;">
				<div id="historygrid" style="width: 850px; height: 600px;"></div>
			</div>
	      </div>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	  
<!-- end of modal  -->
</div>