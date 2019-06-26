<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : UserMasterList.jsp
  * @Description : UserMaster List 화면
  * @Modification Information
  * 
  * @author test
  * @since 20150923
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>목록</title>



<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(tblUserId) {
	document.getElementById("listForm").tblUserId.value = tblUserId;
   	document.getElementById("listForm").action = "<c:url value='/userMaster/updateUserMasterView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.getElementById("listForm").action = "<c:url value='/userMaster/addUserMasterView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/userMaster/UserMasterList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<input type="hidden" name="tblUserId" />
<div id="content_pop">
<div role="main" class="ui-content jqm-content">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt="title" /> List </li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<!-- List -->
	<div id="table">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
							</colgroup>		  
			<tr>
								<th align="center">TblUserName</th>
								<th align="center">TblBirth</th>
								<th align="center">TblAuthority</th>
								<th align="center">TblEName</th>
								<th align="center">TblCName</th>
								<th align="center">TblUserId</th>
								<th align="center">TblUserPw</th>
								<th align="center">TblJikwiCode</th>
								<th align="center">TblPositionCode</th>
								<th align="center">TblTeamCode</th>
								<th align="center">TblEmail</th>
								<th align="center">TblTel</th>
								<th align="center">TblZipcode</th>
								<th align="center">TblAddress1</th>
								<th align="center">TblAddress2</th>
								<th align="center">TblHandyuid</th>
								<th align="center">TblMajor</th>
								<th align="center">TblUseYn</th>
								<th align="center">TblSysmuser</th>
								<th align="center">TblSysmdate</th>
								<th align="center">TblUpduser</th>
								<th align="center">TblUpddate</th>
								<th align="center">TblFileImg</th>
								<th align="center">TblKolasJikwi</th>
								<th align="center">TblPortalId</th>
								<th align="center">MssqlGubun</th>
								<th align="center">MssqlUid</th>
								<th align="center">TblLastIp</th>
								<th align="center">TblLastDate</th>
								<th align="center">Mssql70Uid</th>
								<th align="center">TblSign</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
													<td align="center" class="listtd"><c:out value="${result.tblUserName}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblBirth}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblAuthority}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblEName}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblCName}"/>&nbsp;</td>
						<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.tblUserId}"/>')"><c:out value="${result.tblUserId}"/></a>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblUserPw}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblJikwiCode}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblPositionCode}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblTeamCode}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblEmail}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblTel}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblZipcode}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblAddress1}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblAddress2}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblHandyuid}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblMajor}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblUseYn}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblSysmuser}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblSysmdate}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblUpduser}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblUpddate}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblFileImg}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblKolasJikwi}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblPortalId}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.mssqlGubun}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.mssqlUid}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblLastIp}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblLastDate}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.mssql70Uid}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.tblSign}"/>&nbsp;</td>
				    			</tr>
			</c:forEach>
		</table>
	</div>
	<!-- /List -->
	<div id="paging" align="center" class="paginate">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="image"
				   jsFunction="fn_egov_link_page"
				   />
		<form:hidden path="pageIndex" />
	</div>
	<div id="sysbtn1">
		<ul>
			<li>
				<div id="sysbtn">
				<div><a href="javascript:fn_egov_addView();" class="ui-btn ui-shadow ui-corner-all ui-btn-inline ui-mini" data-theme="a"> 등록 </a></div>
					<span class="btn_blue_l"><a href="javascript:fn_egov_addView();">등록</a><img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt="" />
					</span>
				</div>
			</li>
		</ul>
	</div>
</div>	
</div>
</form:form>
</body>
</html>
