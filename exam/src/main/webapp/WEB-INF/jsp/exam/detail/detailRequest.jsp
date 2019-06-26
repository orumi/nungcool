<%@ page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%
	String detailReqid = request.getParameter("detailReqid");
%>
<script type="text/javascript" src="<c:url value='/jquery/jquery.form.js'/>"></script>

<style>
  
	/* add Sample model dailog */
    
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
    
    .my-placeholder { color: #DEDEDE; }
</style>
  
<script type="text/javascript" src="<c:url value='/js/exam/testRequest.js' />"></script>

<!-- for ajax json   -->
<script>	
		
		/* 기초정보 통합  
		 * formTag : 업무 구분 
		 * pm : 정보
		 */
		 
	$(function() {   
		
		<% if(detailReqid!=null && !"".equals(detailReqid)){ %>
		/* 기존 신청 가져오기 */
		setSelectInfo("requestInfo",{"formTag":"requestInfo",  "reqid":"<%=detailReqid%>"});
		<% } else { %>
		/*신규 등록   */
		setSelectInfo("getMemberInfo", {"formTag":"getMemberInfo"} );
		<% } %>
		
		
	});	
			
 
 
 	function setSelectInfo(formTag, pm){
		$.ajax({
			type     : "post",
		    dataType : "json",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/req/selectInfo.json'/>",
	        success: function (data) {
				
	        	if(data["RESULT_ERRER"]){
	        		
	        		alert("오류가 발생되었습니다. 관리자에게 문의바랍니다. ");
	        		return;
	        	}
	        	
	        	if("getMemberInfo" == formTag){
					setFrmMember( data["info"][0] );
					
				} else if("selectClass" == formTag){
					setClass(data["info"]); 
				} else if("selectMaster" == formTag) {
					setMaster(data["info"]);
				} else if("selectResult" == formTag) {
					$("#current_smpid").val(pm["smpid"]);
					setResultItem(data["info"]);
				} else if("selectSample" == formTag) {
					setSample(data);
				} else if("selectCopySample" == formTag) {
					setCopySample(data);
				} else if("adjustCopySample" == formTag) {
					setSample(data);
				} else if("selectItems" == formTag){
					// selectitmes for add items
					setSelectItems(data);
				} else if("saveItems" == formTag){
					//setResultItem(data["info"]);
				} else if("adjustTemplet" == formTag) {
					setAdjustTemplet(data);
				} else if("actionTemplet" == formTag) {
					setActionTemplet(data);
				} else if("selectTemplet" == formTag) {
					setTemplet(data);
				} else if("insertTemplet" == formTag) {
					setTemplet(data);
				} else if("deleteTemplet" == formTag) {
					setTemplet(data);
				} else if("requestInfo" == formTag){
					setRequestInfo(data);
				} else if("requestConfirm" == formTag) {
					
					if(data["RESULT_YN"]=="Y"){
						alert("접수 완료 되었습니다.");
						window.location.href = "<c:url value='/detail/reqList.do?sub=detail&menu=reqList'/>";
					} else {
						alert("오류");
					}
				} else if("deleteRequest" == formTag) {
					if(data["RESULT_YN"]=="Y"){
						alert("삭제 되었습니다.");
						window.location.href = "<c:url value='/req/testRequest.do?sub=req&menu=testRequest'/>";
					} else {
						alert("오류");
					}
					
				}
				
	        },
	        error:function(request,status,error){
	        	alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });
	}
	
	
	/* 성적 기본 정보 저장 */
	function actionAdjustRequest(){
		
		//유효성 체크
		// data 가져오기
		var frmData = JSON.stringify( $("#frmMember").serializeFormJSON() );
		
		$.ajax({
			type     : "post",
		    dataType : "json",
		    async    : false,
		    data     : { "dataType":"set", "dataStep":"setp01", "frmData": frmData },
	        url      : "<c:url value='/req/setRequest.json'/>",
	        success: function (data) {
				var result_yn = data["RESULT_YN"];

				if("Y"==result_yn){
	            	actionDivWindow("div1_close");
	            	setFrmMember( data["RESULT_VO"][0] );
	            	actionDivWindow("div_detail_open");
	            } else {
	            	alert( "오류가 발생되었습니다. 관리자에게 문의바랍니다. "+data["RESULT_MESSAGE"]);
	            }
	            
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });
		
		
	}		
		
		
	/* get select Results  */	
	function actionSelectResult(smpid){
		
		$("#current_smpid").val(smpid);
		$("#txt_samplenm").val($("#td_sname_"+smpid).html());
		$("#lbl_masternm").html($("#td_mname_"+smpid).html());
		
		$.ajax({
			type     : "post",
		    data     :  {"mode":"", "reqid":$("#reqid").val(), "smpid":$("#current_smpid").val()},
		    async    : false,
		    url      : "<c:url value='/req/selectResult.json'/>",
	        success: function (data) {

	        	$('#ifrmResults').contents().find('div[id=div_result]').html(data);
	        	
	        	//$("#div_items").html(data);
				
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });		
		
    }	
		
	

	
	
	function actionAdjustSample(){
		/*시료정보 저장 */
		
		//유효성 체크
		// data 가져오기

		
		var reqid = $("#reqid").val();
		var masterid = $("#add_masterId").val();
		var samplename = $("#add_sampleName").val();		
		
		
		
		$.ajax({
			type     : "post",
		    dataType : "json",
		    async    : false,
		    data     : { "dataType":"insert", "reqid":reqid, "masterid": masterid, "sname":samplename },
	        url      : "<c:url value='/req/setSample.json'/>",
	        success: function (data) {
				var result_yn = data["RESULT_YN"];

				if("Y"==result_yn){
	            	//actionDivWindow("div1_close");
	            	setSample(data);
	            	//actionSelectResult(data["SMPID"],);
	            } else {
	            	alert( "오류가 발생되었습니다. 관리자에게 문의바랍니다. /r/n"+data["RESULT_MESSAGE"]);
	            }
	            
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });
        		
	}
	
	
	
	function actionDeleteSample(smpid){
		/* 시료정보 삭제 */
		$("#current_smpid").val("");
		setInitResultTable();
		
		// 유효성 체크
		var reqid = $("#reqid").val();
	
		$.ajax({
			type     : "post",
		    dataType : "json",
		    async    : false,
		    data     : { "dataType":"delete","reqid":reqid, "smpid": smpid },
	        url      : "<c:url value='/req/deleteSample.json'/>",
	        success: function (data) {
				var result_yn = data["RESULT_YN"];

				if("Y"==result_yn){

					setSample(data);
					
	            } else {
	            	alert( "오류가 발생되었습니다. 관리자에게 문의바랍니다. /r/n"+data["RESULT_MESSAGE"]);
	            }
	            
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });
		
	}
	
	
	
	/* addItems from modal   */
	function actionInsertItems(chkItems){
		/*시료정보 저장 */
		
		//유효성 체크
		// data 가져오기
		
		
		pm = {"mode":"insertItems", "reqid":$("#reqid").val(), "smpid":$("#current_smpid").val(), "items":chkItems };
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/req/selectResult.json'/>",
	        success: function (data) {

	        	$('#ifrmResults').contents().find('div[id=div_result]').html(data);
	        	
	        	alert("적용되었습니다. ");
	        	//$("#div_items").html(data);
				
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });	
		
	}

	
	/* saveItems  */
	function actionSaveItems(formTag, pm){
		
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/req/selectResult.json'/>",
	        success: function (data) {

	        	//alert(pm["result"]);
	        	$('#ifrmResults').contents().find('div[id=div_result]').html(data);
	        	
	        	alert("적용되었습니다. ");
	        	//$("#div_items").html(data);
				
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });		
		
		
	}
	
	/* deleteItems  */
	function actionDeleteItems(pm){
		
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/req/selectResult.json'/>",
	        success: function (data) {

	        	//alert(pm["result"]);
	        	$('#ifrmResults').contents().find('div[id=div_result]').html(data);
	        	
	        	alert("적용되었습니다. ");
	        	//$("#div_items").html(data);
				
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });		
		
		
	}	
	
	 
	/* insertItemsCopy  */
	function actionInsertItemsCopy(pm){
		
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/req/selectResult.json'/>",
	        success: function (data) {

	        	//alert(pm["result"]);
	        	$('#ifrmResults').contents().find('div[id=div_result]').html(data);
	        	
	        	alert("적용되었습니다. ");
	        	//$("#div_items").html(data);
				
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });		
		
		
	}	
	
	/* updateItemsCopy  */
	function actionUpdateItemsCopy(pm){
		
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/req/selectResult.json'/>",
	        success: function (data) {

	        	//alert(pm["result"]);
	        	$('#ifrmResults').contents().find('div[id=div_result]').html(data);
	        	
	        	alert("적용되었습니다. ");
	        	//$("#div_items").html(data);
				
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });		
		
		
	}		
	
	
	/* deleteItemsCopy  */
	function actionDeleteItemsCopy(pm){
		
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/req/selectResult.json'/>",
	        success: function (data) {

	        	//alert(pm["result"]);
	        	$('#ifrmResults').contents().find('div[id=div_result]').html(data);
	        	
	        	alert("적용되었습니다. ");
	        	//$("#div_items").html(data);
				
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        },
	        complete: function (data) {
	        	//gridView.hideToast();
	        },
	        cache: false
	    });		
		
		
	}		

	
	/* zipcode   */
    function actionAjaxZipcode(pm){
		var url = "<c:url value='/main/zipcodeService.json' />";
		
		$.ajax({
			type     : "post",
		   	dataType : "json",
		   	data     : pm,
		    url      : url,
		    success: function(result){	
		    	// session check
		    	if(result["CHECK_SESSION"] == "N"){
		    		alert("로그아웃 되었습니다. 다시 로그인 바랍니다.");
		    		return;
		    	}
		    	
		        if(pm.formTag == "siguList"){
		        	
		        	if(result["RESULT_YN"]=="Y" ){
		        		// 정보 가져오기 
			        	resultSiguList(result["RESULT_LIST"]);
		        	} else {
		        		alert("해당하는 정보가 없습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm.formTag == "zipcodeSearch"){
		        	
		        	resultZipcodeList(result);
		        	
		        }
		    },
		    error:function(request,status,error){
		    	alert("Error : "+error);
		    },
		    complete: function (data) {
		    },
		   
		});
    }
</script>


<!-- for event   -->
<script>
/* action files  */ 

	function actionFile(){
		$("#frmFile").ajaxForm();
		
		var url = "<c:url value='/request/attachFile.json' />";
		$("#file_reqid").val($("#reqid").val());
		
		$("#frmFile").ajaxSubmit({
			type       : "post",
			processData: false,
	        contentType: false,
		    url        : url,
		    dataType   : "json",
			statusCode: {			
			      400: function() {
			        alert("파일 내용이 잘못되었습니다.");
			      },			
			      500: function() {
			        alert("파일을 업로드할 수 없습니다.");
			      }
			    },						
		    success: function(data) {
		    	resultAttach(data["RESULT_ATTACH"]);
		        //alert("업로드 되었습니다. 페이지를 다시 읽습니다.");
		    }
			
		})
	
     }

	function actionEraseAttach(pm){
		
		var url = "<c:url value='/request/deleteFile.json' />";
		
		$.ajax({
			type     : "post",
		   	dataType : "json",
		   	data     : {"reqid":$("#reqid").val(),"reqfid":pm[0],"filepath":pm[1] },
		    url      : url,
		    success: function(data){	
		    	// session check
		    	if(data["CHECK_SESSION"] == "N"){
		    		alert("로그아웃 되었습니다. 다시 로그인 바랍니다.");
		    		return;
		    	}
		    	resultAttach(data["RESULT_ATTACH"]); 	
		    },
		    error:function(request,status,error){
		    	alert("Error : "+error);
		    },
		    complete: function (data) {
		    },
		   
		});		
		
		
	}

	function actionDownload(filenick, fileName){
		//filenick = filenick.replace("\\","\\\\");
		
		//alert(filenick);
		//return;
    	window.open("<c:url value='/common/download.json?filenick="+filenick+"&fileName="+fileName+"'/>");
	}
	
	
	function actionList(){
		window.location.href = "<c:url value='/detail/state.do?sub=detail&menu=state'/>";
	}
	
</script>


		<!-- right_warp(일반 사용자 정보 ) -->
		<div class="right_warp">
			<div class="title_route">
				<h3>일반시험의뢰</h3>
				<p class="route">
				<img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 시험신청 <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>일반의뢰 시험</span></p>
			</div>
			<div class="template_btn" style="height:34px;">
				<!--   
			    <div type="button" id="btn_insertTemplet" class="btn btn-primary btn-normal" style="height:27px;padding:2px 12px !important; float:right;margin-right:3px;" onclick="javascript:actionPerformed('insertTemplete');">
					템플릿 저장하기
			    </div>
			    
			    <div type="button" id="btn_adjustTemplet" class="btn btn-primary btn-normal" style="height:27px;padding:2px 12px !important; float:right;margin-right:3px;" onclick="javascript:actionPerformed('adjustTemplete');">
					템플릿 적용하기
			    </div>
				-->
				<div type="button" id="btn_delRequest" class="btn btn-warning btn-normal" style="height:27px;padding:2px 12px !important; float:right;margin-right:8px;" onclick="javascript:actionPerformed('deleteRequest');">
					의뢰정보 삭제
			    </div>
			    
			 <%-- 
				<a href="javascript:actionPerformed('adjustTemplete');"><img id="btn_adjustTemplet" src="<c:url value='/images/exam/btn/btn_template_get.gif'/>" alt="템플릿가져오기" style="border:0px;    border-radius: 0px;" /></a>
				<a href="javascript:actionPerformed('insertTemplete');"><img id="btn_insertTemplet" src="<c:url value='/images/exam/btn/btn_template_save.gif'/>" alt="템플릿저장하기" style="border:0px;    border-radius: 0px;" /></a>
			 --%>	
			</div>

	<form name="frmMember" id="frmMember">
		    <input type="hidden" id="reqid" name="reqid" value=""  />
		    <input type="hidden" id="current_smpid" name="current_smpid" />
		    <input type="hidden" id="reqstate" name="reqstate" />
		    
			<!-- 신청자정보 -->
			<div class="table_warp">
				<span class="back_bg_t">&nbsp;</span>
				<!-- table_w_in -->
				<div id="" class="table_w_in">
					<p class="close_btn">
						<a href="javascript:actionDivWindow('div1_close');"><img id="icon_div1_close" src="<c:url value='/images/exam/btn/btn01.gif'/>" alt="" /></a>
						<a href="javascript:actionDivWindow('div1_open');"><img id="icon_div1_open" src="<c:url value='/images/exam/btn/btn02.gif'/>" alt="" /></a>
					</p>
					<h4 class="title01">신청자 정보 </h4>
					<!-- table_bg -->
					<div id="div1_win_content" class="table_bg">
						<table summary="신청자정보" class="table_w">
							<colgroup>
							<col width="134px"/>
							<col width="275px"/>
							<col width="134px"/>
							<col width="*"/>
							</colgroup>
							<tr>
								<th>업체명</th>
								<td><label id="cname" fieldName="cname" ></label></td>
								<th>사업자번호</th>
								<td><label id="bizno" fieldName="bizno" ></label></td>
							</tr>
							<tr>
								<th>업태</th>
								<td><label id="biztype" fieldName="biztype" ></label></td>
								<th>대표자</th>
								<td><label id="ceoname" fieldName="ceoname" ></label></td>
							</tr>
							<tr>
								<th>담당자 <span class="surely01">*</span></th>
								<td><input id="mngname" name="mngname" type="text" value="" class="h30" style="width:243px;border:0px;" readonly="readonly"/></td>
								<th>담당부서 <span class="surely01">*</span></th>
								<td><input id="mngdept" name="mngdept" type="text" value="" class="h30" style="width:243px;border:0px;" readonly="readonly"/></td>
							</tr>
							<tr>
								<th>휴대폰 <span class="surely01">*</span></th>
								<td>
									<input type="text" id="mnghp" name="mnghp" value="" class="h30" style="width:108px;border:0px;" placeholder="010-0000-0000" readonly="readonly"/>
									<div class="ex">
									</div> 
								</td>
								<th>이메일 <span class="surely01">*</span></th>
								<td><input name="mngemail" id="mngemail" type="text" value="" class="h30" style="width:243px;border:0px;" readonly="readonly"/></td>
							</tr>
							<tr>
								<th class="b_B_none">전화번호 <span class="surely01">*</span></th>
								<td class="b_B_none">
									<input type="text" id="mngphone" name="mngphone" value="" class="h30" style="width:108px;border:0px;" placeholder="020-0000-0000" readonly="readonly"/>
									<div class="ex">
									</div> 
								</td>
								<th class="b_B_none">팩스번호 <span class="surely01">*</span></th>
								<td class="b_B_none">
									<input type="text" id="fax" name="fax" value="" class="h30" style="width:108px;border:0px;" placeholder="020-0000-0000" readonly="readonly"/>
									<div class="ex">
									</div> 
								</td>
							</tr>
						</table>
					</div>
					<!-- //table_bg  -->


					<h4 id="div2_h4" class="title01">성적서 기본정보</h4>
					<!-- table_bg -->
					<div id="div2_win_content" class="table_bg">
						<table summary="성적서 기본정보" class="table_w">
							<colgroup>
							<col width="136px"/>
							<col width="276px"/>
							<col width="130px"/>
							<col width="*"/>
							</colgroup>
							<tr>
								<th>시험성적서 원본</th>
								<td>
									<select name="langtype" id="langtype" class="h30" style="width:100px;">
										<option value="K"> 국문 1부</option>
										<option value="E"> 영문 1부</option>
									</select>
								</td>
								<th>성적서 용도</th>
								<td>
									<select name="usage" id="usage" class="h30" style="width:150px;">
										<option value="-1">##선택##</option>
										<option value="20">품질관리용</option>
										<option value="21">업체납품용</option>
										<option value="22">연구개발용</option>
										<option value="23">기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>시험성적서 부분</th>
								<td>
									<select name="copycnt" id="copycnt" class="h30" style="width:100px;" onchange="javascript:actionChangeCopycnt();">
										<option value="0">신청안함</option>
										<% for(int cnt=0; cnt<10; cnt++){ %>
										<option value="<%=cnt+1%>"><%=cnt+1%></option>
										<% } %>
										<option value="etc">기타</option>
									</select>
									
									<input id="copycnt_etc" name="copycnt_etc" type="text" class="h30" style="width:50px; display: none;" />									
									<span id="span_copycnt_etc">부</span>
								</td>
								<th >시험완료후<br/>시료처리</th>
								<td >
									<select id="itemafter" name="itemafter" class="h30" style="width:150px;">
										<option value="1">폐기</option>
										<option value="2">보관</option>
									</select>
								</td>
							</tr>

							<tr>
								<th >시험성적서<br/>받는 주소</th>
								<td colspan="3">
									<div style="
										height: 28px;
    									padding-top: 16px;
									">
										<input type="radio" id="rcvtype" name="rcvtype" value="1"  onclick="javascript:actionClickRcv();" /> 신청자 정보와 동일
										<input type="radio" id="rcvtype" name="rcvtype" value="2"  class="m_L40" onclick="javascript:actionClickRcv();"/> 신규등록
								    </div>
								    <div class="div_table_sub_w">
								<table id="tbl_rcv" class="table_sub_w" style="display:none;">
									<colgroup>
										<col width="100px"/>
										<col width="130px"/>
										<col width="100px"/>
										<col width="*"/>
									</colgroup>
									
									<tr>
										<th class="cor01">업체명</th>
										<td ><input id="rcvcompany" name="rcvcompany" type="text" value="" class="h30" style="width:200px;border:0px;" readonly="readonly"/></td>
										<th class="cor01">대표자</th>
										<td><input id="rcvceo" name="rcvceo" type="text" value="" class="h30" style="width:200px;border:0px;" readonly="readonly"/></td>
									</tr>
									<tr>
										<th class="cor01" style="height:70px;">주소</th>
										<td colspan="3">
											<input id="rcvzipcode" name="rcvzipcode" type="text" value="" class="h30" style="width:60px;border:0px;" readonly="readonly"/>
				                            <br>
											<input id="rcvaddr1" name="rcvaddr1" type="text" value="" class="h30" style="width:365px; margin-top:3px;border:0px;" readonly="readonly" />
											<input id="rcvaddr2" name="rcvaddr2" type="text" value="" class="h30" style="width:140px; margin-top:3px;float:right;border:0px;" readonly="readonly"/>
										</td>
									</tr>
									<tr>
										<th class="cor01">담당부서</th>
										<td ><input id="rcvdept" name="rcvdept" type="text" value="" class="h30" style="width:200px;border:0px;" readonly="readonly"/></td>
										<th class="cor01">담당자</th>
										<td ><input id="rcvmngname" name="rcvmngname" type="text" value="" class="h30" style="width:200px;border:0px;" readonly="readonly"/></td>
										
									</tr>
									<tr>
										<th class="cor01">휴대폰</th>
										<td >
											<input type="text" id="rcvhp" name="rcvhp" value="" class="h30" style="width:108px;border:0px;" placeholder="020-0000-0000" readonly="readonly"/>
										</td>
										<th class="cor01">이메일</th>
										<td><input type="text" id="rcvemail" name="rcvemail" value="" class="h30" style="width:200px;border:0px;" readonly="readonly"/></td>
										
										
									</tr>
									<tr>
										<th class="cor01">전화번호</th>
										<td >
											<input type="text" id="rcvphone" name="rcvphone" value="" class="h30" style="width:108px;border:0px;" placeholder="020-0000-0000" readonly="readonly"/>
										</td>
										
										<th class="cor01">팩스번호</th>
										<td style="border-right: 1px solid #FFFFFF !important;">
											<input type="text" id="rcvfax" name="rcvfax" value="" class="h30" style="width:108px;border:0px;" placeholder="020-0000-0000" readonly="readonly"/>
										</td>
									</tr>								
								</table>
								</div>
								
								
								</td>
							</tr>
							
							<tr>
								<th>세금계산서 청구</th>
								<td colspan="3">
									<select id="pricechargetype" name="pricechargetype" class="h30" style="width:100px; margin-bottom:6px; margin-top:3px;" onchange="javascript:actionChangePriceType();">
										<option value="-1">##선택##</option>
										<option value="26">청구</option>
										<option value="27">카드</option>
										<option value="28">영수</option>
									</select>
									
									<table id="tbl_tax" class="table_sub_w" style="display:none;">
										<colgroup>
											<col width="100px"/>
											<col width="130px"/>
											<col width="100px"/>
											<col width="*"/>
										</colgroup>									
									
										<tr>
											<th class="cor01">업체명</th>
											<td ><input id="taxcompany" name="taxcompany" type="text" value="" class="h30" style="width:220px;border:0px;" readonly="readonly"/></td>
											<th  class="cor01">대표자</th>
											<td><input id="taxceo" name="taxceo" type="text" value="" class="h30" style="width:220px;border:0px;" readonly="readonly"/></td>
										</tr>
										<tr>
											<th class="cor01" style="height:70px;">주소</th>
											<td colspan="3">
											<input id="taxzipcode" name="taxzipcode" type="text" value="" class="h30" style="width:60px;border:0px;" readonly="readonly"/>
				                            <br>
											<input id="taxaddr1" name="taxaddr1" type="text" value="" class="h30" style="width:365px;border:0px; margin-top:3px;" readonly="readonly" />
											<input id="taxaddr2" name="taxaddr2" type="text" value="" class="h30" style="width:180px;border:0px; margin-top:3px;float:right;" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th class="cor01">사업자번호</th>
											<td ><input id="taxbizno" name="taxbizno" type="text" value="" class="h30" style="width:220px;border:0px;" readonly="readonly"/></td>
											<th class="cor01">업태</th>
											<td><input type="text" id="taxbiztype" name="taxbiztype" value=" " class="h30" style="width:220px;border:0px;" readonly="readonly"/></td>
										</tr>
										<tr>
											<th class="cor01">담당부서</th>
											<td ><input id="taxdept" name="taxdept" type="text" value="" class="h30" style="width:220px;border:0px;" readonly="readonly"/></td>
											<th class="cor01">담당자</th>
											<td><input type="text" id="taxmngname" name="taxmngname" value=" " class="h30" style="width:220px;border:0px;" readonly="readonly"/></td>
										</tr>										
										<tr>
											<th class="cor01">이메일</th>
											<td ><input id="taxemail" name="taxemail" type="text" value="" class="h30" style="width:220px;border:0px;" readonly="readonly"/></td>
											<th class="cor01">휴대폰</th>
											<td >
												<input type="text" id="taxhp" name="taxhp" value="" class="h30" style="width:108px;border:0px;" placeholder="020-0000-0000" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th class="cor01">전화번호</th>
											<td >
												<input type="text" id="taxphone" name="taxphone" value="" class="h30" style="width:108px;border:0px;" placeholder="020-0000-0000" readonly="readonly"/>
											</td>
											<th class="b_B_none cor01">팩스번호</th>
											<td class="b_B_none">
												<input type="text" id="taxfax" name="taxfax" value="" class="h30" style="width:108px;border:0px;" placeholder="020-0000-0000" readonly="readonly"/>
											</td>
										</tr>									
									
									
									</table>
									
									
									
									
								</td>
							</tr>
							

						</table>
					</div>
					
					
<%-- 					<p id="div2_btn" class="txt_C" style="padding-top:8px;" >
					 	<a href="javascript:actionPerformed('setRequest');"> <img id="btn_setrequest" src="<c:url value='/images/exam/btn/btn_save02.gif'/>" alt="저장"  /> </a>
					</p> 
--%>
					<div id="div2_btn" style="width:100%;text-align: center;margin-top:6px;">
					<div type="button" id="btn_setRequest" class="btn btn-primary btn-normal" style="height:32px;padding:1px 24px 1px 24px !important; margin-right:8px; font-weight:700 !important; font-size:16px !important" onclick="javascript:actionPerformed('setRequest');">
						저 장 
					</div>
					</div>
			
					
					<!-- //table_bg  -->
				</div>
				
				
				
				<!-- //table_w_in -->
				<span class="back_bg_b">&nbsp;</span>
			</div>
			<!-- //성적서 기본정보 -->
	</form>			
			
			
	</div>
	
	<div class="right_warp" id="div_detail" style="display:none;">			
			
			<div class="table_warp">
				<span class="back_bg_t">&nbsp;</span>
				<div class="table_w_in">
				
					<h4 class="title01">
						<span class="txt">시료정보</span>
						<span id="div_sample" class="btn_r">
							<a href="javascript:actionPerformed('addSample');"><img id="btn_addSample" src="<c:url value='/images/exam/btn/btn_sample01.gif'/>" alt="시료추가" style="border:0px;" /></a>
							<a href="javascript:actionPerformed('copySample');"><img id="btn_copySample" src="<c:url value='/images/exam/btn/btn_sample02.gif'/>" alt="시료복사" style="border:0px;"/></a>
						</span>
					</h4>
					<!-- table_bg -->
					<div class="table_bg" style="width:100%;height:200px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table summary="시료정보" class="table_h" id="tbl_sample" name="tbl_sample">
							<colgroup>
							<col width="8%"/>
							<col width="40%"/>
							<col width="40%"/>
							<col width="*"/>
							</colgroup>
							<tr>
								<th>순번</th>
								<th>시료명칭</th>
								<th>유종제품</th>
								<th class="b_R_none">삭제</th>
							</tr>
							

						</table>
					</div>
					<!-- //table_bg  -->
				</div>
				<!-- //table_w_in -->
				<span class="back_bg_b">&nbsp;</span>
			</div>
			<!-- //시료정보 -->

			<!-- 검사항목 -->
			<div class="table_warp">
				<span class="back_bg_t">&nbsp;</span>
				<div class="table_w_in">
					<table summary="시료명칭/유종제품" class="table_w " style="margin-top: 0px;">
						<colgroup>
						<col width="20%"/>
						<col width="*"/>
						</colgroup>
						<tr>
							<th class="bor_T_color01 bor_L_color01 bor_B_color01">시료명칭/유종제품</th>
							<td class="bor_T_color01 bor_R_color01 bor_B_color01 ">
								<input type="text" id="txt_samplenm" name="txt_samplenm" value="" class="h30" style="width:42%" />
								/
								<label id="lbl_masternm" name="lbl_masternm" sytle="width:48%"></label>
							</td>
						</tr>
					</table>
					<h4 class="title01">
						<span class="txt">검사항목</span>
						<span id="div_items" class="btn_r">
							<a href="javascript: actionPerformed('openSelectItems');"><img id="btn_addItems" src="<c:url value='/images/exam/btn/btn_article01.gif'/>" alt="항목추가" style="border:0px;" /></a>
							<a href="javascript: actionPerformed('deleteItems')"><img id="btn_delItems" src="<c:url value='/images/exam/btn/btn_article02.gif'/>" alt="항목삭제"/></a>
							<a href="javascript: actionPerformed('insertItemsCopy')"><img id="btn_copyItems" src="<c:url value='/images/exam/btn/btn_article03.gif'/>" alt="항목복사"/></a>
							<a href="javascript: actionPerformed('deleteItemsCopy');"><img id="btn_delSameItems" src="<c:url value='/images/exam/btn/btn_article04.gif'/>" alt="동일항목 삭제"/></a>
							<a href="javascript: actionPerformed('updateItemsCopy');"><img id="btn_copySameItems" src="<c:url value='/images/exam/btn/btn_article05.gif'/>" alt="동일항목 속성일괄복사"/></a>
							<a href="javascript: actionPerformed('saveItems');" class="last"><img id="btn_saveItems" src="<c:url value='/images/exam/btn/btn_save01.gif'/>" alt="저장" /></a>
						</span>
					</h4>
					<!-- table_bg -->
					<div id="div_items" name="div_items" class="table_bg" style="width:100%;height:350px; overflow:hidden;">
                    	<iframe id="ifrmResults" src="<c:url value='/req/testIframe.do'/>" style="width:100%; height:350px; padding:0px; border: 0px;"></iframe>
					</div>
					<!-- //table_bg  -->
				</div>
				<!-- //table_w_in -->
				<span class="back_bg_b">&nbsp;</span>
			</div>
			<!-- //검사항목 -->

			<form id="frmFile" name="frmFile" enctype="multipart/form-data">
			<input type="hidden" name="file_reqid" id="file_reqid">
			
			<div class="table_warp">
				<span class="back_bg_t">&nbsp;</span>
					<div id="" class="table_w_in">
					<h4 class="title01">파일등록</h4>
					<!-- table_bg -->
					<div class="table_bg" style="width:100%;height:150px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table class="table_h" id="tbl_attach">
							<colgroup>
							<col width="80px"/>
							<col width="620px"/>
							<col width="*"/>
							</colgroup>
							<thead>
								<tr>
									<th>순번</th>
									<th>등록파일명</th>
									<th>삭제</th>
								</tr>
							</thead>
						</table>
					</div>	
						<br>
						<table class="table_h" style="display: none;">	
							<tfoot>
								<tr>
									<td colspan="3">
										<input type="file" id="attach" name="attach" style="width:500px;height:20px;">
										<img id="btn_addFiles" onclick="javascript:actionFile();" src="<c:url value='/images/exam/btn/btn_save01.gif'/>" alt="저장" align="right" style="cursor: pointer;"/>
									</td>
								</tr>
							</tfoot>
						</table>
						
					</div>
				<span class="back_bg_b">&nbsp;</span>
			</div>
			</form>
			
			<!-- 시험자에게 남기는 글 -->
			<div class="say_talk">
				<textarea class="say_talk_text" id="itemdesc" name="tiemdesc"></textarea>
				<p class="sum">
					<input type="text" id="totalprice" name="totalprice" value="" style="text-align: right;font-weight:700;"/>
				</p>
			</div>
			<!-- //시험자에게 남기는 글 -->
			
			<div style="width:100%;text-align: center;">
			<div type="button" id="btn_confirm" class="btn btn-primary btn-normal" style="height:38px;padding:8px 24px 1px 24px !important; margin-right:8px; font-weight:700 !important; font-size:16px !important" onclick="javascript:">
				접수 완료
			</div>

			<div type="button" id="btn_reqList" class="btn btn-default btn-normal" style="height:27px;padding:2px 12px !important; margin-right:8px;" onclick="javascript:actionList();">
				확 인
			</div>


			</div>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		</div>
		<!-- //right_warp(오른쪽 내용) -->


<!-- modal jsp include -->
<%@ include file="/WEB-INF/jsp/exam/req/testModal.jsp" %>




