<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
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
	var gridView;
	var gridView2;
	var gridView3;
	var dataProvider;
	var dataProvider2;
	var dataProvider3;
	
	var reqids = "${data}"
	var datas = reqids.split(",");
	var datacnt = datas.length;
	if(reqids == ""){
		datacnt = datacnt - 1;
	}
	var reqid = "${reqDetail.reqid}";
	
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
			,{fieldName: "cooperresultstate"}
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
    			width: 100
    		}, 
    		{
    			name: "cooperresultstate",
    			fieldName: "cooperresultstate",
    			header : {
    				text: "등록여부"
    			},
    			width: 100
    		}, 
    		{
    			name: "itemregid",
    			fieldName: "itemregid",
    			header : {
    				text: "작성자"
    			},
    			readOnly : "true",
    			width: 80
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
          
         //컬럼을 GridView에 입력 합니다.
 	    gridView.setColumns(columns);
 	    gridView2.setColumns(columns2);
 	    gridView3.setColumns(columns3);
 	    
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
 	    
 	 	gridView.setLookups([
   	        {"id": "lookID2","levels": 2}
   	    ]);
 	    
 	    
 	    /* 그리드 row추가 옵션사용여부 */
 	    gridView.setOptions({
 	    	panel : { visible : false },
 	    	footer : { visible : false },
 	    	display: {
                fitStyle: "evenFill"
            },
            edit : {editable: false }
 	    });
 	    
 	    gridView2.setOptions({
 	    	panel : { visible : false },
 	    	footer : { visible : false },
 	    	display: {
                fitStyle: "evenFill"
            },
            edit : {editable: false }
 	    });
 	    
 	    gridView3.setOptions({
             panel: {visible: false},
             footer: {visible: false},
             checkBar: {visible: false},
             display: {
                 fitStyle: "evenFill"
             },
             edit : {editable: false }
         });
 	    
 	   //자동 호출
 	    fnGetReqResultList();
	});	 	    
 	    
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
		window.location.href="<c:url value='/cooperate/receiveApprove/ApproveList.do'/>";
		
	}
	
	function fnGetReqResultList(){
		var cmbsmpid = $("#cmbsmpid").val();
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"reqid":reqid,"smpid":cmbsmpid},
            url: "<c:url value='/cooperate/result/getCoopResultList.json'/>",
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
		document.frm.action = "<c:url value='/cooperate/receiveApprove/ApproveDetail.do'/>";
		document.frm.submit();
		}
    }
    
    function fnNextConfirm(){
		
		if(confirm("승인처리 하시겠습니까?")){
		document.frm.data.value = reqids;
		document.frm.confirm.value = "Y";
		document.frm.reqid.value = reqid;
		document.frm.method="post"
		document.frm.action = "<c:url value='/cooperate/receiveApprove/ApproveDetail.do'/>";
		document.frm.submit();
		}
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
				<!-- <button class="btn btn-default btn-danger" onclick="javascript:fnReject();">
				<i class="glyphicon glyphicon-ok"></i>반려
				</button> -->
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
<form name="frm">
<double-submit:preventer/>
<input type="hidden" name="data" id="data">
<input type="hidden" name="reqid" id="reqid">
<input type="hidden" name="confirm" id="confirm">
<input type="hidden" name="rejdesc" id="rejdesc">
<input type="hidden" name="apprid" id="apprid" value="<%=nLoginVO.getAdminid()%>">
<input type="hidden" name="adminid" id="adminid" value="<%=nLoginVO.getAdminid()%>">
</form>	