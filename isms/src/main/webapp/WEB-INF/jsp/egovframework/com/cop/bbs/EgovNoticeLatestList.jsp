<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/com/cop/bbs/"/>
<%
 /**
  * @Class Name : EgovNoticeList.jsp
  * @Description : 게시물 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.19   이삼섭          최초 생성
  * @ 2011.11.11   이기하          익명게시판 검색시 작성자 제거
  * @ 2015.05.08   조정국          표시정보 클릭시 이동링크 제한 : bbsId가 없는 요청은 처리제한.
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.19
  *  @version 1.0
  *  @see
  *
  */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/egovframework/com/button.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<style type="text/css">

	div#border {
	    width: 100% !important;
	    margin: 0 auto;
	    border-collapse: collapse;
	}
	
	.listTable th {
	    BORDER-bottom: #A3A3A3 1px solid;
	    padding-left: 2px;
	    padding-right: 2px;
	    background-color: #efefef;;
	    height: 30px;
	    color: #3c3c3c;
	}
	.listTable {
		border-spacing: 0px !important;
	    BORDER-TOP: #8c8c8c 2px solid;
	    BORDER-bottom: #BABABA 1px solid;
	}
	
	.listTable td {
	    BORDER-bottom: #E0E0E0 1px solid;
	    padding-left: 2px;
	    padding-right: 2px;
	    background-color: #fff;
	    height: 28px;
	}


</style>

<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cop/bbs/EgovBBSMng.js' />" ></script>
<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
	function press(event) {
	}

	function fn_egov_addNotice() {
	}

	function fn_egov_select_noticeList(pageNo) {
	}

	function fn_egov_inqire_notice(nttId, bbsId) {
	}
//-->
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
<!--
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_noticeList('1');
		}
	}

	function fn_egov_addNotice() {
		document.frm.action = "<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>";
		document.frm.submit();
	}

	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_notice(i, nttId, bbsId) {
		 if(bbsId == "") return false; //20150508
		document.subForm.nttId.value = nttId;
		document.subForm.bbsId.value = bbsId;
		document.subForm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
		document.subForm.submit();
	}
//-->
</script>
</c:otherwise>
</c:choose>
<title><c:out value="${brdMstrVO.bbsNm}"/></title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>
<body>

<div id="border">



<table width="100%" cellpadding="0" class="listTable" summary="번호, 제목, 게시시작일, 게시종료일, 작성자, 작성일, 조회수   입니다">
 <thead>
  <tr>
    <!-- th class="title" width="3%" nowrap><input type="checkbox" name="all_check" class="check2"></th-->
    <th scope="col" class="listTitle" width="5%" nowrap>번호</th>
    <th scope="col" class="listTitle" width="10%" nowrap>제목</th>
   	<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
	    <th scope="col" class="listTitle" width="5%" nowrap>게시시작일</th>
	    <th scope="col" class="listTitle" width="5%" nowrap>게시종료일</th>
   	</c:if>
   	<c:if test="${anonymous != 'true'}">
    	<th scope="col" class="listTitle" width="5%" nowrap>작성자</th>
    </c:if>
    <th scope="col" class="listTitle" width="10%" nowrap>작성일</th>
    <th scope="col" class="listTitle" width="5%" nowrap>조회수</th>
  </tr>
 </thead>

 <tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
	  <tr>
	    <td class="listCenter" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
	    <td class="listLeft" nowrap>
	    	<c:choose>
	    		<c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
			    	<c:if test="${result.replyLc!=0}">
			    		<c:forEach begin="0" end="${result.replyLc}" step="1">
			    			&nbsp;
			    		</c:forEach>
			    		<img src="<c:url value='/images/egovframework/com/cmm/icon/reply_arrow.gif'/>" alt="reply arrow">
			    	</c:if>
	    			<c:out value="${result.nttSj}" />
	    		</c:when>
	    		<c:otherwise>
		    		<form name="subForm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>">
						<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
						<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
						<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				    	<c:if test="${result.replyLc!=0}">
				    		<c:forEach begin="0" end="${result.replyLc}" step="1">
				    			&nbsp;
				    		</c:forEach>
				    		<img src="<c:url value='/images/egovframework/com/cmm/icon/reply_arrow.gif'/>" alt="reply arrow">
				    	</c:if>
			    		<span class="link">
			    			<input type="submit" style="border:solid 0px black;text-align:left;" value="<c:out value="${result.nttSj}"/>" ></span>
			    	</form>
	    		</c:otherwise>
	    	</c:choose>
	    </td>
    	<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
		    <td class="listCenter" nowrap><c:out value="${result.ntceBgnde}"/></td>
		    <td class="listCenter" nowrap><c:out value="${result.ntceEndde}"/></td>
    	</c:if>
    	<c:if test="${anonymous != 'true'}">
	    	<td class="listCenter" nowrap><c:out value="${result.frstRegisterNm}"/></td>
	    </c:if>
	    <td class="listCenter" nowrap><c:out value="${result.frstRegisterPnttm}"/></td>
	    <td class="listCenter" nowrap><c:out value="${result.inqireCo}"/></td>
	  </tr>
	 </c:forEach>
	 <c:if test="${fn:length(resultList) == 0}">
	  <tr>
    	<c:choose>
    		<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
    			<td class="listCenter" colspan="7" ><spring:message code="common.nodata.msg" /></td>
    		</c:when>
    		<c:otherwise>
    			<c:choose>
    				<c:when test="${anonymous == 'true'}">
		    			<td class="listCenter" colspan="4" ><spring:message code="common.nodata.msg" /></td>
		    		</c:when>
		    		<c:otherwise>
		    			<td class="listCenter" colspan="5" ><spring:message code="common.nodata.msg" /></td>
		    		</c:otherwise>
		    	</c:choose>
    		</c:otherwise>
    	</c:choose>
 		  </tr>
	 </c:if>
 </tbody>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="10"></td>
  </tr>
</table>

</div>
</body>
</html>
