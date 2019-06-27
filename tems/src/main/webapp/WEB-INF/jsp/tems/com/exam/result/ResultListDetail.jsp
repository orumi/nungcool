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
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<script src="<c:url value='/js/tems/common/stringutil.js'/>"></script>
<script src="<c:url value='/js/tems/common/priceutil.js'/>"></script>
<script src="<c:url value='/jquery/jquery.form.js'/>"></script>
<script>
		$(document).ready( function(){
    		$("#UserModal").on('hidden.bs.modal', function () {
    			dataProviderUser3.clearRows();
    		});
    		
    		 $("#UserModal").on('shown.bs.modal', function () {
   	 	    	gridViewUser1.resetSize();
   	            gridViewUser2.resetSize();
   	            gridViewUser3.resetSize();
   	 		 });	
		});
		
		$(function() {
			$("#frm").ajaxForm();
		})
</script>
<script>
	var gridView;
	var gridView2;
	var gridView3;
	var gridViewUser1;
	var gridViewUser2;
	var gridViewUser3;
	var dataProvider;
	var dataProvider2;
	var dataProvider3;
	var dataProviderUser1;
	var dataProviderUser2;
	var dataProviderUser3;
	var reqid = "${reqDetail.reqid}";
	var reportid = "${reqDetail.reportid}";
	var nullcnt = "${reqDetail.nullcnt}";
	
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    dataProvider = new RealGridJS.LocalTreeDataProvider();
	    gridView = new RealGridJS.TreeView("realgrid"); 
	    gridView.setDataSource(dataProvider);   
	    
	    dataProvider2 = new RealGridJS.LocalDataProvider();
	    gridView2 = new RealGridJS.GridView("realgrid2"); 
	    gridView2.setDataSource(dataProvider2);
	    
	    dataProvider3 = new RealGridJS.LocalDataProvider();
	    gridView3 = new RealGridJS.GridView("realgrid3"); 
	    gridView3.setDataSource(dataProvider3);
	    
	    dataProviderUser1 = new RealGridJS.LocalTreeDataProvider();
	    gridViewUser1 = new RealGridJS.TreeView("realgridUser1"); 
	    gridViewUser1.setDataSource(dataProviderUser1);
	    
	    dataProviderUser2 = new RealGridJS.LocalDataProvider();
	    gridViewUser2 = new RealGridJS.GridView("realgridUser2"); 
	    gridViewUser2.setDataSource(dataProviderUser2);
	    
	    dataProviderUser3 = new RealGridJS.LocalDataProvider();
	    gridViewUser3 = new RealGridJS.GridView("realgridUser3"); 
	    gridViewUser3.setDataSource(dataProviderUser3);
	    
	    //setOptions(gridView);
	    
	    var fields = [
			{fieldName: "itemid"}
			,{fieldName: "adminnm"}
			,{fieldName: "smpid"}
			,{fieldName: "timecondunit"}
			,{fieldName: "remark"}
			,{fieldName: "annotation"}
			,{fieldName: "unitid"}
			,{fieldName: "displayunit"}
			,{fieldName: "itemname"}
			,{fieldName: "methodid"}
			,{fieldName: "itempid"}
			,{fieldName: "itemterm"}
			,{fieldName: "itemvalue"}
			,{fieldName: "orderby"}
			,{fieldName: "resulttype"}
			,{fieldName: "basicunitnm"}
			,{fieldName: "tempunit"}
			,{fieldName: "cooperyn"}
			,{fieldName: "resultvalue"}
			,{fieldName: "basiccond"}
			,{fieldName: "condid"}
			,{fieldName: "resultid"}
			,{fieldName: "tempercond"}
			,{fieldName: "etc"}
			,{fieldName: "etcunit"}
			,{fieldName: "basicunit"}
			,{fieldName: "itemregid"}
			,{fieldName: "methodnm"}
			,{fieldName: "condetc"}
			,{fieldName: "treefield"}
			,{fieldName: "adminid"}
			,{fieldName: "timecond"}
			,{fieldName: "reqid"}
			,{fieldName: "displaytype"}
			,{fieldName: "calc"}
			,{fieldName: "reference"}
	    ];
	    
	    //DataProvider의 setFields함수로 필드를 입력합니다.
	    dataProvider.setFields(fields);

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns = [
    		{
    			name: "itemname",
    			fieldName: "itemname",
    			header : {
    				text: "검사항목명"
    			},
    			styles: {
    		        textAlignment: "near"
    		    },
    		    readOnly : "true",
    			width: 250
    		},
    		{
    			name: "unitid",
    			fieldName: "unitid",
    			header : {
    				text: "표준\n단위"
    			},
    			readOnly : "true",
    			width: 60
    		},
    		{
    			name: "displayunit",
    			fieldName: "displayunit",
    			header : {
    				text: "성적서\n단위"
    			},
    			width: 60
    		},
    		{
                type: "group",
                name: "시험조건",
                width: 160,
                columns: [{
	                	name: "condid",
	                	fieldName: "condid",
	               	 	header: {
	                    	text: "선택"
	          	    	},
	          	    	lookupDisplay: true,
	                    lookupSourceId: "lookID2",
	                    lookupKeyFields: ["itemid", "condid"],
	                    editor: {
	                        "type": "dropDown",
	                        "dropDownCount": 3
	                    },
	                    editButtonVisibility: "always",
	               	 	width: 80
	            	},
                	{
                        name: "condetc",
                        fieldName: "condetc",
                        header: {
                            text: "기타"
                        },
                        readOnly : "true",
                        width: 80
                    }
      			]
			},
    		{
    			name: "resulttype",
    			fieldName: "resulttype",
    			header : {
    				text: "결과유형"
    			},
    			editor: {
                    "type": "dropDown",
                    "dropDownCount": 10
                },
                lookupDisplay: true,
                editButtonVisibility: "always",
    			width: 100
    		},
    		{
    			name: "displaytype",
    			fieldName: "displaytype",
    			header : {
    				text: "결과보고"
    			},
    			width: 80
    		},
			{
    			name: "itemvalue",
    			fieldName: "itemvalue",
    			header : {
    				text: "측정값"
    			},
    			width: 80
    		},
			{
    			name: "resultvalue",
    			fieldName: "resultvalue",
    			header : {
    				text: "시험결과"
    			},
    			width: 80
    		},
    		{
    			name: "annotation",
    			fieldName: "annotation",
    			header : {
    				text: "주석"
    			},
    			width: 100
    		},  
    		{
    			name: "methodnm",
    			fieldName: "methodnm",
    			header : {
    				text: "시험방법"
    			},
    			styles: {textAlignment: "near"},
    			renderer: {
    	            "url": "javascript:void(0)",
    	            "type": "link",
    	            "requiredFields": "reqid",
    	            "showUrl": false,
    	            "color":"blue"
    	        },
    			readOnly : "true",
    			width: 150
    		},
    		{
    			name: "reference",
    			fieldName: "reference",
    			header : {
    				text: "참조"
    			},
    			readOnly : "true",
    			width: 80
    		},
    		{
    			name: "itemregid",
    			fieldName: "itemregid",
    			header : {
    				text: "작성자"
    			},
    			readOnly : "true",
    			width: 80
    		},
			{
    			name: "cooperyn",
    			fieldName: "cooperyn",
    			header : {
    				text: "협조본부\n(진행상태)"
    			},
    			readOnly : "true",
    			width: 80
    		},
    		{
    			name: "adminnm",
    			fieldName: "adminnm",
    			header : {
    				text: "담당자"
    			},
    			readOnly : "true",
    			button: "action",
    			buttonVisibility : "always",
    			width: 130
    		}
	    ];
	    
	    var fields2 = [
   			{fieldName: "itemvalue"}
			,{fieldName: "itemid"}
			,{fieldName: "resultid"}
			,{fieldName: "calnm"}
			,{fieldName: "calid"}
			,{fieldName: "methodid"}
			,{fieldName: "itempid"}
			,{fieldName: "regid"}
			,{fieldName: "regdate"}
			,{fieldName: "modifyid"}
			,{fieldName: "modifydate"}
			,{fieldName: "itemnm"}
			,{fieldName: "calc"}
   	    ];
   	    
   	    //DataProvider의 setFields함수로 필드를 입력합니다.
   	    dataProvider2.setFields(fields2);

   	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
   	    var columns2 = [
       		{
       			name: "itemnm",
       			fieldName: "itemnm",
       			header : {
       				text: "검사항목명"
       			},
       			styles: {
       		        textAlignment: "near",
       		     	textWrap:"normal"
       		    },
       		 	mergeRule: { criteria: "value" },
       			width: 250
       		},
       		{
       			name: "calc",
       			fieldName: "calc",
       			header : {
       				text: "산식"
       			},
       			styles: {
       		        textAlignment: "near",
	       		    textWrap:"normal"
       		    },
       		 	mergeRule: { criteria: "values['itemnm'] + value" },
       			width: 250
       		},
       		{
       			name: "calnm",
       			fieldName: "calnm",
       			header : {
       				text: "속성명"
       			},
       			styles: {
       		        textAlignment: "near"
       		    },
       			width: 200
       		},
       		{
       			name: "calid",
       			fieldName: "calid",
       			header : {
       				text: "속성코드"
       			},
       			width: 80
       		},
       		{
       			name: "itemvalue",
       			fieldName: "itemvalue",
       			header : {
       				text: "결과값"
       			},
       			width: 80
       		}
   	    ];
   	    
  		var fields3 = [
              	{fieldName: "smpfid"}
				,{fieldName: "reqid"}
				,{fieldName: "smpid"}
				,{fieldName: "filepath"}
				,{fieldName: "orgname"}
				,{fieldName: "savename"}
				,{fieldName: "filesize"}
				,{fieldName: "regid"}
				,{fieldName: "regdate"}
          ];

          //DataProvider의 setFields함수로 필드를 입력합니다.
          dataProvider3.setFields(fields3);

          //필드와 연결된 컬럼 배열 객체를 생성합니다.
          var columns3 = [
              {
                  name: "orgname",
                  fieldName: "orgname",
                  header: {text: "파일명"},
                  width: 200,
                  styles: {textAlignment: "near"},
                  renderer: {
      	            "url": "javascript:void(0)",
      	            "type": "link",
      	            "requiredFields": "reqid",
      	            "showUrl": false,
      	            "color":"blue"
	      	      },
                  readOnly: "true"
              },
              {
                  name: "filesize",
                  fieldName: "filesize",
                  header: {text: "사이즈"},
                  width: 100,
                  styles: {textAlignment: "far"},
                  readOnly: "true"
              },
              {
                  name: "",
                  fieldName: "",
                  header: {text: "삭제"},
                  width: 30,
                  button: "action",
      			  buttonVisibility : "always",
                  readOnly: "true"
              }
              
          ];
          

	    //담당자 추가 모달
	    var fieldsUser1 = [
              {fieldName: "treeview"}
              , {fieldName: "officeid"}
              , {fieldName: "name"}
              , {fieldName: "uppofficeid"}
              , {fieldName: "uppname"}
          ];

          //DataProvider의 setFields함수로 필드를 입력합니다.
          dataProviderUser1.setFields(fieldsUser1);

          //필드와 연결된 컬럼 배열 객체를 생성합니다.
          var columnsUser1 = [
              {
                  name: "name",
                  fieldName: "name",
                  header: {text: "부서명"},
                  width: 150,
                  styles: {textAlignment: "near"},
                  readOnly: "true"
              }
          ];
          
          
          var fieldsUser2 = [
             {fieldName: "adminid"}
             , {fieldName: "officeid"}
             , {fieldName: "authorgpcode"}
             , {fieldName: "name"}
             , {fieldName: "adminpw"}
             , {fieldName: "uppofficeid"}
             , {fieldName: "empid"}
             , {fieldName: "ename"}
             , {fieldName: "cellphone"}
             , {fieldName: "telno"}
             , {fieldName: "extension"}
             , {fieldName: "email"}
             , {fieldName: "umjpname"}
             , {fieldName: "umjdname"}
             , {fieldName: "umpgname"}
             , {fieldName: "birthday"}
             , {fieldName: "skin"}
             , {fieldName: "useflag"}
         ];

         //DataProvider의 setFields함수로 필드를 입력합니다.
         dataProviderUser2.setFields(fieldsUser2);

         //필드와 연결된 컬럼 배열 객체를 생성합니다.
         var columnsUser2 = [
             {
                 name: "name",
                 fieldName: "name",
                 header: {text: "이름"},
                 width: 350,
                 readOnly: "true"
             },
             {
                 name: "umjpname",
                 fieldName: "umjpname",
                 header: {text: "직위"},
                 width: 350,
                 readOnly: "true"
             },
             {
                 name: "umjdname",
                 fieldName: "umjdname",
                 header: {text: "직책"},
                 width: 350,
                 readOnly: "true"
             }
         ];
         
         var fieldsUser3 = [
             {fieldName: "adminid"}
             , {fieldName: "name"}
             , {fieldName: "empid"}
             , {fieldName: "umjpname"}
             , {fieldName: "umjdname"}
             , {fieldName: "umpgname"}
         ];

         //DataProvider의 setFields함수로 필드를 입력합니다.
         dataProviderUser3.setFields(fieldsUser3);

         //필드와 연결된 컬럼 배열 객체를 생성합니다.
         var columnsUser3 = [
			{
			    name: "adminid",
			    fieldName: "adminid",
			    header: {text: "아이디"},
			    width: 350,
			    readOnly: "true"
			},
             {
                 name: "name",
                 fieldName: "name",
                 header: {text: "이름"},
                 width: 350,
                 readOnly: "true"
             }
         ];
         
         gridView.addCellStyle("style01", {
             "background": "#4400ff00"
         });
         
         
         //컬럼을 GridView에 입력 합니다.
 	    gridView.setColumns(columns);
 	    gridView2.setColumns(columns2);
 	    gridView3.setColumns(columns3);
 	    
 	   	gridViewUser1.setColumns(columnsUser1);
 	 	gridViewUser2.setColumns(columnsUser2);
 	 	gridViewUser3.setColumns(columnsUser3);
 	    
 	    /* 헤더의 높이를 지정*/
 	    gridView.setHeader({
 	    	height: 45
 	    }); 
 	    
 	    
 	    var cellDefaultStyles = [{
	        criteria: "value like '%반%'",
	        styles: "background=rgb(255, 43, 43)"
	    }];
	    
	    
	    gridView.setStyles(smart_style);
	    gridView.setStyles({
	        body: {
	            cellDynamicStyles: cellDefaultStyles
	        }
	    });
 	    gridView2.setStyles(smart_style);
 	    gridView3.setStyles(smart_style);
 	    
 	   	gridViewUser1.setStyles(smart_style);
 	  	gridViewUser2.setStyles(smart_style);
 	 	gridViewUser3.setStyles(smart_style);
 	 	
 	 	gridView.setLookups([
   	        {"id": "lookID2","levels": 2}
   	    ]);
 	    
 	    
 	    /* 그리드 row추가 옵션사용여부 */
 	    gridView.setOptions({
 	    	panel : { visible : false },
 	    	footer : { visible : false }
 	    });
 	    
 	    gridView2.setOptions({
 	    	panel : { visible : false },
 	    	footer : { visible : false },
 	    	display: {
                fitStyle: "evenFill"
            }
 	    });
 	    
 	    gridView3.setOptions({
             panel: {visible: false},
             footer: {visible: false},
             checkBar: {visible: false},
             display: {
                 fitStyle: "evenFill"
             }
         });
 	    
 	   	gridViewUser1.setOptions({
           	panel: {visible: false},
           	footer: {visible: false},
           	checkBar: {visible: false},
           	display: {
               	fitStyle: "evenFill"
           	}
       	});
 	   	
 	   gridViewUser2.setOptions({
          	panel: {visible: false},
          	footer: {visible: false},
          	checkBar: {visible: false},
          	display: {
              	fitStyle: "evenFill"
          	}
      	});
 	   
 	  	gridViewUser3.setOptions({
         	panel: {visible: false},
         	footer: {visible: false},
         	checkBar: {visible: false},
         	display: {
             	fitStyle: "evenFill"
         	}
     	});

       
         //담당자 추가 모달

	    
	    /************************ 
	    	그리드 이벤트 핸들러  
	    *************************/
	    gridView.onCurrentRowChanged = function (grid, oldRow, newRow) {   
	        var itemindex = gridView.getItemsOfRows([newRow]);
	        var cyn = gridView.getValue(itemindex[0],"cooperyn");
        	 
        	var readOnly = "";
        	if(cyn != "null"){readOnly = "true"} else {readOnly = "false"};
	        gridView.setColumnProperty("itemvalue", "readOnly",readOnly);
	        gridView.setColumnProperty("resultvalue", "readOnly",readOnly);
	    };
	    
	    gridView.onCellButtonClicked = function (grid, itemIndex, column) {
	    		$("#UserModal").modal();
	    		 
    			var adminid = gridView.getValue(itemIndex,"adminid");
    			var adminnm = gridView.getValue(itemIndex,"adminnm");
    			if(adminid != null){
	    			var adminids = adminid.split(",");
	    			var adminnms = adminnm.split(",");
	    			
	    			for(var i=0;i<adminids.length;i++){
	    			var row = {
    				    adminid : adminids[i],
    				    name : adminnms[i]
	    			}
	    			dataProviderUser3.addRow(row);
	    			}
    			}
    			
	 	    	$.ajax({
	 	            type: "post",
	 	            dataType: "json",
	 	            url: "<c:url value='/system/selOfficeList.json'/>",
	 	            success: function (data) {
	 	            	dataProviderUser1.setRows(data, "treeview", true, "", "");
	 	            },
	 	            error: function (request, status, error) {
	 	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	 	            },
	 	            complete: function (data) {
	 	            	gridViewUser1.expandAll();
	 	                var options = {
	     			        fields:['officeid'],
	     			        values:['<%=nLoginVO.getOfficeid()%>']
	     			    }
	     			    var itemindex = gridViewUser1.searchItem(options);
	                 	
	 	               gridViewUser1.setCurrent({itemIndex:itemindex, column:"name"});
	 	            },
	 	            cache: false
	 	        });	
	    };
	    
	    //dataProvider.onValueChanged = function (provider, rowId, field) {
	    dataProvider.onValueChanged = function (provider, rowId, field) {	
	    	var itemIndex = gridView.getItemIndex(rowId); 	
	    	editRvalue(itemIndex, field);
	    } 

	    gridView.onCellEdited =  function (grid, itemIndex, dataRow, field) {
	    	editRvalue(itemIndex, field);
	    } 
	    
	    

	    
	    //산식저장
	    gridView2.onCellEdited =  function (grid, itemIndex, dataRow, field) {
        	var calc = gridView2.getValue(itemIndex,"calc");
        	var resultid = gridView2.getValue(itemIndex,"resultid");
        	
        	for(var i=0; i<=gridView2.getItemCount(); i++){
        		var itemvalue = gridView2.getValue(i,"itemvalue");
        		var calid = gridView2.getValue(i,"calid");

        		if(resultid == gridView2.getValue(i,"resultid") && itemvalue != null){
        			//calc = calc.replace(calid, itemvalue);
        			calc = calc.split(calid).join(itemvalue);
        		}
        	}
        	if(calc.indexOf("X") == '-1'){
        		//alert(eval(calc));
        		var options = {
    			        fields:['resultid'],
    			        values:[resultid]
    			    }
            	var item = gridView.searchItem(options);
        		//산식 함수 치환 
        		gridView.setValue(item,"itemvalue",eval(calc.replace(/POWER/gi,"Math.pow").replace(/EXP/gi,"Math.exp").replace(/LN/gi,"Math.log").replace(/ABS/gi,"Math.abs")));
        	}        	
	    }
	    	
	    gridViewUser1.onCurrentChanged = function (grid, index) {
            var officeid = gridViewUser1.getValue(index.itemIndex, "officeid");
            $.ajax({
                type: "post",
                dataType: "json",
                data: {"officeid": officeid},
                url: "<c:url value='/system/selOfficeUserList.json'/>",
                success: function (data) {
                    dataProviderUser2.fillJsonData(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                },
                complete: function (data) {
                    //gridView.hideToast();
                },
                cache: false
            });
        };
        
        ///항목담당자 선택
        gridViewUser2.onDataCellDblClicked =  function (grid, index) {
   			var row = {
			    adminid : gridViewUser2.getValue(index.itemIndex,"adminid"),
			    name : gridViewUser2.getValue(index.itemIndex,"name")
   			};
   			dataProviderUser3.addRow(row);
        };
        
        ///항목담당자 삭제
        gridViewUser3.onDataCellDblClicked =  function (grid, index) {
        	gridViewUser3.deleteSelection(true);
        };
        
        
        ////시험방법 링크
        gridView.onLinkableCellClicked = function (grid, index, url) {
        	var methodname = gridView.getValue(index.itemIndex,"methodnm").split(":")[0].replace(/ /gi,"");
	    		//window.open("http://10.1.10.80/ekp/standard/StandardFileDownPage.bzr?cabinetInstanceID=1036&kname="+methodname);
	    		window.open("http://portal.kpetro.or.kr/ekp/Standard/StandardFileDownPage.bzr?PRASNO="+methodname);
	    		
	    };
	    
	    
	    //첨부파일 다운
	    gridView3.onLinkableCellClicked = function (grid, index, url) {
        	var filenick = gridView3.getValue(index.itemIndex,"filepath");
        	var fileName = gridView3.getValue(index.itemIndex,"orgname");
	    		window.open("<c:url value='/common/getFileDown.json?filenick="+filenick+"&fileName="+fileName+"'/>");
	    };
	    
	    
	    ////첨부파일 삭제
	    gridView3.onCellButtonClicked = function (grid, itemIndex, column) {
	    	var cmbsmpid = $("#cmbsmpid").val();
	    	var smpfid = gridView3.getValue(itemIndex,"smpfid");
	    	var filepath = gridView3.getValue(itemIndex,"filepath");
			$.ajax({
				type : "post",
			    dataType : "json",
			    data : {"reqid":reqid,"smpid":cmbsmpid,"smpfid":smpfid,"filepath":filepath},
	            url: "<c:url value='/common/delSampleFile.json'/>",
	            success: function (data) {
	            	fnGetSmpFileList();
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            },
	            complete: function (data) {

	            },
	            cache: false
	        });
    	};
        
        //그리드 이벤트 끝
        
        fnGetReqResultList();
        fnGetSmpFileList();
	});	    
	
	function editRvalue(itemIndex, field){
    	if("resulttype" == dataProvider.getOrgFieldName(field)){
    		var rtype = gridView.getValue(itemIndex,"resulttype");
    		var displaytype = gridView.getValue(itemIndex,"displaytype");
    		//var displaytype = "0.01";
    		var digit = 0;
    		var itemvalue = String(gridView.getValue(itemIndex,"itemvalue"));
    		if(itemvalue == null){return}
    		if(rtype == "34"){		//수치맺음
    			if(displaytype == null){return}
    			digit = displaytype.substr(displaytype.indexOf(".")+1,displaytype.length).length;
    			if(digit > 0){
    				var fiveyn = itemvalue.substr(itemvalue.indexOf(".")+digit+1,1);
					if(fiveyn == "5"){
						
						var chkindex = ["0","2","4","6","8"];
						var chkindex2 = ["1","3","5","7","9"];
						
						if(itemvalue.substr(itemvalue.indexOf(".")+digit+2) ==""){			//5다음 숫자가 없을때
							if(chkindex.indexOf(itemvalue.substr(itemvalue.indexOf(".")+digit,1)) != "-1"){		//끝수가 짝수일때
								gridView.setValue(itemIndex,"resultvalue",floorXL(eval(itemvalue),eval(digit)));		
							} else if(chkindex2.indexOf(itemvalue.substr(itemvalue.indexOf(".")+digit,1)) != "-1"){	//끝수가 홀수일때
								gridView.setValue(itemIndex,"resultvalue",roundXL(eval(itemvalue),eval(digit)));	
							}
						} else {
							gridView.setValue(itemIndex,"resultvalue",roundXL(eval(itemvalue),eval(digit)));
						}
					} else {
						gridView.setValue(itemIndex,"resultvalue",roundXL(eval(itemvalue),eval(digit)));
					}
    			}
    		} else if(rtype == "35"){ //구간방식	a<x<b등등......
    			var x = itemvalue;
    			var y = 0;
    			var scripts = gridView.getValue(itemIndex,"displaytype").replace(/≥/gi,">=").replace(/≤/gi,"<=").replace(/＜/gi,"<").replace(/＞/gi,">").split(",");
    			var script = "";
    			var endvalue = "";
    			if(scripts.length > 0){
					for(var i=0;i<scripts.length;i++){
	    				if(i==0){	    				
	    					script = script+"if("+scripts[i].split(":")[0]+"){y="+scripts[i].split(":")[1]+"}";
	    				} else{
							script = script+"else if("+scripts[i].split(":")[0]+"){y="+scripts[i].split(":")[1]+"}";
	    				}
    				}
    			}
    			var endvalue = eval(script);
    			gridView.setValue(itemIndex,"resultvalue",endvalue);
    		} else if(rtype == "36"){ //정수	반올림
    			gridView.setValue(itemIndex,"resultvalue",Math.round(itemvalue));
    		} else if(rtype == "37"){ //5단위 표기
    			
    			var lastvalue = itemvalue.substr(itemvalue.length-1,1);
    			if(lastvalue < 5){//0,1,2는 0 3,4 는 5로 표기
    				if(lastvalue >= 3){
    					itemvalue = itemvalue.substr(0,itemvalue.length-1)+"5";
    				} else {
    					itemvalue = itemvalue.substr(0,itemvalue.length-1)+"0";
    				}
    				gridView.setValue(itemIndex,"resultvalue",itemvalue);
    			} else {		//5보다 크면 반올림
    				digit = itemvalue.substr(itemvalue.indexOf(".")+2,itemvalue.length).length;
    				if(itemvalue.indexOf(".") != "-1"){
    					gridView.setValue(itemIndex,"resultvalue",roundXL(eval(itemvalue),eval(digit))+"0");
    				} else {
    					gridView.setValue(itemIndex,"resultvalue",Math.round(itemvalue/10)*10);
    				}
    			}
    		} else if(rtype == "38"){ //Text
    			gridView.setValue(itemIndex,"resultvalue",gridView.getValue(itemIndex,"itemvalue"));
    		} else if(rtype == "39"){ //10진법
    			gridView.setValue(itemIndex,"resultvalue",Math.round(gridView.getValue(itemIndex,"itemvalue")));
    		} else if(rtype == "40"){ //3배수
    			if(itemvalue % 3 == "1"){	//3배수 내림
    				gridView.setValue(itemIndex,"resultvalue",Math.floor(itemvalue/3)*3);
    			} else if(itemvalue % 3 == "2") {	//3배수 올림
    				gridView.setValue(itemIndex,"resultvalue",Math.round(itemvalue/3)*3);
    			} else {
    				gridView.setValue(itemIndex,"resultvalue",itemvalue);
    			}
    		} else if(rtype == "41"){ //2.5배수
    			if(itemvalue % 2.5 == 0){	//나머지 0
    				gridView.setValue(itemIndex,"resultvalue",itemvalue);
    			} else if(itemvalue % 2.5 < 1.25){	//2.5배수 내림
    				gridView.setValue(itemIndex,"resultvalue",parseInt(itemvalue / 2.5)*2.5);
    			} else if(itemvalue % 2.5 >= 1.25) {	//2.5배수 올림
    				gridView.setValue(itemIndex,"resultvalue",Math.round(itemvalue / 2.5)*2.5);
    			} else {
    				gridView.setValue(itemIndex,"resultvalue",itemvalue);
    			}
    		}
    	} else if("itemvalue" == dataProvider.getOrgFieldName(field)){
    		var rtype = gridView.getValue(itemIndex,"resulttype");
    		var displaytype = gridView.getValue(itemIndex,"displaytype");
    		//var displaytype = "0.01";
    		var digit = 0;
    		var itemvalue = String(gridView.getValue(itemIndex,"itemvalue"));
    		if(rtype == null){return}
    		if(rtype == "34"){		//수치맺음
    			if(displaytype == null){return}
    			digit = displaytype.substr(displaytype.indexOf(".")+1,displaytype.length).length;
    			if(digit > 0){
    				var fiveyn = itemvalue.substr(itemvalue.indexOf(".")+digit+1,1);
					if(fiveyn == "5"){
						var chkindex = ["0","2","4","6","8"];
						var chkindex2 = ["1","3","5","7","9"];
						
						if(itemvalue.substr(itemvalue.indexOf(".")+digit+2) ==""){			//5다음 숫자가 없을때
							if(chkindex.indexOf(itemvalue.substr(itemvalue.indexOf(".")+digit,1)) != "-1"){		//끝수가 짝수일때
								gridView.setValue(itemIndex,"resultvalue",floorXL(eval(itemvalue),eval(digit)));		
							} else if(chkindex2.indexOf(itemvalue.substr(itemvalue.indexOf(".")+digit,1)) != "-1"){	//끝수가 홀수일때
								gridView.setValue(itemIndex,"resultvalue",roundXL(eval(itemvalue),eval(digit)));	
							}
						} else {
							gridView.setValue(itemIndex,"resultvalue",roundXL(eval(itemvalue),eval(digit)));
						}
					} else {
						gridView.setValue(itemIndex,"resultvalue",roundXL(eval(itemvalue),eval(digit)));
					}
    			}
    		} else if(rtype == "35"){ //구간방식	a<x<b등등......
    			var x = itemvalue;
    			var y = 0;
    			var scripts = gridView.getValue(itemIndex,"displaytype").replace(/≥/gi,">=").replace(/≤/gi,"<=").replace(/＜/gi,"<").replace(/＞/gi,">").split(",");
    			var script = "";
    			var endvalue = "";
    			if(scripts.length > 0){
					for(var i=0;i<scripts.length;i++){
	    				if(i==0){	    				
	    					script = script+"if("+scripts[i].split(":")[0]+"){y="+scripts[i].split(":")[1]+"}";
	    				} else{
							script = script+"else if("+scripts[i].split(":")[0]+"){y="+scripts[i].split(":")[1]+"}";
	    				}
    				}
    			}
    			var endvalue = eval(script);
    			gridView.setValue(itemIndex,"resultvalue",endvalue);
    		} else if(rtype == "36"){ //정수	반올림
    			gridView.setValue(itemIndex,"resultvalue",Math.round(itemvalue));
    		} else if(rtype == "37"){ //5단위 표기
    			
    			var lastvalue = itemvalue.substr(itemvalue.length-1,1);
    			if(lastvalue < 5){//0,1,2는 0 3,4 는 5로 표기
    				if(lastvalue >= 3){
    					itemvalue = itemvalue.substr(0,itemvalue.length-1)+"5";
    				} else {
    					itemvalue = itemvalue.substr(0,itemvalue.length-1)+"0";
    				}
    				gridView.setValue(itemIndex,"resultvalue",itemvalue);
    			} else {		//5보다 크면 반올림
    				digit = itemvalue.substr(itemvalue.indexOf(".")+2,itemvalue.length).length;
    				if(itemvalue.indexOf(".") != "-1"){
    					gridView.setValue(itemIndex,"resultvalue",roundXL(eval(itemvalue),eval(digit))+"0");
    				} else {
    					gridView.setValue(itemIndex,"resultvalue",Math.round(itemvalue/10)*10);
    				}
    			}
    		} else if(rtype == "38"){ //Text
    			gridView.setValue(itemIndex,"resultvalue",gridView.getValue(itemIndex,"itemvalue"));
    		} else if(rtype == "39"){ //10진법
    			gridView.setValue(itemIndex,"resultvalue",Math.round(gridView.getValue(itemIndex,"itemvalue")));
    		} else if(rtype == "40"){ //3배수
    			if(itemvalue % 3 == "1"){	//3배수 내림
    				gridView.setValue(itemIndex,"resultvalue",Math.floor(itemvalue/3)*3);
    			} else if(itemvalue % 3 == "2") {	//3배수 올림
    				gridView.setValue(itemIndex,"resultvalue",Math.round(itemvalue/3)*3);
    			} else {
    				gridView.setValue(itemIndex,"resultvalue",itemvalue);
    			}
    		} else if(rtype == "41"){ //2.5배수
    			if(itemvalue % 2.5 == 0){	//나머지 0
    				gridView.setValue(itemIndex,"resultvalue",itemvalue);
    			} else if(itemvalue % 2.5 < 1.25){	//2.5배수 내림
    				gridView.setValue(itemIndex,"resultvalue",parseInt(itemvalue / 2.5)*2.5);
    			} else if(itemvalue % 2.5 >= 1.25) {	//2.5배수 올림
    				gridView.setValue(itemIndex,"resultvalue",Math.round(itemvalue / 2.5)*2.5);
    			} else {
    				gridView.setValue(itemIndex,"resultvalue",itemvalue);
    			}
    		}
    	} 
		
	}
	
	function setOptions(tree) {
	    tree.setOptions({
	        summaryMode: "aggregate",
	        stateBar: {
	            visible: false
	        }
	    });
	 
	    tree.addCellStyle("style01", {
	        background: "#cc6600",
	        foreground: "#ffffff"
	    });
	}
	
	function fnExpand(){
		 gridView.expandAll();
	}
	
	
	function fnGoList(){
		window.location.href="<c:url value='/officialExam/result/ResultList.do'/>";
	}
	
	function fnGetReqResultList(){
		var cmbsmpid = $("#cmbsmpid").val();
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"reqid":reqid,"smpid":cmbsmpid},
            url: "<c:url value='/officialExam/result/getResultList.json'/>",
            success: function (data) {
            	dataProvider.setRows(data.ResultList,"treefield", true, "", "");
            	dataProvider2.fillJsonData(data.CalcList);
            	var labels =new Array();
        		var values =new Array();
        		var icnt = 0;
        		
        		<c:forEach var="ComboList18" items="${ComboList18}">
        		values[icnt] = "<c:out value='${ComboList18.codeid}'/>";
        		labels[icnt] = "<c:out value='${ComboList18.codename}'/>";
        		icnt++;
        		</c:forEach>
        		
        		
        		var column = gridView.columnByName("resulttype");
        		column.labels = labels;
        		column.values = values;
        		gridView.setColumn(column); 
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	gridView.expandAll();
            	fnGetLookup();
            },
            cache: false
        });
	}
	
	function fnGetSmpFileList(){
		var cmbsmpid = $("#cmbsmpid").val();
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"reqid":reqid,"smpid":cmbsmpid},
            url: "<c:url value='/common/getSampleFile.json'/>",
            success: function (data) {
            	dataProvider3.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	gridView3.closeProgress();
            },
            cache: false
        });
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
	            	dataProvider.clearRowStates(true);
	                fnGetReqResultList();
	            } else {
	                alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	            }
	        },
	        error : function(request, status, error) {
	            alert("code:" + request.status + "\n" + "error:" + error);
	        },
            complete: function (data) {
            	gridView.expandAll();
            	//fnRePrice(gridView, dataProvider);
            },
            cache: false
	    });
	}
	
	function saveDataConfirm(urlStr,data) {
	    $.ajax({
	        url : urlStr,
	        type : "post",
	        data : data,
	        dataType : "json",
	        success : function(data) {
	            if (data.RESULT_YN =="Y") {
	            	alert("정상 처리 되었습니다.");            	
	            	$("#reqConfModal").modal('hide');
	            	window.location.href="<c:url value='/officialExam/result/ResultList.do'/>";
	            } else {
	                alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	            }
	        },
	        error : function(request, status, error) {
	            alert("code:" + request.status + "\n" + "error:" + error);
	        },
            complete: function (data) {
            },
            cache: false
	    });
	}
	
    function fnUserAdd(){
    	var data = dataProviderUser3.getRows(0, -1);
    	var adminid = "";
    	var adminnm = "";
    	for(var i=0;i < data.length; i++){
    		if(i==0){
    			adminid = adminid+data[i][0];
        		adminnm = adminnm+data[i][1];
    		} else {
    			adminid = adminid+","+data[i][0];
        		adminnm = adminnm+","+data[i][1];
    		}
    	}
    	var crow = gridView.getCurrent();
    	gridView.setValue(crow.itemIndex,"adminid",adminid);
    	gridView.setValue(crow.itemIndex,"adminnm",adminnm);
    	
    	$("#UserModal").modal('hide');
    }
    
    function fnSaveResult(){
    	gridView.commit();
    	
    	var state;
	    var jData;
	    var jRowsData = [];
	    
	    var rows = dataProvider.getAllStateRows();
	    //var rows = gridView.getCheckedRows();
	    
	    if(rows.updated.length > 0){
	        for(var i=0; i < rows.updated.length; i++){
	            jData = dataProvider.getJsonRow(rows.updated[i]);
	            jData.state = "updated";
	            jRowsData.push(jData);
	        };
	    }

	    if (jRowsData.length == 0) {
	    	alert("선택된 내용이 없습니다.");
	        dataProvider.clearRowStates(true);
	        return;
	    }
	    
	    var state2;
	    var jData2;
	    var jRowsData2 = [];

	    var rows2 = dataProvider2.getAllStateRows();
	    
	    if(rows2.updated.length > 0){
	        for(var i=0; i < rows2.updated.length; i++){
	            jData2 = dataProvider2.getJsonRow(rows2.updated[i]);
	            jData2.state = "updated";
	            jRowsData2.push(jData2);
	        };
	    }
	    
	    
	    var val = JSON.stringify(jRowsData);
	    var caldata = JSON.stringify(jRowsData2);
	    var data = {"data":val,"caldata":caldata};
	    if(confirm("선택된 내용을 \n 저장 하시겠습니까?")){
	    	saveData("<c:url value='/officialExam/result/upResultDetail.json'/>",data);
	    }
    }
    
    
    function fnConfirm(){
    	$("#reqConfModal").modal('show');
		selModal();
    }
    
    function lookupDataChange(data2) {
        var lookups = [];
        for (var i = 0; i < data2.length; i++) {
            var json = data2[i];
            var lookupetc = [json.itemid, '-1', '기타'];
            var lookup = [json.itemid, json.condid, json.testcond];
            lookups.push(lookup);
        }
        gridView.fillLookupData("lookID2", {
            rows: lookups
        })
    }
    
    function fnGetLookup(){
		var cmbsmpid = $("#cmbsmpid").val();
        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/common/getReqCondComboList.json'/>",
            data: {"reqid": reqid,"smpid":cmbsmpid},
            success: function (data) {
                lookupDataChange(data);
            },
            error : function(request, status, error) {
            	alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
	}
    
     function fnAttachSend(){
   	 	var form = $('form')[0];
   	    var formData = new FormData(form);
   	 	var smpid = $("#cmbsmpid").val();
   	 	var filesize = $("input[name=attach]")[0].files[0].size;
   	 	var maxsize = 10*1024*1024;	//10MB
   	    formData.append("uploadfile", $("input[name=attach]")[0].files[0]);
   	    formData.append("reqid", reqid);
   	 	formData.append("smpid", smpid);
   	 	gridView3.showProgress();
   	    $.ajax({
           url: "<c:url value='/common/fileattach.json'/>",
           processData: false,
           contentType: false,
           data: formData,
           type: 'POST',
           success: function(data){
       	    	fnGetSmpFileList();
           }
       });
    } 
     
     function fnAttachSubmit(){
    	var smpid = $("#cmbsmpid").val();
    	$("#reqid").val(reqid);
    	$("#smpid").val(smpid);
    	$("#frm").ajaxSubmit({
    		url: "<c:url value='/common/fileattach.json'/>",
            processData: false,
            contentType: false,
            type: 'POST',
            success: function(data){
       	    	fnGetSmpFileList();
            },
            error: function(){
              	alert("에러!");
            } 
    	})
     }
    
     function fnApprConf(){
 		apprView4.commit();
 		
 		var state;
 	    var jData;
 	    var jRowsData = [];
 	    
 		/* if(nullcnt > 0){
 			alert("결과 미등록 항목이 존재합니다.");
 			return;
 		} */
 	    
    	if(apprView4.getValue(0, "fstapprid") != null){
            jData = {
                "draftid": apprView4.getValue(0, "draftid"),
                "apprid": apprView4.getValue(0, "fstapprid"),
                "ordinal": "1"
            }
            jData.reqid = reqid;
            jData.reportid = reportid;
            jRowsData.push(jData);
    	}
    	
    	if(apprView4.getValue(0, "sndapprid") != null){
            jData = {
                "draftid": apprView4.getValue(0, "draftid"),
                "apprid": apprView4.getValue(0, "sndapprid"),
                "ordinal": "2"
            }
            jData.reqid = reqid;
            jData.reportid = reportid;
            jRowsData.push(jData);
    	}
    	
    	if(apprView4.getValue(0, "trdapprid") != null){
            jData = {
                "draftid": apprView4.getValue(0, "draftid"),
                "apprid": apprView4.getValue(0, "trdapprid"),
                "ordinal": "3"
            }
            jData.reqid = reqid;
            jData.reportid = reportid;
            jRowsData.push(jData);
    	}
    	
    	if(apprView4.getValue(0, "fthapprid") != null){
            jData = {
                "draftid": apprView4.getValue(0, "draftid"),
                "apprid": apprView4.getValue(0, "fthapprid"),
                "ordinal": "4"
            }
            jData.reqid = reqid;
            jData.reportid = reportid;
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
 	    	saveDataConfirm("<c:url value='/officialExam/result/inApprConf.json'/>",data);
 	    }
 	    
 	}
     
	function fnConfirmAll(){
    	$("#reqConfModal").modal('show');
		$("#reqConfModal").on('shown.bs.modal', function () {
			selModal();
    	});				
 	}
	
	function fnCooper(){
		$("#reqCooperModal").modal('show');
		selCoopModal();
	}

	function fnTest(){
		alert();
	}
</script>	
<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">


<!-- top button area  -->
	<div role="content">
		<div class="dt-toolbar border-bottom-solid">
			<div class="col-sm-6">
				<div class="txt-guide">
				</div>  
			</div>
			
			
			<div class="col-sm-6 text-right" >
				<button class="btn btn-primary" onclick="javascript:fnConfirmAll();">
					<i class="fa fa-krw"></i> 발급승인요청  
				</button>
				<button class="btn btn-default" onclick="javascript:fnGoList();">
					<i class="fa fa-th-list"></i> 목록
				</button>
			</div>
		
	<!-- end of div dt-toolbar content -->	
		</div>
		<div class="form-horizontal form-terms ui-sortable"> 
			<div class="jarviswidget jarviswidget-sortable" role="widget">	
				<div class="widget-body">
			
			
				<fieldset>
					<div class="col-md-4 form-group ">
						<label class="col-md-4 form-label">접수번호</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.acceptno }</span>
						</div>
					</div>
					<div class="col-md-4 form-group">
						<label class="col-md-4 form-label">접수일</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.receiptdate}</span>
						</div>
					</div>
					<div class="col-md-4 form-group ">
						<label class="col-md-4 form-label">성적서 발급예정일</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.issuedateplan}</span>
						</div>
					</div>
				</fieldset>
				
				<fieldset>
					<div class="col-md-4 form-group">
						<label class="col-md-4 form-label">시료건수</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.smpcnt}</span>
						</div>
					</div>
					<div class="col-md-4 form-group ">
						<label class="col-md-4 form-label">의뢰업체</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.comname}</span>
						</div>
					</div>
					<div class="col-md-4 form-group">
						<label class="col-md-4 form-label">진행상태</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.statenm}</span>
						</div>
					</div>
				</fieldset>		
				<fieldset>
					<div class="col-md-4 form-group">
						<label class="col-md-4 form-label">시험자에게 남기는글</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.itemdesc}</span>
						</div>
					</div>
					<div class="col-md-4 form-group ">
						<label class="col-md-4 form-label">비고</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.remark}</span>
						</div>
					</div>
					<div class="col-md-4 form-group">
						<label class="col-md-4 form-label">시험완료후시료처리</label>
						<div class="col-md-8">
							<span class="txt-sub-content">${reqDetail.itemafter}</span>
						</div>
					</div>
				</fieldset>
				<fieldset>
					<div class="col-md-12 form-group ">
						<label class="col-md-2 form-label col-11p">첨부파일</label>
						<div class="col-md-10 col-89p">
							<span class="txt-sub-content">
								<c:forEach var="reqAttachList" items="${reqAttachList}" varStatus="count">
									<a href="javascript:fnAttachDown('${reqAttachList.filepath}','${reqAttachList.orgname}')");">${reqAttachList.orgname}</a>
									<c:if test="${!count.last}">, </c:if>
								</c:forEach>						
							</span>
						</div>
					</div>
				</fieldset>			
				</div>
		</div>
	</div>	
</div>
	
<!--  신청 항목 창  -->	
	<div role="content">
		<div class="dt-toolbar">
			<div class="col-sm-5">
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
						<select class="form-control" style="height:33px;width: 100%;" id="cmbsmpid" name="cmbsmpid" onchange="javascript:fnGetReqResultList();">
						<c:forEach var="reqSmpList" items="${reqSmpList}">
							<option value="${reqSmpList.smpid}">${reqSmpList.smpname} / ${reqSmpList.mname}<c:if test="${reqSmpList.adminnm ne null}">(${reqSmpList.officenm}/${reqSmpList.adminnm})</c:if></option>
						</c:forEach>						
						</select>
					</div>
					<div class="" style="
					    float: left;
					    margin-bottom: 3px;
					    padding-bottom: 6px;
					    padding-top: 6px;
					    padding-right: 6px;
					    padding-left: 6px;
					    border-top: 1px solid #C1C1C1;
					    border-left: 1px solid #C1C1C1;
					    border-bottom: 1px solid #C1C1C1;
					    border-right: 1px solid #C1C1C1; 
					    background: #ECECEC;   
					">
					총시료개수 : ${reqDetail.smpcnt}
					</div>
				</div>
			</div>
			
			
			<div class="col-sm-7 text-right" >
				<button class="btn btn-primary" onclick="javascript:fnSaveResult();">
					<i class="fa fa-save"></i> 저장
				</button>
				<button class="btn btn-success" onclick="javascript:fnCooper();">
					<i class="fa fa-minus"></i> 시험항목 협조요청
				</button>
				<button class="btn btn-default" onclick="javascript:fnTest();">
					<i class="fa fa-copy "></i> 실험일지보기
				</button>
			</div>
			
		</div>
			
		<div class="div-realgrid">	
			<div id="realgrid" style="width: 100%; height: 400px;"></div>
		</div>			
	<!-- end of realgrid Content -->		
	</div>	
	<br>
	<div role="content" style="width:58%; float: left">
		<div class="dt-toolbar">
			<div class="col-sm-5">
			<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
			실적상세내역
			</div>
			<div class="col-sm-7 text-right" >
				

			</div>
		</div>
		<div class="div-realgrid">	
			<div id="realgrid2" style="width: 100%; height: 200px;"></div>
		</div>			
	<!-- end of realgrid Content -->		
	</div>	
	<div role="content" style="width:38%; float: right">
		<div class="dt-toolbar">
			<div class="col-sm-5">
			<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
			시험결과 관련자료
			</div>
			<div class="col-sm-7 text-right">
				<form id="frm" name="frm" action="<c:url value='/common/fileattach.json'/>" method="post"  enctype="multipart/form-data">
				<input type="hidden" id="reqid" name="reqid" />
				<input type="hidden" id="smpid" name="smpid" />
				<!-- <input type="file" id="attach" name="attach" style="width:200px; float:right" onchange="javascript:fnAttachSend();"/> -->
				<input type="file" id="attach" name="attach" style="width:200px; float:right" onchange="javascript:fnAttachSubmit();"/>
				</form>
			</div>
		</div>
		
		<div class="div-realgrid">	
			<div id="realgrid3" style="width: 100%; height: 200px;"></div>
		</div>			
		
	<!-- end of realgrid Content -->		
	</div>	
	<div role="content" style="clear:both;">
		&nbsp;
	</div>
<!-- end of /section:basics/content.breadcrumbs -->	
</div>
		
<!-- 담당자추가 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="UserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel">담당자변경</h4>
            </div>
            <div class="modal-body requestBody">    <!-- Modal Body-->
                <div class="page-content">          <!-- start of content -->
                    <div role="content">
                        <!--  start of  form-horizontal tems_search  -->
                        <!--  start of widget-body -->
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <!-- back -->
                                <div class="widget-body">
                                    <fieldset>
                                        <div class="col-md-12 form-group">
                                            <div class="col-md-6">
                    							<div class="div-realgrid">
                    								<h4 class="modal-title" id="myModalLabel">부서</h4>
							                        <div id="realgridUser1" style="width: 100%; height: 500px;"></div>
							                    </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="div-realgrid">
                                                	<h4 class="modal-title" id="myModalLabel">사용자선택</h4>
							                        <div id="realgridUser2" style="width: 100%; height: 235px;"></div>
							                    </div>
							                    <div class="div-realgrid">
							                    	<h4 class="modal-title" id="myModalLabel">선택된사용자</h4>
							                        <div id="realgridUser3" style="width: 100%; height: 240px;"></div>
							                    </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                    <!--  end of  form-horizontal tems_search  -->
                                    <!--  end of jarviswidget -->
                                </div>
                            </div>
                            <!-- end of widget-body -->
                        </div>
                        <!--  end of content -->
                    </div>
                    <!-- -----------------------------------------------------------------------------------  -->
                    <!-- Footer -->
                    <footer>
                    </footer>
                    <!-- Footer End -->
                    <!-- end of realgrid Content -->
                </div>
                <!-- -----------------------------------------------------------------------------------  -->
            </div>
            <!-- Modal Body End-->
            <div class="modal-footer">
            	<button type="button" class="btn btn-primary" onclick="fnUserAdd()">적용</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>		
<jsp:include page="/include/approval/reportApprovalPop.jsp"></jsp:include>
