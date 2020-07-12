<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<script src="<c:url value='/bootstrap/js/libs/jquery-2.1.1.min.js'/> "></script>
<script src="<c:url value='/jsp/svg/js/MoveAndResizeTool.js'/> "></script>
<script src="<c:url value='/jsp/svg/js/svgController.js'/> "></script>
  
  <title>Document</title>
  <style type="text/css">
  	
  	html, body {
		height:100%;
  		padding: 0;
  		margin: 0;
  	}
  	
  	#header {
  		position:relative;
  		display:block;
  		height:50px;
  		margin:0;
  		z-index:909;
  		border:1px solid #c1c1c1;
  	}
  	
  	#aside {
  		position:absolute;
  		display:block;
  		top:0;
  		left:0;
  		bottom:0;
  		width:220px;
  		z-index:901;
  		padding-top:50px;
  		border:1px solid #c1c1c1;
  	}
  	
  	#section {
  		position:absolute;
  		top:50px;
  		left:220px;
  		right:2px;
  		bottom:40px;
  		overflow: scroll;
  		border:1px solid red;
  		
  	}
  	
  	#footer {
  		position:absolute;
  		display:block;
  		right:2px;
  		left:220px;
  		bottom:0px;
  		height:40px;
  		z-index:903;
  		border:1px solid blue;
  	}
  </style>
</head>
<body>
	<header id="header">
		headerheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheader
		headerheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheaderheader
	</header>
	
	<aside id="aside">
	<a href="javascript:addSVGObject();">addIcon</a>	   
		left
	</aside>
	
	<section id="section">
	
		<div id="divCompus" style="display: table-cell;">
			compus
		</div>
	</section>
	
	 <footer id="footer">
	 	footer
	 </footer> 
	  
</body>
</html>