<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title>팝업창 인생은 선택의 연속 선택 하시오</title>
</head>
<script>

    $(function () {
        $("#btnLoad").click(loadData);
        /*$("#btnSave").click(save);
         $("#btnAppend").click(btnAppendClickHandler);
         $("#btnDelete").click(btnDeleteClickHandler);*/
    });

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
                "fieldName": "itemID"
            }, {
                "fieldName": "colA"
            }, {
                "fieldName": "colB"
            }, {
                "fieldName": "colC"
            }
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider.setFields(fields);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns = [
                    {
                        "name": "itemID",
                        "fieldName": "itemID",
                        "width": 150
                    }
                    , {
                        "name": "colA",
                        "fieldName": "colA",
                        "width": 150,
                        "lookupDisplay": true,
                        "lookupSourceId": "lookID",
                        "lookupKeyFields": ["itemID", "colA"],
                        "editor": {
                            "type": "dropDown",
                            "editButtonVisibility": "always",
                            "dropDownCount": 3
                        }
                    }
                    , {
                        "name": "colB",
                        "fieldName": "colB",
                        "width": 150
                    }
                    , {
                        "name": "colC",
                        "fieldName": "colC",
                        "width": 150,
                        "lookupDisplay": true,
                        "lookupSourceId": "lookID",
                        "lookupKeyFields": ["itemID", "colA"],

                    }


                ]
                ;

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
        gridView.setLookups([{
            "id": "lookID",
            "levels": 2,
            "keys": [
                ["4", "1"],
                ["4", "2"],
                ["4", "3"],
                ["4", "4"]
            ],
            "values": [
                "Vins et alcools Chevalier",
                "Victuailles en stock",
                "Toms Spezialitäten",
                "Hanari Carnes"
            ]

        }]);

        loadData();

        gridView.onCurrentChanged = function (grid, newIndex) {

            if (newIndex) {
                //var keyValue = grid.getValue(newIndex.itemIndex, "Country");
                lookupDataChange("");
            }
        };

        /*
        gridView.onEditChange =  function (grid, index, value) {
            if(index.fieldName == "colA"){
                gridView.setValue(index.itemIndex, "colB", "fadfsdfsadfsadfs")
            }
        }
*/

        function lookupDataChange(keyValue) {
            var lookup = ["1", "1", "a"];
            var lookup2 = ["1", "2", "b"];
            var lookup3 = ["1", "3", "c"];
            var lookup4 = ["3", "1", "d"];
            var lookup5 = ["3", "2", "e"];
            var lookups = [];
            lookups.push(lookup);
            lookups.push(lookup2);
            lookups.push(lookup3);
            lookups.push(lookup4);
            lookups.push(lookup5);
            gridView.fillLookupData("lookID", {
                rows: lookups
            });
        }


    })
    ;
</script>
<body>

<input type="hidden" id="jsonTempRepo"/>

<div class="col-xs-12">
    <div class="dd-handle" style="width: 100px;">
        골라
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
