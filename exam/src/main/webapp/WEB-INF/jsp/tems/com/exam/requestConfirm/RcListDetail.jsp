<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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
	    				text: "순번"
	    			},
	    			width: 80
	    		},
	    		{
	    			name: "",
	    			fieldName: "",
	    			header : {
	    				text: "검사항목명"
	    			},
	    			width: 290
	    		},
	    		{
	    			name: "",
	    			fieldName: "",
	    			header : {
	    				text: "단위"
	    			},
	    			width: 80
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
	    			width: 100
	    		},
	    		{
	    			name: "",
	    			fieldName: "",
	    			header : {
	    				text: "조건"
	    			},
	    			width: 250
	    		},
	    		{
	    			name: "",
	    			fieldName: "",
	    			header : {
	    				text: "수수료"
	    			},
	    			width: 100
	    		},
	    		{
	    			name: "",
	    			fieldName: "",
	    			header : {
	    				text: "비고"
	    			},
	    			width: 100
	    		},
	            {
	                "type": "group",
	                "name": "시험조건",
	                "width": 160,

	                "columns": [{
	                    	name: "",
	                    	fieldName: "",
	                   	 	header: {
	                        	text: "시간"
	              	    	},
	                   	 	width: 80
	                	},
	                	{
	                        name: "",
	                        fieldName: "",
	                        header: {
	                            text: "온도"
	                        },
	                        width: 80
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
	    		},
	    		{
	    			name: "",
	    			fieldName: "",
	    			header : {
	    				text: "담당자"
	    			},
	    			width: 200
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
	
</script>	
<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">

	<!-- 신청자정보 ----------------------------------------------------------------- -->
	
	<div style="border: 0px solid red;height: 120px;">
	
		<div style="height: 40%">
			<div class="col col-lg-2 listTitle" style="float: left;">
				<p>
					신청자 정보
				</p>
			</div>
			<div class="col col-lg-10 btnDiv" style="float: left;">
				<p>
					<a href="javascript:void(0);" class="btn btn-labeled btn-success"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>의뢰승인 다음</a>
				</p>
				<p>
					<a href="javascript:void(0);" class="btn btn-labeled btn-success"> <span class="btn-label"><i class="glyphicon glyphicon-trash"></i></span>승인보류 다음</a>
				</p>
				<p style="margin-top: 5px">
					남은 결제 건수 : <input type="text" value="15" style="border: none;width: 20px;">건
				</p>
				<p>
					<a class="btn btn-default btn-danger" data-toggle="modal" data-target="#rejectBtn">반려</a>
				</p>
				<p>
					<a href="javascript:void(0);" class="btn btn-labeled btn-default"> <span class="btn-label"><i class="glyphicon glyphicon-th-list"></i></span>목록</a>
				</p>
				
			</div>
		</div>
		
		<div class="col col-lg-12" style="height: 60%">
			<div class="infoDiv2">
				<div class="col col-lg-1 infoTitle"><b>업체명</b></div>
				<div class="col col-lg-2 infoBody"><p>주식회사</p></div>
				<div class="col col-lg-1 infoTitle"><b>대표자</b></div>
				<div class="col col-lg-2 infoBody"><p>홍길동</p></div>
				<div class="col col-lg-1 infoTitle"><b>담당자</b></div>
				<div class="col col-lg-2 infoBody"><p>신길동</p></div>
				<div class="col col-lg-1 infoTitle"><b>담당부서</b></div>
				<div class="col col-lg-2 infoBody infoInputRight"><p>운영지원팀</p></div>
			</div>

			<div class="infoDiv2">
				<div class="col col-lg-1 infoTitle"><b>이메일</b></div>
				<div class="col col-lg-2 infoBody infoInputBottom"><p>@</p></div>
				<div class="col col-lg-1 infoTitle"><b>휴대폰</b></div>
				<div class="col col-lg-2 infoBody infoInputBottom"><p>010</p></div>
				<div class="col col-lg-1 infoTitle"><b>전화번호</b></div>
				<div class="col col-lg-2 infoBody infoInputBottom"><p>02</p></div>
				<div class="col col-lg-1 infoTitle"><b>팩스번호</b></div>
				<div class="col col-lg-2 infoBody infoInputRight infoInputBottom"><p>070</p></div>
			</div>
		</div>
	</div>
	
	<!-- 성적서정보 ----------------------------------------------------------------- -->
	
	<div style="border: 0px solid red;height: 300px;margin-top: 15px;">
		<div style="height: 15%">
			<div class="col col-lg-12 listTitle" >
				<p>
					성적서 정보
				</p>
			</div>
		</div>
		<div class="col col-lg-12" style="height: 85%;border: 0px solid blue;">
			<div class="infoRow7">
				<div class="col col-lg-2 infoTitle"><b>성적서 용도</b></div>
				<div class="col col-lg-2 infoBody"><p>성적서 용도 내용</p></div>
				<div class="col col-lg-2 infoTitle"><b>성적서 원본/등본</b></div>
				<div class="col col-lg-2 infoBody"><p>국문1부/영문0부</p></div>
				<div class="col col-lg-2 infoTitle"><b>시료개수</b></div>
				<div class="col col-lg-2 infoBody infoInputRight"><p>3</p></div>
			</div>
			<div class="infoRow7">
				<div class="col col-lg-2 infoTitle"><b>성적서 수신 업체</b></div>
				<div class="col col-lg-2 infoBody"><p>@</p></div>
				<div class="col col-lg-2 infoTitle"><b>성적서 수신인</b></div>
				<div class="col col-lg-6 infoBody infoInputRight"><p>신길동</p></div>
			</div>
			<div class="infoRow7">
				<div class="col col-lg-2 infoTitle"><b>성적서 수신주소</b></div>
				<div class="col col-lg-10 infoBody infoInputRight"><p>(12134)충남</p></div>
			</div>
			<div class="infoRow7">
				<div class="col col-lg-2 infoTitle"><b>세금계산서 청구선택</b></div>
				<div class="col col-lg-2 infoBody"><p>청구함</p></div>
				<div class="col col-lg-2 infoTitle"><b>세금계산서 업체</b></div>
				<div class="col col-lg-2 infoBody"><p>주식회사</p></div>
				<div class="col col-lg-2 infoTitle"><b>세금계산서 담당자</b></div>
				<div class="col col-lg-2 infoBody infoInputRight"><p>마길동</p></div>
			</div>
			<div class="infoRow7">
				<div class="col col-lg-2 infoTitle"><b>세금계산서 발급주소</b></div>
				<div class="col col-lg-6 infoBody" style="margin-left: -2px;"><p>(12313) 충남</p></div>
				<div class="col col-lg-2 infoTitle"><b>세금계산서 E-Mail</b></div>
				<div class="col col-lg-2 infoBody infoInputRight"><p>@</p></div>
			</div>
			<div class="infoRow7">
				<div class="col col-lg-2 infoTitle"><b>비고</b></div>
				<div class="col col-lg-10 infoBody infoInputRight"><p><input type="text" style="width: 100%"></p></div>
			</div>
			<div class="infoRow7">
				<div class="col col-lg-2 infoTitle"><b>시험자에게 남기는글</b></div>
				<div class="col col-lg-10 infoBody infoInputRight infoInputBottom"><p>잘부탁드립니다.</p></div>
			</div>
		</div>
	</div>	
	
	<!-- 시험항목정보 ----------------------------------------------------------------- -->
	
	<div style="height: 700px;border: 0px solid red;">
		<div class="col col-lg-12 listTitle">
			<p>
				시험 항목
			</p>
		</div>

		<div class="col col-lg-12" style="margin-bottom: 3px;height: 35px;"> 
			<div class="col col-lg-2 infoTitle">
				<b>시료 / 유종제품</b>
			</div>
			<div class="col col-lg-3" style="height: 100%">
				<select style="height: 33px;width: 100%;">
					<option>시료명1 / 제품명1</option>
					<option>시료명2 / 제품명2</option>
					<option>시료명2 / 제품명3</option>
				</select>
			</div>
		</div>

		<div class="col col-lg-12" style="margin-top: 15px;">
			<div id="realgrid" style="width: 100%; height: 500px;"></div>
		</div>
	</div>
</div>	

<!-- 반려 버튼  모달창------------------------------------------------------------------------ -->
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


