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
    <script type="text/javaScript" language="javascript" defer="defer">

        var CodeNameArr = ${CodeNameArr};
        var CodeIDArr = ${CodeIDArr};
        var officeIDArr = ${officeIDArr};
        var nameArr = ${nameArr};

    </script>

    <script type="text/javaScript" language="javascript" defer="defer">

        var searchFlag = false;


        $(function () {
            $("#load").click(loadTriger);
            $("#save").click(saveData);
            $("#selectedID").change(selectedIDHandler);
            $("#selectGroup").change(selectGroupHandler);
            $("#searchData").click(searchTriger);
        })

        function selectGroupHandler() {
            var value = $("#selectGroup").val();
            loadAdmin(value);

        }

        function injection(methodID, methodName) {
            console.log(methodID + "  " + methodName + "  " + index);
            var jsonRow = gridView.getValues(index);
            var row = [jsonRow.itemID, jsonRow.itemPID, methodID, jsonRow.name, methodName];
            dataProvider.insertRow(index, row);
            gridView.setFocus();
        }

        function selectedIDHandler() {
            alert($("#selectedID").val());
        }

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

        function injectAdmin(data) {

            removeAdmin();

            for (var i = 0; i < data.length; i++) {
                var temp = data[i];
                $("#selectAdmin").append("<option value='" + temp.name + "'>" + temp.name + "</option>");
            }
        }

        function removeAdmin() {

            $("#selectAdmin").find("option").remove();

        }

        function getOfficeID() {

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

        function save() {

            var jData;
            var jRowsData = [];
            var rows = dataProvider.getAllStateRows();

            if (rows.updated.length > 0) {
                for (var i = 0; rows.updated.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.updated[i]);
                    jData.state = "updated";
                    jData.modifyID = userID;
                    jRowsData.push(jData);
                }
            }

            if (rows.created.length > 0) {
                for (var i = 0; rows.created.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.created[i]);
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
                    alert(data);
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


    </script>
    <script type="">


        var searchFlag = false;

        var userID = '<%= userID %>';
        var selectedID;
        var selectedMethodName;
        var index;

        var officeID;
        var itemID;
        var methodID;
        var itemPID;

        var gridView;
        var dataProvider;

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
            //DataProvider의 setFields함수로 필드를 입력합니다.
            dataProvider.setFields(fields);

            //필드와 연결된 컬럼 배열 객체를 생성합니다.
            var columns = [

                {
                    name: "name",
                    fieldName: "name",
                    header: {
                        text: "항목명"
                    },
                    width: 150
                }
                , {
                    name: "methodName",
                    fieldName: "methodName",
                    header: {
                        text: "시험방법명"
                    },
                    width: 150,
                    readOnly: "true",
                    button: "action",
                    alwaysShowButton: true,
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
                    alwaysShowButton: true,
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
                , {
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

                }
                , {
                    name: "admin",
                    fieldName: "admin",
                    header: {
                        text: "담당자"
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
            });
            gridView.setStyles({
                selection: {
                    background: "#11000000",
                    border: "#87000000,1"
                }
            });

            gridView.onCellButtonClicked = function (grid, itemIndex, column) {

                gridView.commit();

                if (column.fieldName == 'add') {

                    index = itemIndex;

                    var popUrl = "<c:url value= '/com/testBaseManagement/testItemManagement/genReqTestProp/propPopUp.do' />";	//팝업창에 출력될 페이지 URL
                    var popOption = "width=850, height=600, resizable=no, scrollbars=no, status=no";    //팝업창 옵션(optoin)
                    window.open(popUrl, "시험조건", popOption);

                }
                if (column.fieldName == 'methodName') {

                    var json = gridView.getValues(itemIndex);
                    json = JSON.stringify(json);
                    deleteData(json);

                }

                if (column.fieldName == 'admin') {

                    var selectedRow = gridView.getValues(itemIndex);

                    officeID = selectedRow.location;
                    itemID = selectedRow.itemID;
                    itemPID = selectedRow.itemPID;
                    methodID = selectedRow.methodID;


                    if (officeID == undefined) {
                        alert('담당지점을 먼저 선택 해 주세요');
                        return
                    }

                    var popUrl = "<c:url value= '/com/testBaseManagement/testItemManagement/genReqTestProp/addAdminPopUp.do' />";	//팝업창에 출력될 페이지 URL
                    var popOption = "width=800, height=480";    //팝업창 옵션(optoin)
                    window.open(popUrl, "시험조건", popOption);

                }

            };
            /*
             gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {

             alert(gridView.getValues(itemIndex));

             };
             */
        });

        loadTriger();
    </script>
</head>
<body>
<input type="hidden" name="jsonTempRepo" id="jsonTempRepo">


<div>
</div>
<div class="page-content">
    <div role="main" class="ui-content jqm-content" align="center">
        <!-- 타이틀 -->
        <div>

            <div class="col-xs-12">
                <table id="simple-table" class="table table-striped table-bordered table-hover">
                    <tbody>
                    <tr>
                        <th style="width: 200px;">
                            항목명
                        </th>
                        <th>
                            <input id="itemName" type="text" id="itemName" style="width: 300px;">
                        </th>
                        <th style="width: 200px;">
                            시험방법
                        </th>
                        <th>
                            <input id="itemMethod" type="text" id="testMethod" style="width: 300px;">
                        </th>
                    </tr>

                    <tr>
                        <th style="width: 200px;">
                            관리본부지점
                        </th>
                        <th>
                            <select id="selectGroup" style="width: 300px;">
                                <option value="">-- 관리본부지점 --</option>
                            </select>
                        </th>
                        <th style="width: 200px;">
                            항목기본담당자
                        </th>
                        <th>
                            <select id="selectAdmin" style="width: 300px;">
                                <option value="">-- 항목기본담당자 --</option>
                            </select>
                            <button id="searchData" align="right">
                                조회
                            </button>
                        </th>
                    </tr>

                    </tbody>
                </table>
            </div>


        </div>
        <div align="right">
            <input type="button" id="load" value="refresh"/>
            <input type="button" id="save" value="저장"/>
        </div>
        <!-- // 타이틀 -->
        <div id="realgrid" style="width: 100%; height: 700px;"></div>
        <%--<input type="text" id="txtPageSize" value="30" style="text-align:right" hidden="true"/>
        <input type="button" id="btnFirst" value="First" class="button black medium3"/>
        <input type="button" id="btnPrev" value="<" class="button black medium3"/>

        <div id="pageNumbers" style="display: inline-block; white-space: nowrap;">
            <input type='button' value='1' class='button white small2'/>
            <input type='button' value='2' class='button white small2'/>
            <input type='button' value='3' class='button white small2'/>
            <input type='button' value='4' class='button white small2'/>
            <input type='button' value='5' class='button white small2'/>
            <input type='button' value='6' class='button white small2'/>
            <input type='button' value='7' class='button white small2'/>
            <input type='button' value='8' class='button white small2'/>
            <input type='button' value='9' class='button white small2'/>
            <input type='button' value='10' class='button white small2'/>
        </div>
        <input type="hidden" id="txtPage" value="1" style="text-align:right" maxlength="4" size="4"/>
        <input type="text" id="goInput" width="5"/>
        <input type="button" id="btnPage" value="Go" class="button black medium3"/>
        <input type="button" id="btnNext" value=">" class="button black medium3"/>
        <input type="button" id="btnLast" value="Last" class="button black medium3"/>--%>
    </div>
</div>


</body>
</html>
