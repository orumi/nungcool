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
	.info1, .info2, .sInfo1, .sInfo2{
		height: 100%;
		display: table;
		float: left;
	}
	
	.info1, .sInfo1, .suInfo1{
		background-color: #E6E6E6;
		font-weight: bold;
    	border-bottom: 1px solid white;
	}
	
	.info2, .sInfo2{
		border-bottom: 1px solid #E6E6E6;
	}
	
	.info1 p, .sInfo1 p{
		display: table-cell;
    	text-align: center;
    	vertical-align: middle;
	}
	.info2 p, .sInfo2 p{
		display: table-cell;
    	vertical-align: middle;
	}
	.sinBut p, .siBut p{
		float: right;
		margin-right: 5px;
	}

	.sinTitle p, .sonTitle p, .suTitle p{
		float: left;
	    height: 100%;
	    font-size: 15px;
	    border-left: 2px solid lightgrey;
	    border-top: 2px solid lightgray;
	    border-right: 2px solid lightgray;
	    padding: 2px 5px;
	    margin-left: -12px;
	}
	
	.sinInfo1, .sinInfo2{
		height: 50%;
	}
	.sinInfo1>.info2, .soInfo1>.sInfo2{
		border-top: 1px solid #E6E6E6;
	}
	
	.soInfo1, .soInfo2{
		height: 14%;
	}
	
    .testMenu{
    	height: 100%;
    	background-color: #E6E6E6;
    	font-weight: bold;
    	display: table;
    	margin-left: -12px;
    }
    .testMenu p, .suInfo1 p{
    	display: table-cell;
    	text-align: center;
    	vertical-align: middle;
    }
    .suInfo1, .suInfo2{
    	height: 100%;
    	float: left;
    }
    .suInfo1, .suInfo2{
    	display: table;
    }
    .suInfo2 p, .suInfo2_1 p{
    	display: table-cell;
    	text-align: right;
    	vertical-align: middle;
    }
    .suInfo2{
    	border-right: 1px solid #E6E6E6;
    }
    .suInfo2_1{
    	border-left: 1px solid #E6E6E6;
    }
    .suInfo2_2{
    	height: 100%;
    	border-right: 1px solid #E6E6E6;
    	border-top: 1px solid #E6E6E6;
    	border-bottom: 1px solid #E6E6E6;
    }
</style> 

<script>
		$(document).ready( function(){	
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
	
</script>	
<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">

	<!-- 신청자정보 ----------------------------------------------------------------- -->
	
	<div style="border: 0px solid red;height: 100px;">
	
		<div style="height: 37%">
			<div class="col col-lg-2 sinTitle" style="float: left;">
				<p>
					신청자 정보
				</p>
			</div>
			<div class="col col-lg-10 sinBut" style="float: left;">
				<p>
					<a href="javascript:void(0);" class="btn btn-labeled btn-success"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>저장</a>
				</p>
				<p>
					<a href="javascript:void(0);" class="btn btn-labeled btn-danger"> <span class="btn-label"><i class="glyphicon glyphicon-trash"></i></span>삭제</a>
				</p>
				<p>
					<a href="javascript:void(0);" class="btn btn-labeled btn-info"> <span class="btn-label"><i class="glyphicon glyphicon-plus"></i></span>세금계산서</a>
				</p>
				<p>
					<a href="javascript:void(0);" class="btn btn-labeled btn-default"> <span class="btn-label"><i class="glyphicon glyphicon-th-list"></i></span>목록</a>
				</p>
				
			</div>
		</div>
		
		<div style="height: 63%">
			<div class="sinInfo1">
				<div class="col col-lg-1 info1"><p>업체명</p></div>
				<div class="col col-lg-2 info2"><p>주식회사</p></div>
				<div class="col col-lg-1 info1"><p>대표자</p></div>
				<div class="col col-lg-2 info2"><p>홍길동</p></div>
				<div class="col col-lg-1 info1"><p>담당자</p></div>
				<div class="col col-lg-2 info2"><p>신길동</p></div>
				<div class="col col-lg-1 info1"><p>담당부서</p></div>
				<div class="col col-lg-2 info2"><p>운영지원팀</p></div>
			</div>

			<div class="sinInfo2">
				<div class="col col-lg-1 info1"><p>이메일</p></div>
				<div class="col col-lg-2 info2"><p>@</p></div>
				<div class="col col-lg-1 info1"><p>휴대폰</p></div>
				<div class="col col-lg-2 info2"><p>010</p></div>
				<div class="col col-lg-1 info1"><p>전화번호</p></div>
				<div class="col col-lg-2 info2"><p>02</p></div>
				<div class="col col-lg-1 info1"><p>팩스번호</p></div>
				<div class="col col-lg-2 info2"><p>070</p></div>
			</div>
		</div>
	</div>
	
	<!-- 성적서정보 ----------------------------------------------------------------- -->
	
	<div style="border: 0px solid red;height: 260px;margin-top: 13px;">
		<div style="height: 15%">
			<div class="col col-lg-12 sonTitle" >
				<p>
					성적서 정보
				</p>
			</div>
		</div>
		<div style="height: 85%;border: 0px solid blue;">
			<div class="soInfo1">
				<div class="col col-lg-2 sInfo1"><p>성적서 용도</p></div>
				<div class="col col-lg-2 sInfo2"><p>성적서 용도 내용</p></div>
				<div class="col col-lg-2 sInfo1"><p>성적서 원본/등본</p></div>
				<div class="col col-lg-2 sInfo2"><p>국문1부/영문0부</p></div>
				<div class="col col-lg-2 sInfo1"><p>시료개수</p></div>
				<div class="col col-lg-2 sInfo2"><p>3</p></div>
			</div>
			<div class="soInfo2">
				<div class="col col-lg-2 sInfo1"><p>성적서 수신 업체</p></div>
				<div class="col col-lg-2 sInfo2"><p>@</p></div>
				<div class="col col-lg-2 sInfo1"><p>성적서 수신인</p></div>
				<div class="col col-lg-6 sInfo2"><p>신길동</p></div>
			</div>
			<div class="soInfo2">
				<div class="col col-lg-2 sInfo1"><p>성적서 수신주소</p></div>
				<div class="col col-lg-10 sInfo2"><p>(12134)충남</p></div>
			</div>
			<div class="soInfo2">
				<div class="col col-lg-2 sInfo1"><p>세금계산서 청구선택</p></div>
				<div class="col col-lg-2 sInfo2"><p>청구함</p></div>
				<div class="col col-lg-2 sInfo1"><p>세금계산서 업체</p></div>
				<div class="col col-lg-2 sInfo2"><p>주식회사</p></div>
				<div class="col col-lg-2 sInfo1"><p>세금계산서 담당자</p></div>
				<div class="col col-lg-2 sInfo2"><p>마길동</p></div>
			</div>
			<div class="soInfo2">
				<div class="col col-lg-2 sInfo1"><p>세금계산서 발급주소</p></div>
				<div class="col col-lg-6 sInfo2" style="margin-left: -2px;"><p>(12313) 충남</p></div>
				<div class="col col-lg-2 sInfo1"><p>세금계산서 E-Mail</p></div>
				<div class="col col-lg-2 sInfo2"><p>@</p></div>
			</div>
			<div class="soInfo2">
				<div class="col col-lg-2 sInfo1"><p>비고</p></div>
				<div class="col col-lg-10 sInfo2"><p><input type="text" style="width: 100%"></p></div>
			</div>
			<div class="soInfo2">
				<div class="col col-lg-2 sInfo1"><p>시험자에게 남기는글</p></div>
				<div class="col col-lg-10 sInfo2"><p>잘부탁드립니다.</p></div>
			</div>
		</div>
	</div>	
	
	<!-- 시험항목정보 ----------------------------------------------------------------- -->
	
	<div style="height: 600px;">
		<div class="col col-lg-12 sonTitle" style="height: 37px;">
			<p>
				시험 항목
			</p>
		</div>

		<div style="height: 35px;"> 
			<div class="col col-lg-5" style="float: left;height: 100%;">
				<div class="col col-lg-3 testMenu">
					<p>시료 / 유종제품</p>
				</div>
				<div class="col col-lg-9" style="height: 100%">
					<select style="height: 33px;width: 100%;">
						<option>시료명1 / 제품명1</option>
						<option>시료명2 / 제품명2</option>
						<option>시료명2 / 제품명3</option>
					</select>
				</div>
			</div>
			
			<div class="col col-lg-7 siBut" style="float: left;">
				<p>
					<a class="btn btn-labeled btn-default"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>항목저장</a>
				</p>
				<p>
					<a class="btn btn-labeled btn-default"> <span class="btn-label"><i class="glyphicon glyphicon-minus"></i></span>항목</a>
				</p>
				<p>
					<a class="btn btn-labeled btn-default"> <span class="btn-label"><i class="glyphicon glyphicon-plus"></i></span>항목</a>
				</p>
				<p>
					<a class="btn btn-labeled btn-info"> <span class="btn-label"><i class="glyphicon glyphicon-duplicate"></i></span>동일항목 속성일괄복사</a>
				</p>
				<p>
					<a class="btn btn-labeled btn-danger"> <span class="btn-label"><i class="glyphicon glyphicon-minus"></i></span>항목 일괄삭제</a>
				</p>
				<p>
					<a class="btn btn-labeled btn-success"> <span class="btn-label"><i class="glyphicon glyphicon-plus"></i></span>항목 일괄추가</a>
				</p>
			</div>
		</div>

		<div>
			<div id="realgrid" style="width: 100%; height: 500px;"></div>
		</div>
	</div>
	
	<!-- 수수료 ----------------------------------------------------------------- -->
	
	<div style="height: 500px;border: 0px solid red;">
		<div style="height: 37px;">
			<div class="col col-lg-9 suTitle" style="float: left;">
				<p>
					수수료
				</p>
			</div>
			<div class="col col-lg-3" style="float: left;">버튼</div>
		</div>
		
		<div style="height: 95px;">
			<div style="height: 33%;">
				<div class="col col-lg-1 suInfo1"><p>항목 수수료</p></div>				
				<div class="col col-lg-1 suInfo1"><p>회원할인률(%)</p></div>
				<div class="col col-lg-2 suInfo1"><p>기타수수료</p></div>
				<div class="col col-lg-1 suInfo1"><p>기본료</p></div>
				<div class="col col-lg-1 suInfo1"><p>부본료</p></div>
				<div class="col col-lg-2 suInfo1"><p>조정금액</p></div>
				<div class="col col-lg-1 suInfo1"><p>총금액(VAT별도)</p></div>
				<div class="col col-lg-1 suInfo1"><p>부가세(VAT)</p></div>
				<div class="col col-lg-2 suInfo1"><p>총금액</p></div>
			</div>
			<div style="height: 33%;">
				<div class="col col-lg-1 suInfo2 suInfo2_1"><p>923,000</p></div>
				<div class="col col-lg-1 suInfo2"><p>0%</p></div>
				<div class="col col-lg-2 suInfo2"><p><input type="text"></p></div>
				<div class="col col-lg-1 suInfo2"><p>10,000</p></div>
				<div class="col col-lg-1 suInfo2"><p>0</p></div>
				<div class="col col-lg-2 suInfo2"><p><input type="text"></p></div>
				<div class="col col-lg-1 suInfo2"><p>933,000</p></div>
				<div class="col col-lg-1 suInfo2"><p>93,300</p></div>
				<div class="col col-lg-2 suInfo2"><p>1,026,300</p></div>
			</div>
			<div style="height: 33%;">
				<div class="col col-lg-1 suInfo1"><p>비고</p></div>
				<div class="col col-lg-11 suInfo2 suInfo2_2" style="margin-left: -7px;"><p><input type="text" style="width: 100%"></p></div>
			</div>
		</div>
		
		<div>
			<div></div>
			<div></div>
			<div></div>
		</div>
		<div>
			<div>
				<div></div>
				<div></div>
			</div>
			<div>
				<div></div>
				<div></div>
			</div>
		</div>
		<div>
	
		</div>
		<div>
		
		</div>
	</div>
	
	
</div>	