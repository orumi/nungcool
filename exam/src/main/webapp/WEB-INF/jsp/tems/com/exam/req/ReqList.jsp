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

<script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>

<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">

<script>
		$(document).ready( function(){
			sel();
			
			$(".approve").click(function(){
				$("#approveModal").modal('show');
				$("#approveModal").on('shown.bs.modal', function () {
					gridView2.resetSize();
					
		    	});
				
			});
			
			$("#reqConfBtn").click(function(){
				
				var rows = gridView.getCheckedRows();
				var jRowsData = [];
				var jData
				
				if(rows.length > 0){
			        for(var i=0; i < rows.length; i++){
			            jData = dataProvider.getJsonRow(rows[i]);
			            jRowsData.push(jData);
			        };
			    }
				
				if (jRowsData.length == 0) {
					alert("선택된 값이 없습니다.");
			        return;
			    }
				
				$("#reqConfModal").modal('show');
				$("#reqConfModal").on('shown.bs.modal', function () {
					selModal();
					gridView4.resetSize();
		    	});
				
			});
		    
		});
</script>
<script>
	var gridView;
	var dataProvider;
	var gridView2;
	var dataProvider2;
	var gridView3;
	var dataProvider3;
	var gridView4;
	var dataProvider4;
	
	var gridView5;
	var dataProvider5;
	var gridView6;
	var dataProvider6;
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
		RealGridJS.setRootContext("<c:url value='/script'/>");
	    
		dataProvider = new RealGridJS.LocalDataProvider();
		dataProvider2 = new RealGridJS.LocalDataProvider();
	    
	   	dataProvider3 = new RealGridJS.LocalDataProvider();
	    dataProvider4 = new RealGridJS.LocalDataProvider();
	    
	    dataProvider5 = new RealGridJS.LocalTreeDataProvider();
	    dataProvider6 = new RealGridJS.LocalDataProvider();
	    
	    gridView = new RealGridJS.GridView("realgrid"); 
	    gridView2 = new RealGridJS.GridView("realgrid2");
		gridView3 = new RealGridJS.GridView("realgrid3");
	    gridView4 = new RealGridJS.GridView("realgrid4");
	    
	    gridView5 = new RealGridJS.TreeView("realgrid5");
	    gridView6 = new RealGridJS.GridView("realgrid6");
	    
	    gridView.setDataSource(dataProvider);   
	    gridView2.setDataSource(dataProvider2);
	    gridView3.setDataSource(dataProvider3);
	    gridView4.setDataSource(dataProvider4);
	    
	    gridView5.setDataSource(dataProvider5);
	    gridView6.setDataSource(dataProvider6);
	    
	  
	    //setOptions(gridView);
	    //setOptions(gridView2);
	    //setOptions(gridView3);
	    //setOptions(gridView4);

	   	
	    //접수내역 메인 그리드
	    var fields = [
			{fieldName: "comname"},
			{fieldName: "memname"},
			{fieldName: "requestcdate"},
			{fieldName: "reqid"},
			{fieldName: "smpcnt"},
			{fieldName: "mngphone"},
			{fieldName: "taxcompany"},
			{fieldName: "pricechargetype"},
			{fieldName: "pricechargetypenm"},
			{fieldName: "pricedate"},
			{fieldName: "reportprice", dataType: "number"},
			{fieldName: "pricetype"},
			{fieldName: "pricetypenm"},
			{fieldName: "taxissuedate"},
			{fieldName: "reqstate"},
			{fieldName: "statenm"},
			{fieldName: "signappr"},
			{fieldName: "apprstatenm"},
			{fieldName: "rltcnt"}
	    ];
	    
	    var columns = [
			 {
    			name: "requestcdate",
    			fieldName: "requestcdate",
    			header : {
    				text: "신청일자"
    			},
    			width: 100,
    			readOnly : "true"	  
    		},
    		{
    			name: "comname",
    			fieldName: "comname",
    			header : {
    				text: "업체명"
    			},
    			renderer: {
    	            "url": "javascript:alert('${comname}')",
    	            "type": "link",
    	            "requiredFields": "reqid",
    	            "showUrl": false,
    	            "color":"blue"
    	        },
    			width: 200,
    			readOnly : "true"
    		},
    		{
    			name: "memname",
    			fieldName: "memname",
    			header : {
    				text: "신청자"
    			},
    			width: 100,
    			readOnly : "true"
    		},
    		{
    			name: "mngphone",
    			fieldName: "mngphone",
    			header : {
    				text: "전화번호"
    			},
    			width: 120,
    			readOnly : "true"
    		},
    		{
    			name: "smpcnt",
    			fieldName: "smpcnt",
    			header : {
    				text: "시료\n건수"
    			},
    			width: 60,
    			readOnly : "true"
    		},
    		{
    			name: "rltcnt",
    			fieldName: "rltcnt",
    			header : {
    				text: "항목\n건수"
    			},
    			width: 60,
    			readOnly : "true"
    		},
    		{
    			name: "taxcompany",
    			fieldName: "taxcompany",
    			header : {
    				text: "세금계산서발행업체"
    			},
    			width: 150,
    			readOnly : "true"
    		},
    		{
    			name: "pricechargetype",
    			fieldName: "pricechargetype",
    			header : {
    				text: "결제\n청구유형"
    			},
    			width: 100,
    			readOnly : "true"
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "견적서"
    			},
    			width: 60,
    			button: "action",
    			buttonVisibility : "always"
    		},
    		{
    			name: "pricedate",
    			fieldName: "pricedate",
    			header : {
    				text: "결제일자"
    			},

    			editButtonVisibility : "always",
    			editor: {
    	            "type": "date",
    	            "datetimeFormat": "yyyy.MM.dd"
    	        },
    	        styles: {
    	            "textAlignment": "center",
    	            "datetimeFormat": "yyyy.MM.dd"
    	        },
    			width: 100
    		},
    		{
    			name: "reportprice",
    			fieldName: "reportprice",
    			header : {
    				text: "결제금액"
    			},
   		        styles : {
   		            "textAlignment": "far",
   		         	"numberFormat": "000,000"
   		        },
    			width: 100,
    			readOnly : "true"
    		},
    		{
    			name: "pricetype",
    			fieldName: "pricetype",
    			header : {
    				text: "결제유형"
    			},

   		        editor: {
   		            "type": "dropDown",
   		            "dropDownCount": 6
   		        },
    			width: 100,
    			lookupDisplay : true,
    			editButtonVisibility : "always"
    		},
    		{
    			name: "taxissuedate",
    			fieldName: "taxissuedate",
    			header : {
    				text: "계산서발행일자"
    			},
    			width: 110,
    			readOnly : "true"
    		},
    		{
    			name: "apprstatenm",
    			fieldName: "apprstatenm",
    			header : {
    				text: "승인\n요청"
    			},
    			width: 70,
    			readOnly : "true"
    		},
    		{
    			name: "statenm",
    			fieldName: "statenm",
    			header : {
    				text: "진행상태"
    			},
    			width: 80,
    			readOnly : "true"
    		}
	    ];
	    
	    
	    //접수내역 메인리스트에서 결재중 팝업 그리드
	    var fields2 = [
			{
            		fieldName: "title"
            	},
            	{
					fieldName: "content"            		
            	},
    			{
            		fieldName: "b_date"
            	}
	    ];
	    
	    var columns2 = [
			{
				name: "",
				fieldName: "",
				header : {
					text: "구분"
				},
    			width: 100
			},{
				name: "",
				fieldName: "",
				header : {
					text: "기안자"
				},
    			width: 100
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "1차승인"
				},
    			width: 100
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "2차승인"
				},
    			width: 100
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "3차승인"
				},
    			width: 100
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "4차승인"
				},
    			width: 100
			}
	    ];
	    
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
	    
	    
	    //DataProvider의 setFields함수로 필드를 입력합니다.
	    dataProvider.setFields(fields);
	    gridView.setColumns(columns);
	    
	    dataProvider2.setFields(fields2);
	    gridView2.setColumns(columns2);
	    
	    dataProvider3.setFields(fields3);
	    gridView3.setColumns(columns3);
	    
	    dataProvider4.setFields(fields4);
	    gridView4.setColumns(columns4);
	    
	    dataProvider5.setFields(fields5);
	    gridView5.setColumns(columns5);
	    
	    dataProvider6.setFields(fields6);
	    gridView6.setColumns(columns6);
	    
	    
	    
	    gridView4.setDisplayOptions({rowHeight: 125})	     

	    
	    /* 그리드 row추가 옵션사용여부 */
	    gridView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	        display : { fitStyle : "evenFill" }
	    });
	    
	    gridView2.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	display : { fitStyle : "evenFill" }
	    });
	    
	    gridView3.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	display : { fitStyle : "evenFill" }
	    });
	    
	    gridView4.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	edit : {
	    		deletable: true,
	    		appendable : true
	    	},
	    	display : { fitStyle : "evenFill" }
	    }); 
	    
	    
	    gridView5.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    gridView6.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	        display : {
	            fitStyle : "evenFill"
	        }
	    });
	    
	    /* 헤더의 높이를 지정*/
	    gridView.setHeader({
	    	height: 45
	    }); 
	    /* 헤더의 높이를 지정*/
	    gridView3.setHeader({
	    	height: 35
	    }); 
	    
	    /* 헤더의 높이를 지정*/
	    gridView4.setHeader({
	    	height: 35
	    }); 
	    
	    gridView.setStyles(smart_style);
	    gridView2.setStyles(smart_style);
	    gridView3.setStyles(smart_style);
	    gridView4.setStyles(smart_style);
	    gridView5.setStyles(smart_style);
	    gridView6.setStyles(smart_style);
	    
	    ////////////////////////////////////
	    
			 
	    
	     //grid event handling
	    gridView.onLinkableCellClicked = function (grid, index, url) {
	    	alert(gridView.getValue(index.itemIndex,"reqid")+"의 상세페이지");
	    };
	    
	    gridView.onCellEdited =  function (grid, itemIndex, dataRow, field) {
	    	gridView.checkItem(itemIndex);
	    };
	     
	    gridView.onCellButtonClicked = function (grid, itemIndex, column) {
	        alert(gridView.getValue(itemIndex,"reqid")+" 의 견적서");
	    };
	    
	    gridView3.onDataCellClicked =  function (grid, index) {
	    	apprlineid = gridView3.getValue(index.dataRow, "apprlineid");
	    	
	    	$.ajax({
				type : "post",
			    dataType : "json",
			    data : {"apprlineid":apprlineid},
	            url: "<c:url value='/exam/req/getApprDetail.json'/>",
	            success: function (data) {
	                dataProvider4.fillJsonData(data);
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            },
	            complete: function (data) {
	            	//gridView.hideToast();
	            },
	            cache: false
	        });
	    };
	     
	    
	    var selcolumn;
	    gridView4.onCellButtonClicked = function (grid, itemIndex, column) {
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
				$("#userInfofModal").on('shown.bs.modal', function () {
					gridView5.resetSize();
					gridView6.resetSize();
					
					$.ajax({
						type : "post",
					    dataType : "json",
			            url: "<c:url value='/system/selOfficeList.json'/>",
			            success: function (data) {
			                dataProvider5.setRows(data,"treeview", true, "", "");
			            },
			            error:function(request,status,error){
			                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			            },
			            complete: function (data) {
			            	gridView5.expandAll();
			            	var options = {
			    			        fields:['name'],
			    			        values:['<%=nLoginVO.getOfficenm()%>']
			    			    }
		    			    var itemindex = gridView5.searchItem(options);
		                	
		                	gridView5.setCurrent({itemIndex:itemindex, column:"name"});
		                	fnGetUserList(itemindex);
			            },
			            cache: false
			        });
		    	});
				
	    };
	    
	    gridView5.onDataCellClicked =  function (grid, index) {
	    	fnGetUserList(index.itemIndex);
	    };
	    
	    
	    gridView6.onDataCellClicked =  function (grid, index) {
	    	if(selcolumn == "fst"){
	    		gridView4.setValue(0, "fstapprid", gridView6.getValue(index.itemIndex,"adminid"));
		    	gridView4.setValue(0, "fst", gridView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "snd"){
	    		gridView4.setValue(0, "sndapprid", gridView6.getValue(index.itemIndex,"adminid"));
		    	gridView4.setValue(0, "snd", gridView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "trd"){
	    		gridView4.setValue(0, "trdapprid", gridView6.getValue(index.itemIndex,"adminid"));
		    	gridView4.setValue(0, "trd", gridView6.getValue(index.itemIndex,"name"));
	    	} else if(selcolumn == "fth"){
	    		gridView4.setValue(0, "fthapprid", gridView6.getValue(index.itemIndex,"adminid"));
		    	gridView4.setValue(0, "fth", gridView6.getValue(index.itemIndex,"name"));
	    	} 
	    	$("#userInfofModal").modal('hide');
	    };
	    
	    
	});
	
	function fnGetUserList(index){
		var officeid = gridView5.getValue(index, "officeid");
    	$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"officeid":officeid},
            url: "<c:url value='/system/selOfficeUserList.json'/>",
            success: function (data) {
                dataProvider6.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	
            },
            cache: false
        });
	}
	
	function sel(){
		$.ajax({
			type : "post",
		    dataType : "json",
            url: "<c:url value='/exam/req/selReqList.json'/>",
            success: function (data) {
                dataProvider.fillJsonData(data);
                
                var labels =new Array();
        		var values =new Array();
        		var icnt = 0;
        		
        		<c:forEach var="ComboList17" items="${ComboList17}">
        		values[icnt] = "<c:out value='${ComboList17.codeid}'/>";
        		labels[icnt] = "<c:out value='${ComboList17.codename}'/>";
        		icnt++;
        		</c:forEach>
        		
        		
        		var column = gridView.columnByName("pricetype");
        		column.labels = labels;
        		column.values = values;
        		gridView.setColumn(column); 
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	//gridView.hideToast();
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
                dataProvider3.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	gridView3.resetSize();
            },
            cache: false
        });
	}
	
	function fnExpand(){
		 gridView.expandAll();
	}
	

	function refreshClients(){
		dataProvider2.refreshClients();
	};
	
	
	function fnPriceTypeSave(){
		gridView.commit();	
		
		var state;
	    var jData;
	    var jRowsData = [];

	    var rows = dataProvider.getAllStateRows();
	    
	    if(rows.updated.length > 0){
	        for(var i=0; i < rows.updated.length; i++){
	            jData = dataProvider.getJsonRow(rows.updated[i]);
	            jData.state = "updated";
	            jRowsData.push(jData);
	        };
	    }

	    if (jRowsData.length == 0) {
	    	alert("변경된 내용이 없습니다.");
	        dataProvider.clearRowStates(true);
	        return;
	    }
	    
	    
	    var val = JSON.stringify(jRowsData);
	    var data = {"data":val};
	    if(confirm("변경된 내용을 저장하시겠습니까?")){
	    	
	    	saveData("<c:url value='/exam/req/edtReqList.json'/>",data);	
	    }
		
	}
	
	function saveData(urlStr,data) {
	    $.ajax({
	        url : urlStr,
	        type : "post",
	        data : data,
	        dataType : "json",
	        success : function(data) {
	            if (data.RESULT_YN =="Y") {
	            	alert("정상 처리 되었습니다.");
	                dataProvider.clearRowStates(true, true);
	                sel();
	                $("#reqConfModal").modal('hide');
	            } else {
	                alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	            }
	        },
	        error : function(request, status, error) {
	            alert("code:" + request.status + "\n" + "error:" + error);
	        }
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
	                dataProvider4.clearRowStates(true, true);
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
		gridView4.deleteSelection(true);
	}
	
	
	function fnEqPriceType(){
		
		var rows = gridView.getCheckedRows();
		var jRowsData = [];
		if(rows.length > 0){
			var setData = gridView.getValue(rows[0],"pricetype");
			if(rows.length > 0){
		        for(var i=0; i < rows.length; i++){
		            jData = gridView.getValue(rows[i],"pricetype");
		            gridView.setValue(rows[i],"pricetype",setData);
		        };
		    }
		}
	}
	
	function fnReqStateChange(){
		
		var rows = gridView.getCheckedRows();
		var jRowsData = [];
		var jData
		
		if(rows.length > 0){
	        for(var i=0; i < rows.length; i++){
	            jData = dataProvider.getJsonRow(rows[i]);
	            jRowsData.push(jData);
	        };
	    }
		
		if (jRowsData.length == 0) {
			alert("선택된 값이 없습니다.");
	        return;
	    }
		
		//var data = JSON.stringify(jRowsData)
		var val = JSON.stringify(jRowsData);

		var data = {"data":val,"cmbstate":$("#cmbState").val()};
	    if(confirm("선택된 내용을 저장하시겠습니까?")){
	    	saveData("<c:url value='/exam/req/upReqState.json'/>",data);	
	    }
	}
	
	function fnAddRow(){
		var gcnt = gridView4.getItemCount();
		if(gcnt < 1){
			gridView4.beginAppendRow();
			gridView4.setValues(0, {draftid:"<%=nLoginVO.getAdminid()%>",draftnm:"<%=nLoginVO.getName()%>"})
		}
	}
	
	function fnApprUserSave(){

		gridView4.commit();	
		
		var state;
	    var jData;
	    var jRowsData = [];

	    var rows = dataProvider4.getAllStateRows();
	    
	    if(rows.updated.length > 0){
	    	if(gridView4.getValue(rows.updated[0], "fstapprid") != null){
	            jData = {
	                "draftid": gridView4.getValue(rows.updated[0], "draftid"),
	                "apprid": gridView4.getValue(rows.updated[0], "fstapprid"),
	                "ordinal": "1"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(gridView4.getValue(rows.updated[0], "sndapprid") != null){
	            jData = {
	                "draftid": gridView4.getValue(rows.updated[0], "draftid"),
	                "apprid": gridView4.getValue(rows.updated[0], "sndapprid"),
	                "ordinal": "2"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(gridView4.getValue(rows.updated[0], "trdapprid") != null){
	            jData = {
	                "draftid": gridView4.getValue(rows.updated[0], "draftid"),
	                "apprid": gridView4.getValue(rows.updated[0], "trdapprid"),
	                "ordinal": "3"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(gridView4.getValue(rows.updated[0], "fthapprid") != null){
	            jData = {
	                "draftid": gridView4.getValue(rows.updated[0], "draftid"),
	                "apprid": gridView4.getValue(rows.updated[0], "fthapprid"),
	                "ordinal": "4"
	            }
	            jData.state = "updated";
	            jRowsData.push(jData);
	    	}	   
	    }

	    if(rows.created.length > 0){
	    	
	    	if(gridView4.getValue(rows.created[0], "fstapprid") != null){
	            jData = {
	                "draftid": gridView4.getValue(rows.created[0], "draftid"),
	                "apprid": gridView4.getValue(rows.created[0], "fstapprid"),
	                "ordinal": "1"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(gridView4.getValue(rows.created[0], "sndapprid") != null){
	            jData = {
	                "draftid": gridView4.getValue(rows.created[0], "draftid"),
	                "apprid": gridView4.getValue(rows.created[0], "sndapprid"),
	                "ordinal": "2"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(gridView4.getValue(rows.created[0], "trdapprid") != null){
	            jData = {
	                "draftid": gridView4.getValue(rows.created[0], "draftid"),
	                "apprid": gridView4.getValue(rows.created[0], "trdapprid"),
	                "ordinal": "3"
	            }
	            jData.state = "created";
	            jRowsData.push(jData);
	    	}
	    	
	    	if(gridView4.getValue(rows.created[0], "fthapprid") != null){
	            jData = {
	                "draftid": gridView4.getValue(rows.created[0], "draftid"),
	                "apprid": gridView4.getValue(rows.created[0], "fthapprid"),
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
		gridView.commit();
		gridView4.commit();	
		
		
		var state;
	    var jData;
	    var jRowsData = [];
	    
	    
	    var chkrows = gridView.getCheckedRows();
	    
		if(chkrows.length > 0){
	        for(var i=0; i < chkrows.length; i++){
    	    	if(gridView4.getValue(0, "fstapprid") != null){
    	            jData = {
    	                "draftid": gridView4.getValue(0, "draftid"),
    	                "apprid": gridView4.getValue(0, "fstapprid"),
    	                "ordinal": "1"
    	            }
    	            jData.reqid = gridView.getValue(chkrows[i],"reqid");
    	            jRowsData.push(jData);
    	    	}
    	    	
    	    	if(gridView4.getValue(0, "sndapprid") != null){
    	            jData = {
    	                "draftid": gridView4.getValue(0, "draftid"),
    	                "apprid": gridView4.getValue(0, "sndapprid"),
    	                "ordinal": "2"
    	            }
    	            jData.reqid = gridView.getValue(chkrows[i],"reqid");
    	            jRowsData.push(jData);
    	    	}
    	    	
    	    	if(gridView4.getValue(0, "trdapprid") != null){
    	            jData = {
    	                "draftid": gridView4.getValue(0, "draftid"),
    	                "apprid": gridView4.getValue(0, "trdapprid"),
    	                "ordinal": "3"
    	            }
    	            jData.reqid = gridView.getValue(chkrows[i],"reqid");
    	            jRowsData.push(jData);
    	    	}
    	    	
    	    	if(gridView4.getValue(0, "fthapprid") != null){
    	            jData = {
    	                "draftid": gridView4.getValue(0, "draftid"),
    	                "apprid": gridView4.getValue(0, "fthapprid"),
    	                "ordinal": "4"
    	            }
    	            jData.reqid = gridView.getValue(chkrows[i],"reqid");
    	            jRowsData.push(jData);
    	    	}	   
	        }
		}
	    
	    var val = JSON.stringify(jRowsData);
	    var data = {"data":val};
	    
	    if(confirm("변경된 내용을 저장하시겠습니까?")){
	    	
	    	saveData("<c:url value='/exam/req/inApprConf.json'/>",data);	
	    }
	    
	}
</script>



<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">

	<!-- start of content -->
	<div role="content">
	
	<!--  start of  form-horizontal tems_search  -->
	<!--  start of widget-body -->
	<div class="form-horizontal form-terms "> <div class="jarviswidget jarviswidget-sortable" role="widget">	
		<!-- 
		<header role="heading">
		
		<span class="widget-icon"> <i class="fa fa-edit"></i> </span>
		<h2>접수내역 조회</h2>
		</header>
	    -->
	<!-- back -->    	
	<div class="widget-body">
	
	
		<fieldset>
		<div class="col-md-6 form-group ">
			<label class="col-md-3 form-label"><b>신청일자</b></label>
			<div class="col-md-9">
				<div class="col-sm-1 checkbox" style="padding-left:0px;width:20px;">
					<label>
							<input type="checkbox" class="checkbox">
							<span></span>
					</label>		
				</div>
				<div class="col-sm-4" style="padding-left:0px;">
					<div class="input-group">
						<input class="form-control form-calendar" id="startdate1" type="text">
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
						<div class="col-sm-1 wave">
							<b>~</b>
						</div>
				<div class="col-sm-1 checkbox" style="padding-left:0px;width:20px;">
					<label>
						<input type="checkbox" class="checkbox">
						<span></span>
					</label>
				</div>	
				<div class="col-sm-4" style="padding-left:0px;">
					<div class="input-group">
						<input class="form-control form-calendar" id="finishdate1" type="text">
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>결재일자</b></label>
			<div class="col-md-9">
			
                    <div class="col-sm-1 checkbox" style="padding-left:0px;width:20px;">
						<label>
							<input type="checkbox" class="checkbox">
							<span></span>
						</label>
					</div>
					<div class="col-sm-4" style="padding-left:0px;">
						<div class="input-group">
							<input class="form-control form-calendar" id="startdate2" type="text">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-1 wave">
						<b>~</b>
					</div>
					<div class="col-sm-1 checkbox" style="padding-left:0px;width:20px;">
						<label>
							<input type="checkbox" class="checkbox ">
							<span></span>
						</label>
					</div>
					<div class="col-sm-4" style="padding-left:0px;">
						<div class="input-group">
							<input class="form-control form-calendar" id="finishdate2" type="text">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>			
			
			</div>
		</div>
	</fieldset>
	<fieldset>
	
		<div class="col-md-6 form-group ">
			<label class="col-md-3 form-label"><b>신청자</b></label>
			<div class="col-md-9" >
				<input type="text" class="form-control inputBox"/>
			</div>
		</div>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>결재유형</b></label>
			<div class="col-md-9">
			
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<c:forEach var="ComboList17" items="${ComboList17}">
						<option value="<c:out value="${ComboList17.codeid}"/>"><c:out value="${ComboList17.codename}"/></option>
						</c:forEach>
					</select>		
			
			</div>
		</div>	
	</fieldset>

	<fieldset>
	
		<div class="col-md-6 form-group ">
			<label class="col-md-3 form-label"><b>승인요청상태</b></label>
			<div class="col-md-9" >
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<c:forEach var="ApprComboList" items="${ApprComboList}">
						
						<option value="<c:out value="${ApprComboList.codeid}"/>"><c:out value="${ApprComboList.codename}"/></option>
						
						</c:forEach>
					</select>
			</div>
		</div>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>진행상태</b></label>
			<div class="col-md-9">
			
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<c:forEach var="StateComboList" items="${StateComboList}">
						<c:if test="${StateComboList.codeid ne '4'}">
						<option value="<c:out value="${StateComboList.codeid}"/>"><c:out value="${StateComboList.codename}"/></option>
						</c:if>
						</c:forEach>
					</select>	
			
			</div>
		</div>	
	</fieldset>
		
	<fieldset>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>신청업체명</b></label>
			<div class="col-md-9">
				<input type="text" class="form-control inputBox"/>
				
			</div>
		</div>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>세금계산서업체명</b></label>
			<div class="col-md-9">
			<div class="col-sm-10 form-button" >
				<input type="text" class="form-control inputBox"/>	
			</div>
			<div class="col-sm-2 form-button" >
				<button class="btn btn-default btn-primary" type="button">
					<i class="fa fa-search"></i> 검색
				</button>
			</div>

			</div>

		</div> 
	</fieldset>
	

	
	<!--  end of  form-horizontal tems_search  -->
	<!--  end of jarviswidget -->
	</div></div>

	<!-- end of widget-body -->
	</div>
	<!--  end of content -->			
    </div>
			


	
	<!-- -----------------------------------------------------------------------------------  -->
		
		
	<div role="content">
		<div class="dt-toolbar">
			<div class="col-sm-6">
				<div class="txt-guide">
					※ 업체명을 클릭하시면 상세정보창이 표시됩니다.
				</div>  
			</div>
			
			
			<div class="col-sm-6 text-right" >
				<button class="btn btn-default" onclick="javascript:javascript:fnPriceTypeSave();">
					결재유형 저장
				</button>
				<button class="btn btn-default" onclick="javascript:fnEqPriceType();">
					결제유형 같음
				</button>
				<button class="btn btn-default" onclick="javascript:alert();" >
					결재중 모달창
				</button>
			</div>
			
		</div>
			
		<div class="div-realgrid">	
			<div id="realgrid" style="width: 100%; height: 550px;"></div>
		</div>			

		<footer>
		<div class="dt-footbar">
			<div style="float:right;margin-left: 25px;">
			<button class="btn btn-primary" type="button" id="reqConfBtn" data-toggle="modal">
				<i class="fa fa-pencil"></i>
				의뢰승인요청
			</button>
			</div>
			
			
			<div class="input-group">
					<select class="form-control" id="select-1" style="width:160px;float:right;">
						<c:forEach var="StateComboList" items="${StateComboList}">
						<option value="<c:out value="${StateComboList.codeid}"/>"><c:out value="${StateComboList.codename}"/></option>
						</c:forEach>
					</select>
					
					<div class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="javascript:fnReqStateChange();">
							진행상태저장
						</button>
					</div>
			</div>
			
			
		</div>	
		</footer>
			
			
	<!-- end of realgrid Content -->		
	</div>
	
		
		
	
	<!-- -----------------------------------------------------------------------------------  -->
	

</div>	






<!-- 결재중 모달창------------------------------------------------------------------------ -->
<div class="modal fade" id="approveModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog apprDialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
        <h4 class="modal-title" id="myModalLabel">결재진행정보</h4>
      </div>
      <div class="modal-body apprBody">
			<div id="realgrid2" style="width: 100%; height: 200px;"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


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
				<div id="realgrid3" style="width: 260px; height: 200px;"></div>
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
				<div id="realgrid4" style="width:516px; height: 166px;"></div>
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
				<div id="realgrid5" style="width: 520px; height: 200px;"></div>
			</div>
			<div style="width: 50;height: 100%; display: table; float:left; margin:0 16px;">
				<div style="display: table-cell;vertical-align: middle;">
					<p>
						&nbsp;
					</p>
				</div>
			</div>
			<div  style="width: 286px; float:left;">
				<div id="realgrid6" style="width:286px; height: 200px;"></div>
			</div>
	      </div>
	    </div>
	  </div>
	  
<!-- end of modal  -->
</div>