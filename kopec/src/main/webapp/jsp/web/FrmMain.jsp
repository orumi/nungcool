<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nc.cool.AppConfigUtil"%>
<%@ page import="com.nc.util.Util"%>
<%@ page import="com.nc.xml.MeasReportUtil"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.nc.util.DataSet"%>

<%
	String rootUrl = "";
	StringBuffer reqUrl = request.getRequestURL();
	if("\\".equals(System.getProperty("file.separator"))){
		rootUrl = reqUrl.substring(0,reqUrl.lastIndexOf(request.getContextPath()))+request.getContextPath()+"/";
	}else{
		rootUrl = reqUrl.substring(0,reqUrl.lastIndexOf(request.getRequestURI()))+"/";
	}

	String userId    = (String) session.getAttribute("userId");
	String userName  = (String) session.getAttribute("userName");
    String groupId   = (String) session.getAttribute("groupId");
    String groupNm   = (String) session.getAttribute("groupNm");
    String deptNm    = (String) session.getAttribute("deptNm");
    String bscNm	 = (String) session.getAttribute("bscNm");
	String mngYn     = (String) session.getAttribute("mngYn");

	if (groupId == null) {
%>
		<script>
			alert("잘못된 접속입니다.");
			top.location.href = "./loginProc.jsp";
		</script>
<%
	}

	// 세션 등록부분
	int group = new Integer(groupId).intValue();

	AppConfigUtil app = new AppConfigUtil();
	String showym = app.getShowYM() ;

	//String qtr    = Util.getPrevQty2(null);		// 6 개월전
	//String qtr    = Util.getPrevQty (null);		// 3 개월전

	String year   = showym.substring(0,4);
	String ym     = showym.substring(0,6);
	String month  = showym.substring(4,6);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>한국전력기술(주) :: 성과관리시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/kopec.css" rel="stylesheet" type="text/css"/>
</head>
<script language="JavaScript">

	var xcount = 0;
	var ycount = 0;

	function showUserMsg(){
		alert("잠시만 기다려 주십시요.");
	}

	function LinkForm(tag, num, subNum){
		if("10" == tag){ // 공지사항 전체 리스트
		    top.topFrm.openBoard();
			top.FrmBoard.document.getElementById("page").src = "<%=rootUrl%>jsp/web/commueval/bbs_list.jsp?div_cd=0";
			top.FrmBoard.document.getElementById("titleText").innerText="공지사항";
			top.FrmBoard.document.getElementById("titleText_1").innerText="공지사항";

		}else if("11" == tag){ // 경영정보회의 공유자료
		    top.topFrm.openBoard();
			top.FrmBoard.document.getElementById("page").src = "<%=rootUrl%>jsp/web/commueval/bbs_list.jsp?div_cd=3";
			top.FrmBoard.document.getElementById("titleText").innerText="공지사항";
			top.FrmBoard.document.getElementById("titleText_1").innerText="경영정보회의 공유자료";
		}else if("12" == tag){ // 한전경영평가자료
		    top.topFrm.openBoard();
			top.FrmBoard.document.getElementById("page").src = "<%=rootUrl%>jsp/web/commueval/bbs_list.jsp?div_cd=1";
			top.FrmBoard.document.getElementById("titleText").innerText="공지사항";
			top.FrmBoard.document.getElementById("titleText_1").innerText="한전경영평가자료";
		}else if("13" == tag){ // 내부평가자료
		    top.topFrm.openBoard();
			top.FrmBoard.document.getElementById("page").src = "<%=rootUrl%>jsp/web/commueval/bbs_list.jsp?div_cd=2";
			top.FrmBoard.document.getElementById("titleText").innerText="공지사항";
			top.FrmBoard.document.getElementById("titleText_1").innerText="내부평가자료";
		}
	}

	function LeftLinkForm(tag) {
		if ("01" == tag) { // Left Menu: 전략맵
			top.topFrm.openScorecard();
			//parent.document.all.mainFrm.document.all.contentFrm.rows = "0, 0,*,0 0,0,0, 0"
			top.FrmScorecard.openContents("1");
		} else if ("02" == tag) { // Left Menu: 조직도
			parent.topFrm.openScorecard();
		    //parent.document.all.mainFrm.document.all.contentFrm.rows = "0, 0,*,0 0,0,0, 0"
			top.FrmScorecard.openContents("2");
		}  else if ("03" == tag) { // Left Menu: 경영정보
			parent.topFrm.openEis();
		    top.FrmEis.openContents("1");
		}
	}

	function bluring(){
	if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG")
		document.body.focus();
	}
	document.onfocusin=bluring;

	/**
	 * 설  명: 공지사항, 커뮤니티, 자료실, 실적보고서 메뉴 보이기, 숨기기 제어
	 * 함수명: showboard(no)
	 */
	function showboard(no) {
		if (no == 1) {
			document.getElementById("menuImg1").style.display = "block";
			document.getElementById("menuImg2").style.display = "none";
			document.getElementById("menuImg3").style.display = "none";
			document.getElementById("menuImg4").style.display = "none";

			document.getElementById("notiLayer").style.display = "none";
			document.getElementById("commLayer").style.display = "none";
			document.getElementById("pdsLayer").style.display = "none";
			document.getElementById("actreportLayer").style.display = "block";
		} else if (no == 2) {
			document.getElementById("menuImg1").style.display = "none";
			document.getElementById("menuImg2").style.display = "block";
			document.getElementById("menuImg3").style.display = "none";
			document.getElementById("menuImg4").style.display = "none";
			document.getElementById("notiLayer").style.display = "none";
			document.getElementById("commLayer").style.display = "block";
			document.getElementById("pdsLayer").style.display = "none";
			document.getElementById("actreportLayer").style.display = "none";
		} else if (no == 3) {
			document.getElementById("menuImg1").style.display = "none";
			document.getElementById("menuImg2").style.display = "none";
			document.getElementById("menuImg3").style.display = "block";
			document.getElementById("menuImg4").style.display = "none";

			document.getElementById("notiLayer").style.display = "none";
			document.getElementById("commLayer").style.display = "none";
			document.getElementById("pdsLayer").style.display = "block";
			document.getElementById("actreportLayer").style.display = "none";
		} else if (no == 4) {
			document.getElementById("menuImg1").style.display = "none";
			document.getElementById("menuImg2").style.display = "none";
			document.getElementById("menuImg3").style.display = "none";
			document.getElementById("menuImg4").style.display = "block";


			document.getElementById("notiLayer").style.display = "block";
			document.getElementById("commLayer").style.display = "none";
			document.getElementById("pdsLayer").style.display = "none";
			document.getElementById("actreportLayer").style.display = "none";
		}
	}

	function windowClose(){
		if(navigator.appVersion.indexOf("MSIE 7.0")>=0) {
	        //IE7에서는 아래와 같이
	        top.window.open('about:blank','_self').close();
	     }
	     else {
			//IE7이 아닌 경우
			top.opener=self;
			top.window.close();
	     }
	}
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="965" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>

    <!-- / 좌측메뉴 : 사용자 정보 및 퀵링크 / -->
    <td width="195" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="460" valign="top" style="background:url("<%=rootUrl %>images/main_left_bg.jpg) no-repeat">
			<table width="180" border="0" align="center" cellpadding="0" cellspacing="0">

			  <tr>
			    <td height="140" valign="top" background="<%=rootUrl %>/images/user_info_box.gif"><table width="170" border="0" align="center" cellpadding="0" cellspacing="0">
			      <tr>
			        <td height="37" colspan="3">&nbsp;</td>
			      </tr>
			      <tr>
			        <td width="47" height="21">&nbsp;</td>
			        <td colspan="2"><%="".equals(userName) ? "" : userName %></td>
			      </tr>
			      <tr>
			        <td height="22">&nbsp;</td>
			        <td colspan="2"><%="".equals(deptNm) ? "" : deptNm %></td>
			      </tr>
			      <tr>
			        <td height="23">&nbsp;</td>
			        <td width="18">&nbsp;</td>
			        <td width="105"><%="".equals(groupNm) ? "" : groupNm %></td>
			      </tr>
			      <tr>
			        <td height="30" colspan="3" align="center"><a href="#"><img src="<%=rootUrl %>images/btn_pw_change.gif" alt="비밀번호변경" width="91" height="22" align="absmiddle" border="0" onclick="window.open('./pass.jsp','win1',  'toolbar=0, status=0, scrollbars=no, location=0, menubar=0, width=400, height=200')"/></a><a href="#"><img src="<%=rootUrl %>images/btn_logout.gif" alt="로그아웃" width="70" height="22" align="absmiddle" border="0" onclick="windowClose()"/></a></td>
			      </tr>
			    </table></td>
			  </tr>
			</table>
           <!--/링크/-->
          <table width="180" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><img src="<%=rootUrl %>images/main_link_01.gif" width="180" height="147" border="0" usemap="#link" /></td>
            </tr>
          </table>

           <!--/여백/-->
          <table width="180" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
          </table>

           <!--/링크/-->
          <table width="180" height="96" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="48" background="<%=rootUrl %>images/visitor_box.gif">
              <!--/문의사항/-->
              <table width="170" border="0" cellspacing="0" cellpadding="0">
                <tr><td width="40%" height="20"></td>
                <td widht="60%"></td>
                </tr>
                <tr>
                  <td height="30">&nbsp;</td>
                  <td class="fc_b3">
                  	<strong>팀장 이은주</strong><br>&nbsp;054)421-4164
                  </td>
                 </tr><tr>
                  <td height="20">&nbsp;</td>
                  <td class="fc_b3" valign="top">
                  	<strong>담당자 김새롬</strong><br>&nbsp;054)421-4268
                  </td>
                </tr>
              </table>
               <!--/문의사항/-->
              </td>
            </tr>
          </table></td>
      </tr>
    </table></td>

    <!-- / 중앙  : 초기화면  이미지  / -->
    <td width="340"><img src="<%=rootUrl %>images/main_visual.jpg" width="340" height="460"></td>

    <!-- / 우측  : 상단 성과현황  및 게시판 / -->
    <td valign="top"><table width="426" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="<%=rootUrl %>images/main_top_01.jpg" width="426" height="77" /></td>
      </tr>
    </table>
	<table width="426" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="28" background="<%=rootUrl %>images/main_box_top_01.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="12%">&nbsp;</td>
	        <td width="88%" valign="top" align="right"><font color="#555555">(<%=year %>년 <%=month %>월 현재)&nbsp&nbsp&nbsp&nbsp</font> </td>
	      </tr>
	    </table></td>
	  </tr>
	  <tr>
	    <td height="150" valign="top" background="<%=rootUrl %>images/main_box_bg.gif">
	    <table width="393" border="0" align="center" cellpadding="0" cellspacing="0">
	      <tr>
	        <td><img src="<%=rootUrl %>images/main_box_bar.gif" width="393" height="23" /></td>
	      </tr>
	    </table>
			<%


				request.setAttribute("year", year);
				request.setAttribute("ym"  , ym  );

				MeasReportUtil util = new MeasReportUtil();

				util.getOrgRankBonbu(request,response);
				DataSet dsBsc = (DataSet)request.getAttribute("ds");
			%>

	        <table width="393" border="0" align="center" cellpadding="0" cellspacing="0">
	          <!--/리스트/-->
<% if(dsBsc != null){
		int j=0;
   		while (dsBsc.next()) {

   			String bid         = ((String)dsBsc.getString("bid")).trim();
   			String bcid        = ((String)dsBsc.getString("bcid")).trim();
   			String bname       = ((String)dsBsc.getString("bname")).trim();
   			String bscore      = dsBsc.isEmpty("bscore")?"":dsBsc.getString("bscore")==null?"":dsBsc.getString("bscore");
   			String gscore      = dsBsc.isEmpty("bscore")?"":dsBsc.getString("fscr")==null?"":dsBsc.getString("fscr").trim();
   			String deptrank    = dsBsc.isEmpty("deptrank")?"":dsBsc.getString("deptrank");
   			String colorgrade  = dsBsc.isEmpty("colorgrade")?"n":dsBsc.getString("colorgrade");
   			String iconfile    = "img_state_" + colorgrade + ".gif";
    %>
	          <tr>
	            <td width="73" height="20" align="center"><%=deptrank %></td>
	            <td width="184">&nbsp&nbsp<%=bname %></td>
	            <td width="74" align="center" class="fc_b3"><%=gscore%></td>
	            <td width="62" align="center"><img src="<%=rootUrl %>images/<%=iconfile %>" width="10" height="10" /></td>
	          </tr>

    <%
    		j++;
    	}
	} %>



		     <%--  <tr>
	            <td width="73" height="20" align="center">1</td>
	            <td width="194">&nbsp&nbsp원자력본부</td>
	            <td width="64" align="center" class="fc_b3">88.98</td>
	            <td width="62" align="center"><img src="<%=rootUrl %>images/img_state_b.gif" width="10" height="10" /></td>
	          </tr>
	          <tr>
	            <td width="73" height="20" align="center">2</td>
	            <td width="194">&nbsp&nbsp원자로설계개발단</td>
	            <td width="64" align="center" class="fc_b3">88.77</td>
	            <td width="62" align="center"><img src="<%=rootUrl %>images/img_state_b.gif" width="10" height="10" /></td>
	          </tr>
	          <tr>
	            <td width="73" height="20" align="center">3</td>
	            <td width="194">&nbsp&nbsp경영관리본부</td>
	            <td width="64" align="center" class="fc_b3">87.75</td>
	            <td width="62" align="center"><img src="<%=rootUrl %>images/img_state_b.gif" width="10" height="10" /></td>
	          </tr>
	          <tr>
	            <td width="73" height="20" align="center">4</td>
	            <td width="194">&nbsp&nbsp플랜트본부</td>
	            <td width="64" align="center" class="fc_b3">85.38</td>
	            <td width="62" align="center"><img src="<%=rootUrl %>images/img_state_b.gif" width="10" height="10" /></td>
	          </tr> --%>

	          <!--/리스트/-->
	          <tr>
	            <td height="1" colspan="4" bgcolor="#E3E3E3"></td>
	          </tr>
	      </table></td>
	  </tr>
	  <tr>
	    <td><img src="<%=rootUrl %>images/main_box_end.gif" width="426" height="8" /></td>
	  </tr>
	</table>
	<table width="426" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td><img src="images/main_box_top_02.gif" width="426" height="8" /></td>
	  </tr>
	  <tr>
	    <td height="140" valign="top" background="images/main_box_bg.gif">

	    <!----// tapmenu //---->
		   <table width="390" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr id="menuImg1" style="display:block">
                <td><table width="390" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="74"><img src="<%=rootUrl %>images/tap_04_over.gif" width="73" height="19" onclick="showboard(1)" style="cursor:hand;"></td>
                      <td width="100"><img src="<%=rootUrl %>images/tap_03_off.gif" width="98" height="19" onclick="showboard(3)" style="cursor:hand;"></td>
  			          <td width="74"><img src="<%=rootUrl %>images/tap_01_off.gif" width="72" height="19" onclick="showboard(4)" style="cursor:hand;"></td>
  			          <td>&nbsp;</td>
				      <td width="30"><a href="#"><img src="images/btn_more1.gif" alt="more" width="28" height="11" border="0"  onclick="LinkForm(13, 0);"/></a></td>
                  </table></td>
              </tr>
              <tr id="menuImg2" style="display:none">
                <td><table width="390" border="0" cellspacing="0" cellpadding="0">
                    <tr>

                      <td width="74"><img src="<%=rootUrl %>images/tap_04_off.gif" width="73" height="19" onclick="showboard(1)" style="cursor:hand;"></td>
                      <td width="100"><img src="<%=rootUrl %>images/tap_03_off.gif" width="98" height="19" onclick="showboard(3)" style="cursor:hand;"></td>
  			          <td width="74"><img src="<%=rootUrl %>images/tap_01_off.gif" width="72" height="19" onclick="showboard(4)" style="cursor:hand;"></td>

  			          <td>&nbsp;</td>
				      <td width="30"><a href="#"><img src="images/btn_more1.gif" alt="more" width="28" height="11" border="0"  onclick="LinkForm(11, 0);"/></a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr id="menuImg3" style="display:none">
                <td><table width="390" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="74"><img src="<%=rootUrl %>images/tap_04_off.gif" width="73" height="19" onclick="showboard(1)" style="cursor:hand;"></td>
                      <td width="100"><img src="<%=rootUrl %>images/tap_03_over.gif" width="98" height="19"></td>
  			          <td width="74"><img src="<%=rootUrl %>images/tap_01_off.gif" width="72" height="19" onclick="showboard(4)" style="cursor:hand;"></td>
  			          <td>&nbsp;</td>
  			          <td width="30"><a href="#"><img src="images/btn_more1.gif" alt="more" width="28" height="11" border="0"  onclick="LinkForm(12, 0);"/></a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr id="menuImg4" style="display:none">
                <td><table width="390" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="74"><img src="<%=rootUrl %>images/tap_04_off.gif" width="73" height="19" onclick="showboard(1)" style="cursor:hand;"></td>
                      <td width="100"><img src="<%=rootUrl %>images/tap_03_off.gif" width="98" height="19" onclick="showboard(3)" style="cursor:hand;"></td>
  			          <td width="74"><img src="<%=rootUrl %>images/tap_01_over.gif" width="72" height="19" onclick="showboard(4)" style="cursor:hand;"></td>
  			          <td>&nbsp;</td>
				      <td width="30"><a href="#"><img src="images/btn_more1.gif" alt="more" width="28" height="11" border="0"  onclick="LinkForm(10, 0);"/></a></td>
                    </tr>
                  </table></td>
              </tr>

              <!-- 경영정보 공유 회의자료 Layer -->
              <tr id="commLayer" style="display:none;">
                <td valign="top"><table width="390" border="0" cellpadding="10" cellspacing="0" bgcolor="d5d5d5">
                    <tr>
                      <td height="16" valign="top" bgcolor="#FFFFFF"><iframe src="<%=rootUrl%>jsp/web/commueval/bbs_list_tab.jsp?div_cd=3&lines=5" scrolling="no" width="100%" frameborder="0"  height="125"></iframe></td>
                    </tr>
                  </table></td>
              </tr>
              <!-- 한전경영평가자료 Layer -->
              <tr id="pdsLayer" style="display:none;">
                <td valign="top"><table width="390" border="0" cellpadding="10" cellspacing="0" bgcolor="d5d5d5">
                    <tr>
                      <td height="16" valign="top" bgcolor="#FFFFFF"><iframe src="<%=rootUrl%>jsp/web/commueval/bbs_list_tab.jsp?div_cd=1&lines=5" scrolling="no" width="100%" frameborder="0"  height="125"></iframe></td>
                    </tr>
                  </table></td>
              </tr>
              <!-- 내부평가자료  Layer -->
              <tr id="actreportLayer" style="display:block;">
                <td valign="top"><table width="390" border="0" cellpadding="10" cellspacing="0" bgcolor="d5d5d5">
                    <tr>
                    <td height="16" valign="top" bgcolor="#FFFFFF"><iframe src="<%=rootUrl%>jsp/web/commueval/bbs_list_tab.jsp?div_cd=2&lines=5" scrolling="no" width="100%" frameborder="0"  height="125"></iframe></td>
                    </tr>
                  </table></td>
              </tr>

   			<!-- 공지사항 Layer -->
              <tr id="notiLayer" style="display:none;">
                <td valign="top"><table width="390" border="0" cellpadding="10" cellspacing="0" bgcolor="d5d5d5">
                    <tr>
                      <td height="16" valign="top" bgcolor="#FFFFFF"><iframe src="<%=rootUrl%>jsp/web/commueval/bbs_list_tab.jsp?div_cd=0&lines=5"; scrolling="no" width="100%" frameborder="0" height="125"></iframe></td>
                    </tr>
                  </table></td>
              </tr>

	       </table>
	      <!----// list //---->      </td>
	  </tr>
	  <tr>
	    <td><img src="images/main_box_end.gif" width="426" height="8" /></td>
	  </tr>
	</table>
     </td>
  </tr>
</table>

<table width="960" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#E3E3E3"></td>
  </tr>
  <tr>
    <td align="center"><img src="<%=rootUrl %>images/footer_01.gif" width="432" height="25"/></td>
  </tr>
</table>

<map name="link" id="link">
        <area shape="rect" coords="10,13,169,51" href="javascript:LeftLinkForm('01');"/>
        <area shape="rect" coords="9,53,169,92"  href="javascript:LeftLinkForm('02');"/>
        <area shape="rect" coords="9,93,169,132" href="javascript:LeftLinkForm('03');"/></map></body>
</body>
</html>