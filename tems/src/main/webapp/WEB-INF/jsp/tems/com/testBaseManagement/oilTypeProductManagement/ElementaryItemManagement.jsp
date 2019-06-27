<%@ page import="java.util.List" %>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script type="text/javaScript" language="javascript" defer="defer">

    <%
            LoginUserVO loginUserVO = (LoginUserVO) session.getAttribute("loginUserVO");
            String userID = loginUserVO.getAdminid();
    %>

    var userID = '<%= userID %>';
    var contextPath = '<%= request.getContextPath()%>';
    var masterID;
    var jsonV;
    var gridView;
    var dataProvider;
    var gridView2;
    var dataProvider2;
    var gridView3;
    var dataProvider3;

    $(function () {

        $("#delete").click(deleteData);
        $("#loadData").click(loadData);
        $("#save").click(save);
        $("#selBox1").change(selBox1Handler);
        $("#selBox2Btn").click(selBox2BtnHandler);
        $("#addItem").click(modalUp);
        $("#modalAdd").click(add);
        $("#search3").click(fnSearch);
    })

    function fnSearch() {

        var keyword = $("#searchKeyword3").val();

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/com/testBaseManagement/testItemManagement/eleItemManage/modalSearch.do'/>",
            data: {"data": keyword},
            success: function (data) {
                dataProvider3.fillJsonData(data);
            },
            error: function (xhr, status, error, data) {
            }
        });

    }


    function loadDataLeft(stringfied, itemIndex) {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/com/testBaseManagement/testItemManagement/eleItemManage/loadDataLeft.do'/>",
            data: {"data": stringfied},
            success: function (data) {
                var json = data[0];
                var values = {
                    displayType: json.displayType,
                    unitID: json.unitID,
                    admin: json.admin
                }
                gridView2.setValues(itemIndex, values, true);
            },
            error: function (xhr, status, error, data) {
            }
        });

    }

    function deleteData() {

        var checkedRows = gridView2.getCheckedRows();
        var dataArr = [];
        var stringfied;

        if (checkedRows.length == 0) {
            alert('삭제를 원하시는 항목의 체크바를 체크해 주세요');
        }

        for (var i = 0; i < checkedRows.length; i++) {
            var jsonv = dataProvider2.getJsonRow(checkedRows[i])
            dataArr.push(jsonv);
        }

        for (var i = 0; i < dataArr.length; i++) {
            dataArr[i].masterID = masterID;
        }

        stringfied = JSON.stringify(dataArr);
        deleteRows(stringfied);

        setTimeout("loadRightOne();", 1000);

    }

    function deleteRows(data) {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/com/testBaseManagement/testItemManagement/eleItemManage/deleteData.do'/>",
            data: {"data": data},
            success: function (data) {

            },
            error: function (xhr, status, error, data) {
            }
        });

    }

    function loadTestMethod() {

        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/com/testBaseManagement/testItemManagement/eleItemManage/loadTestMethod.do'/>",
            data: {"data": masterID},
            success: function (data) {
                lookupDataChange1(data)
            },
            error: function (xhr, status, error, data) {
            }
        });
    }

    function loadTestCondition() {

        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/com/testBaseManagement/testItemManagement/eleItemManage/loadTestCondition.do'/>",
            data: {"data": masterID},
            success: function (data) {
                lookupDataChange2(data);
            },
            error: function (xhr, status, error, data) {
                alert("error");
            }
        });
    }

    function lookupDataChange1(data) {

        var lookups = [];

        for (var i = 0; i < data.length; i++) {

            var json = data[i];
            var lookup = [json.itemID, json.methodID, json.name];
            lookups.push(lookup);

        }

        gridView2.fillLookupData("lookID1", {
            rows: lookups
        })
    }

    function lookupDataChange2(data) {

        var lookups = [];

        for (var i = 0; i < data.length; i++) {

            var json = data[i];
            var lookup = [json.itemID, json.condID, json.testCond];
            lookups.push(lookup);
        }

        gridView2.fillLookupData("lookID2", {
            rows: lookups
        })
    }

    function getMasterID() {
        return masterID;
    }

    function modalUp() {
    	

        if (masterID == undefined) {
            alert('먼저 추가 하실 제품을 선택 해 주세요');
            return;
        } else {
            $("#modalPopUp").modal();
            $("#modalPopUp").on('shown.bs.modal', function () {
                gridView3.resetSize();
                loadModalData();
                gridView2.cancel();
                gridView.cancel();
                
            });
        }
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
                    $("#selBox1").append("<option value='" + firstSelectListJson[i].classID + "'>" + firstSelectListJson[i].name + "</option>");
                }

            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });

    }

    function selBox1Handler() {

        var firstSelKey = $('#selBox1').find('option:selected').val();

        $("#selBox2 option").remove(); // 첫번째 선택창에서 선택 된 놈 소집

        $("#selBox2").append("<option>" + "== 유종 ==" + "</option>");

        for (var i = 0; i < secondSelectListJson.length; i++) {

            if (secondSelectListJson[i].classID == firstSelKey) { // 1번째에서 선택 된 클래스아이디와 같은 종류만 모두 소집
                $("#selBox2").append("<option value='" + secondSelectListJson[i].groupID + "'>" + secondSelectListJson[i].name + "</option>");
            }

        }
    }

    function selBox2BtnHandler() {


        var secondSelKey = $('#selBox2').find('option:selected').val();

        if ((secondSelKey == undefined) || (secondSelKey == "") || (secondSelKey == "== 유종 ==")) {
            alert('유종을 옳바르게 선택 바랍니다.');
            return;
        }

        $.ajax({
            url: "<c:url value='/com/testBaseManagement/testItemManagement/eleItemManage/getThirdList.do'/>",
            type: "post",
            data: {"data": secondSelKey},
            dataType: "json",
            success: function (result) {
                console.log(JSON.stringify(result));
                dataProvider.fillJsonData(result);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }


    function save() {
        gridView2.commit();
        saveData();
    }

    function saveData(urlStr) {

        var jData;
        var jRowsData = [];
        var rows = dataProvider2.getAllStateRows();

        if (rows.updated.length > 0) {
            for (var i = 0; rows.updated.length > i; i++) {
                jData = dataProvider2.getJsonRow(rows.updated[i]);
                jData.state = "updated";
                jData.modifyID = userID;
                jRowsData.push(jData);
            }
        }

        if (rows.created.length > 0) {
            for (var i = 0; rows.created.length > i; i++) {
                jData = dataProvider2.getJsonRow(rows.created[i]);
                jData.state = "created";
                jData.regID = userID;
                jRowsData.push(jData);
            }
        }

        var jsonv = JSON.stringify(jRowsData);

        $.ajax({
            url: "<c:url value='/com/testBaseManagement/testItemManagement/eleItemManage/save.do'/>",
            type: "POST",
            data: {"data": jsonv},
            success: function (data) {
                loadData();
                loadRightOne();
                loadTestMethod();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function loadModalData() {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value= '/com/testBaseManagement/testItemManagement/eleItemManage/popUpLoad.do' />",
            data: {"data": "data"},
            success: function (data) {
                dataProvider3.fillJsonData(data);
                setCheckBar();
            },
            error: function (xhr, status, error, data) {
                $("#loadResult").css("color", "red").text("Load failed: " + error).show();
            }
        });
    }

    function add() {

        var masterID = getMasterID();

        var checkedRows = gridView3.getCheckedRows();
        var dataArr = [];
        var stringfied;

        if (checkedRows.length == 0) {
            alert('원하시는 시험방법의 Check Bar를 클릭하여 주세요');
        }

        for (var i = 0; i < checkedRows.length; i++) {
            var jsonv = dataProvider3.getJsonRow(checkedRows[i])
            dataArr.push(jsonv);
        }
        for (var i = 0; i < dataArr.length; i++) {
            dataArr[i].masterID = masterID;
            dataArr[i].regID = userID;
        }
        stringfied = JSON.stringify(dataArr);
        saveModal(stringfied);

        setTimeout("loadRightOne();", 250);

    }

    function saveModal(jsonObj) {

        var sendObj = JSON.stringify(jsonObj);

        $.ajax({
            type: "POST",
            dataType: "text",
            url: "<c:url value= '/com/testBaseManagement/testItemManagement/eleItemManage/savePopUp.do'/>",
            data: {"data": sendObj},
            success: function (data) {
                alert('성공적으로 추가 되었습니다.');

            },
            error: function (xhr, status, error, data) {

            }
        });
    }

    function setCheckBar() {

        allData = dataProvider3.getJsonRows();

        for (var i = 0; i < allData.length; i++) {
            if (allData[i].cnt >= 1) {
                gridView3.setCheckable(i, false);
            }
        }
    }

    function loadData() {

        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/com/testBaseManagement/testMethodManagement/retrieve.do'/>",
            success: function (data) {

            },
            error: function (xhr, status, error, data) {
                $("#loadResult").css("color", "red").text("Load failed: " + error).show();
            }
        });
    }

    function loadRightOne() {

        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/com/testBaseManagement/testItemManagement/eleItemManage/loadRightOne.do'/>",
            data: {"data": masterID},
            success: function (data) {
                dataProvider2.setRows(data, "tree", false);
                gridView2.expandAll();
            },
            error: function (xhr, status, error, data) {
                alert('data load에 실패 하였습니다.');
            }
        });

        loadTestCondition();
        loadTestMethod();
    }


    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("<c:url value='/script'/>");

        dataProvider = new RealGridJS.LocalDataProvider();
        gridView = new RealGridJS.GridView("realgrid");
        gridView.setDataSource(dataProvider);

        dataProvider2 = new RealGridJS.LocalTreeDataProvider();
        gridView2 = new RealGridJS.TreeView("realgrid2");
        gridView2.setDataSource(dataProvider2);

        dataProvider3 = new RealGridJS.LocalDataProvider();
        gridView3 = new RealGridJS.GridView("realgrid3");
        gridView3.setDataSource(dataProvider3);

        //필드를 가진 배열 객체를 생성합니다.
        var fields = [
            {
                fieldName: "masterID"
            }
            , {
                fieldName: "oilType"
            }
            , {
                fieldName: "name"
            }
            , {
                fieldName: "eName"
            }
            , {
                fieldName: "adminID"
            }
            , {
                fieldName: "cnt"
            }
        ];

        var fields2 = [
            {
                fieldName: "tree"
            }
            , {
                fieldName: "methodName"
            }
            , {
                fieldName: "methodKName"
            }
            , {
                fieldName: "itemID"
            }
            , {
                fieldName: "masterID"
            }
            , {
                fieldName: "methodID"
            }
            , {
                fieldName: "temperCond"
            }
            , {
                fieldName: "tempUnit"
            }
            , {
                fieldName: "timeCond"
            }
            , {
                fieldName: "timeCondUnit"
            }
            , {
                fieldName: "etc"
            }
            , {
                fieldName: "etcUnit"
            }
            , {
                fieldName: "lvl"
            }
            , {
                fieldName: "resultFlag"
            }
            , {
                fieldName: "itemPID"
            }
            , {
                fieldName: "price",
                dataType: "number"
            }
            , {
                fieldName: "unitID"
            }
            , {
                fieldName: "displayType"
            }
            , {
                fieldName: "name"
            }
            , {
                fieldName: "kName"
            }
            , {
                fieldName: "condID"
            }
            , {
                fieldName: "mtItemID"
            }
            , {
                fieldName: "admin"
            }
            , {
                fieldName: "orderBy"
            }

        ];
        var fields3 = [
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
                fieldName: "price",
                dataType: "number"
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
        dataProvider2.setFields(fields2);
        dataProvider3.setFields(fields3);
        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns = [

            {
                name: "name",
                fieldName: "name",
                header: {
                    text: "제품명"
                },
                styles: {
                    textAlignment: "near"
                },
                width: 130,
                readOnly: true
            }
            , {
                name: "eName",
                fieldName: "eName",
                header: {
                    text: "영문명"
                },
                styles: {
                    textAlignment: "near"
                },
                width: 170,
                readOnly: true
            }
            , {
                name: "adminID",
                fieldName: "adminID",
                header: {
                    text: "담당자"
                },
                styles: {
                    textAlignment: "near"
                },
                width: 120,
                readOnly: true
            }
            , {
                name: "cnt",
                fieldName: "cnt",
                header: {
                    text: "항목수"
                },
                styles: {
                    textAlignment: "center"
                },
                width: 80,
                readOnly: true
            }

        ];

        var columns2 = [

            {
                name: "name",
                fieldName: "name",
                header: {
                    text: "항목명"
                },
                width: 250,
                styles: {
                    textAlignment: "near"
                },
                readOnly: true
            }
            , {
                name: "lvl",
                fieldName: "lvl",
                header: {
                    text: "레벨"
                },
                width: 70,
                styles: {
                    textAlignment: "center"
                },
                readOnly: true
            }
            , {
                name: "methodID",
                fieldName: "methodID",
                header: {
                    text: "시험방법"
                },
                width: 350,
                styles: {
                    textAlignment: "near"
                },
                "lookupDisplay": true,
                "lookupSourceId": "lookID1",
                "lookupKeyFields": ["itemID", "methodID"],
                "editor": {
                    "type": "dropDown",
                    "editButtonVisibility": "always",
                    "dropDownCount": 3
                }
            }
            , {
                name: "price",
                fieldName: "price",
                header: {
                    text: "수수료"
                },
                styles: {
                    textAlignment: "far",
                    "numberFormat": "000,000"
                },
                width: 100,
                readOnly: true
            }
            , {
                name: "unitID",
                fieldName: "unitID",
                header: {
                    text: "단위"
                },
                width: 100,
                readOnly: true
            }
            , {
                name: "displayType",
                fieldName: "displayType",
                header: {
                    text: "결과유형"
                },
                width: 100,
                readOnly: true
            }
            , {
                name: "admin",
                fieldName: "admin",
                header: {
                    text: "담당자"
                },
                styles: {
                    textAlignment: "near"
                },
                width: 200,
                readOnly: true
            }
            , {
                name: "condID",
                fieldName: "condID",
                header: {
                    text: "시험조건"
                },
                width: 200,
                "lookupDisplay": true,
                "lookupSourceId": "lookID2",
                "lookupKeyFields": ["itemID", "condID"],
                "editor": {
                    "type": "dropDown",
                    "dropDownCount": 3
                },
                editButtonVisibility: "always"
            }
        ];

        var columns3 = [
            /*            {
             name: "itemID",
             fieldName: "itemID",
             header: {
             text: "itemID"
             },
             width: 50,

             },
             {
             name: "itemPID",
             fieldName: "itemPID",
             header: {
             text: "itemPID"
             },
             width: 50,

             },*/
            {
                name: "itemName",
                fieldName: "itemName",
                header: {
                    text: "항목"
                },
                width: 215,
                styles: {
                    textAlignment: "near"
                },
                readOnly:true

            }
            , {
                name: "lvl",
                fieldName: "lvl",
                header: {
                    text: "레벨"
                },
                width: 40,
                readOnly:true

            }
            , {
                name: "price",
                fieldName: "price",
                header: {
                    text: "가격"
                },
                styles: {
                    textAlignment: "far",
                    numberFormat: "000,000"
                },
                width: 60,
                readOnly:true

            }

            , {
                name: "cnt",
                fieldName: "cnt",
                header: {
                    text: "cnt"
                },
                width: 80,
                readOnly:true

            }
        ];

        //컬럼을 GridView에 입력 합니다.
        gridView.setColumns(columns);
        gridView2.setColumns(columns2);
        gridView3.setColumns(columns3);

        /* 헤더의 높이를 지정*/
        gridView.setHeader({
            height: 30
        });

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
            header: {},
            select: {
                style: RealGridJS.SelectionStyle.ROWS
            },
            checkBar: {
                visible: false
            },
            display: {
                fitStyle: "evenFill"
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
            header: {},
            select: {
                style: RealGridJS.SelectionStyle.ROWS
            },
            checkBar: {
                visible: true
            },
            display: {
                fitStyle: "evenFill"
            }
        });
        gridView3.setOptions({
            display: {
                fitStyle: "evenFill"
            }
        });

        gridView.setSortingOptions({
            keepFocusedRow: true
        })

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
        gridView.setStyles(smart_style);
        gridView2.setStyles(smart_style);
        gridView3.setStyles(smart_style);

        gridView2.setLookups([
            {
                "id": "lookID2",
                "levels": 2
            }
            , {
                "id": "lookID1",
                "levels": 2
            }]);


        gridView.onDataCellDblClicked = function (grid, index) {

            leftJsonData = gridView.getValues(index.dataRow);
            masterID = leftJsonData.masterID;
            var name = leftJsonData.name;

            $("#title").val(name);

            loadRightOne();
            loadTestCondition();
            loadTestMethod();
        };

        gridView2.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {

            gridView2.commit();

            var rowValue = gridView2.getValues(itemIndex);
            var stringfied = JSON.stringify(rowValue);

            if (field == 5) { // field 넘버 5는 시험방법 을 뜻한다 변경시 함께 변경 되어져야함

                loadDataLeft(stringfied, itemIndex);
            }
        }
    });


    loadData();
    getJavaObject();

</script>
<style>

    td {
        padding-left: 20px;
    }

</style>

<input type="hidden" name="jsonTempRepo" id="jsonTempRepo">

<%
    List list = (List) request.getAttribute("list");
%>


<div class="page-content">
    <div style="width: 30%;float: left;height: 900px;">

        <div style="height: 90px;">

            <div style="height: 40%;">

                <div class="page-content">
                    <div role="content">
                        <!--  start of  form-horizontal tems_search  -->
                        <!--  start of widget-body -->
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <div class="widget-body">

                                    <fieldset>
                                        <div class="col-md-12 form-group">
                                            <label class="col-md-3 form-label"><b>유종구분</b></label>

                                            <div class="col-md-9">
                                                <select name="selBox1" id="selBox1" style="width: 60%;"
                                                        class="form-control selectBox">
                                                    <option value="plzNoSel">== 선택 하세요 ==</option>
                                                    <%--<%
                                                        for (int i = 0; i < list.size(); i++) {
                                                            OilTypeProductVO vo2 = (OilTypeProductVO) list.get(i);
                                                    %>
                                                    <option value="<%= vo2.getClassID() %>"><%= vo2.getName() %>
                                                    </option>
                                                    <%
                                                        }
                                                    %>--%>
                                                </select>
                                            </div>
                                        </div>
                                    </fieldset>

                                    <fieldset>
                                        <div class="col-md-12 form-group">
                                            <label class="col-md-3 form-label"><b>유종</b></label>

                                            <div class="col-md-9">
                                                <select name="selBox2" id="selBox2" style="width: 60%; float: left"
                                                        class="form-control selectBox">
                                                </select>
                                                <button id="selBox2Btn" class="btn btn-primary" style="float: right">
                                                    조회
                                                </button>
                                            </div>
                                        </div>
                                    </fieldset>
                                    <!--  end of  form-horizontal tems_search  -->
                                    <!--  end of jarviswidget -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div id="realgrid" style="width: 100%; height: 700px;"></div>
        </div>
    </div>
    <div style="width: 60%;float: left;margin-left: 2%;height: 900px;">
        <%--<div style="height: 40px;">
            <div class="col col-lg-3" style="float: left;background-color: #E6E6E6;height: 100%;display: table;">
                <b style="display: table-cell;vertical-align: middle; text-align: right;">제품명</b>
            </div>
            <div class="col col-lg-9"
                 style="float: left;height: 100%; border-bottom: 1px solid #E6E6E6;border-right: 1px solid #E6E6E6; border-top: 1px solid #E6E6E6;">
                <div style="float: left;width: 60%;height: 100%;display: table; vertical-align: middle">
                    <input type="text" id="title" class="form-control inputBox"
                           style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; width:250px;"/>
                </div>
                <div style="float: left;width: 40%;height: 100%;display: table; ">
                    <p style="display: table-cell;vertical-align: middle;text-align: center; text-align: right">

                        <button id="addItem" class="btn btn-primary">
                            <i class="fa fa-plus"></i> 항목추가
                        </button>
                        <button id="save" class="btn btn-primary">
                            <i class="fa fa-save"></i> 저장
                        </button>
                        <button id="delete" class="btn btn-primary">
                            <i class="fa fa-eraser"></i> 삭제
                        </button>
                    <p>
                </div>
            </div>
        </div>
        <br/>--%>


        <div class="page-content">
            <div role="content">
                <!--  start of  form-horizontal tems_search  -->
                <!--  start of widget-body -->
                <div class="form-horizontal form-terms ">
                    <div class="jarviswidget jarviswidget-sortable" role="widget">
                        <div class="widget-body">

                            <fieldset>
                                <div class="col-md-12 form-group">
                                    <label class="col-md-3 form-label"><b>제품명</b></label>

                                    <div class="col-md-9">

                                        <input type="text" id="title" class="form-control inputBox"
                                               style="float: left; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; width:30%;"/>

                                        <button id="save" class="btn btn-primary" style="float: right">
                                            <i class="fa fa-save"></i> 저장
                                        </button>
                                        <p style="float: right; width: 3px"></p>
                                        <button id="delete" class="btn btn-primary" style="float: right">
                                            <i class="fa fa-eraser"></i> 삭제
                                        </button>
                                        <p style="float: right; width: 3px"></p>
                                        <button id="addItem" class="btn btn-primary" style="float: right">
                                            <i class="fa fa-plus"></i> 항목추가
                                        </button>


                                    </div>
                                </div>
                            </fieldset>
                            <!--  end of  form-horizontal tems_search  -->
                            <!--  end of jarviswidget -->
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <%--<div style="height: 45px;">
            <div class="col col-lg-3" style="float: left;background-color: #E6E6E6;height: 85%;display: table;">
                <b style="display: table-cell;text-align: center;vertical-align: middle;">제품명</b>
            </div>
            <div class="col col-lg-6" style="float: left;height: 85%;border: 1px solid #E6E6E6;display: table;">
                <div style="display: table-cell;vertical-align: middle;">
                    <input type="text" id="title"
                           style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; width:250px;"/>
                </div>
            </div>
            <div class="col col-lg-3" style="float: left;display: table;height: 85%;">
                <p style="display: table-cell;vertical-align: middle;text-align: center;">
                    <button id="addItem" class="btn btn-default btn-sm">항목추가</button>
                    <button id="delete" class="btn btn-default btn-sm">삭제</button>
                    <button id="save" class="btn btn-default btn-sm">저장</button>
                </p>
            </div>
        </div>--%>
        <div>
            <div id="realgrid2" style="width: 100%; height: 730px;"></div>
        </div>
    </div>
</div>


<div class="page-content">
    <div role="content">
        <!--  start of  form-horizontal tems_search  -->
        <!--  start of widget-body -->
        <div class="form-horizontal form-terms ">
            <div class="jarviswidget jarviswidget-sortable" role="widget">
                <div class="widget-body">

                    <fieldset>
                        <div class="col-md-6 form-group">
                            <label class="col-md-3 form-label"><b>신청업체명</b></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control inputBox">

                            </div>
                        </div>
                    </fieldset>
                    <!--  end of  form-horizontal tems_search  -->
                    <!--  end of jarviswidget -->
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Modal PopUp 창 Start-->
<div class="modal fade" id="modalPopUp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel">항목추가</h4>
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
                    </div>

                    <div class="div-realgrid">
                        <div id="realgrid3" style="width: 100%; height: 500px;"></div>
                    </div>


                    <!-- Footer -->
                    <footer>
                    </footer>
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
<!-- end of modal -->



