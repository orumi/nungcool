<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>

<script>
    var gridView;
    var dataProvider;

    var gridView2;
    var dataProvider2;

    var gpcode;	//선택된 권한그룹 코드

    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("<c:url value='/script'/>");

        dataProvider = new RealGridJS.LocalDataProvider();
        gridView = new RealGridJS.GridView("realgrid");
        gridView.setDataSource(dataProvider);

        var fields = [
            {fieldName: "authorgpcode"}
            , {fieldName: "authorgpnm"}
            , {fieldName: "regid"}
            , {fieldName: "regdate"}
            , {fieldName: "orderby"}
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider.setFields(fields);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns = [
            {
                name: "authorgpnm",
                fieldName: "authorgpnm",
                header: {text: "권한그룹명"},
                width: 150
                /* ,
                 filters:[
                 {   criteria:"value = '기본2'",
                 name:"filter1",
                 text:"기본2"
                 }
                 ] */
            },
            {
                name: "orderby",
                fieldName: "orderby",
                header: {text: "정렬순서"},
                width: 80,
                styles: {textAlignment: "center"}
            },
            {
                name: "regid",
                fieldName: "regid",
                header: {text: "등록자"},
                width: 100,
                readOnly: "true"
            },
            {
                name: "regdate",
                fieldName: "regdate",
                header: {text: "등록일"},
                width: 100,
                readOnly: "true"
            }
        ];

        //컬럼을 GridView에 입력 합니다.
        gridView.setColumns(columns);

        /* 그리드 row추가 옵션사용여부 */
        gridView.setOptions({
            panel: {visible: false},
            footer: {visible: false},
            edit: {
                insertable: true,
                appendable: true
            },
            display: {
                fitStyle: "evenFill"
            }
        });

        gridView.setStyles(smart_style);
        /*gridView2.setStyles(smart_style);*/
        //그리드 클릭 이벤트
        gridView.onDataCellClicked = function (grid, index) {
            gpcode = gridView.getValue(index.dataRow, "authorgpcode");

            $.ajax({
                type: "post",
                dataType: "json",
                data: {"gpcode": gpcode},
                url: "<c:url value='/system/selAuthorList.json'/>",
                success: function (data) {
                    dataProvider2.fillJsonData(data);
                    var values = dataProvider2.getFieldValues("chkyn");  // 특정 필드의 값을 배열로 가져옵니다.
                    if (values.length > 0) {
                        for (var i = 0; i < values.length; i++) {
                            if (values[i]) {
                                gridView2.checkRow(i);
                            }
                        }
                    }
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                },
                complete: function (data) {
                    //gridView.hideToast();
                },
                cache: false
            });
        };


        /************
         그리드 2번!!!그룹별 권한목록
         ************/
        dataProvider2 = new RealGridJS.LocalDataProvider();
        gridView2 = new RealGridJS.GridView("realgrid2");
        gridView2.setDataSource(dataProvider2);


        var fields2 = [
            {fieldName: "authorgpcode"}
            , {fieldName: "chkyn"}
            , {fieldName: "authorcode"}
            , {fieldName: "authornm"}
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider2.setFields(fields2);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns2 = [
            {
                name: "authornm",
                fieldName: "authornm",
                header: {text: "권한명"},
                width: 350
            }
        ];

        //컬럼을 GridView에 입력 합니다.
        gridView2.setColumns(columns2);

        /* 그리드 row추가 옵션사용여부 */
        gridView2.setOptions({
            panel: {visible: false},
            footer: {visible: false},
            display: {
                fitStyle: "evenFill"
            }
        });
        gridView2.setStyles(smart_style);

    });

    $(function () {
        $("#add").click(btnAppendClickHandler);
        $("#save").click(btnSave);
        $("#del").click(btnDelete);
        $("#can").click(btnCancel);

        $("#save2").click(btnSaveAuthorList);

    });

    function sel() {
        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/system/selAuthorGrpList.json'/>",
            success: function (data) {
                dataProvider.fillJsonData(data);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            },
            complete: function (data) {
                //gridView.hideToast();
            },
            cache: false
        });
    }


    function btnCancel() {
        alert("취소");
        //gridView.setColumns();
        gridView.cancel();
    }


    function btnAppendClickHandler(e) {
        gridView.beginAppendRow();
        gridView.showEditor();
        gridView.setFocus();
    }

    function btnDelete(e) {
        var rows = gridView.getCheckedRows();
        var jRowsData = [];
        var jData

        if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                jData = dataProvider.getJsonRow(rows[i]);
                jRowsData.push(jData);
            }
            ;
        }

        if (jRowsData.length == 0) {
            return;
        }

        //var data = JSON.stringify(jRowsData)
        var val = JSON.stringify(jRowsData);
        var data = {"data": val};
        if (confirm("선택된 내용을 삭제하시겠습니까?")) {

            saveData("<c:url value='/system/delAuthorGrpList.json'/>", data);
        }

    }

    function btnSaveAuthorList(e) {
        var rows = gridView2.getCheckedRows();
        var jRowsData = [];
        var jData

        if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                jData = dataProvider2.getJsonRow(rows[i]);
                jRowsData.push(jData);
            }
            ;
        }

        if (jRowsData.length == 0) {
            alert("선택된 값이 없습니다.");
            return;
        }

        //var data = JSON.stringify(jRowsData)
        var val = JSON.stringify(jRowsData);
        var data = {"data": val, "gpcode": gpcode};
        if (confirm("선택된 내용을 저장하시겠습니까?")) {
            saveData2("<c:url value='/system/edtAuthorList.json'/>", data);
        }

    }

    function btnSave(e) {

        gridView.commit();

        var state;
        var jData;
        var jRowsData = [];

        var rows = dataProvider.getAllStateRows();

        if (rows.updated.length > 0) {
            for (var i = 0; i < rows.updated.length; i++) {
                jData = dataProvider.getJsonRow(rows.updated[i]);
                jData.state = "updated";
                jRowsData.push(jData);
            }
            ;
        }

        if (rows.created.length > 0) {
            for (var i = 0; i < rows.created.length; i++) {
                jData = dataProvider.getJsonRow(rows.created[i]);
                jData.state = "created";
                jRowsData.push(jData);
            }
            ;
        }

        if (jRowsData.length == 0) {
            alert("추가 또는 변경된 내용이 없습니다.");
            dataProvider.clearRowStates(true);
            return;
        }


        var val = JSON.stringify(jRowsData);
        var data = {"data": val};
        if (confirm("변경된 내용을 저장하시겠습니까?")) {

            saveData("<c:url value='/system/edtAuthorGrpList.json'/>", data);
        }
    }

    function saveData(urlStr, data) {
        $.ajax({
            url: urlStr,
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data != null) {
                    alert("정상 처리 되었습니다.");
                    dataProvider.clearRowStates(true);
                    dataProvider.fillJsonData(data);
                } else {
                    alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function saveData2(urlStr, data) {
        $.ajax({
            url: urlStr,
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data != null) {
                    alert("정상 처리 되었습니다.");
                    dataProvider2.fillJsonData(data);

                    var values = dataProvider2.getFieldValues("chkyn");  // 특정 필드의 값을 배열로 가져옵니다.
                    if (values.length > 0) {
                        for (var i = 0; i < values.length; i++) {
                            if (values[i]) {
                                gridView2.checkRow(i);
                            }
                        }
                    }
                } else {
                    alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    sel();
</script>

<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">
    <!-- 여기서 부터 내용 작성 -->
    <table width="100%">
        <%--<tr>
            <td width="48%">
                <!-- <span class="label label-xlg label-primary arrowed arrowed-right">권한그룹</span> -->
                <label>
                    <i class="ace-icon fa fa-angle-double-right"></i>
                    사용자그룹
                </label>
                <div class="text-right">
                <button class="btn btn-xs btn-white btn-default btn-round " id="add">
                    <i class="ace-icon fa fa-pencil align-top bigger-125"></i>
                    추가
                </button>
                <button class="btn btn-xs btn-white btn-default btn-round " id="save">
                    <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                    저장
                </button>
                <button class="btn btn-xs btn-white btn-default btn-round " id="del">
                    <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
                    삭제
                </button>
                <button class="btn btn-xs btn-white btn-default btn-round " id="can">
                    <i class="ace-icon fa fa-times red2"></i>
                    취소
                </button>
                </div>
            </td>
            <td rowspan="2" width="4%">
                &nbsp;
            </td>
            <td width="48%">
                <!-- <span class="label label-xlg label-primary arrowed arrowed-right">권한그룹</span> -->
                <label>
                    <i class="ace-icon fa fa-angle-double-right"></i>
                    그룹별 권한
                </label>
                <div class="text-right">
                <button class="btn btn-xs btn-white btn-default btn-round pull-right" id="save2">
                    <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                    저장
                </button>
                </div>
            </td>
        </tr>--%>
        <tr>
            <td width="48%">
                <!-- <span class="label label-xlg label-primary arrowed arrowed-right">권한그룹</span> -->
                <div class="page-content">
                    <div role="content">
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <div class="widget-body">
                                    <fieldset>
                                        <div class="col-md-6 form-group" style="float: left; width: 300px">
                                            <label class="col-md-6 form-label"><b>사용자 그룹</b></label>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-right">
                    <button class="btn btn-default" id="add">
                        <i class="ace-icon fa fa-pencil align-top bigger-125"></i>
                        추가
                    </button>
                    <button class="btn btn-default" id="save">
                        <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                        저장
                    </button>
                    <button class="btn btn-default" id="del">
                        <i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
                        삭제
                    </button>
                    <button class="btn btn-default" id="can">
                        <i class="ace-icon fa fa-times red2"></i>
                        취소
                    </button>
                </div>
                <div class="div-realgrid">
                    <div id="realgrid" style="width: 100%; height: 500px;"></div>
                </div>

                <!-- Footer -->

                <!-- Footer End -->
                <!-- end of realgrid Content -->


            </td>
            <td rowspan="2" width="4%">
                &nbsp;
            </td>
            <td width="48%">
                <!-- <span class="label label-xlg label-primary arrowed arrowed-right">권한그룹</span> -->
                <div class="page-content">
                    <div role="content">
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <div class="widget-body">
                                    <fieldset>
                                        <div class="col-md-6 form-group" style="float: left; width: 300px">
                                            <label class="col-md-6 form-label"><b>그룹권한 관리</b></label>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Content End-->

                    <div class="page-content">
                        <div class="text-right">
                            <button class="btn btn-default" id="save2">
                                <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
                                저장
                            </button>
                        </div>

                        <div class="div-realgrid">
                            <div id="realgrid2" style="width: 100%; height: 500px;"></div>
                        </div>
                        <!-- end of realgrid Content -->
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <!-- 작성완료 -->
</div>
