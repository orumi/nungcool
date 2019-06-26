<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : TestItemRegister.jsp
  * @Description : TestItem Register 화면
  * @Modification Information
  * 
  * @author test
  * @since 1
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

<c:set var="registerFlag" value="${empty testItemVO.tblItemCode ? '등록' : '수정'}"/>

<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script -->
<!-- validator:javascript formName="testItemVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/testItem/TestItemList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/testItem/deleteTestItem.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
	
  	frm.action = "<c:url value="${registerFlag == '등록' ? '/testItem/addTestItem.do' : '/testItem/updateTestItem.do'}"/>";
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="testItemVO" name="detailForm" id="detailForm" >
<div id="content_pop">
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
			<th>TBL_ITEM_CODE *</th>
			<td>
				<form:input path="tblItemCode" cssClass="essentiality" readonly="true" />
			</td>			
		</tr>	
		</c:if>
		<c:if test="${registerFlag == '등록'}">
	   <tr>
			<th>TBL_ITEM_CODE *</th>
			<td>
				<form:input path="tblItemCode" cssClass="txt" readonly="false" />
			</td>			
		</tr>	
		</c:if>		
		<tr>
			<th>TBL_ITEM_NAME</th>
			<td>
				<form:input path="tblItemName" cssClass="txt"/>
				&nbsp;<form:errors path="tblItemName" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ITEM_ENAME</th>
			<td>
				<form:input path="tblItemEname" cssClass="txt"/>
				&nbsp;<form:errors path="tblItemEname" />
			</td>
		</tr>	
		<tr>
			<th>TBL_S_ITEM_CODE</th>
			<td>
				<form:input path="tblSItemCode" cssClass="txt"/>
				&nbsp;<form:errors path="tblSItemCode" />
			</td>
		</tr>	
		<tr>
			<th>TBL_USER_ID</th>
			<td>
				<form:input path="tblUserId" cssClass="txt"/>
				&nbsp;<form:errors path="tblUserId" />
			</td>
		</tr>	
		<tr>
			<th>TBL_REPORTCLASSCODE</th>
			<td>
				<form:input path="tblReportclasscode" cssClass="txt"/>
				&nbsp;<form:errors path="tblReportclasscode" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ENDTERM</th>
			<td>
				<form:input path="tblEndterm" cssClass="txt"/>
				&nbsp;<form:errors path="tblEndterm" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ENDTERM_K</th>
			<td>
				<form:input path="tblEndtermK" cssClass="txt"/>
				&nbsp;<form:errors path="tblEndtermK" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ENDTERM_J</th>
			<td>
				<form:input path="tblEndtermJ" cssClass="txt"/>
				&nbsp;<form:errors path="tblEndtermJ" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ENDTERM_C</th>
			<td>
				<form:input path="tblEndtermC" cssClass="txt"/>
				&nbsp;<form:errors path="tblEndtermC" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ENDTERM_G</th>
			<td>
				<form:input path="tblEndtermG" cssClass="txt"/>
				&nbsp;<form:errors path="tblEndtermG" />
			</td>
		</tr>	
		<tr>
			<th>TBL_TESTMETHOD</th>
			<td>
				<form:input path="tblTestmethod" cssClass="txt"/>
				&nbsp;<form:errors path="tblTestmethod" />
			</td>
		</tr>	
		<tr>
			<th>TBL_REFERENCEBOOK</th>
			<td>
				<form:input path="tblReferencebook" cssClass="txt"/>
				&nbsp;<form:errors path="tblReferencebook" />
			</td>
		</tr>	
		<tr>
			<th>TBL_GUBUN</th>
			<td>
				<form:input path="tblGubun" cssClass="txt"/>
				&nbsp;<form:errors path="tblGubun" />
			</td>
		</tr>	
		<tr>
			<th>TBL_ORDERBY</th>
			<td>
				<form:input path="tblOrderby" cssClass="txt"/>
				&nbsp;<form:errors path="tblOrderby" />
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
			<th>TBL_FUPDUSER</th>
			<td>
				<form:input path="tblFupduser" cssClass="txt"/>
				&nbsp;<form:errors path="tblFupduser" />
			</td>
		</tr>	
		<tr>
			<th>TBL_FUPDDATE</th>
			<td>
				<form:input path="tblFupddate" cssClass="txt"/>
				&nbsp;<form:errors path="tblFupddate" />
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
			<th>MSSQL_TESTITEMCODE</th>
			<td>
				<form:input path="mssqlTestitemcode" cssClass="txt"/>
				&nbsp;<form:errors path="mssqlTestitemcode" />
			</td>
		</tr>	
		<tr>
			<th>MSSQL_S_TESTITEMCODE</th>
			<td>
				<form:input path="mssqlSTestitemcode" cssClass="txt"/>
				&nbsp;<form:errors path="mssqlSTestitemcode" />
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
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

