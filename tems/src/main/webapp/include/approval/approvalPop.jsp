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
		$(document).ready( function(){
    		$("#reqConfModal").on('shown.bs.modal', function () {
    			selModal();
    			apprView3.resetSize();
            	apprView4.resetSize();
        	});		
    		
    		$("#userInfofModal").on('shown.bs.modal', function () {
				apprView5.resetSize();
				apprView6.resetSize();
    		});
		});
</script>
<script>
	var apprView3;
	var apprProvider3;
	var apprView4;
	var apprProvider4;
	var apprView5;
	var apprProvider5;
	var apprView6;
	var apprProvider6;
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
		RealGridJS.setRootContext("<c:url value='/script'/>");

	   	apprProvider3 = new RealGridJS.LocalDataProvider();
	    apprProvider4 = new RealGridJS.LocalDataProvider();
	    
	    apprProvider5 = new RealGridJS.LocalTreeDataProvider();
	    apprProvider6 = new RealGridJS.LocalDataProvider();
	    
		apprView3 = new RealGridJS.GridView("realappr3");
	    apprView4 = new RealGridJS.GridView("realappr4");
	    
	    apprView5 = new RealGridJS.TreeView("realappr5");
	    apprView6 = new RealGridJS.GridView("realappr6");
	    
	    apprView3.setDataSource(apprProvider3);
	    apprView4.setDataSource(apprProvider4);
	    
	    apprView5.setDataSource(apprProvider5);
	    apprView6.setDataSource(apprProvider6);
	    
	    //의뢰승인요청 팝업 그리드 (왼쪽) 
		   var fields3 = [
				{fieldName: "apprlineid"},
				{fieldName: "draftid"},
				{fieldName: "apprid"},
				{fieldName: "ordinal"},
				{fieldName: "apprnm"},
				{fieldName: "regid"},
				{fieldName: "regdate"},
				{fieldName: "modifyid"},
				{fieldName: "modifydate"}
		    ];
		    
		    var columns3 = [
	    		{
	    			name: "apprnm",
	    			fieldName: "apprnm",
	    			header : {
	    				text: "결재정보"
	    			},
	    			width: 100
	    		},
	    		{
	    			name: "",
	    			fieldName: "",
	    			header : {
	    				text: "삭제"
	    			},
	    			width: 35
	    		}
		    ];
	    
	    
	  //의뢰승인요청 팝업 그리드 (오른쪽)
	   var fields4 = [
				{fieldName: "apprlineid"},
				{fieldName: "draftid"},
				{fieldName: "draftnm "},
				{fieldName: "fst"},
				{fieldName: "fstapprid"},
				{fieldName: "snd"},
				{fieldName: "sndapprid"},
				{fieldName: "trd "},
				{fieldName: "trdapprid"},
				{fieldName: "fth"},
				{fieldName: "fthapprid"}
	    ];
	    
	    var columns4 = [
			 {
    			name: "draftnm",
    			fieldName: "draftnm",
    			header : {
    				text: "기안자"
    			},
    			width: 90
    		},
    		{
    			name: "fst",
    			fieldName: "fst",
    			header : {
    				text: "1차승인"
    			},
    			button: "action",
    	        styles: {
    	            "textAlignment": "center"
    	        },
    	        buttonVisibility : "always",
    			width: 90
    		},
    		{
    			name: "snd",
    			fieldName: "snd",
    			header : {
    				text: "2차승인"
    			},
    			button: "action",
    	        styles: {
    	            "textAlignment": "center"
    	        },
    	        buttonVisibility : "always",
    			width: 90
    		},
    		{
    			name: "trd",
    			fieldName: "trd",
    			header : {
    				text: "3차승인"
    			},
    			button: "action",
    	        styles: {
    	            "textAlignment": "center"
    	        },
    	        buttonVisibility : "always",
    			width: 90
    		},
    		{
    			name: "fth",
    			fieldName: "fth",
    			header : {
    				text: "4차승인"
    			},
    			button: "action",
    	        styles: {
    	            "textAlignment": "center"
    	        },
    			buttonVisibility : "always",
    			width: 90
    		}
	    ]; 
	    
	    
	    var fields5 = [
   			{fieldName: "treeview"}
   		   ,{fieldName: "officeid"}
   	       ,{fieldName: "name"}
   	       ,{fieldName: "uppofficeid"}
   	       ,{fieldName: "uppname"}
   	    ];

   	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
   	    var columns5 = [
   			{
   	            name: "name", 
   	            fieldName: "name", 
   	            header : { text: "부서명" },
   	            width : 150,
   	            readOnly : "true"	                       
   	        }
   	    ];
   	    
   	    
   		 var fields6 = [
   	 			{fieldName: "adminid"}
   	 			,{fieldName: "officeid"}
   	 			,{fieldName: "authorgpcode"}
   	 			,{fieldName: "name"}
   	 			,{fieldName: "adminpw"}
   	 			,{fieldName: "uppofficeid"}
   	 			,{fieldName: "empid"}
   	 			,{fieldName: "ename"}
   	 			,{fieldName: "useflag"}
   	 	    ];
   	 	    
   	 	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
   	 	    var columns6 = [
   	 			{
   	 	            name: "name", 
   	 	            fieldName: "name", 
   	 	            header : { text: "이름" },
   	 	            width : 350,
   	 	            readOnly : "true"	 
   	 	        },
   	 	        {
   	 	            name: "umjpname", 
   	 	            fieldName: "umjpname", 
   	 	            header : { text: "직위" },
   	 	            width : 350,
   	 	            readOnly : "true"	 
   	 	        },
   	 	        {
   	 	            name: "umjdname", 
   	 	            fieldName: "umjdname", 
   	 	            header : { text: "직책" },
   	 	            width : 350,
   	 	            readOnly : "true"	 
   	 	        }
   	 	    ];
	    
	    ////////////////////컬럼 셋팅 끝////////////////////
	    
	    apprProvider3.setFields(fields3);
	    apprView3.setColumns(columns3);
	    
	    apprProvider4.setFields(fields4);
	    apprView4.setColumns(columns4);
	    
	    apprProvider5.setFields(fields5);
	    apprView5.setColumns(columns5);
	    
	    apprProvider6.setFields(fields6);
	    apprView6.setColumns(columns6);
	    
	    
	    
	    apprView4.setDisplayOptions({rowHeight: 125})
	    
	    apprView3.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	display : { fitStyle : "evenFill" }
	    });
	    
	    apprView4.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	edit : {
	    		deletable: true,
	    		appendable : true
	    	},
	    	display : { fitStyle : "evenFill" }
	    }); 
	    
	    
	    apprView5.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    apprView6.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    
	    apprView3.setHeader({
	    	height: 35
	    }); 
	    
	    /* 헤더의 높이를 지정*/
	    apprView4.setHeader({
	    	height: 35
	    }); 
	    
	    apprView3.setStyles(smart_style);
	    apprView4.setStyles(smart_style);
	    apprView5.setStyles(smart_style);
	    apprView6.setStyles(smart_style);
	    
	    ////////////////////////////////////
	    
	    apprView3.onDataCellClicked =  function (appr, index) {
	    	apprlineid = apprView3.getValue(index.dataRow, "apprlineid");
	    	
	    	$.ajax({
				type : "post",
			    dataType : "json",
			    data : {"apprlineid":apprlineid},
	            url: "<c:url value='/exam/req/getApprDetail.json'/>",
	            success: function (data) {
	                apprProvider4.fillJsonData(data);
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            },
	            complete: function (data) {
	            	//apprView.hideToast();
	            },
	            cache: false
	        });
	    };
	     
	    
	    var selcolumn;
	    apprView4.onCellButtonClicked = function (appr, itemIndex, column) {
	        	selcolumn = column.fieldName;
	        	
	        	if(selcolumn == "fst"){
	        		$("#myModalLabel4").text("1차 결재자 선택");
		    	} else if(selcolumn == "snd"){
		    		$("#myModalLabel4").text("2차 결재자 선택");
		    	} else if(selcolumn == "trd"){
		    		$("#myModalLabel4").text("3차 결재자 선택");
		    	} else if(selcolumn == "fth"){
		    		$("#myModalLabel4").text("4차 결재자 선택");
		    	} 
	        	
	        	
	        
				$("#userInfofModal").modal('show');
				
					
				$.ajax({
					type : "post",
				    dataType : "json",
		            url: "<c:url value='/system/selOfficeList.json'/>",
		            success: function (data) {
		                apprProvider5.setRows(data,"treeview", true, "", "");
		            },
		            error:function(request,status,error){
		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		            },
		            complete: function (data) {
		            	apprView5.expandAll();
		            	var options = {
		    			        fields:['name'],
		    			        values:['<%=nLoginVO.getOfficenm()%>']
		    			    }
	    			    var itemindex = apprView5.searchItem(options);
	                	
	                	apprView5.setCurrent({itemIndex:itemindex, column:"name"});
	                	fnGetUserList(itemindex);
		            },
		            cache: false
		        });
				
	    };
	    
	    apprView5.onDataCellClicked =  function (appr, index) {
	    	fnGetUserList(index.itemIndex);
	    };
	    
	    
	    apprView6.onDataCellClicked =  function (appr, index) {
	    	if(selcolumn == "fst"){
	    		apprView4.setValue(0, "fstapprid", apprView6.getValue(index.itemIndex,"adminid"));
		    	apprView4.setValue(0, "fst", apprView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "snd"){
	    		apprView4.setValue(0, "sndapprid", apprView6.getValue(index.itemIndex,"adminid"));
		    	apprView4.setValue(0, "snd", apprView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "trd"){
	    		apprView4.setValue(0, "trdapprid", apprView6.getValue(index.itemIndex,"adminid"));
		    	apprView4.setValue(0, "trd", apprView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "fth"){
	    		apprView4.setValue(0, "fthapprid", apprView6.getValue(index.itemIndex,"adminid"));
		    	apprView4.setValue(0, "fth", apprView6.getValue(index.itemIndex,"name"));
	    	} 
	    	$("#userInfofModal").modal('hide');
	    };
	    
	    
	});
	
	function fnGetUserList(index){
		var officeid = apprView5.getValue(index, "officeid");
    	$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"officeid":officeid},
            url: "<c:url value='/system/selOfficeUserList.json'/>",
            success: function (data) {
                apprProvider6.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	
            },
            cache: false
        });
	}
	
	function selModal(){
		$.ajax({
			type : "post",
		    dataType : "json",
            url: "<c:url value='/exam/req/getApprList.json'/>",
            success: function (data) {
                apprProvider3.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	
            },
            cache: false
        });
	}
	
	function saveDataModal(urlStr,data) {
	    $.ajax({
	        url : urlStr,
	        type : "post",
	        data : data,
	        dataType : "json",
	        success : function(data) {
	            if (data.RESULT_YN =="Y") {
	            	alert("정상 처리 되었습니다.");
	                apprProvider4.clearRowStates(true, true);
	                selModal();
	            } else {
	                alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	            }
	        },
	        error : function(request, status, error) {
	            alert("code:" + request.status + "\n" + "error:" + error);
	        }
	    });
	}
	
	function fnCancelAppr(){
		apprView4.deleteSelection(true);
	}
	
	function fnAddRow(){
		apprView4.deleteSelection(true);
		var gcnt = apprView4.getItemCount();
		if(gcnt < 1){
			apprView4.beginAppendRow();
			apprView4.setValues(0, {draftid:"<%=nLoginVO.getAdminid()%>",draftnm:"<%=nLoginVO.getName()%>"})
		}
	}
	
	function fnApprUserSave(){

		apprView4.commit();	
		
		var state;
	    var jData;
	    var jRowsData = [];

	    var rows = apprProvider4.getAllStateRows();
	    
	    if(rows.updated.length > 0){
	    	if(apprView4.getValue(rows.updated[0], "fstapprid") != null){
	            jData = {
	                "draftid": apprView4.getValue(rows.updated[0], "draftid"),
	                "apprid": apprView4.getValue(rows.updated[0], "fstapprid"),
	                "ordinal": "1"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(apprView4.getValue(rows.updated[0], "sndapprid") != null){
	            jData = {
	                "draftid": apprView4.getValue(rows.updated[0], "draftid"),
	                "apprid": apprView4.getValue(rows.updated[0], "sndapprid"),
	                "ordinal": "2"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(apprView4.getValue(rows.updated[0], "trdapprid") != null){
	            jData = {
	                "draftid": apprView4.getValue(rows.updated[0], "draftid"),
	                "apprid": apprView4.getValue(rows.updated[0], "trdapprid"),
	                "ordinal": "3"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(apprView4.getValue(rows.updated[0], "fthapprid") != null){
	            jData = {
	                "draftid": apprView4.getValue(rows.updated[0], "draftid"),
	                "apprid": apprView4.getValue(rows.updated[0], "fthapprid"),
	                "ordinal": "4"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}	   
	    }

	    if(rows.created.length > 0){
	    	
	    	if(apprView4.getValue(rows.created[0], "fstapprid") != null){
	            jData = {
	                "draftid": apprView4.getValue(rows.created[0], "draftid"),
	                "apprid": apprView4.getValue(rows.created[0], "fstapprid"),
	                "ordinal": "1"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(apprView4.getValue(rows.created[0], "sndapprid") != null){
	            jData = {
	                "draftid": apprView4.getValue(rows.created[0], "draftid"),
	                "apprid": apprView4.getValue(rows.created[0], "sndapprid"),
	                "ordinal": "2"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(apprView4.getValue(rows.created[0], "trdapprid") != null){
	            jData = {
	                "draftid": apprView4.getValue(rows.created[0], "draftid"),
	                "apprid": apprView4.getValue(rows.created[0], "trdapprid"),
	                "ordinal": "3"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(apprView4.getValue(rows.created[0], "fthapprid") != null){
	            jData = {
	                "draftid": apprView4.getValue(rows.created[0], "draftid"),
	                "apprid": apprView4.getValue(rows.created[0], "fthapprid"),
	                "ordinal": "4"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}	    	
                           
	    }
	    
	    
	    var val = JSON.stringify(jRowsData);
	    var data = {"data":val};
	    if(confirm("변경된 내용을 저장하시겠습니까?")){
	    	
	    	saveDataModal("<c:url value='/exam/req/edtApprLine.json'/>",data);	
	    }
	}
	
	function fnApprConf(){
		apprView4.commit();
		var reqid = "${reqDetail.reqid}";
		
		var state;
	    var jData;
	    var jRowsData = [];
	    
    	if(apprView4.getValue(0, "fstapprid") != null){
            jData = {
                "draftid": apprView4.getValue(0, "draftid"),
                "apprid": apprView4.getValue(0, "fstapprid"),
                "ordinal": "1"
            }
            jData.reqid = reqid;
            jRowsData.push(jData);
    	}
    	
    	if(apprView4.getValue(0, "sndapprid") != null){
            jData = {
                "draftid": apprView4.getValue(0, "draftid"),
                "apprid": apprView4.getValue(0, "sndapprid"),
                "ordinal": "2"
            }
            jData.reqid = reqid;
            jRowsData.push(jData);
    	}
    	
    	if(apprView4.getValue(0, "trdapprid") != null){
            jData = {
                "draftid": apprView4.getValue(0, "draftid"),
                "apprid": apprView4.getValue(0, "trdapprid"),
                "ordinal": "3"
            }
            jData.reqid = reqid;
            jRowsData.push(jData);
    	}
    	
    	if(apprView4.getValue(0, "fthapprid") != null){
            jData = {
                "draftid": apprView4.getValue(0, "draftid"),
                "apprid": apprView4.getValue(0, "fthapprid"),
                "ordinal": "4"
            }
            jData.reqid = reqid;
            jRowsData.push(jData);
    	}	   
	        	
		if (jRowsData.length == 0) {
	    	alert("선택된 내용이 없습니다.");
	        apprProvider.clearRowStates(true);
	        return;
	    }
	    
	    var val = JSON.stringify(jRowsData);
	    var data = {"data":val};
	    
	    if(confirm("결재 요청 하시겠습니까?")){
	    	
	    	saveDataConfirm("<c:url value='/exam/req/inApprConf.json'/>",data);	
	    }
	    
	}
</script>


<!-- 의뢰승인요청 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="reqConfModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
	        <h4 class="modal-title" id="myModalLabel">결재정보</h4>
	      </div>
	      <div class="modal-body requestBody">
	      	<div style="width:30%;float:left;">
				<div id="realappr3" style="width: 260px; height: 200px;"></div>
			</div>
			<div style="width: 50;height: 100%; display: table; float:left; margin:0 16px;">
				<div style="display: table-cell;vertical-align: middle;">
					<br><br>
					<p style="padding:6px;">
						<a href="javascript:fnCancelAppr();" class="btn btn-default"><i class="glyphicon glyphicon-chevron-left"></i></a>
					</p>
					
				</div>
			</div>
			<div  style="width: 516px; float:left;">
			<a href="javascript:fnAddRow();" class="btn btn-default pull-right" style="margin-bottom: 2px; margin-left: 2px; ">신규</a>
			<a href="javascript:fnApprUserSave();" class="btn btn-default pull-right">결재정보저장</a>
				<div id="realappr4" style="width:516px; height: 166px;"></div>
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" onclick="fnApprConf()">결재 요청</button>
	      </div>
	    </div>
	  </div>
	  
<!-- end of modal  -->
</div>


<!-- 의뢰승인요청 결재자선택 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="userInfofModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog modal-lg" role="document" style="top: 150px; height: 300px;">
	    <div class="modal-content" style="height: inherit;">
	      <div class="modal-header">
	        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
	        <h4 class="modal-title" id="myModalLabel4">결재자선택</h4>
	      </div>
	      <div class="modal-body requestBody">
	      	<div style="width:60%;float:left;">
				<div id="realappr5" style="width: 520px; height: 200px;"></div>
			</div>
			<div style="width: 50;height: 100%; display: table; float:left; margin:0 16px;">
				<div style="display: table-cell;vertical-align: middle;">
					<p>
						&nbsp;
					</p>
				</div>
			</div>
			<div  style="width: 286px; float:left;">
				<div id="realappr6" style="width:286px; height: 200px;"></div>
			</div>
	      </div>
	    </div>
	  </div>
	  
<!-- end of modal  -->
</div>