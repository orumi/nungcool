<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script>

    <%
        LoginUserVO loginUserVO = (LoginUserVO) session.getAttribute("loginUserVO");
    %>

    var masterID;
    var loginID = '<%=loginUserVO.getName()%>';
    var firstSelectListJson;
    var secondSelectListJson;
    var thirdSelectListJson;

    $(function () {
        $("#firstOpt").change(selSecondOption);
        $("#secondOpt").change(selThirdOption);
        $("#search").click(search);
        $("#standAdd").click(modalPopUp);
        $("#modalDelete").click(modalDeleteDataTriger);
        $("#modalAdd").click(modalAdd);
        $("#save").click(save);
        $("#modalSave").click(modalSaveData);
        $("#appendRow").click(appendRow);
    });

    function appendRow() {

        document.getElementById("realFrame").contentWindow.appendRow();

    }

    function save() {
        document.getElementById("realFrame").contentWindow.save();
    }

    function modalSaveData() {

        gridView.commit();

        var jData;
        var jRowsData = [];
        var rows = dataProvider.getAllStateRows();

        if (rows.updated.length > 0) {
            for (var i = 0; rows.updated.length > i; i++) {
                jData = dataProvider.getJsonRow(rows.updated[i]);
                jData.state = "updated";
                jData.modifyID = loginID;
                jRowsData.push(jData);
            }
        }

        if (rows.created.length > 0) {
            for (var i = 0; rows.created.length > i; i++) {
                jData = dataProvider.getJsonRow(rows.created[i]);
                jData.state = "created";
                jData.masterID = masterID;
                jData.regID = loginID;
                jRowsData.push(jData);
            }
        }

        var jsonv = JSON.stringify(jRowsData);

        $.ajax({
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/saveData.json'/>",
            type: "POST",
            data: {"data": jsonv},
            success: function (data) {
                loadTriger();
                search();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function modalAdd() {
        gridView.beginAppendRow();
    }

    function loadTriger() {
        loadData(masterID);
    }

    function loadData(data) {

        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/loadPopUpList.json'/>",
            data: {"data": data},
            success: function (data) {
                dataProvider.fillJsonData(data);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }

    function getMasterID() {

        var ID = masterID;
        return ID;

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

        $("#secondOpt option").remove(); // 첫번째 선택창에서 선택 된 놈 소집

        $("#secondOpt").append("<option>" + "====== 유종 ======" + "</option>");

        for (var i = 0; i < secondSelectListJson.length; i++) {

            if (secondSelectListJson[i].classID == optionValue) { // 1번째에서 선택 된 클래스아이디와 같은 종류만 모두 소집
                $("#secondOpt").append("<option value='" + secondSelectListJson[i].groupID + "'>" + secondSelectListJson[i].name + "</option>");
            }

        }


        /*$.ajax({
         type: "post",
         dataType: "json",
         url: "
        <c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selSecondOption.json'/>",
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
         });*/

    }

    function selThirdOption() {

        var optionValue = $("#secondOpt option:selected").val();


        $("#thirdOpt option").remove();
        $("#thirdOpt").append("<option>" + "====== 제품 ======" + "</option>");

        for (var i = 0; i < thirdSelectListJson.length; i++) {

            if (thirdSelectListJson[i].groupID == optionValue) { // 1번째에서 선택 된 클래스아이디와 같은 종류만 모두 소집
                $("#thirdOpt").append("<option value='" + thirdSelectListJson[i].masterID + "'>" + thirdSelectListJson[i].name + "</option>");
            }

        }
        /*

         $.ajax({
         type: "post",
         dataType: "json",
         url: "
        <c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selThirdOption.json'/>",
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
         */

    }

    function search() {

        masterID = $("#thirdOpt option:selected").val();

        for (var i = 0; i < thirdSelectListJson.length; i++) {

            if (thirdSelectListJson[i].masterID == masterID) {
                if (thirdSelectListJson[i].cnt == 0) {
                    alert("해당 제품에 항목이 등록되어 있지 않습니다. (시험기초관리 ->유종/제품관리 -> 기본항목관리)로 이동 후 항목을 먼저 등록하여 주시기 바랍니다.");
                    return;
                }
            }
        }

        sel(masterID);
    }

    function injectionToIframe(responseText) {
        document.getElementById("realFrame").contentWindow.injection(responseText);
    }

    function clearIframe() {
        document.getElementById("realFrame").contentWindow.clearFrame();
    }

    function sel(optionValue) {

        $.ajax({
            data: {"data": optionValue},
            type: "post",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selQualStandList.json'/>",
            success: function (responseText, statusText, xhr, $form) {
                clearIframe();
                injectionToIframe(responseText);
                /*$("#listbody1").html(responseText);*/
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            },
            complete: function (data) {

            },
            cache: false
        });

    }

    function init(optionValue) {
        $.ajax({
            data: {"data": optionValue},
            type: "post",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/selQualStandList.json'/>",
            success: function (responseText, statusText, xhr, $form) {

                injectionToIframe(responseText);
                /*$("#listbody1").html(responseText);*/
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            },
            complete: function (data) {

            },
            cache: false
        });
    }


    function deleteConfirm() {
        if (confirm("저장되어 있던 모든 데이터가 삭제 됩니다 계속 하시겠습니까? ")) {
            deleteDataTriger();
        } else {
            return false;
        }
    }

    function deleteSetting() {
        var rows = gridView.getCheckedRows();
        var jRows = [];
        for (var i = 0; i < rows.length; i++) {

            var json = gridView.getValues(rows[i]);
            jRows.push(json);
        }

        var preparedJson = JSON.stringify(jRows);

        return preparedJson;
    }

    function deleteData(str) {

        $.ajax({
            type: "post",
            dataType: "text",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/deletePopUp.json'/>",
            data: {"data": str},
            success: function (data) {
                alert(data);
                loadTriger();
                search();// refresh 용
                refreshParents();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }

    function modalDeleteDataTriger() {

        var preparedJson = deleteSetting();
        deleteData(preparedJson);

    }


    function modalPopUp() {

        gridView.commit();
        loadTriger();
        $("#modalPopUp1").modal();

        /*$("#modalPopUp").on('shown.bs.modal', function () {
         gridView.resetSize();
         loadModalData();
         });*/

        $("#modalPopUp1").on('shown.bs.modal', function () {
            gridView.resetSize();

        });

    }


    function getJavaObject() { // 자바에서 객체 1,2,3 번째 다 가져와서 자바스크립트에 JSON 기입 후 1번째만 삽입.

        $.ajax({
            type: "post",
            dataType: "text",
            url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/getSelectListWithJson.json'/>",
            data: {"data": "data"},
            success: function (data) {

                var json = JSON.parse(data);

                firstSelectListJson = json.list;
                secondSelectListJson = json.list2;
                thirdSelectListJson = json.list3;

                for (var i = 0; i < firstSelectListJson.length; i++) {
                    $("#firstOpt").append("<option value='" + firstSelectListJson[i].classID + "'>" + firstSelectListJson[i].name + "</option>");
                }

            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }


    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("<c:url value='/script'/>");
        dataProvider = new RealGridJS.LocalDataProvider();
        gridView = new RealGridJS.GridView("realgrid");
        gridView.setDataSource(dataProvider);

        //필드를 가진 배열 객체를 생성합니다.
        var fields = [
            {
                fieldName: "specNM"
            }
            , {
                fieldName: "masterID"
            }
            , {
                fieldName: "specID"
            }

        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider.setFields(fields);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns = [
            {
                name: "specNM",
                fieldName: "specNM",
                header: {
                    text: "기준이름"
                },
                width: 300,
                readOnly: false
            }
        ];

        //컬럼을 GridView에 입력 합니다.
        gridView.setColumns(columns);

        /* 그리드 row추가 옵션사용여부 */
        gridView.setOptions({
            panel: {
                visible: false
            },
            footer: {
                visible: false
            },
            stateBar: {
                visible: false
            },
            display: {
                fitStyle: "evenFill"
            },
            header: {},
            select: {
                style: RealGridJS.SelectionStyle.ROWS
            },
            checkBar: {
                visible: true
            }

        });
        gridView.setEditOptions({
            insertable: true,
            appendable: true,
            deletable: true
        })
        gridView.setStyles({
            selection: {
                background: "#11000000",
                border: "#88000000,1"
            }
        });
        /*selFirstOption();*/  // 원래 에이작스 에이작스 에이작스로 했지만 부장님 권유로 객체를 통채로 가져다 놓게 되어 지움
        getJavaObject(); // 1,2,3 전부 객체 여기다 갖다 놓는 작업 후 1번째만 삽입.
        init(165);
    });
</script>

<div class="page-content">
    <div role="content">
        <!--  start of  form-horizontal tems_search  -->
        <!--  start of widget-body -->
        <div class="form-horizontal form-terms ">
            <div class="jarviswidget jarviswidget-sortable" role="widget">
                <!-- back -->
                <div class="widget-body">
                    <fieldset>
                        <div class="col-md-9 form-group" style="float: left">
                            <label class="col-md-3 form-label"><b>유종구분 / 유종 / 제품</b></label>

                            <div class="col-md-9" style="text-align: center; vertical-align: bottom;">
                                <select id="firstOpt" style="width: 200px;" class="selectBox">
                                    <option>
                                        ====== 유종구분 ======
                                    </option>
                                </select>
                                <select id="secondOpt" style="width: 200px;" class="selectBox">
                                    <option>
                                        ======= 유종 =======
                                    </option>
                                </select>
                                <select id="thirdOpt" style="width: 200px;" class="selectBox">
                                    <option>
                                        ======= 제품 =======
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div style="float: right; text-align: right;">
                            <button id="search" class="btn btn-primary">
                                <i class="fa fa-search"></i> 조회
                            </button>
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
    <!--  real grid section content -->
    <div role="content">
        <div class="dt-toolbar">
            <div class="col-sm-6">
                <div class="txt-guide">
                    <!--※ 업체명을 클릭하시면 상세정보창이 표시됩니다.-->
                </div>
            </div>
            <div class="col-sm-6 text-right">
                <%--<button id="appendRow" class="btn btn-primary">
                    <i class="fa fa-plus"></i> 행추가
                </button>--%>
                <button id="standAdd" class="btn btn-primary">
                    <i class="fa fa-plus"></i> 시험기준추가
                </button>
                <button id="save" class="btn btn-primary">
                    <i class="fa fa-save"></i> 저장
                </button>
            </div>
        </div>

        <iframe id="realFrame" frameborder="no" cellpadding="0" cellspacing="0"
                src="<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/iframe.do'/>"
                style="width: 100%; height: 550px; padding:0px;">

        </iframe>

        <%-- <footer>
             <div class="dt-footbar">
             </div>
         </footer>--%>
        <!-- end of realgrid Content -->
    </div>
    <%--    <div role="main" class="ui-content jqm-content" align="center">
            <div id="realgrid1" style="width: 100%; height: 550px;"></div>
        </div>--%>
</div>


<%--<div id="listbody1">

</div>--%>


<!-- 기준추가 상세 모달창------------------------------------------------------------------------ -->

<div class="modal fade" id="modalPopUp1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel">시험기준추가</h4>
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
                                        <div class="col-md-6 form-group">
                                            <label class="col-md-3 form-label"><b>항목명 조회</b></label>

                                            <div class="col-md-9">
                                                <div class="col-sm-10 form-button">
                                                    <input id="searchKeyword3" type="text"
                                                           class="form-control inputBox">
                                                </div>
                                                <div class="col-sm-2 form-button">
                                                    <button class="btn btn-default btn-primary" type="button"
                                                            id="search3">
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
                        <button id="modalAdd" class="btn btn-primary">추가</button>
                        <button id="modalDelete" class="btn btn-primary">삭제</button>
                        <button id="modalSave" class="btn btn-primary">저장</button>

                    </div>
                    <div class="div-realgrid">
                        <div id="realgrid" style="width: 100%; height: 500px;"></div>
                    </div>

                    <!-- Footer -->
                    <!-- Footer End -->
                    <!-- end of realgrid Content -->
                </div>
                <!-- -----------------------------------------------------------------------------------  -->
            </div>
            <!-- Modal Body End-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>


<!-- 작성완료 -->

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




