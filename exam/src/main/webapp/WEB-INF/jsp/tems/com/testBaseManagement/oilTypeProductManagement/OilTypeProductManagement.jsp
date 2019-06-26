<%@ page import="tems.com.login.model.LoginUserVO" %><%--@elvariable id="getContext" type=""--%>
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
    <script type="text/javascript" src="<c:url value='/script/realgridjs-lic.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs_eval.1.0.12.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs-api.1.0.12.js'/>"></script>
    <script type="text/javaScript" language="javascript" defer="defer">

        var contextPath = '<%=request.getContextPath()%>';
        var userID = '<%= userID %>';


        $(function () {
            $("#loadData").click(loadData);
            $("#save").click(save);
            $("#save2").click(save2);
            $("#save3").click(save3);
            $("#btnAppend").click(btnAppendClickHandler);
            $("#btnAppend2").click(btnAppend2ClickHandler);
            $("#btnAppend3").click(btnAppend3ClickHandler);
            $("#btnDelete1").click(btnDeleteClickHandler);
            $("#btnDelete2").click(btnDelete2ClickHandler);
            $("#btnDelete3").click(btnDelete3ClickHandler);
        })

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
        function btnDelete2ClickHandler() {

            if (confirm("정말로 삭제 하시겠습니까?")) {
                var checkedRows = gridView2.getCheckedRows();

                for (var i = 0; checkedRows.length > i; i++) {
                    var num = checkedRows[i];
                    dataProvider2.setRowState(num, "deleted");
                }
                save2();
            }
        }
        function btnDelete3ClickHandler() {

            if (confirm("정말로 삭제 하시겠습니까?")) {
                var checkedRows = gridView3.getCheckedRows();

                for (var i = 0; checkedRows.length > i; i++) {
                    var num = checkedRows[i];
                    dataProvider3.setRowState(num, "deleted");
                }
                save3();
            }
        }

        function btnAppendClickHandler(e) {
            gridView.beginAppendRow();
        }
        function btnAppend2ClickHandler(e) {
            gridView2.beginAppendRow();
        }
        function btnAppend3ClickHandler(e) {
            gridView3.beginAppendRow();
        }

        function save() {
            gridView.commit();
            saveData();
        }
        function save2() {
            gridView2.commit();
            saveData2();
        }
        function save3() {
            gridView3.commit();
            saveData3();
        }


        function btnPageNumClickHandler(obj) {
            var page = parseInt($(obj).val()) - 1;
            setPage(page);
        }

        function saveData() {

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

            if (rows.deleted.length > 0) {
                for (var i = 0; rows.deleted.length > i; i++) {
                    jData = dataProvider.getJsonRow(rows.deleted[i]);
                    jData.state = "deleted";
                    jRowsData.push(jData);
                }
            }

            var jsonv = $('#jsonTempRepo').val = JSON.stringify(jRowsData);

            $.ajax({
                url: contextPath + "/com/testBaseManagement/oilTypeProductManagement/saveData.do",
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
        function saveData2() {

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
                    var classID = classIdTempForSecond;
                    jData.classID = classID;
                    jData.regID = userID;
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

            var jsonv = $('#jsonTempRepo').val = JSON.stringify(jRowsData);

            $.ajax({
                url: contextPath + "/com/testBaseManagement/oilTypeProductManagement/saveData2.do",
                type: "POST",
                data: {"data": jsonv},
                success: function (data) {
                    loadData2(tempForSecondLoad);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }
        function saveData3() {

            var jData;
            var jRowsData = [];
            var rows = dataProvider3.getAllStateRows();

            if (rows.updated.length > 0) {
                for (var i = 0; rows.updated.length > i; i++) {
                    jData = dataProvider3.getJsonRow(rows.updated[i]);
                    jData.state = "updated";
                    jData.modifyID = userID;
                    jRowsData.push(jData);
                }
            }
            if (rows.created.length > 0) {
                for (var i = 0; rows.created.length > i; i++) {
                    jData = dataProvider3.getJsonRow(rows.created[i]);
                    jData.state = "created";
                    var groupID = groupIdTempForThird;
                    jData.groupID = groupID;
                    jData.regID = userID;
                    jRowsData.push(jData);
                }
            }
            if (rows.deleted.length > 0) {
                for (var i = 0; rows.deleted.length > i; i++) {
                    jData = dataProvider3.getJsonRow(rows.deleted[i]);
                    jData.state = "deleted";
                    jRowsData.push(jData);
                }
            }
            var jsonv = $('#jsonTempRepo').val = JSON.stringify(jRowsData);

            $.ajax({
                url: contextPath + "/com/testBaseManagement/oilTypeProductManagement/saveData3.do",
                type: "POST",
                data: {"data": jsonv},
                success: function (data) {
                    loadData3(tempForThirdLoad);
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
                url: contextPath + "/com/testBaseManagement/oilTypeProductManagement/select.do",
                success: function (data) {
                    dataProvider.fillJsonData(data);
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

        function loadData2(obj) {

            var tempRepo = $('#jsonTempRepo').val = obj;

            $.ajax({
                type: "post",
                url: contextPath + "/com/testBaseManagement/oilTypeProductManagement/loadData2.do",
                data: {"data": tempRepo},
                dataType: "json",
                success: function (data) {
                    dataProvider2.fillJsonData(data);
                },
                error: function (xhr, status, error, data) {
                    $("#loadResult").css("color", "red").text("Load failed: " + error).show();
                },
                cache: false
            });
        }

        function loadData3(obj) {

            var tempRepo = $('#jsonTempRepo').val = obj;

            $.ajax({
                type: "post",
                url: contextPath + "/com/testBaseManagement/oilTypeProductManagement/loadData3.do",
                data: {"data": tempRepo},
                dataType: "json",
                success: function (data) {
                    dataProvider3.fillJsonData(data);
                },
                error: function (xhr, status, error, data) {
                    $("#loadResult").css("color", "red").text("Load failed: " + error).show();
                },
                cache: false
            });
        }


    </script>
    <script type="">

        var gridView;
        var dataProvider;
        var gridView2;
        var dataProvider2;
        var gridView3;
        var dataProvider3;

        var classIdTempForSecond;
        var tempForSecondLoad;
        var groupIdTempForThird;
        var tempForThirdLoad;

        $(document).ready(function () {

            RealGridJS.setTrace(false);
            RealGridJS.setRootContext(${getContext}"/script");

            dataProvider = new RealGridJS.LocalDataProvider();
            dataProvider2 = new RealGridJS.LocalDataProvider();
            dataProvider3 = new RealGridJS.LocalDataProvider();

            gridView = new RealGridJS.GridView("realgrid");
            gridView2 = new RealGridJS.GridView("realgrid2");
            gridView3 = new RealGridJS.GridView("realgrid3");

            gridView.setDataSource(dataProvider);
            gridView2.setDataSource(dataProvider2);
            gridView3.setDataSource(dataProvider3);
            //필드를 가진 배열 객체를 생성합니다. gird1

            var fields = [
                {
                    fieldName: "classID"
                },
                {
                    fieldName: "name"
                }
                , {
                    fieldName: "eName"
                }, {
                    fieldName: "orderBy"
                }
                , {
                    fieldName: "useFlag"
                }
                , {
                    fieldName: "cnt"
                }

            ];
            //DataProvider의 setFields함수로 필드를 입력. grid1

            //필드와 연결된 컬럼 배열 객체를 생성.
            var columns = [
                {
                    name: "name",
                    fieldName: "name",
                    header: {
                        text: "유종구분명"
                    },
                    width: 200
                }
                , {
                    name: "eName",
                    fieldName: "eName",
                    header: {
                        text: "영문명"
                    },
                    width: 200
                }, {
                    name: "orderBy",
                    fieldName: "orderBy",
                    header: {
                        text: "순서"
                    },
                    width: 200
                }
                , {
                    name: "useFlag",
                    fieldName: "useFlag",
                    header: {
                        text: "사용여부"
                    },
                    editButtonVisibility: "always",
                    lookupDisplay: "true",
                    values: ["1", "0"],
                    labels: ["사용", "비사용"],
                    editor: {
                        type: "dropDown",
                        dropDownCount: 2
                    },
                    width: 200
                }
                , {
                    name: "cnt",
                    fieldName: "cnt",
                    header: {
                        text: "유종건수"
                    },
                    width: 200
                }
            ];

            var fields2 = [
                {
                    fieldName: "groupID"
                }
                , {
                    fieldName: "classID"
                }
                , {
                    fieldName: "name"
                }
                , {
                    fieldName: "eName"
                }
                , {
                    fieldName: "officeID"
                }
                , {
                    fieldName: "adminID"
                }
                , {
                    fieldName: "remark"
                }
                , {
                    fieldName: "useFlag"
                }
                , {
                    fieldName: "orderBy"
                }
                , {
                    fieldName: "cnt"
                }

            ];
            var columns2 = [

                {
                    name: "name",
                    fieldName: "name",
                    header: {
                        text: "유종명"
                    }
                    ,
                    width: 150
                },
                {
                    name: "eName",
                    fieldName: "eName",
                    header: {
                        text: "영문명"
                    }
                    ,
                    width: 150
                },
                {
                    name: "orderBy",
                    fieldName: "orderBy",
                    header: {
                        text: "순서"
                    },
                    width: 150
                },
                {
                    name: "useFlag",
                    fieldName: "useFlag",
                    header: {
                        text: "사용여부"
                    },
                    editButtonVisibility: "always",
                    lookupDisplay: "true",
                    values: ["1", "0"],
                    labels: ["사용", "비사용"],
                    editor: {
                        type: "dropDown",
                        dropDownCount: 2
                    },
                    width: 200
                },
                {
                    name: "officeID",
                    fieldName: "officeID",
                    header: {
                        text: "담당부서"
                    }
                    ,
                    width: 150
                },
                {
                    name: "adminID",
                    fieldName: "adminID",
                    header: {
                        text: "담당자"
                    }
                    ,
                    width: 150
                },
                {
                    name: "cnt",
                    fieldName: "cnt",
                    header: {
                        text: "제품건수"
                    }
                    ,
                    width: 150
                }

            ];

            var fields3 = [
                {
                    fieldName: "masterID"
                }
                , {
                    fieldName: "groupID"
                }
                , {
                    fieldName: "name"
                }
                , {
                    fieldName: "eName"
                }
                , {
                    fieldName: "remark"
                }
                , {
                    fieldName: "useFlag"
                }
                , {
                    fieldName: "orderBy"
                }
                , {
                    fieldName: "smpUnit"
                }
                , {
                    fieldName: "regID"
                }
                , {
                    filedName: "regDate"
                }
                , {
                    filedName: "modifyID"
                }
                , {
                    filedName: "modifyDate"
                }
            ];

            var columns3 = [

                {
                    name: "name",
                    fieldName: "name",
                    header: {
                        text: "유종명"
                    }
                    ,
                    width: 150
                },
                {
                    name: "eName",
                    fieldName: "eName",
                    header: {
                        text: "영문명"
                    }
                    ,
                    width: 150
                },
                {
                    name: "orderBy",
                    fieldName: "orderBy",
                    header: {
                        text: "순서"
                    },
                    width: 150
                },
                {
                    name: "useFlag",
                    fieldName: "useFlag",
                    header: {
                        text: "사용여부"
                    },
                    editButtonVisibility: "always",
                    lookupDisplay: "true",
                    values: ["1", "0"],
                    labels: ["사용", "비사용"],
                    editor: {
                        type: "dropDown",
                        dropDownCount: 2
                    },
                    width: 200
                }

            ];

            dataProvider.setFields(fields);
            gridView.setColumns(columns);

            dataProvider2.setFields(fields2);
            gridView2.setColumns(columns2);

            dataProvider3.setFields(fields3);
            gridView3.setColumns(columns3);

            /* 그리드 row추가 옵션사용여부 */
            gridView.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true,
            })
            gridView2.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true,
            })
            gridView3.setEditOptions({
                insertable: true,
                appendable: true,
                deletable: true,
            })
            //데이터를 바로 삭제하지 않고 상태만 변경
            dataProvider.setOptions({
                softDeleting: true
            })
            dataProvider2.setOptions({
                softDeleting: true
            })
            dataProvider3.setOptions({
                softDeleting: true
            })
			
			gridView.setStyles({
	    	"grid": {
	    		            "paddingRight": "2",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "2",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "2",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff000000",
	    		            "hoveredMaskBackground": "#1f5292f7",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#1f5292f7",
	    		            "textAlignment": "center",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff008800",
	    		            "paddingLeft": "2",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#ff696969",
	    		            "background": "#ffffffff",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "맑은 고딕,12",
	    		            "border": "#ff313539,1",
	    		        },
	    		        "panel": {
	    		            "borderRight": "#ff777777,1",
	    		            "paddingRight": "2",
	    		            "borderBottom": "#ff688caf,1",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "4",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "5",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff787878",
	    		            "hoveredMaskBackground": "#1f5292f7",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#1f5292f7",
	    		            "textAlignment": "near",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff008800",
	    		            "paddingLeft": "8",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#ff696969",
	    		            "background": "#ffdee2e7",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "돋움,11",
	    		            "border": "#ff313539,1",
	    		        },
	    		        "body": {
	    		            "borderRight": "#ffdedede,1",
	    		            "paddingRight": "2",
	    		            "borderBottom": "#ffdedede,1",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "2",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "2",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff666666",
	    		            "hoveredMaskBackground": "#1f5292f7",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#1f5292f7",
	    		            "textAlignment": "center",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff008800",
	    		            "paddingLeft": "2",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "line": "#ff808080,1",
	    		            "selectedBackground": "#ff696969",
	    		            "background": "#ffffffff",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "돋움,11",
	    		            "border": "#ff313539,1",
	    		            "empty": {
	    		                "borderRight": "#ff999999,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff999999,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffffffff",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#ff313539,1",
	    		            }
	    		        },
	    		        "fixed": {
	    		            "borderRight": "#ff999999,1",
	    		            "paddingRight": "2",
	    		            "borderBottom": "#ff999999,1",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "2",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "2",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff000000",
	    		            "hoveredMaskBackground": "#1f5292f7",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#1f5292f7",
	    		            "textAlignment": "center",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff008800",
	    		            "paddingLeft": "2",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#ff696969",
	    		            "background": "#ffd3d3d3",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "맑은 고딕,12",
	    		            "border": "#88888888,1",
	    		            "colBar": {
	    		                "borderRight": "#ff808080,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff808080,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffffffff",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#ff313539,1",
	    		            },
	    		            "rowBar": {
	    		                "borderRight": "#ff999999,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff999999,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffd3d3d3",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#88888888,1",
	    		            }
	    		        },
	    		        "header": {
	    		            "borderRight": "#ff5d8cc9,1",
	    		            "paddingRight": "2",
	    		            "borderBottom": "#ff5d8cc9,1",
	    		            "borderTop": "#ffffffff,1",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "2",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "2",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff002f6e",
	    		            "hoveredMaskBackground": "linear,#fffff8a9,#ffffd75e,90",
	    		            "selectedForeground": "#ffff0000",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "linear,#fffff8a9,#ffffd75e,90",
	    		            "textAlignment": "center",
	    		            "hoveredForeground": "#ff002f6e",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff000000",
	    		            "paddingLeft": "2",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#33000000",
	    		            "background": "linear,#ffe9f0f8,#ffc3d8f1,90",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "맑은 고딕,11,bold",
	    		            "border": "#ff313539,1",
	    		            "borderLeft": "#ffffffff,1",
	    		            "group": {
	    		                "borderRight": "#ff5d8cc9,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff5d8cc9,1",
	    		                "borderTop": "#ffffffff,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff002f6e",
	    		                "hoveredMaskBackground": "linear,#fffff8a9,#ffffd75e,90",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "linear,#fffff8a9,#ffffd75e,90",
	    		                "textAlignment": "center",
	    		                "hoveredForeground": "#ff222530",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "linear,#ffe9f0f8,#ffc3d8f1,90",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,11,bold",
	    		                "border": "#ff313539,1",
	    		                "borderLeft": "#ffffffff,1"
	    		            }
	    		        },
	    		        "footer": {
	    		            "borderRight": "#ff9099a3,1",
	    		            "paddingRight": "2",
	    		            "borderTop": "#ff79828b,1",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "2",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "1",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff000000",
	    		            "hoveredMaskBackground": "#1f5292f7",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#1f5292f7",
	    		            "textAlignment": "near",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff008800",
	    		            "paddingLeft": "2",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#ff696969",
	    		            "background": "#ffdee2e7",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "맑은 고딕,12",
	    		            "border": "#88888888,1",
	    		        },
	    		        "rowGroup": {
	    		            "header": {
	    		                "borderRight": "#ff85a8d0,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff85a8d0,1",
	    		                "borderTop": "#ffffffff,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff002f6e",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "near",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffd7e6f7",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,11,bold",
	    		                "border": "#ff313539,0",
	    		                "borderLeft": "#ffffffff,1"
	    		            },
	    		            "footer": {
	    		                "borderRight": "#ffd8e3f0,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ffffffff,0",
	    		                "borderTop": "#ffd8e3f0,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ff9cbade",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,11,bold",
	    		                "border": "#ffffffff,0",
	    		                "borderLeft": "#ffffffff,0"
	    		            },
	    		            "head": {
	    		                "borderRight": "#ff5d8cc9,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff5d8cc9,1",
	    		                "borderTop": "#ffffffff,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff002f6e",
	    		                "hoveredMaskBackground": "linear,#fffff8a9,#ffffd75e,90",
	    		                "selectedForeground": "#ffff0000",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "linear,#fffff8a9,#ffffd75e,90",
	    		                "textAlignment": "center",
	    		                "hoveredForeground": "#ff002f6e",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff000000",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ffff0000",
	    		                "background": "linear,#ffe9f0f8,#ffc3d8f1,90",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,11,bold",
	    		                "border": "#ff313539,1",
	    		                "borderLeft": "#ffffffff,1"
	    		            },
	    		            "foot": {
	    		                "borderRight": "#ff9099a3,1",
	    		                "borderTop": "#ff79828b,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "1",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "near",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffdee2e7",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#88888888,1",
	    		            },
	    		            "headerBar": {
	    		                "borderRight": "#ffffffff,0",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ffffffff,0",
	    		                "borderTop": "#ffffffff,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff002f6e",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "near",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff498ee1",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffd7e6f7",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,11",
	    		                "border": "#ffffffff,0",
	    		                "borderLeft": "#ffffffff,1"
	    		            },
	    		            "footerBar": {
	    		                "borderRight": "#ffd7e6f7,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ffffffff,0",
	    		                "borderTop": "#ffd7e6f7,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "near",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ff9cbade",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#ffffffff,0",
	    		                "borderLeft": "#ffffffff,0"
	    		            },
	    		            "bar": {
	    		                "borderRight": "#ff85a8d0,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff85a8d0,0",
	    		                "borderTop": "#ffffffff,0",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff002f6e",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "near",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffd7e6f7",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,11",
	    		                "border": "#ff313539,0",
	    		                "borderLeft": "#ffffffff,1"
	    		            },
	    		            "panel": {
	    		                "borderRight": "#ff5d8cc9,1",
	    		                "paddingRight": "1",
	    		                "borderBottom": "#ff5d8cc9,1",
	    		                "borderTop": "#ffffffff,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "1",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "1",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff002f6e",
	    		                "hoveredMaskBackground": "#fffff5a2",
	    		                "selectedForeground": "#ffff0000",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#fffff5a2",
	    		                "textAlignment": "center",
	    		                "hoveredForeground": "#ff002f6e",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff000000",
	    		                "paddingLeft": "1",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "line": "#ff5d8cc9,1",
	    		                "selectedBackground": "#ffff0000",
	    		                "background": "#ffd7e6f7",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "돋움,11",
	    		                "border": "#ff5d8cc9,1",
	    		                "borderLeft": "#ffffffff,1"
	    		            }
	    		        },
	    		        "indicator": {
	    		            "borderRight": "#ff93a4b9,1",
	    		            "paddingRight": "2",
	    		            "borderBottom": "#ff93a4b9,1",
	    		            "borderTop": "#ffffffff,1",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "2",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "2",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff002f6e",
	    		            "hoveredMaskBackground": "#fffff0b2",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#fffff0b2",
	    		            "textAlignment": "center",
	    		            "hoveredForeground": "#ff002f6e",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff1c82ff",
	    		            "paddingLeft": "2",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#fffff0b2",
	    		            "background": "#ffebf3fc",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "돋움,11",
	    		            "border": "#ff313539,1",
	    		            "borderLeft": "#ffffffff,1",
	    		            "head": {
	    		                "borderRight": "#ff5d8cc9,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff5d8cc9,1",
	    		                "borderTop": "#ffffffff,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "hoveredForeground": "#ffffffff",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "linear,#ffe9f0f8,#ffc3d8f1,90",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#ff000000,1",
	    		                "borderLeft": "#ffffffff,1"
	    		            },
	    		            "foot": {
	    		                "borderRight": "#ff9099a3,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff808080,1",
	    		                "borderTop": "#ff79828b,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff002f6e",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffdee2e7",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#88888888,1",
	    		                "borderLeft": "#ffffffff,1"
	    		            }
	    		        },
	    		        "checkBar": {
	    		            "borderRight": "#ffaab1b8,1",
	    		            "paddingRight": "2",
	    		            "borderBottom": "#ffaab1b8,1",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "2",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "2",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff555555",
	    		            "hoveredMaskBackground": "#1f5292f7",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#1f5292f7",
	    		            "textAlignment": "center",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff008800",
	    		            "paddingLeft": "2",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#ff696969",
	    		            "background": "#ffffffff",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "맑은 고딕,12",
	    		            "border": "#ff313539,1",
	    		            "head": {
	    		                "borderRight": "#ff5d8cc9,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff5d8cc9,1",
	    		                "borderTop": "#ffffffff,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "hoveredForeground": "#ffffffff",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "linear,#ffe9f0f8,#ffc3d8f1,90",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#ff000000,0",
	    		                "borderLeft": "#ffffffff,1"
	    		            },
	    		            "foot": {
	    		                "borderRight": "#ff9099a3,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff808080,1",
	    		                "borderTop": "#ff79828b,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffdee2e7",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#88888888,1",
	    		                "borderLeft": "#ffffffff,1"
	    		            }
	    		        },
	    		        "stateBar": {
	    		            "borderRight": "#ffaab1b8,1",
	    		            "paddingRight": "2",
	    		            "borderBottom": "#ffaab1b8,1",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "2",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "2",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff000000",
	    		            "hoveredMaskBackground": "#1f5292f7",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#1f5292f7",
	    		            "textAlignment": "center",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff008800",
	    		            "paddingLeft": "2",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#ff696969",
	    		            "background": "#ffffffff",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": "맑은 고딕,12",
	    		            "border": "#ff313539,1",
	    		            "head": {
	    		                "borderRight": "#ff5d8cc9,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff5d8cc9,1",
	    		                "borderTop": "#ffffffff,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "hoveredForeground": "#ffffffff",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "linear,#ffe9f0f8,#ffc3d8f1,90",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#ff000000,0",
	    		                "borderLeft": "#ffffffff,1"
	    		            },
	    		            "foot": {
	    		                "borderRight": "#ff9099a3,1",
	    		                "paddingRight": "2",
	    		                "borderBottom": "#ff808080,1",
	    		                "borderTop": "#ff79828b,1",
	    		                "iconAlignment": "center",
	    		                "paddingTop": "2",
	    		                "iconIndex": "0",
	    		                "iconOffset": "0",
	    		                "iconLocation": "left",
	    		                "iconPadding": "0",
	    		                "paddingBottom": "2",
	    		                "contentFit": "auto",
	    		                "foreground": "#ff000000",
	    		                "hoveredMaskBackground": "#1f5292f7",
	    		                "selectedForeground": "#ffffffff",
	    		                "disabledForeground": "#ff808080",
	    		                "hoveredBackground": "#1f5292f7",
	    		                "textAlignment": "center",
	    		                "lineAlignment": "center",
	    		                "figureBackground": "#ff008800",
	    		                "paddingLeft": "2",
	    		                "figureInactiveBackground": "#ffd3d3d3",
	    		                "selectedBackground": "#ff696969",
	    		                "background": "#ffdee2e7",
	    		                "inactiveBackground": "#ffd3d3d3",
	    		                "font": "맑은 고딕,12",
	    		                "border": "#88888888,1",
	    		                "borderLeft": "#ffffffff,1"
	    		            }
	    		        },
	    		        "selection": {
	    		            "paddingRight": "0",
	    		            "iconAlignment": "center",
	    		            "paddingTop": "0",
	    		            "iconIndex": "0",
	    		            "iconOffset": "0",
	    		            "iconLocation": "left",
	    		            "iconPadding": "0",
	    		            "paddingBottom": "0",
	    		            "contentFit": "auto",
	    		            "foreground": "#ff000000",
	    		            "hoveredMaskBackground": "#1f5292f7",
	    		            "selectedForeground": "#ffffffff",
	    		            "disabledForeground": "#ff808080",
	    		            "hoveredBackground": "#1f5292f7",
	    		            "textAlignment": "center",
	    		            "lineAlignment": "center",
	    		            "figureBackground": "#ff008800",
	    		            "paddingLeft": "0",
	    		            "figureInactiveBackground": "#ffd3d3d3",
	    		            "selectedBackground": "#ff696969",
	    		            "background": "#2f1e90ff",
	    		            "inactiveBackground": "#ffd3d3d3",
	    		            "font": ",12",
	    		            "border": "#5f1e90ff,2",
	    		        }
	    });


            gridView.onDataCellClicked = function (grid, index) {

                var stringified = JSON.stringify(index);
                var parsed = JSON.parse(stringified);
                var selection = gridView.getValues(parsed.itemIndex);
                classIdTempForSecond = $('#classIdTempForSecond').val = selection.classID;
                tempForSecondLoad = (JSON.stringify(selection))
                loadData2(tempForSecondLoad);
            }

            gridView2.onDataCellClicked = function (grid2, index2) {

                var stringified = JSON.stringify(index2);
                var parsed = JSON.parse(stringified);
                var selection = gridView2.getValues(parsed.itemIndex);
                groupIdTempForThird = $('#groupIdTempForThird').val = selection.groupID;
                tempForThirdLoad = (JSON.stringify(selection))
                loadData3((JSON.stringify(selection)));
            }

        });

        loadData();
    </script>
</head>
<body>

<input type="hidden" name="jsonTempRepo" id="jsonTempRepo">
<input type="hidden" name="classIdTempForSecond" id="classIdTempForSecond">
<input type="hidden" name="groupIdTempForThird" id="groupIdTempForThird">

<div class="page-content">
    <table width="100%">
        <tr>
            <td width="63%">
                <div align="right">


                    <button id="save" class="btn btn-white btn-info btn-round no-border">
                        <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                        Save
                    </button>

                    <button id="btnDelete1" class="btn btn-white btn-warning btn-round no-border">
                        <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
                        Delete
                    </button>

                    <button id="btnAppend" class="btn btn-white btn-default btn-round no-border">
                        <i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
                        Add
                    </button>

                    <div id="realgrid" style="width: 100%; height: 400px;" align="left">

                    </div>
                </div>
            </td>
            <td width="500px" rowspan="2">
                <div align="right">
                    <button id="save3" class="btn btn-white btn-info btn-round no-border">
                        <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                        Save
                    </button>

                    <button id="btnDelete3" class="btn btn-white btn-warning btn-round no-border">
                        <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
                        Delete
                    </button>

                    <button id="btnAppend3" class="btn btn-white btn-default btn-round no-border">
                        <i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
                        Add
                    </button>

                    <div id="realgrid3" style="width: 100%; height: 845px; "></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div align="right">
                    <button id="save2" class="btn btn-white btn-info btn-round no-border">
                        <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                        Save
                    </button>

                    <button id="btnDelete2" class="btn btn-white btn-warning btn-round no-border">
                        <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
                        Delete
                    </button>

                    <button id="btnAppend2" class="btn btn-white btn-default btn-round no-border">
                        <i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
                        Add
                    </button>

                    <div id="realgrid2" style="width: 100%; height: 400px;"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
<div>
</div>
<div id="content_pop">
    <div role="main" class="ui-content jqm-content" align="center">
        <!-- 타이틀 -->
        <input type="text" id="txtPageSize" value="10" style="text-align:right" hidden="true"/>

    </div>

</div>


</body>
</html>
