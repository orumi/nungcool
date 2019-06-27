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
			getJavaObject();
		});
		
		$(function() {
			$("#frm").ajaxForm();
		})
</script>
<script>
	var gridView;
	var gridView2;
	var gridView3;
	var dataProvider;
	var dataProvider2;
	var dataProvider3;
	
	var reqView;
	var reqProvider;
	
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
	    
	    reqProvider = new RealGridJS.LocalDataProvider();
	    reqView = new RealGridJS.GridView("reqgrid"); 
	    reqView.setDataSource(reqProvider);
	    
	    //setOptions(gridView);
	    
	    var fields = [
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
			,{fieldName: "condetc"}
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
			,{fieldName: "displaytype"}
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
				name: "smpnm",
				fieldName: "smpnm",
				header : {
					text: "시료명"
				},
				styles: {
			        textAlignment: "near"
			    },
			    readOnly : "true",
				width: 100
			},
			{
				name: "masternm",
				fieldName: "masternm",
				header : {
					text: "제품명"
				},
				styles: {
			        textAlignment: "near"
			    },
			    readOnly : "true",
				width: 80
			},
			{
				name: "acceptno",
				fieldName: "acceptno",
				header : {
					text: "접수번호"
				},
				styles: {
			        textAlignment: "near"
			    },
			    readOnly : "true",
				width: 100
			},
			{
				name: "issuedateplan",
				fieldName: "issuedateplan",
				header : {
					text: "발급예정"
				},
				styles: {
			        textAlignment: "near"
			    },
			    readOnly : "true",
				width: 80
			},
    		{
    			name: "unitid",
    			fieldName: "unitid",
    			header : {
    				text: "표준단위"
    			},
    			readOnly : "true",
    			width: 60
    		},
    		{
    			name: "displayunit",
    			fieldName: "displayunit",
    			header : {
    				text: "단위"
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
    			styles: {
       		        textAlignment: "near"
       		    },
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
    			name: "spec",
    			fieldName: "spec",
    			header : {
    				text: "품질기준"
    			},
    			readOnly : "true",
    			button: "action",
    			buttonVisibility : "always",
    			width: 130
    		},
    		{
    			name: "testnote",
    			fieldName: "testnote",
    			header : {
    				text: "실험일지"
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
			,{fieldName: "acceptno"}
			,{fieldName: "masternm"}
			,{fieldName: "smpnm"}
   	    ];
   	    
   	    //DataProvider의 setFields함수로 필드를 입력합니다.
   	    dataProvider2.setFields(fields2);

   	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
   	    var columns2 = [
       		{
       			name: "smpnm",
       			fieldName: "smpnm",
       			header : {
       				text: "시료/제품명"
       			},
       			styles: {
       		        textAlignment: "near",
       		     	textWrap:"normal"
       		    },
       		 	mergeRule: { criteria: "value" },
       			width: 200
       		},
       		{
       			name: "acceptno",
       			fieldName: "acceptno",
       			header : {
       				text: "접수번호"
       			},
       			styles: {
       		        textAlignment: "near",
       		     	textWrap:"normal"
       		    },
       		 	mergeRule: { criteria: "values['reqid'] + value" },
       			width: 160
       		},       		
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
       		 	mergeRule: { criteria: "values['reqid'] + value" },
       			width: 200
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
       		 	mergeRule: { criteria: "values['reqid'] + value" },
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
       				text: "속성"
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
				,{fieldName: "acceptno"}
				,{fieldName: "masternm"}
				,{fieldName: "smpnm"}
          ];

          //DataProvider의 setFields함수로 필드를 입력합니다.
          dataProvider3.setFields(fields3);

          //필드와 연결된 컬럼 배열 객체를 생성합니다.
          var columns3 = [
				{
					name: "smpnm",
					fieldName: "smpnm",
					header : {
						text: "시료/제품명"
					},
					styles: {
				        textAlignment: "near",
				     	textWrap:"normal"
				    },
				 	mergeRule: { criteria: "value" },
					width: 150
				},
				{
					name: "acceptno",
					fieldName: "acceptno",
					header : {
						text: "접수번호"
					},
					styles: {
				        textAlignment: "near",
				     	textWrap:"normal"
				    },
				 	mergeRule: { criteria: "value" },
					width: 150
				},       	
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
          
          
         var reqfields = [
			{fieldName: "itemafter"}
			,{fieldName: "remark"}
			,{fieldName: "reqid"}
			,{fieldName: "itemdesc"}
			,{fieldName: "acceptno"}
			,{fieldName: "filepath"}
			,{fieldName: "orgname"}
         ];
         
         //DataProvider의 setFields함수로 필드를 입력합니다.
         reqProvider.setFields(reqfields);
         
       //필드와 연결된 컬럼 배열 객체를 생성합니다.
         var reqcolumns = [
				{
					name: "acceptno",
					fieldName: "acceptno",
					header : {
						text: "접수번호"
					},
					styles: {
				        textAlignment: "near",
				     	textWrap:"normal"
				    },
				 	mergeRule: { criteria: "value" },
					width: 150
				},       	
				{
					name: "itemdesc",
					fieldName: "itemdesc",
					header : {
						text: "시험자에게\n남기는글"
					},
					styles: {
				        textAlignment: "near",
				     	textWrap:"normal"
				    },
				    mergeRule: { criteria: "values['reqid'] + value" },
					width: 150
				},    
				{
					name: "remark",
					fieldName: "remark",
					header : {
						text: "실험자\n비고"
					},
					styles: {
				        textAlignment: "near",
				     	textWrap:"normal"
				    },
				    mergeRule: { criteria: "values['acceptno'] + value" },
					width: 150
				},    
				{
					name: "itemafter",
					fieldName: "itemafter",
					header : {
						text: "시료처리"
					},
					styles: {
				        textAlignment: "near",
				     	textWrap:"normal"
				    },
				    mergeRule: { criteria: "values['acceptno'] + value" },
					width: 150
				},    
             	{
              	  	name: "orgname",
                 	fieldName: "orgname",
	                  header: {text: "첨부파일"},
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
	              }
         ];
          
         
         gridView.addCellStyle("style01", {
             "background": "#4400ff00"
         });
         
         
         //컬럼을 GridView에 입력 합니다.
 	    gridView.setColumns(columns);
 	    gridView2.setColumns(columns2);
 	    gridView3.setColumns(columns3);
 	    
 	    reqView.setColumns(reqcolumns);
 	    
 	    /* 헤더의 높이를 지정*/
 	    gridView.setHeader({
 	    	height: 45
 	    }); 
 	    
 	   /* 헤더의 높이를 지정*/
 	    reqView.setHeader({
 	    	height: 45
 	    });
 	    
 	    
 	    gridView.setStyles(smart_style);
 	    gridView2.setStyles(smart_style);
 	    gridView3.setStyles(smart_style);
 	    
 	    reqView.setStyles(smart_style);
 	 	
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
 	    	checkBar: {visible: false},
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
 	    
 	    reqView.setOptions({
            panel: {visible: false},
            footer: {visible: false},
            checkBar: {visible: false},
            stateBar: {visible: false},
            display: {
                fitStyle: "evenFill"
            }
        });

       
	    
	    /************************ 
	    	그리드 이벤트 핸들러  
	    *************************/
	    gridView.onCellButtonClicked = function (grid, itemIndex, column) {
			alert();
			
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
        		gridView.setValue(item,"itemvalue",eval(calc.replace(/POWER/gi,"Math.pow").replace(/EXP/gi,"Math.exp").replace(/LN/gi,"Math.log").replace(/ABS/gi,"Math.abs")));
        	}        	
	    }
	    	
        ///첨부대상 시료 선택
        gridView.onCurrentChanged  =  function (grid, index) {
   			$("#selsmpnm").text(gridView.getValue(index.itemIndex,"acceptno"));
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
	    
	    reqView.onLinkableCellClicked = function (grid, index, url) {
        	var filenick = reqView.getValue(index.itemIndex,"filepath");
        	var fileName = reqView.getValue(index.itemIndex,"orgname");
	    		window.open("<c:url value='/common/getFileDown.json?filenick="+filenick+"&fileName="+fileName+"'/>");
	    };
	    
	    
	    ////첨부파일 삭제
	    gridView3.onCellButtonClicked = function (grid, itemIndex, column) {
	    	var reqid = gridView3.getValue(itemIndex,"reqid");//$("#cmbsmpid").val();
	    	var smpid = gridView3.getValue(itemIndex,"smpid");//$("#cmbsmpid").val();
	    	var smpfid = gridView3.getValue(itemIndex,"smpfid");
	    	var filepath = gridView3.getValue(itemIndex,"filepath");
			$.ajax({
				type : "post",
			    dataType : "json",
			    data : {"reqid":reqid,"smpid":smpid,"smpfid":smpfid,"filepath":filepath},
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
							script = script+"else if("+scripts[0].split(":")[0]+"){y="+scripts[0].split(":")[1]+"}";
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
    			gridView.setValue(itemIndex,"resultvalue",gridView.getValue(itemIndex,"itemvalue"));
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
							script = script+"else if("+scripts[0].split(":")[0]+"){y="+scripts[0].split(":")[1]+"}";
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
    			gridView.setValue(itemIndex,"resultvalue",gridView.getValue(itemIndex,"itemvalue"));
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
		window.location.href="<c:url value='/exam/result/ResultList.do'/>";
		
	}
	
	function fnGetReqResultList(){
		var adminid =  '<%=nLoginVO.getAdminid()%>';
		var firstOpt = $("#firstOpt").val();
		var secondOpt = $("#secondOpt").val();
		var thirdOpt = $("#thirdOpt").val();
		var smpname = $("#smpname").val();
		var itemname = $("#itemname").val();
		var reqstate = $("#reqstate").val(); 
		var dateplan = $("#dateplan").val();
		var chkstartdate1 = $("input:checkbox[id='chkstartdate1']").is(":checked");//$("#chkstartdate").val();
		var startdate1 = $("#startdate1").val();
		var chkfinishdate1 = $("input:checkbox[id='chkfinishdate1']").is(":checked");//$("#chkfinishdate").val();
		var finishdate1 = $("#finishdate1").val();
		var acceptno = $("#acceptno").val();
		var reqstate = $("#reqstate").val();
		
		var data = {"adminid":adminid,
			"firstOpt":        firstOpt      ,
			"secondOpt":	secondOpt     ,
			"thirdOpt":	thirdOpt      ,
			"smpname":		smpname       ,
			"itemname":	itemname      ,
			"reqstate":	reqstate      , 
			"dateplan":	dateplan      ,
			"chkstartdate1":	chkstartdate1  ,
			"startdate1":	startdate1     ,
			"chkfinishdate1":	chkfinishdate1 ,
			"finishdate1":	finishdate1,
			"acceptno":	acceptno,
			"reqstate":	reqstate
		};		
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : data,
            url: "<c:url value='/exam/resultAdmin/getResultAdminList.json'/>",
            success: function (data) {
            	dataProvider.setRows(data.ResultList,"treefield", true, "", "");
            	dataProvider2.fillJsonData(data.CalcList);
            	reqProvider.fillJsonData(data.reqList);
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
            	fnGetSmpFileList();
            },
            cache: false
        });
	}
	
	function fnGetSmpFileList(){
		var adminid =  '<%=nLoginVO.getAdminid()%>';
		var firstOpt = $("#firstOpt").val();
		var secondOpt = $("#secondOpt").val();
		var thirdOpt = $("#thirdOpt").val();
		var smpname = $("#smpname").val();
		var itemname = $("#itemname").val();
		var reqstate = $("#reqstate").val(); 
		var dateplan = $("#dateplan").val();
		var chkstartdate1 = $("input:checkbox[id='chkstartdate1']").is(":checked");//$("#chkstartdate").val();
		var startdate1 = $("#startdate1").val();
		var chkfinishdate1 = $("input:checkbox[id='chkfinishdate1']").is(":checked");//$("#chkfinishdate").val();
		var finishdate1 = $("#finishdate1").val();
		var acceptno = $("#acceptno").val();
		var reqstate = $("#reqstate").val();
		
		var data = {"adminid":adminid,
			"firstOpt":        firstOpt      ,
			"secondOpt":	secondOpt     ,
			"thirdOpt":	thirdOpt      ,
			"smpname":		smpname       ,
			"itemname":	itemname      ,
			"reqstate":	reqstate      , 
			"dateplan":	dateplan      ,
			"chkstartdate1":	chkstartdate1  ,
			"startdate1":	startdate1     ,
			"chkfinishdate1":	chkfinishdate1 ,
			"finishdate1":	finishdate1,
			"acceptno":	acceptno,
			"reqstate":	reqstate
		};
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : data,
            url: "<c:url value='/common/getAdminSampleFile.json'/>",
            success: function (data) {
            	dataProvider3.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	gridView3.closeProgress();
            	//$("#selsmpnm").text("");
            	var index =  gridView.getCurrent();
            	var itemIndex = index.itemIndex;
            	$("#selsmpnm").text(gridView.getValue(index.itemIndex,"acceptno"));
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
            },
            cache: false
	    });
	}

	function fnSaveResult(){
		gridView.commit();	
		gridView2.commit();
		
		var state;
	    var jData;
	    var jRowsData = [];

	    var rows = dataProvider.getAllStateRows();
	    //var rows = gridView.getCheckedRows();
	    
	    if(rows.updated.length > 0){
	        for(var i=0; i < rows.updated.length; i++){
	            jData = dataProvider.getJsonRow(rows.updated[i]);
	            jRowsData.push(jData);
	        };
	    }

	    if (jRowsData.length == 0) {
	    	alert("변경된 내용이 없습니다.");
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
	    	saveData("<c:url value='/exam/resultAdmin/upResultAdminDetail.json'/>",data);	
	    }
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
    	var adminid = "<%=nLoginVO.getAdminid()%>";		
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"adminid":adminid},
            url: "<c:url value='/common/getCondComboList.json'/>",
            success: function (data) {
                lookupDataChange(data);
            },
            error : function(request, status, error) {
            	alert("code:" + request.status + "\n" + "error:" + error);
            }
        }); 
	}
    
     function fnAttachSend(){
    	 
    	var index =  gridView.getCurrent();
    	var itemIndex = index.itemIndex;
    	var setText = $("#selsmpnm").text();
    	 
		if(setText == ""){
			alert("첨부대상 시료를 선택하여 주십시오.");
			return;
		}
		
		var reqid = gridView.getValue(itemIndex, "reqid");
		var smpid = gridView.getValue(itemIndex, "smpid");
     	
   	 	var form = $('form')[0];
   	    var formData = new FormData(form);
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
    	var index =  gridView.getCurrent();
     	var itemIndex = index.itemIndex;
     	var setText = $("#selsmpnm").text();
     	 
 		if(setText == ""){
 			alert("첨부대상 시료를 선택하여 주십시오.");
 			return;
 		}
 		
 		var reqid = gridView.getValue(itemIndex, "reqid");
 		var smpid = gridView.getValue(itemIndex, "smpid");
 		
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
    
     
     function getJavaObject() { // 자바에서 객체 1,2,3 번째 다 가져와서 자바스크립트에 JSON 기입 후 1번째만 삽입.

         $.ajax({
             type: "post",
             dataType: "text",
             url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/getSelectListWithJson.json'/>",
             data: {"data": "data"},
             success: function (data) {
                 var json = JSON.parse(data);

                 firstSelectListJson = json.list;
                 secondSelectListJson = json.list2;
                 thirdSelectListJson = json.list3;

                 for (var i = 0; i < firstSelectListJson.length; i++) {
                     $("#firstOpt").append("<option value='" + firstSelectListJson[i].classID + "'>" + firstSelectListJson[i].name + "</option>");
                 }

             },
             error: function (request, status, error) {
                 alert("code:" + request.status + "\n" + "error:" + error);
             }
         });

     }

     function selSecondOption() {

         var optionValue = $("#firstOpt option:selected").val();

         $("#secondOpt option").remove(); // 첫번째 선택창에서 선택 된 놈 소집
         $("#thirdOpt option").remove(); //  두번째 선택창에서 선택 된 놈 소집

         $("#secondOpt").append("<option value=''>" + "전체" + "</option>");
         $("#thirdOpt").append("<option value=''>" + "전체" + "</option>");

         for (var i = 0; i < secondSelectListJson.length; i++) {

             if (secondSelectListJson[i].classID == optionValue) { // 1번째에서 선택 된 클래스아이디와 같은 종류만 모두 소집
                 $("#secondOpt").append("<option value='" + secondSelectListJson[i].groupID + "'>" + secondSelectListJson[i].name + "</option>");
             }

         }
     }

     function selThirdOption() {

         var optionValue = $("#secondOpt option:selected").val();


         $("#thirdOpt option").remove();
         $("#thirdOpt").append("<option value=''>" + "전체" + "</option>");

         for (var i = 0; i < thirdSelectListJson.length; i++) {

             if (thirdSelectListJson[i].groupID == optionValue) { // 1번째에서 선택 된 클래스아이디와 같은 종류만 모두 소집
                 $("#thirdOpt").append("<option value='" + thirdSelectListJson[i].masterID + "'>" + thirdSelectListJson[i].name + "</option>");
             }

         }
     }
    

</script>	
<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">


<!-- top button area  -->
	<div role="content">
		<div role="content" style="width:49%; float: left">
		<div class="dt-toolbar">
			<div class="col-sm-5">
			<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
			검색조건
			</div>
			<div class="col-sm-7 text-right" >
				

			</div>
		</div>
	
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
		<div class="col-md-12 form-group ">
			<label class="col-md-3 form-label"><b>접수일자</b></label>
				<div class="col-md-9">
					<div class="col-sm-1 checkbox" style="padding-left:0px;width:20px;">
						<label>
								<input type="checkbox" class="checkbox" id="chkstartdate1" name="chkstartdate1">
								<span></span>
						</label>		
					</div>
					<div class="col-sm-4" style="padding-left:0px;">
						<div class="input-group">
							<input class="form-control form-calendar" id="startdate1" name="startdate1" type="text">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
							<div class="col-sm-1 wave">
								<b>~</b>
							</div>
					<div class="col-sm-1 checkbox" style="padding-left:0px;width:20px;">
						<label>
							<input type="checkbox" class="checkbox"  id="chkfinishdate1" name="chkfinishdate1">
							<span></span>
						</label>
					</div>	
					<div class="col-sm-4" style="padding-left:0px;">
						<div class="input-group">
							<input class="form-control form-calendar" id="finishdate1" name="finishdate1" type="text">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>
			</div>
		</fieldset>
		<fieldset>
		<div class="col-md-12 form-group">
			<label class="col-md-3 form-label"><b>접수번호</b></label>
			<div class="col-md-9">
				<input type="text" class="form-control inputBox" id="acceptno"  name="acceptno"/>
			</div>
		</div>
		</fieldset>			
		<fieldset>
			<div class="col-md-12 form-group">
			<label class="col-md-3 form-label"><b>유종구분 / 유종 / 제품</b></label>
			<div class="col-md-9">
                <div class="col-md-4" style="padding-left:0px;">
				<select class="form-control selectBox95" id="firstOpt" onchange="javascript:selSecondOption();">
					<option selected="selected"  value=''>전체</option>
				</select>
				</div>
				<div class="col-md-4" style="padding-left:0px;">
				<select class="form-control selectBox95" id="secondOpt" onchange="javascript:selThirdOption();">
					<option selected="selected" value=''>전체</option>
				</select>
				</div>
				<div class="col-md-4" style="padding-left:0px;">
				<select class="form-control selectBox95" id="thirdOpt">
					<option selected="selected" value=''>전체</option>
				</select>
				</div>
			</div>
		</div>
		</fieldset>
		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-3 form-label"><b>시료명</b></label>
			<div class="col-md-9" >
				<input type="text" class="form-control inputBox" id="smpname"  name="smpname"/>
			</div>
		</div>
		</fieldset>
		<fieldset>
		<div class="col-md-12 form-group">
			<label class="col-md-3 form-label"><b>시험항목</b></label>
			<div class="col-md-9">
				<div class="col-sm-10 form-button" >
				<input type="text" class="form-control inputBox" id="itemname"  name="itemname"/>
				</div>
			
				<div class="col-sm-2 form-button" style="float: right">				
					<button class="btn btn-default btn-primary" type="button" onclick="javascript:fnGetReqResultList();">
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
	    
	    <div role="content" style="width:49%; float: right">
		    <div class="dt-toolbar">
				<div class="col-sm-5">
				<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
				시료정보
				</div>
				<div class="col-sm-7 text-right" >
					
	
				</div>
			</div>
    		<div class="form-horizontal form-terms "> <div class="jarviswidget jarviswidget-sortable" role="widget">	
				<div class="widget-body">
					<fieldset>
						<div id="reqgrid" style="width: 100%; height: 178px;"></div>
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
					
				</div>
			</div>
			
			
			<div class="col-sm-7 text-right" >
				<button class="btn btn-primary" onclick="javascript:fnSaveResult();">
					<i class="fa fa-save"></i> 저장
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
			<div class="col-sm-9">
			<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
			시험결과 관련자료 (현재선택시료:<font color="blue"><span id="selsmpnm" name="selsmpnm"></span></font>)
			</div>
			<div class="col-sm-3 text-right">
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
