<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<script>

    <%
    LoginUserVO loginUserVO = (LoginUserVO) session.getAttribute("loginUserVO");
    %>

    var gridView;
    var dataProvider;
    var gridView2;
    var dataProvider2;
    var loginID = '<%=loginUserVO.getName()%>';
    var codeGroupID;


    $(function () {

        $("#save").click(saveTriger);
        $("#save2").click(saveTriger2);
        $("#add").click(add);
        $("#add2").click(add2);
        $("#delete").click(deleteTriger);
        $("#delete2").click(deleteTriger2);
        $("#cancel").click(cancel);
        $("#cancel2").click(cancel2);
    })

    function setCodeGroupID(str) {
        codeGroupID = str;
    }

    function cancel() {
        gridView.commit();
        loadDataLeft();
    }

    function cancel2() {
        gridView2.commit();
        loadDataRight(codeGroupID);
    }


    function loadDataLeft() {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/system/codeManage/loadDataLeft.json'/>",
            data: {"data": "data"},
            success: function (data) {
                dataProvider.fillJsonData(data);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function loadDataRight(data) {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/system/codeManage/loadDataRight.json'/>",
            data: {"data": data},
            success: function (data) {
                dataProvider2.fillJsonData(data);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }

    function add() {
        gridView.beginAppendRow();
    }

    function add2() {
        gridView2.beginAppendRow();
    }

    function settingBeforeSave() {

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
                jData.regID = loginID;
                jRowsData.push(jData);
            }
        }

        return JSON.stringify(jRowsData);

    }

    function settingBeforeSave2() {

        gridView2.commit();

        var jData;
        var jRowsData = [];
        var rows = dataProvider2.getAllStateRows();

        if (rows.updated.length > 0) {
            for (var i = 0; rows.updated.length > i; i++) {
                jData = dataProvider2.getJsonRow(rows.updated[i]);
                jData.state = "updated";
                jData.modifyID = loginID;
                jRowsData.push(jData);
            }
        }

        if (rows.created.length > 0) {
            for (var i = 0; rows.created.length > i; i++) {
                jData = dataProvider2.getJsonRow(rows.created[i]);
                jData.state = "created";
                jData.regID = loginID;
                jData.codeGroupID = codeGroupID;
                jRowsData.push(jData);
            }
        }

        return JSON.stringify(jRowsData);
    }


    function sendDataToSave(data) {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/system/codeManage/saveData.json'/>",
            data: {"data": data},
            success: function (data) {
                loadDataLeft();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function sendDataToSave2(data) {

        $.ajax({
            type: "POST",
            dataType: "TEXT",
            url: "<c:url value='/system/codeManage/saveDataRight.json'/>",
            data: {"data": data},
            success: function (data) {
                loadDataRight(codeGroupID);
                alert(data);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }


    function saveTriger() {
        var data = settingBeforeSave();
        sendDataToSave(data);
    }


    function saveTriger2() {
        var data = settingBeforeSave2();
        sendDataToSave2(data);
    }

    function settingBeforDelete() {

        var rows = gridView.getCheckedRows();
        var jRows = [];
        for (var i = 0; i < rows.length; i++) {

            var json = gridView.getValues(rows[i]);
            jRows.push(json);
        }

        var preparedJson = JSON.stringify(jRows);

        return preparedJson;
    }

    function settingBeforDelete2() {

        var rows = gridView2.getCheckedRows();
        var jRows = [];
        for (var i = 0; i < rows.length; i++) {

            var json = gridView2.getValues(rows[i]);
            jRows.push(json);
        }

        var preparedJson = JSON.stringify(jRows);

        return preparedJson;
    }

    function sendDataToDelete(data) {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/system/codeManage/deleteData.json'/>",
            data: {"data": data},
            success: function (data) {
                loadDataLeft();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }


    function sendDataToDelete2(data) {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/system/codeManage/deleteDataRight.json'/>",
            data: {"data": data},
            success: function (data) {
                loadDataRight(codeGroupID);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function deleteTriger() {

        var data = settingBeforDelete();
        sendDataToDelete(data);

    }

    function deleteTriger2() {

        var data = settingBeforDelete2();
        sendDataToDelete2(data);

    }


    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("<c:url value='/script'/>");

        dataProvider = new RealGridJS.LocalDataProvider();
        gridView = new RealGridJS.GridView("realgrid");
        gridView.setDataSource(dataProvider);

        dataProvider2 = new RealGridJS.LocalDataProvider();
        gridView2 = new RealGridJS.GridView("realgrid2");
        gridView2.setDataSource(dataProvider2);

        //두 개의 필드를 가진 배열 객체를 생성합니다.
        var fields = [
            {
                fieldName: "codeGroupID"
            },
            {
                fieldName: "codeGroupName"
            },
            {
                fieldName: "useFlag"
            },
            {
                fieldName: "regID"
            },
            {
                fieldName: "regDate"
            },
            {
                fieldName: "modifyID"
            },
            {
                fieldName: "modifyDate"
            },
            {
                fieldName: "state"
            }
        ];
        var fields2 = [
            {
                fieldName: "codeGroupID"
            },
            {
                fieldName: "codeID"
            },
            {
                fieldName: "codeName"
            },
            {
                fieldName: "useFlag"
            },
            {
                fieldName: "regID"
            },
            {
                fieldName: "regDate"
            },
            {
                fieldName: "modifyID"
            },
            {
                fieldName: "modifyDate"
            }
        ];
        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider.setFields(fields);
        dataProvider2.setFields(fields2);

        //필드와 연결된 컬럼을 가진 배열 객체를 생성합니다.
        var columns = [
            {
                name: "codeGroupID",
                fieldName: "codeGroupID",
                header: {
                    text: "코드그룹ID"
                },
                width: 200,
                readOnly: true
            },
            {
                name: "codeGroupName",
                fieldName: "codeGroupName",
                header: {
                    text: "이름"
                },
                width: 400
            },
            {
                name: "useFlag",
                fieldName: "useFlag",
                header: {
                    text: "사용여부"
                },
                width: 135,
                editButtonVisibility: "always",
                lookupDisplay: "true",
                values: ["Y", "N"],
                labels: ["Y", "N"],
                editor: {
                    type: "dropDown",
                    dropDownCount: 2
                },

            }
        ];
        var columns2 = [
            {
                name: "codeID",
                fieldName: "codeID",
                header: {
                    text: "코드ID"
                },
                width: 200,
                readOnly: true
            },
            {
                name: "codeName",
                fieldName: "codeName",
                header: {
                    text: "이름"
                },
                width: 400
            },
            {
                name: "useFlag",
                fieldName: "useFlag",
                header: {
                    text: "사용여부"
                },
                width: 135,
                editButtonVisibility: "always",
                lookupDisplay: "true",
                values: ["Y", "N"],
                labels: ["Y", "N"],
                editor: {
                    type: "dropDown",
                    dropDownCount: 2
                }
            }
        ];
        //컬럼을 GridView에 입력 합니다.
        gridView.setColumns(columns);
        gridView2.setColumns(columns2);

        gridView.setOptions({
            panel: {
                visible: false
            },
            footer: {
                visible: false
            },
            indicator: {
                displayValue: "row"
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

        gridView2.setOptions({
            panel: {
                visible: false
            },
            footer: {
                visible: false
            },
            indicator: {
                displayValue: "row"
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
        gridView2.setEditOptions({
            insertable: true,
            appendable: true,
            deletable: true
        })

        gridView.setStyles(smart_style);
        gridView2.setStyles(smart_style);

        gridView.onDataCellDblClicked = function (grid, index) {
            var json = gridView.getValues(index.dataRow);
            var codeGroupID = json.codeGroupID;

            setCodeGroupID(codeGroupID); // 매 클릭마다 전역변수에 코드그룹아이디 저장 추가 할때 필요 하므로..

            loadDataRight(codeGroupID);
        };

    });

    loadDataLeft();

</script>

<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">
    <!-- 여기서 부터 내용 작성 -->
    <table width="100%">
        <tr>
            <td width="48%">
                <!-- <span class="label label-xlg label-primary arrowed arrowed-right">권한그룹</span> -->
                <div class="page-content">
                    <div role="content">
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <div class="widget-body">
                                    <fieldset>
                                        <div class="col-md-6 form-group" style="float: left; width: 300px">
                                            <label class="col-md-6 form-label"><b>코드 그룹</b></label>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="page-content">
                    <div class="text-right" style="float: right; width:40%; margin-bottom: 1px">
                        <button class="btn btn-primary" id="add">
                            <i class="ace-icon fa fa-pencil align-top bigger-125"></i>
                            추가
                        </button>
                        <button class="btn btn-primary" id="save">
                            <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                            저장
                        </button>
                        <button class="btn btn-primary" id="delete">
                            <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
                            삭제
                        </button>
                        <button class="btn btn-primary" id="cancel">
                            <i class="ace-icon fa fa-times red2"></i>
                            취소
                        </button>
                    </div>
                    <div class="div-realgrid">
                        <div id="realgrid" style="width: 100%; height: 500px;"></div>
                    </div>

                    <!-- Footer -->

                    <!-- Footer End -->
                    <!-- end of realgrid Content -->
                </div>

            </td>
            <td rowspan="2" width="4%">
                &nbsp;
            </td>
            <td width="48%">
                <!-- <span class="label label-xlg label-primary arrowed arrowed-right">권한그룹</span> -->
                <div class="page-content">
                    <div role="content">
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <div class="widget-body">
                                    <fieldset>
                                        <div class="col-md-6 form-group" style="float: left; width: 300px">
                                            <label class="col-md-6 form-label"><b>코드그룹 상세</b></label>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Content End-->

                    <div class="page-content">

                        <div class="text-right" style=" margin-bottom: 1px ">
                            <button class="btn btn-primary" id="add2">
                                <i class="ace-icon fa fa-pencil align-top bigger-125"></i>
                                추가
                            </button>
                            <button class="btn btn-primary" id="save2">
                                <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                                저장
                            </button>
                            <button class="btn btn-primary" id="delete2">
                                <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
                                삭제
                            </button>
                            <button class="btn btn-primary" id="cancel2">
                                <i class="ace-icon fa fa-times red2"></i>
                                취소
                            </button>
                        </div>

                        <div class="div-realgrid">
                            <div id="realgrid2" style="width: 100%; height: 500px;"></div>
                        </div>
                        <!-- end of realgrid Content -->
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <!-- 작성완료 -->
</div>




