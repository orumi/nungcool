<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>목록</title>
    <script type="text/javascript" src="<c:url value='/script/realgridjs_lic.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs_eval.1.0.13.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs-api.1.0.13.js'/>"></script>
    <script type="text/javaScript" language="javascript" defer="defer">

        var contextPath = '<%=request.getContextPath()%>';
        var officeID;
        var itemID;
        var itemPID;
        var methodID;

        $(function () {
            $("#save").click(save);
            $("#delete").click(deleteTriger);
        })

        function loadTriger() {

            officeID = window.opener.getOfficeID();
            itemID = window.opener.getItemID();
            itemPID = window.opener.getItemPID();
            methodID = window.opener.getMethodID();

            load(officeID);
            var loadRightSettingValue = loadRightSetting(itemID, itemPID, methodID);
            loadRight(loadRightSettingValue);

        }

        function loadRightSetting(itemID, itemPID, methodID) {

            var SettingValue = new Object();

            SettingValue.itemID = itemID;
            SettingValue.itemPID = itemPID;
            SettingValue.methodID = methodID;

            var stringfied = JSON.stringify(SettingValue)

            return stringfied;


        }

        function save() {

            var rows = gridView.getCheckedRows();

            var repoArr = [];

            for (var i = 0; i < rows.length; i++) {
                var valueJson = gridView.getValues(rows[i]);

                valueJson.officeID = officeID;
                valueJson.itemID = itemID;
                valueJson.itemPID = itemPID;
                valueJson.methodID = methodID;

                repoArr.push(valueJson);
            }

            var stringfied = JSON.stringify(repoArr);

            sendSaveData(stringfied);
        }

        function sendSaveData(data) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/savePopData.do'/>",
                type: "POST",
                data: {"data": data},
                dataType: "JSON",
                success: function (data) {
                    loadTriger();
                    window.opener.reload();
                },
                error: function (request, status, error) {
                    loadTriger();
                }
            });

        }

        function load(officeID) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/loadAdmin.do'/>",
                type: "POST",
                data: {"data": officeID},
                dataType: "json",
                success: function (data) {
                    dataProvider.fillJsonData(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function loadRight(loadRightSettingValue) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/loadRight.do'/>",
                type: "POST",
                data: {"data": loadRightSettingValue},
                dataType: "json",
                success: function (data) {
                    dataProvider2.fillJsonData(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function deleteSetting() {

            var arr = [];
            var checkedRows = gridView2.getCheckedRows();

            for (var i = 0; i < checkedRows.length; i++) {

                var value = gridView2.getValues(checkedRows[i]);

                value.itemID = itemID;
                value.itemPID = itemPID;

                arr.push(value);
            }

            var stringified = JSON.stringify(arr);

            return stringified;

        }

        function deleteAdmins(data) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/testItemManagement/genReqTestProp/deleteAdmins.do'/>",
                type: "POST",
                data: {"data": data},
                dataType: "json",
                success: function (data) {
                    loadTriger();
                    window.opener.reload();
                },
                error: function (request, status, error) {
                    loadTriger();
                }
            });
        }

        function deleteTriger() {


            var data = deleteSetting();

            deleteAdmins(data);


        }


    </script>
    <script>

        var gridView;
        var dataProvider;
        var gridView2;
        var dataProvider2;

        $(document).ready(function () {
            RealGridJS.setTrace(false);
            RealGridJS.setRootContext("/script");
            dataProvider = new RealGridJS.LocalDataProvider();
            gridView = new RealGridJS.GridView("realgrid");
            gridView.setDataSource(dataProvider);
            dataProvider2 = new RealGridJS.LocalDataProvider();
            gridView2 = new RealGridJS.GridView("realgrid2");
            gridView2.setDataSource(dataProvider2);

            //필드를 가진 배열 객체를 생성합니다.
            var fields = [
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

            var fields2 = [
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
            //필드와 연결된 컬럼 배열 객체를 생성합니다.
            var columns = [
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
            var columns2 = [
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
            /* 그리드 row추가 옵션사용여부 */
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
                display: {},
                header: {},
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
                indicator: {
                    displayValue: "row"
                },
                stateBar: {
                    visible: false
                },
                display: {},
                header: {},
                select: {
                    style: RealGridJS.SelectionStyle.ROWS
                }
            });
            gridView.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true
            })
            gridView2.setEditOptions({
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
            gridView2.setStyles({
                selection: {
                    background: "#11000000",
                    border: "#88000000,1"
                }
            });
            loadTriger();
        });

    </script>
</head>
<html>
<body>
<div>
    관리자추가
</div>
<div id="realgrid" style=" width: 45%; height: 400px; float: left; "></div>
<div style=" width: 10%; height: 400px; float: left; align-content: center; vertical-align: center;display: table ">
    <div style="display: table-cell;vertical-align: middle; text-align: center">
        <button id="save"> > </button><br/>
        <button id="delete"> < </button>
    </div>
</div>
<div id="realgrid2" style="width: 45%; height: 400px; float: right;"></div>

</body>
</html>
