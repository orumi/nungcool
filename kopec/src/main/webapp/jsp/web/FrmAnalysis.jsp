<%@ page contentType="text/html; charset=euc-kr" %>

<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>:::  :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!--
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
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/ScoreTable.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/analysis/orgAnalysis/orgAnalysis.do";
			document.getElementById("titleText").innerText="조직별 실적분석";
			document.getElementById("titleText_1").innerText="조직별 실적분석";
			document.getElementById("titleText_2").innerText="성과분석";
		} else if ("2" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/measureTable.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/analysis/meaAnalysis/meaAnalysis.do";
			document.getElementById("titleText").innerText="지표별 실적분석";
			document.getElementById("titleText_1").innerText="지표별 실적분석";
			document.getElementById("titleText_2").innerText="성과분석";
		} else if ("3" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/analyDivisions.jsp";
			document.getElementById("titleText").innerText="조직별 성과추이";
			document.getElementById("titleText_1").innerText="조직별 성과추이";
			document.getElementById("titleText_2").innerText="성과분석";
		}  else if ("4" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/analyAnnually.jsp";
			document.getElementById("titleText").innerText="연도별 성과추이";
			document.getElementById("titleText_1").innerText="연도별 성과추이";
			document.getElementById("titleText_2").innerText="성과분석";
		}  else if ("5" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgMeasStatus.jsp";
			document.getElementById("titleText").innerText="조직별 지표구성 내역";
			document.getElementById("titleText_1").innerText="조직별 지표구성 내역";
			document.getElementById("titleText_2").innerText="성과분석";
		}  else if ("6" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/import/measureExcel.jsp";
			document.getElementById("titleText").innerText="지표정의서 엑셀출력";
			document.getElementById("titleText_1").innerText="지표정의서 엑셀출력";
			document.getElementById("titleText_2").innerText="성과분석";
		} else if ("10" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/rptForCEO.jsp";
			document.getElementById("titleText").innerText="성과관리 리포트";
			document.getElementById("titleText_1").innerText="성과관리 리포트";
			document.getElementById("titleText_2").innerText="성과분석";
		} else if ("11" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgMeasDetail.jsp";
			document.getElementById("titleText").innerText="성과지표 계획 및 실적";
			document.getElementById("titleText_1").innerText="성과지표 계획 및 실적";
			document.getElementById("titleText_2").innerText="성과분석";
		} else if ("12" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgMeasEvalComment.jsp";
			document.getElementById("titleText").innerText="비계량지표 평가의견";
			document.getElementById("titleText_1").innerText="비계량지표 평가의견";
			document.getElementById("titleText_2").innerText="성과분석";
		} else if ("13" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptMeasRanking.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/analysis/meaRank/meaRank.do";
			document.getElementById("titleText").innerText="지표별 조직순위";
			document.getElementById("titleText_1").innerText="지표별 조직순위";
			document.getElementById("titleText_2").innerText="성과분석";
		}  else if ("14" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgRanking.jsp";
			document.getElementById("titleText").innerText="년도별 조직순위";
			document.getElementById("titleText_1").innerText="년도별 조직순위";
			document.getElementById("titleText_2").innerText="성과분석";


		}  else if ("7" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/evalPersonScoreCard.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/analysis/psn/psnEmpScore.do";
			document.getElementById("titleText").innerText="최종성과지급율(책임급이하)";
			document.getElementById("titleText_1").innerText="최종성과지급율(책임급이하)";
			document.getElementById("titleText_2").innerText="성과분석";
		}
	}

</script>
<body leftmargin="0" topmargin="0"  onLoad="MM_preloadImages('images/topmenu_01_off.gif','images/topmenu_01_over.gif','images/topmenu_02_over.gif','images/topmenu_03_over.gif','images/topmenu_04_over.gif','images/topmenu_05_over.gif','images/topmenu_06_over.gif','images/topmenu_07_over.gif')">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" height="100%" align="center" valign="top">
	  <table width="170" height="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center" colspan="3" height="50"><img src="images/sub_title03.jpg" width="163" height="50"></td>
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
                  <td width="130" align="left" class="title_text">성과분석</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
                </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><span class="text"><a href="javascript:openContents(10);">성과관리 리포트</a></span></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
              </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><span class="text"><a href="javascript:openContents(1);">조직별 실적분석</a></span></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
              </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><a href="javascript:openContents(2);">지표별 실적분석</a> </td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
              </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><a href="javascript:openContents(13);">지표별 조직순위</a> </td>
              </tr>
              <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
               </tr>
               <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(6);">지표정의서 엑셀출력</a> </td>
               </tr>
               <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
               </tr>
               <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(7);">최종성과지급율<br>(책임급이하)</a> </td>
               </tr>
               <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
               </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
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
                      <td valign="middle" style="padding-top:6;padding-right:5;"><p class="title_b"><font size="3" id="titleText_1">성과관리 리포트</font></p></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="3" background="images/line01.jpg"><img src="images/line01.jpg" width="6" height="5"></td>
                    </tr>
                  </table>
				</td>
                <td align="right" valign="bottom" style="padding-right:15;">
				  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right" class="td">홈 &gt; 성과분석 &gt; <font id="titleText_2">성과분석</font> &gt; <strong><font id="titleText">성과관리 리포트</font></strong></td>
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
            <IFRAME id="page" name="contents" marginWidth="0" marginHeight="0" src="<%=imgUri%>/jsp/web/eval/rptForCEO.jsp" frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>
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
