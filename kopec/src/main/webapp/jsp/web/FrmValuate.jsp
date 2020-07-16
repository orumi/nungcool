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
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/valuateActual.jsp";
			document.getElementById("titleText").innerText="실행실적 등록";
			document.getElementById("titleText_1").innerText="실행실적 등록";
		} else if ("2" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/doValuateInit.jsp";
			document.getElementById("titleText").innerText="비계량 지표평가(년)";
			document.getElementById("titleText_1").innerText="비계량 지표평가(년)";
		} else if ("3" == tag) {
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/valuateView.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/valuate/result/valuateView.do";

			document.getElementById("titleText").innerText="평가 결과 보기";
			document.getElementById("titleText_1").innerText="평가 결과 보기";
		} else if ("4"==tag) {
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/adjustValuate.jsp";
			document.getElementById("titleText").innerText="평가 결과 반영";
			document.getElementById("titleText_1").innerText="평가 결과 반영";
		} else if ("5" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/valuateView.jsp";
			document.getElementById("titleText").innerText="평가 결과 보기";
			document.getElementById("titleText_1").innerText="평가 결과 보기";
		} else if ("6" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/adjustValuate.jsp";
			document.getElementById("titleText").innerText="평가 결과 반영";
			document.getElementById("titleText_1").innerText="평가 결과 반영";
		} else if ("7" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/doValuateInit2007_1.jsp";
			document.getElementById("titleText").innerText="비계량 지표평가 2007";
			document.getElementById("titleText_1").innerText="비계량 지표평가 2007";
		} else if ("8" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/doValuateOrgInit.jsp";

			document.getElementById("titleText").innerText="비계량 지표평가";
			document.getElementById("titleText_1").innerText="비계량 지표평가";
		}  else if ("9" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/doValuate.jsp";
			document.getElementById("titleText").innerText="비계량 지표평가(년)flex";
			document.getElementById("titleText_1").innerText="비계량 지표평가(년)flex";
		}
	}

</script>
<body onLoad="MM_preloadImages('images/menu01_over.jpg','images/menu02_over.jpg','images/menu03_over.jpg','images/menu04_over.jpg','images/menu05_over.jpg','images/menu06_over.jpg','images/menu07_over.jpg')">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" height="100%" align="center" valign="top">
	  <table width="170" height="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center" colspan="3" height="50"><img src="images/sub_title05.jpg" width="163" height="50"></td>
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
                  <td width="130" align="left" class="title_text">비계량평가</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
                </tr>
<!--                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left" class="text"><a href="javascript:openContents(1);">실행실적 등록 </a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>

                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><span class="text"><a href="javascript:openContents(7);">비계량 지표평가 2007</a></span></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
-->
                  <td height="25">&nbsp;</td>
                  <td align="left"><span class="text"><a href="javascript:openContents(8);">비계량 지표평가</a></span></td>
                </tr>
<!--
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                  </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><span class="text"><a href="javascript:openContents(2);">비계량 지표평가(년)</a></span></td>
                </tr>
-->
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><span class="text"><a href="javascript:openContents(3);">평가 결과 보기</a></span></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
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
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" background="images/bsub_title_bg.jpg" style="background-repeat: repeat-x">
        <tr>
          <td>
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="300" valign="bottom">
				  <table height="45" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="11" style="padding-top:5;"><img src="images/bulet01.jpg" width="11" height="21"></td>
                      <td width="5">&nbsp;</td>
                      <td valign="middle" style="padding-top:6;padding-right:5;"><p class="title_b"><font size="3" id="titleText_1">비계량 지표평가</font></p></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="3" background="images/line01.jpg"><img src="images/line01.jpg" width="6" height="5"></td>
                    </tr>
                  </table>
				</td>
                <td align="right" valign="bottom" style="padding-right:15;">
				  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right" class="td">홈 &gt; 비계량 성과평가 &gt; 비계량평가 &gt; <strong><font id="titleText">비계량 지표평가</font></strong></td>
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
            <IFRAME id="page" name="contents" marginWidth="0" marginHeight="0" src="<%=imgUri%>/jsp/web/valuate/doValuateOrgInit.jsp" frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>
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
