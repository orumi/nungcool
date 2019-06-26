<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.List" %>
<%@ page import="exam.com.detail.model.DetailVO" %>
<%@ page import="exam.com.common.PageMaker" %>
<%@ page import="exam.com.common.Criteria" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %>

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

    	$("#crtPage").val("1");
    	
    	frmSearch.submit();
    	
        /* var keyword = $("#keyword").val();
        location.href = "<c:url value='/detail/reqList.do?'/>sub=detail&menu=reqList&crtPage=1&keyword=" + keyword;
         */
    }

    function fnPageNext(){

        var lastPage = <%=pageMaker.getEndPage()%>;
        var currentPage = <%=cri.getCrtPage()%>;
        var nextPage = currentPage+1;

        if(nextPage > lastPage){
            alert("마지막페이지 입니다.");
        } else {
        	$("#crtPage").val(nextPage);    
        	frmSearch.submit();
        	
        	//location.href = "<c:url value='/detail/reqList.do?'/>sub=detail&menu=reqList&crtPage="+nextPage+"&keyword=<%=cri.getKeyword()%>";
        }
    }

    function fnPagePrev(){

        var firstPage = 1;
        var currentPage = <%=cri.getCrtPage()%>;
        var prevPage = currentPage-1;

        if(prevPage < firstPage){
            alert('첫번째 페이지 입니다.');
        } else {
        	$("#crtPage").val(prevPage);    
        	frmSearch.submit();
        	
        	//location.href = "<c:url value='/detail/reqList.do?'/>sub=detail&menu=reqList&crtPage="+prevPage+"&keyword=<%=cri.getKeyword()%>";
        }

    }

    function actionPage(page){
    	$("#crtPage").val(page);    
    	frmSearch.submit();
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
    	openINIpay = window.open( "<c:url value='/INIpay/INIpaystart.jsp?'/>selchk="+selchk,"new","left=300, top=300, width=800, height=600, toolbar=no, location=yes, directories=no, status=no, menubar=no, scrollbars=yes, copyhistory=yes, resizable=no");
    	openINIpay.focus();
    }
    
    
    
    var openINIcancel;
    var cancelBillno;
    function actionCancelCard( cardbillno ){
    	
    	cancelBillno = cardbillno;
    	
    	if(openINIcancel) openINIcancel.close();
    	
    	openINIcancel = window.open( "<c:url value='/INIpay/INIcancelstart.jsp?'/>cancelType=request&cardbillno="+cardbillno,"new","left=300, top=300, width=800, height=600, toolbar=no, location=yes, directories=no, status=no, menubar=no, scrollbars=yes, copyhistory=yes, resizable=no");
    	openINIcancel.focus();
    }

</script>

<form name="frmSearch" action="<c:url value='/detail/reqList.do?sub=detail&menu=reqList'/>" accept-charset="UTF-8" method="post">
<input type="hidden" name="crtPage" id="crtPage" >
<!-- right_warp(오른쪽 내용) -->
<div class="right_warp">
    <div class="title_route">
    		<div class="title_route">
				<h3>접수정보조회(수수료납부)</h3>
				<p class="route">
				<img src="<c:url value='/images/exam/ico/home.gif'/>" alt="홈"/> 
				<img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> 접수내역 
				<img src="<c:url value='/images/exam/bg/gt.gif'/>" alt=""/> <span>접수정보조회(수수료납부)</span></p>
			</div>
			
    </div>
    <!-- 신청일자검색 -->
    <div class="table_bg m_B27">
        <table summary="신청일자검색" class="table_w">
            <colgroup>
                <col width="131px"/>
                <col width="*"/>
            </colgroup>
<%--            <tr>
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
                <th class="b_B_none">검색</th>
                <td class="b_B_none">
                    <input id="keyword" name="keyword" type="text" value="<%=(cri.getKeyword() != null)?keyword:""%>"
                           onkeypress='if( event.keyCode==13 ){fnSearch()}' class="h30" style="width:248px"/>
                    <a href="javascript: fnSearch()">
                        <img src="<c:url value='/images/exam/btn/btn_inquiry01.gif'/>" alt="조회"/>
                    </a>
                    <span class="txt_color01 font12"> &nbsp;※ 접수번호/시료명/유종제품 구분없이 조회가능</span>
                </td>
            </tr>
        </table>
    </div>
    <!-- //신청일자검색 -->
</form>
    <!-- 신청내역정보 -->
    <h4 class="title01">신청내역정보
       <div style="float:right;padding-right:18px;">
    	<div type="button" class="btn btn-primary" style="height:17px;font-size:13px;padding:3px 6px !important;margin:0px;" onclick="javascript:actionCard();">
					                카드결제
	    </div>
       </div>
      <span class="notice" style="background: none !important;width:590px;"> ※  신청정보 수정 또는 삭제하려면 <strong>[상세보기]</strong>버튼 클릭. &nbsp;&nbsp;&nbsp;  ※  결재 정보를 선택 후 <strong>[카드결재]</strong>버튼 클릭.</span>
    </h4>
    <!-- table_bg -->
    <div class="table_bg">
        <table summary="신청내역정보" class="table_h">
            <colgroup>
                <col width="5%"/>
                <col width="10%"/>
                <col width="30%"/>
                <col width="10%"/>
                <col width="12%"/>
                <col width="10%"/>
                <col width="7%"/>
                <col width="8%"/>
                <col width="*"/>
            </colgroup>
            <tr>
                <th>순번</th>
                <th>시료(항목)<br>건수</th>
                <th>시료명</th>
                <th>진행상태</th>
                <th>견적서</th>
                <th>수수료</th>
                <th>결제</th>
                <th>시료도착</th>
                <th class="b_R_none">상세보기</th>
            </tr>
            <tbody>
            <%
                for (DetailVO vo : list) {
            %>

            <tr>
                <td class="txt_C"><%=vo.getIdx()%>
                </td>
                <td class="txt_C"><%=vo.getSmpcnt()%>(<%=vo.getItemcnt()%>)
                </td>
                <td class="txt_L"><%=(vo.getSmpname()!=null && vo.getSmpname().length()>25)?vo.getSmpname().substring(0,23)+" ...":(vo.getSmpname()!=null?vo.getSmpname():"") %>
                </td>
                <td class="txt_C"><%=vo.getStatenm()%>
                </td>
                <td class="txt_C"><a href="#"><img src="<c:url value='/images/exam/btn/btn_print01.gif'/>"
                                                   alt="견적서 인쇄"/></a></td>
                <td class="txt_R"><%=vo.getTotalprice()!=null?vo.getTotalprice():""%>
                </td>
                <td class="txt_C">
                	<% if(vo.getReqstate().equals("2")){ %>
                	
                		<% if("29".equals(vo.getPricetype())){ %>
                		<!-- 결제완료 -->
                		<div type="button" class="btn btn-warning" style="height:17px;font-size:12px;padding:1px 2px !important;margin:4px;" onclick="javascript:actionCancelCard('<%=vo.getCardbillno()%>');">
					                결제취소
					    </div>
                		<% } else { %>
                		<input type="checkbox" id="chk_card" name="chk_card" value="<%=vo.getReqid()%>">
                		<% } %>
                	<% } else { %>
                		처리중
                	<% } %>
                </td>
                <td class="txt_C"><%=(vo.getSmpgetyn()!=null && vo.getSmpgetyn().equals("Y"))?"도착완료":"-" %></td>
                <td class="txt_C b_R_none"><a href="javascript:actionOpenReqDetail('<%=vo.getReqid()%>');"><img src="<c:url value='/images/exam/btn/btn03.gif'/>" alt="상세보기"/></a></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <!-- //신청내역정보 -->

    <!-- 페이지리스트 -->
    <p class="pagelist m_T14">

        <a href="<c:url value='/detail/reqList.do?'/>sub=detail&menu=reqList&crtPage=1&keyword=<%=cri.getKeyword()%>" class="btn_pr01">
            <img src="<c:url value='/images/exam/btn/btn_pr01.gif'/>" alt="첫번째 페이지"/>
        </a>

        <a href="javascript: fnPagePrev()" class="btn_pr02"><img src="<c:url value='/images/exam/btn/btn_pr02.gif'/>" alt="이전"/></a>

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
        <a href="javascript:actionPage(<%=i%>);"><%=i%></a>
        <%
            }
        %>
        <%
            }
        %>

        <input type="text" value="10" style="width:26px;" class="page_input"/>

        <a href="#" class="go_btn"><img src="<c:url value='/images/exam/btn/btn_go01.gif'/>" alt="go"/></a>

        <a href="javascript: fnPageNext()"><img src="<c:url value='/images/exam/btn/btn_nex01.gif'/>" alt="다음"/></a>

        <a href="<c:url value='/detail/reqList.do?'/>sub=detail&menu=reqList&crtPage=<%=pageMaker.getEndPage()%>&keyword=<%=cri.getKeyword()%>" class="btn_nex02">
            <img src="<c:url value='/images/exam/btn/btn_nex02.gif'/>" alt="10페이지 뒤로"/>
        </a>

    </p>
    <!-- //페이지리스트 -->
</div>
<!-- //right_warp(오른쪽 내용) -->