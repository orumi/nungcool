<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="ImgUrl" value="${pageContext.request.contextPath}/images/egovframework/com/sym/mnu/mpm/"/>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/button.css' />" type="text/css">
    <title>메뉴정보등록</title>
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
    <script type="text/javascript" src="<c:url value="/validator.do" />"></script>
    <script type="text/javascript">
        var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>";
    </script>
    <script language="javascript1.2" type="text/javaScript"
            src="<c:url value='/js/egovframework/com/sym/mnu/mpm/EgovMenuList.js' />"/>
    <validator:javascript formName="menuManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
    <script language="javascript1.2" type="text/javaScript">
        <!--
        /* ********************************************************
         * 메뉴이동 화면 호출 함수
         ******************************************************** */
        function mvmnMenuList() {
            /*window.open("
            <c:url value='/sym/mnu/mpm/EgovMenuListSelectMvmn.do' />", 'Pop_Mvmn', 'scrollbars=yes,width=600,height=600');*/
            $("#menuSelect").modal();

        }

        /* ********************************************************
         * 입력값 validator 함수
         ******************************************************** */
        function fn_validatorMenuList() {

            if (document.menuManageVO.menuNo.value == "") {
                alert("메뉴번호는 Not Null 항목입니다.");
                return false;
            }
            if (!checkNumber(document.menuManageVO.menuNo.value)) {
                alert("메뉴번호는 숫자만 입력 가능합니다.");
                return false;
            }
            if (document.menuManageVO.menuOrdr.value == "") {
                alert("메뉴순서는 Not Null 항목입니다.");
                return false;
            }
            if (!checkNumber(document.menuManageVO.menuOrdr.value)) {
                alert("메뉴순서는 숫자만 입력 가능합니다.");
                return false;
            }

            if (document.menuManageVO.upperMenuId.value == "") {
                alert("상위메뉴번호는 Not Null 항목입니다.");
                return false;
            }
            if (!checkNumber(document.menuManageVO.upperMenuId.value)) {
                alert("상위메뉴번호는 숫자만 입력 가능합니다.");
                return false;
            }

            if (document.menuManageVO.progrmFileNm.value == "") {
                alert("프로그램파일명은 Not Null 항목입니다.");
                return false;
            }
            if (document.menuManageVO.menuNm.value == "") {
                alert("메뉴명은 Not Null 항목입니다.");
                return false;
            }
            return true;
        }

        /* ********************************************************
         * 필드값 Number 체크 함수
         ******************************************************** */
        function checkNumber(str) {
            var flag = true;
            if (str.length > 0) {
                for (i = 0; i < str.length; i++) {
                    if (str.charAt(i) < '0' || str.charAt(i) > '9') {
                        flag = false;
                    }
                }
            }
            return flag;
        }

        /* ********************************************************
         * 입력처리 함수
         ******************************************************** */
        function insertMenuManage(form) {
            if (!fn_validatorMenuList()) {
                return;
            }
            if (confirm("<spring:message code="common.save.msg" />")) {

                if (!validateMenuManageVO(form)) {
                    return;
                } else {
                    form.submit();
                }
            }
        }

        /* ********************************************************
         * 파일목록조회  함수
         ******************************************************** */
        function searchFileNm() {

            $("#programFileName").modal();
            /*document.all.tmp_SearchElementName.value = "progrmFileNm";
             window.open("
            <c:url value='/sym/prm/EgovProgramListSearch.do' />", 'Pop_progrmFileNm', 'width=500,height=600');*/
        }

        function choisProgramListSearch(vFileNm) {
            //eval("opener.document.all."+opener.document.all.tmp_SearchElementName.value).value = vFileNm;
            //opener.document.menuManageVO.progrmFileNm.value = vFileNm;
            /*var parentFrom = document.getElementsByName('progrmFileNm');
             parentFrom[0].progrmFileNm.value = vFileNm;
             window.close();*/
            $("#progrmFileNm").val(vFileNm);
            $("#programFileName").modal("hide");
        }

        /* ********************************************************
         * 목록조회  함수
         ******************************************************** */
        function selectList() {
            location.href = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do' />";
        }
        /* ********************************************************
         * 파일명 엔터key 목록조회  함수
         ******************************************************** */
        function press() {
            if (event.keyCode == 13) {
                searchFileNm();    // 원래 검색 function 호출
            }
        }

        function choiceNodes(nodeNum) {
            var nodeValues = treeNodes[nodeNum].split("|");
            /*document.menuManageVO.menuNo.value = nodeValues[4];
             document.menuManageVO.menuOrdr.value = nodeValues[5];
             document.menuManageVO.menuNm.value = nodeValues[6];
             document.menuManageVO.upperMenuId.value = nodeValues[7];
             document.menuManageVO.menuDc.value = nodeValues[8];
             document.menuManageVO.relateImagePath.value = nodeValues[9];
             document.menuManageVO.relateImageNm.value = nodeValues[10];
             document.menuManageVO.progrmFileNm.value = nodeValues[11];
             document.menuManageVO.menuNo.readOnly = true;
             document.menuManageVO.tmp_CheckVal.value = "U";*/
            document.menuManageVO.upperMenuId.value = nodeValues[4];
            $("#menuSelect").modal("hide");
        }
        <c:if test="${!empty resultMsg}">alert("${resultMsg}");
        </c:if>
        -->
    </script>

</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<%--<div id="border" style="width:730px">
    <table border="0">
        <tr>
            <td width="700">
                <!-- ********** 여기서 부터 본문 내용 *************** -->

                <form:form commandName="menuManageVO" name="menuManageVO" method="post"
                           action="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMenuRegistInsert.do">

                    <table width="717" cellpadding="8" class="table-search" border="0">
                        <tr>
                            <td width="100%" class="title_left" style="border-right: 1px; border-left: 1px;">
                                <h1>메뉴 등록</h1>
                            </td>
                        </tr>
                    </table>
                    <table width="717" border="0" cellpadding="0" cellspacing="1" class="table-register"
                           summary="메뉴 등록화면">
                        <caption>메뉴 등록</caption>
                        <tr>
                            <th width="15%" height="23" class="required_text" scope="row"><label
                                    for="menuNo">메뉴No</label><img
                                    src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15"
                                    height="15" alt="필수입력표시"></th>
                            <td width="35%">
                                &nbsp;
                                <form:input path="menuNo" size="10" maxlength="10" title="메뉴No"/>
                                <form:errors path="menuNo"/>
                            </td>
                            <th width="15%" height="23" class="required_text" scope="row"><label
                                    for="menuOrdr">메뉴순서</label><img
                                    src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15"
                                    height="15" alt="필수입력표시"></th>
                            <td width="35%">
                                &nbsp;
                                <form:input path="menuOrdr" size="10" maxlength="10" title="메뉴순서"/>
                                <form:errors path="menuOrdr"/>
                            </td>
                        </tr>
                        <tr>
                            <th width="15%" height="23" class="required_text" scope="row"><label
                                    for="menuNm">메뉴명</label><img
                                    src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15"
                                    height="15" alt="필수입력표시"></th>
                            <td width="35%">
                                &nbsp;
                                <form:input path="menuNm" size="30" maxlength="30" title="메뉴명"/>
                                <form:errors path="menuNm"/>
                            </td>
                            <th width="15%" height="23" class="required_text" scope="row"><label for="upperMenuId">상위메뉴No</label><img
                                    src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15"
                                    height="15" alt="필수입력표시"></th>
                            <td width="35%">
                                &nbsp;
                                <form:input path="upperMenuId" size="10" maxlength="10" title="상위메뉴No" readonly="true"
                                            class="readOnlyClass"/>
                                <form:errors path="upperMenuId"/>
                                <a href="<c:url value='/sym/mnu/mpm/EgovMenuListSelectMvmn.do' />" target="_blank"
                                   title="새창으로" onClick="mvmnMenuList();return false;"
                                   style="selector-dummy:expression(this.hideFocus=false);"><img
                                        src="<c:url value='/images/egovframework/com/cmm/icon/search2.gif' />"
                                        alt='' width="15" height="15"/>(메뉴선택 검색)</a>
                            </td>
                        </tr>
                        <tr>
                            <th width="15%" height="23" class="required_text" scope="row"><label
                                    for="progrmFileNm">파일명</label><img
                                    src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15"
                                    height="15" alt="필수입력표시"></th>
                            <td width="85%" colspan="3">
                                &nbsp;
                                <form:input path="progrmFileNm" size="60" maxlength="60" onkeypress="press();"
                                            title="파일명" readonly="true" class="readOnlyClass"/>
                                <form:errors path="progrmFileNm"/>
                                <a href="<c:url value='/sym/prm/EgovProgramListSearch.do'/>?tmp_SearchElementName=progrmFileNm"
                                   target="_blank" title="새창으로" onclick="javascript:searchFileNm(); return false;"
                                   style="selector-dummy:expression(this.hideFocus=false);">
                                    <img src="<c:url value='/images/egovframework/com/cmm/icon/search2.gif' />" alt=''
                                         width="15" height="15"/>(프로그램파일명 검색)</a>
                            </td>
                        </tr>
                        <tr>
                            <th width="15%" height="23" class="required_text" scope="row"><label for="relateImageNm">관련이미지명</label>
                            </th>
                            <td width="35%">
                                &nbsp;
                                <form:input path="relateImageNm" size="30" maxlength="30" title="관련이미지명"/>
                                <form:errors path="relateImageNm"/>
                            </td>
                            <th width="15%" height="23" class="required_text" scope="row"><label for="relateImagePath">관련이미지경로</label>
                            </th>
                            <td width="35%">
                                &nbsp;
                                <form:input path="relateImagePath" size="30" maxlength="30" title="관련이미지경로"/>
                                <form:errors path="relateImagePath"/>
                            </td>
                        </tr>
                        <tr>
                            <th width="15%" height="23" class="required_text" scope="row"><label
                                    for="menuDc">메뉴설명</label></th>
                            <td colspan="3">&nbsp;
                                <form:textarea path="menuDc" rows="14" cols="75" cssClass="txaClass" title="메뉴설명"/>
                                <form:errors path="menuDc"/>
                            </td>
                        </tr>
                    </table>
                    <table width="717" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="10"></td>
                        </tr>
                    </table>

                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="90%"></td>
                            <td><span class="button"><a href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>"
                                                        onclick="javascript:selectList(); return false;">목록</a></span>
                            </td>
                            <td width="2%"></td>
                            <td><span class="button"><input type="submit"
                                                            value="<spring:message code="button.create" />"
                                                            onclick="insertMenuManage(document.forms[0]); return false;"/></span>
                            </td>
                        </tr>
                    </table>

                    <input type="hidden" name="tmp_SearchElementName" value="">
                    <input type="hidden" name="tmp_SearchElementVal" value="">
                    <input name="cmd" type="hidden" value="<c:out value='insert'/>">
                </form:form>
                <!-- ********** 여기까지 내용 *************** -->
            </td>
        </tr>
    </table>
</div>--%>


<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable">

    <form:form commandName="menuManageVO" name="menuManageVO" method="post"
               action="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMenuRegistInsert.do">
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

                <h2> 프로그램목록관리 </h2>
                <span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
            </header>
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


                        <table id="dt_basic"
                               class="table table-striped table-bordered table-hover dataTable no-footer"
                               width="80%" role="grid" aria-describedby="dt_basic_info"
                               style="width: 100%; padding-top: 0px;">
                            <caption>메뉴 등록</caption>
                            <tr>
                                <th style="background-color: #EEEEEE" width="15%" height="23" class="required_text"
                                    scope="row"><label
                                        for="menuNo">메뉴No</label><img
                                        src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />"
                                        width="15"
                                        height="15" alt="필수입력표시"></th>
                                <td width="35%">
                                    &nbsp;
                                    <form:input path="menuNo" size="10" maxlength="10" title="메뉴No"/>
                                    <form:errors path="menuNo"/>
                                </td>
                                <th style="background-color: #EEEEEE" width="15%" height="23" class="required_text"
                                    scope="row"><label
                                        for="menuOrdr">메뉴순서</label><img
                                        src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />"
                                        width="15"
                                        height="15" alt="필수입력표시"></th>
                                <td width="35%">
                                    &nbsp;
                                    <form:input path="menuOrdr" size="10" maxlength="10" title="메뉴순서"/>
                                    <form:errors path="menuOrdr"/>
                                </td>
                            </tr>
                            <tr>
                                <th style="background-color: #EEEEEE" width="15%" height="23" class="required_text"
                                    scope="row"><label
                                        for="menuNm">메뉴명</label><img
                                        src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />"
                                        width="15"
                                        height="15" alt="필수입력표시"></th>
                                <td width="35%">
                                    &nbsp;
                                    <form:input path="menuNm" size="30" maxlength="30" title="메뉴명"/>
                                    <form:errors path="menuNm"/>
                                </td>
                                <th style="background-color: #EEEEEE" width="15%" height="23" class="required_text"
                                    scope="row"><label
                                        for="upperMenuId">상위메뉴No</label><img
                                        src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />"
                                        width="15"
                                        height="15" alt="필수입력표시"></th>
                                <td width="35%">
                                    &nbsp;
                                    <form:input path="upperMenuId" size="10" maxlength="10" title="상위메뉴No"
                                                readonly="true"
                                                class="readOnlyClass"/>
                                    <form:errors path="upperMenuId"/>
                                    <a href="<c:url value='/sym/mnu/mpm/EgovMenuListSelectMvmn.do' />"
                                       target="_blank"
                                       title="새창으로" onClick="mvmnMenuList();return false;"
                                       style="selector-dummy:expression(this.hideFocus=false);"><img
                                            src="<c:url value='/images/egovframework/com/cmm/icon/search2.gif' />"
                                            alt='' width="15" height="15"/>(메뉴선택 검색)</a>
                                </td>
                            </tr>
                            <tr>
                                <th style="background-color: #EEEEEE" width="15%" height="23" class="required_text"
                                    scope="row"><label
                                        for="progrmFileNm">파일명</label><img
                                        src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />"
                                        width="15"
                                        height="15" alt="필수입력표시"></th>
                                <td width="85%" colspan="3">
                                    &nbsp;
                                    <form:input path="progrmFileNm" size="60" maxlength="60" onkeypress="press();"
                                                title="파일명" readonly="true" class="readOnlyClass"/>
                                    <form:errors path="progrmFileNm"/>
                                    <a href="<c:url value='/sym/prm/EgovProgramListSearch.do'/>?tmp_SearchElementName=progrmFileNm"
                                       target="_blank" title="새창으로"
                                       onclick="javascript:searchFileNm(); return false;"
                                       style="selector-dummy:expression(this.hideFocus=false);">
                                        <img src="<c:url value='/images/egovframework/com/cmm/icon/search2.gif' />"
                                             alt=''
                                             width="15" height="15"/>(프로그램파일명 검색)</a>
                                </td>
                            </tr>
                            <tr>
                                <th style="background-color: #EEEEEE" width="15%" height="23" class="required_text"
                                    scope="row"><label
                                        for="relateImageNm">관련이미지명</label>
                                </th>
                                <td width="35%">
                                    &nbsp;
                                    <form:input path="relateImageNm" size="30" maxlength="30" title="관련이미지명"/>
                                    <form:errors path="relateImageNm"/>
                                </td>
                                <th style="background-color: #EEEEEE" width="15%" height="23" class="required_text"
                                    scope="row"><label
                                        for="relateImagePath">관련이미지경로</label>
                                </th>
                                <td width="35%">
                                    &nbsp;
                                    <form:input path="relateImagePath" size="30" maxlength="30" title="관련이미지경로"/>
                                    <form:errors path="relateImagePath"/>
                                </td>
                            </tr>
                            <tr>
                                <th style="background-color: #EEEEEE" width="15%" height="23" class="required_text"
                                    scope="row"><label
                                        for="menuDc">메뉴설명</label></th>
                                <td colspan="3">&nbsp;
                                    <form:textarea path="menuDc" rows="14" cols="75" cssClass="txaClass"
                                                   title="메뉴설명"/>
                                    <form:errors path="menuDc"/>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" name="tmp_SearchElementName" value="">
                        <input type="hidden" name="tmp_SearchElementVal" value="">
                        <input name="cmd" type="hidden" value="<c:out value='insert'/>">


                        <div class="dt-toolbar-footer">
                            <div align="right" style="padding-top: 4px">

                                <a class="btn btn-primary" href="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>"
                                                        onclick="javascript:selectList(); return false;">목록</a>

                                <input class="btn btn-primary" type="submit"
                                       value="<spring:message code="button.create"/>"
                                       onclick="insertMenuManage(document.forms[0]); return false;"/></span>
                            </div>

                            <!-- 페이징 끝 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
</article>


<%--메뉴선택 검색--%>


<div class="modal fade" id="menuSelect" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">시험방법추가</h4>
            </div>
            <div class="modal-body requestBody" style="padding-right: 200px;">
                <div class="page-content">
                    <div role="content">
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <fieldset>
                                    <form name="searchUpperMenuIdForm"
                                          action="<c:url value='/sym/mnu/mpm/EgovMenuListSelectTmp.do'/>" method="post">
                                        <div style="visibility:hidden;display:none;">
                                            <input name="iptSubmit"
                                                   type="submit" value="전송"
                                                   title="전송">
                                        </div>
                                        <input type="hidden" name="req_RetrunPath" value="/sym/mnu/mpm/EgovMenuMvmn">
                                        <c:forEach var="result" items="${list_menulist}" varStatus="status">
                                            <input type="hidden" name="tmp_menuNmVal"
                                                   value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.progrmFileNm}|${result.menuNo}|${result.menuOrdr}|${result.menuNm}|${result.upperMenuId}|${result.menuDc}|${result.relateImagePath}|${result.relateImageNm}|${result.progrmFileNm}|">
                                        </c:forEach>
                                        <DIV id="main">

                                            <table style="width:100%" cellpadding="8" class="table-search" border="0">
                                                <tr>
                                                    <td width="40%" class="title_left">
                                                        <h1><img
                                                                src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />"
                                                                width="16"
                                                                height="16" hspace="3" alt="">&nbsp;메뉴이동</h1></td>
                                                    <th>
                                                    </th>
                                                    <td width="10%"></td>
                                                    <td width="35%"></td>
                                                    <th width="10%">
                                                        <table border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td></td>
                                                            </tr>
                                                        </table>
                                                    </th>
                                                </tr>
                                            </table>
                                            <table style="width:100%" border="0" cellpadding="0" cellspacing="1">
                                                <tr>
                                                    <td width="100%">
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="1"
                                                               class="table-register"
                                                               summary="메뉴이동 처리버튼">
                                                            <caption>메뉴이동 처리버튼</caption>
                                                            <tr>
                                                                <th width="20%" height="40"
                                                                    style="background-color: #EEEEEE">이동할메뉴명&nbsp;</th>
                                                                <td width="80%">
                                                                    <table border="0" cellspacing="0" cellpadding="0"
                                                                           align="left">
                                                                        <tr>
                                                                            <td>&nbsp;<input name="progrmFileNm"
                                                                                             type="text" size="30"
                                                                                             value=""
                                                                                             maxlength="60"
                                                                                             title="이동할메뉴명"></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table style="width:100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td height="10">&nbsp;</td>
                                                </tr>
                                            </table>

                                            <table style="width:100%" cellpadding="8" class="table-line">
                                                <tr>
                                                    <td>
                                                        <div class="tree" style="width:100%;">
                                                            <script language="javascript" type="text/javaScript">

                                                                var chk_Object = true;
                                                                var chk_browse = "";
                                                                if (eval(document.searchUpperMenuIdForm.req_RetrunPath) == "[object]") chk_browse = "IE";
                                                                if (eval(document.searchUpperMenuIdForm.req_RetrunPath) == "[object NodeList]") chk_browse = "Fox";
                                                                if (eval(document.searchUpperMenuIdForm.req_RetrunPath) == "[object Collection]") chk_browse = "safai";

                                                                var Tree = new Array;
                                                                if (chk_browse == "IE" && eval(document.searchUpperMenuIdForm.tmp_menuNmVal) != "[object]") {
                                                                    alert("메뉴 목록 데이타가 존재하지 않습니다.");
                                                                    chk_Object = false;
                                                                }
                                                                if (chk_browse == "Fox" && eval(document.searchUpperMenuIdForm.tmp_menuNmVal) != "[object NodeList]") {
                                                                    alert("메뉴 목록 데이타가 존재하지 않습니다.");
                                                                    chk_Object = false;
                                                                }
                                                                if (chk_browse == "safai" && eval(document.searchUpperMenuIdForm.tmp_menuNmVal) != "[object Collection]") {
                                                                    alert("메뉴 목록 데이타가 존재하지 않습니다.");
                                                                    chk_Object = false;
                                                                }
                                                                if (chk_Object) {
                                                                    for (var j = 0; j < document.searchUpperMenuIdForm.tmp_menuNmVal.length; j++) {
                                                                        Tree[j] = document.searchUpperMenuIdForm.tmp_menuNmVal[j].value;
                                                                    }
                                                                    createTree(Tree, true);
                                                                } else {
                                                                    alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요");
                                                                    window.close();
                                                                }
                                                            </script>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </DIV>
                                    </form>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <footer>
                    </footer>
                </div>
                <!-- -----------------------------------------------------------------------------------  -->
            </div>
            <!-- Modal Body End-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="programFileName" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">시험방법추가</h4>
            </div>
            <div class="modal-body requestBody" style="padding-right: 200px;">
                <div class="page-content">
                    <div role="content">
                        <div class="form-horizontal form-terms ">
                            <div class="jarviswidget jarviswidget-sortable" role="widget">
                                <fieldset>
                                    <div align="center">
                                        <iframe style="width:800px; height: 600px; padding-left: 50px" frameborder=no
                                                scrolling=no
                                                src="${pageContext.request.contextPath}/sym/prm/EgovProgramListSearch.do"></iframe>

                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <footer>
                    </footer>
                </div>
                <!-- -----------------------------------------------------------------------------------  -->
            </div>
            <!-- Modal Body End-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>


