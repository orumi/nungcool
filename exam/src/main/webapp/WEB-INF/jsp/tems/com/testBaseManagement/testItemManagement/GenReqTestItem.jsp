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

    </script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs-lic.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs_eval.1.0.12.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs-api.1.0.12.js'/>"></script>
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
        })


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
                itemPID: "0"
            }, 0);
  /*          gridView.expand(gridView.getItemIndex(parent));*/

        }

        function saveData() {
            gridView.commit();
            save(contextPath + "/com/testBaseManagement/testItemManagement/getReqTestItem/saveData.do");
        }

        function btnPageNumClickHandler(obj) {
            var page = parseInt($(obj).val()) - 1;
            setPage(page);
        }

        function search() {

            var searchKeyword = $("#searchKeyword").val();
            $.ajax({

                url: contextPath + "/com/testBaseManagement/testItemManagement/getReqTestItem/searchData.do",
                type: "post",
                data: {"data": searchKeyword},
                success: function (data) {
                    dataProvider.setRows(data, "itemID", true);
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
                url: contextPath + "/com/testBaseManagement/testItemManagement/getReqTestItem/deleteData.do",
                type: "POST",
                dataType: "text",
                data: {"data": data},
                success: function (data) {
                    alert(data);
                    loadData();
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
                url: contextPath + "/com/testBaseManagement/testItemManagement/getReqTestItem/loadData.do",
                success: function (data) {
                    dataProvider.setRows(data, "tree", false);
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

    </script>
    <script type="">
        var gridView;
        var dataProvider;

        $(document).ready(function () {

            RealGridJS.setTrace(false);
            RealGridJS.setRootContext("/script");

            dataProvider = new RealGridJS.LocalTreeDataProvider();
            gridView = new RealGridJS.TreeView("realgrid");
            gridView.setDataSource(dataProvider);

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
                    fieldName: "price"
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
                    fieldName: "addPrice"
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
                    width: 180
                }
                , {
                    name: "eName",
                    fieldName: "eName",
                    header: {
                        text: "영문명"
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
                            width: 100,
                            "button": "action"
                        }
                    ]
                }
                , {
                    name: "useFlag",
                    fieldName: "useFlag",
                    header: {
                        text: "사용여부"
                    },
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
                    border: "#88000000,1"
                }
            });

            gridView.onCellButtonClicked = function (grid, itemIndex, column) {

                if (column.fieldName == 'delete') {
                    var json = gridView.getValues(itemIndex);
                    json = JSON.stringify(json);
                    deleteData(json);

                } else if (column.fieldName == 'addSon') {
                    var json = gridView.getValues(itemIndex);
                    var current = gridView.getCurrent();
                    var row = current.dataRow;
                    var child = dataProvider.addChildRow(row,
                            {
                                itemPID: json.itemID
                            }, 0);

                    gridView.expand(gridView.getItemIndex(row));
                    current.itemIndex = gridView.getItemIndex(child);
                    gridView.setCurrent(current);
                    gridView.setFocus();
                } else if (column.fieldName == 'testCond') {

                    var itemIDClickedRow = gridView.getValues(itemIndex).itemID;
                    $("#popUp").val(itemIDClickedRow);
                    var popUrl = contextPath + "/com/testBaseManagement/testItemManagement/getReqTestItem/popUp.do";	//팝업창에 출력될 페이지 URL
                    var popOption = "width=740, height=400, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
                    var popWin = window.open(popUrl, "시험조건", popOption);
                }
            };
        });

        loadData();
    </script>
</head>
<body>
<input type="hidden" name="jsonTempRepo" id="jsonTempRepo">
<input type="hidden" name="popUp" id="popUp">

<div>
</div>
<div class="page-content">


    <td>
        <div role="main" class="ui-content jqm-content" align="center">
            <!-- 타이틀 -->
            <div>
                <div align="left">
                    <h3>시험방법 조회</h3><input id="searchKeyword"/><input type="button" id="search" value="검색"/>
                </div>
            </div>
            <div align="right">
                <input type="button" id="btnAppend" value="시험방법추가"/>
                <input type="button" id="save" value="저장"/>
            </div>
            <!-- // 타이틀 -->
            <div id="realgrid" style="width: 100%; height: 730px;"></div>

        </div>
    </td>

</div>

</body>
</html>
