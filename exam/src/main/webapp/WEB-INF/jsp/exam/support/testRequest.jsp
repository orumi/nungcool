<%@ page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%
	String detailReqid = request.getParameter("detailReqid");
%>


<style>
  
	/* add Sample model dailog */
    
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
    
    .my-placeholder { color: #DEDEDE; }

</style>
<script type="text/javascript" src="<c:url value='/rexscript/getscript.jsp?f=rexpert.min'/>"></script>
<script type="text/javascript" src="<c:url value='/rexscript/getscript.jsp?f=rexpert.properties'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/exam/testRequestEstimate.js' />"></script>

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
		//setSelectInfo("getMemberInfo", {"formTag":"getMemberInfo"} );
		<% } %>
		
		
	});	 
			
 
 
 	function setSelectInfo(formTag, pm){
		$.ajax({
			type     : "post",
		    dataType : "json",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/support/selectInfo.json'/>",
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
					
					if(data["RESULT_YN"] == "XM"){
						alert("저장 안된 [시험방법] 또는 [요구규격]이 있습니다.");
						
						actionSelectResult(data["RESULT_METHODCHECK"][0]["smpid"]);
					} else if(data["RESULT_YN"] == "XC"){
						alert("저장 안된 [시험조건]이 있습니다.");
						
						actionSelectResult(data["RESULT_CONDITIONCHECK"][0]["smpid"]);
						
					} else if(data["RESULT_YN"]=="Y"){
						alert("접수 완료 되었습니다.");
						window.location.href = "<c:url value='/detail/reqList.do?sub=detail&menu=reqList'/>";
					} else {
						alert("오류");
					}
				} else if("deleteRequest" == formTag) {
					if(data["RESULT_YN"]=="Y"){
						alert("삭제 되었습니다.");
						window.location.href = "<c:url value='/support/testRequest.do?sub=req&menu=testRequest'/>";
					} else {
						alert("오류");
					}
					
				} else if("selectDetailSearch" == formTag){
					setDetailSearch(data["info"]); 
					
					setItemGroup(data["itemGroup"]);
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
		
		/* form to JSON */
	    $.fn.serializeFormJSON = function () {

	        var o = {};
	        var a = this.serializeArray();
	        $.each(a, function () {
	            if (o[this.name]) {
	                if (!o[this.name].push) {
	                    o[this.name] = [o[this.name]];
	                }
	                o[this.name].push(this.value || '');
	            } else {
	                o[this.name] = this.value || '';
	            }
	        });
	        return o;
	    };
	    
		var frmData = JSON.stringify( $("#frmMember").serializeFormJSON() );
		
		$.ajax({
			type     : "post",
		    dataType : "json",
		    async    : false,
		    data     : { "dataType":"set", "dataStep":"setp01", "frmData": frmData },
	        url      : "<c:url value='/support/setRequest.json'/>",
	        success: function (data) {
				var result_yn = data["RESULT_YN"];

				if("Y"==result_yn){
	            	actionDivWindow("div1_close");
	            	setFrmMember( data["RESULT_VO"][0] );
	            	actionDivWindow("div_detail_open");
	            	setPrice(data["RESULT_PRICEVO"]);
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
		    url      : "<c:url value='/support/selectResult.json'/>",
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
		var kolasyn = $("#kolasyn").val();
		
		
		
		$.ajax({
			type     : "post",
		    dataType : "json",
		    async    : false,
		    data     : { "dataType":"insert", "reqid":reqid, "masterid": masterid, "sname":samplename, "kolasyn":kolasyn },
	        url      : "<c:url value='/support/setSample.json'/>",
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
	        url      : "<c:url value='/support/deleteSample.json'/>",
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
	function actionInsertItems(parentItems, chkItems, pItems){
		/*시료정보 저장 */
		
		//유효성 체크
		// data 가져오기
		
		
		pm = {"mode":"insertItems", "reqid":$("#reqid").val(), "smpid":$("#current_smpid").val(), "items":chkItems, "pItems":pItems , "parentItems":parentItems};
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/support/selectResult.json'/>",
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
	
	/* addItems from modal   */
	function actionInsertItemsCheck(chkItems, pItems){
		/*시료정보 저장 */
		
		//유효성 체크
		// data 가져오기
		
		
		pm = {"formTag":"insertItemsCheck", "reqid":$("#reqid").val(), "smpid":$("#current_smpid").val(), "items":chkItems, "pItems":pItems };
		$.ajax({
			type     : "post",
		    data     :  pm,
		    dataType : "json",
		    async    : false,
	        url      : "<c:url value='/support/selectInfo.json'/>",
	        success: function (data) {

	        	var result_except = data["RESULT_EXCEPT"];
	        	
	        	
	        	//if("Y" == data["RESULT_EXCEPT"] || "Y" == data["RESULT_DUPLICATE"] ){
	        	if("Y" == data["RESULT_DUPLICATE"] ){
	        		actionAddItemDuplicate(data);
	        		
	        		
	        		/* 
	        		var items = data["RESULT_EXCEPTITEM"][0]["itemname"];
	        		
		        	if(confirm("중복된 항목이 있습니다. 기존항목 삭제하고 추가하시겠습니까?\r[중복된 항목 : "+items+"]")){
		        		actionAddItems("EXCEPT_Y");
		        	}
		        	 */
		        	
	        	} else {
	        		actionAddItems("EXCEPT_N");
	        		
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

	
	/* saveItems  */
	function actionSaveItems(formTag, pm){
		
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/support/selectResult.json'/>",
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
	
	/* 항목추가 선택시 저장  */
	function actionSaveItemsAuto(formTag, pm){
		
		$.ajax({
			type     : "post",
		    data     :  pm,
		    async    : false,
	        url      : "<c:url value='/support/selectResult.json'/>",
	        success: function (data) {

	        	$('#ifrmResults').contents().find('div[id=div_result]').html(data);
	        	
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
	        url      : "<c:url value='/support/selectResult.json'/>",
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
	        url      : "<c:url value='/support/selectResult.json'/>",
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
	        url      : "<c:url value='/support/selectResult.json'/>",
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
	        url      : "<c:url value='/support/selectResult.json'/>",
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
		
	/* 
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
		   
		}); */
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
	
	 function fnOpen() {
			// 필수 - 레포트 생성 객체
			var oReport = GetfnParamSet();
			// 여러 iframe에 레포트를 보여주기 위해 레포트객체id 명시할 수 있음.
			//var oReport = GetfnParamSet("0");

			// 필수 - 레포트 파일명
			//oReport.rptname = rebName;
			
			oReport.rptname = "http://10.1.10.106:8080/tems/rebfiles/nmestimate.reb";

			// 옵션 - 데이터타입(csv - 기본값, xml)
			//oReport.datatype= "xml";

			// 옵션 - 데이터베이스 연결 정보 (서버로 통해 데이터를 가져올 때)
			oReport.connectname= "oracle1";
			
			//var tbl_receiptno = getCheckBoxs();
			var reqid = $("#reqid").val();
			alert(reqid);
			// 옵션 - 레포트 파라메터
			oReport.param("reqid").value = reqid;
			
			oReport.event.init = fnReportEvent;
			oReport.event.buttonprintclickbefore = fnReportEvent;
			oReport.event.buttonprintclickafter = fnReportEvent;
			
			oReport.event.buttonexportclickbefore = fnReportEvent;
			oReport.event.buttonexportclickafter = fnReportEvent;
			
			oReport.event.buttonrefreshclickbefore = fnReportEvent;
			oReport.event.buttonrefreshclickafter = fnReportEvent;	
			
			oReport.event.buttonexportxlsclickbefore = fnReportEvent;
			oReport.event.buttonexportxlsclickafter = fnReportEvent;		

			oReport.event.buttonexportpdfclickbefore = fnReportEvent;
			oReport.event.buttonexportpdfclickafter = fnReportEvent;	
			
			oReport.event.buttonexporthwpclickbefore = fnReportEvent;
			oReport.event.buttonexporthwpclickafter = fnReportEvent;

			oReport.event.cancelprint = fnReportEvent;

			oReport.event.buttonclosewindowclickbefore = fnReportEvent;
			oReport.event.buttonclosewindowclickafter = fnReportEvent;

			oReport.event.printpage = fnReportEvent;
			oReport.event.cancelexport = fnReportEvent;	
			oReport.event.finishprintresult = fnReportEvent;


			oReport.event.errorevent = fnReportEvent;
			
			oReport.event.beforeprint = fnReportEvent;
			//oReport.save(false, "pdf", "c:\\"+val+".pdf", 1, -1, "");	// 다이얼로그표시유무, 파일타입, 파일명, 시작페이지, 끝페이지, 카피수, 옵션
			oReport.open();
			//oReport.save(false, "pdf", "c:\\LIMSReport\\"+fName+".pdf", 1, -1, "");	// 다이얼로그표시유무, 파일타입, 파일명, 시작페이지, 끝페이지, 카피수, 옵션
			//filename = fName;
		}
	 
	 function fnReportEvent(oRexCtl, sEvent, oArgs) {
			//alert(sEvent);

			if (sEvent == "init") {
				 /* oRexCtl.SetCSS("export.appearance.filelist.selectedfile=pdf");   
				 oRexCtl.SetCSS("export.appearance.filepath=C:\\LIMSReport\\"+filename+".pdf");
				 oRexCtl.SetCSS("export.xls.option.zoomrate=200");   
			     oRexCtl.UpdateCSS(); */   
			} else if (sEvent == "finishdocument") {
				oRexCtl.Zoom("wholepage");
			} else if (sEvent == "finishprint") {
				
			} else if (sEvent == "finishexport") {
				//alert(oArgs.filename);

			} else if (sEvent == "finishprintresult") {
				//alert(oArgs.resultcode);
				/*
					0      : 성공
					1002 : 인쇄 작업이 일지정지
					1003 : 인쇄 작업중 오류 발생
					1004 : 인쇄 작업이 삭제중
					1005 : 프린터 오프라인상태
					1006 : 프린터 용지 부족
					1007 : 인쇄 작업이 삭제됨
					9999 : 알수 없는 오류 발생
				*/
			} else if (sEvent == "hyperlinkclicked") {
				//alert(oArgs.Path);
			} else if (sEvent == "buttonprintclickbefore") { 
			} else if (sEvent == "buttonprintclickafter") {  
			} else if (sEvent == "buttonexportclickbefore") { 
			} else if (sEvent == "buttonexportclickafter") { 
			} else if (sEvent == "buttonrefreshclickbefore") {
			} else if (sEvent == "buttonrefreshclickafter") { 
			} else if (sEvent == "buttonexportxlsclickbefore") {  
			} else if (sEvent == "buttonexportxlsclickafter") { 
			} else if (sEvent == "buttonexportpdfclickbefore") {
			} else if (sEvent == "buttonexportpdfclickafter") { 
			} else if (sEvent == "buttonexporthwpclickbefore") {  
			} else if (sEvent == "buttonexporthwpclickafter") {  
			} else if (sEvent == "cancelprint") { 
			} else if (sEvent == "buttonclosewindowclickbefore") { 
			} else if (sEvent == "buttonclosewindowclickafter") { 
			} else if (sEvent == "printpage") { 
				//alert("call:"  + "oArgs.totalpage:" + oArgs.totalpage + "   oArgs.page:" + oArgs.page);
			} else if (sEvent == "cancelexport") {  
			} else if (sEvent == "finishprintresult") {  
				//alert("call:"  + "finishprintresult" + "oArgs.resultcode:" + oArgs.resultcode);
			} else if (sEvent == "errorevent") {  
				//alert("call:"  + "errorevent" + "oArgs.errorxml:" + oArgs.errorxml);
			} else if (sEvent == "beforeprint") {
				//alert("printname : " + oArgs.printname + "\r\nfrompage : " + oArgs.frompage + "\r\ntopage : " + oArgs.topage + "\r\ncopies : " + oArgs.copies);
			}
			//window.close();
		}
	
</script>


		<!-- right_warp(일반 사용자 정보 ) -->
		<div class="right_warp">
			<div class="title_route">
				<h3>일반의뢰시험 견적서 산출</h3>
				<p class="route">
				<img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 고객지원센터 <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>일반의뢰시험 견적서 산출</span></p>
			</div>
			<!-- 
			<div class="template_btn" style="height:34px;">
			    <div type="button" id="btn_insertTemplet" class="btn btn-primary btn-normal" style="height:27px;padding:2px 12px !important; float:right;margin-right:3px;" onclick="javascript:actionPerformed('insertTemplete');">
					템플릿 저장하기
			    </div>
			    
			    <div type="button" id="btn_adjustTemplet" class="btn btn-primary btn-normal" style="height:27px;padding:2px 12px !important; float:right;margin-right:3px;" onclick="javascript:actionPerformed('adjustTemplete');">
					템플릿 적용하기
			    </div>

				<div type="button" id="btn_delRequest" class="btn btn-warning btn-normal" style="height:27px;padding:2px 12px !important; float:right;margin-right:8px;" onclick="javascript:actionPerformed('deleteRequest');">
					의뢰정보 삭제
			    </div>
			    
			 <%-- 
				<a href="javascript:actionPerformed('adjustTemplete');"><img id="btn_adjustTemplet" src="<c:url value='/images/exam/btn/btn_template_get.gif'/>" alt="템플릿가져오기" style="border:0px;    border-radius: 0px;" /></a>
				<a href="javascript:actionPerformed('insertTemplete');"><img id="btn_insertTemplet" src="<c:url value='/images/exam/btn/btn_template_save.gif'/>" alt="템플릿저장하기" style="border:0px;    border-radius: 0px;" /></a>
			 --%>	
			</div>
			 -->

	<form name="frmMember" id="frmMember">
		    <input type="hidden" id="reqid" name="reqid" value=""  />
		    <input type="hidden" id="current_smpid" name="current_smpid" />
		    <input type="hidden" id="reqstate" name="reqstate" />
		    
					
	</form>			
			
			
	</div>
	
	<div class="right_warp" id="div_detail" style="display:inline;">			
			
			<div class="table_warp">
				<span class="back_bg_t">&nbsp;</span>
				<div class="table_w_in">
				
					<h4 class="title01">
						<span class="txt">시료정보</span>
						<span id="div_sample" class="btn_r">
						<div type="button" id="btn_setRequest" class="btn btn-primary btn-normal" style="height:32px;padding:1px 24px 1px 24px !important; margin-right:8px; font-weight:700 !important; font-size:16px !important" onclick="javascript:actionPerformed('addSample');">
							시료선택
						</div>
							
							<%-- <a href="javascript:actionPerformed('addSample');"><img id="btn_addSample" src="<c:url value='/images/exam/btn/btn_sample01.gif'/>" alt="시료추가" style="border:0px;" /></a>
							<a href="javascript:actionPerformed('copySample');"><img id="btn_copySample" src="<c:url value='/images/exam/btn/btn_sample02.gif'/>" alt="시료복사" style="border:0px;"/></a>
							 --%>
						</span>
					</h4>
					<!-- table_bg -->
					<div class="table_bg" style="width:100%;height:100px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
						<table summary="시료정보" class="table_h" id="tbl_sample" name="tbl_sample">
							<colgroup>
							<col width="8%"/>
							<col width="40%"/>
							<col width="*"/>
							</colgroup>
							<tr>
								<th>순번</th>
								<th>시료명칭</th>
								<th>유종제품</th>
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
							<!-- 
							<a href="javascript: actionPerformed('insertItemsCopy')"><img id="btn_copyItems" src="<c:url value='/images/exam/btn/btn_article03.gif'/>" alt="항목복사"/></a>
							
							<a href="javascript: actionPerformed('deleteItemsCopy');"><img id="btn_delSameItems" src="<c:url value='/images/exam/btn/btn_article04.gif'/>" alt="동일항목 삭제"/></a>
							<a href="javascript: actionPerformed('updateItemsCopy');"><img id="btn_copySameItems" src="<c:url value='/images/exam/btn/btn_article05.gif'/>" alt="동일항목 속성일괄복사"/></a>
							 -->
							<a href="javascript: actionPerformed('saveItems');" class="last"><img id="btn_saveItems" src="<c:url value='/images/exam/btn/btn_save01.gif'/>" alt="저장" /></a>
						</span>
						
                        <span class="btn_r" style="width:400px;font-weight:200;font-size:12px;margin-top:8px;">
							<span style="float:left;margin-left:12px;width:30px;height:18px;background-color:#CCE0FF;border: 1px solid #B9B9B9"></span>
							<span style="float:left;padding-top:3px;padding-left:5px;"> : 신규 추가항목 표시</span>
						</span>
					</h4>
					<!-- table_bg -->
					<div id="div_items" name="div_items" class="table_bg" style="width:100%;height:550px; overflow:hidden;">
                    	<iframe id="ifrmResults" src="<c:url value='/support/testIframe.do'/>" style="width:100%; height:550px; padding:0px; border: 0px;" scrolling="no"></iframe>
					</div>
					<!-- //table_bg  -->
				</div>
				<!-- //table_w_in -->
				<span class="back_bg_b">&nbsp;</span>
			</div>
			<!-- //검사항목 -->
			
			<div style="float:left;width:80%;height:50px;border: 1px solid #BDD5E4; background:linear-gradient(#e0f0fc, #cae4f9);border-radius:2px;">
			    <div style="float:left;width:180px;margin:4px 0 0 0;"> 
			    	<p style="    text-align: center;
					    font-weight: 600;
					    margin: 6px;">
					    수수료 총액 (VAT 포함)</p>
			    	
			    	<p style="text-align:center;">기본료 : 10,000원</p>
			    </div>
			    <div style="float:left;margin:9px 6px;">
			    <p class="sum">
					<input type="text" id="totalprice" name="totalprice" value="" style="text-align: right;font-weight:700; width:480px;height:30px;border: 1px solid #CACDD0;"/>
				</p>
				</div>
			</div>
			<div type="button" id="btn_confirm" class="btn btn-primary btn-normal"
               style="height:38px;padding:8px 24px 1px 24px !important; margin-right:8px; font-weight:700 !important; font-size:16px !important; float:right"
               onclick="javascript:fnOpen();">
               	견적서 출력
          		</div>
			
			<!-- 시험자에게 남기는 글 
			<div class="say_talk">
				<textarea class="say_talk_text" id="itemdesc" name="tiemdesc"></textarea>
				<p class="sum">
					<input type="text" id="totalprice" name="totalprice" value="" style="text-align: right;font-weight:700;"/>
				</p>
			</div>
			-->
			<!-- //시험자에게 남기는 글 -->
			
<!-- 			<div style="width:100%;text-align: center;">
			<div type="button" id="btn_confirm" class="btn btn-primary btn-normal" style="height:38px;padding:8px 24px 1px 24px !important; margin-right:8px; font-weight:700 !important; font-size:16px !important" onclick="javascript:actionPerformed('requestConfirm');">
				접수 완료
			</div>
			  
			<div type="button" id="btn_reqList" class="btn btn-default btn-normal" style="height:27px;padding:2px 12px !important; margin-right:8px;" onclick="javascript:actionPerformed('reqList');">
				접수정보목록
			</div>
			
			</div> -->
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		</div>
		<!-- //right_warp(오른쪽 내용) -->


<!-- modal jsp include -->
<%@ include file="/WEB-INF/jsp/exam/support/testModal.jsp" %>




