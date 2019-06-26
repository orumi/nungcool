<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>


    var masterID;

    $(function () {

        $("#firstOpt").change(selSecondOption);
        $("#secondOpt").change(selThirdOption);
        $("#search").click(search);
        $("#okay").click(okay);
    })

    function getMasterID() {

        var ID = masterID;
        return ID;

    }

    function okay() {

        alert(masterID);

    }


    function selFirstOption() {

        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selFirstOption.json'/>",
            data: {"data": "data"},
            success: function (data) {

                for (var i = 0; i < data.length; i++) {
                    $("#firstOpt").append("<option value='" + data[i].classID + "'>" + data[i].name + "</option>");
                }

            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }

    function selSecondOption() {

        var optionValue = $("#firstOpt option:selected").val();

        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selSecondOption.json'/>",
            data: {"data": optionValue},
            success: function (data) {

                $("#secondOpt option").remove();

                $("#secondOpt").append("<option>" + "유종" + "</option>");

                for (var i = 0; i < data.length; i++) {
                    $("#secondOpt").append("<option value='" + data[i].groupID + "'>" + data[i].name + "</option>");
                }

            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }

    function selThirdOption() {

        var optionValue = $("#secondOpt option:selected").val();

        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selThirdOption.json'/>",
            data: {"data": optionValue},
            success: function (data) {


                $("#thirdOpt option").remove();
                $("#thirdOpt").append("<option>" + "유종" + "</option>");
                for (var i = 0; i < data.length; i++) {
                    $("#thirdOpt").append("<option value='" + data[i].masterID + "'>" + data[i].name + "</option>");
                }

            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }

    function search() {

        masterID = $("#thirdOpt option:selected").val();

        sel(masterID);

    }


    function sel(optionValue) {
        $.ajax({
            data: {"data": optionValue},
            type: "post",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selQualStandList.json'/>",
            success: function (responseText, statusText, xhr, $form) {
                $("#listbody1").html(responseText);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            },
            complete: function (data) {

            },
            cache: false
        });
    }


    function fnSave() {
        var fieldid = $("#fieldcnt").val();

        gridView.commit();

        var state;
        var jData;
        var jRowsData = [];

        var rows = dataProvider.getAllStateRows();

        if (rows.updated.length > 0) {
            for (var i = 0; i < rows.updated.length; i++) {

                for (var j = 0; j < fieldid; j++) {
                    jData = {
                        "mtitemid": gridView.getValue(rows.updated[i], 0),
                        "specid": dataProvider.getOrgFieldName(5 + j),
                        "spec": gridView.getValue(rows.updated[i], 5 + j)
                    }
                    jRowsData.push(jData);
                }

            }
            ;
        }


        if (jRowsData.length == 0) {
            alert("변경된 내용이 없습니다.");
            dataProvider.clearRowStates(true);
            return;
        }

        var val = JSON.stringify(jRowsData);
        var data = {"data": val};
        if (confirm("변경된 내용을 저장하시겠습니까?")) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/edtQualStand.json'/>",
                type: "post",
                data: data,
                dataType: "json",
                success: function (data) {
                    if (data.RESULT_YN == "Y") {
                        alert("정상 처리 되었습니다.");
                        dataProvider.clearRowStates(true, true);
                    } else {
                        alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }


    }

    function fnAdd() {

        var popUrl = "/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/qualAddPopUp.do";	//팝업창에 출력될 페이지 URL
        var popOption = "width=380, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
        var popWin = window.open(popUrl, "시험조건", popOption);

    }


    selFirstOption();

</script>
<!-- /section:basics/content.breadcrumbs -->
<div class="page-content" align="right">

    <div>
        <table width="100%" border="">
            <tr>
                <div style="float:left;">

                    <td style="width:300px;"><h3 align="center">유종구분/ 유종 / 제품</h3></td>

                    <td style="vertical-align: bottom">
                        <span align="center">
                            <select id="firstOpt" style="width: 200px;">
                                <option>
                                    유종구분
                                </option>
                            </select>

                            <select id="secondOpt" style="width: 200px;">
                                <option>
                                    유종
                                </option>
                            </select>
                            <select id="thirdOpt" style="width: 200px;">
                                <option>
                                    제품
                                </option>
                            </select>
                        </span>
                </div>
                <div style="float:right">
                    <button id="search">조회</button>
                </div>
                </td>
            </tr>
        </table>
    </div>
    <!-- 여기서 부터 내용 작성 -->
    <br/>
    <br/>

    <div>
        <div style="padding-right: 15px;">
            <input type="button" onclick="javascript:fnAdd()" value="기준추가"/>
            <input type="button" onclick="javascript:fnSave()" value="저장"/>
        </div>
    </div>
    <div>
        <div id="listbody1" style="width: 100%; height: 500px;"></div>
        <!-- 작성완료 -->
    </div>
    <%--<div class="btnDiv">
        <p style="float: right;margin-left: 10px;">
            <a href="javascript:void(0);" class="btn btn-labeled btn-success btn-sm"> <span class="btn-label"><i
                    class="glyphicon glyphicon-ok"></i></span>결제유형 저장</a>
        </p>

        <p style="float: right;margin-left: 10px;">
            <a class="btn btn-default" data-toggle="modal" data-target="#rejectBtn">기준추가</a>
        </p>
    </div>
    <div>
        <div id="listbody1" style="width: 100%; height: 500px;"></div>
        <!-- 작성완료 -->
    </div>--%>
</div>

<!-- 기준추가 상세 모달창------------------------------------------------------------------------ -->
<%--
<div class="modal fade" id="rejectBtn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog rejectDia" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel">품질기준</h4>
            </div>

                <div class="col-xs-12">
                    <table id="simple-table" class="table  table-bordered table-hover">
                        <thead>
                        <tr>
                            <div align="center">
                                <td style="align: center">품질기준 명칭</td>
                            </div>
                        </tr>
                        </thead>

                        <tbody>
                        <tr>
                            <td><input></td>
                        </tr>

                        </tbody>
                    </table>
                </div>


            <div class="modal-footer">
                <button id="okay" type="button" class="btn btn-primary">확인</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>--%>
