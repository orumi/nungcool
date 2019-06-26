<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
    
<script>
		$(document).ready( function(){	
						
		});
</script>
<script>
	var gridView;
	var dataProvider;
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
        RealGridJS.setRootContext("/script");
	    
	    dataProvider = new RealGridJS.LocalTreeDataProvider();
	    gridView = new RealGridJS.TreeView("realgrid"); 
	    gridView.setDataSource(dataProvider);   
	    
	    setOptions(gridView);
	    
	    var fields = [
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
	    
	    //DataProvider의 setFields함수로 필드를 입력합니다.
	    dataProvider.setFields(fields);

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns = [
				{
					name: "",
					fieldName: "",
					header : {
						text: "신청일자"
					},
					width: 100
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "업체명"
					},
					width: 200
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "신청자"
					},
					width: 80
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "전화번호"
					},
					width: 150
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "시료\n건수"
					},
					width: 50
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "항목\n건수"
					},
					width: 50
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "세금계산서\n발생업체"
					},
					width: 110
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "결제\n청구유형"
					},
					width: 70
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "견적서"
					},
					width: 70
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "결제일자"
					},
					width: 140
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "결제금액"
					},
					width: 140
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "결제유형"
					},
					width: 140
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "계산서\n발생일자"
					},
					width: 100
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "승인\n요청"
					},
					width: 50
				},
				{
					name: "",
					fieldName: "",
					header : {
						text: "진행상태"
					},
					width: 150
				}
	    ];
	    
	    //컬럼을 GridView에 입력 합니다.
	    gridView.setColumns(columns);
	    
	    /* 그리드 row추가 옵션사용여부 */
	    gridView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false }
	    });
	    
	    /* 헤더의 높이를 지정*/
	    gridView.setHeader({
	    	height: 30
	    }); 
	    
	    loadDate();
	    
	});	    
	
	function loadDate(){
		$.ajax({
			type : "post",
		    dataType : "json",
            url: "<c:url value='/com/testBoard/jangme/loadDate.do'/>",
            success: function (data) {
                dataProvider.setRows(data,"title", true);
                //setTimeout(fnExpand, 1000);
            },
            error:function(request,status,error){
                //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	//gridView.hideToast();
            	fnExpand();
            },
            cache: false
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
	
	function fnExpand(){
		 gridView.expandAll();
	}
	
	function btnAppendClick(e) {
        console.log('btnAppendClick');
        gridView.beginAppendRow();
        gridView.commit();
    }
	
	function reqDetail(){
		document.progrmManageForm.action = "/eGov_test/exam/req/ReqListDetail.do";
	   	document.progrmManageForm.submit();
	}
	
	//sel();
</script>	
<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">
	<div class="menuTable" style="height: 128px;">
		<div style="height: 100%;width: 95%;float: left;">
			<div class="col col-lg-12" style="height: 33%">
				<div class="col col-lg-2 infoTitle"><b>신청일자</b></div>
				<div class="col col-lg-4 infoInput infoInputTop" style="float: left; height: 100%">
					<span class="checkbox col-sm-1">
							<label>
								<input type="checkbox" class="checkbox style-0">
								<span></span>
							</label>
						</span>
						<div class="col-sm-4">
							<div class="input-group">
								<input class="form-control" id="startdate1" type="text">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
						</div>
						<div class="col-sm-1 wave">
							<b>~</b>
						</div>
						<span class="checkbox col-sm-1">
							<label>
								<input type="checkbox" class="checkbox style-0">
								<span></span>
							</label>
						</span>
						<div class="col-sm-4">
							<div class="input-group">
								<input class="form-control" id="finishdate1" type="text">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
						</div>
				</div>
				<div class="col col-lg-2 infoTitle"><b>결재일자</b></div>
				<div class="col col-lg-4 infoInput infoInputTop infoInputRight" style="float: left;height: 100%;">
					<span class="checkbox col-sm-1">
						<label>
							<input type="checkbox" class="checkbox style-0">
							<span></span>
						</label>
					</span>
					<div class="col-sm-4">
						<div class="input-group">
							<input class="form-control" id="startdate2" type="text">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-1 wave">
						<b>~</b>
					</div>
					<span class="checkbox col-sm-1">
						<label>
							<input type="checkbox" class="checkbox style-0">
							<span></span>
						</label>
					</span>
					<div class="col-sm-4">
						<div class="input-group">
							<input class="form-control" id="finishdate2" type="text">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col col-lg-12" style="height: 33%">
				<div class="col col-lg-2 infoTitle"><b>신청자</b></div>
				<div class="col col-lg-4 infoInput" style="float: left;">
					<input type="text" class="inputBox"/>
				</div>
				<div class="col col-lg-2 infoTitle"><b>결재유형</b></div>
				<div class="col col-lg-4 infoInput infoInputRight" style="float: left;">
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<option>카드</option>
						<option>현금</option>
						<option>기타</option>
					</select>
				</div>
			</div>
			
			<div class="col col-lg-12" style="height: 33%">
				<div class="col col-lg-2 infoTitle"><b>신청업체명</b></div>
				<div class="col col-lg-4 infoInput" style="float: left;">
					<input type="text" class="inputBox"/>
				</div>
				<div class="col col-lg-2 infoTitle"><b>세금계산서업체명</b></div>
				<div class="col col-lg-4 infoInput infoInputRight" style="float: left;">
					<input type="text" class="inputBox"/>
				</div>
			</div>
			
			<!-- <div class="col col-lg-12" style="height: 20%">
				<p>
					<a class="btn btn-labeled btn-default btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-search"></i></span>조회</a>
				</p>
			</div> -->
		</div>
		
		<!-- -----------------------------------------------------------------------------------  -->
		
		<div class="searchDiv">
			<p class="searchBtn">
				<a href="javascript:void(0);" class="btn btn-default txt-color-dark">조회</a>
			</p>
		</div> 
	</div>
	
	<div class="btnDiv">
		<p style="float: right;margin-left: 10px;">
			<a href="javascript:void(0);" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>결제유형 저장</a>
		</p>
		<p style="float: right;margin-left: 10px;">
			<a class="btn btn-default" data-toggle="modal" data-target="#rejectBtn">반려 상세보기</a>
		</p>
	</div>
	
	<div id="realgrid" style="width: 100%; height: 500px;"></div>
	
	<div class="btnDiv">
		<p style="float: right;">
			<a class="btn btn-labeled btn-success btn-sm" id="reqConfBtn" data-toggle="modal"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>의뢰승인요청</a>
		</p>
	</div>
</div>	


<!-- 승인요청 반려 상세 모달창------------------------------------------------------------------------ -->
<div class="modal fade" id="rejectBtn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog rejectDia" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
        <h4 class="modal-title" id="myModalLabel">반려</h4>
      </div>
      <div class="modal-body rejectBody">
			<div style="height: 20%">
				<div class="col col-lg-2 rjHeader"><p>반려자</p></div>
				<div class="col col-lg-10 rjBody" style="height: 100%;border-top: 1px solid #E6E6E6;">
					<p>
						<input type="text" value="신길동" style="border: none;">
					</p>
				</div>
			</div>
			<div style="height: 80%">
				<div class="col col-lg-2 rjHeader"><p>반려사유</p></div>
				<div class="col col-lg-10 rjBody" style="height: 100%;">
					<p>
						<textarea rows="5" cols="59" style="resize: none;"></textarea>
					</p>
				</div>
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary">반려</button>
      </div>
    </div>
  </div>
</div>

