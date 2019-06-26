<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title>팝업창 인생은 선택의 연속 선택 하시오</title>

</head>
<script>

    var allData;
    var gridView;
    var dataProvider;

    $(function () {
        $("#btnLoad").click(loadData);
        $("#add").click(add);
    });

    function setCheckBar() {

        allData = dataProvider.getJsonRows();

        for (var i = 0; i < allData.length; i++) {
            if (allData[i].cnt >= 1) {
                gridView.setCheckable(i, false);
            }
        }
    }

    function initSet() {

        setTimeout("setCheckBar()", 1000);
    }

    function add() {

        var masterID = window.opener.getMasterID();
        if (masterID == null) {

            alert('이 창을 닫은 후 원하시는 제품을 먼저 선택해 주세요');
            self.close();

        } else {

            var checkedRows = gridView.getCheckedRows();
            var dataArr = [];
            var stringfied;

            if (checkedRows.length == 0) {
                alert('원하시는 시험방법의 Check Bar를 클릭하여 주세요');
            }

            for (var i = 0; i < checkedRows.length; i++) {
                var jsonv = dataProvider.getJsonRow(checkedRows[i])
                dataArr.push(jsonv);
            }
            for (var i = 0; i < dataArr.length; i++) {
                dataArr[i].masterID = masterID;
            }
            stringfied = JSON.stringify(dataArr);
            saveData(stringfied);

            setTimeout("window.opener.loadRightOne();", 1000);

        }
    }

    function saveData(jsonObj) {

        var sendObj = JSON.stringify(jsonObj);

        $.ajax({
            type: "POST",
            dataType: "text",
            url: "<c:url value= '/com/testBaseManagement/testItemManagement/eleItemManage/savePopUp.do' />",
            data: {"data": sendObj},
            success: function (data) {
                if (data == '"이미 저장 된 값이 있습니다."') {
                    alert(data);
                }
            },
            error: function (xhr, status, error, data) {

            }
        });
    }

    function loadData() {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value= '/com/testBaseManagement/testItemManagement/eleItemManage/popUpLoad.do' />",
            data: {"data": "data"},
            success: function (data) {
                dataProvider.fillJsonData(data);
            },
            error: function (xhr, status, error, data) {
                $("#loadResult").css("color", "red").text("Load failed: " + error).show();
            }
        });
    }

    function setLookup(gridView) {

        gridView.setLookups([{
            "id": "colB_setLookup",
            "levels": 2,
            "keys": [
                ["a", "K0001"], ["a", "K0002"],
                ["b", "E0001"], ["b", "E0002"],
                ["c", "D0001"], ["c", "D0002"]
            ],
            "values": [
                "K0001_label", "K0002_label",
                "E0001_label", "E0002_label",
                "D0001_label", "D0002_label"
            ]
        }]);
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
                fieldName: "itemID"
            }
            , {
                fieldName: "itemPID"
            }
            , {
                fieldName: "methodID"
            }
            , {
                fieldName: "itemName"
            }
            , {
                fieldName: "testName"
            }
            , {
                fieldName: "price"
            }
            , {
                fieldName: "codeName"
            }
            , {
                fieldName: "unitID"
            }
            , {
                fieldName: "lvl"
            }
            , {
                fieldName: "cnt"
            }
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider.setFields(fields);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns = [
            {
                name: "itemID",
                fieldName: "itemID",
                header: {
                    text: "itemID"
                },
                width: 50,
                readOnly: true
            },
            {
                name: "itemPID",
                fieldName: "itemPID",
                header: {
                    text: "itemPID"
                },
                width: 50,
                readOnly: true
            },
            {
                name: "itemName",
                fieldName: "itemName",
                header: {
                    text: "항목"
                },
                width: 215,
                readOnly: true
            }
            , {
                name: "lvl",
                fieldName: "lvl",
                header: {
                    text: "레벨"
                },
                width: 40,
                readOnly: true
            }
            , {
                name: "price",
                fieldName: "price",
                header: {
                    text: "가격"
                },
                width: 60,
                readOnly: true
            }

            , {
                name: "cnt",
                fieldName: "cnt",
                header: {
                    text: "cnt"
                },
                width: 80,
                readOnly: true
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

        loadData();
        initSet();

    });
</script>
<body>

<input type="hidden" id="jsonTempRepo"/>

<div>

    <div>
        <div class="dd-handle" style="height : 38px">
            <div style="float: left; width: 80%;">
                <span style="float:left">추가 하고 싶은 항목을 더블클릭 하세요</span>
            </div>
            <div style="float: left;width: 20%;">
                <button id="add" style="float:right">추가</button>
            </div>
        </div>
    </div>

    <div>
        <div id="realgrid" style="width: 100%; height: 300px;"></div>
    </div>

    <%--    <div align="right">
            <button id="btnLoad" align="left">Load</button>
            <button id="btnSave" align="left">Save</button>
            <button id="btnAppend" align="left">Add</button>
            <button id="btnDelete" align="left">Delete</button>
        </div>--%>

</div>
</body>
</html>
