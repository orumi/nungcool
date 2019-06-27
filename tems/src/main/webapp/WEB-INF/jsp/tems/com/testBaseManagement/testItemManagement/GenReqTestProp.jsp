<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%
    LoginUserVO vo = (LoginUserVO) session.getAttribute("loginUserVO");
    String userID = vo.getAdminid();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>목록</title>
    <script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
    <script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
    <script type="text/javaScript" language="javascript" defer="defer">


        var CodeNameArr = ${CodeNameArr};
        var CodeIDArr = ${CodeIDArr};
        var officeIDArr = ${officeIDArr};
        var officeNameArr = ${nameArr};
        var searchFlag = false;
        var userID = '<%= userID %>';
        var selectedMethodName;
        var index;

        <!-- 시험방법추가 변수들-->
        var officeID;
        var itemID;
        var methodID;
        var itemPID;
        var itemName;
        var addItemID;
        var addItemPID;
        <!-- 시험방법추가 변수들 END -->

        <!-- 담당자 관련 변수들-->

        var adminItemID;
        var adminMethodID;
        var adminItemPID;
        var adminOfficeID;

        <!-- 담당자 관련 변수들 End-->

        <!-- Grid 변수들 -->
        var gridView;
        var dataProvider;
        var gridView2;
        var dataProvider2;
        var gridView3;
        var dataProvider3;
        var gridView4;
        var dataProvider4;
        <!-- Grid 변수들 -->

        $(function () {
            $("#load").click(loadTriger);
            $("#save").click(saveData);
            $("#selectGroup").change(selectGroupHandler);
            $("#searchData").click(searchTriger);
            $("#adminList").change(selectModalGroupHandler)
            $("#adminSave").click(adminSave);
            $("#adminDelete").click(deleteAdminsTriger);
            $("#modalSearch").click(modalSearch);
        })


        function modalSearch() {

                var searchKeyword = $("#searchKeyword").val();
                $.ajax({

                    url: "<c:url value='/com/testBaseManagement/testMethodManagement/searchTestItems.do'/>",
                    type: "post",
                    data: {"data": searchKeyword},
                    success: function (data) {
                        dataProvider2.fillJsonData(data);
                    },
                    error: function (request, status, error) {
                        alert("code:" + request.status + "\n" + "error:" + error);
                    }
                });

        }

        function selectGroupHandler() {
            var value = $("#selectGroup").val();
            loadAdmin(value);
        }

        /*        function injection(methodID, methodName) {
         console.log(methodID + "  " + methodName + "  " + index);
         var jsonRow = gridView.getValues(index);
         var row = [jsonRow.itemID, jsonRow.itemPID, methodID, jsonRow.name, methodName];
         dataProvider.insertRow(index, row);
         gridView.setFocus();
         }*/

        function saveData() {
            gridView.commit();
            save();
        }

        function loadSetting() {

            $("#itemName").val("");
            $("#itemMethod").val("");
            $("#selectGroup").val("");
            $("#selectAdmin").append("<option value=''>" + "--항목기본담당자--" + "</option>");
        }

        function loadTriger() {

            searchFlag = false;
            load();
        }

        function load() {

            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/load.do'/>",
                data: {"data": "data"},
                success: function (data) {
                    dataProvider.fillJsonData(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });

            loadGroup();

        }

        function loadAdmin(value) {

            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/loadAdmin.do'/>",
                data: {"data": value},
                success: function (data) {
                    injectAdmin(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function loadGroup() {

            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/loadGroup.do'/>",
                data: {"data": "data"},
                success: function (data) {
                    injectGroup(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function loadLocation() {

            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/loadGroup.do'/>",
                data: {"data": "data"},
                success: function (data) {
                    lookupDataChange();
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });

        }

        function injectGroup(data) {

            for (var i = 0; i < data.length; i++) {
                var temp = data[i];
                $("#selectGroup").append("<option value='" + temp.officeID + "'>" + temp.name + "</option>");
            }
        }

        function removeAdmin() {

            $("#selectAdmin").find("option").remove();

        }

        function injectAdmin(data) {

            removeAdmin();

            for (var i = 0; i < data.length; i++) {
                var temp = data[i];
                $("#selectAdmin").append("<option value='" + temp.name + "'>" + temp.name + "</option>");
            }
        }

        function getofficeID() {

            var tempID = officeID;
            return tempID;

        }
        function getItemID() {

            var tempID = itemID;
            return tempID;

        }
        function getItemPID() {

            var tempID = itemPID;
            return tempID;

        }
        function getMethodID() {

            var tempID = methodID;
            return tempID;

        }
        function getUserID() {

            var tempUserID = userID;
            return tempUserID;

        }

        function addValidation(jData) {

            if (jData.unitID == undefined || jData.ruleID == undefined) {

                alert('표준단위 및 표기유형은 반드시 입력 하셔야 합니다.');
                return false;
            }
        }

        function save() {

            var jData;
            var jRowsData = [];
            var rows = dataProvider.getAllStateRows();

            if (rows.updated.length > 0) {
                for (var i = 0; rows.updated.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.updated[i]);

                    if ((addValidation(jData)) == false) {
                        return;
                    };

                    jData.state = "updated";
                    jData.modifyID = userID;
                    jRowsData.push(jData);

                }
            }

            if (rows.created.length > 0) {
                for (var i = 0; rows.created.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.created[i]);

                    if ((addValidation(jData)) == false) {
                        return;
                    }
                    ;

                    jData.state = "created";
                    jData.regID = userID;
                    jRowsData.push(jData);
                }
            }

            var jsonv = JSON.stringify(jRowsData);

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/saveData.do'/>",
                type: "POST",
                data: {"data": jsonv},
                success: function (data) {
                    alert(data);
                    reload();
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });

        }

        function deleteData(data) {

            $.ajax({
                url: "<c:url value= '/com/testBaseManagement/testItemManagement/genReqTestProp/deleteData.do'/>",
                type: "POST",
                dataType: "TEXT",
                data: {"data": data},
                success: function (data) {
                    reload();
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });

        }

        function searchData(data) {

            $.ajax({
                url: "<c:url value= '/com/testBaseManageMent/testItemManagement/genReqTestProp/searchData.do'/>",
                type: "POST",
                dataType: "TEXT",
                data: {"data": data},
                success: function (data) {
                    dataProvider.fillJsonData(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });

        }

        function searchSetting() {

            var itemName = $("#itemName").val();
            var itemMethod = $("#itemMethod").val();
            var adminName = $("#selectAdmin option:selected").val();

            if (adminName == "-- 항목기본담당자 --") {
                adminName = "";
            }


            var json = new Object();

            json.itemName = itemName;
            json.itemMethod = itemMethod;
            json.adminName = adminName;

            var stringified = JSON.stringify(json);

            return stringified
        }

        function searchTriger() {

            searchFlag = true;

            var data = searchSetting();

            searchData(data);

        }

        function reload() {

            if (searchFlag == true) {
                searchTriger();
            } else if (searchFlag == false) {
                loadTriger();
            }

        }

        <!-- Add modal popUp methods-->

        function addModalTriger() {

            $("#modalPopUp").modal();
            $("#modalPopUp").on('shown.bs.modal', function () {
                gridView2.resetSize();
                loadAddModal();
            });
        }

        function loadAddModal() {

            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value= '/com/testBaseManagement/testMethodManagement/retrieve.do'/>",
                success: function (data) {
                    dataProvider2.fillJsonData(data);
                },
                error: function (xhr, status, error, data) {
                    $("#loadResult").css("color", "red").text("Load failed: " + error).show();
                },
                complete: function (data) {
                    gridView.hideToast();
                },
                cache: false
            });
        }

        function addService(rows) {

            var row = [addItemID, addItemPID, rows.methodID, itemName, rows.name];
            dataProvider.insertRow(index, row);
            gridView.setFocus();

            addSave();


        }

        function addSave() {

            var jData;
            var jRowsData = [];
            var rows = dataProvider.getAllStateRows();

            // 혹시 안되면
            /*if (rows.updated.length > 0) {
                for (var i = 0; rows.updated.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.updated[i]);
                    jData.state = "updated";
                    jData.modifyID = userID;
                    jData.unitID = "필수입력";
                    jData.ruleID = 0;
                    jRowsData.push(jData);

                }
            }*/

            if (rows.created.length > 0) {
                for (var i = 0; rows.created.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.created[i]);
                    // 아래는 디폴트로 넣어주는 값들 when 저장
                    jData.unitID = "필수입력";
                    jData.ruleID = 39;
                    jData.state = "created";
                    jData.regID = userID;
                    jData.useFlag = 'Y'

                    jRowsData.push(jData);
                }
            }

            var jsonv = JSON.stringify(jRowsData);

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/saveData.do'/>",
                type: "POST",
                data: {"data": jsonv},
                success: function (data) {
                    alert(data);
                    reload();
                    $("#modalPopUp").modal("hide");
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });

        }

        <!-- Add modal popUp methods Ends-->



        <!-- Admin modal popUp methods Starts-->
        function loadModalGroup() {

            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/loadGroup.do'/>",
                data: {"data": "data"},
                success: function (data) {
                    injectModalGroup(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function injectModalGroup(data) {

            for (var i = 0; i < data.length; i++) {
                var temp = data[i];
                $("#adminList").append("<option value='" + temp.officeID + "'>" + temp.name + "</option>");
            }
        }

        function selectModalGroupHandler() {
            var value = $("#adminList").val();
            loadModalAdmin(value);
        }

        function loadModalAdmin(value) {

            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/loadAdmin.do'/>",
                data: {"data": value},
                success: function (data) {
                    dataProvider3.fillJsonData(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });

        }

        function adminSave() {

            var rows = gridView3.getCheckedRows();

            var repoArr = [];

            for (var i = 0; i < rows.length; i++) {
                var valueJson = gridView3.getValues(rows[i]);

                valueJson.officeID = adminOfficeID;
                valueJson.itemID = adminItemID;
                valueJson.itemPID = adminItemPID;
                valueJson.methodID = adminMethodID;

                repoArr.push(valueJson);
            }

            var stringfied = JSON.stringify(repoArr);

            sendAdminDataToSave(stringfied);
        }

        function sendAdminDataToSave(data) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/savePopData.do'/>",
                type: "POST",
                data: {"data": data},
                dataType: "JSON",
                success: function (data) {
                    loadRightTriger();
                    reload();
                },
                error: function (request, status, error) {

                }
            });

        }

        <!-- 오른쪽!! -->

        function loadRightTriger() {

            var loadRightSettingValue = loadRightSetting();

            loadRight(loadRightSettingValue);
        }

        function loadRightSetting() {

            var SettingValue = new Object();

            SettingValue.itemID = adminItemID;
            SettingValue.itemPID = adminItemPID;
            SettingValue.methodID = adminMethodID;

            var stringValue = JSON.stringify(SettingValue)

            return stringValue;

        }

        function loadRight(loadRightSettingValue) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/loadRight.do'/>",
                type: "POST",
                data: {"data": loadRightSettingValue},
                dataType: "json",
                success: function (data) {
                    dataProvider4.fillJsonData(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function deleteAdmins(data) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/deleteAdmins.do'/>",
                type: "POST",
                data: {"data": data},
                dataType: "json",
                success: function (data) {
                    loadRightTriger();
                    reload();
                },
                error: function (request, status, error) {

                }
            });
        }

        function deleteAdminSetting() {

            var arr = [];
            var checkedRows = gridView4.getCheckedRows();

            for (var i = 0; i < checkedRows.length; i++) {

                var value = gridView4.getValues(checkedRows[i]);
                value.itemID = adminItemID;
                value.itemPID = adminItemPID;
                arr.push(value);
            }

            var stringified = JSON.stringify(arr);

            return stringified;
        }

        function deleteAdminsTriger() {

            var data = deleteAdminSetting();
            deleteAdmins(data);
        }


        <!-- 오른쪽!! -->

        function adminModalTriger() {

            $("#adminModal").modal();

            $("#adminModal").on('shown.bs.modal', function () {

                gridView3.resetSize();
                gridView4.resetSize();
                loadRightTriger();
            });
        }


        <!-- Admin modal popUp methods Ends-->

        $(document).ready(function () {

            RealGridJS.setTrace(false);
            RealGridJS.setRootContext("<c:url value='/script'/>");

            dataProvider = new RealGridJS.LocalDataProvider();
            gridView = new RealGridJS.GridView("realgrid");
            gridView.setDataSource(dataProvider);

            dataProvider2 = new RealGridJS.LocalDataProvider();
            gridView2 = new RealGridJS.GridView("realgrid2");
            gridView2.setDataSource(dataProvider2);

            dataProvider3 = new RealGridJS.LocalDataProvider();
            gridView3 = new RealGridJS.GridView("realgrid3");
            gridView3.setDataSource(dataProvider3);

            dataProvider4 = new RealGridJS.LocalDataProvider();
            gridView4 = new RealGridJS.GridView("realgrid4");
            gridView4.setDataSource(dataProvider4);

            //필드를 가진 배열 객체를 생성합니다.
            var fields = [
                {
                    fieldName: "itemID"
                }
                , {
                    fieldName: "itemPID"
                }
                , {
                    fieldName: "methodID"
                }
                , {
                    fieldName: "name"
                }
                , {
                    fieldName: "methodName"  // tce_method테이블의 name이다 중복이름 때문에 methodName으로 명명
                }
                , {
                    fieldName: "add"
                }
                , {
                    fieldName: "unitID"
                }
                , {
                    fieldName: "smpAmount"
                }
                , {
                    fieldName: "range"
                }
                , {
                    fieldName: "ruleID"
                }
                , {
                    fieldName: "displayType"
                }
                , {
                    fieldName: "displayScript"
                }
                , {
                    fieldName: "repeat"
                }
                , {
                    fieldName: "kolasFlag"
                }
                , {
                    fieldName: "cycle"
                }
                , {
                    fieldName: "term"
                }
                , {
                    fieldName: "calc"
                }
                , {
                    fieldName: "temperCond"
                }
                , {
                    fieldName: "timeCond"
                }
                , {
                    fieldName: "regID"
                }
                , {
                    fieldName: "regDate"
                }
                , {
                    fieldName: "modifyID"
                }
                , {
                    fieldName: "modifyDate"
                }
                , {
                    fieldName: "useFlag"
                }
                , {
                    fieldName: "admin"
                }
                , {
                    fieldName: "location"
                }
            ];

            var fields2 = [
                {
                    fieldName: "methodID"
                }
                , {
                    fieldName: "version"
                }
                , {
                    fieldName: "name"
                }
                , {
                    fieldName: "kName"
                }
                , {
                    fieldName: "kUrl"
                }
            ];

            var fields3 = [
                {
                    fieldName: "adminID"
                },
                {
                    fieldName: "officeID"
                },
                {
                    fieldName: "name"
                },
                {
                    fieldName: "officeName"
                }
            ];

            var fields4 = [
                {
                    fieldName: "adminID"
                },
                {
                    fieldName: "officeID"
                },
                {
                    fieldName: "name"
                },
                {
                    fieldName: "officeName"
                },
                {
                    fieldName: "methodID"
                }
            ];


            //DataProvider의 setFields함수로 필드를 입력합니다.
            dataProvider.setFields(fields);
            dataProvider2.setFields(fields2);
            dataProvider3.setFields(fields3);
            dataProvider4.setFields(fields4);

            //필드와 연결된 컬럼 배열 객체를 생성합니다.
            var columns = [
                {
                    name: "name",

                    fieldName: "name",
                    header: {
                        text: "항목명"
                    },
                    styles: {
                        textAlignment: "near"
                    },
                    width: 150,
                    mergeRule: {criteria: "value"},
                }
                , {
                    name: "methodName",
                    fieldName: "methodName",
                    header: {
                        text: "시험방법명"
                    },
                    styles: {
                        textAlignment: "near"
                    },
                    width: 150,
                    readOnly: "true",
                    button: "action",
                    alwaysShowButton: true
                }
                , {
                    editButtonVisibility: "always",
                    name: "add",
                    fieldName: "add",
                    header: {
                        text: "시험방법 추가"
                    },
                    width: 80,
                    "button": "action",
                    alwaysShowButton: true
                }
                , {
                    name: "unitID",
                    fieldName: "unitID",
                    header: {
                        text: "표준단위"
                    },
                    width: 70
                }
                , {
                    name: "term",
                    fieldName: "term",
                    header: {
                        text: "처리기간"
                    },
                    width: 70
                }
                , {
                    name: "smpAmount",
                    fieldName: "smpAmount",
                    header: {
                        text: "시료량"
                    },
                    styles: {
                        textAlignment: "far",
                        numberFormat: "000,000"
                    },
                    width: 70
                }
                , {
                    name: "ruleID",
                    fieldName: "ruleID",
                    header: {
                        text: "표기유형"
                    },
                    editButtonVisibility: "always",
                    lookupDisplay: "true",
                    values: CodeIDArr,
                    labels: CodeNameArr,
                    editor: {
                        type: "dropDown",
                        dropDownCount: 7
                    },
                    width: 80
                }
                , {
                    name: "calc",
                    fieldName: "calc",
                    header: {
                        text: "계산식"
                    },
                    width: 70
                }
                , {
                    name: "displayType",
                    fieldName: "displayType",
                    header: {
                        text: "표기법"
                    },
                    width: 70
                }
                , {
                    name: "repeat",
                    fieldName: "repeat",
                    header: {
                        text: "반복성"
                    },
                    width: 70
                }
                , {
                    name: "kolasFlag",
                    fieldName: "kolasFlag",
                    header: {
                        text: "KOLAS 여부"
                    },
                    width: 70
                }
                , {
                    name: "cycle",
                    fieldName: "cycle",
                    header: {
                        text: "보정주기"
                    },
                    width: 70
                }
                /*, {
                 name: "location",
                 fieldName: "location",
                 header: {
                 text: "담당지점"
                 },
                 editButtonVisibility: "always",
                 lookupDisplay: "true",
                 values: officeIDArr,
                 labels: nameArr,
                 editor: {
                 type: "dropDown",
                 dropDownCount: 7
                 },
                 width: 200
                 }*/
                , {
                    name: "admin",
                    fieldName: "admin",
                    header: {
                        text: "담당자"
                    },
                    styles: {
                        textAlignment: "near"
                    },
                    width: 300,
                    "button": "action",
                    alwaysShowButton: true
                }
                , {
                    name: "useFlag",
                    fieldName: "useFlag",
                    header: {
                        text: "사용여부"
                    },
                    editButtonVisibility: "always",
                    lookupDisplay: "true",
                    values: ["Y", "N"],
                    labels: ["Y", "N"],
                    editor: {
                        type: "dropDown",
                        dropDownCount: 2
                    },
                    width: 80
                }
            ];

            var columns2 = [
                {
                    name: "methodID",
                    fieldName: "methodID",
                    header: {
                        text: "시험방법아이디"
                    },
                    width: 50
                }
                , {
                    name: "version",
                    fieldName: "version",
                    header: {
                        text: "버전"
                    },
                    width: 60
                }
                , {
                    name: "name",
                    fieldName: "name",
                    header: {
                        text: "시험방법"
                    },
                    width: 200
                }
                , {
                    name: "kName",
                    fieldName: "kName",
                    header: {
                        text: "KIGIS 명"
                    },
                    width: 200
                }
                , {
                    name: "kUrl",
                    fieldName: "kUrl",
                    header: {
                        text: "KIGIS URL"
                    },
                    width: 205
                }
            ];

            var columns3 = [
                {
                    name: "name",
                    fieldName: "name",
                    header: {
                        text: "관리자 이름"
                    },
                    width: 150
                },
                {
                    name: "officeName",
                    fieldName: "officeName",
                    header: {
                        text: "부서이름"
                    },
                    width: 150
                }
            ];
            var columns4 = [
                {
                    name: "name",
                    fieldName: "name",
                    header: {
                        text: "관리자 이름"
                    },
                    width: 150
                },
                {
                    name: "officeName",
                    fieldName: "officeName",
                    header: {
                        text: "부서이름"
                    },
                    width: 150
                }
            ];

            //컬럼을 GridView에 입력 합니다.
            gridView.setColumns(columns);
            gridView2.setColumns(columns2);
            gridView3.setColumns(columns3);
            gridView4.setColumns(columns4);

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
                select: {
                    style: RealGridJS.SelectionStyle.ROWS
                }
            });

            gridView2.setOptions({
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
                }
            });

            gridView3.setOptions({
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
                }
            });

            gridView4.setOptions({
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
                }
            });

            gridView.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true
            });
            gridView2.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true
            });
            gridView3.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true
            });
            gridView4.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true
            });

            gridView.setStyles(smart_style);
            gridView2.setStyles(smart_style);
            gridView3.setStyles(smart_style);
            gridView4.setStyles(smart_style);

            gridView.onCellButtonClicked = function (grid, itemIndex, column) {

                gridView.commit();

                if (column.fieldName == 'add') {

                    var rows = gridView.getValues(itemIndex);

                    itemName = rows.name;
                    addItemID = rows.itemID;
                    addItemPID = rows.itemPID;

                    addModalTriger();

                    /*var popUrl = "
                    <c:url value= '/com/testBaseManagement/testItemManagement/genReqTestProp/propPopUp.do' />";	//팝업창에 출력될 페이지 URL
                     var popOption = "width=850, height=600, resizable=no, scrollbars=no, status=no";    //팝업창 옵션(optoin)
                     window.open(popUrl, "시험조건", popOption);*/

                }

                if (column.fieldName == 'methodName') {

                    var json = gridView.getValues(itemIndex);
                    json = JSON.stringify(json);
                    deleteData(json);
                }

                if (column.fieldName == 'admin') {

                    var selectedRow = gridView.getValues(itemIndex);

                    adminOfficeID = selectedRow.location;
                    adminItemID = selectedRow.itemID;
                    adminItemPID = selectedRow.itemPID;
                    adminMethodID = selectedRow.methodID;

                    /*if (officeID == undefined) {
                     alert('담당지점을 먼저 선택 해 주세요');
                     return
                     }*/

                    adminModalTriger();

                    /*var popUrl = "
                    <c:url value= '/com/testBaseManagement/testItemManagement/genReqTestProp/addAdminPopUp.do' />";	//팝업창에 출력될 페이지 URL
                     var popOption = "width=800, height=480";    //팝업창 옵션(optoin)
                     window.open(popUrl, "시험조건", popOption);*/

                }
            };

            gridView2.onDataCellDblClicked = function (grid, itemIndex, column) {

                var rows = gridView2.getValues(itemIndex.itemIndex);
                methodID = rows.methodID;
                window.returnValue = 'ok';
                addService(rows);
                gridView.setFocus();
                //window.close();

            };

            $("#modalPopUp").on('shown.bs.modal', function () {
                gridView2.resetSize();
                loadAddModal();
            });

            $("#adminModal").on('shown.bs.modal', function () {
                gridView3.resetSize();
                gridView4.resetSize();
                loadRightTriger();
            });

        });

        loadTriger();
        loadModalGroup();
    </script>
</head>
<body>
<input type="hidden" name="jsonTempRepo" id="jsonTempRepo">

<div class="page-content">
    <div role="content">
        <!--  start of  form-horizontal tems_search  -->
        <!--  start of widget-body -->
        <div class="form-horizontal form-terms ">
            <div class="jarviswidget jarviswidget-sortable" role="widget">
                <!--
                <header role="heading">
                <span class="widget-icon"> <i class="fa fa-edit"></i> </span>
                <h2>접수내역 조회</h2>
                </header>
                -->
                <!-- back -->
                <div class="widget-body">
                    <fieldset>
                        <div class="col-md-6 form-group ">
                            <label class="col-md-3 form-label"><b>항목명</b></label>

                            <div class="col-md-9">
                                <input id="itemName" type="text" class="form-control inputBox"/>
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="col-md-3 form-label"><b>시험방법</b></label>

                            <div class="col-md-9">
                                <input id="itemMethod" type="text" class="form-control inputBox"/>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <div class="col-md-6 form-group ">
                            <label class="col-md-3 form-label"><b>관리본부지점</b></label>

                            <div class="col-md-9">
                                <select class="form-control selectBox" id="selectGroup">
                                    <option>--관리본부지점--</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="col-md-3 form-label"><b>항목기본담당자</b></label>

                            <div class="col-md-9">
                                <div style="float: left; width: 90%">
                                    <select class="form-control selectBox" id="selectAdmin">
                                        <option>-- 항목기본담당자 --</option>
                                    </select>
                                </div>
                                <div style="float: left; width: 10%; vertical-align: bottom">
                                    <button id="searchData" class="btn btn-primary"> 조회</button>
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

    <div role="content">
        <div class="dt-toolbar">
            <div class="col-sm-6">
                <div class="txt-guide">
                    <!--※ 업체명을 클릭하시면 상세정보창이 표시됩니다.-->
                </div>
            </div>

            <div class="col-sm-6 text-right">
                <button id="load" class="btn btn-primary">
                    새로고침
                </button>
                <button id="save" class="btn btn-primary">
                    <i class="fa fa-save"></i> 저장
                </button>
            </div>
        </div>

        <div class="div-realgrid">
            <div id="realgrid" style="width: 100%; height: 550px;"></div>
        </div>

        <!-- end of realgrid Content -->
    </div>
</div>





















<!-- 시험방법 추가 MODAL-->
<div class="modal fade" id="modalPopUp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title">시험방법 추가가</h4>
           </div>
            <div class="modal-body requestBody">
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
                                                    <input id="searchKeyword" type="text" class="form-control inputBox">
                                                </div>
                                                <div class="col-sm-2 form-button">
                                                    <button class="btn btn-default btn-primary" type="button"
                                                            id="modalSearch">
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

                    <!-- realGrid -->
                    <div class="div-realgrid">
                        <div id="realgrid2" style="width: 100%; height: 500px;"></div>
                    </div>
                    <!-- realGrid End -->

                    <!-- Footer -->
                    <footer>
                        <div align="right" style="padding-top: 2px">
                            <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        </div>
                    </footer>
                    <!-- Footer End -->
                    <!-- end of realgrid Content -->
                </div>
                <!-- -----------------------------------------------------------------------------------  -->
            </div>
            <!-- Modal Body End-->
        </div>
    </div>
</div>

<!-- end of modal  -->
<!--End Of 시험방법 추가 MODAL-->


















<!-- 담당자 관련 모달------------------------------------------------------------------ -->
<div class="modal fade" id="adminModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title">담당자 관리</h4>


            </div>
            <div class="modal-body requestBody">
                <div style="width: 100%">

                    <select id="adminList" class="form-control selectBox" style="width: 200px">
                        <option>--부서선택--</option>
                    </select>

                </div>
                <div id="realgrid3" style=" width: 45%; height: 400px; float: left; "></div>
                <div style=" width: 10%; height: 400px; float: left; align-content: center; vertical-align: middle; display: table ">
                    <div style="display: table-cell;vertical-align: middle; text-align: center">
                        <button id="adminSave"> ></button>
                        <br/>
                        <button id="adminDelete"> <</button>
                    </div>
                </div>
                <div id="realgrid4" style="width: 45%; height: 400px; float: right;"></div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
    <!-- end of modal  -->
</div>


</body>
</html>
