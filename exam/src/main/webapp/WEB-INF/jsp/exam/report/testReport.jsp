<%@ page import="exam.com.common.Criteria" %>
<%@ page import="exam.com.common.PageMaker" %>
<%@ page import="exam.com.report.model.ReportVO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    PageMaker pageMaker = (PageMaker) request.getAttribute("pageMaker");
    Criteria cri = pageMaker.getCri();
%>
<script>

    var lastPage = '<%= pageMaker.getEndPage()%>';

    $(function () {

        $("#issueDate1").datepicker({
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage: "<c:url value='/images/calendar.gif'/>",
            buttonImageOnly: true,
            buttonText: "일자선택",
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            onClose: function (selectedDate) {
                $("#issueDate2").datepicker("option", "minDate", selectedDate);
            }
        });

        $("#issueDate2").datepicker({
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage: "<c:url value='/images/calendar.gif'/>",
            buttonImageOnly: true,
            buttonText: "일자선택",
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            onClose: function (selectedDate) {
                $("#issueDate1").datepicker("option", "maxDate", selectedDate);
            }
        });

        $("#requestDate1").datepicker({
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage: "<c:url value='/images/calendar.gif'/>",
            buttonImageOnly: true,
            buttonText: "일자선택",
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            onClose: function (selectedDate) {
                $("#requestDate2").datepicker("option", "minDate", selectedDate);
            }
        });

        $("#requestDate2").datepicker({
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            showOn: "both",
            buttonImage: "<c:url value='/images/calendar.gif'/>",
            buttonImageOnly: true,
            buttonText: "일자선택",
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            onClose: function (selectedDate) {
                $("#requestDate1").datepicker("option", "maxDate", selectedDate);
            }
        });

    });

    function search() {

        $("#crtPage").val("1");
        frmSearch.submit();

    }

    function goPage(index) {
        $("#crtPage").val(index);
        frmSearch.submit();
    }

    function fnPagePrev() {

        if($("#crtPage").val() == 1){
            alert('its first page here');
        } else {
            $("#crtPage").val($("#crtPage").val()-1);
            frmSearch.submit();
        }
    }

    function fnPageNext() {

        if($("#crtPage").val() == lastPage){
            alert('마지막 페이지 입니다.');
        } else {
            $("#crtPage").val($("#crtPage").val()+1);
            frmSearch.submit();
        }
    }

    function requestCopyReportDetail( reqId ){
        window.location.replace("<c:url value='/report/copyReportRequest.do'/>?sub=report&menu=testReport"+"&reqId="+reqId);
    }

    function requestMergeCopy(reqId) {
        window.location.replace("<c:url value='/report/mergeCopyRequest.do'/>?sub=report&menu=testReport"+"&reqId="+reqId);
    }



</script>

<style>

    /* datepicker css  */

    .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
        border: 1px solid #37A3D0;
        background: #71B9D7;
        font-weight: normal;
        color: #fff !important;
    }

    .ui-state-default:HOVER, .ui-widget-content .ui-state-default:HOVER, .ui-widget-header .ui-state-default:HOVER {
        border: 1px solid #227BB3;
        background: #4B93C0;
        font-weight: normal;
        color: #fff !important;
    }

    .ui-datepicker-trigger {
        cursor: pointer;
        border: 1px solid #C7C7C7;
        padding: 4px;
        border-left: none;
    }

</style>


<%
    String keyword = (String) request.getAttribute("keyword");
    String requestDate1 = (String) request.getAttribute("requestDate1");
    String requestDate2 = (String) request.getAttribute("requestDate2");
    String issueDate1 = (String) request.getAttribute("issueDate1");
    String issueDate2 = (String) request.getAttribute("issueDate2");
    int crtPage = (Integer) request.getAttribute("crtPage");
%>


<form id="frmSearch" name="frmSearch" action="<c:url value='/report/testReport.do?sub=report&menu=testReport'/>"
      method="post">

    <input id="crtPage" name="" value="<%=crtPage%>" hidden="hidden" style="display: none"/>

    <!-- right_warp(오른쪽 내용) -->
    <div class="right_warp">
        <div class="title_route">
            <div class="title_route">
                <h3>성적서발급조회</h3>

                <p class="route">
                    <img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/>
                    <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 접수내역
                    <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/>
                    <span>성적서발급조회</span>
                </p>
            </div>

        </div>


        <!-- 신청일자검색 -->
        <div class="table_bg m_B27">
            <table summary="신청일자검색" class="table_w">
                <colgroup>
                    <col width="131px"/>
                    <col width="*"/>
                </colgroup>
                <tr>
                    <th>발급일자</th>
                    <td>
                        <%--<input type="checkbox"/>--%>
                        <input type="text" id="issueDate1" name="issueDate1" value="<%=issueDate1%>" class="h30"
                               style="width:142px;"/>
                        ~
                        <%--<input type="checkbox"/>--%>
                        <input type="text" id="issueDate2" name="issueDate2" value="<%=issueDate2%>" class="h30"
                               style="width:142px;"/>
                    </td>
                </tr>
                <tr>
                    <th>신청일자</th>
                    <td>
                        <%--<input type="checkbox"/>--%>
                        <input type="text" id="requestDate1" name="requestDate1" value="<%=requestDate1%>" class="h30" style="width:142px;"/>
                        ~
                        <%--<input type="checkbox"/>--%>
                        <input type="text" id="requestDate2" name="requestDate2" value="<%=requestDate2%>" class="h30" style="width:142px;"/>
                    </td>
                </tr>
                <tr>
                    <th class="b_B_none">검색</th>
                    <td class="b_B_none">
                        <input id="keyword" name="keyword" type="text" value="<%=keyword%>" class="h30" style="width:248px"
                               onkeydown="javascript: if(event.keyCode == 13)search()"/>
                        <a href="javascript: search()"><img src="<c:url value='/images/exam/btn/btn_inquiry01.gif'/>" alt="조회"/></a>
                        <span class="txt_color01 font12"> &nbsp;※ 접수번호/시료명/유종/제품 단일단어 검색</span>
                    </td>
                </tr>
            </table>
        </div>
        <!-- //신청일자검색 -->

        <!-- 발급내역정보 -->
        <h4 class="title01">발급내역정보</h4>
        <!-- table_bg -->
        <div class="table_bg">
            <table summary="발급내역정보" class="table_h">
                <thead>
                <colgroup>
                    <col width="6%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                    <col width="9%"/>
                </colgroup>
                <tr>
                    <th>순번</th>
                    <th>접수번호</th>
                    <th>발급번호</th>
                    <th>시료건수</th>
                    <th>검사항목수</th>
                    <th>발급일자</th>
                    <th>수수료</th>
                    <th>시험결과<br/>보기</th>
                    <th>재신청</th>
                    <th>등본요청</th>
                    <th class="b_R_none">통합요청</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="list" items="${list}">


                    <tr>
                        <td class="txt_C">${list.idx}
                        </td>
                        <td class="txt_C">${list.acceptNo}
                        </td>
                        <td class="txt_C">${list.reportNo}
                        </td>
                        <td class="txt_C">${list.smpCnt}
                        </td>
                        <td class="txt_C">${list.examItemCnt}
                        </td>
                        <td class="txt_C">${list.issueDateCmpl}
                        </td>
                        <td class="txt_R">${list.totalPrice}
                        </td>
                        <td class="txt_C"><a href="#"><img src="<c:url value='/images/exam/btn/btn03.gif'/>" alt=""/></a>
                        </td>
                        <td class="txt_C"><a href="#"><img src="<c:url value='/images/exam/btn/btn03.gif'/>" alt=""/></a>
                        </td>
                        <td class="txt_C b_R_none"><a href="javascript:requestCopyReportDetail('${list.reqId}')">
                            <img src="<c:url value='/images/exam/btn/btn03.gif'/>" alt="..."/></a>
                        </td>
                        <td class="txt_C b_R_none"><a href="javascript:requestMergeCopy('${list.reqId}')">
                            <img src="<c:url value='/images/exam/btn/btn03.gif'/>" alt="..."/></a>
                        </td>
                    </tr>


                </c:forEach>

                </tbody>
            </table>
        </div>
        <!-- //발급내역정보 -->








        <!-- 페이지리스트 -->
        <p class="pagelist m_T14">

            <a href="javascript:goPage('<%=pageMaker.getStartPage()%>')"
               class="btn_pr01">
                <img src="<c:url value='/images/exam/btn/btn_pr01.gif'/>" alt="첫번째 페이지"/>
            </a>

            <a href="javascript: fnPagePrev()" class="btn_pr02"><img
                    src="<c:url value='/images/exam/btn/btn_pr02.gif'/>" alt="이전"/></a>

            <%
                for (int i = pageMaker.getStartPage(); i <= pageMaker.getEndPage(); i++) {

                    if (i == pageMaker.getCri().getCrtPage()) {
            %>
            <strong>
                <%=i%>
            </strong>
            <%
            } else {
            %>
            <a href="javascript:goPage('<%=i%>')"><%=i%>
            </a>
            <%
                }
            %>
            <%
                }
            %>

            <a href="javascript:fnPageNext()"><img src="<c:url value='/images/exam/btn/btn_nex01.gif'/>" alt="다음"/></a>

            <a href="javascript:goPage('<%=pageMaker.getEndPage()%>')"
               class="btn_nex02">
                <img src="<c:url value='/images/exam/btn/btn_nex02.gif'/>" alt="go to endPage"/>
            </a>
        </p>

    </div>
</form>
<!-- //right_warp(오른쪽 내용) -->
