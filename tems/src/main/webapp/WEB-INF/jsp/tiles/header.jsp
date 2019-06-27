<%@ page import="tems.com.login.model.FavoriteVO" %>
<%@ page import="java.util.List" %>
<%@ page import="tems.com.login.model.LoginUserVO" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
    String menuId = (String) session.getAttribute("menuId");

    LoginUserVO loginUserVO = (LoginUserVO) session.getAttribute("loginUserVO");
    String userID = loginUserVO.getAdminid();
%>
<script src="<c:url value='/script/datePicker/datePicker.js'/>"></script>
<script src="<c:url value='/script/realGrid/realGridStyles.js'/>"></script>
<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<script type="text/javaScript" language="javascript" defer="defer">


    var favoriteDataProvider;
    var favoriteGridView;


    $(function () {
        $("#favoriteDelete").click(favoriteDelete);
        $("#favoriteSave").click(favoriteSave);
        $("#favoriteAccept").click(refresh);
    })

    function favoriteDelete() {
        var rows = favoriteGridView.getCheckedRows();

        var repoArr = [];

        for (var i = 0; i < rows.length; i++) {
            var valueJson = favoriteGridView.getValues(rows[i]);
            repoArr.push(valueJson);
        }

        var stringfied = JSON.stringify(repoArr);

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/login/deleteFavoriteMenu.json'/>",
            data: {"data": stringfied},
            success: function (data) {
                alert(data.message);
                addFavoriteMenuLoad();
            },
            error: function (xhr, status, error, data) {
            }
        });
    }

    function favoriteSave(urlStr) {

        favoriteGridView.commit();

        var cnt = 0;

        var rows = favoriteDataProvider.getRows(0, -1);

        for (var i = 0; i < rows.length; i++) {
            if ((rows[i])[3] == 'Y') {
                cnt += 1;
            }
        }

        if (cnt > 3) {
            alert("즐겨찾기 바로가기는 3개를 초과 할 수 없습니다.");
            return;
        }

        var jData;
        var jRowsData = [];
        var rows = favoriteDataProvider.getAllStateRows();

        if (rows.updated.length > 0) {
            for (var i = 0; rows.updated.length > i; i++) {
                jData = favoriteDataProvider.getJsonRow(rows.updated[i]);
                jData.state = "updated";
                jData.modifyID = '<%=userID%>';
                jRowsData.push(jData);
            }
        }
        var jsonv = JSON.stringify(jRowsData);

        $.ajax({
            url: "<c:url value='/login/updateFavoriteMenu.json'/>",
            type: "POST",
            data: {"data": jsonv},
            dataType: "JSON",
            success: function (data) {
                alert(data.message);
                addFavoriteMenuLoad();
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "error:" + error);
            }
        });
    }

    function goFavorite(url) {
        location.href = url;
    }

    function addFavoriteSetting() {

        var menuNo = '<%=menuId%>';
        var userID = '<%=userID%>';

        var json = new Object();

        json.menuNo = menuNo;
        json.adminID = userID;
        json.regID = userID;
        json.mainView = 'N';

        return JSON.stringify(json);
    }

    function addFavoriteMenu() {

        var data = addFavoriteSetting();

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/login/addFavoriteMenu.json'/>",
            data: {"data": data},
            success: function (data) {
                alert(data.message);
                location.reload();
            },
            error: function (xhr, status, error, data) {
            }
        });
    }

    function favoriteModal() {

        $("#favoriteModal").modal('show');
        $("#favoriteModal").on('shown.bs.modal', function () {
            favoriteGridView.resetSize();
            addFavoriteMenuLoad();
        });
        /*

         // 모달은 tile layout 부분에 넣어놨슴.
         // layout.jsp 검색해서 열어보면 모달 들어있음
         <div id="content">

         */
    }

    function refresh() {
        location.reload();
    }

    function addFavoriteMenuLoad() {

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/login/addFavoriteMenuLoad.json'/>",
            data: {"data": "<%=userID%>"},
            success: function (data) {

                favoriteDataProvider.fillJsonData(data);

            },
            error: function (xhr, status, error, data) {
            }
        });
    }

    function getHeaderInformation(){

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "<c:url value='/login/getHeaderInformation.json'/>",
            data: {"data": "123"},
            success: function (data) {

                $("#generalRegist2").text(data.generalRegist);
                $("#copyRegist2").text(data.copyRegist);
                $("#mergedRegist2").text(data.mergedRegist);
                $("#resultUnregistedSample2").text(data.resultUnregistedSample);
                $("#resultUnregisteredItem2").text(data.resultUnregisteredItem);
                $("#paymentRecieved2").text(data.paymentRecieved);
                $("#paymentIssued2").text(data.paymentIssued);
                $("#etcPayment2").text(data.etcPayment);

            },
            error: function (xhr, status, error, data) {
            }
        });

    }

    $(document).ready(function () {

        RealGridJS.setTrace(false);
        RealGridJS.setRootContext("<c:url value='/script'/>");

        favoriteDataProvider = new RealGridJS.LocalDataProvider();
        favoriteGridView = new RealGridJS.GridView("favoriteGrid");
        favoriteGridView.setDataSource(favoriteDataProvider); 

        var fields = [
            {
                fieldName: "menuNo"
            }
            , {
                fieldName: "adminID"
            }
            , {
                fieldName: "menuName"
            }
            , {
                fieldName: "mainView"
            }
            , {
                fieldName: "orderBy"
            }
        ];

        favoriteDataProvider.setFields(fields);

        var columns = [

            {
                name: "menuName",
                fieldName: "menuName",
                header: {
                    text: "메뉴No"
                },
                styles: {
                    textAlignment: "near"
                },
                width: 170,
                readOnly: true
            }
            , {
                name: "mainView",
                fieldName: "mainView",
                header: {
                    text: "바로가기등록"
                },
                styles: {
                    textAlignment: "near"
                },
                editButtonVisibility: "always",
                lookupDisplay: "true",
                values: ["Y", "N"],
                labels: ["사용", "비사용"],
                editor: {
                    type: "dropDown",
                    dropDownCount: 2
                },
                width: 120
            }
            , {
                name: "orderBy",
                fieldName: "orderBy",
                header: {
                    text: "순서등록"
                },
                styles: {
                    textAlignment: "center"
                },
                width: 80
            }

        ];

        favoriteGridView.setColumns(columns);

        favoriteGridView.setOptions({
            panel: {
                visible: false
            },
            footer: {
                visible: false
            },
            stateBar: {
                visible: false
            },
            header: {},
            select: {
                style: RealGridJS.SelectionStyle.ROWS
            },
            checkBar: {
                visible: true
            },
            display: {
                fitStyle: "evenFill"
            }
        });

        favoriteGridView.setStyles(smart_style);
        getHeaderInformation(); 
    })

</script>


<div id="divHeader" style="width:100%;">

    <div id="logo-group">

        <!-- PLACE YOUR LOGO HERE -->
		<span id="logo"> 
		<div class="logo_img"></div>
		<!-- 
		<img class="logo_img" src="<c:url value='/images/logo/logo.png'/>" alt="KPetro TEMS">
		 --> 
		</span>
        <!-- END LOGO PLACEHOLDER -->

        <!-- Note: The activity badge color changes when clicked and resets the number to 0
             Suggestion: You may want to set a flag when this happens to tick off all checked messages / notifications -->
        <span id="activity" class="activity-dropdown"> <i class="fa fa-user"></i> <b class="badge"> 210 </b> </span>

    </div>


    <!-- #PROJECTS: projects dropdown -->
    <div id="top-state" class="top-infobox">
        <div class="top_infobox_group group_color">
            <span class="label top_infobox_title bg-color-pink">접수현황</span>
            <span class="top_infobox_text">일반</span>
            <span class="badge title_color" id="generalRegist2"></span>
            <span class="top_infobox_text">등본</span>
            <span class="badge title_color" id="copyRegist2"></span>
            <span class="top_infobox_text">통합</span>
            <span class="badge title_color" id="mergedRegist2"></span>
        </div>
        <div class="top_infobox_group group_color">
            <span class="label top_infobox_title bg-color-green">진행상태</span>
            <span class="top_infobox_text">시료</span>
            <span class="badge title_color" id="resultUnregistedSample2"></span>
            <span class="top_infobox_text">항목</span>
            <span class="badge title_color" id="resultUnregisteredItem2"></span>
        </div>
        <div class="top_infobox_group group_color">
            <span class="label top_infobox_title bg-color-magenta">결재현황</span>
            <span class="top_infobox_text">접수</span>
            <span class="badge title_color" id="paymentRecieved2"></span>
            <span class="top_infobox_text">발급</span>
            <span class="badge title_color" id="paymentIssued2" ></span>
            <span class="top_infobox_text">기타</span>
            <span class="badge title_color" id="etcPayment2" ></span>
        </div>
        <!-- end dropdown-menu-->

    </div>
    <!-- end projects dropdown -->


    <!-- #TOGGLE LAYOUT BUTTONS -->
    <!-- pulled right: nav area -->
    <div id="top_btn" class="pull-right">
        <!-- logout button -->
        <div id="logout" class="btn-header transparent pull-right">
            <span> <a class="top_btn_margin0" href="<c:url value='/login/userLogout.do' />" title="LogOut"
                      data-action="userLogout" data-logout-msg="이 열린 브라우저를 닫고 로그 아웃 한 후 추가 보안을 향상시킬 수 있습니다"><i
                    class="fa fa-sign-out"></i></a> </span>
        </div>
        <!-- end logout button -->


        <!-- collapse menu button -->
        <div id="hide-menu" class="btn-header pull-right">
            <span> <a class="top_btn_margin0" href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu"><i
                    class="fa fa-reorder"></i></a> </span>
        </div>
        <!-- end collapse menu -->


        <!-- fullscreen button -->
        <!--
        <div id="fullscreen" class="btn-header transparent pull-right">
            <span> <a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen"><i class="fa fa-arrows-alt"></i></a> </span>
        </div>
         -->
        <!-- end fullscreen button -->


        <div class="project-context btn-header transparent pull-right top_more_padding">
					<span class="top-menu dropdown-toggle" data-toggle="dropdown">
						<a href="javascript:alert('메뉴이동');" title="즐겨찾기3" class="top_btn_margin0">즐겨찾기<i
                                class="fa fa-angle-down"></i> </a>
					</span>

            <!-- Suggestion: populate this list with fetch and push technique -->
            <ul class="dropdown-menu">

                <%

                    List<FavoriteVO> favoriteList = (List<FavoriteVO>) session.getAttribute("favoriteList");
                    for (FavoriteVO vo : favoriteList) {

                %>
                <li>
                    <a href="javascript:goFavorite('/tems'+'<%=vo.getUrl()%>');"><%=vo.getMenuName()%>
                    </a>
                </li>
                <%
                    }
                %>
                <li>
                    <a href="javascript:addFavoriteMenu();"><i class="fa fa-plus-square"></i>&nbsp; 메뉴추가</a>
                </li>
                <li>
                    <a href="javascript:favoriteModal();"><i class="fa fa-sign-in"></i>&nbsp; 메뉴관리</a>
                </li>
            </ul>
            <!-- end dropdown-menu-->
        </div>

        <!--  개인 바로 가기  -->


        <%
            for (FavoriteVO vo : favoriteList) {
                if (vo.getMainView().equals("Y")) {
        %>
        <div class="btn-header transparent pull-right">
            <span class="top-menu top_btn_margin0">
                <a href="javascript:goFavorite('/tems'+'<%=vo.getUrl()%>');" class="top_user_btn"><%=vo.getMenuName()%>
                </a>
            </span>
        </div>
        <%
                }
            }
        %>
    </div>

</div>



