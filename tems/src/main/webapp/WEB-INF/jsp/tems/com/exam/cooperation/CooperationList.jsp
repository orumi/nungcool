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
			getJavaObject();
			getCooperationList();
		});
</script>
<script>
	var gridView;
	var dataProvider;
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    dataProvider = new RealGridJS.LocalDataProvider();
	    gridView = new RealGridJS.GridView("realgrid");
	    gridView.setDataSource(dataProvider);
	    
	    //setOptions(gridView);
	    
	    
	    var fields = [
			 {fieldName: "coopercnt"}
			,{fieldName: "rltcnt"}
			,{fieldName: "receiptdate"}
			,{fieldName: "nullcnt"}
			,{fieldName: "officenm"}
			,{fieldName: "remark"}
			,{fieldName: "issuedateplan"}
			,{fieldName: "itemterm"}
			,{fieldName: "dday"}
			,{fieldName: "statenm"}
			,{fieldName: "smpcnt"}
			,{fieldName: "memname"}
			,{fieldName: "reqid"}
			,{fieldName: "comname"}
			,{fieldName: "reportid"}
			,{fieldName: "issustatenm"}
			,{fieldName: "acceptno"}
			,{fieldName: "officeid"}
	    ];

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns = [
			{
				name: "acceptno",
				fieldName: "acceptno",
				header : {
					text: "접수번호"
				},
				styles: {
    		        textAlignment: "near"
    		    },
				width: 150
			},
    		{
    			name: "comname",
    			fieldName: "comname",
    			header : {
    				text: "의뢰업체"
    			},
    			styles: {
    		        textAlignment: "near"
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
    			name: "officenm",
    			fieldName: "officenm",
    			header : {
    				text: "협조본부"
    			},
    			styles: {
    		        textAlignment: "near"
    		    },
    			width: 110
    		},
    		{
    			name: "coopercnt",
    			fieldName: "coopercnt",
    			header : {
    				text: "협조항목"
    			},
    			width: 110
    		},
    		{
    			name: "statenm",
    			fieldName: "statenm",
    			header : {
    				text: "진행상태"
    			},
    			width: 110
    		}
	    ];
	    
	    
	    dataProvider.setFields(fields);
	    gridView.setColumns(columns);
	    
	    
	    /* 그리드 row추가 옵션사용여부 */
		gridView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	        display : { fitStyle : "evenFill" },
	        edit : {readOnly : true}
	    });
	    
	    
	    /* 헤더의 높이를 지정*/
	    gridView.setHeader({
	    	height: 45
	    });
	    
	    /* 그리드 스타일*/
		gridView.setStyles(smart_style);
		
	    
	});	    
	
	function getCooperationList(){
		var adminid =  '<%=nLoginVO.getAdminid()%>';
		var firstOpt = $("#firstOpt").val();
		var secondOpt = $("#secondOpt").val();
		var thirdOpt = $("#thirdOpt").val();
		var smpname = $("#smpname").val();
		var chkstartdate1 = $("input:checkbox[id='chkstartdate1']").is(":checked");//$("#chkstartdate").val();
		var startdate1 = $("#startdate1").val();
		var chkfinishdate1 = $("input:checkbox[id='chkfinishdate1']").is(":checked");//$("#chkfinishdate").val();
		var finishdate1 = $("#finishdate1").val();
		var acceptno = $("#acceptno").val();
		
		var data = {"adminid":adminid,
			"firstOpt":        firstOpt      ,
			"secondOpt":	secondOpt     ,
			"thirdOpt":	thirdOpt      ,
			"smpname":		smpname       ,
			"chkstartdate1":	chkstartdate1  ,
			"startdate1":	startdate1     ,
			"chkfinishdate1":	chkfinishdate1 ,
			"finishdate1":	finishdate1,
			"acceptno":	acceptno
		};		
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : data,
            url: "<c:url value='/exam/cooperation/getCooperationList.json'/>",
            success: function (data) {
            	dataProvider.fillJsonData(data.cooperationList);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            },
            cache: false
        });
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
    
    function fnConfirmAll(){
 		var adminid =  '<%=nLoginVO.getAdminid()%>';
 		
 		
 		var rows = gridView.getCheckedRows();
 		var jRowsData = [];
 		var jData = {};
 		
 		if(rows.length > 0){
 	        for(var i=0; i < rows.length; i++){
 	        	var rowData = dataProvider.getJsonRow(rows[i]);
 	        	jData.officeid = rowData.officeid;
 	        	jData.reqid = rowData.reqid;
 	        	jData.adminid = adminid;
 	            jRowsData.push(jData);
 	        };
 	    }
 		
 		if (jRowsData.length == 0) {
 			alert("선택된 값이 없습니다.");
 	        return;
 	    }
 		
 		var val = JSON.stringify(jRowsData);

 		var data = {"data":val};
 		var url = "<c:url value='/exam/cooperation/upCooperApproval.json'/>";
 		saveData(url,data);	
 	 }
    
	function fnConfirm(){
 		
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
 		document.frm.action = "<c:url value='/exam/cooperation/CooperationDetail.do'/>";
 		document.frm.submit();
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
	                getCooperationList();
	            } else {
	                alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	            }
	        },
	        error : function(request, status, error) {
	            alert("code:" + request.status + "\n" + "error:" + error);
	        }
	    });
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
					<button class="btn btn-default btn-primary" type="button" onclick="javascript:getCooperationList();">
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
				
				<!-- <button class="btn btn-default" onclick="location.href='/tems/exam/cooperation/CooperationDetail.do'">
					상세보기
				</button> -->
				<p style="float: right;margin-left: 10px;">
					<a href="javascript:fnConfirm();" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>개별승인</a>
				</p>
				<p style="float: right;margin-left: 10px;">
					<a href="javascript:fnConfirmAll();" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>일괄승인</a>
				</p>
			</div>
			
		</div>
		
		<div class="div-realgrid">	
			<div id="realgrid" style="width: 100%; height: 550px;"></div>
		</div>			
			
	<!-- end of realgrid Content -->		
	</div>
</div>

<form name="frm">
<input type="hidden" name="data" id="data">
</form>	