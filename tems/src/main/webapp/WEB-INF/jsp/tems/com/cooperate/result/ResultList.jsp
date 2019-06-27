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
			//getJavaObject();
		});
</script>
<script>
	var gridView;
	var gridView2;
	var dataProvider;
	var dataProvider2;
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    dataProvider = new RealGridJS.LocalDataProvider();
	    gridView = new RealGridJS.GridView("realgrid");
	    gridView.setDataSource(dataProvider);
	    
	    dataProvider2 = new RealGridJS.LocalDataProvider();
	    gridView2 = new RealGridJS.GridView("realgrid2"); 
	    gridView2.setDataSource(dataProvider2);
	    
	    setOptions(gridView);
	    
	    
	    var fields = [
			{fieldName: "coopercnt"}
			,{fieldName: "rltcnt"}
			,{fieldName: "nullcnt"}
			,{fieldName: "remark"}
			,{fieldName: "issuedateplan"}
			,{fieldName: "itemterm"}
			,{fieldName: "dday"}
			,{fieldName: "statenm"}
			,{fieldName: "smpcnt"}
			,{fieldName: "memname"}
			,{fieldName: "reqid"}
			,{fieldName: "requestcdate"}
			,{fieldName: "acceptno"}
			,{fieldName: "issustatenm"}
			,{fieldName: "receiptdate"}
			,{fieldName: "comname"}
			,{fieldName: "reportid"}
	    ];

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns = [
			{
				name: "acceptno",
				fieldName: "acceptno",
				header : {
					text: "접수번호"
				},
				width: 250
			},
    		{
    			name: "comname",
    			fieldName: "comname",
    			header : {
    				text: "의뢰업체"
    			},
    			renderer: {
    	            "url": "javascript:void(0)",
    	            "type": "link",
    	            "requiredFields": "reqid",
    	            "showUrl": false,
    	            "color":"blue"
    	        },
    			width: 250
    		},
    		{
    			name: "receiptdate",
    			fieldName: "receiptdate",
    			header : {
    				text: "접수일자"
    			},
    			width: 130
    		},
    		{
    			name: "issuedateplan",
    			fieldName: "issuedateplan",
    			header : {
    				text: "발급예정일"
    			},
    			width: 130
    		},
    		{
    			name: "itemterm",
    			fieldName: "itemterm",
    			header : {
    				text: "처리기한"
    			},
    			width: 110
    		},
    		{
    			name: "smpcnt",
    			fieldName: "smpcnt",
    			header : {
    				text: "시료건수"
    			},
    			width: 110
    		},
    		{
    			name: "rltcnt",
    			fieldName: "rltcnt",
    			header : {
    				text: "항목건수"
    			},
    			width: 110
    		},
    		{
    			name: "nullcnt",
    			fieldName: "nullcnt",
    			header : {
    				text: "결과미등록건수"
    			},
    			width: 110
    		},
    		{
    			name: "statenm",
    			fieldName: "statenm",
    			header : {
    				text: "협조진행상태"
    			},
    			width: 110
    		}
	    ];
	    
	  //접수내역 메인리스트에서 결재중 팝업 그리드
	    var fields2 = [
				{fieldName: "reqid"}
				,{fieldName: "gubun"}
				,{fieldName: "gian"}
				,{fieldName: "fst"}
				,{fieldName: "snd"}
				,{fieldName: "trd"}
				,{fieldName: "fth"}
	    ];
	    
	    var columns2 = [
			{
				name: "gubun",
				fieldName: "gubun",
				header : {
					text: "구분"
				},
    			width: 100
			},{
				name: "gian",
				fieldName: "gian",
				header : {
					text: "기안자"
				},
    			width: 100
			},
			{
				name: "fst",
				fieldName: "fst",
				header : {
					text: "1차승인자"
				},
    			width: 100
			},
			{
				name: "snd",
				fieldName: "snd",
				header : {
					text: "2차승인자"
				},
    			width: 100
			},
			{
				name: "trd",
				fieldName: "trd",
				header : {
					text: "3차승인자"
				},
    			width: 100
			},
			{
				name: "fth",
				fieldName: "fth",
				header : {
					text: "4차승인자"
				},
    			width: 100
			}
	    ];
	    
	    dataProvider.setFields(fields);
	    gridView.setColumns(columns);
	    
	    dataProvider2.setFields(fields2);
	    gridView2.setColumns(columns2);
	    
	    /* 그리드 row추가 옵션사용여부 */
		gridView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	        display : { fitStyle : "evenFill" },
	        edit : {readOnly : true}
	    });
	    
	    gridView2.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	    	checkBar: { visible: false },
	    	display : { fitStyle : "evenFill" }
	    });
	    
	    /* 헤더의 높이를 지정*/
	    gridView.setHeader({
	    	height: 45
	    });
	    
		gridView.setStyles(smart_style);
		gridView2.setStyles(smart_style);
		
	    
	    gridView.onDataCellClicked = function (grid, index, column) {
			if(index.column == "apprline"){
	    		
	    		reqid = gridView.getValue(index.dataRow, "reqid");
		    	
		    	$.ajax({
					type : "post",
				    dataType : "json",
				    data : {"reqid":reqid},
		            url: "<c:url value='/exam/req/getApprLineUp.json'/>",
		            success: function (data) {
		                dataProvider2.fillJsonData(data);
		            },
		            error:function(request,status,error){
		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		            },
		            complete: function (data) {
		            	//gridView.hideToast();
		            },
		            cache: false
		        });
	    		
	    		$("#approveModal").modal('show');
				$("#approveModal").on('shown.bs.modal', function () {
					gridView2.resetSize();
		    	});
	    	} else if(index.column == "comname"){
	    		selReqComHistoryModal(gridView.getValue(index.itemIndex,"reqid"));
	    		//window.location.href="<c:url value='/exam/requestConfirm/RcListDetail.do?reqid="+gridView.getValue(index.itemIndex,"reqid")+"'/>";
	    	} else {
	    		window.location.href="<c:url value='/cooperate/result/ResultDetail.do?reqid="+gridView.getValue(index.itemIndex,"reqid")+"'/>";	
	    	}
	    	
	    };
	    
	    
	    loadData();
	    
	});	    
	
	function loadData(){
		var adminid =  '<%=nLoginVO.getAdminid()%>';
		
		var dateplan = $("#dateplan").val();
		var chkstartdate1 = $("input:checkbox[id='chkstartdate1']").is(":checked");//$("#chkstartdate").val();
		var startdate1 = $("#startdate1").val();
		var chkfinishdate1 = $("input:checkbox[id='chkfinishdate1']").is(":checked");//$("#chkfinishdate").val();
		var finishdate1 = $("#finishdate1").val();
		var acceptno = $("#acceptno").val();
		var reqstate = $("#reqstate").val();
		
		var data = {"adminid":adminid,
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
            url: "<c:url value='/cooperate/result/getCoopReqList.json'/>",
            success: function (data) {
                dataProvider.fillJsonData(data);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
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
	                dataProvider.clearRowStates(true, true);
	                loadData();
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
	
	<%-- function fnConfirm(){
		
		var apprid =  '<%=nLoginVO.getAdminid()%>';
		var rows = gridView.getCheckedRows();
		var data = [];
		var jData
		
		if(rows.length > 0){
	        for(var i=0; i < rows.length; i++){
	        	jData = gridView.getValue(rows[i],"reqid");
	        	data.push(jData);
	        };
	    }
		
		if (data.length == 0) {
			alert("선택된 값이 없습니다.");
	        return;
	    }
		
		document.frm.data.value = data;
		document.frm.method="post"
		document.frm.action = "<c:url value='/exam/requestConfirm/RcListDetail.do'/>";
		document.frm.submit();
	} --%>
	
	function fnConfirmAll(){
		var apprid =  '<%=nLoginVO.getAdminid()%>';
		
		
		var rows = gridView.getCheckedRows();
		var jRowsData = [];
		var jRowsNotData = [];
		var jData
		
		if(rows.length > 0){
	        for(var i=0; i < rows.length; i++){
	        	if(gridView.getValue(rows[i],"nullcnt") > 0){
					alert("결과 미입력 건수가 남아있습니다.");
					return;
				}
	        	jData = dataProvider.getJsonRow(rows[i]);
	            jRowsData.push(jData);
	        }
	        
	    }
		
		if (jRowsData.length == 0) {
			alert("선택된 값이 없습니다.");
	        return;
	    } else {
	    	$("#reqConfModal").modal('show');
			$("#reqConfModal").on('shown.bs.modal', function () {
				selModal();
	    	});				
	    }
		
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

        $("#secondOpt").append("<option>" + "전체" + "</option>");
        $("#thirdOpt").append("<option>" + "전체" + "</option>");

        for (var i = 0; i < secondSelectListJson.length; i++) {

            if (secondSelectListJson[i].classID == optionValue) { // 1번째에서 선택 된 클래스아이디와 같은 종류만 모두 소집
                $("#secondOpt").append("<option value='" + secondSelectListJson[i].groupID + "'>" + secondSelectListJson[i].name + "</option>");
            }

        }
    }

    function selThirdOption() {

        var optionValue = $("#secondOpt option:selected").val();


        $("#thirdOpt option").remove();
        $("#thirdOpt").append("<option>" + "전체" + "</option>");

        for (var i = 0; i < thirdSelectListJson.length; i++) {

            if (thirdSelectListJson[i].groupID == optionValue) { // 1번째에서 선택 된 클래스아이디와 같은 종류만 모두 소집
                $("#thirdOpt").append("<option value='" + thirdSelectListJson[i].masterID + "'>" + thirdSelectListJson[i].name + "</option>");
            }

        }
    }
    
    function fnApprConf(){
		apprView4.commit();
		
		var state;
	    var jData;
	    var jRowsData = [];
	    
		var chkrows = gridView.getCheckedRows();
	    
		if(chkrows.length > 0){
	        for(var i=0; i < chkrows.length; i++){
	    	    	if(apprView4.getValue(0, "fstapprid") != null){
	    	            jData = {
	    	                "draftid": apprView4.getValue(0, "draftid"),
	    	                "apprid": apprView4.getValue(0, "fstapprid"),
	    	                "ordinal": "1"
	    	            }
	    	            jData.reqid = gridView.getValue(chkrows[i],"reqid");
	    	            jData.reportid = gridView.getValue(chkrows[i],"reportid");
	    	            jRowsData.push(jData);
	    	    	}
	    	    	
	    	    	if(apprView4.getValue(0, "sndapprid") != null){
	    	            jData = {
	    	                "draftid": apprView4.getValue(0, "draftid"),
	    	                "apprid": apprView4.getValue(0, "sndapprid"),
	    	                "ordinal": "2"
	    	            }
	    	            jData.reqid = gridView.getValue(chkrows[i],"reqid");
	    	            jData.reportid = gridView.getValue(chkrows[i],"reportid");
	    	            jRowsData.push(jData);
	    	    	}
	    	    	
	    	    	if(apprView4.getValue(0, "trdapprid") != null){
	    	            jData = {
	    	                "draftid": apprView4.getValue(0, "draftid"),
	    	                "apprid": apprView4.getValue(0, "trdapprid"),
	    	                "ordinal": "3"
	    	            }
	    	            jData.reqid = gridView.getValue(chkrows[i],"reqid");
	    	            jData.reportid = gridView.getValue(chkrows[i],"reportid");
	    	            jRowsData.push(jData);
	    	    	}
	    	    	
	    	    	if(apprView4.getValue(0, "fthapprid") != null){
	    	            jData = {
	    	                "draftid": apprView4.getValue(0, "draftid"),
	    	                "apprid": apprView4.getValue(0, "fthapprid"),
	    	                "ordinal": "4"
	    	            }
	    	            jData.reqid = gridView.getValue(chkrows[i],"reqid");
	    	            jData.reportid = gridView.getValue(chkrows[i],"reportid");
	    	            jRowsData.push(jData);
	    	    	}	   
	        } 
		}   
	        	
		if (jRowsData.length == 0) {
	    	alert("선택된 내용이 없습니다.");
	        apprProvider.clearRowStates(true);
	        return;
	    }
	    
	    var val = JSON.stringify(jRowsData);
	    var data = {"data":val};
	    
	    if(confirm("결재 요청 하시겠습니까?")){
	    	saveDataConfirm("<c:url value='/exam/result/inApprConf.json'/>",data);	
	    }
	    
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
	            	loadData();
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
	
	//sel();
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
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>접수번호</b></label>
			<div class="col-md-9">
				<input type="text" class="form-control inputBox" id="acceptno"  name="acceptno"/>
			</div>
		</div>
	</fieldset>
	<fieldset>
			<div class="col-md-12 form-group">
			<label class="col-md-3 form-label" style="width:12.5%"><b>유종구분 / 유종 / 제품</b></label>
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
		<div class="col-md-6 form-group ">
			<label class="col-md-3 form-label"><b>시료명</b></label>
			<div class="col-md-9" >
				<input type="text" class="form-control inputBox" id="smpname"  name="smpname"/>
			</div>
		</div>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>시험항목</b></label>
			<div class="col-md-9">
				<div class="col-sm-10 form-button" >
				<input type="text" class="form-control inputBox" id="itemname"  name="itemname"/>
				</div>
				<div class="col-sm-2 form-button" >				
					<button class="btn btn-default btn-primary" type="button" onclick="javascript:getReceiveList();">
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
    
    <div role="content">
		<div class="dt-toolbar">
			<div class="col-sm-6">
				<div class="txt-guide">
					
				</div>  
			</div>
			
			
			<div class="col-sm-6 text-right" >
				<!-- <p style="float: right;margin-left: 10px;">
					<a href="javascript:fnConfirmAll();" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>발급승인요청</a>
				</p> -->
			</div>
			
		</div>
			
		<div class="div-realgrid">	
			<div id="realgrid" style="width: 100%; height: 550px;"></div>
		</div>			
			
	<!-- end of realgrid Content -->		
	</div>
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
			<div id="realgrid2" style="width: 100%; height: 100px;"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<form name="frm">
<input type="hidden" name="data" id="data">
</form>	

<jsp:include page="/include/approval/reportApprovalPop.jsp"></jsp:include>
<jsp:include page="/include/req/reqComHistory.jsp"></jsp:include>