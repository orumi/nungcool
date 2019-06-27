<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>




<html>
<head>
    <title>Title</title>
</head>
<script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<script>

    var itemID = opener.document.getElementById("popUp").value;

    var regID = null;
    var tempCodeNameArr = ${tempCodeNameArr};
    var tempCodeIDArr = ${tempCodeIDArr};
    var timeCodeNameArr = ${timeCodeNameArr};
    var timeCodeIDArr = ${timeCodeIDArr};
    var etcCodeNameArr = ${etcCodeNameArr};
    var etcCodeIDArr = ${etcCodeIDArr};

    $(function () {
        $("#btnLoad").click(load);
        $("#btnSave").click(save);
        $("#btnAppend").click(btnAppendClickHandler);
        $("#btnDelete").click(btnDeleteClickHandler);
    });

    function save() {
        gridView.commit();
        saveData();
    }

    function btnDeleteClickHandler() {

        if (confirm("정말로 삭제 하시겠습니까?")) {
            var checkedRows = gridView.getCheckedRows();

            for (var i = 0; checkedRows.length > i; i++) {
                var num = checkedRows[i];
                dataProvider.setRowState(num, "deleted");
            }
            save();
        }
    }

    function load() {

        var contextPath = '<%=request.getContextPath()%>';

        $.ajax({
            url: contextPath + "/com/testBaseManagement/testItemManagement/getReqTestItem/popUpLoadData.do",
            type: "POST",
            data: {"data": itemID},
            dataType: "json",
            success: function (data) {
                dataProvider.fillJsonData(data);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }


    function loadUnit() {

        var contextPath = '<%=request.getContextPath()%>';

        $.ajax({
            url: contextPath + "/com/testBaseManagement/testItemManagement/getReqTestItem/loadUnit.do",
            type: "POST",
            dataType: "JSON",
            data: {"data": itemID},
            success: function (data) {

            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }


    function btnAppendClickHandler(e) {
        gridView.beginAppendRow();
    }

    function saveData() {

        var jData;
        var jRowsData = [];
        var rows = dataProvider.getAllStateRows();

        if (rows.updated.length > 0) {
            for (var i = 0; rows.updated.length > i; i++) {
                jData = dataProvider.getJsonRow(rows.updated[i]);
                jData.state = "updated";
                jData.modifyID = $("#userID").val();
                jRowsData.push(jData);
            }
        }
        if (rows.created.length > 0) {
            for (var i = 0; rows.created.length > i; i++) {
                jData = dataProvider.getJsonRow(rows.created[i]);
                jData.state = "created";
                jData.itemID = itemID;
                jData.regID = $("#userID").val();
                jRowsData.push(jData);
            }
        }
        if (rows.deleted.length > 0) {
            for (var i = 0; rows.deleted.length > i; i++) {
                jData = dataProvider.getJsonRow(rows.deleted[i]);
                jData.state = "deleted";
                jRowsData.push(jData);
            }
        }

        var jsonv = $('#jsonTempRepo').val = JSON.stringify(jRowsData);

        $.ajax({
            url: "/com/testBaseManagement/testItemManagement/getReqTestItem/popUpSaveData.do",
            type: "POST",
            data: {"data": jsonv},
            dataType: "text",
            success: function (data) {
                load();
                alert(data);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

</script>

<script type="">

    var gridView;
    var dataProvider;

    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("<c:url value='/script'/>");
        dataProvider = new RealGridJS.LocalDataProvider();
        gridView = new RealGridJS.GridView("realgrid");
        gridView.setDataSource(dataProvider);

        //필드를 가진 배열 객체를 생성합니다.
        var fields = [
            {
                fieldName: "itemID"
            }
            , {
                fieldName: "temperCond"
            }
            , {
                fieldName: "timeCond"
            }
            , {
                fieldName: "etc"
            }
            , {
                fieldName: "tempUnit"
            }
            , {
                fieldName: "timeCondUnit"
            }
            , {
                fieldName: "etcUnit"
            }
            , {
                fieldName: "condID"
            }
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider.setFields(fields);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns = [

            {
                name: "temperCond",
                fieldName: "temperCond",
                header: {
                    text: "온도조건"
                },
                width: 80
            }
            , {
                name: "tempUnit",
                fieldName: "tempUnit",
                header: {
                    text: "온도 단위"
                },
                editButtonVisibility: "always",
                lookupDisplay: "true",
                values: tempCodeIDArr,
                labels: tempCodeNameArr,
                editor: {
                    type: "dropDown",
                    dropDownCount: 2
                },
                width: 80
            }
            , {
                name: "timeCond",
                fieldName: "timeCond",
                header: {
                    text: "시간조건"
                },
                width: 80
            }
            , {
                name: "timeCondUnit",
                fieldName: "timeCondUnit",
                header: {
                    text: "시간 단위"
                },
                editButtonVisibility: "always",
                lookupDisplay: "true",
                values: timeCodeIDArr,
                labels: timeCodeNameArr,
                editor: {
                    type: "dropDown",
                    dropDownCount: 2
                },
                width: 80
            }
            , {
                name: "etc",
                fieldName: "etc",
                header: {
                    text: "기타 조건"
                },
                width: 80
            }
            , {
                name: "etcUnit",
                fieldName: "etcUnit",
                header: {
                    text: "기타 단위"
                },
                editButtonVisibility: "always",
                lookupDisplay: "true",
                values: etcCodeIDArr,
                labels: etcCodeNameArr,
                editor: {
                    type: "dropDown",
                    dropDownCount: 2
                },
                width: 80
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

        load();

    });

</script>
<body>

<input type="hidden" id="jsonTempRepo"/>
<%
    LoginUserVO loginUserVO = (LoginUserVO) session.getAttribute("loginUserVO");
    String userID = (String) loginUserVO.getAdminid();
%>

<input type="hidden" id="userID" value="<%=userID%>"/>
<div class="col-xs-12">
    <div class="dd-handle" style="width: 100px;">
        시험조건
    </div>
    <div>
        <div id="realgrid" style="width: 100%; height: 300px;"></div>
    </div>

    <div align="right">
        <button id="btnLoad" align="left">Load</button>
        <button id="btnSave" align="left">Save</button>
        <button id="btnAppend" align="left">Add</button>
        <button id="btnDelete" align="left">Delete</button>
    </div>

</div>
</body>
</html>
