<%@ page import="exam.com.common.Criteria" %>
<%@ page import="exam.com.common.PageMaker" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

    PageMaker pageMaker = (PageMaker) request.getAttribute("pageMaker");
    Criteria cri = pageMaker.getCri();

%>

<script>

    $(function () {

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

        if ($("#crtPage").val() == 1) {
            alert('its first page here');
        } else {
            $("#crtPage").val($("#crtPage").val() - 1);
            frmSearch.submit();
        }
    }

    function fnPageNext() {

        alert('1');

        if ($("#crtPage").val() == lastPage) {
            alert('its last page here');
        } else {
            $("#crtPage").val($("#crtPage").val() + 1);
            frmSearch.submit();
        }
    }

    function deleteCopyList(reqId, reportId) {

        if (!confirm('삭제 하시겠습니까?')) {
            return false;
        }

        $.ajax({
            type: "post",
            data: {"reqId": reqId, "reportId": reportId},
            async: false,
            url: "<c:url value='/report/deleteCopyList.json'/>",
            success: function (data) {
                location.reload();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "\n" + "error:" + error);
            },
            complete: function (data) {
            },
            cache: false
        });


    }

    function reviseCopyReport(reqId, reportId) {

        location.href = "<c:url value='/report/reviseCopyReport.do'/>?sub=report&menu=copyReport&reqId=" + reqId + "&reportId=" + reportId;

    }

    function reviseMergeReport(reqId, reportId) {
        location.href = "<c:url value='/report/reviseMergeReport.do'/>?sub=report&menu=copyReport&reqId=" + reqId + "&reportId=" + reportId;
    }

    
    var openINIpay ;
    function actionCard(){
    	
    	var chks = "";
    	$("input[name=chk_card]:checkbox").each(function(i){
    		if($(this).prop("checked")){
    			chks += "|"+$(this).val();
    		}
    	})
    	var selchk = chks;
    	
    	if(chks == ""){
    		alert("결제하려고 하는 정보를 선택하십시오.");
    		return;
    	}
    	
    	if(openINIpay) openINIpay.close();
    	openINIpay = window.open( "<c:url value='/INIpay/INIpaystartReport.jsp?'/>selchk="+selchk,"new","left=300, top=300, width=800, height=600, toolbar=no, location=yes, directories=no, status=no, menubar=no, scrollbars=yes, copyhistory=yes, resizable=no");
    	openINIpay.focus();
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


<form id="frmSearch" name="frmSearch" action="<c:url value='/report/copyReport.do?sub=report&menu=testReport'/>"
      method="post">

    <!-- right_warp(오른쪽 내용) -->
    <div class="right_warp">


        <%--<div class="title_route">
            <h3><img src="<c:url value='/images/exam/bg/report02_title.gif'/>" alt="등본통합발급"/></h3>

            <p class="route">
                <img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/>
                <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 성적서확인 <img
                    src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/>
                <span>등본(통합)발급</span>
            </p>
        </div>--%> <!-- 두줄깨짐 수정 아래로 대체 -->


            <div class="title_route">
                <div class="title_route">
                    <h3>등본통합발급</h3>

                    <p class="route">
                        <img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/>
                        <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 성적서확인
                        <img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/>
                        <span>등본통합발급</span>
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
                    <th>신청일자</th>
                    <td>
                        <input type="text" id="requestDate1" name="requestDate1" class="h30" style="width:142px;"
                               value="${requestDate1}"/>
                        ~
                        <input type="text" id="requestDate2" name="requestDate2" class="h30" style="width:142px;"
                               value="${requestDate2}"/>

                    </td>
                </tr>
                <tr>
                    <th class="b_B_none">검색</th>
                    <td class="b_B_none">
                        <input type="text" id="keyword" name="keyword" value="${keyword}" class="h30"
                               style="width:248px"
                               onkeydown="javascript: if(event.keyCode == 13)search()"/>
                        <a href="javascript:search()"><img src="<c:url value='/images/exam/btn/btn_inquiry01.gif'/>"
                                                           alt="조회"/></a>
                        <span class="txt_color01 font12"> &nbsp; ※ 접수번호/시료명/유종/제품</span>
                    </td>
                </tr>
            </table>
        </div>

        <!-- //신청일자검색 -->

        <!-- 신청내역정보 -->
        <h4 class="title01" style="float:left;">신청내역정보<span class="back01">&nbsp;(신규 발급 요청은 <strong>성적서발급조회</strong>에서 가능) </span></h4>
        	<div type="button" class="btn btn-primary" style="float:right;height:17px;font-size:13px;padding:3px 6px !important;margin:0px;" onclick="javascript:actionCard();">
					카드결제
		    </div>
		    
        <!-- table_bg -->
        <div class="table_bg" style="float:right;width:100%">
            <table summary="신청내역정보" class="table_h">
                <colgroup>
                    <col width="5%"/>
                    <col width="8%"/>
                    <col width="8%"/>
                    <col width="8%"/>
                    <col width="10%"/>
                    <col width="10%"/>
                    <col width="8%"/>
                    <col width="10%"/>
                    <col width="8%"/>
                    <col width="10%"/>
                    <col width="8%"/>
                    <col width="8%"/>
                </colgroup>
                <tr>
                    <th>번호</th>
                    <th>접수번호</th>
                    <th>발급번호</th>
                    <th>시료건수</th>
                    <th>검사항목수</th>
                    <th>발급일자</th>
                    <th>수수료</th>
                    <th>진행상태</th>
                    <th>결제상태</th>
                    <th>시험결과<br/>보기</th>
                    <th>수정</th>
                    <th class="b_R_none">삭제</th>

                </tr>

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
                        <td class="txt_C">${list.stateNm}
                        </td>
                        <td class="txt_C">
                         	<c:if test="${list.reportState < 2}">
                         		신청중
                         	</c:if>
                         	<c:if test="${list.reportState == 2}">
                         	
                         		<c:if test="${list.pricetype > 0 }">
                         			결제완료
                         		</c:if>
                         		<c:if test="${list.pricetype == null }">
                         			<input type="checkbox" id="chk_card" name="chk_card" value="${list.reqId}_${list.reportId}">
                         		</c:if>
                         	</c:if>
                         	<c:if test="${list.reportState > 2}">
                         		완료
                         	</c:if>
                        
                        </td>
                        <td class="txt_C"><a href="#"><img src="<c:url value='/images/exam/btn/btn03.gif'/>"
                                                           alt=""/></a>
                        </td>

                        <c:if test="${list.type == 'C'}">
                        <td class="txt_C"><a href="javascript:reviseCopyReport('${list.reqId}','${list.reportId}')"><img
                                src="<c:url value='/images/exam/btn/btn03.gif'/>"></a>
                            </c:if>


                            <c:if test="${list.type == 'M'}">
                        <td class="txt_C"><a
                                href="javascript:reviseMergeReport('${list.reqId}','${list.reportId}')"><img
                                src="<c:url value='/images/exam/btn/btn03.gif'/>"></a>
                            </c:if>


                        </td>
                        <td class="txt_C b_R_none"><a
                                href="javascript:deleteCopyList('${list.reqId}','${list.reportId}')"><img
                                src="<c:url value='/images/exam/btn/btn_del02.gif'/>"
                                alt="삭제"/></a></td>
                    </tr>

                </c:forEach>

                <%--					<tr>
                                        <td class="txt_C">1</td>
                                        <td class="txt_C">2015-0120</td>
                                        <td class="txt_C">000-01</td>
                                        <td class="txt_C">3</td>
                                        <td class="txt_C">46</td>
                                        <td class="txt_C">2015-10-10</td>
                                        <td class="txt_R">160,000</td>
                                        <td class="txt_C">접수대기</td>
                                        <td class="txt_C"><a href="#"><img src="<c:url value='/images/exam/btn/btn_sign.gif'/>" alt="" /></a></td>
                                        <td class="txt_C"><a href="#"><img src="<c:url value='/images/exam/btn/btn03.gif'/>" alt="" /></a></td>
                                        <td class="txt_C b_R_none"><a href="#"><img src="<c:url value='/images/exam/btn/btn_del02.gif'/>" alt="삭제" /></a></td>
                                    </tr>--%>

                </tbody>
            </table>
        </div>
        <!-- //신청내역정보 -->

        <!-- 페이지리스트 -->
        <!-- 페이지리스트 -->
        <p class="pagelist m_T14" style="float:left;width:100%;text-align:center;">

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
        <!-- //페이지리스트 -->


    </div>
</form>
<!-- //right_warp(오른쪽 내용) -->