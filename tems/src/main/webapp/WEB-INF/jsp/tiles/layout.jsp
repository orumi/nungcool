<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%
    LoginUserVO nLoginVO = (LoginUserVO) session.getAttribute("loginUserVO");
    String menuId = (String) session.getAttribute("menuId");

%>
<!DOCTYPE html>
<html class="<%=(String)session.getAttribute("skin")%>">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="description" content="frequently asked questions using tabs and accordions"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>

    <!-- jQuery -->
    <script type="text/javascript" src="<c:url value='/jquery/jquery-1.11.3.js' />"></script>


    <!-- Basic Styles -->
    <link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/bootstrap.min.css' />">
    <link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/font-awesome.min.css' />">

    <!-- SmartAdmin Styles : Caution! DO NOT change the order -->
    <link rel="stylesheet" type="text/css" media="screen"
          href="<c:url value='/bootstrap/css/smartadmin-production-plugins.min.css' />">
    <link rel="stylesheet" type="text/css" media="screen"
          href="<c:url value='/bootstrap/css/smartadmin-production.min.css' />">
    <link rel="stylesheet" type="text/css" media="screen"
          href="<c:url value='/bootstrap/css/smartadmin-skins.min.css' />">

    <!-- SmartAdmin RTL Support  -->
    <link rel="stylesheet" type="text/css" media="screen"
          href="<c:url value='/bootstrap/css/smartadmin-rtl.min.css' />">

    <!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update.
		<link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/your_style.css' />"> -->

    <!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
    <link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/bootstrap/css/demo.min.css' />">

    <!-- FAVICONS
    <link rel="shortcut icon" href="/bootstrap/img/favicon/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/bootstrap/img/favicon/favicon.ico" type="image/x-icon">
     -->

    <!-- GOOGLE FONT -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

    <!-- Specifying a Webpage Icon for Web Clip
         Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
    <link rel="apple-touch-icon" href="<c:url value='/bootstrap/img/splash/sptouch-icon-iphone.png' />">
    <link rel="apple-touch-icon" sizes="76x76" href="<c:url value='/bootstrap/img/splash/touch-icon-ipad.png' />">
    <link rel="apple-touch-icon" sizes="120x120"
          href="<c:url value='/bootstrap/img/splash/touch-icon-iphone-retina.png' />">
    <link rel="apple-touch-icon" sizes="152x152"
          href="<c:url value='/bootstrap/img/splash/touch-icon-ipad-retina.png' />">

    <!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!-- Startup image for web apps -->
    <link rel="apple-touch-startup-image" href="<c:url value='/bootstrap/img/splash/ipad-landscape.png' />"
          media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
    <link rel="apple-touch-startup-image" href="<c:url value='/bootstrap/img/splash/ipad-portrait.png' />"
          media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
    <link rel="apple-touch-startup-image" href="<c:url value='/bootstrap/img/splash/iphone.png' />"
          media="screen and (max-device-width: 320px)">

    <!-- tems styles -->
    <link rel="stylesheet" href="<c:url value='/css/tems/tems.css' />" id="tems"/>

    <script type="text/javascript" src="<c:url value='/script/jszip.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs-lic.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs_eval.1.0.14.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/script/realgridjs-api.1.0.14.js'/>"></script> 

</head>



<body class="">

<header id="header">
    <tiles:insertAttribute name="header"/>
</header>
<!-- END HEADER -->

<!-- content start -->
<aside id="left-panel">

    <!-- User info -->
    <div class="login-info">
				<span> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					<!--  
					<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
						 <img src="<c:url value='/bootstrap/img/avatars/sunny.png'/>" alt="me" class="online" /> --> 
						<span class="online">
							<%=nLoginVO.getName() %> (TFTeam)
						</span>
					<!--  	
						<i class="fa fa-angle-down"></i>
					</a>--> 
					
				</span>
    </div>
    <!-- end user info -->

    <!-- NAVIGATION : This navigation is also responsive-->
    <nav>
        <tiles:insertAttribute name="left"/>
    </nav>
</aside>
<!-- END NAVIGATION -->

<!-- MAIN PANEL -->
<div id="main" role="main">

    <!-- RIBBON -->
    <div id="ribbon">

        <!-- breadcrumb -->
        <ol class="breadcrumb" id="uTag">
            <i class="fa fa-lg fa-fw fa-home"></i>
            <li>종합시험관리 시스템</li>
        </ol>
        <!-- end breadcrumb -->

        <!-- You can also add more buttons to the
        ribbon for further usability

        Example below:

        <span class="ribbon-button-alignment pull-right">
        <span id="search" class="btn btn-ribbon hidden-xs" data-title="search"><i class="fa-grid"></i> Change Grid</span>
        <span id="add" class="btn btn-ribbon hidden-xs" data-title="add"><i class="fa-plus"></i> Add</span>
        <span id="search" class="btn btn-ribbon" data-title="search"><i class="fa-search"></i> <span class="hidden-mobile">Search</span></span>
        </span>
        -->

    </div>
    <!-- END RIBBON -->


    <!-- MAIN CONTENT -->
    <div id="content">

        <tiles:insertAttribute name="content"/>

        <div class="modal fade" id="favoriteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
                        <h4 class="modal-title" id="myModalLabel">즐겨찾기 관리</h4>
                    </div>
                    <div class="modal-body requestBody">    <!-- Modal Body-->
                        <div class="page-content">          <!-- start of content -->
                            <div role="content">
                                <!--  start of  form-horizontal tems_search  -->
                                <!--  start of widget-body -->

                                <!--  end of content -->
                            </div>
                            <!-- -----------------------------------------------------------------------------------  -->

                            <div style="text-align: right">
                                <button id="favoriteDelete" class="btn btn-primary">삭제</button>
                                <button id="favoriteSave" class="btn btn-primary">저장</button>
                            </div>

                            <div class="div-realgrid">
                                <div id="favoriteGrid" style="width: 100%; height: 500px;"></div>
                            </div>


                            <!-- Footer -->
                            <footer>
                            </footer>
                            <!-- Footer End -->
                            <!-- end of realgrid Content -->
                        </div>
                        <!-- -----------------------------------------------------------------------------------  -->
                    </div>
                    <!-- Modal Body End-->
                    <div class="modal-footer">
                        <button id="favoriteAccept" type="button" class="btn btn-default" data-dismiss="modal">확인</button>
                    </div>
                </div>

            </div>
        </div>
    <!-- END MAIN CONTENT -->

</div>
<!-- END MAIN PANEL -->


<!-- PAGE FOOTER -->
<!-- div class="page-footer">  -->
<div>
    <tiles:insertAttribute name="footer"/>
</div>


<!--================================================== -->

<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)-->
<script data-pace-options='{ "restartOnRequestAfter": true }'
        src="<c:url value='/bootstrap/js/plugin/pace/pace.min.js'/>"></script>

<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
    if (!window.jQuery) {
        var txt = "<c:url value='/bootstrap/js/libs/jquery-2.1.1.min.js' />"
        document.write("<script src=" + txt + ">" + "<" + "/script>");
    }
</script>
-->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script>
    if (!window.jQuery.ui) {
        var txt = "<c:url value='/bootstrap/js/libs/jquery-ui-1.10.3.min.js' />"
        document.write("<script src=" + txt + ">" + "<" + "/script>");
    }
</script>

<!-- IMPORTANT: APP CONFIG -->
<script src="<c:url value='/bootstrap/js/app.config.js'/>"></script>

<!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
<script src="<c:url value='/bootstrap/js/plugin/jquery-touch/jquery.ui.touch-punch.min.js'/>"></script>

<!-- BOOTSTRAP JS -->
<script src="<c:url value='/bootstrap/js/bootstrap/bootstrap.min.js'/>"></script>

<!-- CUSTOM NOTIFICATION -->
<script src="<c:url value='/bootstrap/js/notification/SmartNotification.min.js'/>"></script>

<!-- JARVIS WIDGETS -->
<script src="<c:url value='/bootstrap/js/smartwidgets/jarvis.widget.min.js'/>"></script>

<!-- EASY PIE CHARTS -->
<script src="<c:url value='/bootstrap/js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js'/>"></script>

<!-- SPARKLINES -->
<script src="<c:url value='/bootstrap/js/plugin/sparkline/jquery.sparkline.min.js'/>"></script>

<!-- JQUERY VALIDATE -->
<script src="<c:url value='/bootstrap/js/plugin/jquery-validate/jquery.validate.min.js'/>"></script>

<!-- JQUERY MASKED INPUT -->
<script src="<c:url value='/bootstrap/js/plugin/masked-input/jquery.maskedinput.min.js'/>"></script>

<!-- JQUERY SELECT2 INPUT -->
<script src="<c:url value='/bootstrap/js/plugin/select2/select2.min.js'/>"></script>

<!-- JQUERY UI + Bootstrap Slider -->
<script src="<c:url value='/bootstrap/js/plugin/bootstrap-slider/bootstrap-slider.min.js'/>"></script>

<!-- browser msie issue fix -->
<script src="<c:url value='/bootstrap/js/plugin/msie-fix/jquery.mb.browser.min.js'/>"></script>

<!-- FastClick: For mobile devices -->
<script src="<c:url value='/bootstrap/js/plugin/fastclick/fastclick.min.js'/>"></script>

<!--[if IE 8]>

<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>

<![endif]-->

<!-- Demo purpose only -->
<!-- 오른쪽 스킨 설정  -->
<script src="<c:url value='/bootstrap/js/demo.min.js'/>"></script>

<!-- MAIN APP JS FILE -->
<script src="<c:url value='/bootstrap/js/app.min.js'/>"></script>

<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
<!-- Voice command : plugin -->
<script src="<c:url value='/bootstrap/js/speech/voicecommand.min.js'/>"></script>

<!-- SmartChat UI : plugin -->
<script src="<c:url value='/bootstrap/js/smart-chat-ui/smart.chat.ui.min.js'/>"></script>
<script src="<c:url value='/bootstrap/js/smart-chat-ui/smart.chat.manager.min.js'/>"></script>

<!-- PAGE RELATED PLUGIN(S)
<script src="..."></script>-->

<script type="text/javascript">

    $(document).ready(function () {

        /* DO NOT REMOVE : GLOBAL FUNCTIONS!
         *
         * pageSetUp(); WILL CALL THE FOLLOWING FUNCTIONS
         *
         * // activate tooltips
         * $("[rel=tooltip]").tooltip();
         *
         * // activate popovers
         * $("[rel=popover]").popover();
         *
         * // activate popovers with hover states
         * $("[rel=popover-hover]").popover({ trigger: "hover" });
         *
         * // activate inline charts
         * runAllCharts();
         *
         * // setup widgets
         * setup_widgets_desktop();
         *
         * // run form elements
         * runAllForms();
         *
         ********************************
         *
         * pageSetUp() is needed whenever you load a page.
         * It initializes and checks for all basic elements of the page
         * and makes rendering easier.
         *
         */

        pageSetUp();

        changeTheme("<%=(String)session.getAttribute("skin")%>");
        /*
         * ALL PAGE RELATED SCRIPTS CAN GO BELOW HERE
         * eg alert("my home function");
         *
         * var pagefunction = function() {
         *   ...
         * }
         * loadScript("js/plugin/_PLUGIN_NAME_.js", pagefunction);
         *
         * TO LOAD A SCRIPT:
         * var pagefunction = function (){
         *  loadScript(".../plugin.js", run_after_loaded);
         * }
         *
         * OR
         *
         * loadScript(".../plugin.js", run_after_loaded);
         */

    })

</script>

<!-- Your GOOGLE ANALYTICS CODE Below -->
<script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);
    _gaq.push(['_trackPageview']);

    (function () {
        var ga = document.createElement('script');
        ga.type = 'text/javascript';
        ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(ga, s);
    })();

</script>

<script>
    var menu = "<%=menuId%>";
    $("#" + menu).attr("class", "active");
    if ($("#" + menu).parent().attr("class") == "submenu") {
        $("#" + menu).parent().parent().attr("class", "active open");
        var tval = $("#" + menu).attr("tval");
        $("#uTag").html(tval);


    }

    if ($("#" + menu).parent().parent().parent().attr("class") == "submenu") {
        $("#" + menu).parent().parent().parent().parent().attr("class", "active open");
        var tval = $("#" + menu).attr("tval");
        $("#uTag").html(tval);
    }

    /* $(".menu-text").click(function(event){
     var tval= $(this).attr("tval");
     $("#contentsTitle").text(tval);
     //alert(tval);
     alert($("#contentsTitle").text(tval));
     }); */

    function entkey() {
        if (event.keyCode == 13) {
            goLogin(); // 로그인 메소드 실행
        }
    }

    function fn_styleSetup(style) {
        var skin = style.attr("id");
        var adminid = "<%=nLoginVO.getAdminid()%>"
        $.ajax({
            type: "post",
            dataType: "json",
            data: {"skin": skin, "adminid": adminid},
            url: "<c:url value='/login/edtUserSkin.json'/>",
            success: function (result) {
            },
            error: function (xhr, status, error, data) {
                $("#loadResult").css("color", "red").text("Load failed: " + error).show();
            }
        });
    }

</script>
</body>
</html>
