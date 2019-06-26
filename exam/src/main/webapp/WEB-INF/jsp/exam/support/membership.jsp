<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/additional-methods.js"></script>
<script>


    $(function () {
        /* jquery init condition */
        $("button").button().click(function (event) {
            event.preventDefault();
        });

        actionAjax({ "formTag":"selectMembershipInfo"  });
        
        

        $("#issueDate1").datepicker({
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage: "<c:url value='/images/calendar.gif'/>",
            buttonImageOnly: true,
            buttonText: "일자선택",
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            onClose: function (selectedDate) {
                //$("#issueDate2").datepicker("option", "minDate", selectedDate);
            	$("#issueDate2").datepicker("setDate", $("#issueDate1").val() );
            	$("#issueDate2").datepicker("setDate", "c+1y" );
            	$("#issueDate2").datepicker("setDate", "c+1d" );
            }
        });

        $("#issueDate2").datepicker({
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage: "<c:url value='/images/calendar.gif'/>",
            buttonImageOnly: true,
            buttonText: "일자선택",
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            onClose: function (selectedDate) {
                //$("#issueDate1").datepicker("option", "maxDate", selectedDate);
            	$("#issueDate1").datepicker("setDate", $("#issueDate2").val() );
            	$("#issueDate1").datepicker("setDate", "c-1y" );
            	$("#issueDate1").datepicker("setDate", "c-1d" );
                
            }
        });
        
        
        /* set mask  */
/*		$("#mngphone").mask("999-9999-9999");
		$("#mnghp").mask("999-9999-9999");
		$("#mngfax").mask("999-9999-9999");
		$("#phone").mask("999-9999-9999");
		$("#hp").mask("999-9999-9999");
		$("#fax").mask("999-9999-9999");*/
        
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
    });


    
    function actionPerformed(tag) {

        if (tag == "updateMembership") {
        	
        	if($("#issueDate1").val()=="" || $("#issueDate2").val()==""){
        		alert("신청기간을 선택하십시오.");
        		return;
        	}
        	
        	
        	if(confirm("연회비회원으로 신청하시겠습니까?")){
        		
        		var sDate = $("#issueDate1").val();
        		var eDate = $("#issueDate2").val();
        		var tag   = $("#tag").val();
        		actionAjax({"formTag":"updateMembership", "sDate":sDate, "eDate":eDate, "tag":tag });
        	}
        	
        } else if (tag == "updateCompany") {
            if(confirm("업체정보를 수정하시겠습니까?")){
	        	var frmData = JSON.stringify( $("#frmCompany").serializeFormJSON() );
	        	actionAjax({"formTag":"updateCompany","frmData":frmData});
            }
        }

    }
    
    
	function actionAjax (pm){

		var url = "<c:url value='/member/actionMembership.json' />";
		
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
		    	
		        if(pm["formTag"]=="selectMembershipInfo"){
		        	
		        	if(result["RESULT_YN"]=="Y" ){
		        		
		        		// 정보 가져오기 
			        	resultCompany(result["RESULT_COMPANY"][0]);
			        	
		        		resultMembership(result["RESULT_MEMBERSHIP"][0]);
			        	
		        	} else {
		        		alert("해당하는 정보가 없습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm["formTag"]=="updateCompany"){
		        	
		        	if(result["RESULT_YN"] == "Y"){
		        		resultCompany(result["RESULT_COMPANY"][0]);
		        	} else {
		        		alert("처리중오류가 발생되었습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm["formTag"]=="updateMembership"){
		        	
		        	if(result["RESULT_YN"] == "Y"){
		        		//resultMember(result["RESULT_Member"][0]);
		        		alert("회원신청이 완료 되었습니다. ");
		        		resultMembership(result["RESULT_MEMBERSHIP"][0]);
		        	} else {
		        		alert("처리중오류가 발생되었습니다. 운영자에게 문의바랍니다.");
		        	}
		        }
		    },
		    error:function(request,status,error){
		    	alert("Error : "+error);
		    	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    },
		    complete: function (data) {
		      	//gridView.hideToast();
		    },
		   
		});
	}    
    
    function resultCompany(data){
    	
		$("#frmCompany input").each(function(i){
			var objName = this.name;
			
			if (objName){
				if(data[objName])
				var dataVal = data[objName]; //eval("data."+objName);
				if(dataVal){
					switch($(this).attr("type")){
					case "text":
						this.value = dataVal;
					case "hidden":
						this.value = dataVal;
					case "checkbox":
						;
					case "radio":
						;
					case "select":
						;
					default:
						break;
					}
				} else {
					switch($(this).attr("type")){
					case "text":
						this.value = "";
					default:
						break;
					}
				}
			}
		});
		
    }
	
    function resultMembership(data){
		//alert(data.startdate);
		
		$("#ecdiv").val(data.ecdiv);
		$("#ecstat").val(data.ecstat);
		
		$("#issueDate1").val(data.startdate);
		$("#issueDate2").val(data.enddate);
		
		$("#mshipid").text(data.mshipid);
		
		if(data.comid){
			$("#tag").val("U");
			
		}
		
		
		
		if(data.divtag == "1"){

			$("#btn_newid").css("display","none");
			$("#btn_update").css("display","none");
			$("#div_text").text(" ");
		} else if (data.divtag == "-1"){
			$("#btn_newid").css("display","none");
			$("#btn_update").css("display","inline");
			$("#div_text").text(" ");
		} else if (data.divtag == "2"){
			// 기간 만료
			$("#btn_newid").css("display","inline");
			$("#btn_update").css("display","none");
			
			$("#div_text").text("※ 기간 만료");
		}
		
		
    }

    

    function checkCompRegiTriger(commander) {

        var searchKeyword;
        if (commander == "regiCheck") {
            searchKeyword = $("#compName").val();
        } else if (commander == "regiCheck2") {
            searchKeyword = $("#searchKeyword").val();
        }
        checkCompRegi(searchKeyword);
    }

    function checkCompRegi(searchKeyword) {

        $.ajax({
            type: "POST",
            url: "<c:url value= '/member/checkCompRegi.json'/>",
            data: {"data": searchKeyword},
            dataType: "JSON",
            success: function (data) {

                injectDataToModal(data);
                dialog_company.dialog("open");

            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
            }
        });
    }

    function bisNumCheck() {

        var bisNum1 = $("#bisNum1").val();
        var bisNum2 = $("#bisNum2").val();
        var bisNum3 = $("#bisNum3").val();

        var bisNum = bisNum1 + bisNum2 + bisNum3;

        $.ajax({
            type: "POST",
            url: "<c:url value= '/member/bisNumCheck.json'/>",
            data: {"data": bisNum},
            dataType: "JSON",
            success: function (data) {
                alert(data);
            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
            }
        });
    }

    function injectDataToModal(data) {

        $("#output").find("tr:not(:first)").each(function () {
            this.remove();
        });

        var output = "";

        $(data).each(function (index, item) {
            output += "<tr>";
            output += "<td>" + item.compName + "</td>";
            output += "<td>" + item.bisNum + "</td>";
            output += "<td>" + item.ceoNm + "</td>";
            output += "<td>" + item.compAddr1 + "</td>";
            output += "<td class='txt_C'><a href='javascript:choiceCompany(\"" + item.compName + "///" + item.comId + "\");'><img src='' alt='선택'/></a></td>";
            output += "<tr>";
        });
        $('#output').append(output);
    }

    function choiceCompany(text) {

        var strArr = text.split("///");
        var compName = strArr[0];
        var comId = strArr[1];

        $("#comId").val(comId);
        $("#compName").val(compName);

        //숨김 종합 선물 세트 Start
        dialog_company.dialog("close");
        $("#btn_openCompanyDetail").hide();
        $("#regiCheckBtn").hide();
        actionPerformed("closeCompanyDetail");
        // 숨김 종합 선물 세트 End
    }

    function idValidation() {

        var userId = $("#userId").val();

        if (userId == "" || userId == " " || userId == "  ") {
            alert("아이디를 옳바로 입력해 주세요.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "<c:url value= '/member/idValidation.json'/>",
            data: {"data": userId},
            dataType: "JSON",
            success: function (data) {
                alert(data);
            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
            }
        });
    }

    function compValidation() {
        if ($("#compName").val() == "") {
            alert("업체명은 필수값 입니다.");
            return false;
        } else if ($("#bisNum1").val() == "" || $("#bisNum2").val() == "" || $("#bisNum3").val() == "") {
            alert("사업자 등록번호는 필수값 입니다.");
            return false;
        } else if ($("#bisType1").val() == "" || $("#bisType2").val() == "") {
            alert("사업유형은 필수값 입니다.");
            return false;
        } else if ($("#ceoNm").val() == "") {
            alert("대표자명은 필수값 입니다.");
            return false;
        } else if ($("#compTelNum1").val() == "" || $("#compTelNum2").val() == "" || $("#compTelNum3").val() == "") {
            alert("대표 전화번호는 필수값 입니다.");
            return false;
        } else if ($("#mngNm").val() == "") {
            alert("담당자명은 필수값 입니다.");
            return false;
        } else if ($("#mngPhone1").val() == "" || $("#mngPhone2").val() == "" || $("#mngPhone3").val() == "") {
            alert("담당자 전화번호는 필수값 입니다.");
            return false;
        } else if ($("#compFaxNum1").val() == "" || $("#compFaxNum2").val() == "" || $("#compFaxNum3").val() == "") {
            alert("대표 팩스번호는 필수값 입니다.");
            return false;
        } else if ($("#mngEmail").val() == "") {
            alert("담당자 email은 필수값 입니다.");
            return false;
        } else if ($("#mngDept").val() == "") {
            alert("담당자 부서는 필수값 입니다.");
            return false;
        }
        return true;
    }

    function userValidation() {

        if ($("#userId").val() == "") {
            alert("유저 아이디는 필수값 입니다.");
        }
        if ($("#userId").val().length < 3) {
            alert("유저 아이디는 3글자 이상이어야 합니다.");
        }

    }

    function finallyJoinMember() {

        var form = $("#form_joinMember");
        form.submit();
    }

    $(function () {
        $("form").validate({

            submitHandler: function () {
                var f = confirm("회원가입을 완료 하시겠습니까?");
                if (f) {
                    return true;
                }
                else {
                    return false;
                }
            },

            rules: {
                bisNum1: {
                    required: true
                }
            }
        })
    })


</script>

<style>

    /* datepicker css  */

    .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
        border: 1px solid #37A3D0;
        background: #71B9D7;
        font-weight: normal;
        color: #fff !important;
    }

    .ui-state-default:HOVER, .ui-widget-content .ui-state-default:HOVER, .ui-widget-header .ui-state-default:HOVER {
        border: 1px solid #227BB3;
        background: #4B93C0;
        font-weight: normal;
        color: #fff !important;
    }

    .ui-datepicker-trigger {
        cursor: pointer;
        border: 1px solid #C7C7C7;
        padding: 4px;
        border-left: none;
    }

</style>


    <!-- right_warp(오른쪽 내용) -->
    <div class="right_warp loginproc">
        <div class="title_route">
            <h3>연회비회원</h3>

            <p class="route">
                <img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 고객지원 센터 <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>연회비회원</span>
            </p>
        </div>

<form id="frmCompany" name="frmCompany" action="<c:url value=''/>" method="post" class="formClass">
        <!-- 업체정보 -->
        <div>
        <h4 class="title01" style="display:table-cell">업체정보</h4>
        </div>
        <!-- 업체정보 디폴트 값들-->
        <input id="comid" name="comid" type="hidden"/>


        <div class="table_bg m_B27">
            <table summary="업체정보" class="table_w">
                    <colgroup>
                        <col width="130px"/>
                        <col width="310px"/>
                        <col width="130px"/>
                        <col width="*"/>
                    </colgroup>
                <tr>
                    <th class="font13">업체명</th>
                    <td class="">
                        <input id="comname" name="comname" type="text" value="" class="h30 txt_color02"
                               style="width:198px;" onfocus="this.value=''"/>&nbsp;
                       
                    </td>
                     <th class="font13">사업자등록번호</th>
                     <td class="">
                         <div style="float: left">
                             <input id="bizno" name="bizno" type="text" value="" class="h30"
                                    style="width:98px;" maxlength="10"/>
                         </div>
                       
                     </td>
                </tr>
                    <tr>
                        <th class="font13" style="">대표자명</th>
                        <td class="" style=""><input id="ceoname" name="ceoname" type="text" value=""
                                                                        class="h30"
                                                                        style="width:198px;"/></td>
                        <th class="font13">업태</th>
                        <td class="">
                            <input id="biztype" name="biztype" type="text" value="" class="h30" style="width:198px;"/>&nbsp;
                        </td>
                    </tr>



                </table>
        </div>
        <!-- //업체정보 -->
</form>


	        <div style="text-align: center;">

       	  	</div>
       	  	
<form id="frmMembership" name="frmMembership" action="<c:url value=''/>" method="post" class="formClass">
	<input type="hidden" name="memid" id="memid" >
	<input type="hidden" name="comid" id="comid" >
	<input type="hidden" name="tag" id="tag" value="N"> 
        <!-- 사용자정보 -->
        <div>
        <h4 class="title01" style="display:table-cell">연회비 정보</h4>
        </div>
        
        <!-- 사용자 디폴트 값들 -->

        <div class="table_bg m_B10">
            <table summary="사용자정보" class="table_w">
                <colgroup>
                    <col width="130px"/>
                    <col width="310px"/>
                    <col width="130px"/>
                    <col width="*"/>
                </colgroup>
                
                <tr>

                    <th class="font13">회원구분</th>
                    <td class="">
	                    <select style="width:160px;height:24px;" id="ecdiv" name="ecdiv">
	                    	<option value="0">일반회원</option>
	                    	<option value="-1">신청중</option>
	                    	<option value="2">연회원</option>
	                    </select>
                    
                    </td>

                    <th class="font13">진행상태</th>
                    <td class="">
                    	<select style="width:160px;height:24px;" id="ecstat" name="ecstat">
	                    	<option value="-1">-</option>
	                    	<option value="0">신청</option>
	                    	<option value="1">승인</option>
	                    </select>
                    </td>
                </tr>
                <tr>
                    <th class="font13">회원번호</th>
                    <td class="">
							<div style="width:100%;float:left;" id="mshipid" name="mshipid">
							
							</div> 
                    </td>
                    <th class="font13">회원제 기간</th>
                    <td class="">
                        <input type="text" id="issueDate1" name="issueDate1" value="" class="h30"
                               style="width:90px;"/>
                        ~
                        <input type="text" id="issueDate2" name="issueDate2" value="" class="h30"
                               style="width:90px;"/>
                    </td>
                </tr>

            </table>
        </div>
</form>
       
        <div style="float:left;width:60%;">
                   <div style="float:right">
                   <button id="btn_newid" name="btn_newid" class="btn" style="display: inline;"
                           onclick="actionPerformed('updateMembership');">연회비회원 신청
                   </button>
                   
                   <button id="btn_update" name="btn_update" class="btn" style="display: none;"
                           onclick="actionPerformed('updateMembership');">연회비회원 수정
                   </button>
                   </div>
                  
                  <div id="div_text" 
                  style="    float: right;
    font-weight: 600;
    padding-top: 9px;
    padding-right: 20px;
    color: #5F5F5F;"
                  ></div>
                   
                   
       	  	</div>
    </div>
    <!-- //right_warp(오른쪽 내용) -->













