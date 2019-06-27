<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: owner1120
  Date: 2016-01-06
  Time: 오후 2:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title></title>
</head>
<script>

    function injection(responseText) {
        clearFrame();
        $("#iFrameGrid").html(responseText)
    }

    function clearFrame() {
        $("#iFrameGrid").html("")
    }

    function getRealGridObject() {
        return $("#realgrid")
    }

    function appendRow() {
        alert('appendRow');
        alert(gridView);
        gridView.beginInsertRow(0);
    }

    function getGridView() {
        return gridView;
    }

    function getDataProvider() {
        return dataProvider;
    }

    function save() {

        var fieldid = $("#fieldcnt").val();

        gridView.commit();

        var state;
        var jData;
        var jRowsData = [];

        var rows = dataProvider.getAllStateRows();

        if (rows.updated.length > 0) {
            for (var i = 0; i < rows.updated.length; i++) {

                for (var j = 0; j < fieldid; j++) {
                    jData = {
                        "mtitemid": gridView.getValue(rows.updated[i], 0),
                        "specid": dataProvider.getOrgFieldName(5 + j),
                        "spec": gridView.getValue(rows.updated[i], 5 + j)
                    }
                    jRowsData.push(jData);
                }
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
        if (confirm("변경된 내용을 저장하시겠습니까?")) {

            $.ajax({
                url: "<c:url value='/com/testBaseManageMent/oilTypeProductManagement/qualStandManagement/edtQualStand.json'/>",
                type: "post",
                data: data,
                dataType: "json",
                success: function (data) {
                    if (data.RESULT_YN == "Y") {
                        alert("정상 처리 되었습니다.");
                        dataProvider.clearRowStates(true, true);
                    } else {
                        alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "error:" + error);
                }
            });
        }
    }

</script>
<body>
<div id="iFrameGrid" style="width:100% height:100%">

</div>


</select>
</body>
</html>
