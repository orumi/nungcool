<%@page import="exam.com.common.StringUtils"%>
<%@page import="exam.com.main.model.LoginPersonUserVO"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/additional-methods.js"></script>

<%
	LoginPersonUserVO loginPersonUserVO = (LoginPersonUserVO) request.getSession().getAttribute("loginPersonUserVO");
	
	String username = "";
	String userid = "";
	String dept = "";
	String phone = "";
	String hp = "";
	String fax = "";
	String email = "";
	String zipcode = "";
	String addr1 = "";
	String addr2 = "";
	
	if(loginPersonUserVO == null){
		%>
		 	<script>
		 		alert("로그인 정보가 없습니다. 다시 접속바랍니다. ");
		 		history.back();
		 	</script>
		<%
		
		return ;
	} else {
		username = loginPersonUserVO.getName();
		userid = loginPersonUserVO.getMemid();
		
		dept =  StringUtils.nvl(loginPersonUserVO.getDept(),"");
		phone = StringUtils.nvl(loginPersonUserVO.getPhone(),"");
		hp =    StringUtils.nvl(loginPersonUserVO.getHp(),"");
		fax =   StringUtils.nvl(loginPersonUserVO.getFax(),"");
		email = StringUtils.nvl(loginPersonUserVO.getEmail(),"");
		zipcode = StringUtils.nvl(loginPersonUserVO.getZipcode(),"");
		addr1 = StringUtils.nvl(loginPersonUserVO.getAddr1(),"");
		addr2 = StringUtils.nvl(loginPersonUserVO.getAddr2(),"");
	}
	
%>

<style>
    ::-webkit-input-placeholder {
        /* WebKit browsers */
        color: #aaa;
        font-size: 12px;
    }

    :-moz-placeholder {
        /* Mozilla Firefox 4 to 18 */
        color: #aaa;
        font-size: 12px;
    }

    ::-moz-placeholder {
        /* Mozilla Firefox 19+ */
        color: #aaa;
        font-size: 12px;
    }

    :-ms-input-placeholder {
        /* Internet Explorer 10+ */
        color: #aaa;
        font-size: 12px;
    }
</style>


<script>

    var dialog_company, form_company;

    $(function () {
        /* jquery init condition */
        $("button").button().click(function (event) {
            event.preventDefault();
        });

        $("#radio").buttonset();

        /* add Items modal */
        dialog_company = $("#form_company").dialog({
            autoOpen: false,
            width: 750,
            height: 500,
            modal: true,
            buttons: {
                "취소": function () {
                    dialog_company.dialog("close");
                }
            },
            close: function () {
                //form_addItems[0].reset();
            }
        });

        form_company = dialog_company.find("form").on("submit", function (event) {
            event.preventDefault();
        });

        // open Modal Window
        /*	    $( "#btn_insertCompany" ).button().on( "click", function() {
         dialog_company.dialog( "open" );

         //select items
         //$("#btn_select_items").click();
         });*/


        $("button").button().click(function (event) {
            event.preventDefault();
        });
        $("#sameAddr").click(sameAddr);

        /* zip code modal setting  */

        dialog_zipcode = $("#form_zipcode").dialog({
            autoOpen: false,
            width: 600,
            height: 700,
            modal: true,
            buttons: {
                "취소": function () {
                    dialog_zipcode.dialog("close");
                }
            },
            close: function () {
                form_zipcode[0].reset();
            }
        });

        form_zipcode = dialog_zipcode.find("form").on("submit", function (event) {
            event.preventDefault();
        });

        // open Modal Window
        $("#btn_zipcode1").button().on("click", function () {
            dialog_zipcode.dialog("open");
            zipcodeTarget = "receive";
            zipTableInit();
        });

        $("#btn_zipcode2").button().on("click", function () {
            dialog_zipcode.dialog("open");
            zipcodeTarget = "tax";
            zipTableInit();
        });


        /*         $("#bisNum").mask("999-99-99999");
         $("#compTelNum").mask("999-9999-9999");
         $("#teleNum").mask("999-9999-9999");
         $("#mobile").mask("999-9999-9999");
         $("#faxNum").mask("999-9999-9999");*/

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

    $(function () {
        //$("#bisNumCheck").click(bisNumCheck);
        
        
    });


    function actionPerformed(tag) {

        if (tag == "openCompanyDetail") {
            $("#div_companyDetail").css("display", "block");
            $("#compName").val("");
            $("#comId").val("");
            $("#bisNum").val("");
            $("#bisType").val("");
            $("#ceoNm").val("");
            $("#compTelNum").val("");
            $("#compAddrNum").val("");
            $("#compAddr1").val("");
            $("#compAddr2").val("");
            $("#compEnNm").val("");
            $("#ceoEnNm").val("");
            $("#newRegi").val("notNull");
            $("#busiRegedInfo").css("display", "none");
            $("#busiRegedInfo2").css("display", "none");
            $("#busiRegedInfo3").css("display", "block");


        } else if (tag == "closeCompanyDetail") {
            $("#div_companyDetail").css("display", "none");
        } else if (tag == "updateMember"){
        	
        	if(checkValidate()){
        		if(confirm("회원정보를 저장하시겠습니까?")){
        			var frmData = JSON.stringify( $("#frmMember").serializeFormJSON() );
            		actionAjax({"formTag":"updateMember","frmData":frmData});
        		}
        	}
        	
        }

    }
 	
    
    
    
	function actionAjax (pm){

		var url = "<c:url value='/login/personProcService.do' />";
		//pm = {"formTag":"updateMember","frmData":"{comId:20130214150631}"} ;
		
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
		    	
		        if(pm["formTag"]=="updateMember"){
		        	
		        	if(result["RESULT_YN"] == "Y"){
		        		//resultMember(result["RESULT_Member"][0]);
		        		
		        		alert("정상적으로 등록되었습니다. 다시 로그인 바랍니다.");
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
	
	function checkValidateCom(){
		if($("#compName").val()=="") {
    		alert("업체명 정보를 입력하십시오.");
    		return false;
    	}
		
		if($("#bisNum").val()=="") {
    		alert("사업자번호 정보를 입력하십시오.");
    		return false;
    	}
		
		if($("#bisType").val()=="") {
    		alert("사업유형 정보를 입력하십시오.");
    		return false;
    	}
		
		if($("#ceoNm").val()=="") {
    		alert("대표자명 정보를 입력하십시오.");
    		return false;
    	}
		
		if($("#compTelNum").val()=="") {
    		alert("대표 전화번호 정보를 입력하십시오.");
    		return false;
    	}
		
		if($("#compAddrNum").val()=="" || $("#compAddr1").val()=="" || $("#compAddr2").val()=="") {
    		alert("업체주소 정보를 입력하십시오.");
    		return false;
    	}
		
		if($("#compEnNm").val()=="") {
    		alert("영문업체명 정보를 입력하십시오.");
    		return false;
    	}
		
		if($("#ceoEnNm").val()=="") {
    		alert("영문대표자명 정보를 입력하십시오.");
    		return false;
    	}
		
		return true;
	}
	
    function checkValidate(){
    	if($("#comId").val()==""){
    		if(checkValidateCom()){
    			// ok
    		} else {
    			alert("업체를 선택하시거나 신규등록 바랍니다.");
    			return;
    		}
    	}
    	
    	
    	
    	
    	if($("#dept").val()=="") {
    		alert("담당부서 정보를 입력하십시오.");
    		return false;
    	}
    	
    	if($("#phone").val()=="") {
    		alert("전화번호 정보를 입력하십시오.");
    		return false;
    	}
    	
    	if($("#hp").val()=="") {
    		alert("휴대폰 정보를 입력하십시오.");
    		return false;
    	}
    	
    	if($("#fax").val()=="") {
    		alert("팩스번호 정보를 입력하십시오.");
    		return false;
    	}
    	if($("#email").val()=="") {
    		alert("이메일 정보를 입력하십시오.");
    		return false;
    	}
    	if($("#userZipcode").val()=="" || $("#userAddr1").val()=="" || $("#userAddr2").val()=="" ) {
    		alert("사용자주소 정보를 입력하십시오.");
    		return false;
    	}
    	
    	return true;
    }
    
    
    function checkCompRegiTriger(commander) {
        var searchKeyword;
        if (commander == "regiCheck") {
            searchKeyword = $("#compName").val();
            if (searchKeyword == "") {
                alert("업체명에 확인 하실 회사 이름을 기입하세요.");
            } else {
                checkCompRegi(searchKeyword);
            }

        } else if (commander == "regiCheck2") {
            searchKeyword = $("#searchKeyword").val();
            checkCompRegi(searchKeyword);
        }
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

        var bisNum = $("#bisNum").val();

        $.ajax({
            type: "POST",
            url: "<c:url value= '/login/personProcService.do'/>",
            data: {"formTag":"checkBizNum", "bizNum": bisNum},
            dataType: "JSON",
            success: function (data) {
            	resultCheckBizNum(data);
            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
            }
        });
    }

    function resultCheckBizNum(data){
    	var comVO = data.RESULT_COMPANY;
    	if(comVO.length==0){
    		alert("등록되지 않은 번호입니다. 사용가능합니다.");
    	} else {
    		alert("'"+comVO[0].comname+"'으로 등록되어 있습니다.");
    	}
    }
    
    function injectDataToModal(data) {
        $("#output").find("tr:not(:first)").each(function () {
            $(this).remove();
        });

        var output = "";

        $(data).each(function (index, item) {

            output += "<tr>";
            output += "<td>" + item.compName + "</td>";
            output += "<td>" + item.bisNum + "</td>";
            output += "<td>" + item.ceoNm + "</td>";
            output += "<td>" + item.compAddr1 + "</td>";
            output += "<td class='txt_C'><button onclick='javascript:choiceCompany(\"" + item.compName + "///" + item.comId + "///" + item.compAddrNum + "///" + item.compAddr1 + "///" + item.compAddr2 + "\");'>선택</button></td>";
            output += "<tr>";

        });

        $('#output').append(output);

    }

    function choiceCompany(text) {

        var strArr = text.split("///");
        var compName = strArr[0];
        var comId = strArr[1];
        var compAddrNum = strArr[2];
        var compAddr1 = strArr[3];
        var compAddr2 = strArr[4];

        $("#comId").val(comId);
        $("#compName").val(compName);

        //숨김 종합 선물 세트 Start
        dialog_company.dialog("close");
        actionPerformed("closeCompanyDetail");
        // 숨김 종합 선물 세트 End
        $("#newRegi").val("")
        $("#bisNum").val("registered");
        $("#bisType").val("registered");
        $("#ceoNm").val("registered");
        $("#compTelNum").val("registered");
        $("#compAddrNum").val(compAddrNum);
        $("#compAddr1").val(compAddr1);
        compAddr2 != 'null' ? $("#compAddr2").val(compAddr2) : $("#compAddr2").val("기입안됨");
        $("#compEnNm").val("registered");
        $("#ceoEnNm").val("registered");

        $("#busiRegedInfo").css("display", "none");
        $("#busiRegedInfo3").css("display", "none");
        $("#busiRegedInfo2").css("display", "block");

    }

    function idValidation() {

        var userId = $("#userId").val();

        if (userId == "" || userId == " " || userId == "  ") {
            alert("아이디를 옳바로 입력해 주세요.");
        } else {
            $.ajax({
                type: "POST",
                url: "<c:url value= '/member/idValidation.json'/>",
                data: {"userId": userId},
                dataType: "JSON",
                success: function (data) {
                    if (data.id == "true") {
                        alert("사용 가능한 아이디 입니다.")
                    } else {
                        alert("중복 된 아이디 입니다.");
                    }
                    ;
                },
                error: function (xhr, status, error, data) {
                    alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
                }
            });
        }
    }


    function sameAddr() {

        if ($(this).is(":checked") == true) {
            $("#userZipcode").val($("#compAddrNum").val());
            $("#userAddr1").val($("#compAddr1").val());
            $("#userAddr2").val($("#compAddr2").val());
        } else {
            $("#userZipcode").val("");
            $("#userAddr1").val("");
            $("#userAddr2").val("");
        }

    }

    $.validator.addMethod("alphanumeric", function (value, element) {
        return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
    });


    function finallyJoinMember() {

        var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}$/;
        var pw = $("#psword").val();

        if (($("#newRegi").val() == "") && ($("#comId").val() == "")) {
            alert("업체정보를 정확히 입력하여 주세요");
        } else {
            if (!check.test(pw)) {
                alert("중요: 비밀번호는 글자와 숫자 그리고 특수문자의 혼합형태여야 합니다.");
            } else {
                if (pw.length < 6 || pw.length > 16) {
                    alert("중요: 비밀번호는 6자이상 16자 이하 이어야 합니다.");
                } else {
                    var userId = $("#userId").val();
                    var mobile = $("#mobile").val();
                    var email = $("#email").val();
                    $.ajax({
                        type: "POST",
                        url: "<c:url value= '/member/idValidation.json'/>",
                        data: {"userId": userId, "mobile": mobile, "email": email},
                        dataType: "JSON",
                        success: function (data) {

                            if (data.id == "true") {
                                if (data.email == "true") {
                                    if (data.phone == "true") {
                                        // 드디어 전송
                                        var form = $("#form_joinMember");
                                        form.submit();
                                        // 이게 가장 마지막 final.. 시벌것..

                                    } else if (data.phone == "false") {
                                        alert("중복 된 휴대폰 번호를 사용 할 수 없습니다.");
                                        $("#mobile").val("");
                                    }
                                } else if (data.email == "false") {
                                    alert("중복 된 이메일이 존재 합니다. 다른 이메일을 사용해 주세요");
                                    $("#email").val("")
                                }
                            } else if (data.id == "false") {
                                alert("아이디가 중복 됩니다 다른 아이디를 사용해 주세요.");
                                $("#userId").val();
                            }
                        },
                        error: function (xhr, status, error, data) {
                            alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
                        }
                    });
                }
            }
        }
    }
    $(function () {
        $("#form_joinMember").validate({

            errorPlacement: function (error, element) {
                element.attr("placeholder", error.text());
            },

            rules: {
                compName: {
                    required: true
                },
                bisNum: {
                    required: true
                },
                bisType: {
                    required: true
                }
                ,
                ceoNm: {
                    required: true
                }
                ,
                compTelNum: {
                    required: true
                }
                ,
                userId: {
                    required: true,
                    minlength: 2,
                    maxlength: 15,
                    alphanumeric: true
                }
                ,
                psword: {
                    required: true,
                    minlength: 6,
                    maxlength: 15
                }
                ,
                psConfirm: {
                    required: true,
                    equalTo: '#psword'
                }
                ,
                userNm: {
                    required: true,
                    minlength: 2,
                    maxlength: 5
                }
                ,
                departNm: {
                    required: true
                }
                ,
                tele: {
                    required: true
                }
                ,
                mobile: {
                    required: true
                }
                ,
                email: {
                    required: true,
                    email: true
                }
                ,
                userAddrNum: {
                    required: true
                }
                ,
                userAddr1: {
                    required: true
                }
                ,
                userAddr2: {
                    required: true
                },
                compAddrNum: {
                    required: true
                },
                compAddr1: {
                    required: true
                },
                compAddr2: {
                    required: true
                },
                compEnNm: {
                    required: true
                },
                ceoEnNm: {
                    required: true
                }

            }
            ,
            messages: {
                psConfirm: {
                    equalTo: "패스워드 항목과 일치하지 않습니다."
                },
                userId: {
                    alphanumeric: "알파벳과 숫자만 사용가능합니다."
                },
                bisNum1: {},
                bisNum2: {},
                bisNum3: {},
                faxNum1: {
                    required: "필수항목"
                }
                ,
                faxNum2: {
                    required: "필수항목"
                }
                ,
                faxNum3: {
                    required: "필수항목"
                },
                tele1: {
                    required: "필수항목"
                }
                ,
                tele2: {
                    required: "필수항목"
                }
                ,
                tele3: {
                    required: "필수항목"
                },
                mobi1: {
                    required: "필수항목"
                }
                ,
                mobi2: {
                    required: "필수항목"
                }
                ,
                mobi3: {
                    required: "필수항목"
                },
                userAddrNum: {
                    required: "필수항목"
                }
            }
        })
    });


    $(function () {

        $("button").button().click(function (event) {
            event.preventDefault();
        });
        $("#sameAddr").click(sameAddr);

        /* zip code modal setting  */

        dialog_zipcode = $("#form_zipcode").dialog({
            autoOpen: false,
            width: 600,
            height: 700,
            modal: true,
            buttons: {
                "취소": function () {
                    dialog_zipcode.dialog("close");
                }
            },
            close: function () {
                form_zipcode[0].reset();
            }
        });

        form_zipcode = dialog_zipcode.find("form").on("submit", function (event) {
            event.preventDefault();
        });

        // open Modal Window
        $("#btn_zipcode1").button().on("click", function () {
            dialog_zipcode.dialog("open");
            zipcodeTarget = "receive";
            zipTableInit();
        });

        $("#btn_zipcode2").button().on("click", function () {
            dialog_zipcode.dialog("open");
            zipcodeTarget = "tax";
            zipTableInit();
        });

        actionInitZipCode();

    });


    var dialog_zipcode, form_zipcode;


    function actionInitZipCode() {
        actionAjaxZipcode({"formTag": "siguList"});
    }

    function actionAjaxZipcode(pm) {
        var url = "<c:url value='/member/zipcodeService.json' />";

        $.ajax({
            type: "post",
            dataType: "json",
            data: pm,
            url: url,
            success: function (result) {
                // session check
                if (result["CHECK_SESSION"] == "N") {
                    alert("로그아웃 되었습니다. 다시 로그인 바랍니다.");
                    return;
                }

                if (pm.formTag == "siguList") {

                    if (result["RESULT_YN"] == "Y") {
                        // 정보 가져오기
                        resultSiguList(result["RESULT_LIST"]);
                    } else {
                        alert("해당하는 정보가 없습니다. 운영자에게 문의바랍니다.");
                    }
                } else if (pm.formTag == "zipcodeSearch") {

                    resultZipcodeList(result);

                }
            },
            error: function (request, status, error) {
                alert("Error : " + error);
            },
            complete: function (data) {
            }

        });
    }

    function resultSiguList(list) {
        for (var i = 0; i < list.length; i++) {
            $("#cbLvl1").append("<option value='" + list[i]["sidocode"] + "'>" + list[i]["sido"] + "</option>");
        }
    }

    function zipTableInit() {
        $("#tblList tr").each(function () {
            var row = $("#" + this.id);
            row.remove();
        });
    }

    function actionSearchZipCode() {
        var searchKey = $("#txtSearch").val();
        if (searchKey == "") {
            alert("검색할 주소를 입력하십시오.");
            return;
        }

        var pm = {
            "formTag": "zipcodeSearch",
            "sido": $("#cbLvl1").val(),
            "searchKey": $("#txtSearch").val(),
            "searchType": $("#searchType").val()
        };

        actionAjaxZipcode(pm);
    }

    function resultZipcodeList(data) {
        zipTableInit();

        var vCnt = data["RESULT_CNT"];
        if (vCnt == 0) {
            alert("검색 정보가 없습니다. ");
            return;
        } else if (vCnt > 150) {
            alert("검색정보가 많습니다. 세부적으로 검색바랍니다. ");
        }

        vList = data["RESULT_LIST"];

        var tblHTML = "<table class='table_h'>";
        for (var i = 0; i < vList.length; i++) {
            tblHTML += "<tr id='tr_zip_" + vList[i]["rn"] + "' style='height:24px;'>";
            tblHTML += "<td style='width:5%;text-align:center;'>" + vList[i]["rn"] + "</td>";
            tblHTML += "<td style='width:15%;text-align:center;'>" + vList[i]["zipcode"] + "</td>";
            tblHTML += "<td style='width:35%;'><a href='javascript:actionZipcodesend(\"" + vList[i]["zipcode"] + "\",\"" + vList[i]["roadnamefull"] + "\");'>" + vList[i]["roadnamefull"] + "</a></td>";
            tblHTML += "</tr>";
        }

        tblHTML += "</table>";

        $("#tblList").append(tblHTML);
    }

    function actionZipcodesend(zipcode, fullname) {
        if (zipcodeTarget == "receive") {
            $("#compAddrNum").val(zipcode);
            $("#compAddr1").val(fullname);
            $("#compAddr2").val("");

        } else if (zipcodeTarget == "tax") {
            $("#userZipcode").val(zipcode);
            $("#userAddr1").val(fullname);
            $("#userAddr2").val("");

        }

        dialog_zipcode.dialog("close");

    }

    function afterEnter() {
        $("#div_companyDetail").css("display", "none");
    }

    function pswordRegex(pw) {

        var flag = true;

        var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}$/;
        if (!check.test(pw)) {
            alert("중요: 비밀번호는 글자와 숫자 그리고 특수문자의 혼합형태여야 합니다.");
            flag = false;
        }
        if (pw.length < 6 || pw.length > 16) {
            alert("중요: 비밀번호는 6자이상 16자 이하 이어야 합니다.");
            flag = false;
        }
        return flag;
    }


    function phoneNumValidation() {

        var flag = "false";

        var mobile = $("#mobile").val();
        $.ajax({
            type: "POST",
            url: "<c:url value= '/member/phoneNumValidation.json'/>",
            data: {"data": mobile},
            dataType: "JSON",
            success: function (data) {
                if (data == "true") {
                    flag = "true";
                } else if (data == "false") {
                    alert("중복된 휴대폰 번호가 존재 합니다. 한 번호당 하나의 아이디만 가입 가능 합니다.");
                    flag = "false";
                }
            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
                flag = "false";
            }
        });
        return flag;
    }

    function emailValidation() {
        var email = $("#email").val();


        $.ajax({
            type: "POST",
            url: "<c:url value= '/member/emailValidation.json'/>",
            data: {"data": email},
            dataType: "JSON",
            success: function (data) {
                if (data == "true") {
                    var flag = "true";
                    return flag;
                } else if (data == "false") {
                    alert("중복된 이메일이 존재 합니다. 다른 이메일을 사용해 주세요");
                    var flag = "false";
                    return flag;
                }
            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
                var flag = "false"
                return flag;
            }
        });
    }

</script>


<form id="frmMember" name="frmMember" action="" method="post" class="formClass">
    <!-- right_warp(오른쪽 내용) -->
    <div class="right_warp">
        <div class="title_route">
            <h3>회원정보</h3>

            <p class="route">
                <img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 고객지원 센터 <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>자기정보 수정</span>
            </p>
        </div>

        <!-- 업체정보 -->
        <h4 class="title01">업체정보</h4>


        <!-- 업체정보 디폴트 값들-->
        <input id="comId" name="comId" type="hidden"/>
        <input id="newRegi" name="newRegi" type="hidden"/>
        <input id="memid" name="memid" type="hidden" value="<%=userid%>">
        <input id="useFlag" name="useFlag" type="hidden" value="1"/>
        <input id="confirmFlag" name="confirmFlag" type="hidden" value="0"/>


        <div class="table_bg m_B27">
            <table summary="업체정보" class="table_w">
                <colgroup>
                    <col width="130px"/>
                    <col width="*"/>
                </colgroup>
                <tr>
                    <th class="b_B_none font13"><span style="color:red;">* </span>업체명</th>
                    <td class="b_B_none">
                        <div style="float: left" class="h30 txt_color02">
                        <input id="compName" name="compName" type="text" class="h30 txt_color02"
                               style="width:150px;" onfocus="" placeholder="업체명을 입력하세요"
                               onkeydown="javascript:if(event.keyCode==13){checkCompRegiTriger('regiCheck'); afterEnter();}"
                               data-placement="bottom" required/>&nbsp;

                        <a id="regiCheckBtn" href="javascript:checkCompRegiTriger('regiCheck')"><img
                                id="btn_insertCompany"
                                src="<c:url value='/images/exam/btn/btn_check04.gif'/>"
                                alt="등록여부확인"
                                style="border:0px;"/></a>&nbsp;
                        </div>
                        <div style="float: left" class="h30 txt_color02">
                            <span id="busiRegedInfo" class="txt_color03"><img
                                    src="<c:url value='/images/exam/ico/ico06.gif'/>" alt=""/> 업체등록여부를 확인해 주세요</span>
                            <span id="busiRegedInfo2" class="txt_color03" style="display: none"><img
                                    src="<c:url value='/images/exam/ico/ico06.gif'/>" alt=""/> 업체정보가 확인 되었습니다.</span>
                            <span id="busiRegedInfo3" class="txt_color03" style="display: none"><img
                                    src="<c:url value='/images/exam/ico/ico06.gif'/>" alt=""/> 업체정보를 입력을 선택 하셨습니다.</span>
                        </div>
                        <div style="float:right;">
                            <button id="btn_openCompanyDetail" name="btn_openCompanyDetail" class="btn"
                                    onclick="actionPerformed('openCompanyDetail');">업체신규 등록
                            </button>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="div_companyDetail" style="display: none;">
                <table summary="업체정보" class="table_w">
                    <colgroup>
                        <col width="130px"/>
                        <col width="310px"/>
                        <col width="130px"/>
                        <col width="*"/>
                    </colgroup>
                    <tr>

                        <th class="font13"><span style="color:red;">* </span>사업자번호</th>
                        <td class="">
                            <input id="bisNum" name="bisNum" type="text" class="h30 txt_color02"
                                   placeholder="아이디를 입력하세요" maxlength="10"
                                   style="width:150px;" onkeyup="this.value=this.value.replace(/[^a-z0-9]/gi,'');"/>&nbsp;
                            <a href="javascript:bisNumCheck()"><img
                                    src="<c:url value='/images/exam/btn/btn_check05.gif'/>"
                                    alt="사용여부확인"/></a>&nbsp;
                        </td>
                        <th class="font13"><span style="color:red;">* </span>사업유형</th>
                        <td class="">
                            <input id="bisType" name="bisType" type="text" value="" class="h30" style="width:150px;"/>&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <th class="font13"><span style="color:red;">* </span>대표자명</th>
                        <td class=""><input id="ceoNm" name="ceoNm" type="text" value=""
                                            class="h30"
                                            style="width:150px;"
                        /></td>
                        <th class="font13" style=""><span style="color:red;">* </span>대표 전화번호</th>
                        <td class="">
                            <input id="compTelNum" name="compTelNum" type="text" value="" class="h30"
                                   onkeyup="this.value=this.value.replace(/[^0-9]/gi,'');"
                                   style="width:150px;" maxlength="11"/>
                        </td>
                    </tr>

                    <tr>
                        <th rowspan="2" class="font13"><span style="color:red;">* </span>업체주소</th>
                        <td class="" colspan="3" style="border-bottom:none; ">
                            <input id="compAddrNum" name="compAddrNum" type="text" value="" class="h30"
                                   style="width:60px;" readonly="readonly"/>
                            &nbsp;
                            <a href="#"><img id="btn_zipcode1" name="btn_zipcode1"
                                             src="<c:url value='/images/exam/btn/btn_addr.gif'/>" alt="우편번호찾기"
                                             readonly="readonly"/></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="" colspan="3" style="padding-top:0">
                            <input id="compAddr1" name="compAddr1" type="text" value="" class="h30"
                                   placeholder="우편번호 찾기를 이용해 등록해 주세요"
                                   style="width:357px;"/>&nbsp;
                            <input id="compAddr2" name="compAddr2" type="text" value="" class="h30"
                                   style="width:220px;"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="font13"><span style="color:red;">* </span>영문업체명</th>
                        <td class=""><input id="compEnNm" name="compEnNm" type="text" value=""
                                            placeholder="영문으로 입력해 주세요"
                                            class="h30 txt_color02"
                                            style="width:150px;" onfocus="this.value=''"
                                            onkeyup="this.value=this.value.replace(/[^a-z0-9]/gi,'');"/></td>
                        <th class="font13"><span style="color:red;">* </span>영문대표자명</th>
                        <td class=""><input id="ceoEnNm" name="ceoEnNm" type="text" value="" class="h30"
                                            style="width:150px;"
                                            onkeyup="this.value=this.value.replace(/[^a-z0-9]/gi,'');"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- //업체정보 -->

        <!-- 사용자정보 -->
        <h4 class="title01">사용자정보</h4>

        <!-- 사용자 디폴트 값들 -->
        <input id="memYn" name="memYn" type="hidden" value="Y"/>
        <input id="memKind" name="memKind" type="hidden" value="1"/>
        <input id="ordinal" name="ordinal" type="hidden" value="1"/>

        <div class="table_bg m_B10">
            <table summary="사용자정보" class="table_w">
                <colgroup>
                    <col width="130px"/>
                    <col width="310px"/>
                    <col width="130px"/>
                    <col width="*"/>
                </colgroup>
                <tr>
                    <th class="font13">아이디</th>
                    <td class="" colspan="3">
                        <%=userid %>
                    </td>
                </tr>
                
                <tr>

                    <th class="font13"><span style="color:red;">* </span>이름</th>
                    <td class=""><%=username %>
                    </td>

                    <th class="font13"><span style="color:red;">* </span>담당부서</th>
                    <td class=""><input id="dept" name="dept" type="text" value="<%=dept %>" class="h30"
                                        onfocus="this.value=''"
                                        style="width:150px;"/></td>
                </tr>
                <tr>
                    <th class="font13"><span style="color:red;">* </span>전화번호</th>
                    <td class="">
                        <input id="phone" name="phone" type="text" value="<%=phone %>" class="h30" maxlength="11"
                               onkeyup="this.value=this.value.replace(/[^0-9]/gi,'');"
                               style="width:150px;">
                    </td>
                    <th class="font13"><span style="color:red;">* </span>휴대폰</th>
                    <td class="">
                        <input id="hp" name="hp" type="text" value="<%=hp %>" class="h30" maxlength="11"
                               onkeyup="this.value=this.value.replace(/[^0-9]/gi,'');"
                               style="width:150px;"/>
                    </td>
                </tr>
                <tr>
                    <th class="font13"><span style="color:red;">* </span>팩스번호</th>
                    <td class="">
                        <input id="fax" name="fax" type="text" value="<%=fax %>" class="h30" style="width:150px;"
                               onkeyup="this.value=this.value.replace(/[^0-9]/gi,'');"/>
                    </td>
                    <th class="font13"><span style="color:red;">* </span>이메일</th>
                    <td class="">
                        <input id="email" name="email" type="email" value="<%=email %>" class="h30" style="width:150px;"
                               onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9!@#$%^&*()/.]/gi,'');"
                               placeholder="옳바르게 입력해 주세요"/>
                    </td>
                </tr>
                <tr>
                    <th rowspan="2" class="font13"><span style="color:red;">* </span>주소</th>
                    <td class="" colspan="3" style="border-bottom:none; ">
                        <input id="userZipcode" name="userZipcode" type="text" value="<%=zipcode %>" class="h30" readonly="readonly"
                               style="width:60px;"/> &nbsp;
                        <a href="#"><img id="btn_zipcode2" name="btn_zipcode2"
                                         src="<c:url value='/images/exam/btn/btn_addr.gif'/>" alt="우편번호찾기"
                                         readonly="readonly"/></a>&nbsp;
                        <input id="sameAddr" name="sameAddr" type="checkbox"/> 업체주소와 동일
                    </td>
                </tr>
                <tr>
                    <td class="" colspan="3" style="padding-top:0">
                        <input id="userAddr1" name="userAddr1" type="text" value="<%=addr1 %>" class="h30" style="width:357px;"
                               readonly="readonly" placeholder="우편번호 찾기를 이용해 등록해 주세요"/>
                        &nbsp;
                        <input id="userAddr2" name="userAddr2" type="text" value="<%=addr2 %>" class="h30" style="width:220px;"/>&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <!-- //사용자정보 -->

        <!-- 재직증명서 -->
        <%--
        <div class="table_bg02 m_B15">
            <table summary="재직증명서" class="table_w">
                <colgroup>
                <col width="130px"/>
                <col width="*"/>
                </colgroup>
                <tr>
                    <th class="font13">재직증명서</th>
                    <td class="" colspan="3">
                        <input type="text" value="" class="h30 " style="width:198px;" />&nbsp;
                        <a href="#"><img src="<c:url value='/images/exam/btn/btn_file.gif'/>" alt="사용여부확인" /></a>&nbsp;
                        <ul class="certificate">
                            <li>주민번호는 생년월일만 표시하여 제출하시기 바랍니다.</li>
                            <li>개인정보(주민번호)가 노출되지 않도록 각별히 유의 하시기 바랍니다.</li>
                            <li>첨부파일로 전송이 불가한 경우 팩스로 접수 바랍니다.( FAX : 043-240-7997)</li>
                        </ul>
                    </td>
                </tr>
            </table>
        </div>
         --%>

             <div style="text-align: center;">
                   <button id="btn_newid" name="btn_newid" class="btn"
                           onclick="actionPerformed('updateMember');">회원정보 저장 
                   </button>
       	  	</div>

    </div>
    <!-- //right_warp(오른쪽 내용) -->
</form>

<!-- 항목 추가 -->
<div id="form_company" title="회사(업체)선택">
    <fieldset>
        <!-- popup_In -->
        <div class="popup_In">
            <!-- popup_In_table -->
            <div class="popup_In_table">
                <table summary="시료명" class="table_w">
                    <colgroup>
                        <col width="20%"/>
                        <col width="*"/>
                    </colgroup>
                    <tr>
                        <th class="bor_T_color01 bor_B_color01 bor_L_color01">회사(업체)검색</th>
                        <td class="bor_T_color01 bor_R_color01 bor_B_color01 ">
                            <div class="input-group">
                                <input type="text" id="searchKeyword" name="searchname" value="" class="inputBox"
                                       style="width:68%"/>

                                <div class="input-group-btn">
                                    <button id="btn_searchCompany" name="btn_searchCompany" class="btn"
                                            onclick="checkCompRegiTriger('regiCheck2'); ">검색
                                    </button>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <!-- table_bg -->
            <div class="table_bg"
                 style="width:100%; height:320px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
                <table id="output" summary="항목 목록" class="table_h" id="tbl_selectItems">
                    <colgroup>
                        <col width="20%"/>
                        <col width="20%"/>
                        <col width="10%"/>
                        <col width="*"/>
                        <col width="10%"/>
                    </colgroup>
                    <tr>
                        <th>업체명</th>
                        <th>사업자번호</th>
                        <th>대표자</th>
                        <th>주소</th>
                        <th class="b_R_none">선택</th>
                    </tr>

                </table>
            </div>
            <!-- //table_bg  -->
            <!-- //popup_In_table -->
        </div>
        <!-- //popup_In -->


        <!-- Allow form submission with keyboard without duplicating the dialog button  -->
        <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">

    </fieldset>
</div>


<!-- 우편번호 찾기 Modal -->
<div id="form_zipcode" title="우편번호 검색" style="overflow: hidden;">
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

                        <div class="left_Box" style="float:left;   margin: 10px;">
                            <div class="h5_title">
                                <h5>주소명 검색방법</h5>
                            </div>
                            <div class="h_Table_line02" style="float:left;width:100%; ">
                                <div class="top_Table_box"
                                     style="float:left;width:100%; overflow-x:hidden; overflow-y:hidden;">
                                    <table style="margin: 4px;">
                                        <tr>
                                            <td>
                                                1. 동 + 검물명 입력 : 예) '충무로1가(동명) 중앙우체국(건물명)'<br>
                                                2. 도로명 + 건물번호 입력 : 예)'소공로(도로명) 70(건물번호)'<br>
                                                3. 건물명 입력 : 예)'중앙우체국(건물명)'
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="search_Box" style="float:left;width:92%;margin-left:12px;margin-bottom: 12px;">
                            <table summary="검색" class="table01">
                                <caption>검색</caption>
                                <colgroup>
                                    <col width="80px"/>
                                    <col width="*"/>
                                </colgroup>
                                <tr>
                                    <th>시/도</th>
                                    <td>
                                        <select style="width:180px;" name="cbLvl1" id="cbLvl1" onchange="">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height:3px;" colspan="4"></td>
                                </tr>
                                <tr>
                                    <th>
                                        주소검색
                                    </th>
                                    <td colspan="3">
                                        <select name="searchType" id="searchType" style="width:80px;">
                                            <option value="road">도로명</option>
                                            <option value="area">지번</option>
                                        </select>
                                        <input type="text" style="width:200px;" name="txtSearch" id="txtSearch">
                                        <a href="#" onclick="actionSearchZipCode();" id="btnSearch"><img
                                                src="<c:url value='/images/exam/btn/btn_inquiry01.gif'/>" alt="검색"/></a>
                                    </td>
                                </tr>
                            </table>
                        </div>


                        <div class="con_right_in" style="float:left; width:100%; ">


                            <!-- left_Box_top -->
                            <div class="left_Box" style="width:100%;">
                                <!-- h5_title -->
                                <div class="h5_title">
                                    <h5>주소목록</h5>

                                    <div align="right" style="margin-right: 20px;margin-top:5px;">
                                        주소를 클릭하십시오.
                                    </div>
                                </div>
                                <!-- //h5_title -->

                                <!-- DataGrid 전체 DIV -->
                                <div class="h_Table_line02" style="width:100%;">
                                    <div class="table_bg" style="width:100%; overflow-x:hidden; overflow-y:scroll;">
                                        <table summary="" class="table_h">
                                            <thead id="tblHeader">
                                            <tr>
                                                <th style="width:5%" dataField="rn" textAlign="center">검색<br>순번</th>
                                                <th style="width:15%" dataField="tblZipcode" textAlign="center">우편번호
                                                </th>
                                                <th style="width:35%" dataField="tblRoadNameFull" textAlign="left"> 주소
                                                </th>
                                            </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <!-- Grid List 전체 DIV width-2px  -->
                                    <div class="bottom_T_box" id="tblList"
                                         style="width:100%;height:280px;overflow-x:hidden;overflow-y:scroll"
                                         onscroll="">
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
<!-- 우편번호 찾기 모달 End -->





