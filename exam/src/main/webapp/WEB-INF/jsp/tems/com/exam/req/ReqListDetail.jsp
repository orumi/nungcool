<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
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
	    
	    //setOptions(gridView);
	    
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
	    
	    /* 헤더의 높이를 지정*/
	    gridView.setHeader({
	    	height: 45
	    }); 
	    
	    
	    gridView.setStyles(smart_style);
	    
	    
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
	
	
	function showDiv(tag){
		if(tag=='email'){
			if($("#div_email").css("display") == "none"){
				$("#div_email").show();
			} else {
				$("#div_email").hide();	
			}
			//$("#div_email").css("display");
		} else if(tag=='sms'){
			if($("#div_sms").css("display") == "none"){
				$("#div_sms").show();
			} else {
				$("#div_sms").hide();	
			}
			//$("#div_email").css("display");
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
			<!-- 
				<button class="btn btn-primary" onclick="javascript:void(0);">
					<i class="fa fa-save"></i> 저장
				</button>
			 -->
				<button class="btn btn-danger" onclick="javascript:;">
					<i class="fa fa-trash-o"></i> 삭제
				</button>
				<button class="btn btn-primary" onclick="javascript:alert();">
					<i class="fa fa-krw"></i> 세금계산서
				</button>
				<button class="btn btn-default" onclick="javascript:alert();">
					<i class="fa fa-th-list"></i> 목록
				</button>
			</div>
		
	<!-- end of div dt-toolbar content -->	
		</div>
	</div>	


    <!-- 신청자 정보 --------------------------------------------------------------------------------------- -->
	<!-- start of content 신청자 정보 -->
	<div role="content" class="clear-both sub-content">
	
	<!--  start of  form-horizontal tems_search  -->
	<!--  start of widget-body -->
	<div class="form-horizontal form-terms ui-sortable"> <div class="jarviswidget jarviswidget-sortable" role="widget">	
		<header role="heading">
		
		<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
		<h2>신청자</h2>
		</header>

	<!-- body -->    	
	<div class="widget-body">
	
	
		<fieldset>
		<div class="col-md-3 form-group ">
			<label class="col-md-4 form-label">업체명</label>
			<div class="col-md-8">
				<span class="txt-sub-content">주식회사</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">대표자</label>
			<div class="col-md-8">
				<span class="txt-sub-content">홍길동</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">담당자</label>
			<div class="col-md-8">
				<span class="txt-sub-content">신길동</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">담당부서</label>
			<div class="col-md-8">
				<span class="txt-sub-content">운영지원팀</span>
			</div>
		</div>
		</fieldset>
		
		<fieldset>
		<div class="col-md-3 form-group ">
			<label class="col-md-4 form-label">이메일</label>
			<div class="col-md-8">
				<span class="txt-sub-content">absc@bde.com</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">휴대폰</label>
			<div class="col-md-8">
				<span class="txt-sub-content">010-1234-5678</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">전화번호</label>
			<div class="col-md-8">
				<span class="txt-sub-content">02-1234-5678</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">팩스번호</label>
			<div class="col-md-8">
				<span class="txt-sub-content">02-1234-5678</span>
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
    
    
    
   <!-- 성적서 정보--------------------------------------------------------------------------------------- --> 
   <!-- start of content 성적서 정보 -->
	<div role="content" class="clear-both sub-content">
	
	<!--  start of  form-horizontal tems_search  -->
	<!--  start of widget-body -->
	<div class="form-horizontal form-terms ui-sortable"> <div class="jarviswidget jarviswidget-sortable" role="widget">	
		<header role="heading">
		
		<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
		<h2>성적서</h2>
		</header>

	<!-- body -->    	
	<div class="widget-body">
	
	
		<fieldset>
		<div class="col-md-4 form-group ">
			<label class="col-md-4 form-label">성적서용도</label>
			<div class="col-md-8">
				<span class="txt-sub-content">성적서용도</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">성적서 원본/등본</label>
			<div class="col-md-8">
				<span class="txt-sub-content">국문1부/영문0부</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">시료개수</label>
			<div class="col-md-8">
				<span class="txt-sub-content">3</span>
			</div>
		</div>
		</fieldset>
		
		<fieldset>
		<div class="col-md-4 form-group ">
			<label class="col-md-4 form-label">성적서수신업체</label>
			<div class="col-md-8">
				<span class="txt-sub-content">수신업체명</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">성적서수신인</label>
			<div class="col-md-8">
				<span class="txt-sub-content">신길동</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			
		</div>
		</fieldset>		

		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-2 form-label col-11p">성적서수신주소</label>
			<div class="col-md-10 col-89p">
				<span class="txt-sub-content">(12345) 충남 서산시 ..... 수신 주소 123-123</span>
			</div>
		</div>

		</fieldset>		
	
	
		<fieldset>
		<div class="col-md-4 form-group ">
			<label class="col-md-4 form-label">세금계산서 청구</label>
			<div class="col-md-8">
				<span class="txt-sub-content">청구</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">세금계산서 업체</label>
			<div class="col-md-8">
				<span class="txt-sub-content">주식회사</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">세금계산서 담당자</label>
			<div class="col-md-8">
				<span class="txt-sub-content">신길동</span>
			</div>
		</div>
		</fieldset>		


		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-2 form-label col-11p">세금계산서 주소</label>
			<div class="col-md-10 col-89p">
				<span class="txt-sub-content">(12345) 충남 서산시 ..... 수신 주소 123-123</span>
			</div>
		</div>
		</fieldset>		



		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-2 form-label col-11p">비고</label>
			<div class="col-md-10 col-89p">
				<div class="input-group" style="margin-top:0px;">
				<input type="text" class="form-control inputBox"/>
				
				<div class="input-group-btn">
					<button class="btn btn-primary" onclick="javascript:void(0);" style="padding-top:4px; padding-bottom:4px; margin-top:1px;">
						<i class="fa fa-save"></i> 비고 저장
					</button>
				</div>
				</div>
			</div>
		</div>
		</fieldset>	
		
		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-2 form-label col-11p">시험자 부탁의견</label>
			<div class="col-md-10 col-89p">
				<span class="txt-sub-content">시험자에게 부탁의견</span>
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
					<select class="form-control" style="height:33px;width: 100%;">
						<option>시료명1 / 제품명1</option>
						<option>시료명2 / 제품명2</option>
						<option>시료명2 / 제품명3</option>
					</select>
					</div>
				</div>
			</div>
			
			
			<div class="col-sm-7 text-right" >
				<button class="btn btn-primary" onclick="javascript:void(0);">
					<i class="fa fa-save"></i> 저장
				</button>
				<button class="btn btn-default" onclick="javascript:void(0);">
					<i class="fa fa-plus"></i> 항목추가
				</button>
				<button class="btn btn-default" onclick="javascript:alert();">
					<i class="fa fa-minus"></i> 항목삭제
				</button>
				<button class="btn btn-default" onclick="javascript:alert();">
					<i class="fa fa-copy "></i> 동일항목 속성복사
				</button>
				<button class="btn btn-success" onclick="javascript:alert();">
					<i class="fa fa-minus"></i> 일괄삭제
				</button>
				<button class="btn btn-success" onclick="javascript:alert();">
					<i class="fa fa-plus"></i> 일괄추가
				</button>
			</div>
			
		</div>
			
		<div class="div-realgrid">	
			<div id="realgrid" style="width: 100%; height: 450px;"></div>
		</div>			


			
			
	<!-- end of realgrid Content -->		
	</div>	
	
	
		<br>


    <!-- 수수료 --------------------------------------------------------------------------------------- -->
	<!-- start of content -->
	<div role="content" class="clear-both sub-content">
	
	
		<div class="dt-toolbar">
			<div class="col-sm-5">
				<div class="col col-md-12" style="height: 100%;padding-left:2px;">
					<div style="flaot:left; padding-top:5px;font-size:13;">
					<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
					수수료
					</div>
				</div>
			</div>
			
			
			<div class="col-sm-7 text-right" >
				<button class="btn btn-primary" onclick="javascript:void(0);">
					<i class="fa fa-save"></i> 수수료 저장
				</button>
				<button class="btn btn-default" onclick="javascript:void(0);">
					<i class="fa fa-search"></i> 견적서 보기
				</button>
			</div>
			
		</div>	
	

	
	<!--  start of  form-horizontal tems_search  -->
	<!--  start of widget-body -->
	<div class="form-terms ui-sortable"> <div class="jarviswidget jarviswidget-sortable" role="widget">	
	<!-- body -->    	
	<div class="form-vertical widget-body">
	
	
		<fieldset>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">항목수수료</label>
			<div class="col-md-12">
				<span class="txt-sub-content text-right">923,000</span>
			</div>
		</div>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">회원할인률</label>
			<div class="col-md-12">
				<span class="txt-sub-content text-right">0%</span>
			</div>
		</div>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">기타수수료</label>
			<div class="col-md-12">
				<input type="text" class="form-control inputBox" style="text-align: right;"/>
			</div>
		</div>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">기본료</label>
			<div class="col-md-12">
				<span class="txt-sub-content text-right">10,000</span>
			</div>
		</div>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">부본료</label>
			<div class="col-md-12">
				<span class="txt-sub-content">0</span>
			</div>
		</div>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">조정금액</label>
			<div class="col-md-12">
				<input type="text" class="form-control inputBox" style="text-align: right;"/>
			</div>
		</div>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">VAT별도</label>
			<div class="col-md-12">
				<span class="txt-sub-content text-right">933,000</span>
			</div>
		</div>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">부가세</label>
			<div class="col-md-12">
				<span class="txt-sub-content text-right">93,300</span>
			</div>
		</div>
		<div class="col-11p form-group">
			<label class="col-md-12 form-label">총금액</label>
			<div class="col-md-12">
				<span class="txt-sub-content text-right">1,026,300</span>
			</div>
		</div>
		</fieldset>
		
		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-11p form-label ">수수료비고</label>
			<div class="col-89p dash-left">
				<input type="text" class="form-control inputBox" />
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
	<!-- 수수료 끝. ----------------------------------------------------------------- -->
	
	
	
	
	
	
	
	
<!-- 시료도착 --------------------------------------------------------------------------------------- -->
	<!-- start of content -->
	<div role="content" class="clear-both sub-content">
	
		<div class="dt-toolbar">
			<div class="col-sm-5">
				<div class="col col-md-12" style="height: 100%;padding-left:2px;">
					<div style="flaot:left; padding-top:5px;font-size:13;">
					<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
					시료도착
					</div>
				</div>
			</div>
			
			<div class="col-sm-7 text-right" >
			
				<button class="btn btn-primary" onclick="javascript:void(0);" style="float:right">
					<i class="fa fa-save"></i> 도착정보 저장
				</button>

				<div class="dd3-content" style="float:right">
				<div class="pull-right">
					<div class="checkbox no-margin">
						<label>
						  <input type="checkbox" class="checkbox style-0" checked="checked">
						  <span class="font-xs"> 시료도착여부</span>
						</label>
					</div>
				</div>
			    </div>

			</div>
		<!-- end of dt-toolbar -->	
		</div>	
	

	
	<!--  start of  form-horizontal tems_search  -->
	<!--  start of widget-body -->
	<div class="form-terms ui-sortable"> <div class="jarviswidget jarviswidget-sortable" role="widget">	
	<!-- body -->    	
	<div class="form-vertical widget-body">
		
		<fieldset>
		<div class="col-md-12 form-group ">
			<div class="" style="float:left;">
				<div class="row-merge">
					<label class="col col-md-12 form-label ">시료도착내역</label>
				</div>
			</div>
			<div class="dash-left" style="padding-left:153px;">
				<textarea rows="6" class="textAreaBox" style="width:98%;margin:0px;height:50px;"></textarea>
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
	<!-- 시료도착 끝. ----------------------------------------------------------------- -->
	
	
	
	
	<!-- 이메일 발송 및 SMS 발송  --------------------------------------------------------------------------------------- -->
	<!-- start of content -->
	<!--  E-Mail(견적서 포함) -->
<div class="col col-md-12 no-padding" style="margin-bottom:13px !important;">	
	<div class="col col-md-6 no-padding">
			<div role="content" class="clear-both sub-content">
			
				<div class="dt-toolbar" style="border-bottom:1px solid #CCC !important; padding-bottom: 6px;">
					<div class="col-sm-5">
						<div class="col col-md-12" style="height: 100%;padding-left:2px;">
							<div style="flaot:left; padding-top:5px;font-size:13;">
							<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
							E-Mail (견적서 포함)
							</div>
						</div>
					</div>
					
					<div class="col-sm-7 text-right" >
					
						<button class="btn bg-color-blueLight txt-color-white btn-xs" onclick="javascript:showDiv('email');" style="float:right">
							<i class="fa fa-rss"></i> 메시지보기
						</button>
		
						<div class="dd2-content" style="float:right">
						<div class="pull-right">
							<div class="checkbox no-margin">
								<label>
								  <input type="checkbox" class="checkbox style-0" checked="checked">
								  <span class="font-xs"> E-Mail발송여부</span>
								</label>
							</div>
						</div>
					    </div>
		
					</div>
				<!-- end of dt-toolbar -->	
				</div>	
			
		
			
			<!--  start of  form-horizontal tems_search  -->
			<!--  start of widget-body -->
			<div class="form-terms ui-sortable" style="display:none;" id="div_email"> <div class="jarviswidget jarviswidget-sortable" role="widget">	
			<!-- body -->    	
			<div class="form-vertical widget-body" >
				
				<fieldset>
				<div class="col-md-12 form-group ">
					<div class="" style="padding-left:13px;">
						<textarea rows="6" class="textAreaBox" style="width:98%;margin:0px;height:80px;">접수번호 : 100-1222 접수 완료 ..</textarea>
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
			<!-- 끝. ----------------------------------------------------------------- -->
			
	</div>
	<div class="col col-md-6 no-padding" style="padding-left:13px !important;">
			<div role="content" class="clear-both sub-content">
			
				<div class="dt-toolbar" style="border-bottom:1px solid #CCC !important; padding-bottom: 6px;">
					<div class="col-sm-5">
						<div class="col col-md-12" style="height: 100%;padding-left:2px;">
							<div style="flaot:left; padding-top:5px;font-size:13;">
							<span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
							SMS 발송 (접수완료)
							</div>
						</div>
					</div>
					
					<div class="col-sm-7 text-right" >
					
						<button class="btn bg-color-blueLight txt-color-white btn-xs" onclick="javascript:showDiv('sms');" style="float:right">
							<i class="fa fa-rss"></i> 메시지보기
						</button>
		
						<div class="dd2-content" style="float:right">
						<div class="pull-right">
							<div class="checkbox no-margin">
								<label>
								  <input type="checkbox" class="checkbox style-0" checked="checked">
								  <span class="font-xs"> SMS 발송여부</span>
								</label>
							</div>
						</div>
					    </div>
		
					</div>
				<!-- end of dt-toolbar -->	
				</div>	
			
		
			
			<!--  start of  form-horizontal tems_search  -->
			<!--  start of widget-body -->
			<div class="form-terms ui-sortable" id="div_sms" style="display:none;"> <div class="jarviswidget jarviswidget-sortable" role="widget">	
			<!-- body -->    	
			<div class="form-vertical widget-body" >
				
				<fieldset>
				<div class="col-md-12 form-group ">
					<div class="" style="padding-left:13px;">
						<textarea rows="6" class="textAreaBox" style="width:98%;margin:0px;height:80px;">접수번호 : 111 접수완료 되었습니다. </textarea>
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
	</div>
	
</div>	
	
	
	<!--  bottom button area -->
	<!-- 접수완료 접수대시상태에서 만 표시 됨. -->
	<div role="content" style="clear:both;">
		<div class="dt-toolbar border-bottom-solid">
			<div class="col-sm-6">
				<div class="txt-guide">
				</div>  
			</div>
			
			
			<div class="col-sm-6 text-right" >
				<button class="btn btn-default" onclick="javascript:alert();" style="float:right; margin-left:13px;">
					<i class="fa fa-th-list"></i> 목록
				</button>
								
				
				<div class="input-group col-sm-8" style="float:right;">
				<select class="form-control" style="height: 32px;width: 240px;float:right;">
					<option>승인지사</option>
					<option>승인지사</option>
					<option>승인지사</option>
				</select>
				
				<div class="input-group-btn">
					<button class="btn btn-primary" onclick="javascript:void(0);">
						<i class="fa fa-save"></i> 접수완료
					</button>
				</div>
				
				</div>
				
				
				
				

			</div>
		
	<!-- end of div dt-toolbar content -->	
		</div>
	</div>	
	
	
	
	<!--  bottom button area -->
	<!-- 분석승인요청 접수완료 상태에서 만 표시 됨. -->
	<div role="content" style="clear:both;">
		<div class="dt-toolbar border-bottom-solid">
			<div class="col-sm-6">
				<div class="txt-guide">
				</div>  
			</div>
			
			
			<div class="col-sm-6 text-right" >
				<button class="btn btn-default" onclick="javascript:alert();" style="float:right; margin-left:13px;">
					<i class="fa fa-th-list"></i> 목록
				</button>
								
				
				<div class="">
					<button class="btn btn-primary" onclick="javascript:void(0);">
						<i class="fa fa-pencil"></i> 의뢰승인요청
					</button>
				</div>
				

			</div>
		
	<!-- end of div dt-toolbar content -->	
		</div>
	</div>		
		


<!-- end of /section:basics/content.breadcrumbs -->	
</div>	