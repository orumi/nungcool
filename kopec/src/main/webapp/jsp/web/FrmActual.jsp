<%@ page contentType="text/html; charset=euc-kr" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

    String groupId = (String) session.getAttribute("groupId");

	if (groupId == null) {
	%>
	<script>
		alert("잘못된 접속입니다.");
	  	top.location.href = "./loginProc.jsp";
	</script>
	<%
		return;
	}

	int group = new Integer(groupId).intValue();
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
	function openContents(tag){
		if ("1" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/actual/actual.jsp";

			//imgTitle.src="images/4_sub_title01.jpg";
			document.getElementById("titleText").innerText="조직별 계량실적등록";
			document.getElementById("titleText_1").innerText="조직별 계량실적등록";
			document.getElementById("titleText_2").innerText="계량실적";
		} else if ("2" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/actual/deptActual.jsp";
			//imgTitle.src="images/4_sub_title02.jpg";
			document.getElementById("titleText").innerText="계량지표 실적등록";
			document.getElementById("titleText_1").innerText="계량지표 실적등록";
			document.getElementById("titleText_2").innerText="계량실적";
		} else if ("3" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/actual/taskExcel.jsp";
			//imgTitle.src="images/4_sub_title03.jpg";
			document.getElementById("titleText").innerText="실적엑셀등록";
			document.getElementById("titleText_1").innerText="실적엑셀등록";
			document.getElementById("titleText_2").innerText="계량실적";
		} else if ("4" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/actual/planned.jsp";
			//imgTitle.src="images/4_sub_title04.jpg";
			document.getElementById("titleText").innerText="계량지표 등급구간등록";
			document.getElementById("titleText_1").innerText="계량지표 등급구간등록";
			document.getElementById("titleText_2").innerText="계량실적";
		} else if ("5" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/valuateActual.jsp";
			//imgTitle.src="images/4_sub_title06.jpg";
			document.getElementById("titleText").innerText="비계량 실적등록";
			document.getElementById("titleText_1").innerText="비계량 실적등록";
			document.getElementById("titleText_2").innerText="비계량실적";
		} else if ("6" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/task/taskAdmin.jsp";
			document.getElementById("titleText_2").innerText="과제관리";
			document.getElementById("titleText").innerText="과제 등록";
		} else if ("7" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/task/taskActual.jsp";
			document.getElementById("titleText_2").innerText="과제관리";
			document.getElementById("titleText").innerText="과제 실적등록";
		} else if ("8" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/task/taskInitiative.jsp";
			document.getElementById("titleText_2").innerText="과제관리";
			document.getElementById("titleText").innerText="과제 연계등록";
		}else if ("9" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/valuatePlan.jsp";

			document.getElementById("titleText").innerText="비계량 계획등록";
			document.getElementById("titleText_1").innerText="비계량 계획등록";
			document.getElementById("titleText_2").innerText="비계량실적";
		} else if ("10" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/measureFixedItem.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/actual/qtyActual/measurePlanned.do";

			//imgTitle.src="images/4_sub_title04.jpg";
			document.getElementById("titleText").innerText="계량지표 계획등록";
			document.getElementById("titleText_1").innerText="계량지표 계획등록";
			document.getElementById("titleText_2").innerText="계량실적";

		} else if ("11" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgMeasDetail.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/actual/report/measureActual.do";

			document.getElementById("titleText").innerText="성과지표 계획 및 실적";
			document.getElementById("titleText_1").innerText="성과지표 계획 및 실적";
			document.getElementById("titleText_2").innerText="성과분석";

		}  else if ("12" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgMeasStatus.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/actual/report/measureStatus.do";

			document.getElementById("titleText").innerText="조직별 지표구성 내역";
			document.getElementById("titleText_1").innerText="조직별 지표구성 내역";
			document.getElementById("titleText_2").innerText="성과분석";
		}  else if ("13" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/measureOrgUser.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/actual/measure/owner.do";


			document.getElementById("titleText").innerText="지표담당자 변경";
			document.getElementById("titleText_1").innerText="지표담당자 변경";
			document.getElementById("titleText_2").innerText="지표관리";
		}
	}

</script>
<body onLoad="MM_preloadImages('images/menu01_over.jpg','images/menu02_over.jpg','images/menu03_over.jpg','images/menu04_over.jpg','images/menu05_over.jpg','images/menu06_over.jpg')">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" height="100%" align="center" valign="top">
	  <table width="170" height="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center" colspan="3" height="50"><img src="images/sub_title04.jpg" width="163" height="50"></td>
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
                  <td width="130" align="left" class="title_text">지표관리</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(13);">지표담당자 변경</a> </td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td width="30" height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>
                  <td width="130" align="left" class="title_text">계량실적</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(10);">계량지표 계획등록</a> </td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><span class="text"><a href="javascript:openContents(2);">계량지표  실적등록 </a></span></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><span class="text"><a href="javascript:openContents(3);">실적엑셀등록 </a></span></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td width="30" height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>
                  <td width="130" align="left" class="title_text">비계량실적</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left" class="text"><a href="javascript:openContents(9);">비계량 계획등록 </a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left" class="text"><a href="javascript:openContents(5);">비계량 실적등록 </a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>

                <tr>
                  <td width="30" height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>
                  <td width="130" align="left" class="title_text">성과조회</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left" class="text"><a href="javascript:openContents(11);">성과지표 계획 및 실적 </a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left" class="text"><a href="javascript:openContents(12);">조직별 지표구성 내역</a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
<!--                <tr>-->
<!--                  <td width="30" height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>-->
<!--                  <td width="130" align="left" class="title_text">과제관리</td>-->
<!--                </tr>-->
<!--                <tr>-->
<!--                  <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>-->
<!--                </tr>-->
<!--                <tr>-->
<!--                  <td height="25">&nbsp;</td>-->
<!--                  <td align="left" class="text"><a href="javascript:openContents(6);">과제 등록 </a></td>-->
<!--                </tr>-->
<!--                <tr>-->
<!--                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>-->
<!--                </tr>-->
<!--                <tr>-->
<!--                  <td height="25">&nbsp;</td>-->
<!--                  <td align="left" class="text"><a href="javascript:openContents(7);">과제 실적등록 </a></td>-->
<!--                </tr>-->
<!--                <tr>-->
<!--                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>-->
<!--                </tr> -->
<!--                <tr>-->
<!--                  <td height="25">&nbsp;</td>-->
<!--                  <td align="left" class="text"><a href="javascript:openContents(8);">과제 연계등록 </a></td>-->
<!--                </tr>-->
<!--                <tr>-->
<!--                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>-->
<!--                </tr>                  -->
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
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" background="images/bsub_title_bg.jpg">
        <tr>
          <td>
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="300" valign="bottom">
				  <table height="45" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="11" style="padding-top:5;"><img src="images/bulet01.jpg" width="11" height="21"></td>
                      <td width="5">&nbsp;</td>
                      <td valign="middle" style="padding-top:6;padding-right:5;"><p class="title_b"><font size="3" id="titleText_1">계량지표 실적등록</font></p></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="3" background="images/line01.jpg"><img src="images/line01.jpg" width="6" height="5"></td>
                    </tr>
                  </table>
				</td>
                <td align="right" valign="bottom" style="padding-right:15;">
				  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right" class="td">홈 &gt; 실적등록 &gt; <font id="titleText_2">계량실적</font> &gt; <strong><font id="titleText">계량지표 실적등록</font></strong></td>
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
		    <!---------///본문 컨텐츠 삽입영역 ///--------->
            <IFRAME id="page" name="contents" marginWidth="0" marginHeight="0" src="<%=imgUri%>/jsp/web/actual/deptActual.jsp" frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>
		    <!---------///본문 컨텐츠 삽입영역  끝///--------->
		  </td>
        </tr>
	  </table>
	</td>
    <td width="3" valign="top">&nbsp;</td>
  </tr>
</table>

</body>
</html>
