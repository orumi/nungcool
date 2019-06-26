<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/additional-methods.js"></script>
<script>


	/* modal_zipcode */
	var dialog_zipcode, form_zipcode;


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
        
		/* zip code modal setting  */
		
		dialog_zipcode = $("#form_zipcode").dialog({
			autoOpen:false,
			width: 600,
			height: 700,
			modal: true,
			buttons:{
				"취소":function(){
					dialog_zipcode.dialog("close");
				}
			},
			close:function(){
				form_zipcode[0].reset();
			}
		});
		
		form_zipcode = dialog_zipcode.find("form").on("submit", function (event){
			event.preventDefault();
		})
		
		// open Modal Window
	    $( "#btn_zipcode" ).button().on( "click", function() {
	      	dialog_zipcode.dialog( "open" );
	      	zipcodeTarget = "company";
	      	zipTableInit();
	    });
		
		$("#btn_zipcode2").button().on("click", function(){
			dialog_zipcode.dialog( "open" );
	      	zipcodeTarget = "member";
	      	zipTableInit();
		});
		
		
		/* zipcode setting   */
		
		actionInitZipCode();

		
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


    /* ********************** setting Zipcode  **************************************** */
    var zipcodeTarget;
    
    function actionInitZipCode(){
    	actionAjaxZipcode({"formTag":"siguList"});
    }
    function actionSearchZipCode(){
    	var searchKey = $("#txtSearch").val();
    	if(searchKey==""){alert("검색할 주소를 입력하십시오."); return; }
    	
    	var pm = {"formTag":"zipcodeSearch", "sido":$("#cbLvl1").val(), "searchKey":$("#txtSearch").val(), "searchType":$("#searchType").val() };
    	
    	actionAjaxZipcode(pm);
    }
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
    
    function resultSiguList(list){
    	for(var i=0; i<list.length; i++){
    		$("#cbLvl1").append("<option value='"+list[i]["sidocode"]+"'>"+list[i]["sido"]+"</option>");
    	}
    }
    
    function zipTableInit(){
   		$("#tblList tr").each(function (){
            var row = $("#"+this.id);
            row.remove();
        });
    }
    
    function resultZipcodeList(data){
    	zipTableInit();
    	
    	var vCnt  = data["RESULT_CNT"];
    	if(vCnt == 0){
    		alert("검색 정보가 없습니다. ");
    		return;
    	} else if (vCnt > 150){
    		alert("검색정보가 많습니다. 세부적으로 검색바랍니다. ");
    	}
    	
    	vList = data["RESULT_LIST"];
    	
  		var tblHTML = "<table class='table_h'>";
  		for(var i=0; i<vList.length; i++){
  			tblHTML += "<tr id='tr_zip_"+vList[i]["rn"]+"' style='height:24px;'>";
  			tblHTML += "<td style='width:5%;text-align:center;'>"+vList[i]["rn"]+"</td>";
  			tblHTML += "<td style='width:15%;text-align:center;'>"+vList[i]["zipcode"]+"</td>";
  			tblHTML += "<td style='width:35%;'><a href='javascript:actionZipcodesend(\""+vList[i]["zipcode"]+"\",\""+vList[i]["roadnamefull"]+"\");'>"+vList[i]["roadnamefull"]+"</a></td>";
  			tblHTML += "</tr>";
  		}
  	
  		tblHTML += "</table>";
  		
  		$("#tblList").append(tblHTML);
    }
    
    function actionZipcodesend(zipcode, fullname){
    	if(zipcodeTarget == "company") {
    		$("#frmCompany #zipcode").val(zipcode);
    		$("#frmCompany #addr1").val(fullname);
    		$("#frmCompany #addr2").val("");
    		
    		
    		
    	} else if(zipcodeTarget == "member"){
    		$("#frmMember #zipcode").val(zipcode);
    		$("#frmMember #addr1").val(fullname);
    		$("#frmMember #addr2").val("");
    		
    	}
    	
    	dialog_zipcode.dialog("close");
    	
    	//alert(zipcode+"/"+fullname);
    }
    
    
    /* ********************** end of setting Zipcode  **************************************** */
    
    
    
    function actionPerformed(tag) {

        if (tag == "updateMember") {
        	if(confirm("회원정보를 수정하시겠습니까?")){
        		var frmData = JSON.stringify( $("#frmMember").serializeFormJSON() );
        		actionAjax({"formTag":"updateMember","frmData":frmData});
        	}
        	
        	/* 수정완료 처리 후   */
        	//window.location.href = "<c:url value='/login/loginProc.do?sub=support&menu=loginProc&loginTag=Y' />";	
        } else if (tag == "updateCompany") {
            if(confirm("업체정보를 수정하시겠습니까?")){
	        	var frmData = JSON.stringify( $("#frmCompany").serializeFormJSON() );
	        	actionAjax({"formTag":"updateCompany","frmData":frmData});
            }
        }

    }
    
    
	function actionAjax (pm){

		var url = "<c:url value='/login/memberProcService.json' />";
		
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
			        	resultMember(result["RESULT_MEMBER"][0]);
			        	
		        	} else {
		        		alert("해당하는 정보가 없습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm["formTag"]=="updateCompany"){
		        	
		        	if(result["RESULT_YN"] == "Y"){
		        		resultCompany(result["RESULT_COMPANY"][0]);
		        	} else {
		        		alert("처리중오류가 발생되었습니다. 운영자에게 문의바랍니다.");
		        	}
		        } else if(pm["formTag"]=="updateMember"){
		        	
		        	if(result["RESULT_YN"] == "Y"){
		        		//resultMember(result["RESULT_Member"][0]);
		        		window.location.href = "<c:url value='/setMain.do'/>";
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
	
    function resultMember(data){
		$("#frmMember input").each(function(i){
			var objName = this.name;
			
			if (objName){
				if(data[objName])
				var dataVal = data[objName]; //eval("data."+objName);
				if(dataVal){
					switch($(this).attr("type")) {
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
		
		$("#span_userid").html(data["memid"]);
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



    <!-- right_warp(오른쪽 내용) -->
    <div class="right_warp loginproc">
        <div class="title_route">
            <h3>회원정보</h3>

            <p class="route">
                <img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 고객지원 센터 <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>자기정보 수정</span>
            </p>
        </div>

<form id="frmCompany" name="frmCompany" action="<c:url value=''/>" method="post" class="formClass">
        <!-- 업체정보 -->
        <div>
        <h4 class="title01" style="display:table-cell">업체정보</h4>
        <span class="txt_color03" style="display:table-cell; padding-left:20px;margin-bottom:2px;">
        <img src="<c:url value='/images/exam/ico/ico06.gif'/>" alt=""/> 업체정보를 확인해 주세요. </span>
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


                    <tr>
                            <input id="mngname" name="mngname" type="text" value="" class="h30" style="width:198px; display: none;"/>
                            <input type="text" id="mngfax" name="mngfax" value="" class="h30" style="width:108px; display: none;" placeholder="020-0000-0000" />
                            <input type="text" id="mnghp" name="mnghp" value="" class="h30" style="width:108px; display: none;" placeholder="020-0000-0000" />
                            <input type="text" id="mngphone" name="mngphone" value="" class="h30" style="width:108px; display: none;" placeholder="020-0000-0000" />
                            <input id="mngdept" name="mngdept" type="text" value="" class="h30" style="width:198px; display: none;"/>
                            <input id="mngemail" name="mngemail" type="text" value="" class="h30" style="width:198px; display: none;"/>

                    </tr>
                    <tr>
                        <th rowspan="2" class="font13">업체주소</th>
                        <td class="" colspan="3" style="border-bottom:none; ">
                            <input id="zipcode" name="zipcode" type="text" value="" class="h30"
                                   style="width:60px;"/>
                            <a href="#"><img id="btn_zipcode" name="btn_zipcode" src="<c:url value='/images/exam/btn/btn_addr.gif'/>" alt="우편번호찾기" style="border:0px;"/></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="" colspan="3" style="padding-top:0">
                            <input id="addr1" name="addr1" type="text" value="" class="h30"
                                   style="width:357px;"/>&nbsp;
                            <input id="addr2" name="addr2" type="text" value="" class="h30"
                                   style="width:310px;"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="font13">영문업체명</th>
                        <td class=""><input id="ename" name="ename" type="text" value="업체명을 입력해 주세요"
                                            class="h30 txt_color02"
                                            style="width:198px;" onfocus="this.value=''"/></td>
                        <th class="font13">영문대표자명</th>
                        <td class=""><input id="eceoname" name="eceoname" type="text" value="" class="h30"
                                            style="width:198px;"/></td>
                    </tr>
                </table>
        </div>
        <!-- //업체정보 -->
</form>


	        <div style="text-align: center;">
                   <button id="btn_newid" name="btn_newid" class="btn"
                           onclick="actionPerformed('updateCompany');">업체정보 저장 
                   </button>
       	  	</div>
       	  	
<form id="frmMember" name="frmMember" action="<c:url value=''/>" method="post" class="formClass">
	<input type="hidden" name="memid" id="memid" >
	<input type="hidden" name="comid" id="comid" > 
        <!-- 사용자정보 -->
        <div>
        <h4 class="title01" style="display:table-cell">회원정보</h4>
        <span class="txt_color03" style="display:table-cell; padding-left:20px;margin-bottom:2px;">
        <img src="<c:url value='/images/exam/ico/ico06.gif'/>" alt=""/> 회원정보를 확인해 주세요. </span>
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
                    <th class="font13">로그인 아이디</th>
                    <td class="" colspan="3">
                        <span id="span_userid"></span>
                    </td>
                </tr>
                <tr>

                    <th class="font13">이름</th>
                    <td class=""><input id="name" name="name" type="text" value="" class="h30"
                                        style="width:198px;"/></td>

                    <th class="font13">소속부서</th>
                    <td class=""><input id="dept" name="dept" type="text" value="" class="h30"
                                        style="width:198px;"/></td>
                </tr>
                <tr>
                    <th class="font13">전화번호</th>
                    <td class="">
                            <input type="text" id="phone" name="phone" value="" class="h30" style="width:108px;" placeholder="010-0000-0000" />
							<div class="ex">

							</div> 
                    </td>
                    <th class="font13">휴대폰</th>
                    <td class="">
                            <input type="text" id="hp" name="hp" value="" class="h30" style="width:108px;" placeholder="010-0000-0000" />
							<div class="ex">

							</div> 
                    </td>
                </tr>
                <tr>
                    <th class="font13">팩스번호</th>
                    <td class="">
                            <input type="text" id="fax" name="fax" value="" class="h30" style="width:108px;" placeholder="010-0000-0000" />
							<div class="ex">

							</div> 
                    </td>
                    <th class="font13">이메일</th>
                    <td class="">
                        <input id="email" name="email" type="text" value="" class="h30" style="width:198px;"/>
                    </td>
                </tr>
                <tr>
                    <th rowspan="2" class="font13">주소</th>
                    <td class="" colspan="3" style="border-bottom:none; ">
                        <input id="zipcode" name="zipcode" type="text" value="" class="h30"
                               style="width:60px;"/>&nbsp;
                        <a href="#"><img id="btn_zipcode2" anme="btn_zipcode2" src="<c:url value='/images/exam/btn/btn_addr.gif'/>" alt="우편번호찾기" style="border:0px;"/></a>&nbsp;
                        <input id="sameAddr" type="checkbox"/> 업체주소와 동일
                    </td>
                </tr>
                <tr>
                    <td class="" colspan="3" style="padding-top:0">
                        <input id="addr1" name="addr1" type="text" value="" class="h30" style="width:357px;"/>&nbsp;
                        <input id="addr2" name="addr2" type="text" value="" class="h30" style="width:310px;"/>&nbsp;
                    </td>
                </tr>
            </table>
        </div>
</form>
       
        <div style="text-align: center;">
                   <button id="btn_newid" name="btn_newid" class="btn"
                           onclick="actionPerformed('updateMember');">회원정보 저장 
                   </button>
       	  	</div>
    </div>
    <!-- //right_warp(오른쪽 내용) -->














<!-- 우편번호 검색  -->
<div id="form_zipcode" title="우편번호 검색" style="    overflow: hidden;">
  <form>
    <fieldset>

	<!-- popup_In -->
	<div class="" style="width:100%;float:left;">
		<!-- popup_In_table -->
		
			<!-- popup -->
			<div class="" style="width:100%;border:0px;float:left;">
			 <h4 class="title01">도로명 주소 찾기</h4>
			 <!-- popup_In -->
			 <div class="popup_In" style="float:left;height:182px;">
			   
			     <div class="left_Box" style="float:left;   margin: 10px;" >
				     <div class="h5_title">
				      <h5>주소명 검색방법</h5>
				     </div>
					<div class="h_Table_line02"  style="float:left;width:100%; ">
						 <div class="top_Table_box" style="float:left;width:100%; overflow-x:hidden; overflow-y:hidden;"  >  
						 <table style="margin: 4px;">
						 <tr><td >
						 	1. 동 + 검물명 입력 : 예) '충무로1가(동명) 중앙우체국(건물명)'<br>
						 	2. 도로명 + 건물번호 입력 : 예)'소공로(도로명) 70(건물번호)'<br>
						 	3. 건물명 입력 : 예)'중앙우체국(건물명)'
						 </td></tr>
						 </table>
						 </div>
					</div>	 
				</div>
				   
			   <div class="search_Box" style="float:left;width:92%;margin-left:12px;margin-bottom: 12px;">
			    <table summary="검색" class="table01" >
			     <caption>검색</caption>
			     <colgroup>
			     <col width="80px"/>
			     <col width="*"/>
			     </colgroup>
			     <tr>
			      <th>시/도</th>
			      <td>
			       <select style="width:180px;"  name="cbLvl1" id="cbLvl1" onchange="">
			       </select>
			      </td>
			     </tr>
			     <tr><td style="height:3px;" colspan="4"></td></tr>
			     <tr>
			      <th>
					주소검색
			      </th>
			      <td  colspan="3">
			      	<select name="searchType" id="searchType" style="width:80px;">
			      		<option value="road">도로명</option>
			      		<option value="area">지번</option>
			      	</select>      
			       <input type="text" style="width:200px;"  name="txtSearch" id="txtSearch"  >
			      	<a href="#" onclick="actionSearchZipCode();" id="btnSearch" ><img src="<c:url value='/images/exam/btn/btn_inquiry01.gif'/>" alt="검색"  /></a>
			      </td>
			     </tr>     
			    </table>
			   </div>
			   
			
			
			    <div class="con_right_in" style="float:left; width:100%; ">
			
			

		
		    <!-- left_Box_top -->
		     <div class="left_Box" style="width:100%;" >
			     <!-- h5_title -->
			     <div class="h5_title">
			      <h5>주소목록</h5>
				      <div align="right" style="margin-right: 20px;margin-top:5px;">
				      		주소를 클릭하십시오.
				      </div>
			     </div>
		     <!-- //h5_title -->
		        
		        <!-- DataGrid 전체 DIV -->
				<div class="h_Table_line02"  style="width:100%;">
					 <div class="table_bg" style="width:100%; overflow-x:hidden; overflow-y:scroll;"  >      
					       <table summary="" class="table_h">
					        <thead id="tblHeader">
						        <tr>
						         <th style="width:5%"  dataField="rn" textAlign="center" >검색<br>순번</th>
						         <th style="width:15%" dataField="tblZipcode" textAlign="center" >우편번호</th>
						         <th style="width:35%"  dataField="tblRoadNameFull" textAlign="left" > 주소</th>
						        </tr>
					       	</thead>
					       </table>
					   </div>
					<!-- Grid List 전체 DIV width-2px  -->
		            <div class="bottom_T_box" id="tblList" style="width:100%;height:280px;overflow-x:hidden;overflow-y:scroll" onscroll="">
			            <table style="" class="table_h">
			                <tbody id="tblListbody"></tbody>    
			            </table>
		            </div>
		            <div style="margin-top: 7px;">
		            <!-- 
		            	<div id="paging"><strong>[</strong> 전체수:  0,  전체페이지 : 0,  현재페이지 : 0 <strong>]</strong> </div>
		             -->	
		            </div>            
				</div>
		    
		    
		    </div>
		    <!-- left_Box_top -->
		
		     </div>
		  </div>
		  <!-- //con_right -->
		 </div>
		 <!-- //container -->
 
 
 
			<!-- //table_bg  -->
		<!-- //popup_In_table -->
	</div>
	<!-- //popup_In -->
	
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>


