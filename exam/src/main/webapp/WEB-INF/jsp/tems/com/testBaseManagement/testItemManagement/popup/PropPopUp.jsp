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
    <script>

        var contextPath = '<%=request.getContextPath()%>';

        $(function () {
            $("#retrieve").click(retrieve);
            $("#search").click(search);
            $("#save").click(save);
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
            console.log('btnAppendClickHandler');
            gridView.beginAppendRow();
            grid.commit();
        }

        function save() {
            var selectedRow = gridView.getSelectionData(); // 클릭 된 열 정보 배열 상태
            var methodID = selectedRow[0].methodID;
            var methodName = selectedRow[0].name;

            opener.injection(methodID, methodName);

            $("#selectedID", opener.document).val(selectedRow.methodID);
            $("#selectedMethodName", opener.document).val(selectedRow.name);

            window.close();
        }

        function btnPageNumClickHandler(obj) {
            var page = parseInt($(obj).val()) - 1;
            setPage(page);
        }

        function search() {
            console.log('search() has just been clicked. ajax is going to be activated soon');
            var searchKeyword = $("#searchKeyword").val();
            $.ajax({

                url: contextPath + "/com/testBaseManagement/testMethodManagement/searchTestItems.do",
                type: "post",
                data: {"data": searchKeyword},
                success: function (data) {
                    dataProvider.fillJsonData(data);
                    var pageSize = parseInt($('#txtPageSize').val());
                    var rowCount = parseInt(data);
                    var pageCount = Math.round((rowCount + pageSize / 2) / pageSize);
                    gridView.setPaging(true, pageSize, pageCount);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function saveData(urlStr) {

            var jData;
            var jRowsData = [];
            var rows = dataProvider.getAllStateRows();

            if (rows.updated.length > 0) {
                for (var i = 0; rows.updated.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.updated[i]);
                    jData.state = "updated";
                    jRowsData.push(jData);
                }
            }

            if (rows.created.length > 0) {
                for (var i = 0; rows.created.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.created[i]);
                    jData.state = "created";
                    jRowsData.push(jData);
                }
            }

            var jsonv = $('#jsonTempRepo').val = JSON.stringify(jRowsData);

            $.ajax({
                url: urlStr,
                type: "POST",
                data: {"data": jsonv},
                success: function (data) {
                    alert('저장이 완료 되었습니다.');
                    retrieve();
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }

        function retrieve() {

            $.ajax({
                type: "post",
                dataType: "json",
                url: contextPath + "/com/testBaseManagement/testMethodManagement/retrieve.do",
                success: function (data) {
                    dataProvider.fillJsonData(data);
                    var pageSize = parseInt($('#txtPageSize').val());
                    console.log('pageSize =>' + pageSize);
                    var rowCount = parseInt(data);
                    var pageCount = Math.round((rowCount + pageSize / 2) / pageSize);
                    gridView.setPaging(true, pageSize, pageCount);
                    setPage(0);
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
                loadData(dataProvider, page * pageSize);
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
            dataProvider = new RealGridJS.LocalDataProvider();
            gridView = new RealGridJS.GridView("realgrid");
            gridView.setDataSource(dataProvider);

            //필드를 가진 배열 객체를 생성합니다.
            var fields = [
                {
                    fieldName: "methodID"
                }
                , {
                    fieldName: "version"
                }, {
                    fieldName: "name"
                }
                , {
                    fieldName: "kName"
                }
                , {
                    fieldName: "kUrl"
                }

            ];
            //DataProvider의 setFields함수로 필드를 입력합니다.
            dataProvider.setFields(fields);

            //필드와 연결된 컬럼 배열 객체를 생성합니다.
            var columns = [
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
                }, {
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
                deletable: true,
                display: {
                    fitStyle: "evenFill"
                }
            })
            gridView.setStyles({
                selection: {
                    background: "#11000000",
                    border: "#88000000,1"
                }
            });
            gridView.onDataCellDblClicked = function (grid, index) {
                save();
            };

        });

        retrieve();
    </script>
</head>
<body>
<input type="hidden" name="jsonTempRepo" id="jsonTempRepo">

<div>
    <!-- 타이틀 -->
    <div>
        <div style="float: left; width: 50%;">
            <span style="float:left"><text size="100">시험방법 조회</text></span>
        </div>
        <div style="float: right; align-content : flex-end; vertical-align: bottom;">
            <input id="searchKeyword" align="right"/><input align="right" type="button" id="search" value="검색"/>
        </div>
    </div>
    <br/>
    <br/>

    <!-- // 타이틀 -->
    <div id="realgrid" style="width: 100%; height: 450px;"></div>

    <br/>
    <br/>

    <div align="center">
        <input type="text" id="txtPageSize" value="20" style="text-align:right" hidden="true"/>
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
        <input type="button" id="btnLast" value="Last" class="button black medium3"/>
    </div>
</div>

</body>
</html>
