<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <link rel="stylesheet" href="../../resource/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="../../resource/jqwidgets/styles/jqx.light.css" type="text/css" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />

	<script src="<c:url value='/bootstrap/js/libs/jquery-2.1.1.min.js'/> "></script>

	<%-- <script type="text/javascript" src="<c:url value='/jqwidgets/scripts/jquery-1.12.4.min.js'/> "></script> --%>
	<script src="<c:url value='/jsp/svg/js/MoveAndResizeTool.js'/>"></script>
	<script src="<c:url value='/jsp/svg/js/svgController.js'/> "></script>


    <script type="text/javascript" src="<c:url value='/resource/jqwidgets/scripts/demos.js'/> "></script>
    <script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcore.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxbuttons.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxscrollbar.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxpanel.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxtree.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxdragdrop.js'/> "></script>
    <script type="text/javascript" src="<c:url value='/resource/jqwidgets/jqxcheckbox.js'/> "></script>

    <script type="text/javascript">
        $(document).ready(function () {
            // Create jqxTree
            var source = [
                { icon: "<c:url value='/resource/jqwidgets/images/mailIcon.png'/>", label: "Mail", expanded: true, items: [
                    { icon: "<c:url value='/resource/jqwidgets/images/calendarIcon.png'/>", label: "Calendar" },
                    { icon: "<c:url value='/resource/jqwidgets/images/contactsIcon.png'/>", label: "Contacts", selected: true }
                ]
                },
                { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Inbox", expanded: true, items: [
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Admin" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Corporate" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Finance" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Other" },
                ]
                },
                { icon: "<c:url value='/resource/jqwidgets/images/recycle.png'/>", label: "Deleted Items" },
                { icon: "<c:url value='/resource/jqwidgets/images/notesIcon.png'/>", label: "Notes" },
                { iconsize: 14, icon: "<c:url value='/resource/jqwidgets/images/settings.png'/>", label: "Settings" },
                { icon: "<c:url value='/resource/jqwidgets/images/favorites.png'/>", label: "Favorites" },
                { icon: "<c:url value='/resource/jqwidgets/images/mailIcon.png'/>", label: "Mail", expanded: true, items: [
                    { icon: "<c:url value='/resource/jqwidgets/images/calendarIcon.png'/>", label: "Calendar" },
                    { icon: "<c:url value='/resource/jqwidgets/images/contactsIcon.png'/>", label: "Contacts", selected: true }
                ]
                },
                { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Inbox", expanded: true, items: [
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Admin" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Corporate" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Finance" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Other" },
                ]
                },
                { icon: "<c:url value='/resource/jqwidgets/images/recycle.png'/>", label: "Deleted Items" },
                { icon: "<c:url value='/resource/jqwidgets/images/notesIcon.png'/>", label: "Notes" },
                { iconsize: 14, icon: "<c:url value='/resource/jqwidgets/images/settings.png'/>", label: "Settings" },
                { icon: "<c:url value='/resource/jqwidgets/images/favorites.png'/>", label: "Favorites" },
                { icon: "<c:url value='/resource/jqwidgets/images/mailIcon.png'/>", label: "Mail", expanded: true, items: [
                    { icon: "<c:url value='/resource/jqwidgets/images/calendarIcon.png'/>", label: "Calendar" },
                    { icon: "<c:url value='/resource/jqwidgets/images/contactsIcon.png'/>", label: "Contacts", selected: true }
                ]
                },
                { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Inbox", expanded: true, items: [
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Admin" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Corporate" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Finance" },
                   { icon: "<c:url value='/resource/jqwidgets/images/folder.png'/>", label: "Other" },
                ]
                },
                { icon: "<c:url value='/resource/jqwidgets/images/recycle.png'/>", label: "Deleted Items" },
                { icon: "<c:url value='/resource/jqwidgets/images/notesIcon.png'/>", label: "Notes" },
                { iconsize: 14, icon: "<c:url value='/resource/jqwidgets/images/settings.png'/>", label: "Settings" },
                { icon: "<c:url value='/resource/jqwidgets/images/favorites.png'/>", label: "Favorites" },
             ];

            // create jqxTree
            $('#jqxTree').jqxTree({
            	allowDrag: true,
            	allowDrop: true,
            	source: source,
            	width: '250px',
            	dragStart: function (item) {
                    if (item.label == "Community")
                        return false;
                }
            });

            $("#jqxTree").on('dragStart', function (event) {
                console.log("dragStart :"+ event.args.label);
            });


            $("#jqxTree").on('dragEnd', function (event) {
            	 if (event.args.label) {
            		 var ev = event.args.originalEvent;
                     var x = ev.pageX;
                     var y = ev.pageY;

                     if (event.args.originalEvent && event.args.originalEvent.originalEvent && event.args.originalEvent.originalEvent.touches) {
                         var touch = event.args.originalEvent.originalEvent.changedTouches[0];
                         x = touch.pageX;
                         y = touch.pageY;
                     }

                     console.log("X:"+x);


                     var offset = $("#section").offset();
                     var width = $("#section").width();
                     var height = $("#section").height();
                     var right = parseInt(offset.left) + width;
                     var bottom = parseInt(offset.top) + height;

                     console.log("offset :: left : "+parseInt(offset.left)+" top : "+parseInt(offset.top)+" label : "+event.args.label);
                     console.log("offset :: width : "+width+" height : "+height+" label : "+event.args.label);
                     console.log("offset :: right : "+right+" bottom : "+bottom+" label : "+event.args.label);

                     if (x >= parseInt(offset.left) && x <= right) {
                         if (y >= parseInt(offset.top) && y <= bottom) {
                        	 var ix = x-parseInt(offset.left);
                        	 var iy = y-parseInt(offset.top);
                        	 console.log("MX : "+ix+" MY : "+iy+" label : "+event.args.label);
                        	 addSVGObject(ix,iy,event.args.label);
                         }
                     }

            	 }
            });

            // on to 'expand', 'collapse' and 'select' events.
            $('#jqxTree').on('expand', function (event) {
                var args = event.args;
                var item = $('#jqxTree').jqxTree('getItem', args.element);

                console.log("item.label : "+item.label);
                //$('#Events').jqxPanel('prepend', '<div style="margin-top: 5px;">Expanded: ' + item.label + '</div>');
            });
            $('#jqxTree').on('collapse', function (event) {
                var args = event.args;
                var item = $('#jqxTree').jqxTree('getItem', args.element);

                console.log("item.label : "+item.label);
                //$('#Events').jqxPanel('prepend', '<div style="margin-top: 5px;">Collapsed: ' + item.label + '</div>');
            });
            $('#jqxTree').on('select', function (event) {
                var args = event.args;
                var item = $('#jqxTree').jqxTree('getItem', args.element);

                console.log("item.label : "+item.label);
                //$('#Events').jqxPanel('prepend', '<div style="margin-top: 5px;">Selected: ' + item.label + '</div>');
            });
        });
    </script>

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
  		width:250px;
  		z-index:901;
  		padding-top:50px;
  		border:0px solid #c1c1c1;
  	}

  	#section {
  		position:absolute;
  		top:50px;
  		left:250px;
  		right:0px;
  		bottom:40px;
  		overflow: scroll;
  		border:1px solid #c1c1c1;

  	}

  	#footer {
  		position:absolute;
  		display:block;
  		right:0px;
  		left:250px;
  		bottom:0px;
  		height:40px;
  		z-index:900;
  		border:1px solid #c1c1c1;
  	}

  	.col-md {
  		padding:8 4px;
  		margin:2px;
  	}

  </style>
</head>
<body>
	<header id="header" >
		<div class="col-md" style="padding-right: 1px;display:inline-block;">
                <div style="padding:0 4px; font-size: 12px; display:inline-block;">기준년도</div>
                <select style="width:120px;">
                	<option value="Y">Y</option>
                	<option value="N">N</option>
                </select>
        </div>
        <div class="col-md" style="padding-right: 1px;display:inline-block;">
                <div style="padding:0 4px; font-size: 12px; display:inline-block;">조직명칭</div>
                <select style="width:320px;">
                	<option value="Y">Y</option>
                	<option value="N">N</option>
                </select>
                <button> 저장 </button>
        </div>
        <div class="col-md" style="padding-right: 1px;display:inline-block;">
                <button> 속성 </button>
                <button> 새로만들기 </button>
        </div>
	</header>

	<aside id="aside">
	<!-- <a href="javascript:addSVGObject();">addIcon</a>	 -->
		<div id='jqxTree' style='float: left; '>
        </div>
	</aside>

	<section id="section">

		<div id="divCompus" style="display: table-cell;">
			compuscompus
			compus
			compus
			compus
			compus
		</div>
	</section>

	 <footer id="footer">
	 	footer
	 </footer>

</body>
</html>