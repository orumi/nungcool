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
	var dataProvider;
	var reqid = "${reqDetail.reqid}";
	
	$(document).ready( function(){
		$("#confirmcnt").text(datacnt);
		
		RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    dataProvider = new RealGridJS.LocalTreeDataProvider();
	    gridView = new RealGridJS.TreeView("realgrid"); 
	    gridView.setDataSource(dataProvider);   
	    
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
    		}
	    ];
	    
         gridView.addCellStyle("style01", {
             "background": "#4400ff00"
         });
         
         
         //컬럼을 GridView에 입력 합니다.
 	    gridView.setColumns(columns);
 	    
 	    /* 헤더의 높이를 지정*/
 	    gridView.setHeader({
 	    	height: 45
 	    });
 	    
 	    gridView.setStyles(smart_style);

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
	    
        //그리드 이벤트 끝
        
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
		window.location.href="<c:url value='/exam/issue/ApproveIssueList.do'/>";
		
	}
	
	function fnGetReqResultList(){
		var cmbsmpid = $("#cmbsmpid").val();
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"reqid":reqid,"smpid":cmbsmpid},
            url: "<c:url value='/exam/cooperation/getResultList.json'/>",
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
		document.frm.action = "<c:url value='/exam/cooperation/CooperationDetail.do'/>";
		document.frm.submit();
		}
    }
    
    function fnNextConfirm(){
		
		if(confirm("승인처리 하시겠습니까?")){
		document.frm.data.value = reqids;
		document.frm.confirm.value = "Y";
		document.frm.reqid.value = reqid;
		document.frm.method="post"
		document.frm.action = "<c:url value='/exam/cooperation/CooperationDetail.do'/>";
		document.frm.submit();
		}
    }
    
    function fnReject(){
    	$("#rejectModal").modal('show');
    	$("#rejectModal").on('shown.bs.modal', function () {

    	});
    	
    }
    
    function fnSaveReject(){
    	if(confirm("반려처리 하시겠습니까?")){ 		
    	document.frm.data.value = reqids;
		document.frm.confirm.value = "R";
		document.frm.reqid.value = reqid;
		document.frm.rejdesc.value = $("#rejdesc").val();
		document.frm.method="post"
		document.frm.action = "<c:url value='/exam/cooperation/CooperationDetail.do'/>";
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
					<label class="col-md-4 form-label">협조신청일</label>
					<div class="col-md-8">
						<span class="txt-sub-content">${reqDetail.regdate}</span>
					</div>
				</div>
				<div class="col-md-4 form-group ">
					<label class="col-md-4 form-label">의뢰업체</label>
					<div class="col-md-8">
						<span class="txt-sub-content">${reqDetail.comname}</span>
					</div>
				</div>
				<div class="col-md-4 form-group">
					<label class="col-md-4 form-label">협조본부</label>
					<div class="col-md-8">
						<span class="txt-sub-content">${reqDetail.officenm}</span>
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
			</div>
			
		</div>
			
		<div class="div-realgrid">	
			<div id="realgrid" style="width: 100%; height: 400px;"></div>
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
  <div class="modal-dialog apprDialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
        <h4 class="modal-title" id="myModalLabel">반려사유 등록</h4>
      </div>
      <div class="modal-body apprBody">
      	<textarea class="form-control" placeholder="" rows="4" id="trejdesc" name="trejdesc" placeholder="반려사유를 적어주십시오."></textarea>
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
<input type="hidden" name="reqid" id="reqid">
<input type="hidden" name="confirm" id="confirm">
<input type="hidden" name="officeid" id="officeid" value="${reqDetail.officeid}">
<input type="hidden" name="rejdesc" id="rejdesc">
<input type="hidden" name="apprid" id="apprid" value="<%=nLoginVO.getAdminid()%>">
<input type="hidden" name="adminid" id="adminid" value="<%=nLoginVO.getAdminid()%>">
</form>