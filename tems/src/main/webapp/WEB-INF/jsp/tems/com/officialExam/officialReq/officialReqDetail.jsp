<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%
    LoginUserVO nLoginVO = (LoginUserVO) session.getAttribute("loginUserVO");
%>
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<script src="<c:url value='/js/tems/common/stringutil.js'/>"></script>
<script src="<c:url value='/js/tems/common/priceutil.js'/>"></script>
<script>
    $(document).ready(function () {
        $("#UserModal").on('hidden.bs.modal', function () {
            gridView.cancel();
            dataProvider5.clearRows();
        });

        $("#modalPopUp").on('shown.bs.modal', function () {
            gridView.cancel();
            gridView2.resetSize();
        });

        $("#modalPopUp").on('shown.bs.modal', function () {
            gridView.cancel();
            gridView2.resetSize();
        });

        $("#UserModal").on('shown.bs.modal', function () {
            gridView.cancel();
            gridView3.resetSize();
            gridView4.resetSize();
            gridView5.resetSize();
        });

    });
</script>
<script>
    var gridView;
    var gridView2;
    var gridView3;
    var gridView4;
    var gridView5;
    var dataProvider;
    var dataProvider2;
    var dataProvider3;
    var dataProvider4;
    var dataProvider5;
    var reqid = "${reqDetail.reqid}";

    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("<c:url value='/script'/>");

        dataProvider = new RealGridJS.LocalTreeDataProvider();
        gridView = new RealGridJS.TreeView("realgrid");
        gridView.setDataSource(dataProvider);

        dataProvider2 = new RealGridJS.LocalTreeDataProvider();
        gridView2 = new RealGridJS.TreeView("realgrid2");
        gridView2.setDataSource(dataProvider2);

        dataProvider3 = new RealGridJS.LocalTreeDataProvider();
        gridView3 = new RealGridJS.TreeView("realgrid3");
        gridView3.setDataSource(dataProvider3);

        dataProvider4 = new RealGridJS.LocalDataProvider();
        gridView4 = new RealGridJS.GridView("realgrid4");
        gridView4.setDataSource(dataProvider4);

        dataProvider5 = new RealGridJS.LocalDataProvider();
        gridView5 = new RealGridJS.GridView("realgrid5");
        gridView5.setDataSource(dataProvider5);

        //setOptions(gridView);

        var fields = [
            {fieldName: "treefield"}
            , {fieldName: "itemid"}
            , {fieldName: "itempid"}
            , {fieldName: "methodid"}
            , {fieldName: "itemname"}
            , {fieldName: "unitid"}
            , {fieldName: "orderby", dataType: "number"}
            , {fieldName: "methodnm"}
            , {fieldName: "itemprice", dataType: "number"}
            , {fieldName: "price", dataType: "number"}
            , {fieldName: "pricecnt"}
            , {fieldName: "addprice", dataType: "number"}
            , {fieldName: "addpricecond"}
            , {fieldName: "remark"}
            , {fieldName: "condid"}
            , {fieldName: "condetc"}
            , {fieldName: "tempercond"}
            , {fieldName: "tempunit"}
            , {fieldName: "timecond"}
            , {fieldName: "timecondunit"}
            , {fieldName: "etc"}
            , {fieldName: "etcunit"}
            , {fieldName: "itemterm"}
            , {fieldName: "adminnm"}
            , {fieldName: "resultid"}
            , {fieldName: "reqid"}
            , {fieldName: "smpid"}
            , {fieldName: "resulttype"}
            , {fieldName: "adminid"}
            , {fieldName: "basiccond"}
            , {fieldName: "basicunit"}
            , {fieldName: "basicunitnm"}
            , {fieldName: "calc"}
            , {fieldName: "reqspec"}
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider.setFields(fields);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns = [
            {
                name: "itemname",
                fieldName: "itemname",
                header: {
                    text: "검사항목명"
                },
                styles: {
                    textAlignment: "near"
                },
                readOnly: "true",
                width: 250
            },
            {
                name: "unitid",
                fieldName: "unitid",
                header: {
                    text: "단위"
                },
                styles: {textAlignment: "near"},
                lookupDisplay: true,
                lookupSourceId: "lookID3",
                lookupKeyFields: ["itemid", "unitid"],
                editor: {
                    "type": "dropDown",
                    "dropDownCount": 5
                },
                editButtonVisibility: "always",
                width: 60
            },
            {
                name: "methodid",
                fieldName: "methodid",
                header: {
                    text: "시험방법"
                },
                styles: {textAlignment: "near"},
                lookupDisplay: true,
                lookupSourceId: "lookID1",
                lookupKeyFields: ["itemid", "methodid"],
                editor: {
                    "type": "dropDown",
                    "dropDownCount": 5
                },
                editButtonVisibility: "always",
                width: 150
            },
            {
                name: "reqspec",
                fieldName: "reqspec",
                header: {
                    text: "의뢰자\n요구방법"
                },
                readOnly: "true",
                width: 100
            },
            {
                name: "pricecnt",
                fieldName: "pricecnt",
                header: {
                    text: "수수료조건\n(무료처리 갯수)"
                },
                readOnly: "true",
                width: 0
            },
            {
                name: "itemprice",
                fieldName: "itemprice",
                header: {
                    text: "수수료\n(기본+추가)"
                },
                footer: {
                    styles: {
                        textAlignment: "far",
                        numberFormat: "0,000",
                        font: "굴림,12"
                    },
                    text: "합계",
                    groupText: "합계",
                    expression: "sum"
                },
                styles: {
                    "textAlignment": "far",
                    "numberFormat": "000,000"
                },
                width: 100
            },
            {
                name: "price",
                fieldName: "price",
                header: {
                    text: "기본수수료"
                },
                styles: {
                    "textAlignment": "far",
                    "numberFormat": "000,000"
                },
                readOnly: "true",
                width: 100
            },
            {
                "type": "group",
                "name": "기본수수료조건",
                "width": 160,

                "columns": [{
                    name: "basicond",
                    fieldName: "basiccond",
                    header: {
                        text: "조건"
                    },
                    readOnly: "true",
                    width: 80
                },
                    {
                        name: "basicunitnm",
                        fieldName: "basicunitnm",
                        header: {
                            text: "조건단위"
                        },
                        styles: {
                            "textAlignment": "far",
                            "numberFormat": "000,000"
                        },
                        readOnly: "true",
                        width: 80
                    }
                ]
            },
            {
                "type": "group",
                "name": "추가수수료조건",
                "width": 160,

                "columns": [{
                    name: "addpricecond",
                    fieldName: "addpricecond",
                    header: {
                        text: "기준"
                    },
                    readOnly: "true",
                    width: 80
                },
                    {
                        name: "addprice",
                        fieldName: "addprice",
                        header: {
                            text: "추가수수료"
                        },
                        styles: {
                            "textAlignment": "far",
                            "numberFormat": "000,000"
                        },
                        readOnly: "true",
                        width: 80
                    }
                ]
            },
            {
                name: "remark",
                fieldName: "remark",
                header: {
                    text: "비고"
                },
                styles: {textAlignment: "near"},
                width: 100
            },
            {
                type: "group",
                name: "시험조건",
                width: 160,

                columns: [{
                    name: "condid",
                    fieldName: "condid",
                    header: {
                        text: "선택"
                    },
                    lookupDisplay: true,
                    lookupSourceId: "lookID2",
                    lookupKeyFields: ["itemid", "condid"],
                    editor: {
                        "type": "dropDown",
                        "dropDownCount": 3
                    },
                    editButtonVisibility: "always",
                    width: 80
                },
                    {
                        name: "condetc",
                        fieldName: "condetc",
                        header: {
                            text: "기타"
                        },
                        width: 80
                    }
                ]
            },
            {
                name: "itemterm",
                fieldName: "itemterm",
                header: {
                    text: "시험기간"
                },
                width: 100
            },
            {
                name: "adminnm",
                fieldName: "adminnm",
                header: {
                    text: "담당자"
                },
                styles: {textAlignment: "near"},
                button: "action",
                buttonVisibility: "always",
                readOnly: "true",
                width: 200
            },
            {
                name: "orderby",
                fieldName: "orderby",
                header: {
                    text: "정렬\n순서"
                },
                width: 60
            }
        ];

        var fields2 = [
            {fieldName: "treefield"}
            , {fieldName: "itemid"}
            , {fieldName: "itempid"}
            , {fieldName: "itemnm"}
            , {fieldName: "ename"}
            , {fieldName: "price", dataType: "number"}
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider2.setFields(fields2);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns2 = [
            {
                name: "itemnm",
                fieldName: "itemnm",
                header: {
                    text: "검사항목명"
                },
                styles: {
                    textAlignment: "left"
                },
                width: 290
            },
            {
                name: "ename",
                fieldName: "ename",
                header: {
                    text: "영문명"
                },
                width: 290
            },
            {
                name: "price",
                fieldName: "price",
                header: {
                    text: "기본수수료"
                },
                styles: {
                    "textAlignment": "far",
                    "numberFormat": "000,000"
                },
                width: 100
            }
        ];

        var fields3 = [
            {fieldName: "treeview"}
            , {fieldName: "officeid"}
            , {fieldName: "name"}
            , {fieldName: "uppofficeid"}
            , {fieldName: "uppname"}
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider3.setFields(fields3);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns3 = [
            {
                name: "name",
                fieldName: "name",
                header: {text: "부서명"},
                width: 150,
                styles: {textAlignment: "near"},
                readOnly: "true"
            }
        ];


        var fields4 = [
            {fieldName: "adminid"}
            , {fieldName: "officeid"}
            , {fieldName: "authorgpcode"}
            , {fieldName: "name"}
            , {fieldName: "adminpw"}
            , {fieldName: "uppofficeid"}
            , {fieldName: "empid"}
            , {fieldName: "ename"}
            , {fieldName: "cellphone"}
            , {fieldName: "telno"}
            , {fieldName: "extension"}
            , {fieldName: "email"}
            , {fieldName: "umjpname"}
            , {fieldName: "umjdname"}
            , {fieldName: "umpgname"}
            , {fieldName: "birthday"}
            , {fieldName: "skin"}
            , {fieldName: "useflag"}
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider4.setFields(fields4);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns4 = [
            {
                name: "name",
                fieldName: "name",
                header: {text: "이름"},
                width: 350,
                readOnly: "true"
            },
            {
                name: "umjpname",
                fieldName: "umjpname",
                header: {text: "직위"},
                width: 350,
                readOnly: "true"
            },
            {
                name: "umjdname",
                fieldName: "umjdname",
                header: {text: "직책"},
                width: 350,
                readOnly: "true"
            }
        ];

        var fields5 = [
            {fieldName: "adminid"}
            , {fieldName: "name"}
            , {fieldName: "empid"}
            , {fieldName: "umjpname"}
            , {fieldName: "umjdname"}
            , {fieldName: "umpgname"}
        ];

        //DataProvider의 setFields함수로 필드를 입력합니다.
        dataProvider5.setFields(fields5);

        //필드와 연결된 컬럼 배열 객체를 생성합니다.
        var columns5 = [
            {
                name: "adminid",
                fieldName: "adminid",
                header: {text: "아이디"},
                width: 350,
                readOnly: "true"
            },
            {
                name: "name",
                fieldName: "name",
                header: {text: "이름"},
                width: 350,
                readOnly: "true"
            }
        ];

        //컬럼을 GridView에 입력 합니다.
        gridView.setColumns(columns);
        gridView2.setColumns(columns2);
        gridView3.setColumns(columns3);
        gridView4.setColumns(columns4);
        gridView5.setColumns(columns5);

        /* 헤더의 높이를 지정*/
        gridView.setHeader({
            height: 45
        });


        gridView.setStyles(smart_style);
        gridView2.setStyles(smart_style);
        gridView3.setStyles(smart_style);
        gridView4.setStyles(smart_style);
        gridView5.setStyles(smart_style);


        gridView.setLookups([
            {"id": "lookID1", "levels": 2}
            , {"id": "lookID2", "levels": 2}
            , {"id": "lookID3", "levels": 2}
        ]);


        /* 그리드 row추가 옵션사용여부 */
        gridView.setOptions({
            panel: {visible: false},
            footer: {visible: true}
        });

        gridView2.setOptions({
            panel: {visible: false},
            footer: {visible: false}
        });

        gridView3.setOptions({
            panel: {visible: false},
            footer: {visible: false},
            checkBar: {visible: false},
            display: {
                fitStyle: "evenFill"
            }
        });

        gridView4.setOptions({
            panel: {visible: false},
            footer: {visible: false},
            checkBar: {visible: false},
            display: {
                fitStyle: "evenFill"
            }
        });

        gridView5.setOptions({
            panel: {visible: false},
            footer: {visible: false},
            checkBar: {visible: false},
            display: {
                fitStyle: "evenFill"
            },
            edit: {
                deletable: true
            }
        });


        /* 그리드 이벤트 핸들러  */
        gridView.onCellButtonClicked = function (grid, itemIndex, column) {
            $("#UserModal").modal();
            $.ajax({
                type: "post",
                dataType: "json",
                url: "<c:url value='/system/selOfficeList.json'/>",
                success: function (data) {
                    dataProvider3.setRows(data, "treeview", true, "", "");
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                },
                complete: function (data) {
                    gridView3.expandAll();
                    var options = {
                        fields: ['officeid'],
                        values: ['<%=nLoginVO.getOfficeid()%>']
                    }
                    var itemindex = gridView3.searchItem(options);

                    gridView3.setCurrent({itemIndex: itemindex, column: "name"});
                },
                cache: false
            });

            var adminid = gridView.getValue(itemIndex, "adminid");
            var adminnm = gridView.getValue(itemIndex, "adminnm");
            if (adminid != null) {
                var adminids = adminid.split(",");
                var adminnms = adminnm.split(",");

                for (var i = 0; i < adminids.length; i++) {
                    var row = {
                        adminid: adminids[i],
                        name: adminnms[i]
                    };
                    dataProvider5.addRow(row);
                }
            }
        };


        gridView.onCellEdited = function (grid, itemIndex, dataRow, field) {
            gridView.commit();
            gridView.cancel();

            //if(field == '10'){
            if ("pricecnt" == dataProvider.getOrgFieldName(field)) {
                fnChildPriceChange(grid, itemIndex, dataRow, field);
            } else if ("methodid" == dataProvider.getOrgFieldName(field)) {

                var itemid = gridView.getValue(itemIndex, "itemid");
                var methodid = gridView.getValue(itemIndex, "methodid");

                if (methodid == '-1') {
                    return;
                }

                $.ajax({
                    type: "post",
                    dataType: "json",
                    data: {"itemid": itemid, "methodid": methodid},
                    url: "<c:url value='/exam/req/getItemMethodDetail.json'/>",
                    success: function (data) {
                        gridView.setValue(itemIndex, "methodid", data.methodid);
                        gridView.setValue(itemIndex, "methodnm", data.methodname);
                        gridView.setValue(itemIndex, "resulttype", data.ruleid);
                        gridView.setValue(itemIndex, "itemterm", data.term);
                        gridView.setValue(itemIndex, "unitid", data.unitid);
                        gridView.setValue(itemIndex, "adminnm", data.admin);
                        gridView.setValue(itemIndex, "adminid", data.adminid);
                        gridView.setValue(itemIndex, "calc", data.calc);
                    },
                    error: function (request, status, error) {
                        alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                    },
                    complete: function (data) {
                        //gridView.hideToast();
                    },
                    cache: false
                });

            } else if ("condid" == dataProvider.getOrgFieldName(field)) {

                var itemid = gridView.getValue(itemIndex, "itemid");
                var condid = gridView.getValue(itemIndex, "condid");

                $.ajax({
                    type: "post",
                    dataType: "json",
                    data: {"itemid": itemid, "condid": condid},
                    url: "<c:url value='/exam/req/getItemConditionDetail.json'/>",
                    success: function (data) {
                        gridView.setValue(itemIndex, "tempercond", data.tempercond);
                        gridView.setValue(itemIndex, "tempunit", data.tempunit);
                        gridView.setValue(itemIndex, "timecond", data.timecond);
                        gridView.setValue(itemIndex, "timecondunit", data.timecondunit);
                        gridView.setValue(itemIndex, "etc", data.etc);
                        gridView.setValue(itemIndex, "etcunit", data.etcunit);

                        if (gridView.getValue(itemIndex, "addprice") > 0) {
                            var timecond = gridView.getValue(itemIndex, "timecond");
                            var price = gridView.getValue(itemIndex, "price");
                            var addprice = gridView.getValue(itemIndex, "addprice");
                            var basiccond = gridView.getValue(itemIndex, "basiccond");
                            var addpricecond = findnumber(gridView.getValue(itemIndex, "addpricecond"));

                            var itemprice = eval(price + (Math.ceil((timecond - basiccond) / addpricecond)) * addprice);
                            gridView.setValue(itemIndex, "itemprice", itemprice);
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
            } else if ("condetc" == dataProvider.getOrgFieldName(field)) {

                var condetc = findstring(gridView.getValue(itemIndex, "condetc"));
                if (condetc == "일" || condetc == "시간") {
                    if (gridView.getValue(itemIndex, "addprice") > 0) {
                        var condetc = findnumber(gridView.getValue(itemIndex, "condetc"));
                        var price = gridView.getValue(itemIndex, "price");
                        var addprice = gridView.getValue(itemIndex, "addprice");
                        var basiccond = gridView.getValue(itemIndex, "basiccond");
                        var addpricecond = findnumber(gridView.getValue(itemIndex, "addpricecond"));

                        var itemprice = eval(price + (Math.ceil((condetc - basiccond) / addpricecond)) * addprice);
                        gridView.setValue(itemIndex, "itemprice", itemprice);
                    }
                } else {
                    gridView.setValue(itemIndex, "itemprice", gridView.getValue(itemIndex, "price"));
                }

            }
        }

        gridView3.onCurrentChanged = function (grid, index) {
            var officeid = gridView3.getValue(index.itemIndex, "officeid");
            $.ajax({
                type: "post",
                dataType: "json",
                data: {"officeid": officeid},
                url: "<c:url value='/system/selOfficeUserList.json'/>",
                success: function (data) {
                    dataProvider4.fillJsonData(data);
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

        gridView4.onDataCellDblClicked = function (grid, index) {
            var row = {
                adminid: gridView4.getValue(index.itemIndex, "adminid"),
                name: gridView4.getValue(index.itemIndex, "name")
            };
            dataProvider5.addRow(row);
        };

        gridView5.onDataCellDblClicked = function (grid, index) {
            gridView5.deleteSelection(true);
        };


        fnGetReqResultList();
    });

    function setOptions(tree) {
        tree.setOptions({
            summaryMode: "aggregate",
            stateBar: {
                visible: false
            }
        });

        tree.addCellStyle("style01", {
            background: "#cc6600",
            foreground: "#ffffff"
        });
    }

    function fnExpand() {
        gridView.expandAll();
    }

    function btnAppendClick(e) {
        gridView.beginAppendRow();
        gridView.commit();
    }


    function showDiv(tag) {
        if (tag == 'email') {
            if ($("#div_email").css("display") == "none") {
                $("#div_email").show();
            } else {
                $("#div_email").hide();
            }
            //$("#div_email").css("display");
        } else if (tag == 'sms') {
            if ($("#div_sms").css("display") == "none") {
                $("#div_sms").show();
            } else {
                $("#div_sms").hide();
            }
            //$("#div_email").css("display");
        }


    }

    function fnGoList() {
        window.location.href = "<c:url value='/exam/req/ReqList.do'/>";

    }

    function fnReqDelete() {
        if (confirm("삭제 하시겠습니까?")) {
            $.ajax({
                type: "post",
                dataType: "json",
                data: {"reqid": reqid},
                url: "<c:url value='/exam/req/delRequest.json'/>",
                success: function (data) {
                    alert("삭제 처리 되었습니다.");
                    window.location.href = "<c:url value='/exam/req/ReqList.do'/>";
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
    }

    function fnSaveRemark() {
        var remark = $("#remark").val();
        $.ajax({
            type: "post",
            dataType: "json",
            data: {"reqid": reqid, "remark": remark},
            url: "<c:url value='/exam/req/upReqRemark.json'/>",
            success: function (data) {
                alert("정상 처리 되었습니다.");
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


    function fnGetReqResultList() {
        var cmbsmpid = $("#cmbsmpid").val();
        $.ajax({
            type: "post",
            dataType: "json",
            data: {"reqid": reqid, "smpid": cmbsmpid},
            url: "<c:url value='/exam/req/getReqResultList.json'/>",
            success: function (data) {
                dataProvider.setRows(data.reqItemDetailList, "treefield", false, "", "");
                $("#sumitemprice").text(addComma(data.reqPriceVO.sumprice));	//항목수수료
                $("#sumdiscount").text(addComma(data.reqPriceVO.dcsumprice) + "(" + data.reqPriceVO.dcrate + "%)");		//회원할인률
                $("#sumetcprice").val(addComma(data.reqPriceVO.etcprice));		//기타수수료
                $("#sumbasicprice").text(addComma(data.reqPriceVO.orireportprice));		//기본수수료
                $("#sumcopyprice").text(addComma(data.reqPriceVO.copyreportprice));		//부본수수료
                $("#sumaddprice").val(addComma(data.reqPriceVO.dcprice));		//조정금액
                $("#sumnotvat").text(addComma(data.reqPriceVO.vatnotprice));	//부가세별도
                $("#sumvat").text(addComma(data.reqPriceVO.vatprice));			//부가세
                $("#sumtotalprice").text(addComma(data.reqPriceVO.totalprice));	//총합
                $("#pricedesc").val(data.reqPriceVO.pricedesc);	//수수료비고
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            },
            complete: function (data) {
                gridView.expandAll();
                //fnRePrice(gridView, dataProvider);
                //loadTestMethod();
                //loadTestCondition();
                //loadTestUnit();
                fnGetLookup();
            },
            cache: false
        });
    }


    function fnResultDelete() {

        var rows = gridView.getCheckedRows();
        var jRowsData = [];
        var jData

        if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {

                var chieldValue = dataProvider.getChildren(rows[i]);
                if (chieldValue != null) {
                    for (var j = 0; j < chieldValue.length; j++) {
                        jData = dataProvider.getJsonRow(chieldValue[j]);
                        jRowsData.push(jData);
                    }
                }
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
        if (confirm(" 선택한 항목의 \n 하위 항목이 있을경우\n 함께 삭제가 이루어 집니다.\n 선택된 내용을 삭제하시겠습니까?")) {

            saveData("<c:url value='/exam/req/delRequestResult.json'/>", data);
        }

    }

    function fnResultDeleteAll() {

        var rows = gridView.getCheckedRows();
        var jRowsData = [];
        var jData

        if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {

                var chieldValue = dataProvider.getChildren(rows[i]);
                if (chieldValue != null) {
                    for (var j = 0; j < chieldValue.length; j++) {
                        jData = dataProvider.getJsonRow(chieldValue[j]);
                        jRowsData.push(jData);
                    }
                }
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
        if (confirm(" 선택한 항목의 \n 모든시료에 대한  \n 하위 항목이 있을경우\n 함께 삭제가 이루어 집니다.\n 선택된 내용을 삭제하시겠습니까?")) {

            saveData("<c:url value='/exam/req/delRequestResultAll.json'/>", data);
        }

    }

    function saveData(urlStr, data) {
        $.ajax({
            url: urlStr,
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.RESULT_YN == "Y") {
                    alert("정상 처리 되었습니다.");
                    dataProvider.clearRowStates(true);
                    fnGetReqResultList();
                } else {
                    alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            },
            complete: function (data) {
                gridView.expandAll();
                fnRePrice(gridView, dataProvider);
            },
            cache: false
        });
    }

    function saveDataReturn(urlStr, data) {
        $.ajax({
            url: urlStr,
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.RESULT_YN == "Y") {
                    alert("정상 처리 되었습니다.");
                    fnGoList();
                } else {
                    alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            },
            complete: function (data) {
                gridView.expandAll();
                fnRePrice(gridView, dataProvider);
            },
            cache: false
        });
    }

    function saveDataConfirm(urlStr, data) {
        $.ajax({
            url: urlStr,
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.RESULT_YN == "Y") {
                    alert("정상 처리 되었습니다.");
                    $("#reqConfModal").modal('hide');
                    window.location.href = "<c:url value='/exam/req/ReqList.do'/>";
                } else {
                    alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            },
            complete: function (data) {
            },
            cache: false
        });
    }

    function fnResultAdd() {

        $("#modalPopUp").modal();
        $("#modalAdd").attr("onclick", "javascript:fnAddItem()");
        $("#myModalLabel").text("항목추가");
        fnGetItemList();
    }

    function fnResultAddAll() {

        $("#modalPopUp").modal();
        $("#modalAdd").attr("onclick", "javascript:fnAddItemAll()");
        $("#myModalLabel").text("항목일괄추가");
        fnGetItemList();
    }

    function fnAddItemAll() {
        var rows = gridView2.getCheckedRows();
        var jRowsData = [];
        var jData

        if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                jData = dataProvider2.getJsonRow(rows[i]);
                jData.reqid = reqid;
                jRowsData.push(jData);
            }
            ;
        }

        if (jRowsData.length == 0) {
            return;
        }

        var val = JSON.stringify(jRowsData);
        var data = {"data": val};
        var urlStr = "<c:url value='/exam/req/addResultItemAll.json'/>";
        $.ajax({
            url: urlStr,
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.RESULT_YN == "Y") {
                    alert("정상 처리 되었습니다.");
                    $("#modalPopUp").modal('hide');
                    fnGetReqResultList();
                } else {
                    alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function fnGetItemList() {
        var itemnm = $("#itemnm").val();
        $.ajax({
            type: "post",
            dataType: "json",
            data: {"itemnm": itemnm},
            url: "<c:url value='/exam/req/getItemList.json'/>",
            success: function (data) {
                dataProvider2.setRows(data, "treefield", true, "", "");

            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            },
            complete: function (data) {
                gridView2.expandAll();
                gridView2.setCheckableExpression("count = 0", true);
            },
            cache: false
        });
    }

    function fnAddItem() {
        var rows = gridView2.getCheckedRows();
        var jRowsData = [];
        var jData

        if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                jData = dataProvider2.getJsonRow(rows[i]);
                jData.reqid = reqid;
                jData.smpid = $("#cmbsmpid").val();
                jRowsData.push(jData);
            }
            ;
        }

        if (jRowsData.length == 0) {
            return;
        }

        var val = JSON.stringify(jRowsData);
        var data = {"data": val};
        var urlStr = "<c:url value='/exam/req/addResultItem.json'/>";
        $.ajax({
            url: urlStr,
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.RESULT_YN == "Y") {
                    alert("정상 처리 되었습니다.");
                    $("#modalPopUp").modal('hide');
                    fnGetReqResultList();
                } else {
                    alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    //lookup 처리
    function fnGetLookup() {
        var cmbsmpid = $("#cmbsmpid").val();
        $.ajax({
            type: "post",
            dataType: "json",
            url: "<c:url value='/common/getComboListAll.json'/>",
            data: {"reqid": reqid, "smpid": cmbsmpid},
            success: function (data) {
                lookupDataChange(data.MethodList, data.CondList, data.UnitList);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }


    function lookupDataChange(data1, data2, data3) {
        var lookups = [];
        for (var i = 0; i < data1.length; i++) {
            var json = data1[i];
            var lookup = [json.itemid, json.methodid, json.name];
            lookups.push(lookup);
        }
        gridView.fillLookupData("lookID1", {
            rows: lookups
        })

        lookups = [];
        for (var i = 0; i < data2.length; i++) {
            var json = data2[i];
            var lookup = [json.itemid, json.condid, json.testcond];
            lookups.push(lookup);
        }
        gridView.fillLookupData("lookID2", {
            rows: lookups
        })

        lookups = [];
        for (var i = 0; i < data3.length; i++) {
            var json = data3[i];
            var lookup = [json.itemid, json.unitid, json.unitid];
            lookups.push(lookup);
        }
        gridView.fillLookupData("lookID3", {
            rows: lookups
        })
    }

    function fnUserAdd() {

        var data = dataProvider5.getRows(0, -1);
        var adminid = "";
        var adminnm = "";
        for (var i = 0; i < data.length; i++) {
            if (i == 0) {
                adminid = adminid + data[i][0];
                adminnm = adminnm + data[i][1];
            } else {
                adminid = adminid + "," + data[i][0];
                adminnm = adminnm + "," + data[i][1];
            }
        }
        var crow = gridView.getCurrent();
        gridView.setValue(crow.itemIndex, "adminid", adminid);
        gridView.setValue(crow.itemIndex, "adminnm", adminnm);

        $("#UserModal").modal('hide');
    }

    function fnSaveResult() {
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

        if (jRowsData.length == 0) {
            alert("변경된 내용이 없습니다.");
            dataProvider.clearRowStates(true);
            return;
        }


        var val = JSON.stringify(jRowsData);
        var data = {"data": val};
        if (confirm(" 변경된 내용을 \n 저장 하시겠습니까?")) {
            saveData("<c:url value='/exam/req/edtResultList.json'/>", data);
        }
    }

    function fnResultUpdateAll() {
        gridView.commit();

        var state;
        var jData;
        var jRowsData = [];

        var rows = gridView.getCheckedRows();

        if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                jData = dataProvider.getJsonRow(rows[i]);
                jRowsData.push(jData);
            }
            ;
        }

        if (jRowsData.length == 0) {
            alert("변경된 내용이 없습니다.");
            dataProvider.clearRowStates(true);
            return;
        }


        var val = JSON.stringify(jRowsData);
        var data = {"data": val};
        if (confirm(" 선택된 항목들의 속성을\n 모든 시료에 적용 하시겠습니까?")) {
            saveData("<c:url value='/exam/req/upResultDetailAll.json'/>", data);
        }
    }

    function fnPriceSave() {

        var dcprice = $("#sumaddprice").val();
        var etcprice = $("#sumetcprice").val();
        var pricedesc = $("#pricedesc").val();
        var data = {"dcprice": dcprice, "etcprice": etcprice, "reqid": reqid, "pricedesc": pricedesc};
        if (confirm(" 수수료 정보를 저장 하시겠습니까?")) {
            saveData("<c:url value='/exam/req/upReqPrice.json'/>", data);
        }
    }

    function fnSaveReq() {
        var data = {"reqid": reqid, "cmbstate": "2"};
        if (confirm(" 접수완료처리 하시겠습니까?")) {
            saveDataReturn("<c:url value='/exam/req/upReqStateOne.json'/>", data);
        }
    }

    function fnConfirm() {
        $("#reqConfModal").modal('show');
    }

    function fnAttachDown(filenick, fileName) {
        window.open("<c:url value='/common/getFileDown.json?filenick="+filenick+"&fileName="+fileName+"'/>");
    }
</script>
<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">


    <!-- top button area  -->
    <div role="content">
        <div class="dt-toolbar border-bottom-solid">
            <div class="col-sm-6">
                <div class="txt-guide">
                </div>
            </div>


            <div class="col-sm-6 text-right">
                <!--
                    <button class="btn btn-primary" onclick="javascript:void(0);">
                        <i class="fa fa-save"></i> 저장
                    </button>
                 -->
                <c:if test="${reqDetail.reqstate eq '0'}">
                    <button class="btn btn-danger" onclick="javascript:fnReqDelete();">
                        <i class="fa fa-trash-o"></i> 삭제
                    </button>
                </c:if>
                <button class="btn btn-primary" onclick="javascript:alert();">
                    <i class="fa fa-krw"></i> 세금계산서
                </button>
                <button class="btn btn-default" onclick="javascript:fnGoList();">
                    <i class="fa fa-th-list"></i> 목록
                </button>
            </div>

            <!-- end of div dt-toolbar content -->
        </div>
    </div>


    <!-- 신청자 정보 --------------------------------------------------------------------------------------- -->
    <!-- start of content 신청자 정보 -->
    <div role="content" class="clear-both sub-content">

        <!--  start of  form-horizontal tems_search  -->
        <!--  start of widget-body -->
        <div class="form-horizontal form-terms ui-sortable">
            <div class="jarviswidget jarviswidget-sortable" role="widget">
                <header role="heading">

                    <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                    <h2>신청자</h2>
                </header>

                <!-- body -->
                <div class="widget-body">


                    <fieldset>
                        <div class="col-md-3 form-group ">
                            <label class="col-md-4 form-label">업체명</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.comname }</span>
                            </div>
                        </div>
                        <div class="col-md-3 form-group">
                            <label class="col-md-4 form-label">대표자</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.ceoname}</span>
                            </div>
                        </div>
                        <div class="col-md-3 form-group">
                            <label class="col-md-4 form-label">담당자</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.mngname}</span>
                            </div>
                        </div>
                        <div class="col-md-3 form-group">
                            <label class="col-md-4 form-label">담당부서</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.mngdept}</span>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <div class="col-md-3 form-group ">
                            <label class="col-md-4 form-label">이메일</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.mngemail}</span>
                            </div>
                        </div>
                        <div class="col-md-3 form-group">
                            <label class="col-md-4 form-label">휴대폰</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.mnghp}</span>
                            </div>
                        </div>
                        <div class="col-md-3 form-group">
                            <label class="col-md-4 form-label">전화번호</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.mngphone}</span>
                            </div>
                        </div>
                        <div class="col-md-3 form-group">
                            <label class="col-md-4 form-label">팩스번호</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.fax}</span>
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


    <!-- 성적서 정보--------------------------------------------------------------------------------------- -->
    <!-- start of content 성적서 정보 -->
    <div role="content" class="clear-both sub-content">

        <!--  start of  form-horizontal tems_search  -->
        <!--  start of widget-body -->
        <div class="form-horizontal form-terms ui-sortable">
            <div class="jarviswidget jarviswidget-sortable" role="widget">
                <header role="heading">

                    <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                    <h2>성적서</h2>
                </header>

                <!-- body -->
                <div class="widget-body">


                    <fieldset>
                        <div class="col-md-4 form-group ">
                            <label class="col-md-4 form-label">성적서용도</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.usage}</span>
                            </div>
                        </div>
                        <div class="col-md-4 form-group">
                            <label class="col-md-4 form-label">성적서 원본/등본</label>
                            <div class="col-md-8">
				<span class="txt-sub-content">
				<c:choose>
                    <c:when test="${reqDetail.langtype eq 'K'}">
                        국문
                    </c:when>
                    <c:otherwise>
                        영문
                    </c:otherwise>
                </c:choose>
				${reqDetail.orgcnt}/${reqDetail.copycnt}

				</span>
                            </div>
                        </div>
                        <div class="col-md-4 form-group">
                            <label class="col-md-4 form-label">시료개수</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.smpcnt}</span>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <div class="col-md-4 form-group ">
                            <label class="col-md-4 form-label">성적서수신업체</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.rcvcompany}</span>
                            </div>
                        </div>
                        <div class="col-md-4 form-group">
                            <label class="col-md-4 form-label">성적서수신인</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.rcvdept}</span>
                            </div>
                        </div>
                        <div class="col-md-4 form-group">
                            <label class="col-md-4 form-label"><font color="blue">시험완료후 시료처리</font></label>
                            <div class="col-md-8">
                                <span class="txt-sub-content"><font color="blue">${reqDetail.itemafter}</font></span>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <div class="col-md-12 form-group ">
                            <label class="col-md-2 form-label col-11p">성적서수신주소</label>
                            <div class="col-md-10 col-89p">
                                <span class="txt-sub-content">(${reqDetail.rcvzipcode}) ${reqDetail.rcvaddr1}&nbsp;${reqDetail.rcvaddr2} </span>
                            </div>
                        </div>

                    </fieldset>


                    <fieldset>
                        <div class="col-md-4 form-group ">
                            <label class="col-md-4 form-label">세금계산서 청구</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.pricechargetype}</span>
                            </div>
                        </div>
                        <div class="col-md-4 form-group">
                            <label class="col-md-4 form-label">세금계산서 업체</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.taxcompany}</span>
                            </div>
                        </div>
                        <div class="col-md-4 form-group">
                            <label class="col-md-4 form-label">세금계산서 담당자</label>
                            <div class="col-md-8">
                                <span class="txt-sub-content">${reqDetail.taxmngname}</span>
                            </div>
                        </div>
                    </fieldset>


                    <fieldset>
                        <div class="col-md-12 form-group ">
                            <label class="col-md-2 form-label col-11p">세금계산서 주소</label>
                            <div class="col-md-10 col-89p">
                                <span class="txt-sub-content">(${reqDetail.taxzipcode}) ${reqDetail.taxaddr1}&nbsp;${reqDetail.taxaddr2}</span>
                            </div>
                        </div>
                    </fieldset>


                    <fieldset>
                        <div class="col-md-12 form-group ">
                            <label class="col-md-2 form-label col-11p">비고</label>
                            <div class="col-md-10 col-89p">
                                <div class="input-group" style="margin-top:0px; width:100%;">
                                    <input type="text" class="form-control inputBox" id="remark" name="remark"
                                           value="${reqDetail.remark}"/>
                                    <c:if test="${reqDetail.reqstate eq '0'}">
                                        <div class="input-group-btn">
                                            <button class="btn btn-primary" onclick="javascript:fnSaveRemark();"
                                                    style="padding-top:4px; padding-bottom:4px; margin-top:1px;">
                                                <i class="fa fa-save"></i> 비고 저장
                                            </button>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <div class="col-md-12 form-group ">
                            <label class="col-md-2 form-label col-11p"><font color="blue">시험자 부탁의견</font></label>
                            <div class="col-md-10 col-89p">
                                <span class="txt-sub-content"><font color="blue">${reqDetail.itemdesc}</font></span>
                            </div>
                        </div>
                    </fieldset>
                    <%--        <fieldset>
                              <div class="col-md-12 form-group ">
                                <label class="col-md-2 form-label col-11p">첨부파일</label>
                                <div class="col-md-10 col-89p">
                                    <span class="txt-sub-content">
                                        <c:forEach var="reqAttachList" items="${reqAttachList}" varStatus="count">
                                          <a href="javascript:fnAttachDown('${reqAttachList.filepath}','${reqAttachList.orgname}')");">${reqAttachList.orgname}</a>
                                          <c:if test="${!count.last}">, </c:if>
                                        </c:forEach>
                                    </span>
                                </div>
                              </div>
                            </fieldset>--%>

                    <!--  end of  form-horizontal tems_search  -->
                    <!--  end of jarviswidget -->
                </div>
            </div>

            <!-- end of widget-body -->
        </div>
        <!--  end of content -->
    </div>


    <div role="content" class="clear-both sub-content">
        <div class="form-horizontal form-terms ui-sortable">
            <div class="jarviswidget jarviswidget-sortable" role="widget">

                <!-- header -->
                <header role="heading">
                    <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                    <h2>첨부파일</h2>
                </header>

                <!-- body -->
                <div class="widget-body">
                    <c:forEach var="reqAttachList" items="${reqAttachList}" varStatus="count">

                        <fieldset>
                            <div class="col-md-3 form-group ">
                                <label class="col-md-4 form-label">첨부파일</label>
                                <div class="col-md-8">
                                    <a href="javascript:fnAttachDown('${reqAttachList.filepath}','${reqAttachList.orgname}');">${reqAttachList.orgname}</a>
                                </div>
                            </div>
                        </fieldset>

                    </c:forEach>
                    <c:if test="${reqAttachList.size() == 0}">

                        <fieldset>
                            <div class="col-md-3 form-group ">
                                <label class="col-md-4 form-label">첨부파일</label>
                                <div class="col-md-8">
                                    <span class="txt-sub-content">등록 된 파일이 없습니다.</span>
                                </div>
                            </div>
                        </fieldset>

                    </c:if>
                </div>
            </div>
        </div>
    </div>


    <!--  신청 항목 창  -->
    <div role="content">
        <div class="dt-toolbar">
            <div class="col-sm-6">
                <div class="col col-md-12" style="height: 100%">

                    <div class="" style="
					    float: left;
					    margin-bottom: 3px;
					    padding-bottom: 6px;
					    padding-top: 6px;
					    padding-right: 12px;
					    padding-left: 12px;
					    border-top: 1px solid #C1C1C1;
					    border-left: 4px solid #C1C1C1;
					    border-bottom: 1px solid #C1C1C1;
					    background: #ECECEC;
					">
                        시료 / 제품
                    </div>
                    <div style="float:left; width:60%;">
                        <select class="form-control" style="height:33px;width: 100%;" id="cmbsmpid" name="cmbsmpid"
                                onchange="javascript:fnGetReqResultList();">
                            <c:forEach var="reqSmpList" items="${reqSmpList}">
                                <option value="${reqSmpList.smpid}">${reqSmpList.smpname} / ${reqSmpList.mname}<c:if
                                        test="${reqSmpList.adminnm ne null}">(${reqSmpList.officenm}/${reqSmpList.adminnm})</c:if></option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="" style="
					    float: left;
					    margin-bottom: 3px;
					    padding-bottom: 6px;
					    padding-top: 6px;
					    padding-right: 6px;
					    padding-left: 6px;
					    border-top: 1px solid #C1C1C1;
					    border-left: 1px solid #C1C1C1;
					    border-bottom: 1px solid #C1C1C1;
					    border-right: 1px solid #C1C1C1;
					    background: #ECECEC;
					">
                        총시료개수 : ${reqDetail.smpcnt}
                    </div>
                </div>
            </div>


            <div class="col-sm-6 text-right">
                <c:if test="${reqDetail.reqstate eq '0'}">
                    <button class="btn btn-primary" onclick="javascript:fnSaveResult();">
                        <i class="fa fa-save"></i> 저장
                    </button>
                    <button class="btn btn-default" onclick="javascript:fnResultAdd();">
                        <i class="fa fa-plus"></i> 항목추가
                    </button>
                    <button class="btn btn-default" onclick="javascript:fnResultDelete();">
                        <i class="fa fa-minus"></i> 항목삭제
                    </button>
                    <button class="btn btn-default" onclick="javascript:fnResultUpdateAll();">
                        <i class="fa fa-copy "></i> 동일항목 속성복사
                    </button>
                    <button class="btn btn-success" onclick="javascript:fnResultDeleteAll();">
                        <i class="fa fa-minus"></i> 일괄삭제
                    </button>
                    <button class="btn btn-success" onclick="javascript:fnResultAddAll();">
                        <i class="fa fa-plus"></i> 일괄추가
                    </button>
                </c:if>
            </div>

        </div>

        <div class="div-realgrid">
            <div id="realgrid" style="width: 100%; height: 450px;"></div>
        </div>

        <!-- end of realgrid Content -->
    </div>


    <br>


    <!-- 수수료 --------------------------------------------------------------------------------------- -->
    <!-- start of content -->
    <div role="content" class="clear-both sub-content">


        <div class="dt-toolbar">
            <div class="col-sm-5">
                <div class="col col-md-12" style="height: 100%;padding-left:2px;">
                    <div style="flaot:left; padding-top:5px;font-size:13;">
                        <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                        수수료
                    </div>
                </div>
            </div>


            <div class="col-sm-7 text-right">
                <c:if test="${reqDetail.reqstate eq '0'}">
                    <button class="btn btn-primary" onclick="javascript:fnPriceSave();">
                        <i class="fa fa-save"></i> 수수료 저장
                    </button>
                </c:if>
                <button class="btn btn-default" onclick="javascript:void(0);">
                    <i class="fa fa-search"></i> 견적서 보기
                </button>
            </div>

        </div>


        <!--  start of  form-horizontal tems_search  -->
        <!--  start of widget-body -->
        <div class="form-terms ui-sortable">
            <div class="jarviswidget jarviswidget-sortable" role="widget">
                <!-- body -->
                <div class="form-vertical widget-body">


                    <fieldset>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">항목수수료</label>
                            <div class="col-md-12">
                                <span class="txt-sub-content text-right" id="sumitemprice">0</span>
                            </div>
                        </div>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">회원할인률</label>
                            <div class="col-md-12">
                                <span class="txt-sub-content text-right" id="sumdiscount">0%</span>
                            </div>
                        </div>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">기타수수료</label>
                            <div class="col-md-12">
                                <input type="text" class="form-control inputBox" style="text-align: right;"
                                       id="sumetcprice"/>
                            </div>
                        </div>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">기본료</label>
                            <div class="col-md-12">
                                <span class="txt-sub-content text-right" id="sumbasicprice">0</span>
                            </div>
                        </div>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">부본료</label>
                            <div class="col-md-12">
                                <span class="txt-sub-content" id="sumcopyprice">0</span>
                            </div>
                        </div>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">조정금액</label>
                            <div class="col-md-12">
                                <input type="text" class="form-control inputBox" style="text-align: right;"
                                       id="sumaddprice"/>
                            </div>
                        </div>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">VAT별도</label>
                            <div class="col-md-12">
                                <span class="txt-sub-content text-right" id="sumnotvat">0</span>
                            </div>
                        </div>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">부가세</label>
                            <div class="col-md-12">
                                <span class="txt-sub-content text-right" id="sumvat">0</span>
                            </div>
                        </div>
                        <div class="col-11p form-group">
                            <label class="col-md-12 form-label">총금액</label>
                            <div class="col-md-12">
                                <span class="txt-sub-content text-right" id="sumtotalprice">0</span>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <div class="col-md-12 form-group ">
                            <label class="col-11p form-label ">수수료비고</label>
                            <div class="col-89p dash-left">
                                <input type="text" class="form-control inputBox" id="pricedesc" name="pricedesc"/>
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
    <!-- 수수료 끝. ----------------------------------------------------------------- -->


    <!-- 시료도착 --------------------------------------------------------------------------------------- -->
    <!-- start of content -->
    <c:if test="${reqDetail.reqstate eq '0'}">
    <div role="content" class="clear-both sub-content">

        <div class="dt-toolbar">
            <div class="col-sm-5">
                <div class="col col-md-12" style="height: 100%;padding-left:2px;">
                    <div style="flaot:left; padding-top:5px;font-size:13;">
                        <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                        시료도착
                    </div>
                </div>
            </div>

            <div class="col-sm-7 text-right">

                <button class="btn btn-primary" onclick="javascript:void(0);" style="float:right">
                    <i class="fa fa-save"></i> 도착정보 저장
                </button>

                <div class="dd3-content" style="float:right">
                    <div class="pull-right">
                        <div class="checkbox no-margin">
                            <label>
                                <input type="checkbox" class="checkbox style-0" checked="checked">
                                <span class="font-xs"> 시료도착여부</span>
                            </label>
                        </div>
                    </div>
                </div>

            </div>
            <!-- end of dt-toolbar -->
        </div>


        <!--  start of  form-horizontal tems_search  -->
        <!--  start of widget-body -->
        <div class="form-terms ui-sortable">
            <div class="jarviswidget jarviswidget-sortable" role="widget">
                <!-- body -->
                <div class="form-vertical widget-body">

                    <fieldset>
                        <div class="col-md-12 form-group ">
                            <div class="" style="float:left;">
                                <div class="row-merge">
                                    <label class="col col-md-12 form-label ">시료도착내역</label>
                                </div>
                            </div>
                            <div class="dash-left" style="padding-left:153px;">
                                    <textarea rows="6" class="textAreaBox"
                                              style="width:98%;margin:0px;height:50px;"></textarea>
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
    <!-- 시료도착 끝. ----------------------------------------------------------------- -->










    <!----------------------------------------------------- E-mail 견적서-------------------------------------------------------------------->
    <div class="col col-md-12 no-padding" style="margin-bottom:13px !important;">
        <div class="col col-md-6 no-padding">
            <div role="content" class="clear-both sub-content">

                <div class="dt-toolbar" style="border-bottom:1px solid #CCC !important; padding-bottom: 6px;">
                    <div class="col-sm-12">
                        <div class="col col-md-12" style="height: 100%;padding-left:2px;">
                            <div style="float:left; padding-top:5px;font-size:13;">
                                <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                                신청정보 검토 E-mail
                            </div>
                            <div style="float: right">
                                <button class="btn btn-primary">이메일 전송</button>
                            </div>
                        </div>
                        <div class="col col-md-12" style="height: 100%;padding-left:2px;">
                            <div style="padding-top:5px;font-size:13;">
                                <textarea style="width: 100%;"></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- end of dt-toolbar -->
                </div>

                <!--  start of  form-horizontal tems_search  -->
                <!--  start of widget-body -->
                <div class="form-terms ui-sortable" style="display:none;" id="">
                    <div class="jarviswidget jarviswidget-sortable" role="widget">
                        <!-- body -->
                        <div class="form-vertical widget-body">
                            <fieldset>
                                <div class="col-md-12 form-group ">
                                    <div class="" style="padding-left:13px;">
                                        <textarea rows="6" class="textAreaBox"
                                                  style="width:98%;margin:0px;height:80px;">접수 완료 ..</textarea>
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
            <!-- 끝. ----------------------------------------------------------------- -->

        </div>

        <div class="col col-md-6 no-padding" style="padding-left:13px !important;">
            <div role="content" class="clear-both sub-content">

                <div class="dt-toolbar" style="border-bottom:1px solid #CCC !important; padding-bottom: 6px;">
                    <div class="col-sm-12">
                        <div class="col col-md-12" style="height: 100%;padding-left:2px;">
                            <div style = "float:left; padding-top:5px;font-size:13;">
                                <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                                신청정보 검토 SMS
                            </div>
                            <div style = "float:right">
                                <button class="btn btn-primary" >메시지 전송</button>
                            </div>
                        </div>
                        <div class="col col-md-12" style="height: 100%;padding-left:2px;">
                            <div style="flaot:left; padding-top:5px;font-size:13;">
                                <textarea style="width: 100%;"></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- end of dt-toolbar -->
                </div>


                <!--  start of  form-horizontal tems_search  -->
                <!--  start of widget-body -->
                <div class="form-terms ui-sortable" id="" style="display:none;">
                    <div class="jarviswidget jarviswidget-sortable" role="widget">
                        <!-- body -->
                        <div class="form-vertical widget-body">

                            <fieldset>
                                <div class="col-md-12 form-group ">
                                    <div class="" style="padding-left:13px;">
                                            <textarea rows="6" class="textAreaBox"
                                                      style="width:98%;margin:0px;height:80px;">접수완료 되었습니다. </textarea>
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
        </div>

    </div>
    <!----------------------------------------------------- E-mail 견적서 끝-------------------------------------------------------------------->




















    <!-- 이메일 발송 및 SMS 발송 --------------------------------------------------------------------------------------- -->
    <!-- start of content -->
    <!-- E-Mail(견적서 포함) -->
    <div class="col col-md-12 no-padding" style="margin-bottom:13px !important;">
        <div class="col col-md-6 no-padding">
            <div role="content" class="clear-both sub-content">

                <div class="dt-toolbar" style="border-bottom:1px solid #CCC !important; padding-bottom: 6px;">
                    <div class="col-sm-5">
                        <div class="col col-md-12" style="height: 100%;padding-left:2px;">
                            <div style="flaot:left; padding-top:5px;font-size:13;">
                                <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                                E-Mail (견적서 포함)
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-7 text-right">

                        <button class="btn bg-color-blueLight txt-color-white btn-xs"
                                onclick="javascript:showDiv('email');" style="float:right">
                            <i class="fa fa-rss"></i> 메시지보기
                        </button>

                        <div class="dd2-content" style="float:right">
                            <div class="pull-right">
                                <div class="checkbox no-margin">
                                    <label>
                                        <input type="checkbox" class="checkbox style-0" checked="checked">
                                        <span class="font-xs"> E-Mail발송여부</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end of dt-toolbar -->
                </div>

                <!--  start of  form-horizontal tems_search  -->
                <!--  start of widget-body -->
                <div class="form-terms ui-sortable" style="display:none;" id="div_email">
                    <div class="jarviswidget jarviswidget-sortable" role="widget">
                        <!-- body -->
                        <div class="form-vertical widget-body">
                            <fieldset>
                                <div class="col-md-12 form-group ">
                                    <div class="" style="padding-left:13px;">
                                        <textarea rows="6" class="textAreaBox"
                                                  style="width:98%;margin:0px;height:80px;">접수 완료 ..</textarea>
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
            <!-- 끝. ----------------------------------------------------------------- -->

        </div>
        <div class="col col-md-6 no-padding" style="padding-left:13px !important;">
            <div role="content" class="clear-both sub-content">

                <div class="dt-toolbar" style="border-bottom:1px solid #CCC !important; padding-bottom: 6px;">
                    <div class="col-sm-5">
                        <div class="col col-md-12" style="height: 100%;padding-left:2px;">
                            <div style="flaot:left; padding-top:5px;font-size:13;">
                                <span class="widget-icon"> <i class="fa fa-th-large"></i> </span>
                                SMS 발송 (접수완료)
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-7 text-right">

                        <button class="btn bg-color-blueLight txt-color-white btn-xs"
                                onclick="javascript:showDiv('sms');" style="float:right">
                            <i class="fa fa-rss"></i> 메시지보기
                        </button>

                        <div class="dd2-content" style="float:right">
                            <div class="pull-right">
                                <div class="checkbox no-margin">
                                    <label>
                                        <input type="checkbox" class="checkbox style-0" checked="checked">
                                        <span class="font-xs"> SMS 발송여부</span>
                                    </label>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- end of dt-toolbar -->
                </div>


                <!--  start of  form-horizontal tems_search  -->
                <!--  start of widget-body -->
                <div class="form-terms ui-sortable" id="div_sms" style="display:none;">
                    <div class="jarviswidget jarviswidget-sortable" role="widget">
                        <!-- body -->
                        <div class="form-vertical widget-body">

                            <fieldset>
                                <div class="col-md-12 form-group ">
                                    <div class="" style="padding-left:13px;">
                                            <textarea rows="6" class="textAreaBox"
                                                      style="width:98%;margin:0px;height:80px;">접수완료 되었습니다. </textarea>
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
        </div>

    </div>


    <!-- bottom button area -->
    <!-- 접수완료 접수대시상태에서 만 표시 됨. -->
    <div role="content" style="clear:both;">
        <div class="dt-toolbar border-bottom-solid">
            <div class="col-sm-6">
                <div class="txt-guide">
                </div>
            </div>


            <div class="col-sm-6 text-right">
                <button class="btn btn-default" onclick="javascript:fnGoList();"
                        style="float:right; margin-left:13px;">
                    <i class="fa fa-th-list"></i> 목록
                </button>


                <div class="input-group col-sm-8" style="float:right;">
                    <!--
                    <select class="form-control" style="height: 32px;width: 240px;float:right;">
                        <option>승인지사</option>
                        <option>승인지사</option>
                        <option>승인지사</option>
                    </select>
                     -->
                    <div class="input-group-btn">
                        <button class="btn btn-primary" onclick="javascript:fnSaveReq();">
                            <i class="fa fa-save"></i> 접수완료
                        </button>
                    </div>
                </div>
            </div>
            <!-- end of div dt-toolbar content -->
        </div>
    </div>

    </c:if>
    <c:if test="${reqDetail.reqstate eq '2'}">

    <!-- bottom button area -->
    <!-- 분석승인요청 접수완료 상태에서 만 표시 됨. -->
    <div role="content" style="clear:both;">
        <div class="dt-toolbar border-bottom-solid">
            <div class="col-sm-6">
                <div class="txt-guide">
                </div>
            </div>


            <div class="col-sm-6 text-right">
                <button class="btn btn-default" onclick="javascript:fnGoList();"
                        style="float:right; margin-left:13px;">
                    <i class="fa fa-th-list"></i> 목록
                </button>

                <c:if test="${reqDetail.reqstate eq '2' and (reqDetail.signappr eq null or reqDetail.signappr eq 'R' or reqDetail.signappr eq '-')}">
                    <div class="">
                        <button class="btn btn-primary" onclick="javascript:fnConfirm();">
                            <i class="fa fa-pencil"></i> 의뢰승인요청
                        </button>
                    </div>
                </c:if>


            </div>

            <!-- end of div dt-toolbar content -->
        </div>
    </div>

    </c:if>

    <!-- end of /section:basics/content.breadcrumbs -->
</div>

<!-- 항목추가 모달창------------------------------------------------------------------ -->
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
                                        <div class="col-md-12 form-group">
                                            <label class="col-md-2 form-label"><b>항목명 조회</b></label>

                                            <div class="col-md-10">

                                                <div class="col-sm-3 form-button">
                                                    <input id="itemnm" type="text" class="form-control inputBox">
                                                </div>
                                                <div class="col-sm-8">
                                                    <font color="blue">
                                                        (조회시 최상위 항목의 이름으로 검색하여 주시기 바랍니다.)
                                                    </font>
                                                </div>
                                                <div class="col-sm-1 form-button">
                                                    <button class="btn btn-default btn-primary" type="button"
                                                            id="search3" onclick="javascript:fnGetItemList()">
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
                        <button id="modalAdd" class="btn btn-primary" onclick="javascript:fnAddItem()">추가</button>
                    </div>

                    <div class="div-realgrid">
                        <div id="realgrid2" style="width: 100%; height: 500px;"></div>
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
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>

    </div>
</div>

<!-- 담당자추가 모달창------------------------------------------------------------------ -->
<div class="modal fade" id="UserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                <h4 class="modal-title" id="myModalLabel">담당자변경</h4>
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
                                        <div class="col-md-12 form-group">
                                            <div class="col-md-6">
                                                <div class="div-realgrid">
                                                    <h4 class="modal-title" id="myModalLabel">부서</h4>
                                                    <div id="realgrid3" style="width: 100%; height: 500px;"></div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="div-realgrid">
                                                    <h4 class="modal-title" id="myModalLabel">사용자선택(이름을 더블클릭 해주세요)</h4>
                                                    <div id="realgrid4" style="width: 100%; height: 235px;"></div>
                                                </div>
                                                <div class="div-realgrid">
                                                    <h4 class="modal-title" id="myModalLabel">선택된사용자</h4>
                                                    <div id="realgrid5" style="width: 100%; height: 240px;"></div>
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
                <button type="button" class="btn btn-primary" onclick="fnUserAdd()">적용</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/include/approval/approvalPop.jsp"></jsp:include>
