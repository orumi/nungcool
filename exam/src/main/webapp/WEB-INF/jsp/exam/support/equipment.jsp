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

        actionAjax({ "formTag":"selectInfo"  });
        
        

		
        
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
		    	
		        if(pm["formTag"]=="selectInfo"){
		        	
		        	if(result["RESULT_YN"]=="Y" ){
		        		
		        		// 정보 가져오기 
			        	resultCompany(result["RESULT_COMPANY"][0]);
			        	
		        		resultEquipList(result["RESULT_EQUIPREQLIST"]);
		        		//resultMembership(result["RESULT_MEMBERSHIP"][0]);
			        	
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
    
	function resultEquipList(rst){
		/* reset table   */
        $("#tbl_equipList").find("tr:not(:first)").each(function () {
            this.remove();
        });

        var tbl_row = "";
		
        $( rst ).each(function (index, obj) {
        	tbl_row += "<tr  id=\"tr_equip_"+obj.equipreqid+"\">";
        	tbl_row += "<td class=\"txt_C\">" + obj.acceptno + "</td>";
        	tbl_row += "<td class=\"txt_C\">" + obj.memname + "</td>";
        	tbl_row += "<td class=\"txt_L\">" + obj.equipnames + "</td>";
        	tbl_row += "<td class=\"txt_C\">" + obj.startdate + "</td>";
        	tbl_row += "<td class=\"txt_C\">" + obj.enddate + "</td>";
        	tbl_row += "<td class=\"txt_R\">" + obj.totreqpay + "</td>";
        	if(obj.state == 2){
        		if(obj.pricetype > 0){
        			tbl_row += "<td class=\"txt_C\">결제완료</td>";
        		} else {
        			tbl_row += "<td class=\"txt_C\"><input type=\"checkbox\" id=\"chk_card\" name=\"chk_card\" value=\""+obj.equipreqid+"\")></td>";
        		}
        	} else {
        		tbl_row += "<td class=\"txt_C\">" + obj.statename + "</td>";
        	}
        	tbl_row += "<td class=\"txt_C\"><a href='javascript:actionClickEquip(\""+obj.equipreqid+"\")'>" + "<img src='<c:url value='/images/exam/btn/btn03.gif'/>' alt='상세보기'/>" + "</a></td>";
        	tbl_row += "<tr>";
        });
        
        $('#tbl_equipList').append(tbl_row);
	}
	
	function actionClickCalc(equipreqid){
		
		alert("결재");
		
	}
	
	function actionClickEquip(equipreqid){
		 
		window.location.href = "/exam/member/equipmentDetail.do?sub=support&menu=equipment&equipreqid="+equipreqid;
		//alert(equipreqid);
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
		
		$("#div").val(data.div);
		$("#state").val(data.state);
		
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


    
    function actionDetail(){
    	 window.location.href = "/exam/member/equipmentDetail.do?sub=support&menu=equipment";
    }	
    
    
    
    var openINIpay ;
    function actionCard(){
    	
    	var chks = "";
    	$("input[name=chk_card]:checkbox").each(function(i){
    		if($(this).prop("checked")){
    			chks += "|"+$(this).val();
    		}
    	})
    	var selchk = chks;
    	
    	if(chks == ""){
    		alert("결제하려고 하는 정보를 선택하십시오.");
    		return;
    	}
    	
    	if(openINIpay) openINIpay.close();
    	openINIpay = window.open( "<c:url value='/INIpay/INIpaystartEquip.jsp?'/>selchk="+selchk,"new","left=300, top=300, width=800, height=600, toolbar=no, location=yes, directories=no, status=no, menubar=no, scrollbars=yes, copyhistory=yes, resizable=no");
    	openINIpay.focus();
    }
    
    
    
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
                <img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> 
                <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 고객지원 센터 
                <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>연회비회원</span>
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
       	  	
<form id="frmEquipment" name="frmEquipment" action="<c:url value=''/>" method="post" class="formClass">
	<input type="hidden" name="memid" id="memid" >
	<input type="hidden" name="comid" id="comid" >
	<input type="hidden" name="tag" id="tag" value="N"> 
        <!-- 사용자정보 -->
        <div style="width:100%; clear:both;">
	        <h4 class="title01" style="float:left; display:table-cell">연회비 정보
		    </h4>
		    <div type="button" class="btn btn-primary" style="float:right;height:17px;font-size:13px;padding:3px 6px !important;margin:0px;" onclick="javascript:actionCard();">
					카드결제
		    </div>
        </div>
        
        <!-- 사용자 디폴트 값들 -->

        <div class="table_bg m_B10" style="float:right;width:100%">
            <table summary="사용자정보" class="table_w" id="tbl_equipList" name="tbl_equipList">
                <colgroup>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="20%"/>
                    <col width="15%"/>
                    <col width="15%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                </colgroup>
                
                <tr>
					<th class="font13">계량번호</th>
                    <th class="font13">신청자</th>
                    <th class="font13">설비명</th>
                    <th class="font13">계량시작일</th>
                    <th class="font13">계약종료일</th>
                    <th class="font13">계약금액</th>
                    <th class="font13">진행상태</th>
                    <th class="font13">상세보기</th>
                </tr>

            </table>
        </div>
</form>
       
        <div style="height:50px;float:left;width:100%;text-align: center;">
                   <div >
                   <button id="btn_newid" name="btn_newid" class="btn" style="display: inline;"
                   onclick="javascript:actionDetail();"
                   >설비계약신청
                   </button>
                   
                   
                   </div>
                  
       </div>
    <!-- //right_warp(오른쪽 내용) -->













