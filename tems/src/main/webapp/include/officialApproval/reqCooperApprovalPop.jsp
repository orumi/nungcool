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
		$("#userCooperModal").on('shown.bs.modal', function () {
			cooperView5.resetSize();
			cooperView6.resetSize();
    	});
		
		$("#reqCooperModal").on('shown.bs.modal', function () {
			cooperView3.resetSize();
        	cooperView4.resetSize();
        	
        	resultView.resetSize();
        	resultView2.resetSize();
    	});
	});
</script>        
<script>
	var cooperView3;
	var cooperProvider3;
	var cooperView4;
	var cooperProvider4;
	var cooperView5;
	var cooperProvider5;
	var cooperView6;
	var cooperProvider6;
	
	var resultView;
	var resultView2;
	var resultProvider;
	var resultProvider2;
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
		RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    
	   	cooperProvider3 = new RealGridJS.LocalDataProvider();
	    cooperProvider4 = new RealGridJS.LocalDataProvider();
	    
	    cooperProvider5 = new RealGridJS.LocalTreeDataProvider();
	    cooperProvider6 = new RealGridJS.LocalDataProvider();
	    
	    resultProvider = new RealGridJS.LocalTreeDataProvider();
	    resultProvider2 = new RealGridJS.LocalTreeDataProvider();
	    
		cooperView3 = new RealGridJS.GridView("realcooper3");
	    cooperView4 = new RealGridJS.GridView("realcooper4");
	    
	    cooperView5 = new RealGridJS.TreeView("realcooper5");
	    cooperView6 = new RealGridJS.GridView("realcooper6");
	    
	    resultView = new RealGridJS.TreeView("resultGrid");
	    resultView2 = new RealGridJS.TreeView("resultGrid2");
	    
	    cooperView3.setDataSource(cooperProvider3);
	    cooperView4.setDataSource(cooperProvider4);
	    
	    cooperView5.setDataSource(cooperProvider5);
	    cooperView6.setDataSource(cooperProvider6);
	    
	    resultView.setDataSource(resultProvider);
	    resultView2.setDataSource(resultProvider2);
	    
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
   	 	    
		
   	 	 var resultfields = [
			{fieldName: "lvl"}
			,{fieldName: "itemid"}
			,{fieldName: "conitempid"}
			,{fieldName: "smpid"}
			,{fieldName: "unitid"}
			,{fieldName: "annotation"}
			,{fieldName: "itemname"}
			,{fieldName: "methodid"}
			,{fieldName: "itempid"}
			,{fieldName: "testnote"}
			,{fieldName: "itemvalue"}
			,{fieldName: "spec"}
			,{fieldName: "orderby"}
			,{fieldName: "resulttype"}
			,{fieldName: "displayunit"}
			,{fieldName: "resultvalue"}
			,{fieldName: "acceptno"}
			,{fieldName: "resultid"}
			,{fieldName: "condid"}
			,{fieldName: "testcond"}
			,{fieldName: "methodnm"}
			,{fieldName: "itemregid"}
			,{fieldName: "issuedateplan"}
			,{fieldName: "masternm"}
			,{fieldName: "smpnm"}
			,{fieldName: "conitemid"}
			,{fieldName: "reqid"}
			,{fieldName: "masterid"}
			,{fieldName: "treefield"}
			,{fieldName: "condetc"}
			,{fieldName: "displaytype"}
	    ];
	    
	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var resultcolumns = [
			{
	            name: "temname", 
	            fieldName: "itemname", 
	            header : { text: "항목명" },
	            styles: {
    		        textAlignment: "near"
    		    },
	            width : 350,
	            readOnly : "true"	 
	        },
	        {
	            name: "unitid", 
	            fieldName: "unitid", 
	            header : { text: "표준단위" },
	            width : 150,
	            readOnly : "true"	 
	        },
	        {
	            name: "displayunit", 
	            fieldName: "displayunit", 
	            header : { text: "단위" },
	            width : 150,
	            readOnly : "true"	 
	        },
	        {
	            name: "testcond", 
	            fieldName: "testcond", 
	            header : { text: "시험조건" },
	            width : 350,
	            readOnly : "true"	 
	        },
	        {
	            name: "methodnm", 
	            fieldName: "methodnm", 
	            header : { text: "시험방법" },
	            width : 350,
	            readOnly : "true"	 
	        }
	    ];
	    
	    
	    var resultfields2 = [
      			{fieldName: "lvl"}
      			,{fieldName: "itemid"}
      			,{fieldName: "conitempid"}
      			,{fieldName: "smpid"}
      			,{fieldName: "unitid"}
      			,{fieldName: "annotation"}
      			,{fieldName: "itemname"}
      			,{fieldName: "methodid"}
      			,{fieldName: "itempid"}
      			,{fieldName: "testnote"}
      			,{fieldName: "itemvalue"}
      			,{fieldName: "spec"}
      			,{fieldName: "orderby"}
      			,{fieldName: "resulttype"}
      			,{fieldName: "displayunit"}
      			,{fieldName: "resultvalue"}
      			,{fieldName: "acceptno"}
      			,{fieldName: "resultid"}
      			,{fieldName: "condid"}
      			,{fieldName: "testcond"}
      			,{fieldName: "methodnm"}
      			,{fieldName: "itemregid"}
      			,{fieldName: "issuedateplan"}
      			,{fieldName: "masternm"}
      			,{fieldName: "smpnm"}
      			,{fieldName: "conitemid"}
      			,{fieldName: "reqid"}
      			,{fieldName: "masterid"}
      			,{fieldName: "treefield"}
      			,{fieldName: "condetc"}
      			,{fieldName: "displaytype"}
      	    ];
      	    
      	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
      	    var resultcolumns2 = [
      			{
      	            name: "itemname", 
      	            fieldName: "itemname", 
      	            header : { text: "항목명" },
      	        	styles: {
	      		        textAlignment: "near"
	      		    },
      	            width : 350,
      	            readOnly : "true"	 
      	        },
      	      	{
				      name: "smpnm", 
				      fieldName: "smpnm", 
				      header : { text: "시료명" },
				      width : 350,
				      readOnly : "true"	 
				},
      	        {
      	            name: "unitid", 
      	            fieldName: "unitid", 
      	            header : { text: "표준단위" },
      	            width : 350,
      	            readOnly : "true"	 
      	        }
      	    ]; 
	    
	    ////////////////////컬럼 셋팅 끝////////////////////
	    
	    cooperProvider3.setFields(fields3);
	    cooperView3.setColumns(columns3);
	    
	    cooperProvider4.setFields(fields4);
	    cooperView4.setColumns(columns4);
	    
	    cooperProvider5.setFields(fields5);
	    cooperView5.setColumns(columns5);
	    
	    cooperProvider6.setFields(fields6);
	    cooperView6.setColumns(columns6);
	    
	    
	    resultProvider.setFields(resultfields);
	    resultView.setColumns(resultcolumns);
	    
	    resultProvider2.setFields(resultfields2);
	    resultView2.setColumns(resultcolumns2);
	    
	    
	    
	    cooperView4.setDisplayOptions({rowHeight: 35})
	    
	    cooperView3.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	display : { fitStyle : "evenFill" }
	    });
	    
	    cooperView4.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	edit : {
	    		deletable: true,
	    		appendable : true
	    	},
	    	display : { fitStyle : "evenFill" }
	    }); 
	    
	    
	    cooperView5.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    cooperView6.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    resultView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    resultView2.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    resultProvider.setOptions({
	        softDeleting: false
		});
	    
	    resultProvider2.setOptions({
	        softDeleting: false
		});
	    
	    
	    cooperView3.setHeader({
	    	height: 35
	    }); 
	    
	    /* 헤더의 높이를 지정*/
	    cooperView4.setHeader({
	    	height: 35
	    }); 
	    
	    cooperView3.setStyles(smart_style);
	    cooperView4.setStyles(smart_style);
	    cooperView5.setStyles(smart_style);
	    cooperView6.setStyles(smart_style);
	    
	    resultView.setStyles(smart_style);
	    resultView2.setStyles(smart_style);
	    
	    ////////////////////////////////////
	    
	    cooperView3.onDataCellClicked =  function (grid, index) {
	    	apprlineid = cooperView3.getValue(index.dataRow, "apprlineid");
	    	
	    	$.ajax({
				type : "post",
			    dataType : "json",
			    data : {"apprlineid":apprlineid},
	            url: "<c:url value='/officialExam/req/getApprDetail.json'/>",
	            success: function (data) {
	                cooperProvider4.fillJsonData(data);
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
	    cooperView4.onCellButtonClicked = function (appr, itemIndex, column) {
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
	        	
	        	
	        
				$("#userCooperModal").modal('show');
				$.ajax({
					type : "post",
				    dataType : "json",
		            url: "<c:url value='/system/selOfficeList.json'/>",
		            success: function (data) {
		                cooperProvider5.setRows(data,"treeview", true, "", "");
		            },
		            error:function(request,status,error){
		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		            },
		            complete: function (data) {
		            	cooperView5.expandAll();
		            	var options = {
		    			        fields:['name'],
		    			        values:['<%=nLoginVO.getOfficenm()%>']
		    			    }
	    			    var itemindex = cooperView5.searchItem(options);
	                	
	                	cooperView5.setCurrent({itemIndex:itemindex, column:"name"});
	                	fnGetCoopUserList(itemindex);
		            },
		            cache: false
		        });
				
	    };
	    
	    cooperView5.onDataCellClicked =  function (appr, index) {
	    	fnGetCoopUserList(index.itemIndex);
	    };
	    
	    
	    cooperView6.onDataCellClicked =  function (appr, index) {
	    	if(selcolumn == "fst"){
	    		cooperView4.setValue(0, "fstapprid", cooperView6.getValue(index.itemIndex,"adminid"));
		    	cooperView4.setValue(0, "fst", cooperView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "snd"){
	    		cooperView4.setValue(0, "sndapprid", cooperView6.getValue(index.itemIndex,"adminid"));
		    	cooperView4.setValue(0, "snd", cooperView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "trd"){
	    		cooperView4.setValue(0, "trdapprid", cooperView6.getValue(index.itemIndex,"adminid"));
		    	cooperView4.setValue(0, "trd", cooperView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "fth"){
	    		cooperView4.setValue(0, "fthapprid", cooperView6.getValue(index.itemIndex,"adminid"));
		    	cooperView4.setValue(0, "fth", cooperView6.getValue(index.itemIndex,"name"));
	    	} 
	    	$("#userCooperModal").modal('hide');
	    };
	    
	    
	});
	
	function fnGetCoopUserList(index){
		var officeid = cooperView5.getValue(index, "officeid");
    	$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"officeid":officeid},
            url: "<c:url value='/system/selOfficeUserList.json'/>",
            success: function (data) {
                cooperProvider6.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	
            },
            cache: false
        });
	}
	
	function selCoopModal(){
		resultProvider2.setRows(null,"treefield", true, "", "");
		$.ajax({
			type : "post",
		    dataType : "json",
            url: "<c:url value='/officialExam/req/getApprList.json'/>",
            success: function (data) {
                cooperProvider3.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	fnGetReqResultListAll();
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
	                cooperProvider4.clearRowStates(true, true);
	                $("#reqCooperModal").modal("hide");
	            } else {
	                alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	            }
	        },
	        error : function(request, status, error) {
	            alert("code:" + request.status + "\n" + "error:" + error);
	        }
	    });
	}
	
	function fnCancelCoopAppr(){
		cooperView4.deleteSelection(true);
	}
	
	function fnCoopAddRow(){
		cooperView4.deleteSelection(true);
		var gcnt = cooperView4.getItemCount();
		if(gcnt < 1){
			cooperView4.beginAppendRow();
			cooperView4.setValues(0, {draftid:"<%=nLoginVO.getAdminid()%>",draftnm:"<%=nLoginVO.getName()%>"})
		}
	}
	
	function fnCoopApprUserSave(){

		cooperView4.commit();	
		
		var state;
	    var jData;
	    var jRowsData = [];

	    var rows = cooperProvider4.getAllStateRows();
	    
	    if(rows.updated.length > 0){
	    	if(cooperView4.getValue(rows.updated[0], "fstapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(rows.updated[0], "draftid"),
	                "apprid": cooperView4.getValue(rows.updated[0], "fstapprid"),
	                "ordinal": "1"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(cooperView4.getValue(rows.updated[0], "sndapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(rows.updated[0], "draftid"),
	                "apprid": cooperView4.getValue(rows.updated[0], "sndapprid"),
	                "ordinal": "2"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(cooperView4.getValue(rows.updated[0], "trdapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(rows.updated[0], "draftid"),
	                "apprid": cooperView4.getValue(rows.updated[0], "trdapprid"),
	                "ordinal": "3"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(cooperView4.getValue(rows.updated[0], "fthapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(rows.updated[0], "draftid"),
	                "apprid": cooperView4.getValue(rows.updated[0], "fthapprid"),
	                "ordinal": "4"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}	   
	    }

	    if(rows.created.length > 0){
	    	
	    	if(cooperView4.getValue(rows.created[0], "fstapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(rows.created[0], "draftid"),
	                "apprid": cooperView4.getValue(rows.created[0], "fstapprid"),
	                "ordinal": "1"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(cooperView4.getValue(rows.created[0], "sndapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(rows.created[0], "draftid"),
	                "apprid": cooperView4.getValue(rows.created[0], "sndapprid"),
	                "ordinal": "2"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(cooperView4.getValue(rows.created[0], "trdapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(rows.created[0], "draftid"),
	                "apprid": cooperView4.getValue(rows.created[0], "trdapprid"),
	                "ordinal": "3"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(cooperView4.getValue(rows.created[0], "fthapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(rows.created[0], "draftid"),
	                "apprid": cooperView4.getValue(rows.created[0], "fthapprid"),
	                "ordinal": "4"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}	    	
                           
	    }
	    
	    
	    var val = JSON.stringify(jRowsData);
	    var data = {"data":val};
	    if(confirm("변경된 내용을 저장하시겠습니까?")){
	    	
	    	saveDataModal("<c:url value='/officialExam/req/edtApprLine.json'/>",data);
	    }
	}
	
	
	  function fnCoopApprConf(){
	 		cooperView4.commit();
	 		
	 		resultView.commit();
	 		resultView2.commit();
	 		
	 		var state;
	 	    var jData;
	 	    var jRowsData = [];
	 	    var officeid = $("#cmbdept").val();
	 	    
	    	if(cooperView4.getValue(0, "fstapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(0, "draftid"),
	                "apprid": cooperView4.getValue(0, "fstapprid"),
	                "ordinal": "1"
	            }
	            jData.reqid = reqid;
	            jData.officeid = officeid;
	            jRowsData.push(jData);
	    	} else {
	    		alert("1차 승인자를 선택하여 주십시오.");
	    		return;
	    	}
	    	
	    	if(cooperView4.getValue(0, "sndapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(0, "draftid"),
	                "apprid": cooperView4.getValue(0, "sndapprid"),
	                "ordinal": "2"
	            }
	            jData.reqid = reqid;
	            jData.officeid = officeid;
	            jRowsData.push(jData);
	    	}
	    	
	    	if(cooperView4.getValue(0, "trdapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(0, "draftid"),
	                "apprid": cooperView4.getValue(0, "trdapprid"),
	                "ordinal": "3"
	            }
	            jData.reqid = reqid;
	            jData.officeid = officeid;
	            jRowsData.push(jData);
	    	}
	    
	    	if(cooperView4.getValue(0, "fthapprid") != null){
	            jData = {
	                "draftid": cooperView4.getValue(0, "draftid"),
	                "apprid": cooperView4.getValue(0, "fthapprid"),
	                "ordinal": "4"
	            }
	            jData.reqid = reqid;
	            jData.officeid = officeid;
	            jRowsData.push(jData);
	    	}	   
	 	        	
	 		if (jRowsData.length == 0) {
	 	    	alert("선택된 내용이 없습니다.");
	 	        cooperProvider.clearRowStates(true);
	 	        return;
	 	    }
	 		
	 		
	 		//항목정보
	 		var jRowsData2 = [];
			  
			var androws = resultProvider2.getJsonRows(-1, true, "treefield", "");
			  
			if(androws != null && androws.length > 0){
			    for(var i=0; i < androws.length; i++){
			    	//jData = androws[i];
			    	jData.reqid = androws[i].reqid;			    	
			    	jData.resultid = androws[i].resultid;
			    	jData.officeid = officeid;
			        jRowsData2.push(jData);
			            
			        if(androws[i].treefield != null){
			        	for(var j=0; j < androws[i].treefield.length; j++){
			          		//jData = androws[i].treefield[j];
			          		jData.reqid = androws[i].treefield[j].reqid;			    	
			    			jData.resultid = androws[i].treefield[j].resultid;
			          		jData.officeid = officeid;
				            jRowsData2.push(jData);
			           	}
			        }
				}
			}
	 		
	 		
	 	    
	 	    var val = JSON.stringify(jRowsData);
	 	   	var val2 = JSON.stringify(jRowsData2);
	 	    var data = {"data":val,"resultdata":val2};
	 	    
	 	    if(confirm("결재 요청 하시겠습니까?")){
	 	    	saveDataConfirm("<c:url value='/officialExam/result/inCoopConf.json'/>",data);
	 	    }
	 	    
	 	}
	  
	  
	  function fnGetReqResultListAll(){
			var modalsmpid = $("#modalsmpid").val();
			$.ajax({
				type : "post",
			    dataType : "json",
			    data : {"reqid":reqid,"smpid":modalsmpid},
	            url: "<c:url value='/officialExam/result/getResultListAll.json'/>",
	            success: function (data) {
	            	resultProvider.setRows(data.resultAdminList,"treefield", true, "", "");
	            	$("#modalreceiptdate").text(data.smpDetailVO.receiptdate);
	            	$("#modalissuedateplan").text(data.smpDetailVO.issuedateplan);
	            	$("#modalmasternm").text(data.smpDetailVO.masternm);
	            	$("#modalsmpnm").text(data.smpDetailVO.smpnm);
	            	$("#modalsmpadmin").text(data.smpDetailVO.adminnm);
	            	$("#modalstatenm").text(data.smpDetailVO.statenm);
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            },
	            complete: function (data) {
	            	resultView.expandAll();
	            	//fnGetLookup();
	            },
	            cache: false
	        });
		}
	  
	  function fnRight(){
		  
		  var jRowsData = [];
		  
		  var androws = resultProvider2.getJsonRows(-1, true, "treefield", "");
		  
		  if(androws != null && androws.length > 0){
		        for(var i=0; i < androws.length; i++){
		            jData = androws[i];
		            jRowsData.push(jData);
		            
		            if(androws[i].treefield != null){
		            	for(var j=0; j < androws[i].treefield.length; j++){
		            		jData = androws[i].treefield[j];
				            jRowsData.push(jData);
		            	}
		            }
		        }
		  }
		  
		  var rows = resultView.getCheckedRows();
		  if(rows.length > 0){
		        for(var i=0; i < rows.length; i++){
		            jData = resultProvider.getJsonRow(rows[i]);
		            //jRowsData.push(jData);
            		var options = {
	    			        fields:['treefield'],
	    			        values:[jData.treefield]
	    			    }
	            	var items = resultView2.searchItem(options);
		            if(items == "-1"){
		            	jRowsData.push(jData);
		            }
		        }
		  }
		  
		  resultProvider2.setRows(jRowsData,"treefield", true, "", "");
		  //resultProvider.removeRows(rows);
		  resultView2.expandAll();
		  
	  }
	  
	  function fnLeft(){
		  var jRowsData = [];
		  
		  /* var androws = resultProvider.getJsonRows(-1, true, "treefield", "");
		  if(androws.length > 0){
		        for(var i=0; i < androws.length; i++){
		            jData = androws[i];
		            jRowsData.push(jData);
		        }
		  } */
		  
		  var rows = resultView2.getCheckedRows();
		  if(rows.length > 0){
		        for(var i=0; i < rows.length; i++){
		            jData = resultProvider2.getJsonRow(rows[i]);
		            jRowsData.push(jData);
		            
		        };
		    }
		  //resultProvider.setRows(jRowsData,"treefield", true, "", "");
		  resultProvider2.removeRows(rows);
		  resultView.expandAll();
	  }
	
</script>


<!-- 의뢰승인요청 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="reqCooperModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog modal-lg" role="document"  style="width: 1050px;">
	    <div class="modal-content">
	      <div class="modal-header">
	        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
	        <h4 class="modal-title" id="myModalLabel">결재정보</h4>
	      </div>
	      <div class="modal-body requestBody" style="height: 150px;">
	      	<div style="width:30%;float:left;">
				<div id="realcooper3" style="width: 100%; height: 130px;"></div>
			</div>
			<div style="width: 5%;height: 100%; display: table; float:left; margin:0 16px;">
				<div style="display: table-cell;vertical-align: middle;">
					<br><br>
					<p style="padding:6px;">
						<a href="javascript:fnCancelCoopAppr();" class="btn btn-default"><i class="glyphicon glyphicon-chevron-left"></i></a>
					</p>
					
				</div>
			</div>
			<div  style="width: 60%; float:right;">
			<div class="dt-toolbar">
			<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
			결재정보
			
			<a href="javascript:fnCoopAddRow();" class="btn btn-default pull-right  btn-xs" style="margin-bottom: 2px; margin-left: 2px; ">신규</a>
			<a href="javascript:fnCoopApprUserSave();" class="btn btn-default pull-right  btn-xs">결재정보저장</a>
			</div>
				<div id="realcooper4" style="width:100%; height: 90px;"></div>
			</div>
	      </div>
	      <br/>
	      <div role="content" style="padding-left: 20px; padding-right: 20px;">
			<div class="dt-toolbar" style="margin-bottom: 10px;">
				<div class="col-sm-8">
					<div class="col col-md-12" style="height: 100%">
						
						<div class="" style="
						    float: left;
						    margin-bottom: 3px;
						    padding-bottom: 6px;
						    padding-top: 6px;
						    padding-right: 12px;
						    padding-left: 12px;
						    border-top: 1px solid #C1C1C1;
						    border-left: 4px solid #C1C1C1;
						    border-bottom: 1px solid #C1C1C1; 
						    background: #ECECEC;   
						">
						 시료 / 제품
						</div>
						<div style="float:left; width:60%;">
						<select class="form-control" style="height:33px;width: 100%;" id="modalsmpid" name="modalsmpid" onchange="javascript:fnGetReqResultListAll();">
						<c:forEach var="reqSmpList" items="${reqSmpList}">
							<option value="${reqSmpList.smpid}">${reqSmpList.smpname} / ${reqSmpList.mname}<c:if test="${reqSmpList.adminnm ne null}">(${reqSmpList.officenm}/${reqSmpList.adminnm})</c:if></option>
						</c:forEach>						
						</select>
						</div>
						
						
					</div>
				</div>
				<div class="col-sm-4 text-right" >  
					<div class="" style="
						    float: left;
						    margin-bottom: 3px;
						    padding-bottom: 6px;
						    padding-top: 6px;
						    padding-right: 12px;
						    padding-left: 12px;
						    border-top: 1px solid #C1C1C1;
						    border-left: 4px solid #C1C1C1;
						    border-bottom: 1px solid #C1C1C1; 
						    background: #ECECEC;   
						">
						협조본부
					</div>
					<div style="float:left; width:60%;">
						<select class="form-control" style="height:33px;width: 100%;" id="cmbdept" name="cmbdept">
						<c:forEach var="deptList" items="${deptList}">
							<option value="${deptList.officeid}">${deptList.deptnm}</option>
						</c:forEach>						
						</select>
					</div>
				</div>
			</div>
			<br/>
			<div class="form-horizontal form-terms ui-sortable"> 
				<div class="jarviswidget jarviswidget-sortable" role="widget">	
					<div class="widget-body">
					<fieldset>
					<div class="col-md-4 form-group ">
						<label class="col-md-5 form-label">접수일</label>
						<div class="col-md-7">
							<span class="txt-sub-content" id="modalreceiptdate"></span>
						</div>
					</div>
					<div class="col-md-4 form-group">
						<label class="col-md-5 form-label">제품명</label>
						<div class="col-md-7">
							<span class="txt-sub-content" id="modalmasternm"></span>
						</div>
					</div>
					<div class="col-md-4 form-group ">
						<label class="col-md-5 form-label">성적서 발급예정일</label>
						<div class="col-md-7">
							<span class="txt-sub-content" id="modalissuedateplan"></span>
						</div>
					</div>
					</fieldset>
					
					<fieldset>
					<div class="col-md-4 form-group">
						<label class="col-md-5 form-label">시료명</label>
						<div class="col-md-7">
							<span class="txt-sub-content" id="modalsmpnm"></span>
						</div>
					</div>
					<div class="col-md-4 form-group ">
						<label class="col-md-5 form-label">제품(유종)담당자</label>
						<div class="col-md-7">
							<span class="txt-sub-content" id="modalsmpadmin"></span>
						</div>
					</div>
					<div class="col-md-4 form-group">
						<label class="col-md-5 form-label">진행상태</label>
						<div class="col-md-7">
							<span class="txt-sub-content" id="modalstatenm"></span>
						</div>
					</div>
					</fieldset>				
					</div>
				</div>
			</div>		
			<div style="width:55%;float:left;">
				<div id="resultGrid" style="width: 100%; height: 230px;"></div>
			</div>
			<div style="width: 5%;height: 100%; display: table; float:left; margin:0 10px;">
				<div style="display: table-cell;vertical-align: middle;">
					<p style="padding:6px;">
						<a href="javascript:fnLeft();" class="btn btn-default"><i class="glyphicon glyphicon-chevron-left"></i></a>
					</p>
					<p style="padding:6px;">
						<a href="javascript:fnRight();" class="btn btn-default"><i class="glyphicon glyphicon-chevron-right"></i></a>
					</p>
				</div>
			</div>					
			<div style="width:37%;float:right;">
				<div id="resultGrid2" style="width: 100%; height: 230px;"></div>
			</div>
		<!-- end of realgrid Content -->		
		</div>	
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" onclick="fnCoopApprConf()">결재 요청</button>
	      </div>
	    </div>
	  </div>
	  
<!-- end of modal  -->
</div>


<!-- 의뢰승인요청 결재자선택 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="userCooperModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog modal-lg" role="document" style="top: 150px; height: 300px;">
	    <div class="modal-content" style="height: inherit;">
	      <div class="modal-header">
	        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
	        <h4 class="modal-title" id="myModalLabel4">결재자선택</h4>
	      </div>
	      <div class="modal-body requestBody">
	      	<div style="width:60%;float:left;">
				<div id="realcooper5" style="width: 520px; height: 200px;"></div>
			</div>
			<div style="width: 50;height: 100%; display: table; float:left; margin:0 16px;">
				<div style="display: table-cell;vertical-align: middle;">
					<p>
						&nbsp;
					</p>
				</div>
			</div>
			<div  style="width: 286px; float:left;">
				<div id="realcooper6" style="width:286px; height: 200px;"></div>
			</div>
	      </div>
	    </div>
	  </div>
	  
<!-- end of modal  -->
</div>