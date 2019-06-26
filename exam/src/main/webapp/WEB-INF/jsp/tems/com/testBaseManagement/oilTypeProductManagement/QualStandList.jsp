<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.* " %>
<%@ page import="java.text.* " %>
<%@ page import="java.io.* " %>
<%@ page import="tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualStandCrossListVO" %>
<%
    HashMap _leftMap = (HashMap) request.getAttribute("leftMap");
    HashMap _crossField = (HashMap) request.getAttribute("crossField");

    StringBuffer sb001_1 = new StringBuffer();
    StringBuffer sb001_3 = new StringBuffer();
    int fieldcnt = 0;

    Iterator<String> keys = _crossField.keySet().iterator();
    while (keys.hasNext()) {
        String key = keys.next();
        if (key != null) {
            sb001_1.append(",{ name: '" + key + "', fieldName: '" + key + "',  header: {text:'" + _crossField.get(key) + "'}, width: 85}");
            sb001_3.append(",{ fieldName: '" + key + "'}");
            fieldcnt++;
        }
    }
    Iterator<String> keyLeft = _leftMap.keySet().iterator();

%>
<script>
    var gridView;
    var dataProvider;

    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("<c:url value='/script'/>");

        dataProvider = new RealGridJS.LocalDataProvider();
        gridView = new RealGridJS.GridView("realgrid");
        gridView.setDataSource(dataProvider);

        setOption();

        var fields = [
            {fieldName: "mtitemid"}
            , {fieldName: "name"}
            , {fieldName: "unitid"}
            , {fieldName: "displaytype"}
            , {fieldName: "methodname"}
            <%=sb001_3.toString()%>
        ];

        dataProvider.setFields(fields);

        var columns = [
            {
                name: "name",
                fieldName: "name",
                header: {text: "항목명"},
                width: 150,
                readOnly: "true"
            }
            , {
                name: "unitid",
                fieldName: "unitid",
                header: {text: "단위"},
                width: 150,
                readOnly: "true"
            }
            , {
                name: "displaytype",
                fieldName: "displaytype",
                header: {text: "결과표기"},
                width: 150,
                readOnly: "true"
            }
            , {
                name: "methodname",
                fieldName: "methodname",
                header: {text: "시험방법"},
                width: 150,
                readOnly: "true"
            }
            <%=sb001_1.toString()%>
        ];

        gridView.setColumns(columns);

        setData();
    });


    function setOption() {
        /* 그리드 row추가 옵션사용여부 */
        gridView.setOptions({
            panel: {visible: false},
            footer: {visible: false},
            checkBar: {visible: false},
            display: {
                fitStyle: "evenFill"
            }
        });
    }

    function setData() {


        var data = [
            <%
               int j = 1;
               while(keyLeft.hasNext()){
                   QualStandCrossListVO _en = (QualStandCrossListVO)_leftMap.get(keyLeft.next() );
                   //  HashMap  lstMap= (HashMap)dataList.get(j);
               %>

            <%if(j == 1){%>
            [
                "<%=(String)_en.getMtitemid()!=null?_en.getMtitemid():""%>",
                "<%=(String)_en.getName()!=null?_en.getName():""%>",
                "<%=(String)_en.getUnitid()!=null?_en.getUnitid():""%>",
                "<%=(String)_en.getDisplaytype()!=null?_en.getDisplaytype():""%>",
                "<%=(String)_en.getMethodname()!=null?_en.getMethodname():""%>"
                <%for (Iterator<String> iterator = _crossField.keySet().iterator(); iterator.hasNext();) {
                    String key = iterator.next();  %>
                , "<%=_en.crossTap.get(key)!=null?_en.crossTap.get(key):""%>"
                <%}
                    j++;%>
            ]
            <%
        } else { %>
            , [
                "<%=(String)_en.getMtitemid()!=null?_en.getMtitemid():""%>",
                "<%=(String)_en.getName()!=null?_en.getName():""%>",
                "<%=(String)_en.getUnitid()!=null?_en.getUnitid():""%>",
                "<%=(String)_en.getDisplaytype()!=null?_en.getDisplaytype():""%>",
                "<%=(String)_en.getMethodname()!=null?_en.getMethodname():""%>"
                <%for (Iterator<String> iterator = _crossField.keySet().iterator(); iterator.hasNext();) {
                    String key = iterator.next();  %>
                , "<%=_en.crossTap.get(key)!=null?_en.crossTap.get(key):""%>"
                <%}
                    j++;%>
            ]
            <%
        }
    }
    %>
        ]
        dataProvider.setRows(data);
        gridView.setFocus();
    }
    ;


</script>

<!-- /section:basics/content.breadcrumbs -->
<!-- 여기서 부터 내용 작성 -->
<input type="hidden" name="fieldcnt" id="fieldcnt" value="<%=fieldcnt%>"/>

<div id="realgrid" style="width: 100%; height: 500px;"></div>
<!-- 작성완료 -->
