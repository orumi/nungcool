<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.totEval.*,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	String year = request.getParameter("year")!=null?request.getParameter("year"):Util.getToDay().substring(0,4);
	
	String userId = (String)session.getAttribute("userId");
	
	
	if (userId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {
		
%>
<SCRIPT>

var oldObj1;
var oldObj2;
var oldObj3;
var oldObj4;

function openFrame(tag, obj1, obj2, obj3, obj4){
		
	if (oldObj1 == null) oldObj1 = document.images.sub11;
	if (oldObj2 == null) oldObj2 = document.all.sub12;
	if (oldObj3 == null) oldObj3 = document.images.sub13
	if (oldObj4 == null) oldObj4 = document.images.sub14;
	
	if (obj1 == oldObj1) return 0;
	if (obj2 == oldObj2) return 0;
	if (obj3 == oldObj3) return 0;
	if (obj4 == oldObj4) return 0;	
	
	if (tag == 'scr0'){		
		adminContent.location.href="adminBuzScore.jsp";					
	} else if (tag == 'scr1'){		
		adminContent.location.href="adminBuzScore01.jsp";						
	} else if (tag == 'scr2') {
		adminContent.location.href="adminBuzScore02.jsp";
	} else if (tag == 'scr') {
		adminContent.location.href="adminBuzScoreFinal.jsp";
	}
	
	obj1.src = "<%=imgUri%>/jsp/web/images/tap_over_01.gif";
	obj2.background = "<%=imgUri%>/jsp/web/images/tap_over_bg.gif";
	obj3.src = "<%=imgUri%>/jsp/web/images/tap_over_point.gif";
	obj4.src = "<%=imgUri%>/jsp/web/images/tap_over_02.gif";
	
  	oldObj1.src = "<%=imgUri%>/jsp/web/images/tap_off_01.gif";
  	oldObj2.background = "<%=imgUri%>/jsp/web/images/tap_off_bg.gif";	  	
	oldObj3.src = "";
	oldObj4.src = "<%=imgUri%>/jsp/web/images/tap_off_02.gif";	
  		
  	oldObj1 = obj1;
  	oldObj2 = obj2;
  	oldObj3 = obj3;
  	oldObj4 = obj4;
	
}
</SCRIPT>
<html>
<head>
<title>::: 실적관리 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
				<table border="0" cellspacing="0" cellpadding="0">
                    <tr><td>
					  <!----//탭메뉴1(선택시)//---->
					  <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="5"><img src="<%=imgUri%>/jsp/web/images/tap_over_01.gif" id = 'sub11'   width="5" height="23"></td>
                            <td align="center" background="<%=imgUri%>/jsp/web/images/tap_over_bg.gif" id = 'sub12'><img src="<%=imgUri%>/jsp/web/images/tap_over_point.gif"  id = 'sub13' width="5" height="3" align="absmiddle"> 
                              <strong><a href="#"  onClick = "javascript:openFrame('scr0', sub11, sub12, sub13, sub14);"><font color="#003399">지표득점&nbsp;</font></a></strong></td>
                            <td width="6"><img src="<%=imgUri%>/jsp/web/images/tap_over_02.gif"  id = 'sub14' width="6" height="23"></td>
                          </tr>
                      </table>
						<!----//탭메뉴1 끝//---->
					</td><td>
					  <!----//탭메뉴2//---->
					  <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="5"><img src="<%=imgUri%>/jsp/web/images/tap_off_01.gif" id = 'sub21' width="5" height="23"></td>
                            <td align="center" background="<%=imgUri%>/jsp/web/images/tap_off_bg.gif" id = 'sub22'><img src="#"  id = 'sub23' width="5" height="3" align="absmiddle"> 
                            <strong><a href="#" onClick = "javascript:openFrame('scr1', sub21, sub22, sub23, sub24);"><font color="#003399">순위득점</font></a></strong></td>
                            <td width="6"><img src="<%=imgUri%>/jsp/web/images/tap_off_02.gif"  id = 'sub24' width="6" height="23"></td>
                          </tr>
                      </table>
						<!----//탭메뉴2 끝//---->
					</td><td>
					  <!----//탭메뉴3//---->
					  <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="5"><img src="<%=imgUri%>/jsp/web/images/tap_off_01.gif" id = 'sub31' width="5" height="23"></td>
                            <td align="center" background="<%=imgUri%>/jsp/web/images/tap_off_bg.gif" id = 'sub32'><img src="#"  id = 'sub33' width="5" height="3" align="absmiddle"> 
                            <strong><a href="#" onClick = "javascript:openFrame('scr2', sub31, sub32, sub33, sub34);"><font color="#003399">향상득점</font></a></strong></td>
                            <td width="6"><img src="<%=imgUri%>/jsp/web/images/tap_off_02.gif"  id = 'sub34' width="6" height="23"></td>
                          </tr>
                        </table>
						<!----//탭메뉴3 끝//---->
					</td><td> 
					  <!----//탭메뉴4//---->
					  <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="5"><img src="<%=imgUri%>/jsp/web/images/tap_off_01.gif" id = 'sub41' width="5" height="23"></td>
                            <td align="center" background="<%=imgUri%>/jsp/web/images/tap_off_bg.gif" id = 'sub42'><img src="#"  id = 'sub43' width="5" height="3" align="absmiddle"> 
                            <strong><a href="#" onClick = "javascript:openFrame('scr', sub41, sub42, sub43, sub44);"><font color="#003399">최종점수 등록</font></a></strong></td>
                            <td width="6"><img src="<%=imgUri%>/jsp/web/images/tap_off_02.gif"  id = 'sub44' width="6" height="23"></td>
                          </tr>
                        </table>
						<!----//탭메뉴4 끝//---->
					</td><td> 					
					</td>
					</tr>
                </table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"  id="tblList">
	<tr>
		<td width="100%">
			<iframe frameborder="0" id="adminContent" src="adminBuzScore.jsp" style="body" width="100%" height="350">&nbsp;</iframe>
		</td>
	</tr>
</table>
<!---------///본문 컨텐츠 삽입영역  끝///--------->

<!-----//Box layout end//----->
</body>
</html>
<% } %>
