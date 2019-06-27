<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%
    /**
     * @Class Name : EgovMenuCreat.jsp
     * @Description : 메뉴생성 화면
     * @Modification Information
     * @
     * @  수정일         수정자                   수정내용
     * @ -------    --------    ---------------------------
     * @ 2009.03.10    이용          최초 생성
     *
     *  @author 공통서비스 개발팀 이용
     *  @since 2009.03.10
     *  @version 1.0
     *  @see
     *
     */

  /* Image Path 설정 */
//  String imagePath_icon   = "/images/egovframework/com/sym/mnu/mcm/icon/";
//  String imagePath_button = "/images/egovframework/com/sym/mnu/mcm/button/";
%>

<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/button.css' />" type="text/css">
    <title>메뉴생성</title>
    <style type="text/css">
        h1 {
            font-size: 12px;
        }

        caption {
            visibility: hidden;
            font-size: 0;
            height: 0;
            margin: 0;
            padding: 0;
            line-height: 0;
        }
    </style>
    <script type="text/javascript">
        var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>";
    </script>
    <script language="javascript1.2" type="text/javaScript"
            src="<c:url value='/js/egovframework/com/sym/mnu/mcm/EgovMenuCreat.js' />"></script>
    <script language="javascript1.2" type="text/javaScript">
        <!--
            /* ********************************************************
             * 조회 함수
             ******************************************************** */
                function selectMenuCreatTmp() {
                    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
                    document.menuCreatManageForm.submit();
                }

        /* ********************************************************
         * 멀티입력 처리 함수
         ******************************************************** */
        function fInsertMenuCreat() {
            var checkField = document.menuCreatManageForm.checkField;
            /*var checkField = $("#menuCreatManageForm").getElementsByName("checkField");*/
            var checkMenuNos = "";
            var checkedCount = 0;
            if (checkField) {
                if (checkField.length > 1) {
                    for (var i = 0; i < checkField.length; i++) {
                        if (checkField[i].checked) {
                            checkMenuNos += ((checkedCount == 0 ? "" : ",") + checkField[i].value);
                            checkedCount++;
                        }
                    }
                } else {
                    if (checkField.checked) {
                        checkMenuNos = checkField.value;
                    }
                }
            }
            if (checkedCount == 0) {
                alert("선택된 메뉴가 없습니다.");
                return false;
            }
            document.menuCreatManageForm.checkedMenuNoForInsert.value = checkMenuNos;
            document.menuCreatManageForm.checkedAuthorForInsert.value = document.menuCreatManageForm.authorCode.value;
            document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatInsert.do'/>";
            document.menuCreatManageForm.submit();
        }
        /* ********************************************************
         * 메뉴사이트맵 생성 화면 호출
         ******************************************************** */
        function fMenuCreatSiteMap() {
            id = document.menuCreatManageForm.authorCode.value;
            window.open("<c:url value='/sym/mnu/mcm/EgovMenuCreatSiteMapSelect.do'/>?authorCode=" + id, 'Pop_SiteMap', 'scrollbars=yes, width=550, height=700');
        }
        <c:if test="${!empty resultMsg}">alert("${resultMsg}");
        </c:if>
-->
    </script>

</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>



<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable">

    <form name="menuCreatManageForm" action="<c:url value='/sym/mnu/mcm/EgovMenuCreatSiteMapSelect.do' />"
          method="post">
        <input name="checkedMenuNoForInsert" type="hidden">
        <input name="checkedAuthorForInsert" type="hidden">

        <!-- Widget ID (each widget will need unique ID)-->
        <div class="jarviswidget jarviswidget-color-darken jarviswidget-sortable" id="wid-id-0"
             data-widget-editbutton="false" role="widget">
            <!-- widget options:
            usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

            data-widget-colorbutton="false"
            data-widget-editbutton="false"
            data-widget-togglebutton="false"
            data-widget-deletebutton="false"
            data-widget-fullscreenbutton="false"
            data-widget-custombutton="false"
            data-widget-collapsed="true"
            data-widget-sortable="false"

            -->
            <header role="heading">

                <span class="widget-icon"> <i class="fa fa-table"></i> </span>

                <h2> 메뉴생성 </h2>
                <span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span></header>
            <!-- widget div-->
            <div role="content">
                <!-- widget edit box -->
                <div class="jarviswidget-editbox">
                    <!-- This area used as dropdown edit box -->
                </div>
                <!-- end widget edit box -->
                <!-- widget content -->
                <div class="widget-body no-padding">
                    <div id="dt_basic_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <div class="dt-toolbar" style="border-bottom: 1px solid #CCC !important">
                            <div class="col-xs-12 col-sm-6">
                                <div id="dt_basic_filter" class="dataTables_filter">
                                    <label>
                                        <span class="input-group-addon" style="width: 150px; text-align: right">권한코드<i
                                                class="glyphicon glyphicon-search"></i>
                                        </span>
                                        <input class="form-control" name="authorCode" type="text" size="30"
                                               maxlength="30" title="권한코드"
                                               value="${resultVO.authorCode}"/>


                                    </label>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6" style="text-align: right">
                                <button type="button" class="btn btn-primary"
                                        onclick="fInsertMenuCreat(); return false;">메뉴생성
                                </button>
                            </div>

                        </div>


                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>

                        <div id="main">
                            <c:forEach var="result1" items="${list_menulist}" varStatus="status">
                                <input type="hidden" name="tmp_menuNmVal"
                                       value="${result1.menuNo}|${result1.upperMenuId}|${result1.menuNm}|${result1.progrmFileNm}|${result1.chkYeoBu}|">
                            </c:forEach>


                            <!-- div class="tree" style="position:absolute; left:24px; top:70px; width:179px; height:25px; z-index:10;" -->
                            <div class="tree" style="width:900px;">
                                <script language="javascript" type="text/javaScript">

                                    var chk_Object = true;
                                    var chk_browse = "";
                                    if (eval(document.menuCreatManageForm.authorCode) == "[object]") chk_browse = "IE";
                                    if (eval(document.menuCreatManageForm.authorCode) == "[object NodeList]") chk_browse = "Fox";
                                    if (eval(document.menuCreatManageForm.authorCode) == "[object Collection]") chk_browse = "safai";

                                    var Tree = new Array;
                                    if (chk_browse == "IE" && eval(document.menuCreatManageForm.tmp_menuNmVal) != "[object]") {
                                        alert("메뉴 목록 데이타가 존재하지 않습니다.");
                                        chk_Object = false;
                                    }
                                    if (chk_browse == "Fox" && eval(document.menuCreatManageForm.tmp_menuNmVal) != "[object NodeList]") {
                                        alert("메뉴 목록 데이타가 존재하지 않습니다.");
                                        chk_Object = false;
                                    }
                                    if (chk_browse == "safai" && eval(document.menuCreatManageForm.tmp_menuNmVal) != "[object Collection]") {
                                        alert("메뉴 목록 데이타가 존재하지 않습니다.");
                                        chk_Object = false;
                                    }
                                    if (chk_Object) {
                                        for (var j = 0; j < document.menuCreatManageForm.tmp_menuNmVal.length; j++) {
                                            Tree[j] = document.menuCreatManageForm.tmp_menuNmVal[j].value;
                                        }
                                        createTree(Tree);
                                    } else {
                                        alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.");
                                        window.close();
                                    }
                                </script>
                            </div>
                        </div>
                        <input type="hidden" name="req_menuNo">
                    </div>
                </div>
            </div>
        </div>
    </form>
</article>
</body>
</html>

