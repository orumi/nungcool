<%@ page import="java.util.List" %>
<%@ page import="tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeProductVO" %>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


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

    $(function () {

        $("#delete").click(deleteData);
        $("#loadData").click(loadData);
        $("#save").click(save);
        $("#selBox1").change(selBox1Handler);
        $("#selBox2Btn").click(selBox2BtnHandler);
        $("#addItem").click(popUp);
        $("#test").click(test);

    })

    function loadDataLeft(stringfied, itemIndex) {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: contextPath + "/com/testBaseManagement/testItemManagement/eleItemManage/loadDataLeft.do",
            data: {"data": stringfied},
            success: function (data) {
                var json = data[0];
                var values = {
                    displayType: json.displayType,
                    unitID: json.unitID
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
            url: contextPath + "/com/testBaseManagement/testItemManagement/eleItemManage/deleteData.do",
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
            url: contextPath + "/com/testBaseManagement/testItemManagement/eleItemManage/loadTestMethod.do",
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
            url: contextPath + "/com/testBaseManagement/testItemManagement/eleItemManage/loadTestCondition.do",
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

    function popUp() {

        if (masterID == undefined) {
            alert('먼저 추가 하실 제품을 선택 해 주세요');
            return;
        } else {
            var popUrl = "<c:url value= '/com/testBaseManagement/testItemManagement/eleItemManage/elePopUp.do' />";	//팝업창에 출력될 페이지 URL
            var popOption = "width=740, height=400, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
            var popWin = window.open(popUrl, "시험조건", popOption);
        }
    }

    function selBox1Handler() {

        var firstSelKey = $('#selBox1').find('option:selected').val();
        $.ajax({

            url: contextPath + "/com/testBaseManagement/testItemManagement/eleItemManage/getSecondList.do",
            type: "post",
            data: {"data": firstSelKey},
            dataType: "json",
            success: function (result) {

                $("#selBox2").find("option").remove();

                for (var i = 0; i < result.length; i++) {
                    $("#selBox2").append("<option value=" + "'" + result[i].groupID + "'" + ">" + result[i].name + " </option>")
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function selBox2BtnHandler() {

        var firstSelKey = $('#selBox2').find('option:selected').val();
        console.log('groupID number' + firstSelKey + ' 를 검색 합니다.');

        $.ajax({
            url: contextPath + "/com/testBaseManagement/testItemManagement/eleItemManage/getThirdList.do",
            type: "post",
            data: {"data": firstSelKey},
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
            url: contextPath + "/com/testBaseManagement/testItemManagement/eleItemManage/save.do",
            type: "POST",
            data: {"data": jsonv},
            success: function (data) {
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
            url: contextPath + "/com/testBaseManagement/testMethodManagement/retrieve.do",
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
            url: contextPath + "/com/testBaseManagement/testItemManagement/eleItemManage/loadRightOne.do",
            data: {"data": masterID},
            success: function (data) {
                dataProvider2.setRows(data, "tree", false);
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
        RealGridJS.setRootContext("/script");

        dataProvider = new RealGridJS.LocalDataProvider();
        gridView = new RealGridJS.GridView("realgrid");
        gridView.setDataSource(dataProvider);

        dataProvider2 = new RealGridJS.LocalTreeDataProvider();
        gridView2 = new RealGridJS.TreeView("realgrid2");
        gridView2.setDataSource(dataProvider2);

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
                fieldName: "price"
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

        ]

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider.setFields(fields);
        dataProvider2.setFields(fields2);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns = [

            {
                name: "masterID",
                fieldName: "masterID",
                header: {
                    text: "마스터\n아이디"
                },
                width: 70,
                readOnly: true
            }
            , {
                name: "oilType",
                fieldName: "oilType",
                header: {
                    text: "유종"
                },
                width: 70,
                readOnly: true
            }
            , {
                name: "name",
                fieldName: "name",
                header: {
                    text: "제품명"
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
                width: 170,
                readOnly: true
            }
            , {
                name: "adminID",
                fieldName: "adminID",
                header: {
                    text: "담당자"
                },
                width: 50,
                readOnly: true
            }
            , {
                name: "cnt",
                fieldName: "cnt",
                header: {
                    text: "항목수"
                },
                width: 50,
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
                width: 100
            }
            , {
                name: "lvl",
                fieldName: "lvl",
                header: {
                    text: "레벨"
                },
                width: 40
            }
            , {
                name: "methodID",
                fieldName: "methodID",
                header: {
                    text: "시험방법"
                },
                width: 100,
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
                width: 100
            }
            , {
                name: "unitID",
                fieldName: "unitID",
                header: {
                    text: "단위"
                },
                width: 100
            }
            , {
                name: "displayType",
                fieldName: "displayType",
                header: {
                    text: "결과유형"
                },
                width: 100
            }
            , {
                name: "charged",
                fieldName: "charged",
                header: {
                    text: "담당자"
                },
                width: 70
            }
            , {
                name: "order",
                fieldName: "order",
                header: {
                    text: "정렬순서"
                },
                width: 60
            }

            , {
                name: "condID",
                fieldName: "condID",
                header: {
                    text: "시험조건"
                },
                width: 100,
                "lookupDisplay": true,
                "lookupSourceId": "lookID2",
                "lookupKeyFields": ["itemID", "condID"],
                "editor": {
                    "type": "dropDown",
                    "editButtonVisibility": "always",
                    "dropDownCount": 3
                }
            }

        ];

        //컬럼을 GridView에 입력 합니다.
        gridView.setColumns(columns);
        gridView2.setColumns(columns2);


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
            indicator: {
                displayValue: "row"
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
            indicator: {
                displayValue: "row"
            },
            stateBar: {
                visible: false
            },
            display: {
                fitStyle: "evenFill"
            },
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

        gridView2.setLookups([{
            "id": "lookID2",
            "levels": 2
        }, {
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
	<div style="width: 37%;float: left;height: 900px;">
		<div style="height: 90px;">
			<div style="height: 40%;">
				<div class="col col-lg-3" style="float: left;background-color: #E6E6E6;height: 100%;display: table;border-bottom: 1px solid white; ">
					<b style="display: table-cell;text-align: center;vertical-align: middle;">유종구분</b>
				</div>
				<div class="col col-lg-9" style="float: left;border: 1px solid #E6E6E6;height: 100%;display: table;">
					<div style="display: table-cell;vertical-align: middle;">
						<select name="selBox1" id="selBox1" style="width: 200px;">
	                    	<option>선택 하세요</option>
	                        <%
	                        	for (int i = 0; i < list.size(); i++) {
	                            	OilTypeProductVO vo2 = (OilTypeProductVO) list.get(i);
	                       	 %>
	                        <option value="<%= vo2.getClassID() %>"><%= vo2.getName() %>
	                        </option>
	                        <%
	                        }
	                        %>
	                	</select>
	                </div>
				</div>
			</div>
			
			<div style="height: 40%;">
				<div class="col col-lg-3" style="float: left;background-color: #E6E6E6;height: 100%;display: table;">
					<b style="display: table-cell;text-align: center;vertical-align: middle;">유종</b>
				</div>
				<div class="col col-lg-9"  style="float: left;height: 100%; border-bottom: 1px solid #E6E6E6;border-right: 1px solid #E6E6E6;">
					<div style="float: left;width: 70%;height: 100%;display: table;">
						<div style="display: table-cell;vertical-align: middle;">
							<select name="selBox2" id="selBox2" style="width: 200px;">
	                    	</select>
	                    </div>
					</div>
					<div style="float: left;width: 30%;height: 100%;display: table;">
						<p style="display: table-cell;vertical-align: middle;text-align: center;">
							<button id="selBox2Btn" class="btn btn-default btn-sm">조회</button>
	                    	<button id="test" class="btn btn-default btn-sm">test</button>
	                    <p>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div id="realgrid" style="width: 100%; height: 765px;"></div>
		</div>
	</div>
	<div style="width: 60%;float: left;margin-left: 2%;height: 900px;" >
		<div style="height: 45px;">
			<div class="col col-lg-3" style="float: left;background-color: #E6E6E6;height: 85%;display: table;">
				<b style="display: table-cell;text-align: center;vertical-align: middle;">제품명</b>
			</div>
			<div class="col col-lg-6" style="float: left;height: 85%;border: 1px solid #E6E6E6;display: table;">
				<div style="display: table-cell;vertical-align: middle;">
					<input type="text" id="title" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; width:250px;" />
				</div>
			</div>
			<div class="col col-lg-3" style="float: left;display: table;height: 85%;">
				<p style="display: table-cell;vertical-align: middle;text-align: center;">
					<button id="addItem" class="btn btn-default btn-sm">항목추가</button>
               	 	<button id="delete" class="btn btn-default btn-sm">삭제</button>
                	<button id="save" class="btn btn-default btn-sm">저장</button>
				</p>
			</div>
		</div>
		<div>
			<div id="realgrid2" style="width: 100%; height: 800px;"></div>
		</div>
	</div>
</div>


