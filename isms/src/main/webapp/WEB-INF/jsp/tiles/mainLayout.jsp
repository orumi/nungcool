<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<% 
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<title> ISMS SYSYEM </title>
		<meta name="description" content="">
		<meta name="author" content="">
			
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		
		<!-- #CSS Links -->
		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/bootstrap.min.css'/> ">
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/font-awesome.min.css'/> ">

		<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/smartadmin-production-plugins.min.css'/> ">
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/smartadmin-production.min.css'/> ">
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/smartadmin-skins.min.css'/> ">

		<!-- SmartAdmin RTL Support -->
		<%-- <link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/smartadmin-rtl.min.css'/> ">  --%>

		<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/demo.min.css'/> ">

		<!-- #FAVICONS -->
		<link rel="shortcut icon" href="<c:url value='/bootstrap/img/favicon/favicon.ico'/> " type="image/x-icon">
		<link rel="icon" href="<c:url value='/bootstrap/img/favicon/favicon.ico'/> " type="image/x-icon">

		<!-- #GOOGLE FONT -->
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

		<!-- #APP SCREEN / ICONS -->
		<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="<c:url value='/bootstrap/img/splash/sptouch-icon-iphone.png'/> ">
		<link rel="apple-touch-icon" sizes="76x76" href="<c:url value='/bootstrap/img/splash/touch-icon-ipad.png'/>">
		<link rel="apple-touch-icon" sizes="120x120" href="<c:url value='/bootstrap/img/splash/touch-icon-iphone-retina.png'/>">
		<link rel="apple-touch-icon" sizes="152x152" href="<c:url value='/bootstrap/img/splash/touch-icon-ipad-retina.png'/>">
		
		<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="<c:url value='/bootstrap/img/splash/ipad-landscape.png'/> " media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="<c:url value='/bootstrap/img/splash/ipad-portrait.png'/> " media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="<c:url value='/bootstrap/img/splash/iphone.png'/> " media="screen and (max-device-width: 320px)">

		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
		<script src="<c:url value='/bootstrap/js/libs/jquery-2.1.1.min.js'/> "></script>
		<script src="<c:url value='/bootstrap/js/libs/jquery-ui-1.10.3.min.js'/> "></script>
		
		
	</head>

	<!--

	TABLE OF CONTENTS.
	
	Use search to find needed section.
	
	===================================================================
	
	|  01. #CSS Links                |  all CSS links and file paths  |
	|  02. #FAVICONS                 |  Favicon links and file paths  |
	|  03. #GOOGLE FONT              |  Google font link              |
	|  04. #APP SCREEN / ICONS       |  app icons, screen backdrops   |
	|  05. #BODY                     |  body tag                      |
	|  06. #HEADER                   |  header tag                    |
	|  07. #PROJECTS                 |  project lists                 |
	|  08. #TOGGLE LAYOUT BUTTONS    |  layout buttons and actions    |
	|  09. #MOBILE                   |  mobile view dropdown          |
	|  10. #SEARCH                   |  search field                  |
	|  11. #NAVIGATION               |  left panel & navigation       |
	|  12. #MAIN PANEL               |  main panel                    |
	|  13. #MAIN CONTENT             |  content holder                |
	|  14. #PAGE FOOTER              |  page footer                   |
	|  15. #SHORTCUT AREA            |  dropdown shortcuts area       |
	|  16. #PLUGINS                  |  all scripts and plugins       |
	
	===================================================================
	
	-->
	
	<!-- #BODY -->
	<!-- Possible Classes

		* 'smart-style-{SKIN#}'
		* 'smart-rtl'         - Switch theme mode to RTL
		* 'menu-on-top'       - Switch to top navigation (no DOM change required)
		* 'no-menu'			  - Hides the menu completely
		* 'hidden-menu'       - Hides the main menu but still accessable by hovering over left edge
		* 'fixed-header'      - Fixes the header
		* 'fixed-navigation'  - Fixes the main menu
		* 'fixed-ribbon'      - Fixes breadcrumb
		* 'fixed-page-footer' - Fixes footer
		* 'container'         - boxed layout mode (non-responsive: will not work with fixed-navigation & fixed-ribbon)
	-->
	<body class="" style="overflow:hidden;">

		<tiles:insertAttribute name="header" />
		

		<tiles:insertAttribute name="left" />

		<!-- MAIN PANEL -->
		<tiles:insertAttribute name="content" />
		<!-- END MAIN PANEL -->

		<tiles:insertAttribute name="footer" />

		<!-- SHORTCUT AREA : With large tiles (activated via clicking user name tag)
		Note: These tiles are completely responsive,
		you can add as many as you like
		-->
		

		<!--================================================== -->

		<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)-->
		<script data-pace-options='{ "restartOnRequestAfter": true }' src="<c:url value='/bootstrap/js/plugin/pace/pace.min.js'/> "></script>



		<!-- IMPORTANT: APP CONFIG -->
		<script src="<c:url value='/bootstrap/js/app.config.js'/> "></script>

		<!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
		<%-- <script src="<c:url value='/bootstrap/js/plugin/jquery-touch/jquery.ui.touch-punch.min.js'/> "></script> --%> 

		<!-- BOOTSTRAP JS -->
		<script src="<c:url value='/bootstrap/js/bootstrap/bootstrap.min.js'/> "></script>

		<!-- CUSTOM NOTIFICATION -->
		<%-- <script src="<c:url value='/bootstrap/js/notification/SmartNotification.min.js'/> "></script> --%>

		<!-- JARVIS WIDGETS -->
		<script src="<c:url value='/bootstrap/js/smartwidgets/jarvis.widget.min.js'/> "></script>

		<!-- EASY PIE CHARTS -->
		<script src="<c:url value='/bootstrap/js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js'/> "></script>

		<!-- SPARKLINES -->
		<script src="<c:url value='/bootstrap/js/plugin/sparkline/jquery.sparkline.min.js'/> "></script>

		<!-- JQUERY VALIDATE -->
		<script src="<c:url value='/bootstrap/js/plugin/jquery-validate/jquery.validate.min.js'/> "></script>

		<!-- JQUERY MASKED INPUT -->
		<script src="<c:url value='/bootstrap/js/plugin/masked-input/jquery.maskedinput.min.js'/> "></script>

		<!-- JQUERY SELECT2 INPUT -->
		<%-- <script src="<c:url value='/bootstrap/js/plugin/select2/select2.min.js'/> "></script> --%>

		<!-- JQUERY UI + Bootstrap Slider -->
<%-- 		<script src="<c:url value='/bootstrap/js/plugin/bootstrap-slider/bootstrap-slider.min.js'/> "></script> --%>

		<!-- browser msie issue fix -->
<%-- 		<script src="<c:url value='/bootstrap/js/plugin/msie-fix/jquery.mb.browser.min.js'/> "></script> --%>

		<!-- FastClick: For mobile devices -->
<%-- 		<script src="<c:url value='/bootstrap/js/plugin/fastclick/fastclick.min.js'/> "></script> --%>

		<!--[if IE 8]>

		<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>

		<![endif]-->

		<!-- Demo purpose only -->
		<%-- <script src="<c:url value='/bootstrap/js/demo.min.js'/> "></script> --%>

		<!-- MAIN APP JS FILE -->
		<script src="<c:url value='/bootstrap/js/app.min.js'/> "></script>

		<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
		<!-- Voice command : plugin -->
		<%-- <script src="<c:url value='/bootstrap/js/speech/voicecommand.min.js'/> "></script> --%>

		<!-- SmartChat UI : plugin -->
		<script src="<c:url value='/bootstrap/js/smart-chat-ui/smart.chat.ui.min.js'/> "></script>
		<script src="<c:url value='/bootstrap/js/smart-chat-ui/smart.chat.manager.min.js'/> "></script>

		<!-- PAGE RELATED PLUGIN(S) 
		<script src="..."></script>-->
		<script src="<c:url value='/bootstrap/js/plugin/chartjs/chart.min.js'/> "></script>

		<script type="text/javascript">

			$(document).ready(function() {
			 	
				 pageSetUp();
				 
				 $('#tabs').tabs();
			})
		
		</script>

		<!-- Your GOOGLE ANALYTICS CODE Below -->
		<script type="text/javascript">
			var _gaq = _gaq || [];
				_gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);
				_gaq.push(['_trackPageview']);
			
			(function() {
				var ga = document.createElement('script');
				ga.type = 'text/javascript';
				ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0];
				s.parentNode.insertBefore(ga, s);
			})();

		</script>

	</body>

</html>