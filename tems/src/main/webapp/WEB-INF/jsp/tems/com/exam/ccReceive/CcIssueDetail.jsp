<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="tems.com.login.model.LoginUserVO" %>

<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<script src="<c:url value='/js/tems/common/stringutil.js'/>"></script>
<script src="<c:url value='/js/tems/common/priceutil.js'/>"></script>
<script>
		$(document).ready( function(){

		});
</script>
<script>
	var gridView;
	
	var dataProvider;
	
	var reqid = "${reqDetail.reqid}";
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    dataProvider = new RealGridJS.LocalTreeDataProvider();
	    gridView = new RealGridJS.TreeView("realgrid"); 
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
	    ];
	    
	    //DataProvider의 setFields함수로 필드를 입력합니다.
	    dataProvider.setFields(fields);

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns = [
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "검사항목명"
    			},
    			width: 210
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "단위"
    			},
    			width: 60
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "정렬순서"
    			},
    			width: 100
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "시험방법"
    			},
    			width: 200
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "조건"
    			},
    			readOnly : "true",
    			width: 200
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "수수료"
    			},
    			width: 150
    		},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "비고"
    			},
    			width: 300
    		},
    		{
                "type": "group",
                "name": "시험조건",
                "width": 200,

                "columns": [{
                    	name: "",
                    	fieldName: "",
                   	 	header: {
                        	text: "시간"
              	    	},
              	    	readOnly : "true",
                   	 	width: 100
                	},
                	{
                        name: "",
                        fieldName: "",
                        header: {
                            text: "온도"
                        },
                        width: 100
                    }
      			]
			},
    		{
    			name: "",
    			fieldName: "",
    			header : {
    				text: "시험기간"
    			},
    			width: 100
    		}
	    ];
	    
	    

	    //컬럼을 GridView에 입력 합니다.
	    gridView.setColumns(columns);
	    
	    /* 헤더의 높이를 지정*/
	    gridView.setHeader({
	    	height: 45
	    }); 
	    
	    
	    gridView.setStyles(smart_style);
	    
	    /* 그리드 row추가 옵션사용여부 */
		gridView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : false },
	        display : { fitStyle : "evenFill" },
	        edit : {readOnly : true}
	    });
	    
    })
</script>	


<div class="page-content">

	<div role="content">
		<div class="dt-toolbar border-bottom-solid">
			<div class="col-sm-6">
				<div class="txt-guide">
				</div>  
			</div>
			
			<div class="col-sm-6 text-right" >
				<button class="btn btn-default" onclick="">
					목록
				</button>
				<button class="btn btn-default" onclick="">
					승인보류 다음
				</button>
				<button class="btn btn-default" onclick="">
					협조승인 다음
				</button>
			</div>
		</div>
	</div>	


	<div role="content" class="clear-both sub-content">
	
		<div class="form-horizontal form-terms ui-sortable"> 
			<div class="jarviswidget jarviswidget-sortable" role="widget">	

				<!-- body -->    	
				<div class="widget-body">
		
					<fieldset>
						<div class="col-md-4 form-group ">
							<label class="col-md-4 form-label"><b>접수번호</b></label>
							<div class="col-md-8">
								<span class="txt-sub-content"></span>
							</div>
						</div>
					</fieldset>
					
					<fieldset>
						<div class="col-md-4 form-group ">
							<label class="col-md-4 form-label"><b>접수일</b></label>
							<div class="col-md-8">
								<span class="txt-sub-content"></span>
							</div>
						</div>
					</fieldset>		
					
					<fieldset>
						<div class="col-md-4 form-group ">
							<label class="col-md-4 form-label"><b>결과일</b></label>
							<div class="col-md-8">
								<span class="txt-sub-content"></span>
							</div>
						</div>
					</fieldset>	
				</div>
			</div>
		</div>
	</div>
	
	<div role="content" class="clear-both sub-content">
	
		<div class="form-horizontal form-terms ui-sortable"> 
			<div class="jarviswidget jarviswidget-sortable" role="widget">	
				<header role="heading">
				
				<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
				<h2>시료정보</h2>
				</header>
	
				<div class="widget-body">
		
					
				</div>
			</div>
		</div>
	</div>
	
	<div role="content" class="clear-both sub-content">
	
		<div class="form-horizontal form-terms ui-sortable"> 
			<div class="jarviswidget jarviswidget-sortable" role="widget">	
				<header role="heading">
				
				<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
				<h2>검사항목</h2>
				</header>
	
				<div class="widget-body">
		
					
				</div>
			</div>
		</div>
	</div>
	
	
</div>

