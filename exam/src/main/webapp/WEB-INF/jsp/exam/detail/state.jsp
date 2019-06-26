<%@ page import="exam.com.detail.model.DetailVO" %>
<%@ page import="java.util.List" %>
<%@ page import="exam.com.common.PageMaker" %>
<%@ page import="exam.com.common.Criteria" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<%
    List<DetailVO> list = (List) request.getAttribute("detailList");
    PageMaker pageMaker = (PageMaker) request.getAttribute("pageMaker");
    Criteria cri = pageMaker.getCri();
    String keyword = cri.getKeyword();
    if(keyword == null || keyword.equals("null")){
        keyword = "";
    }
%>

<script>


    function fnSearch() {

        var keyword = $("#keyword").val();

        location.href = "<c:url value='/detail/state.do?'/>sub=detail&menu=reqList&crtPage=1&keyword=" + keyword;
    }

    function fnPageNext(){

        var lastPage = <%=pageMaker.getEndPage()%>;
        var currentPage = <%=cri.getCrtPage()%>;
        var nextPage = currentPage+1;

        if(nextPage > lastPage){
            alert("마지막페이지 입니다.");
        } else {
            location.href = "<c:url value='/detail/state.do?'/>sub=detail&menu=reqList&crtPage="+nextPage+"&keyword=<%=cri.getKeyword()%>";
        }
    }

    function fnPagePrev(){

        var firstPage = 1;
        var currentPage = <%=cri.getCrtPage()%>;
        var prevPage = currentPage-1;

        if(prevPage < firstPage){
            alert('첫번째 페이지 입니다.');
        } else {
            location.href = "<c:url value='/detail/state.do?'/>sub=detail&menu=reqList&crtPage="+prevPage+"&keyword=<%=cri.getKeyword()%>";
        }

    }


</script>


<!-- right_warp(오른쪽 내용) -->
<div class="right_warp">

    <div class="title_route">
    		<div class="title_route">
				<h3>분석진행상태조회</h3>
				<p class="route">
				<img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> 
				<img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 접수내역 
				<img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>분석진행상태조회</span></p>
			</div>
			
    </div>
    <!-- 신청일자검색 -->
    <div class="table_bg m_B27">
        <table summary="신청일자검색" class="table_w">
            <colgroup>
                <col width="131px"/>
                <col width="*"/>
            </colgroup>
            <%--<tr>
                <th>신청일자</th>
                <td>
                    <input type="checkbox"/>
                    <select class="h30" style="width:142px;">
                        <option> 달력</option>
                    </select>
                    ~
                    <input type="checkbox"/>
                    <select class="h30" style="width:142px;">
                        <option> 달력</option>
                    </select>
                </td>
            </tr>--%>
            <tr>
                <th class="b_B_none">검색어</th>
                <td class="b_B_none">

                    <%
                        if (cri.getKeyword() != null) {
                    %>
                    <input id="keyword" type="text" value="<%=keyword%>" class="h30" style="width:248px"/>
                    <%
                    } else {
                    %>
                    <input id="keyword" type="text" value="" class="h30" style="width:248px"/>
                    <%
                        }
                    %>

                    <a href="javascript: fnSearch()"><img src="<c:url value='/images/exam/btn/btn_inquiry01.gif'/>"
                                                          alt="조회"/></a>
                    <span class="txt_color01 font12"> &nbsp;※ 접수번호/시료명/유종제품 구분없이 조회가능</span>
                </td>
            </tr>
        </table>
    </div>
    <!-- //신청일자검색 -->

    <!-- 신청내역정보 -->
    <h4 class="title01">신청내역정보</h4>
    <!-- table_bg -->
    <div class="table_bg">
        <table summary="신청내역정보" class="table_h">
            <colgroup>
                <col width="8%"/>
                <col width="10%"/>
                <col width="20%"/>
                <col width="30%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="*"/>
            </colgroup>
            <tr>
                <th>순번</th>
                <th>접수번호</th>
                <th>시료명</th>
                <th>유종/제품</th>
               <th>시료(항목)<br>건수</th>
                <th>진행상태</th>
                <th class="b_R_none">상세보기</th>
            </tr>


            <tbody>
            <%
                for (DetailVO vo : list) {
            %>
            <tr>
                <td class="txt_C"><%=vo.getIdx()%></td>
                <td class="txt_C"><%=vo.getAcceptno()!=null?vo.getAcceptno():"발급전"%></td>
                <td class="txt_L"><%=(vo.getSmpname()!=null && vo.getSmpname().length()>17)?vo.getSmpname().substring(0,15)+" ...":(vo.getSmpname()!=null?vo.getSmpname():"") %></td>
                <td class="txt_L"><%=(vo.getPrdname()!=null && vo.getPrdname().length()>22)?vo.getPrdname().substring(0,20)+" ...":(vo.getPrdname()!=null?vo.getPrdname():"") %></td>
                <td class="txt_C"><%=vo.getSmpcnt()%>(<%=vo.getItemcnt()%>)</td>
                <td class="txt_C"><%=vo.getStatenm() %></td>
                <td class="txt_C b_R_none"><a href="javascript:actionOpenReqView('<%=vo.getReqid()%>');"><img src="<c:url value='/images/exam/btn/btn03.gif'/>"
                                                            alt="상세보기"/></a></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <!-- //신청내역정보 -->



    <p class="pagelist m_T14">

        <a href="<c:url value='/detail/state.do?'/>sub=detail&menu=reqList&crtPage=1&keyword=<%=cri.getKeyword()%>" class="btn_pr01">
            <img src="<c:url value='/images/exam/btn/btn_pr01.gif'/>" alt="첫번째 페이지"/>
        </a>

        <a href="javascript: fnPagePrev()" class="btn_pr02"><img src="<c:url value='/images/exam/btn/btn_pr02.gif'/>" alt="이전"/></a>

        <%
            for (int i = pageMaker.getStartPage(); i <= pageMaker.getEndPage(); i++) {

                if (i == pageMaker.getCri().getCrtPage()) {
        %>
        <a href="<c:url value='/detail/state.do?'/>sub=detail&menu=reqList&crtPage=<%=i%>&keyword=<%=cri.getKeyword()%>">
            <strong>
                <%=i%>
            </strong>
        </a>
        <%
        } else {
        %>
        <a href="<c:url value='/detail/state.do?'/>sub=detail&menu=reqList&crtPage=<%=i%>&keyword=<%=cri.getKeyword()%>"><%=i%>
        </a>
        <%
            }
        %>
        <%
            }
        %>

        <input type="text" value="10" style="width:26px;" class="page_input"/>

        <a href="#" class="go_btn"><img src="<c:url value='/images/exam/btn/btn_go01.gif'/>" alt="go"/></a>

        <a href="javascript: fnPageNext()"><img src="<c:url value='/images/exam/btn/btn_nex01.gif'/>" alt="다음"/></a>

        <a href="<c:url value='/detail/state.do?'/>sub=detail&menu=reqList&crtPage=<%=pageMaker.getEndPage()%>&keyword=<%=cri.getKeyword()%>" class="btn_nex02">
            <img src="<c:url value='/images/exam/btn/btn_nex02.gif'/>" alt="10페이지 뒤로"/>
        </a>

    </p>








<%--
<!-- 페이지리스트 -->
    <p class="pagelist m_T26 m_B20">
        <a href="#" class="btn_pr01"><img src="<c:url value='/images/exam/btn/btn_pr01.gif'/>" alt="10페이지 이전"/></a>
        <a href="#" class="btn_pr02"><img src="<c:url value='/images/exam/btn/btn_pr02.gif'/>" alt="이전"/></a>
        <a href="#"><strong>1</strong></a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a href="#">6</a>
        <a href="#">7</a>
        <a href="#">8</a>
        <a href="#">9</a>
        <a href="#">10</a>
        <input type="text" value="10" style="width:26px;" class="page_input"/>
        <a href="#" class="go_btn"><img src="<c:url value='/images/exam/btn/btn_go01.gif'/>" alt="go"/></a>
        <a href="#" class="btn_nex01"><img src="<c:url value='/images/exam/btn/btn_nex01.gif'/>" alt="다음"/></a>
        <a href="#" class="btn_nex02"><img src="<c:url value='/images/exam/btn/btn_nex02.gif'/>" alt="10페이지 뒤로"/></a>
    </p>
    <!-- //페이지리스트 -->


--%>
<br><br>
    <h4 class="title01">분석진행과정</h4>
    <ul class="step_list">
        <li class="step01"><img src="<c:url value='/images/exam/btn/step01_off.png'/>" alt="분석진행"/></li>
        <li class="step02"><img src="<c:url value='/images/exam/btn/step02_off.png'/>" alt="시험완료"/></li>
        <li class="step03"><img src="<c:url value='/images/exam/btn/step03_off.png'/>" alt="결재완료"/></li>
        <li class="step04"><img src="<c:url value='/images/exam/btn/step04_off.png'/>" alt="발급완료"/></li>
    </ul>
</div>



<!-- //right_warp(오른쪽 내용) -->