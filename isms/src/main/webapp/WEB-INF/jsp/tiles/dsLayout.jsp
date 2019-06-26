<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<% 
	
%>
<!DOCTYPE html>
<html  class="<%=(String)session.getAttribute("skin")%>">
<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		
		<!-- jQuery -->
		<script type="text/javascript" src="<c:url value='/jquery/jquery-1.11.3.js' />"></script>
		<script type="text/javascript" src="<c:url value='/jquery/jquery.mask.min.js' />"></script>
		<%-- 
		<script type="text/javascript" src="<c:url value='/jquery/jquery.placeholder.js' />"></script>
        --%>
        
		<script type="text/javascript" src="<c:url value='/js/exam/tinyfader.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/exam/common.css'/>"/>
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/exam/index.css'/>"/>
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/exam/sub.css'/>"/>
		
		
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/exam/exam.css'/>"/>

	    <!-- jQuery UI 
		<script type="text/javascript"          src="<c:url value='/jquery/jquery-ui/jquery-ui.min.js'/>"></script>
        <link rel="stylesheet" type="text/css" href="<c:url value='/jquery/jquery-ui/jquery-ui.css'/>"/>
        -->
        
        <!-- jQuery UI CUSTOM -->
        <script type="text/javascript"          src="<c:url value='/jquery/jquery-ui-1.11.4.custom/jquery-ui.min.js'/>"></script>
        <link rel="stylesheet" type="text/css" href="<c:url value='/jquery/jquery-ui-1.11.4.custom/jquery-ui.css'/>"/>
        
        
        <script type="text/javascript" src="<c:url value='/jquery/jquery.form.js'/>"></script>
        
        <!-- jQuery Mobile 
		<script type="text/javascript" src="<c:url value='/jquery/jquery-mobile/jquery.mobile-1.4.5.min.js'/>"></script>
        <link rel="stylesheet" type="text/css" href="<c:url value='/jquery/jquery-mobile/jquery.mobile-1.4.5.css'/>"/>
        -->
        
</head>

<tiles:insertAttribute name="content" />
