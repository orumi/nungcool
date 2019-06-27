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
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<script src="<c:url value='/js/tems/common/stringutil.js'/>"></script>
<script src="<c:url value='/js/tems/common/priceutil.js'/>"></script>
<script>
		$(document).ready( function(){
		});
</script>
<script>
	var data = "${data}"
	var reqid = "${reqid}"
	var datas = data.split(",");
	var datacnt = datas.length;
	if(data == ""){
		datacnt = datacnt - 1;
	}
	
	var gridView;
	var dataProvider;
	//var reqid = "${reqDetail.reqid}";
	
	$(document).ready( function(){
		$("#confirmcnt").text(datacnt);
		
		RealGridJS.setTrace(false);
	    RealGridJS.setRootContext("<c:url value='/script'/>");
	    
	    dataProvider = new RealGridJS.LocalTreeDataProvider();
	    gridView = new RealGridJS.TreeView("realgrid"); 
	    gridView.setDataSource(dataProvider);   
	    
	    
	    var fields = [
			{fieldName: "treefield"}
			,{fieldName: "itemid"}
			,{fieldName: "itempid"}
			,{fieldName: "methodid"}
			,{fieldName: "itemname"}
			,{fieldName: "unitid"}
			,{fieldName: "orderby"}
			,{fieldName: "methodnm"}
			,{fieldName: "itemprice", dataType: "number"}
			,{fieldName: "price", dataType: "number"}
			,{fieldName: "pricecnt"}
			,{fieldName: "addprice", dataType: "number"}
			,{fieldName: "addpricecond"}
			,{fieldName: "remark"}
			,{fieldName: "condid"}
			,{fieldName: "condetc"}
			,{fieldName: "tempercond"}
			,{fieldName: "tempunit"}
			,{fieldName: "timecond"}
			,{fieldName: "timecondunit"}
			,{fieldName: "etc"}
			,{fieldName: "etcunit"}
			,{fieldName: "itemterm"}
			,{fieldName: "adminnm"}
			,{fieldName: "resultid"}
			,{fieldName: "reqid"}
			,{fieldName: "smpid"}
			,{fieldName: "resulttype"}
			,{fieldName: "adminid"}
			,{fieldName: "basiccond"}
			,{fieldName: "basicunit"}
			,{fieldName: "basicunitnm"}
	    ];
	    
	    //DataProvider의 setFields함수로 필드를 입력합니다.
	    dataProvider.setFields(fields);

	    //필드와 연결된 컬럼 배열 객체를 생성합니다.
	    var columns = [
    		{
    			name: "itemname",
    			fieldName: "itemname",
    			header : {
    				text: "검사항목명"
    			},
    			styles: {
    		        textAlignment: "near"
    		    },
    		    readOnly : "true",
    			width: 250
    		},
    		{
    			name: "unitid",
    			fieldName: "unitid",
    			header : {
    				text: "단위"
    			},
    			lookupDisplay: true,
                lookupSourceId: "lookID3",
                lookupKeyFields: ["itemid", "unitid"],
                editor: {
                    "type": "dropDown",
                    "dropDownCount": 5
                },
                editButtonVisibility: "always",
    			width: 60
    		},
    		{
    			name: "orderby",
    			fieldName: "orderby",
    			header : {
    				text: "정렬\n순서"
    			},
    			width: 60
    		},
    		{
    			name: "methodid",
    			fieldName: "methodid",
    			header : {
    				text: "시험방법"
    			},
    			lookupDisplay: true,
                lookupSourceId: "lookID1",
                lookupKeyFields: ["itemid", "methodid"],
                editor: {
                    "type": "dropDown",
                    "dropDownCount": 5
                },
                editButtonVisibility: "always",
    			width: 150
    		},
    		{
    			name: "pricecnt",
    			fieldName: "pricecnt",
    			header : {
    				text: "수수료조건\n(무료처리 갯수)"
    			},
    			readOnly : "true",
    			width: 0
    		},
    		{
    			name: "itemprice",
    			fieldName: "itemprice",
    			header : {
    				text: "수수료\n(기본+추가)"
    			},
    			footer: {
   	            	styles: {
   	                textAlignment: "far",
   	             	numberFormat: "0,000",
   	                font: "굴림,12"
   	            	},
   	            	text: "합계",
   	         		groupText: "합계",
   	         		expression: "sum"
   		        },
    			styles : {
   		            "textAlignment": "far",
   		         	"numberFormat": "000,000"
   		        },
    			width: 100
    		},
			{
    			name: "remark",
    			fieldName: "remark",
    			header : {
    				text: "비고"
    			},
    			width: 100
    		},
            {
                type: "group",
                name: "시험조건",
                width: 160,

                columns: [{
                    	name: "condid",
                    	fieldName: "condid",
                   	 	header: {
                        	text: "선택"
              	    	},
              	    	lookupDisplay: true,
                        lookupSourceId: "lookID2",
                        lookupKeyFields: ["itemid", "condid"],
                        editor: {
                            "type": "dropDown",
                            "dropDownCount": 3
                        },
                        editButtonVisibility: "always",
                   	 	width: 80
                	},
                	{
                        name: "condetc",
                        fieldName: "condetc",
                        header: {
                            text: "기타"
                        },
                        width: 80
                    }
      			]
			},
    		{
    			name: "itemterm",
    			fieldName: "itemterm",
    			header : {
    				text: "시험기간"
    			},
    			width: 100
    		},
    		{
    			name: "adminnm",
    			fieldName: "adminnm",
    			header : {
    				text: "담당자"
    			},
    			readOnly : "true",
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
	    
	    
        gridView.setLookups([
	        {"id": "lookID1", "levels": 2} 
	        ,{"id": "lookID2","levels": 2}
	        ,{"id": "lookID3","levels": 2}
	    ]);
	    
	    
	    /* 그리드 row추가 옵션사용여부 */
	    gridView.setOptions({
	    	panel : { visible : false },
	    	footer : { visible : true },
	    	edit : {readOnly : true},
	    	display: { fitStyle: "evenFill" }
	    });
	    
	    fnGetReqResultList();
	});	    
	
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
	
	
	function fnGoList(){
		window.location.href="<c:url value='/tems/requestConfirm.do'/>";
		
	}
	
	function fnGetReqResultList(){
		var cmbsmpid = $("#cmbsmpid").val();
		$.ajax({
			type : "post",
		    dataType : "json",
		    data : {"reqid":reqid,"smpid":cmbsmpid},
            url: "<c:url value='/exam/req/getReqResultList.json'/>",
            success: function (data) {
            	dataProvider.setRows(data.reqItemDetailList,"treefield", true, "", "");
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete: function (data) {
            	gridView.expandAll();
            	//fnRePrice(gridView, dataProvider);
                //loadTestMethod();
                //loadTestCondition();
                //loadTestUnit();
                fnGetLookup();
            },
            cache: false
        });
	}
	
	
	//lookup 처리
	function fnGetLookup(){
		var cmbsmpid = $("#cmbsmpid").val();
        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/common/getComboListAll.json'/>",
            data: {"reqid": reqid,"smpid":cmbsmpid},
            success: function (data) {
                lookupDataChange(data.MethodList,data.CondList,data.UnitList);
            },
            error : function(request, status, error) {
            	alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
	}
	
    
    function lookupDataChange(data1,data2,data3) {
        var lookups = [];
        for (var i = 0; i < data1.length; i++) {
            var json = data1[i];
            var lookup = [json.itemid, json.methodid, json.name];
            lookups.push(lookup);
        }
        gridView.fillLookupData("lookID1", {
            rows: lookups
        })
        
        lookups = [];
        for (var i = 0; i < data2.length; i++) {
            var json = data2[i];
            var lookup = [json.itemid, json.condid, json.testcond];
            lookups.push(lookup);
        }
        gridView.fillLookupData("lookID2", {
            rows: lookups
        })
        
        lookups = [];
        for (var i = 0; i < data3.length; i++) {
            var json = data3[i];
            var lookup = [json.itemid, json.unitid, json.unitid];
            lookups.push(lookup);
        }
        gridView.fillLookupData("lookID3", {
            rows: lookups
        })
    }
    
    function fnNext(){
    	
		if(confirm("승인처리 보류후 다음건을 불러 오시겠습니까?")){
		
		document.frm.data.value = data;
		document.frm.confirm.value = "N";
		document.frm.reqid.value = reqid;
		document.frm.method="post"
		document.frm.action = "<c:url value='/exam/requestConfirm/RcListDetail.do'/>";
		document.frm.submit();
		}
    }
    
    function fnNextConfirm(){
		
		if(confirm("승인처리 하시겠습니까?")){
		document.frm.data.value = data;
		document.frm.confirm.value = "Y";
		document.frm.reqid.value = reqid;
		document.frm.method="post"
		document.frm.action = "<c:url value='/exam/requestConfirm/RcListDetail.do'/>";
		document.frm.submit();
		}
    }
    
    function fnReject(){
    	$("#rejectModal").modal('show');
    }
    
    function fnSaveReject(){
    	document.frm.data.value = data;
		document.frm.confirm.value = "R";
		document.frm.reqid.value = reqid;
		document.frm.rejdesc.value = $("#trejdesc").val();
		document.frm.method="post"
		document.frm.action = "<c:url value='/exam/requestConfirm/RcListDetail.do'/>";
		document.frm.submit();
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
					<button class="btn btn-default btn-success" onclick="javascript:fnNextConfirm();">
					<i class="glyphicon glyphicon-ok"></i>의뢰승인 다음
					</button>
					<button class="btn btn-default btn-success" onclick="javascript:fnNext();">
					<i class="glyphicon glyphicon-ok"></i>승인보류 다음
					</button>
					남은 결제 건수 : <span id="confirmcnt"></span>건
					<button class="btn btn-default btn-danger" onclick="javascript:fnReject();">
					<i class="glyphicon glyphicon-ok"></i>반려
					</button>
					<button class="btn btn-default" onclick="javascript:fnGoList();">
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
				<span class="txt-sub-content">${reqDetail.comname }</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">대표자</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.ceoname}</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">담당자</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.mngname}</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">담당부서</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.mngdept}</span>
			</div>
		</div>
		</fieldset>
		
		<fieldset>
		<div class="col-md-3 form-group ">
			<label class="col-md-4 form-label">이메일</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.mngemail}</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">휴대폰</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.mnghp}</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">전화번호</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.mngphone}</span>
			</div>
		</div>
		<div class="col-md-3 form-group">
			<label class="col-md-4 form-label">팩스번호</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.fax}</span>
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
				<span class="txt-sub-content">${reqDetail.usage}</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">성적서 원본/등본</label>
			<div class="col-md-8">
				<span class="txt-sub-content">
				<c:choose>
				<c:when test="${reqDetail.langtype eq 'K'}">
				국문
				</c:when>
				<c:otherwise>
				영문
				</c:otherwise>
				</c:choose>
				${reqDetail.orgcnt}/${reqDetail.copycnt}
				
				</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">시료개수</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.smpcnt}</span>
			</div>
		</div>
		</fieldset>
		
		<fieldset>
		<div class="col-md-4 form-group ">
			<label class="col-md-4 form-label">성적서수신업체</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.rcvcompany}</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">성적서수신인</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.rcvdept}</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			
		</div>
		</fieldset>		

		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-2 form-label col-11p">성적서수신주소</label>
			<div class="col-md-10 col-89p">
				<span class="txt-sub-content">(${reqDetail.rcvzipcode}) ${reqDetail.rcvaddr1}&nbsp;${reqDetail.rcvaddr2} </span>
			</div>
		</div>

		</fieldset>		
	
	
		<fieldset>
		<div class="col-md-4 form-group ">
			<label class="col-md-4 form-label">세금계산서 청구</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.pricechargetype}</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">세금계산서 업체</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.taxcompany}</span>
			</div>
		</div>
		<div class="col-md-4 form-group">
			<label class="col-md-4 form-label">세금계산서 담당자</label>
			<div class="col-md-8">
				<span class="txt-sub-content">${reqDetail.taxmngname}</span>
			</div>
		</div>
		</fieldset>		


		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-2 form-label col-11p">세금계산서 주소</label>
			<div class="col-md-10 col-89p">
				<span class="txt-sub-content">(${reqDetail.taxzipcode}) ${reqDetail.taxaddr1}&nbsp;${reqDetail.taxaddr2}</span>
			</div>
		</div>
		</fieldset>		



		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-2 form-label col-11p">비고</label>
			<div class="col-md-10 col-89p">
				<span class="txt-sub-content">
				${reqDetail.remark}
				</span>
			</div>
		</div>
		</fieldset>	
		
		<fieldset>
		<div class="col-md-12 form-group ">
			<label class="col-md-2 form-label col-11p">시험자 부탁의견</label>
			<div class="col-md-10 col-89p">
				<span class="txt-sub-content">${reqDetail.itemdesc}</span>
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
					<select class="form-control" style="height:33px;width: 100%;" id="cmbsmpid" name="cmbsmpid" onchange="javascript:fnGetReqResultList();">
					<c:forEach var="reqSmpList" items="${reqSmpList}">
						<option value="${reqSmpList.smpid}">${reqSmpList.smpname} / ${reqSmpList.mname}<c:if test="${reqSmpList.adminnm ne null}">(${reqSmpList.officenm}/${reqSmpList.adminnm})</c:if></option>
					</c:forEach>						
					</select>
					</div>
				</div>
			</div>
			
			
			<div class="col-sm-7 text-right" >
			<c:if test="${reqDetail.reqstate eq '0' and reqDetail.signappr eq null}">
				<button class="btn btn-primary" onclick="javascript:fnSaveResult();">
					<i class="fa fa-save"></i> 저장
				</button>
				<button class="btn btn-default" onclick="javascript:fnResultAdd();">
					<i class="fa fa-plus"></i> 항목추가
				</button>
				<button class="btn btn-default" onclick="javascript:fnResultDelete();">
					<i class="fa fa-minus"></i> 항목삭제
				</button>
				<button class="btn btn-default" onclick="javascript:fnResultUpdateAll();">
					<i class="fa fa-copy "></i> 동일항목 속성복사
				</button>
				<button class="btn btn-success" onclick="javascript:fnResultDeleteAll();">
					<i class="fa fa-minus"></i> 일괄삭제
				</button>
				<button class="btn btn-success" onclick="javascript:fnResultAddAll();">
					<i class="fa fa-plus"></i> 일괄추가
				</button>
			</c:if>				
			</div>
			
		</div>
			
		<div class="div-realgrid">	
			<div id="realgrid" style="width: 100%; height: 450px;"></div>
		</div>			


			
			
	<!-- end of realgrid Content -->		
	</div>	
	
	
		<br>


	
	
	
	
	
	
	
	
<!-- 시료도착 --------------------------------------------------------------------------------------- -->
	<!-- start of content -->
	<c:if test="${reqDetail.reqstate eq '0' and reqDetail.signappr eq null}">
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
						<textarea rows="6" class="textAreaBox" style="width:98%;margin:0px;height:80px;">접수 완료 ..</textarea>
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
						<textarea rows="6" class="textAreaBox" style="width:98%;margin:0px;height:80px;">접수완료 되었습니다. </textarea>
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


	
</c:if>

<!-- end of /section:basics/content.breadcrumbs -->	
</div>

<!-- 항목추가 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="modalPopUp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel">항목추가</h4>
            </div>
            <div class="modal-body requestBody">    <!-- Modal Body-->
                <div class="page-content">          <!-- start of content -->
                    <div role="content">
                        <!--  start of  form-horizontal tems_search  -->
                        <!--  start of widget-body -->
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <!-- back -->
                                <div class="widget-body">
                                    <fieldset>
                                        <div class="col-md-12 form-group">
                                            <label class="col-md-2 form-label"><b>항목명 조회</b></label>

                                            <div class="col-md-10">
                                            
                                                <div class="col-sm-3 form-button">
                                                    <input id="itemnm" type="text" class="form-control inputBox">
                                                </div>
                                                <div class="col-sm-8">
                                                    <font color="blue">
                                                    (조회시 최상위 항목의 이름으로 검색하여 주시기 바랍니다.)
                                                    </font>
                                                </div>
                                                <div class="col-sm-1 form-button">
                                                    <button class="btn btn-default btn-primary" type="button"
                                                            id="search3" onclick="javascript:fnGetItemList()">
                                                        <i class="fa fa-search"></i> 검색
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                    <!--  end of  form-horizontal tems_search  -->
                                    <!--  end of jarviswidget -->
                                </div>
                            </div>
                            <!-- end of widget-body -->
                        </div>
                        <!--  end of content -->
                    </div>
                    <!-- -----------------------------------------------------------------------------------  -->

                    <div style="text-align: right">
                        <button id="modalAdd" class="btn btn-primary" onclick="javascript:fnAddItem()">추가</button>
                    </div>

                    <div class="div-realgrid">
                        <div id="realgrid2" style="width: 100%; height: 500px;"></div>
                    </div>


                    <!-- Footer -->
                    <footer>
                    </footer>
                    <!-- Footer End -->
                    <!-- end of realgrid Content -->
                </div>
                <!-- -----------------------------------------------------------------------------------  -->
            </div>
            <!-- Modal Body End-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>

    </div>
</div>

<!-- 담당자추가 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="UserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel">담당자변경</h4>
            </div>
            <div class="modal-body requestBody">    <!-- Modal Body-->
                <div class="page-content">          <!-- start of content -->
                    <div role="content">
                        <!--  start of  form-horizontal tems_search  -->
                        <!--  start of widget-body -->
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <!-- back -->
                                <div class="widget-body">
                                    <fieldset>
                                        <div class="col-md-12 form-group">
                                            <div class="col-md-6">
                    							<div class="div-realgrid">
                    								<h4 class="modal-title" id="myModalLabel">부서</h4>
							                        <div id="realgrid3" style="width: 100%; height: 500px;"></div>
							                    </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="div-realgrid">
                                                	<h4 class="modal-title" id="myModalLabel">사용자선택</h4>
							                        <div id="realgrid4" style="width: 100%; height: 235px;"></div>
							                    </div>
							                    <div class="div-realgrid">
							                    	<h4 class="modal-title" id="myModalLabel">선택된사용자</h4>
							                        <div id="realgrid5" style="width: 100%; height: 240px;"></div>
							                    </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                    <!--  end of  form-horizontal tems_search  -->
                                    <!--  end of jarviswidget -->
                                </div>
                            </div>
                            <!-- end of widget-body -->
                        </div>
                        <!--  end of content -->
                    </div>
                    <!-- -----------------------------------------------------------------------------------  -->
                    <!-- Footer -->
                    <footer>
                    </footer>
                    <!-- Footer End -->
                    <!-- end of realgrid Content -->
                </div>
                <!-- -----------------------------------------------------------------------------------  -->
            </div>
            <!-- Modal Body End-->
            <div class="modal-footer">
            	<button type="button" class="btn btn-primary" onclick="fnUserAdd()">적용</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<!-- 반려 모달창------------------------------------------------------------------------ -->
<div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog apprDialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
        <h4 class="modal-title" id="myModalLabel">반려사유 등록</h4>
      </div>
      <div class="modal-body apprBody">
      	<textarea class="form-control" placeholder="" rows="4" id="trejdesc" name="trejdesc" placeholder="반려사유를 적어주십시오."></textarea>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" onclick="javascript:fnSaveReject()">등록</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<form name="frm">
<input type="hidden" name="data" id="data">
<input type="hidden" name="reqid" id="reqid">
<input type="hidden" name="confirm" id="confirm">
<input type="hidden" name="rejdesc" id="rejdesc">
<input type="hidden" name="apprid" id="apprid" value="<%=nLoginVO.getAdminid()%>">
</form>