<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	ActualUtil util = new ActualUtil();
	util.setDivision(request, response);

	String strId = (String)session.getAttribute("userId");


	if (strId == null){ %>
		<script>
			alert("�ٽ� �����Ͽ� �ֽʽÿ�");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%
	 return;
	}

	int group = Integer.parseInt(Common.numfilter((String)session.getAttribute("groupId")));


	%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>:::  :::</title>
<!--
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/bsc.css" rel="stylesheet" type="text/css">
-->
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/flex02.css" rel="stylesheet" type="text/css" />
<jsp:include page="js/js.jsp" flush="true"/>
</head>
<script>

	var selPage =null;
	var winEIS = null;

	function openScoreTable(dId, tId, level, year, month){
		<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgScore.jsp?did="+dId+"&tid="+tId+"&level="+level+"&year="+year+"&month="+month; --%>
		document.getElementById("page").src = "<%=imgUri%>/scorecard/score/orgScore.do";

		document.getElementById("titleText").innerText="������ ������ȸ";
		document.getElementById("titleText_1").innerText="������ ������ȸ";
		document.getElementById("titleText_2").innerText="������ȸ";
	}

	function openContents(tag){
		if ("1" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/mapStrategic.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/scorecard/strategy/map.do";
			document.getElementById("titleText").innerText="������ ��������͸�";
			document.getElementById("titleText_1").innerText="������ ��������͸�";
			document.getElementById("titleText_2").innerText="������ȸ";

		} else if ("2" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/mapOrganization.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/scorecard/strategy/org.do";
			document.getElementById("titleText").innerText="������ ��������͸�";
			document.getElementById("titleText_1").innerText="������ ��������͸�";
			document.getElementById("titleText_2").innerText="������ȸ";
		} else if ("3" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgScore.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/scorecard/score/orgScore.do";

			document.getElementById("titleText").innerText="������ ������ȸ";
			document.getElementById("titleText_1").innerText="������ ������ȸ";
			document.getElementById("titleText_2").innerText="������ȸ";
		} else if ("4" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptMeasRanking.jsp";
			document.getElementById("titleText").innerText="��ǥ�� ��������";
			document.getElementById("titleText_1").innerText="��ǥ�� ��������";
			document.getElementById("titleText_2").innerText="������ȸ";
		}  else if ("5" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgRanking.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/scorecard/rank/orgRank.do";
			document.getElementById("titleText").innerText="�⵵�� ��������";
			document.getElementById("titleText_1").innerText="�⵵�� ��������";
			document.getElementById("titleText_2").innerText="������ȸ";

		} else if ("8" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptMboOrgScore.jsp";
			document.getElementById("titleText").innerText="�������� ����͸�";
			document.getElementById("titleText_1").innerText="�������� ����͸�";
			document.getElementById("titleText_2").innerText="������ȸ(����)";
		} else if ("9" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptMboPsnScore.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/scorecard/perform/mboPsnScore.do";
			document.getElementById("titleText").innerText="����å�� ����͸�";
			document.getElementById("titleText_1").innerText="����å�� ����͸�";
			document.getElementById("titleText_2").innerText="������ȸ(����)";
		} else if ("10" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptMboPsnTarget.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/scorecard/perform/mboTargetScore.do";
			document.getElementById("titleText").innerText="������ǥ ����͸�";
			document.getElementById("titleText_1").innerText="������ǥ ����͸�";
			document.getElementById("titleText_2").innerText="������ȸ(����)";
		}
	}

	var viewMenu = true;

	function showMenu(){
		if (viewMenu) {
			document.getElementById("leftMenu").style.display="none";
			top.closeTopMenu();
			viewMenu = false;
		} else {
			document.getElementById("leftMenu").style.display="inline";
			top.openTopMenu();
			viewMenu = true;
		}
	}

	function goDown() {
		if (selPage == document.getElementById("page1") ) {
			openContents(2);
		} else if (selPage == document.getElementById("page2") ) {
			openContents(3);
		} else if (selPage == document.getElementById("page3") ) {
			openContents(4);
		} else if (selPage == document.getElementById("page4") ) {
			//alert("���� ȭ���� �����ϴ�.");
		}
	}

	function goUp() {
		if (selPage == document.getElementById("page1") ) {
			//alert("���� ȭ���� �����ϴ�.");
		} else if (selPage == document.getElementById("page2") ) {
			openContents(1);
		} else if (selPage == document.getElementById("page3") ) {
			openContents(2);
		} else if (selPage == document.getElementById("page4") ) {
			openContents(3);
		}
	}



</script>
<body onLoad="MM_preloadImages('images/menu01_over.jpg','images/menu02_over.jpg','images/menu03_over.jpg','images/menu04_over.jpg','images/menu05_over.jpg','images/menu06_over.jpg')">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" height="100%" align="center" valign="top">
	  <table width="170" height="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center" colspan="3" height="50"><img src="images/sub_title02.jpg" width="163" height="50"></td>
        </tr>
        <tr>
          <td valign="top" colspan="3"><img src="images/menu_title.jpg" width="170" height="29" /></td>
        </tr>
	    <tr>
		  <td width="5" height="100%" background="images/menu_leftbg.jpg" valign="top">
			<img src="images/menu_leftbg.jpg" width="5" height="4" valign="top"/>
		  </td>
		  <td width="160" valign="top">
			<table width="160" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2" align="center"><img src="images/blank.gif" height="5" /></td>
              </tr>
              <tr>
                <td width="30" height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>
                <td width="130" align="left" class="title_text">������ȸ</td>
              </tr>
              <tr>
                <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
              </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left" class="text"><a href="javascript:openContents(3);">������ ������ȸ </a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><span class="text"><a href="javascript:openContents(2);">������ ��������͸�</a></span></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
              </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><span class="text"><a href="javascript:openContents(1);">������ ��������͸�</a></span></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
              </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(5);">�⵵�� ����������ȸ</a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/blank.gif" height="5" /></td>
              </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              <tr>
                <td width="30" height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>
                <td width="130" align="left" class="title_text">������ȸ(����)</td>
              </tr>
              <tr>
                <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
              </tr><!--
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(8);">�������� ����͸�</a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                -->
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(9);">����å�� ����͸�</a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(10);">������ǥ ����͸�</a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
<!--
                <tr>
                  <td height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>
                  <td align="left" class="title_text">�Խ���</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
                  </tr>
                <tr>
                  <td height="35">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(7);">��������</a></td>
                </tr>
-->
            </table>
		  </td>
          <td width="5" background="images/menu_rightbg.jpg">
			<img src="images/menu_rightbg.jpg" width="5" height="6" />
		  </td>
		</tr>
        <tr>
          <td colspan="3"><img src="images/menu_bottom.jpg" width="170" height="6" /></td>
        </tr>
      </table>
	</td>
    <!--<td width="5" valign="top">&nbsp;</td>-->
    <td valign="top">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td>
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom: 1px solid #c1c1c1;">
              <tr>
                <td width="300" valign="bottom">
				  <table height="45" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="11" style="padding-top:5;"><img src="images/bulet01.jpg" width="11" height="21"></td>
                      <td width="5">&nbsp;</td>
                      <td valign="middle" style="padding-top:6;padding-right:5;"><p class="title_b"><font size="3" id="titleText_1">������ ������ȸ</font></p></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="3" background="images/line01.jpg"><img src="images/line01.jpg" width="6" height="5"></td>
                    </tr>
                  </table>
				</td>
                <td align="right" valign="bottom" style="padding-right:15;">
				  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right" class="td">Ȩ &gt; ������ȸ &gt; <font id="titleText_2">������ȸ</font> &gt; <strong><font id="titleText">������ ������ȸ</font></strong></td>
                    </tr>
                    <tr>
                      <td><img src="images/blank.gif" width="1" height="5"></td>
                    </tr>
                  </table>
				</td>
              </tr>
              <tr>
                <td colspan="2" bgcolor="#FFFFFF"><img src="images/blank.gif" width="1" height="5"></td>
              </tr>
            </table>
		  </td>
        </tr>
        <tr>
		  <td valign="top" width="100%" height="100%">
		    <!---------///���� ������ ���Կ��� ///--------->
		    <IFRAME id="page" name="contents" marginWidth="0" marginHeight="0" src="<%=imgUri%>/scorecard/score/orgScore.do" frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>
		    <!---------///���� ������ ���Կ���  ��///--------->
		  </td>
        </tr>
	  </table>
	</td>
    <td width="3" valign="top">&nbsp;</td>
  </tr>
</table>

</body>
</html>
<script>
   selPage = document.getElementById("page1");
</script>
