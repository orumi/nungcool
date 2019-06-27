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
<script>
		$(document).ready( function(){
		});
</script>
<script>
	var reqids = "${data}"
	var datas = reqids.split(",");
	var datacnt = datas.length;
	if(reqids == ""){
		datacnt = datacnt - 1;
	}

	var gridView;
	var gridView2;
	var gridView3;
	var dataProvider;
	var dataProvider2;
	var dataProvider3;
	var reqid = "${reqDetail.reqid}";
	var reportid = "${reqDetail.reportid}";
	var nullcnt = "${reqDetail.nullcnt}";
	
	var rejectView;
	var rejectProvider;
	
	
	$(document).ready( function(){
		$("#confirmcnt").text(datacnt);
		
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
	    
	    rejectProvider = new RealGridJS.LocalTreeDataProvider();
	    rejectView = new RealGridJS.TreeView("rejectgrid"); 
	    rejectView.setDataSource(rejectProvider);   
	    
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
    			readOnly : "true",
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
	                    readOnly : "true",
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
                readOnly : "true",
    			width: 100
    		},
    		{
    			name: "displaytype",
    			fieldName: "displaytype",
    			header : {
    				text: "결과보고"
    			},
    			readOnly : "true",
    			width: 80
    		},
			{
    			name: "itemvalue",
    			fieldName: "itemvalue",
    			header : {
    				text: "측정값"
    			},
    			readOnly : "true",
    			width: 80
    		},
			{
    			name: "resultvalue",
    			fieldName: "resultvalue",
    			header : {
    				text: "시험결과"
    			},
    			readOnly : "true",
    			width: 80
    		},
    		{
    			name: "annotation",
    			fieldName: "annotation",
    			header : {
    				text: "주석"
    			},
    			readOnly : "true",
    			width: 100
    		},  
    		{
    			name: "methodnm",
    			fieldName: "methodnm",
    			header : {
    				text: "시험방법"
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
    			name: "itemregid",
    			fieldName: "itemregid",
    			header : {
    				text: "작성자"
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
       			readOnly : "true",
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
       		 	mergeRule: { criteria: "value" },
       		 	readOnly : "true",
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
       		 	readOnly : "true",
       			width: 200
       		},
       		{
       			name: "calid",
       			fieldName: "calid",
       			header : {
       				text: "속성코드"
       			},
       			readOnly : "true",
       			width: 80
       		},
       		{
       			name: "itemvalue",
       			fieldName: "itemvalue",
       			header : {
       				text: "결과값"
       			},
       			readOnly : "true",
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
              }
          ];
          
          
          var rejectfields = [
				{fieldName: "itemvalue"}
				,{fieldName: "resultid"}
				,{fieldName: "conitempid"}
				,{fieldName: "smpitemnm"}
				,{fieldName: "smpnm"}
				,{fieldName: "conitemid"}
				,{fieldName: "displayunit"}
				,{fieldName: "itemname"}
				,{fieldName: "resultvalue"}
				,{fieldName: "treefield"}
           ];

           //DataProvider의 setFields함수로 필드를 입력합니다.
           rejectProvider.setFields(rejectfields);

           //필드와 연결된 컬럼 배열 객체를 생성합니다.
           var rejectcolumns = [
               {
                   name: "itemname",
                   fieldName: "itemname",
                   header: {text: "항목명"},
                   width: 200,
                   styles: {textAlignment: "near"},
                   readOnly: "true"
               },
               {
                   name: "smpnm",
                   fieldName: "smpnm",
                   header: {text: "시료명"},
                   width: 200,
                   styles: {textAlignment: "near"},
                   readOnly: "true"
               },
               {
                   name: "displayunit",
                   fieldName: "displayunit",
                   header: {text: "단위"},
                   width: 80,
                   styles: {textAlignment: "center"},
                   readOnly: "true"
               },
               {
                   name: "itemvalue",
                   fieldName: "itemvalue",
                   header: {text: "측정값"},
                   width: 80,
                   styles: {textAlignment: "far"},
                   readOnly: "true"
               },
               {
                   name: "resultvalue",
                   fieldName: "resultvalue",
                   header: {text: "시험결과"},
                   width: 80,
                   styles: {textAlignment: "far"},
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
 	    
 	    rejectView.setColumns(rejectcolumns);
 	    
 	    /* 헤더의 높이를 지정*/
 	    gridView.setHeader({
 	    	height: 45
 	    }); 
 	    
 	    
 	    gridView.setStyles(smart_style);
 	    gridView2.setStyles(smart_style);
 	    gridView3.setStyles(smart_style);
 	    
 	    rejectView.setStyles(smart_style);

 	    gridView.setLookups([
   	        {"id": "lookID2","levels": 2}
   	    ]);
 	    
 	    
 	    /* 그리드 row추가 옵션사용여부 */
 	    gridView.setOptions({
 	    	panel : { visible : false },
 	    	footer : { visible : false },
 	    	display: {
                fitStyle: "evenFill"
            }
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
 	    
 	     rejectView.setOptions({
             panel: {visible: false},
             footer: {visible: false},
             display: {
                 fitStyle: "evenFill"
             }
         });
 	    
       
	    /************************ 
	    	그리드 이벤트 핸들러  
	    *************************/
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
        		gridView.setValue(item,"itemvalue",eval(calc));
        	}        	
	    }
	    	
        ////시험방법 링크
        gridView.onLinkableCellClicked = function (grid, index, url) {
        	var methodname = gridView.getValue(index.itemIndex,"methodnm").split(":")[0].replace(/ /gi,"");
	    		window.open("http://10.1.10.80/ekp/standard/StandardFileDownPage.bzr?cabinetInstanceID=1036&kname="+methodname);
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
		window.location.href="<c:url value='/officialExam/issue/ApproveIssueList.do'/>";
		
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
            },
            cache: false
        });
	}
	
	function fnGetRejectResultList(){
		var cmbsmpid = $("#cmbsmpid").val();
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"reqid":reqid},
            url: "<c:url value='/officialExam/issue/getRejectResultList.json'/>",
            success: function (data) {
            	rejectProvider.setRows(data,"treefield", true, "", "");
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	rejectView.expandAll();
            },
            cache: false
        });
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
    
	function fnNext(){
		
		var conftxt = "";
		if(datacnt > 0){
			conftxt = "승인처리 보류후 다음건을 불러 오시겠습니까?";	 
		} else {
			conftxt = "마지막 승인건 입니다.\n 승인처리 보류후 목록으로 돌아가시겠습니까?";
		}
	    	
		if(confirm(conftxt)){
		
		document.frm.data.value = reqids;
		document.frm.confirm.value = "N";
		document.frm.reqid.value = reqid;
		document.frm.method="post"
		document.frm.action = "<c:url value='/officialExam/issue/ApproveIssueDetail.do'/>";
		document.frm.submit();
		}
    }
    
    function fnNextConfirm(){
		
		if(confirm("승인처리 하시겠습니까?")){
		document.frm.data.value = reqids;
		document.frm.confirm.value = "Y";
		document.frm.reqid.value = reqid;
		document.frm.method="post"
		document.frm.action = "<c:url value='/officialExam/issue/ApproveIssueDetail.do'/>";
		document.frm.submit();
		}
    }
    
    function fnReject(){
    	$("#rejectModal").modal('show');
    	$("#rejectModal").on('shown.bs.modal', function () {
    		rejectView.resetSize();
    		fnGetRejectResultList();
    	});
    	
    }
    
    function fnSaveReject(){
    	var rows = rejectView.getCheckedRows();
 		var vodata = [];
 		var jData
 		
 		if(rows.length > 0){
 	        for(var i=0; i < rows.length; i++){
 	        	jData = {
    	                "resultid": rejectView.getValue(rows[i],"resultid"),
    	                "reqid": reqid
    	        }
 	        	vodata.push(jData);
 	        };
 	    }
 		
 		if (vodata.length == 0) {
 			alert("선택된 값이 없습니다.");
 	        return;
 	    }
 		
 		document.frm.vodata.value = JSON.stringify(vodata);
    	document.frm.data.value = reqids;
		document.frm.confirm.value = "R";
		document.frm.reqid.value = reqid;
		document.frm.rejdesc.value = $("#rejdesc").val();
		document.frm.method="post"
		document.frm.action = "<c:url value='/officialExam/issue/ApproveIssueDetail.do'/>";
		document.frm.submit();
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
				<button class="btn btn-default btn-success" onclick="javascript:fnNextConfirm();">
				<i class="glyphicon glyphicon-ok"></i>의뢰승인 다음
				</button>
				<button class="btn btn-default btn-success" onclick="javascript:fnNext();">
				<i class="glyphicon glyphicon-ok"></i>승인보류 다음
				</button>
				남은 결제 건수 : <span id="confirmcnt"></span>건
				<button class="btn btn-default btn-danger" onclick="javascript:fnReject();">
				<i class="glyphicon glyphicon-ok"></i>반려
				</button>
				<button class="btn btn-default" onclick="javascript:fnGoList();">
					<i class="fa fa-th-list"></i> 목록
				</button>
			</div>
		
	<!-- end of div dt-toolbar content -->	
		</div>
	</div>	


    <!-- 승인할 의뢰 정보 --------------------------------------------------------------------------------------- -->
	<div role="content" class="clear-both sub-content">
	
		<div class="form-horizontal form-terms ui-sortable"> <div class="jarviswidget jarviswidget-sortable" role="widget">	
	
		<!-- body -->    	
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
		
		
	
		
		<!--  end of  form-horizontal tems_search  -->
		<!--  end of jarviswidget -->
		</div></div>
	
		<!-- end of widget-body -->
		</div>
	<!--  end of content -->			
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
				</div>
			</div>
			
			
			<div class="col-sm-7 text-right" >
				<button class="btn btn-default" onclick="javascript:alert();">
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
				<form id="frm">
				<input type="hidden" id="reqid" name="reqid" />
				<input type="hidden" id="smpid" name="smpid" />
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


<!-- 반려 모달창------------------------------------------------------------------------ -->
<div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog apprDialog" role="document" style="width: 1000px">
    <div class="modal-content" >
      <div class="modal-header">
        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
        <h4 class="modal-title" id="myModalLabel">반려사유 등록</h4>
      </div>
      <div class="modal-body apprBody">
      	<div role="content" style="width:68%; float: left">
	      	<div class="div-realgrid">	
				<div id="rejectgrid" style="width: 100%; height: 400px;"></div>
			</div>	
      	</div>
      	<div role="content" style="width:28%; float: right">
      	<textarea class="form-control" rows="15" id="rejdesc" name="rejdesc" placeholder="반려사유를 적어주십시오." style="width: 100%; height: 400px;"></textarea>
      	</div>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" onclick="javascript:fnSaveReject()">등록</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<form name="frm">
<input type="hidden" name="data" id="data">
<input type="hidden" name="vodata" id="vodata">
<input type="hidden" name="reqid" id="reqid">
<input type="hidden" name="confirm" id="confirm">
<input type="hidden" name="rejdesc" id="rejdesc">
<input type="hidden" name="apprid" id="apprid" value="<%=nLoginVO.getAdminid()%>">
</form>