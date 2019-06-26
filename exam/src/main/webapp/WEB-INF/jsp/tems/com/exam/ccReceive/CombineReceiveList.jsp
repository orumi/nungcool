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
				width: 80
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "업체명"
				},
				width: 180
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "전화번호"
				},
				width: 70
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "요청\n접수번호"
				},
				width: 80
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "요청\n시료명"
				},
				width: 60
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "세금계산서\n발행업체"
				},
				width: 100
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "수수료"
				},
				width: 80
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "신청\n등본"
				},
				width: 60
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "진행\n상태"
				},
				width: 80
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "결재일자"
				},
				width: 100
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "결재\n유형"
				},
				width: 100
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "계산서\n발행일자"
				},
				width: 100
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "승인\n요청"
				},
				width: 80
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "성적서\n발행일자"
				},
				width: 80
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "성적서\n발행일자"
				},
				width: 80
			},
			{
				name: "",
				fieldName: "",
				header : {
					text: "성적서\n보기"
				},
				width: 80
			},
			{
			    "type": "group",
			    "name": "인쇄여부",
			    "width": 160,
			
			    "columns": [{
			        	name: "",
			        	fieldName: "",
			       	 	header: {
			            	text: "인쇄일자"
			  	    	},
			       	 	width: 80
			    	},
			    	{
			            name: "",
			            fieldName: "",
			            header: {
			                text: "초기화"
			            },
			            width: 80
			        }
				]
			}
	    ];
	    
	    //컬럼을 GridView에 입력 합니다.
	    gridView.setColumns(columns);
	    
	    /* 그리드 row추가 옵션사용여부 */
	    gridView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false }
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
	<div class="infoDiv4">
		<div style="height: 100%;width: 95%;float: left;">
			<div class="col col-lg-12 infoRow4">
				<div class="col col-lg-2 infoTitle" style="float: left;"><b>신청일자</b></div>
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
				<div class="col col-lg-2 infoTitle" style="float: left;"><b>결재일자</b></div>
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
			
			<div class="col col-lg-12 infoRow4">
				<div class="col col-lg-2 infoTitle" style="float: left;"><b>신청자</b></div>
				<div class="col col-lg-4 infoInput" style="float: left;">
					<input type="text" class="inputBox"/>
				</div>
				<div class="col col-lg-2 infoTitle" style="float: left;"><b>결재유형</b></div>
				<div class="col col-lg-4 infoInput infoInputRight" style="float: left;">
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<option>카드</option>
						<option>현금</option>
						<option>기타</option>
					</select>
				</div>
			</div>
			
			<div class="col col-lg-12 infoRow4">
				<div class="col col-lg-2 infoTitle" style="float: left;"><b>승인요청상태</b></div>
				<div class="col col-lg-4 infoInput" style="float: left;">
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<option>요청전</option>
						<option>결제중</option>
					</select>
				</div>
				<div class="col col-lg-2 infoTitle" style="float: left;"><b>진행상태</b></div>
				<div class="col col-lg-4 infoInput infoInputRight" style="float: left;">
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<option>접수대기</option>
						<option>접수완료</option>
					</select>
				</div>
			</div>
			
			<div class="col col-lg-12 infoRow4">
				<div class="col col-lg-2 infoTitle" style="float: left;"><b>신청업체명</b></div>
				<div class="col col-lg-4 infoInput" style="float: left;">
					<input type="text" class="inputBox"/>
				</div>
				<div class="col col-lg-2 infoTitle" style="float: left;"><b>세금계산서업체명</b></div>
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
	
	<div style="height: 40px;">
		<div class="listTitle col col-lg-2">
			<p>
				접수내역
			</p>			
		</div>
		<div class="col col-lg-10">
			<p style="float: right;margin-left: 10px;">
				<a href="javascript:void(0);" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>성적서발급</a>
			</p>
			<p style="float: right;margin-left: 10px;">
				<a href="javascript:void(0);" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>결재승인요청</a>
			</p>
			<p style="float: right;margin-left: 10px;">
				<a href="javascript:void(0);" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>세금계산서생성</a>
			</p>
			<p style="float: right;margin-left: 10px;">
				<a href="javascript:void(0);" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>결재정보저장</a>
			</p>
			<p style="float: right;margin-left: 10px;">
				<a href="javascript:void(0);" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>접수완료</a>
			</p>
		</div>
	</div>
	
	<div style="height: 550px;">
		<div class="col col-lg-12" >
			<div id="realgrid" style="width: 100%; height: 500px;"></div>
		</div>
	</div>
</div>	