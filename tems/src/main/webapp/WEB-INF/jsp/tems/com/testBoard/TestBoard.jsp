<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>  -->
    
<style type="text/css">
	.menuTable{
		border: 0px solid gray;
		height: 168px;
		margin-bottom: 10px;
		font-size: 13px; 
	}
	tbody th{
	    width: 13%;
	    background-color: #D8D8D8;
	    text-align: center;
	    color: lightslategrey;
	}
	.inputBox{
	    border: 1px solid #ccc;
	    margin-top: 5px;
	    height: 32px;
	    width: 60%;
	}
	.selectBox{
		width: 30%;
		margin-top: 5px;
	}
	.menuTitle{
		background-color: #E6E6E6;
		height: 100%;
		border-bottom: 1px solid white;
		display: table;
	}
	.menuTitle b{
		display: table-cell; 
		text-align: center; 
		vertical-align: middle;
	}
	.input-group{
		margin-top: 4px;		
	}
	.wave{
		height: 100%;
		display: table;
	}
	.wave b{
		display: table-cell; 
		text-align: center; 
		vertical-align: middle;
	}
	.menuInput{
		height: 100%;
		border-bottom: 1px solid #E6E6E6;
	}
	.menuTop{
		border-top: 1px solid #E6E6E6;
	}
</style> 

<script>
		$(document).ready( function(){	
			// 신청일자
			$('#startdate1').datepicker({
			    dateFormat: 'yy.mm.dd',
			    prevText: '<i class="fa fa-chevron-left"></i>',
			    nextText: '<i class="fa fa-chevron-right"></i>',
			    onSelect: function (selectedDate) {
			        $('#finishdate1').datepicker('option', 'minDate', selectedDate);
			    }
			});
			 
			
			$('#finishdate1').datepicker({
			    dateFormat: 'yy.mm.dd',
			    prevText: '<i class="fa fa-chevron-left"></i>',
			    nextText: '<i class="fa fa-chevron-right"></i>',
			    onSelect: function (selectedDate) {
			        $('#startdate1').datepicker('option', 'maxDate', selectedDate);
			    }
			});
			
			// 결재일자
			$('#startdate2').datepicker({
			    dateFormat: 'yy.mm.dd',
			    prevText: '<i class="fa fa-chevron-left"></i>',
			    nextText: '<i class="fa fa-chevron-right"></i>',
			    onSelect: function (selectedDate) {
			        $('#finishdate2').datepicker('option', 'minDate', selectedDate);
			    }
			});
			 
			
			$('#finishdate2').datepicker({
			    dateFormat: 'yy.mm.dd',
			    prevText: '<i class="fa fa-chevron-left"></i>',
			    nextText: '<i class="fa fa-chevron-right"></i>',
			    onSelect: function (selectedDate) {
			        $('#startdate2').datepicker('option', 'maxDate', selectedDate);
			    }
			});
			//게시판행 추가
			$("#btnAppend").click(function(){
				btnAppendClick()
			});
			
		});
</script>
<script>
	var gridView;
	var dataProvider;
	
	$(document).ready( function(){
		
		RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
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
    			name: "title",
    			fieldName: "title",
    			header : {
    				text: "제목"
    			},
    			width: 300
    		},
    		{
    			name: "content",
    			fieldName: "content",
    			header : {
    				text: "내용"
    			},
    			width: 300
    		},
    		{
    			name: "b_date",
    			fieldName: "b_date",
    			header : {
    				text: "작성일"
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
	
	//sel();
</script>	
<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">
	<div class="menuTable">
		<div class="col col-lg-11" style="height: 173px;">
			<div class="col col-lg-12" style="height: 25%">
				<div class="col col-lg-2 menuTitle" style="float: left;"><b>신청일자</b></div>
				<div class="col col-lg-4 menuInput menuTop" style="float: left; height: 100%">
					<span class="checkbox col-sm-1">
							<label>
								<input type="checkbox" class="checkbox style-0">
								<span></span>
							</label>
						</span>
						<div class="col-sm-4">
							<div class="input-group">
								<input class="form-control" id="startdate1" type="text" placeholder="Start Date">
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
								<input class="form-control" id="finishdate1" type="text" placeholder="Finish Date">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
						</div>
				</div>
				<div class="col col-lg-2 menuTitle" style="float: left;"><b>결재일자</b></div>
				<div class="col col-lg-4 menuInput menuTop" style="float: left;height: 100%;">
					<span class="checkbox col-sm-1">
						<label>
							<input type="checkbox" class="checkbox style-0">
							<span></span>
						</label>
					</span>
					<div class="col-sm-4">
						<div class="input-group">
							<input class="form-control" id="startdate2" type="text" placeholder="Start Date">
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
							<input class="form-control" id="finishdate2" type="text" placeholder="Finish Date">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col col-lg-12" style="height: 25%">
				<div class="col col-lg-2 menuTitle" style="float: left;"><b>신청자</b></div>
				<div class="col col-lg-4 menuInput" style="float: left;">
					<input type="text" class="inputBox"/>
				</div>
				<div class="col col-lg-2 menuTitle" style="float: left;"><b>결재유형</b></div>
				<div class="col col-lg-4 menuInput" style="float: left;">
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<option>카드</option>
						<option>현금</option>
						<option>기타</option>
					</select>
				</div>
			</div>
			
			<div class="col col-lg-12" style="height: 25%">
				<div class="col col-lg-2 menuTitle" style="float: left;"><b>승인요청상태</b></div>
				<div class="col col-lg-4 menuInput" style="float: left;">
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<option>요청전</option>
						<option>결제중</option>
					</select>
				</div>
				<div class="col col-lg-2 menuTitle" style="float: left;"><b>진행상태</b></div>
				<div class="col col-lg-4 menuInput" style="float: left;">
					<select class="form-control selectBox" id="select-1">
						<option selected="selected">전체</option>
						<option>접수대기</option>
						<option>접수완료</option>
					</select>
				</div>
			</div>
			
			<div class="col col-lg-12" style="height: 25%">
				<div class="col col-lg-2 menuTitle" style="float: left;"><b>신청업체명</b></div>
				<div class="col col-lg-4 menuInput" style="float: left;">
					<input type="text" class="inputBox"/>
				</div>
				<div class="col col-lg-2 menuTitle" style="float: left;"><b>세금계산서업체명</b></div>
				<div class="col col-lg-4 menuInput" style="float: left;">
					<input type="text" class="inputBox"/>
				</div>
			</div>
		</div>
		
		<!-- -----------------------------------------------------------------------------------  -->
		
		<div class="col col-lg-1" style="border: 0px solid yellow; height: 100%;float: left;width: 5%;">
			<p style="text-align: center;">
				<a class="btn btn-primary btn-sm">조회</a>
			</p>
		</div>
	</div>
	
	<div>
		<input type="button" class="btn btn-primary btn-sm" 
			style="float: right;margin-bottom: 10px;" id="btnAppend" value="게시물 추가" >
	</div>
	
	<div id="realgrid" style="width: 100%; height: 500px;"></div>
</div>	