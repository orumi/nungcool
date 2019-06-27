<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
    /**
     * @Class Name : EgovMenuCreatManage.jsp
     * @Description : 메뉴생성관리 조회 화면
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
    String imagePath_icon = "/images/egovframework/com/sym/mnu/mcm/icon/";
    String imagePath_button = "/images/egovframework/com/sym/mnu/mcm/button/";
%>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/button.css' />" type="text/css">
    <title>메뉴생성관리</title>
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

    <link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
    <script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>

    <script language="javascript1.2" type="text/javaScript">
        <!--
        /* ********************************************************
         * 최초조회 함수
         ******************************************************** */
        function fMenuCreatManageSelect() {
            document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
            document.menuCreatManageForm.submit();
        }

        /* ********************************************************
         * 페이징 처리 함수
         ******************************************************** */
        function linkPage(pageNo) {
            document.menuCreatManageForm.pageIndex.value = pageNo;
            document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
            document.menuCreatManageForm.submit();
        }

        /* ********************************************************
         * 조회 처리 함수
         ******************************************************** */
        function selectMenuCreatManageList() {
            document.menuCreatManageForm.pageIndex.value = 1;
            document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
            document.menuCreatManageForm.submit();
        }

        /* ********************************************************
         * 메뉴생성 화면 호출
         ******************************************************** */
        function selectMenuCreat(vAuthorCode) {
            document.menuCreatManageForm.authorCode.value = vAuthorCode;
            document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
            document.menuCreatManageForm.submit();
        }
        <c:if test="${!empty resultMsg}">alert("${resultMsg}");
        </c:if>
        -->
    </script>
</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>


<!--bootStrap-->
<form name="menuCreatManageForm" action="<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>"
      method="post">
    <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable">

        <input name="checkedMenuNoForDel" type="hidden"/>
        <input name="authorCode" type="hidden"/>
        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

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

                <h2> 권한별 메뉴 관리 </h2>
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
                                <div id="dt_basic_filter" class="dataTables_filter"><label><span
                                        class="input-group-addon" style="width: 150px; text-align: right">항목명 조회
                                    <i class="glyphicon glyphicon-search"></i></span>
                                    <input name="searchKeyword"
                                           type="search"
                                           class="form-control"
                                           placeholder=""
                                           aria-controls="dt_basic"
                                           style="width: 400px"></label>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12 hidden-xs">
                                <div class="dataTables_length" id="dt_basic_length">
                                    <input type="submit" value="조회" class="btn btn-default btn-default"
                                           onclick="selectMenuCreatManageList(); return false;"/>
                                </div>
                            </div>
                        </div>
                        <table id="dt_basic" class="table table-striped table-bordered table-hover dataTable no-footer"
                               width="80%" role="grid" aria-describedby="dt_basic_info" style="width: 100%;">
                            <thead>
                            <tr role="row">
                                <th data-hide="phone" tabindex="0" aria-controls="dt_basic"
                                    rowspan="1"
                                    colspan="1"
                                    style="width: 200px; text-align: center; background-color: #EEEEEE">권한코드
                                </th>
                                <th data-hide="phone" tabindex="0" aria-controls="dt_basic"
                                    rowspan="1"
                                    colspan="1"
                                    style="width: 200px; text-align: center; background-color: #EEEEEE">권한명
                                </th>
                                <th data-hide="phone" tabindex="0" aria-controls="dt_basic"
                                    rowspan="1"
                                    colspan="1"
                                    style="width: 200px; text-align: center; background-color: #EEEEEE">권한 설명
                                </th>
                                <th data-hide="phone" tabindex="0" aria-controls="dt_basic"
                                    rowspan="1"
                                    colspan="1"
                                    style="width: 200px; text-align: center; background-color: #EEEEEE">메뉴생성여부
                                </th>
                                <th data-hide="phone" tabindex="0" aria-controls="dt_basic"
                                    rowspan="1"
                                    colspan="1"
                                    style="width: 200px; text-align: center; background-color: #EEEEEE">메뉴생성
                                </th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach var="result" items="${list_menumanage}" varStatus="status">
                                <tr>
                                    <td class="lt_text3" style="cursor:hand;"><c:out
                                            value="${result.authorCode}"/></td>
                                    <td class="lt_text3" style="cursor:hand;"><c:out
                                            value="${result.authorNm}"/></td>
                                    <td class="lt_text3" style="cursor:hand;"><c:out
                                            value="${result.authorDc}"/></td>
                                    <td class="lt_text3" style="cursor:hand;">
                                        <c:if test="${result.chkYeoBu > 0}">Y</c:if>
                                        <c:if test="${result.chkYeoBu == 0}">N</c:if>
                                    </td>
                                    <td class="lt_text3">
                                        <span class="button"><a href="<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>?authorCode=<c:out value="${result.authorCode}"/>">메뉴생성</a></span>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="dt-toolbar-footer">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="10">
                                        <!-- 페이징 시작 -->
                                        <div align="center">
                                            <div>
                                                <ui:pagination paginationInfo="${paginationInfo}" type="image"
                                                               jsFunction="linkPage"/>
                                            </div>
                                        </div>
                                        <!-- 페이징 끝 -->
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end widget content -->
            </div>
            <!-- end widget div -->
        </div>
        <!-- end widget -->
    </article>
</form>



<!-- End of Boot Strap -->

</body>
</html>

