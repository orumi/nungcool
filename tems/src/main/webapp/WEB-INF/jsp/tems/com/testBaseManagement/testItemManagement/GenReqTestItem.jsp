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
    <script>

        var contextPath = '<%=request.getContextPath()%>';
        var userID = '<%= userID %>';
        var CodeNameArr = ${CodeNameArr};
        var CodeIDArr = ${CodeIDArr};

        var regID = null;
        var tempCodeNameArr = ${tempCodeNameArr};
        var tempCodeIDArr = ${tempCodeIDArr};
        var timeCodeNameArr = ${timeCodeNameArr};
        var timeCodeIDArr = ${timeCodeIDArr};
        var etcCodeNameArr = ${etcCodeNameArr};
        var etcCodeIDArr = ${etcCodeIDArr};
        var itemID;

    </script>

    <script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
    <script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">


    <script type="text/javaScript" language="javascript" defer="defer">


        $(function () {
            $("#loadData").click(loadData);
            $("#search").click(search);
            $("#save").click(saveData);
            $("#btnAppend").click(btnAppendClickHandler);
            $("#btnNext").click(btnNextClickHandler);
            $("#btnPrev").click(btnPrevClickHandler);
            $("#btnPage").click(btnPageClickHandler);
            $("#btnFirst").click(btnFirstClickHandler);
            $("#btnLast").click(btnLastClickHandler);
            $("#modalSave").click(modalSave);
            $("#modalAppend").click(modalAppendClickHandler);
            $("#modalDelete").click(modalDeleteClickHandler);

        });


        function btnLastClickHandler(e) {
            var count = gridView.getPageCount();
            setPage(count - 1);
        }
        function btnFirstClickHandler(e) {
            setPage(0);
        }
        function btnPageClickHandler(e) {
            var page = parseInt($("#goInput").val()) - 1;
            setPage(page);
        }
        function btnNextClickHandler() {
            console.log('btnNextClickHandler');
            var page = gridView.getPage();
            console.log(page);
            setPage(page + 1);
        }
        function btnPrevClickHandler(e) {
            var page = gridView.getPage();
            setPage(page - 1);
        }
        function btnAppendClickHandler(e) {

            dataProvider.insertChildRow(0, 0, {
                itemPID: "0",
                oldYN: "N",
                useFlag: "Y"
            }, 0);
            /*          gridView.expand(gridView.getItemIndex(parent));*/
        }

        function saveData() {
            gridView.commit();
            save("<c:url value='/com/testBaseManagement/testItemManagement/getReqTestItem/saveData.do'/>");
        }

        function btnPageNumClickHandler(obj) {
            var page = parseInt($(obj).val()) - 1;
            setPage(page);
        }

        function search() {

            gridView.commit();

            var searchKeyword = $("#searchKeyword").val();

            if (searchKeyword == "" || searchKeyword == " " || searchKeyword == "  ") {
                loadData();
                return;
            }

            $.ajax({

                url: "<c:url value='/com/testBaseManagement/testItemManagement/getReqTestItem/searchData.do'/>",
                type: "post",
                data: {"data": searchKeyword},
                success: function (data) {
                    dataProvider.setRows(data, "tree", false);
                    gridView.expandAll();
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function save(urlStr) {

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
                url: urlStr,
                type: "POST",
                data: {"data": jsonv},
                success: function (data) {
                    alert(data);
                    loadData();
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function deleteData(data) {
            $.ajax({
                url: "<c:url value='/com/testBaseManagement/testItemManagement/getReqTestItem/deleteData.do'/>",
                type: "POST",
                dataType: "text",
                data: {"data": data},
                success: function (data) {
                    alert(data);
                    search();
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }


        function loadData() {

            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value='/com/testBaseManagement/testItemManagement/getReqTestItem/loadData.do'/>",
                success: function (data) {
                    dataProvider.setRows(data, "tree", true, "", "");
                    gridView.expandAll();
                },
                error: function (xhr, status, error, data) {
                    $("#loadDataResult").css("color", "red").text("loadData failed: " + error).show();
                },
                complete: function (data) {
                    gridView.hideToast();
                },
                cache: false
            });
        }

        function setPage(page) {
            // grid page setting
            var count = gridView.getPageCount();
            console.log('count => ' + count);
            page = Math.max(0, Math.min(page, count - 1));
            console.log('page => ' + page);

            var pageSize = $('#txtPageSize').val();
            console.log(pageSize);
            var rows = (page + 1) * pageSize;
            if (rows > dataProvider.getRowCount()) {
                dataProvider.setRowCount(rows);
            }

            gridView.setPage(page);
            var size = $('#txtPageSize').val();
            gridView.setIndicator({rowOffset: page * size});

            // 한번 읽어온 페이지는 데이타를 다시 읽지 않도록
            if (!dataProvider.hasData(page * pageSize)) {
                loadDataData(dataProvider, page * pageSize);
            }

            var displayPage = parseInt(page) + 1;

            // page number show
            var pageNumbers = 10;
            var startPage = Math.floor(page / pageNumbers) * pageNumbers + 1;
            var endPage = startPage + pageNumbers - 1;
            endPage = Math.min(endPage, gridView.getPageCount());

            $('#pageNumbers').empty();
            for (var i = startPage; endPage >= i; i++) {
                if (i == displayPage) { //current page
                    $("#pageNumbers").append("<input type='button' value='" + i + "' class='button gray small2' style='cursor:pointer;'/>");
                } else {
                    $("#pageNumbers").append("<input type='button' value='" + i + "' onclick='btnPageNumClickHandler(this)' class='button white small2'/>");
                }
            }
        }


        function modalUp(itemID) {

            $("#modalPopUp").modal();
            $("#modalPopUp").on('shown.bs.modal', function () {
                gridView2.resetSize();
            });
            modalLoad(itemID);
        }

        function modalLoad(itemID) {

            var contextPath = '<%=request.getContextPath()%>';

            $.ajax({
                url: "<c:url value='/com/testBaseManagement/testItemManagement/getReqTestItem/popUpLoadData.do'/>",
                type: "POST",
                data: {"data": itemID},
                dataType: "json",
                success: function (data) {
                    dataProvider2.fillJsonData(data);
                },
                error: function (request, status, error) {
                    alert(" 먼저 항목에 관한 저장을 시행 후 시험조건을 선택 해 주세요.");
                }
            });
        }

        function modalSave() {
            gridView2.commit();
            modalSaveData();
        }

        function modalSaveData() {

            var jData;
            var jRowsData = [];
            var rows = dataProvider2.getAllStateRows();

            if (rows.updated.length > 0) {
                for (var i = 0; rows.updated.length > i; i++) {
                    jData = dataProvider2.getJsonRow(rows.updated[i]);
                    jData.state = "updated";
                    jData.modifyID = $("#userID").val();
                    jRowsData.push(jData);
                }
            }
            if (rows.created.length > 0) {
                for (var i = 0; rows.created.length > i; i++) {
                    jData = dataProvider2.getJsonRow(rows.created[i]);
                    jData.state = "created";
                    jData.itemID = itemID;
                    jData.regID = $("#userID").val();
                    jRowsData.push(jData);
                }
            }
            if (rows.deleted.length > 0) {
                for (var i = 0; rows.deleted.length > i; i++) {
                    jData = dataProvider2.getJsonRow(rows.deleted[i]);
                    jData.state = "deleted";
                    jRowsData.push(jData);
                }
            }

            var jsonv = JSON.stringify(jRowsData);

            $.ajax({
                url: "<c:url value='/com/testBaseManagement/testItemManagement/getReqTestItem/popUpSaveData.do'/>",
                type: "POST",
                data: {"data": jsonv},
                dataType: "text",
                success: function (data) {
                    modalLoad(itemID);
                    loadData();
                    alert(data);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function modalDeleteClickHandler() {

            if (confirm("정말로 삭제 하시겠습니까?")) {
                var checkedRows = gridView2.getCheckedRows();

                for (var i = 0; checkedRows.length > i; i++) {
                    var num = checkedRows[i];
                    dataProvider2.setRowState(num, "deleted");
                }
                modalSave();
            }
        }

        function modalAppendClickHandler(e) {
            gridView2.beginAppendRow();
        }


    </script>
    <script type="">
        var gridView;
        var dataProvider;

        $(document).ready(function () {

            RealGridJS.setTrace(false);
            RealGridJS.setRootContext("<c:url value='/script'/>");

            dataProvider = new RealGridJS.LocalTreeDataProvider();
            gridView = new RealGridJS.TreeView("realgrid");
            gridView.setDataSource(dataProvider);

            dataProvider2 = new RealGridJS.LocalDataProvider();
            gridView2 = new RealGridJS.GridView("realgrid2");
            gridView2.setDataSource(dataProvider2);

            //필드를 가진 배열 객체를 생성합니다.
            var fields = [
                {
                    fieldName: "tree"
                }
                , {
                    fieldName: "itemID"
                }
                , {
                    fieldName: "itemPID"
                }
                , {
                    fieldName: "lvl"
                }
                , {
                    fieldName: "name"
                }
                , {
                    fieldName: "eName"
                }
                , {
                    fieldName: "useFlag"
                }
                , {
                    fieldName: "price",
                    dataType: "number"
                }
                , {
                    fieldName: "basicCond"
                }
                , {
                    fieldName: "basicUnit"
                }
                , {
                    fieldName: "basicCnt"
                }
                , {
                    fieldName: "calcBase"
                }
                , {
                    fieldName: "addPrice",
                    dataType: "number"
                }
                , {
                    fieldName: "etc"
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
                    fieldName: "oldYN"
                }
                , {
                    fieldName: "orderBy"
                }
                , {
                    fieldName: "oldID"
                }
                , {
                    fieldName: "delete"
                }
                , {
                    fieldName: "addSon"
                }
                , {
                    fieldName: "testCond"
                }

            ];

            var fields2 = [
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
            dataProvider2.setFields(fields2);

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
                    width: 180
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
                    width: 400
                },

                {
                    "type": "group",
                    "name": "수수료조건",
                    "width": 600,

                    "columns": [{
                        name: "price",
                        fieldName: "price",
                        header: {
                            text: "기본수수료"
                        },
                        styles: {
                            "textAlignment": "far",
                            "numberFormat": "000,000"
                        },
                        width: 20
                    }
                        , {
                            name: "basicCond",
                            fieldName: "basicCond",
                            header: {
                                text: "기본조건"
                            },
                            width: 20
                        }
                        , {
                            name: "basicUnit",
                            fieldName: "basicUnit",
                            header: {
                                text: "조건 단위"
                            },
                            editButtonVisibility: "always",
                            lookupDisplay: "true",
                            values: CodeIDArr,
                            labels: CodeNameArr,
                            editor: {
                                type: "dropDown",
                                dropDownCount: 2
                            },
                            width: 20
                        }
                        , {
                            name: "basicCnt",
                            fieldName: "basicCnt",
                            header: {
                                text: "기준 항목수"
                            },
                            width: 20
                        },

                        {
                            "type": "group",
                            "name": "수수료조건",
                            "width": 60,

                            "columns": [
                                {
                                    name: "calcBase",
                                    fieldName: "calcBase",
                                    header: {
                                        text: "추가조건"
                                    },
                                    width: 30
                                }
                                , {
                                    name: "addPrice",
                                    fieldName: "addPrice",
                                    header: {
                                        text: "추가수수료"
                                    },
                                    styles: {
                                        textAlignment: "far",
                                        numberFormat: "000,000"
                                    },
                                    width: 30
                                }
                            ]
                        }
                    ]
                }
                , {
                    name: "etc",
                    fieldName: "etc",
                    header: {
                        text: "비고"
                    },
                    width: 60
                }
                , {
                    "type": "group",
                    "name": "시험조건",
                    "width": 130,

                    "columns": [
                        {
                            name: "testCond",
                            fieldName: "testCond",
                            header: {
                                text: "시간/온도/기타"
                            },
                            styles: {
                                textAlignment: "near"
                            },
                            width: 100,
                            "button": "action",
                            alwaysShowButton: true
                        }
                    ]
                }
                , {
                    name: "useFlag",
                    fieldName: "useFlag",
                    header: {
                        text: "사용여부"
                    },
                    lookupDisplay: "true",
                    values: ["Y", "N"],
                    labels: ["Y", "N"],
                    editor: {
                        type: "dropDown",
                        dropDownCount: 2
                    },
                    editButtonVisibility: "always",
                    width: 60
                }
                , {
                    name: "delete",
                    fieldName: "delete",
                    header: {
                        text: "삭제"
                    },
                    width: 50,
                    "button": "action",
                    alwaysShowButton: true
                }
                , {

                    name: "addSon",
                    fieldName: "addSon",
                    header: {
                        text: "하위항목 추가"
                    },
                    width: 100,
                    "button": "action",
                    alwaysShowButton: true
                }
            ];

            var columns2 = [
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
            gridView2.setColumns(columns2);
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

            gridView.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true
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
                select: {
                    style: RealGridJS.SelectionStyle.ROWS
                }

            });

            gridView2.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true
            });

            gridView.setStyles(smart_style);
            gridView2.setStyles(smart_style);

            gridView.onCellButtonClicked = function (grid, itemIndex, column) {

                if (column.fieldName == 'delete') {

                    var json = gridView.getValues(itemIndex);
                    json = JSON.stringify(json);
                    deleteData(json);

                } else if (column.fieldName == 'addSon') {

                    var json = gridView.getValues(itemIndex);
                    var current = gridView.getCurrent();
                    var row = current.dataRow;

                    var nextLevel = parseInt(json.lvl)+1; // 현재 행의 레벨보다 플러스 1

                    var child = dataProvider.addChildRow(row,
                            {
                                itemPID: json.itemID,
                                oldYN: "N",
                                lvl: nextLevel,
                                useFlag: "Y",
                                lvl: "1"
                            }, 0);

                    gridView.expand(gridView.getItemIndex(row));
                    current.itemIndex = gridView.getItemIndex(child);
                    gridView.setCurrent(current);
                    gridView.setFocus();

                } else if (column.fieldName == 'testCond') {

                    var itemIDForOpen = gridView.getValues(itemIndex).itemID;
                    itemID = itemIDForOpen; // itemID 는 저장 할때 사용하는 용도;
                    if (itemIDForOpen == undefined) {
                        alert('저장 후 시험조건을 선택 해 주세요');
                    } else {
                        modalUp(itemIDForOpen);
                    }

                }
            };

            loadData();
        });


    </script>
</head>
<body>
<input type="hidden" name="jsonTempRepo" id="jsonTempRepo">
<input type="hidden" name="popUp" id="popUp">


<div class="page-content">

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
                                    <input id="searchKeyword" type="text" class="form-control inputBox"/>
                                </div>
                                <div class="col-sm-2 form-button">
                                    <button class="btn btn-default btn-primary" type="button" id="search">
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


    <div role="content">
        <div class="dt-toolbar">
            <div class="col-sm-6">
                <div class="txt-guide">
                    <!--※ 업체명을 클릭하시면 상세정보창이 표시됩니다.-->
                </div>
            </div>


            <div class="col-sm-6 text-right">
                <button id="btnAppend" class="btn btn-primary">
                    <i class="fa fa-plus"></i> 시험방법추가
                </button>
                <button id="save" class="btn btn-primary">
                    <i class="fa fa-save"></i> 저장
                </button>
            </div>

        </div>

        <div class="div-realgrid">
            <div id="realgrid" style="width: 100%; height: 650px;"></div>
        </div>
        <%--<footer><div class="dt-footbar"></div></footer>--%>

        <!-- end of realgrid Content -->
    </div>
</div>

<div class="modal fade" id="modalPopUp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel">시험방법추가</h4>
            </div>
            <div class="modal-body requestBody">
                <div class="page-content">

                    <div class="div-realgrid">
                        <div id="realgrid2" style="width: 100%; height: 500px;"></div>
                    </div>

                    <!-- Footer -->
                    <footer>
                        <div align="right">
                            <%--<button id="modalLoad" class="btn btn-primary" align="left">Load</button>--%>
                            <button id="modalAppend" class="btn btn-primary" align="left">추가</button>
                            <button id="modalDelete" class="btn btn-primary" align="left">삭제</button>
                            <button id="modalSave" class="btn btn-primary" align="left">저장</button>
                        </div>
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


</body>
</html>
