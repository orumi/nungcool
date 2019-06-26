<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : UserMasterRegister.jsp
  * @Description : UserMaster Register 화면
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

<c:set var="registerFlag" value="${empty userMasterVO.tblUserId ? '등록' : '수정'}"/>

<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script -->
<!-- validator:javascript formName="userMasterVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/userMaster/UserMasterList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/userMaster/deleteUserMaster.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
  	frm.action = "<c:url value="${registerFlag == '등록' ? '/userMaster/addUserMaster.do' : '/userMaster/updateUserMaster.do'}"/>";
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="userMasterVO" name="detailForm" id="detailForm" >
<div id="content_pop">
<div role="main" class="ui-content jqm-content">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt="" /><c:out value="${registerFlag}"/></li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<div id="table">
	<table width="100%" border="1" cellpadding="0" cellspacing="0" >
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
			
		<c:if test="${registerFlag == '수정'}">
	   <tr>
			<th>TBL_USER_ID *</th>
			<td>
				<form:input path="tblUserId" cssClass="essentiality" readonly="true" />
			</td>			
		</tr>	
		</c:if>
		<c:if test="${registerFlag == '등록'}">
	   <tr>
			<th>TBL_USER_ID *</th>
			<td>
				<form:input path="tblUserId" cssClass="txt" readonly="false" />
			</td>			
		</tr>	
		</c:if>		
		<tr>
			<th>TBL_USER_NAME</th>
			<td>
				<form:input path="tblUserName" cssClass="txt"/>
				&nbsp;<form:errors path="tblUserName" />
			</td>
		</tr>	
		<tr>
			<th>TBL_BIRTH</th>
			<td>
				<form:input path="tblBirth" cssClass="txt"/>
				&nbsp;<form:errors path="tblBirth" />
			</td>
		</tr>	
		<tr>
			<th>TBL_AUTHORITY</th>
			<td>
				<form:input path="tblAuthority" cssClass="txt"/>
				&nbsp;<form:errors path="tblAuthority" />
			</td>
		</tr>	
		<tr>
			<th>TBL_E_NAME</th>
			<td>
				<form:input path="tblEName" cssClass="txt"/>
				&nbsp;<form:errors path="tblEName" />
			</td>
		</tr>	
		<tr>
			<th>TBL_C_NAME</th>
			<td>
				<form:input path="tblCName" cssClass="txt"/>
				&nbsp;<form:errors path="tblCName" />
			</td>
		</tr>	
		<tr>
			<th>TBL_USER_PW</th>
			<td>
				<form:input path="tblUserPw" cssClass="txt"/>
				&nbsp;<form:errors path="tblUserPw" />
			</td>
		</tr>	
		<tr>
			<th>TBL_JIKWI_CODE</th>
			<td>
				<form:input path="tblJikwiCode" cssClass="txt"/>
				&nbsp;<form:errors path="tblJikwiCode" />
			</td>
		</tr>	
		<tr>
			<th>TBL_POSITION_CODE</th>
			<td>
				<form:input path="tblPositionCode" cssClass="txt"/>
				&nbsp;<form:errors path="tblPositionCode" />
			</td>
		</tr>	
		<tr>
			<th>TBL_TEAM_CODE</th>
			<td>
				<form:input path="tblTeamCode" cssClass="txt"/>
				&nbsp;<form:errors path="tblTeamCode" />
			</td>
		</tr>	
		<tr>
			<th>TBL_EMAIL</th>
			<td>
				<form:input path="tblEmail" cssClass="txt"/>
				&nbsp;<form:errors path="tblEmail" />
			</td>
		</tr>	
		<tr>
			<th>TBL_TEL</th>
			<td>
				<form:input path="tblTel" cssClass="txt"/>
				&nbsp;<form:errors path="tblTel" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ZIPCODE</th>
			<td>
				<form:input path="tblZipcode" cssClass="txt"/>
				&nbsp;<form:errors path="tblZipcode" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ADDRESS1</th>
			<td>
				<form:input path="tblAddress1" cssClass="txt"/>
				&nbsp;<form:errors path="tblAddress1" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ADDRESS2</th>
			<td>
				<form:input path="tblAddress2" cssClass="txt"/>
				&nbsp;<form:errors path="tblAddress2" />
			</td>
		</tr>	
		<tr>
			<th>TBL_HANDYUID</th>
			<td>
				<form:input path="tblHandyuid" cssClass="txt"/>
				&nbsp;<form:errors path="tblHandyuid" />
			</td>
		</tr>	
		<tr>
			<th>TBL_MAJOR</th>
			<td>
				<form:input path="tblMajor" cssClass="txt"/>
				&nbsp;<form:errors path="tblMajor" />
			</td>
		</tr>	
		<tr>
			<th>TBL_USE_YN</th>
			<td>
				<form:input path="tblUseYn" cssClass="txt"/>
				&nbsp;<form:errors path="tblUseYn" />
			</td>
		</tr>	
		<tr>
			<th>TBL_SYSMUSER</th>
			<td>
				<form:input path="tblSysmuser" cssClass="txt"/>
				&nbsp;<form:errors path="tblSysmuser" />
			</td>
		</tr>	
		<tr>
			<th>TBL_SYSMDATE</th>
			<td>
				<form:input path="tblSysmdate" cssClass="txt"/>
				&nbsp;<form:errors path="tblSysmdate" />
			</td>
		</tr>	
		<tr>
			<th>TBL_UPDUSER</th>
			<td>
				<form:input path="tblUpduser" cssClass="txt"/>
				&nbsp;<form:errors path="tblUpduser" />
			</td>
		</tr>	
		<tr>
			<th>TBL_UPDDATE</th>
			<td>
				<form:input path="tblUpddate" cssClass="txt"/>
				&nbsp;<form:errors path="tblUpddate" />
			</td>
		</tr>	
		<tr>
			<th>TBL_FILE_IMG</th>
			<td>
				<form:input path="tblFileImg" cssClass="txt"/>
				&nbsp;<form:errors path="tblFileImg" />
			</td>
		</tr>	
		<tr>
			<th>TBL_KOLAS_JIKWI</th>
			<td>
				<form:input path="tblKolasJikwi" cssClass="txt"/>
				&nbsp;<form:errors path="tblKolasJikwi" />
			</td>
		</tr>	
		<tr>
			<th>TBL_PORTAL_ID</th>
			<td>
				<form:input path="tblPortalId" cssClass="txt"/>
				&nbsp;<form:errors path="tblPortalId" />
			</td>
		</tr>	
		<tr>
			<th>MSSQL_GUBUN</th>
			<td>
				<form:input path="mssqlGubun" cssClass="txt"/>
				&nbsp;<form:errors path="mssqlGubun" />
			</td>
		</tr>	
		<tr>
			<th>MSSQL_UID</th>
			<td>
				<form:input path="mssqlUid" cssClass="txt"/>
				&nbsp;<form:errors path="mssqlUid" />
			</td>
		</tr>	
		<tr>
			<th>TBL_LAST_IP</th>
			<td>
				<form:input path="tblLastIp" cssClass="txt"/>
				&nbsp;<form:errors path="tblLastIp" />
			</td>
		</tr>	
		<tr>
			<th>TBL_LAST_DATE</th>
			<td>
				<form:input path="tblLastDate" cssClass="txt"/>
				&nbsp;<form:errors path="tblLastDate" />
			</td>
		</tr>	
		<tr>
			<th>MSSQL70_UID</th>
			<td>
				<form:input path="mssql70Uid" cssClass="txt"/>
				&nbsp;<form:errors path="mssql70Uid" />
			</td>
		</tr>	
		<tr>
			<th>TBL_SIGN</th>
			<td>
				<form:input path="tblSign" cssClass="txt"/>
				&nbsp;<form:errors path="tblSign" />
			</td>
		</tr>	
	</table>
  </div>
	<div id="sysbtn">
		<ul>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_selectList();">List</a><img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt="" /></span></li>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></a><img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt="" /></span></li>
			<c:if test="${registerFlag == '수정'}">
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_delete();">삭제</a><img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt="" /></span></li>
			</c:if>
			<li><span class="btn_blue_l"><a href="javascript:document.detailForm.reset();">Reset</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
	
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

