<%@ page import="exam.com.report.model.MergeSaveVO" %>
<%@ page import="org.h2.command.dml.Merge" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="<c:url value='/jquery/jquery.form.js'/>"></script>
<script>


    $(function () {
        $("#reportForm").ajaxForm();
    });

    function fnAjaxSubmit() {

        $("#reportForm").ajaxSubmit({

            url: "<c:url value='/report/mergeCopyRequestUpdate.json'/>",
            type: 'POST',
            success: function (data) {
                alert(data);
                location.href = "<c:url value='/report/copyReport.do'/>?sub=report&menu=copyReport"
            },
            error: function () {
                alert(data);
            }
        })
    }

    var dialog_zipcode, form_zipcode;


    $(function() {

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
        });

        // open Modal Window
        $( "#btn_zipcode1" ).button().on( "click", function() {
            dialog_zipcode.dialog( "open" );
            zipcodeTarget = "receive";
            zipTableInit();
        });

        $("#btn_zipcode2").button().on("click", function(){
            dialog_zipcode.dialog( "open" );
            zipcodeTarget = "tax";
            zipTableInit();
        });

        actionInitZipCode();

    });

    function actionInitZipCode(){
        actionAjaxZipcode({"formTag":"siguList"});
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
            }

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
            }

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
        if(zipcodeTarget == "receive") {
            $("#rcvzipcode").val(zipcode);
            $("#rcvaddr1").val(fullname);
            $("#rcvaddr2").val("");

        } else if(zipcodeTarget == "tax"){
            $("#taxzipcode").val(zipcode);
            $("#taxaddr1").val(fullname);
            $("#taxaddr2").val("");

        }

        dialog_zipcode.dialog("close");

        //alert(zipcode+"/"+fullname);
    }

</script>
<style></style>


<!-- right_warp(오른쪽 내용) -->
<div class="right_warp">

    <div id="" class="table_w_in">
        <p class="close_btn">
            <a href="javascript:actionDivWindow('div1_close');"><img id="icon_div1_close"
                                                                     src="/exam/images/exam/btn/btn01.gif" alt=""></a>
            <a href="javascript:actionDivWindow('div1_open');"><img id="icon_div1_open"
                                                                    src="/exam/images/exam/btn/btn02.gif" alt=""
                                                                    style="display: none;"></a>
        </p>
        <h4 class="title01">신청자 정보</h4>
        <!-- table_bg -->
        <div id="div1_win_content" class="table_bg">
            <table summary="신청자정보" class="table_w">
                <colgroup>
                    <col width="134px">
                    <col width="275px">
                    <col width="134px">
                    <col width="*">
                </colgroup>
                <tbody>
                <tr>
                    <th>업체명</th>
                    <td><label id="cname" fieldname="comname">${requestList.comname}</label></td>
                    <th>사업자번호</th>

                    <td><label id="bizno" fieldname="bizno">${requestList.bizno}</label></td>
                </tr>
                <tr>
                    <th>업태</th>
                    <td><label id="biztype" fieldname="biztype"></label></td>
                    <th>대표자</th>
                    <td><label id="ceoname" fieldname="ceoname">장주옥</label></td>
                </tr>
                <tr>
                    <th>담당자
                    <td>${requestList.mngname}</td>
                    <th>담당부서
                    <td>${requestList.mngdept}</td>
                </tr>
                <tr>
                    <th>휴대폰
                    <td>
                        ${requestList.mnghp}
                    </td>
                    <th>이메일
                    <td>${requestList.mngemail}</td>
                </tr>
                <tr>
                    <th class="b_B_none">전화번호
                    <td class="b_B_none">
                        ${requestList.mngphone}
                    </td>
                    <th class="b_B_none">팩스번호
                    <td class="b_B_none">
                        ${requestList.fax}
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- //table_bg  -->


        <h4 id="div2_h4" class="title01">성적서 기본정보</h4>

        <form id="reportForm" name="reportForm" action="<c:url value='/report/mergeCopyRequestSave.do'/>" method="post">
            <!-- hidden 정보들-->
            <input id="reportid" name="reportid" type="text" hidden="true" value="${reportList.reportid}" style="display: none"/>
            <input id="reqid" name="reqid" type="text" hidden="true" value="${reportList.reqid}" style="display: none"/>
            <input id="acceptno" name="acceptno" type="text" hidden="true" value="${reportList.acceptno}" style="display: none"/>
            <input id="reportno" name="reportno" type="text" hidden="true" value="${reportList.reportno}" style="display: none"/>
            <input id="type" name="type" type="text" hidden="true" value="M" style="display: none"/>


            <!-- table_bg -->
            <div id="div2_win_content" class="table_bg">
                <table summary="성적서 기본정보" class="table_w">
                    <colgroup>
                        <col width="136px">
                        <col width="276px">
                        <col width="130px">
                        <col width="*">
                    </colgroup>
                    <tbody>
                    <tr>

                        <th>시험성적서 부분</th>
                        <td>
                            <select name="copycnt" id="copycnt" class="h30" style="width:100px;"
                                    onchange="javascript:actionChangeCopycnt();">
                                <option value="0" <c:if test="${reportList.copycnt  eq '0'}">selected</c:if>>신청안함
                                </option>

                                <option value="1" <c:if test="${reportList.copycnt  eq '1'}">selected</c:if>>1</option>

                                <option value="2"
                                        <c:if test="${reportList.copycnt  eq '2'}">selected</c:if> >2
                                </option>

                                <option value="3"
                                        <c:if test="${reportList.copycnt  eq '3'}">selected</c:if> >3
                                </option>

                                <option value="4"
                                        <c:if test="${reportList.copycnt  eq '4'}">selected</c:if> >4
                                </option>

                                <option value="5"
                                        <c:if test="${reportList.copycnt  eq '5'}">selected</c:if> >5
                                </option>

                                <option value="6"
                                        <c:if test="${reportList.copycnt  eq '6'}">selected</c:if> >6
                                </option>

                                <option value="7"
                                        <c:if test="${reportList.copycnt  eq '7'}">selected</c:if> >7
                                </option>

                                <option value="8"
                                        <c:if test="${reportList.copycnt  eq '8'}">selected</c:if> >8
                                </option>

                                <option value="9"
                                        <c:if test="${reportList.copycnt  eq '9'}">selected</c:if> >9
                                </option>

                                <option value="10"
                                        <c:if test="${reportList.copycnt  eq '10'}">selected</c:if> >10
                                </option>

                                <option value="etc"
                                        <c:if test="${reportList.copycnt  eq 'etc'}">selected</c:if> >기타
                                </option>
                            </select>
                        </td>

                        <th>성적서 용도</th>
                        <td>
                            <select name="usage" id="usage" class="h30" style="width:150px;">
                                <option value="-1">##선택##</option>
                                <option value="20"
                                        <c:if test="${reportList.usage  eq '20'}">selected</c:if> >품질관리용
                                </option>
                                <option value="21"
                                        <c:if test="${reportList.usage  eq '21'}">selected</c:if> >업체납품용
                                </option>
                                <option value="22" <c:if test="${reportList.usage  eq '22'}">selected</c:if>>연구개발용
                                </option>
                                <option value="23" <c:if test="${reportList.usage  eq '23'}">selected</c:if>>기타</option>
                            </select>
                        </td>
                    </tr>
                    <tr>

                        <th>가격</th>
                        <td>
                            <input id="reportprice" name="reportprice" type="text" class="h30"
                                   style="width:150px;" readonly="true" value="${reportList.reportprice}">
                        </td>

                    </tr>

                    <tr>
                        <th>시험성적서<br>받는 주소</th>
                        <td colspan="3">
                            <div class="div_table_sub_w">
                                <table id="tbl_rcv" class="table_sub_w">
                                    <colgroup>
                                        <col width="100px">
                                        <col width="130px">
                                        <col width="100px">
                                        <col width="*">
                                    </colgroup>

                                    <tbody>
                                    <tr>
                                        <th class="cor01">업체명</th>
                                        <td><input id="rcvcompany" name="rcvcompany" type="text"
                                                   value="${reportList.rcvcompany}" class="h30" style="width:200px;">
                                        </td>
                                        <th class="cor01">대표자</th>
                                        <td><input id="rcvceo" name="rcvceo" type="text" value="${reportList.rcvceo}"
                                                   class="h30" style="width:200px;"></td>
                                    </tr>
                                    <tr>
                                        <th class="cor01" style="height:70px;">주소</th>
                                        <td colspan="3">
                                            <input id="rcvzipcode" name="rcvzipcode" type="text" readonly="true"
                                                   value="${reportList.rcvzipcode}" class="h30" style="width:60px;">

                                            <br>
                                            <input id="rcvaddr1" name="rcvaddr1" type="text" readonly="true"
                                                   value="${reportList.rcvaddr1}"
                                                   class="h30" style="width:365px; margin-top:3px;">
                                            <input id="rcvaddr2" name="rcvaddr2" type="text" readonly="true"
                                                   value="${reportList.rcvaddr2}"
                                                   class="h30" style="width:140px; margin-top:3px;float:right;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="cor01">담당부서</th>
                                        <td><input id="rcvdept" name="rcvdept" type="text" value="${reportList.rcvdept}"
                                                   class="h30" style="width:200px;"></td>
                                        <th class="cor01">담당자</th>
                                        <td><input id="rcvmngname" name="rcvmngname" type="text"
                                                   value="${reportList.rcvmngname}" class="h30" style="width:200px;">
                                        </td>

                                    </tr>
                                    <tr>
                                        <th class="cor01">휴대폰</th>
                                        <td>
                                            <input type="text" id="rcvhp" name="rcvhp" value="${reportList.rcvhp}"
                                                   class="h30" style="width:108px;" placeholder="020-0000-0000"
                                                   maxlength="13" autocomplete="off">
                                        </td>
                                        <th class="cor01">이메일</th>
                                        <td><input type="text" id="rcvemail" name="rcvemail"
                                                   value="${reportList.rcvemail}"
                                                   class="h30" style="width:200px;"></td>


                                    </tr>
                                    <tr>
                                        <th class="cor01">전화번호</th>
                                        <td>
                                            <input type="text" id="rcvphone" name="rcvphone"
                                                   value="${reportList.rcvphone}"
                                                   class="h30" style="width:108px;" placeholder="020-0000-0000"
                                                   maxlength="13" autocomplete="off">
                                        </td>

                                        <th class="cor01">팩스번호</th>
                                        <td style="border-right: 1px solid #FFFFFF !important;">
                                            <input type="text" id="rcvfax" name="rcvfax" value="${reportList.rcvfax}"
                                                   class="h30" style="width:108px;" placeholder="020-0000-0000"
                                                   maxlength="13" autocomplete="off">
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </td>
                    </tr>

                    <tr>
                        <th>세금계산서 청구</th>
                        <td colspan="3">
                            <select id="pricechargetype" name="pricechargetype" class="h30"
                                    style="width:100px; margin-bottom:6px; margin-top:3px;"
                                    onchange="javascript:actionChangePriceType();">
                                <option value="-1">##선택##</option>
                                <option value="26" <c:if test="${reportList.pricechargetype  eq '26'}">selected</c:if>>청구
                                </option>
                                <option value="27" <c:if test="${reportList.pricechargetype  eq '27'}">selected</c:if>>카드
                                </option>
                                <option value="28" <c:if test="${reportList.pricechargetype  eq '28'}">selected</c:if>>영수
                                </option>
                            </select>

                            <table id="tbl_tax" class="table_sub_w" style="display: inline;">
                                <colgroup>
                                    <col width="100px">
                                    <col width="130px">
                                    <col width="100px">
                                    <col width="*">
                                </colgroup>

                                <tbody>
                                <tr>
                                    <th class="cor01">업체명</th>
                                    <td><input id="taxcompany" name="taxcompany" type="text"
                                               value="${reportList.taxcompany}" class="h30"
                                               style="width:220px;"></td>
                                    <th class="cor01">대표자</th>
                                    <td><input id="taxceo" name="taxceo" type="text" value="${reportList.taxceo}"
                                               class="h30"
                                               style="width:220px;"></td>
                                </tr>
                                <tr>
                                    <th class="cor01" style="height:70px;">주소</th>
                                    <td colspan="3">
                                        <input id="taxzipcode" name="taxzipcode" type="text"
                                               value="${reportList.taxzipcode}" class="h30"
                                               style="width:60px;">
                                        <a href="#">
                                            <img id="btn_zipcode2" name="btn_zipcode2"
                                                         src="/exam/images/exam/btn/btn_addr.gif" alt="우편번호찾기"
                                                         style="border:0px;"
                                                         class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                                                         role="button"></img>
                                        </a>
                                        <br>
                                        <input id="taxaddr1" name="taxaddr1" type="text" value="${reportList.taxaddr1}"
                                               class="h30"
                                               style="width:365px; margin-top:3px;">
                                        <input id="taxaddr2" name="taxaddr2" type="text" value="${reportList.taxaddr2}"
                                               class="h30"
                                               style="width:180px; margin-top:3px;float:right;">
                                    </td>
                                </tr>
                                <tr>
                                    <th class="cor01">사업자번호</th>
                                    <td><input id="taxbizno" name="taxbizno" type="text" value="${reportList.taxbizno}"
                                               class="h30"
                                               style="width:220px;"></td>
                                    <th class="cor01">업태</th>
                                    <td><input type="text" id="taxbiztype" name="taxbiztype"
                                               value="${reportList.taxbiztype}" class="h30"
                                               style="width:220px;"></td>
                                </tr>
                                <tr>
                                    <th class="cor01">담당부서</th>
                                    <td><input id="taxdept" name="taxdept" type="text" value="${reportList.taxdept}"
                                               class="h30"
                                               style="width:220px;"></td>
                                    <th class="cor01">담당자</th>
                                    <td><input type="text" id="taxmngname" name="taxmngname"
                                               value="${reportList.taxmngname}" class="h30"
                                               style="width:220px;"></td>
                                </tr>
                                <tr>
                                    <th class="cor01">이메일</th>
                                    <td><input id="taxemail" name="taxemail" type="text" value="${reportList.taxemail}"
                                               class="h30"
                                               style="width:220px;"></td>
                                    <th class="cor01">휴대폰</th>
                                    <td>
                                        <input type="text" id="taxhp" name="taxhp" value="${reportList.taxhp}"
                                               class="h30" style="width:108px;"
                                               placeholder="020-0000-0000">
                                    </td>
                                </tr>
                                <tr>
                                    <th class="cor01">전화번호</th>
                                    <td>
                                        <input type="text" id="taxphone" name="taxphone" value="${reportList.taxphone}"
                                               class="h30"
                                               style="width:108px;" placeholder="020-0000-0000">
                                    </td>
                                    <th class="b_B_none cor01">팩스번호</th>
                                    <td class="b_B_none">
                                        <input type="text" id="taxfax" name="taxfax" value="${reportList.taxfax}"
                                               class="h30"
                                               style="width:108px;" placeholder="020-0000-0000">
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <br/>
            <br/>


            <div class="table_bg">
                <table summary="성적서 기본정보" class="table_w">
                    <colgroup>
                        <col width="136px">
                        <col width="276px">
                        <col width="130px">
                        <col width="*">
                    </colgroup>
                    <tbody>

                    <tr>
                        <th>통합신청 가능<br>리스트</th>

                        <td colspan="3">
                            <div class="div_table_sub_w">


                                <table id="mergeListTable" class="table_sub_w" style="margin-top: 3px">
                                    <colgroup>
                                        <col width="10%">
                                        <col width="20%">
                                        <col width="20%">
                                        <col width="20%">
                                        <col width="20%">
                                    </colgroup>


                                    <thead>
                                    <tr>
                                        <th class="cor01" style="text-align: center">선택</th>
                                        <th>접수번호</th>
                                        <th>시료명</th>
                                        <th>유종제품명</th>
                                        <th>항목건수</th>
                                    </tr>
                                    </thead>

                                    <tbody id="mergeListTbody">


                                    <c:forEach var="merge" items="${mergeList}" varStatus="status">
                                    <tr>
                                        <td style="text-align: center">
                                            <input name="mergereqid" value="${merge.reqId}"
                                                   type="checkbox"
                                                    <c:forEach var="savedList" items="${mergeSavedList}"
                                                               varStatus="status">
                                                        <c:if test="${savedList.mergereqid eq merge.reqId}">checked</c:if>
                                                    </c:forEach>
                                                    />
                                        </td>

                                        <td>${merge.reportNo}</td>
                                        <td>${merge.smpName}</td>
                                        <td>${merge.productName}</td>
                                        <td>${merge.smpCnt}</td>
                                    </tr>
                                    </tbody>
                                    </c:forEach>

                                </table>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </form>


        <p id="div2_btn" class="txt_C" style="padding-top:8px;">
            <a href="javascript:fnAjaxSubmit();"> <img id="btn_setrequest" src="/exam/images/exam/btn/btn_save02.gif"
                                                       alt="저장">
            </a>
        </p>


        <!-- //table_bg  -->
    </div>


</div>
<!-- //right_warp(오른쪽 내용) -->



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
