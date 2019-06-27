<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="tems.com.login.model.LoginUserVO" %>


<script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>  
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
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    dataProvider = new RealGridJS.LocalDataProvider();
	    gridView = new RealGridJS.GridView("realgrid");
	    gridView.setDataSource(dataProvider);
	    
	    //setOptions(gridView);
	    
	    
	    var fields = [
			 {fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
			,{fieldName: ""}
	    ];

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
    			width: 100
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "전화번호"
    			},
    			width: 80
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "요청접수번호"
    			},
    			width: 110
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "요청시료명"
    			},
    			width: 80
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "세금계산서\n발행업체"
    			},
    			width: 80
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
    				text: "신청등본"
    			},
    			width: 80
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "진행상태"
    			},
    			width: 80
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "결재일자"
    			},
    			width: 110
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "결재유형"
    			},
    			width: 110
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "계산서\n발행일자"
    			},
    			width: 80
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "승인요청"
    			},
    			width: 70
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
    				text: "성적서보기"
    			},
    			width: 50
    		},
    		{
                "type": "group",
                "name": "인쇄여부",
                "width": 120,

                "columns": [
					{
                    	name: "",
                    	fieldName: "",
                    	header: {
                        	text: "인쇄"
                    	},
                    	width: 60
                	},
                	{
                        name: "",
                        fieldName: "",
                        header: {
                            text: "초기화"
                        },
                        width: 60
                    }
           		]
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
							<input type="checkbox" class="checkbox" id="" name="">
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
						<input type="checkbox" class="checkbox"  id="" name="">
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
		<div class="col-md-6 form-group ">
			<label class="col-md-3 form-label"><b>결재일자</b></label>
			<div class="col-md-9">
				<div class="col-sm-1 checkbox" style="padding-left:0px;width:20px;">
					<label>
							<input type="checkbox" class="checkbox" id="" name="">
							<span></span>
					</label>		
				</div>
				<div class="col-sm-4" style="padding-left:0px;">
					<div class="input-group">
						<input class="form-control form-calendar" id="startdate2" name="startdate2" type="text">
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
						<div class="col-sm-1 wave">
							<b>~</b>
						</div>
				<div class="col-sm-1 checkbox" style="padding-left:0px;width:20px;">
					<label>
						<input type="checkbox" class="checkbox"  id="" name="">
						<span></span>
					</label>
				</div>	
				<div class="col-sm-4" style="padding-left:0px;">
					<div class="input-group">
						<input class="form-control form-calendar" id="finishdate2" name="finishdate2" type="text">
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
			</div>
		</div>
	</fieldset>
	
	<fieldset>
		<div class="col-md-6 form-group ">
			<label class="col-md-3 form-label"><b>신청자</b></label>
			<div class="col-md-9">
				<input type="text" class="form-control inputBox" id=""  name=""/>
			</div>
		</div>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>결재유형</b></label>
			<div class="col-md-9">
				<select class="form-control selectBox" id="" name="">
					<option value="" selected="selected">전체</option>
					<option value="">카드</option>
					<option value="">현금</option>
					<option value="">기타</option>
				</select>
			</div>
		</div>
	</fieldset>
	
	<fieldset>
		<div class="col-md-6 form-group ">
			<label class="col-md-3 form-label"><b>승인요청상태</b></label>
			<div class="col-md-9">
				<select class="form-control selectBox" id="" name="">
					<option value="" selected="selected">요청전</option>
					<option value="">결재중</option>
					<option value="">승인</option>
				</select>
			</div>
		</div>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>발급상태</b></label>
			<div class="col-md-9">
				<select class="form-control selectBox" id="" name="">
					<option value="" selected="selected">발급전</option>
					<option value="">발급완료</option>
				</select>
			</div>
		</div>
	</fieldset>
	
	<fieldset>
		<div class="col-md-6 form-group">
			<label class="col-md-3 form-label"><b>신청업체명</b></label>
			<div class="col-md-9">
				<input type="text" class="form-control inputBox" id=""  name=""/>
			</div>
		</div>
		<div class="col-md-6 form-group ">
			<label class="col-md-3 form-label"><b>세금계산서업체명</b></label>
			<div class="col-md-9">
				<div class="col-sm-10 form-button">
					<input type="text" class="form-control inputBox" id=""  name=""/>
				</div>
				<div class="col-sm-2 form-button">				
					<button class="btn btn-default btn-primary" type="button" onclick="">
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
				<button class="btn btn-default" >
					접수완료
				</button>
				<button class="btn btn-default" >
					결재정보저장
				</button>
				<button class="btn btn-default" >
					세금계산서생성
				</button>
				<button class="btn btn-default">
					결재승인요청
				</button>
				<button class="btn btn-default">
					성적서발급
				</button>
			</div>
			
		</div>
		
		<div class="div-realgrid">	
			<div id="realgrid" style="width: 100%; height: 550px;"></div>
		</div>			
			
	<!-- end of realgrid Content -->		
	</div>
</div>

