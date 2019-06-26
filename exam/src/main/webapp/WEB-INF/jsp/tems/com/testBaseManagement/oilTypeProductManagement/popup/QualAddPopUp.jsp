<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ page import="oracle.jdbc.util.Login" %>
<%@ page import="org.hsqldb.Session" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title>시험기준 추가</title>

</head>
<script>
    <%
      LoginUserVO loginUserVO = (LoginUserVO) session.getAttribute("loginUserVO");
    %>

    var allData;
    var gridView;
    var dataProvider;
    var masterID;
    var loginID = '<%=loginUserVO.getName()%>';

    $(function () {

        $("#save").click(saveTriger);
        $("#add").click(add);
        $("#delete").click(deleteConfirm);

    });

    function refreshParents(){
        window.opener.search();
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
                alert(data)
                loadTriger();
                refreshParents();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }

    function deleteDataTriger() {

        var preparedJson = deleteSetting();

        deleteData(preparedJson);
    }

    function add() {
        gridView.beginAppendRow();
    }

    function getMasterIDFromParents() {

        masterID = window.opener.getMasterID()

        return masterID;
    }

    function loadTriger() {

        getMasterIDFromParents();

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

    function saveTriger() {

        gridView.commit();
        saveData();

    }

    function saveData() {

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
                refreshParents();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }


    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("/script");
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
        loadTriger();

    });
</script>
<body>

<input type="hidden" id="jsonTempRepo"/>

<div>

    <div>
        <div class="dd-handle" style="height : 38px">
            <div style="float: left; width: 40%;">
                <span style="float:left">기준 추가</span>
            </div>
            <div style="float: left;width: 60%;">
                <button id="delete" style="float:right">삭제</button>
                <button id="save" style="float:right">저장</button>
                <button id="add" style="float:right">추가</button>
            </div>
        </div>
    </div>

    <div>
        <div id="realgrid" style="width: 100%; height: 300px;"></div>
    </div>

</div>
</body>
</html>
