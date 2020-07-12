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
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/bsc.css" rel="stylesheet" type="text/css">
<jsp:include page="js/js.jsp" flush="true"/>
</head>
<script>
	function openContents(tag){
		if ("1" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/totEval/buzResult.jsp";		
			document.getElementById("titleText").innerText="평가득점 조회";
		} else if ("2" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/totEval/buzAllot.jsp";
			document.getElementById("titleText").innerText="평가지표 배분표";	
		} else if ("3" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/totEval/adminBuzMea.jsp";
			document.getElementById("titleText").innerText="지표관리";		
		} else if ("4" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/totEval/adminBuzAllot.jsp";
			document.getElementById("titleText").innerText="배분(가중치)관리";		
		} else if ("5" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/totEval/adminBuzResultRegi.jsp";
			document.getElementById("titleText").innerText="지표득점 등록";		
		} else if ("6" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/totEval/adminBuzScoreInit.jsp";
			document.getElementById("titleText").innerText="득점배분 관리";		
		} 
	}

</script>
<body leftmargin="0" topmargin="0" marginwidht="0" marginheight="0">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#E3EEFB">
  <tr> 
    <td width="4" valign="top">&nbsp;</td>
    <td width="121" valign="top" id="leftMenu" style="display:inline">
		<table width="121" height="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" background="<%=imgUri %>/jsp/web/images/submenu_full_86.gif">
		  <tr valign="top" height="45"> 
		    <td colspan="3"><img src="<%=imgUri %>/jsp/web/images/submenu_title_07.gif" width="121" height="45"></td>
		  </tr>
		  <tr valign="top"> 
		    <td width="1" valign="top">&nbsp;</td>
		    <td width="111" height="100%" valign="top">
				<!-------//submenu link//------->
				<table width="111" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			        <tr height="2"> 
			          <td></td>
			        </tr>
			        <tr height="25"> 
			          <td align=center><a href="javascript:openContents(1);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub1','','<%=imgUri %>/jsp/web/images/submenu5_01_on.gif',0)"><img src="<%=imgUri %>/jsp/web/images/submenu5_01_off.gif" name="sub1" width="103" height="25" border="0"></a></td>
			        </tr>
			        <tr height="25"> 
			          <td align=center><a href="javascript:openContents(2);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub2','','<%=imgUri %>/jsp/web/images/submenu5_02_on.gif',0)"><img src="<%=imgUri %>/jsp/web/images/submenu5_02_off.gif" name="sub2" width="103" height="25" border="0"></a></td>
			        </tr>
			        <tr height="25"> 
			          <td align=center><a href="javascript:openContents(3);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub3','','<%=imgUri %>/jsp/web/images/submenu5_03_on.gif',0)"><img src="<%=imgUri %>/jsp/web/images/submenu5_03_off.gif" name="sub3" width="103" height="25" border="0"></a></td>
			        </tr> 
			        <tr height="25"> 
			          <td align=center><a href="javascript:openContents(4);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub4','','<%=imgUri %>/jsp/web/images/submenu5_04_on.gif',0)"><img src="<%=imgUri %>/jsp/web/images/submenu5_04_off.gif" name="sub4" width="103" height="25" border="0"></a></td>
			        </tr> 
			        <tr height="25"> 
			          <td align=center><a href="javascript:openContents(5);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub5','','<%=imgUri %>/jsp/web/images/submenu5_05_on.gif',0)"><img src="<%=imgUri %>/jsp/web/images/submenu5_05_off.gif" name="sub5" width="103" height="25" border="0"></a></td>
			        </tr> 	
			        <tr height="25"> 
			          <td align=center><a href="javascript:openContents(6);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub6','','<%=imgUri %>/jsp/web/images/submenu5_06_on.gif',0)"><img src="<%=imgUri %>/jsp/web/images/submenu5_06_off.gif" name="sub6" width="103" height="25" border="0"></a></td>
			        </tr> 				        			        			        			        		        			        
			        <tr height="100%"> 
			          <td>&nbsp;</td>
			        </tr>
		      	</table>
			  	<!-------------->
			  </td>
		    <td width="1" valign="top" >&nbsp;</td>
		  </tr>
		  <tr valign="top"> 
		    <td colspan="3"><img src="<%=imgUri %>/jsp/web/images/submenu_full_88.gif" width="121" height="7"></td>
		  </tr>
		</table>
    
    </td>
    <td width="5" valign="top">&nbsp;</td>
    <td valign="top">
    
			<!------// box //------>
			<table width="100%" height="6" border="0" cellpadding="0" cellspacing="0">
			<tr><td></td></tr>
			</table>
			<!------// box //------>
				<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			      <tr>
				       <td width="6" height="6"><img src="<%=imgUri %>/jsp/web/images/box_01.gif" width="6" height="6"></td>
				       <td background="<%=imgUri %>/jsp/web/images/box_top.gif"><img src="images/box_top.gif" width="6" height="6"></td>
				       <td width="6" height="6"><img src="<%=imgUri %>/jsp/web/images/box_02.gif" width="6" height="6"></td>
			      </tr>
			      <tr>
			          <td background="<%=imgUri %>/jsp/web/images/box_left.gif"><img src="<%=imgUri %>/jsp/web/images/box_left.gif" width="6" height="6"></td>
			          <td height="100%" valign="top">
				          <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
				              <tr> 
				                <td width="300" height="34" background="<%=imgUri %>/jsp/web/images/subtitle_bg_01.gif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				                <span class="big_text"><strong><font color="#FFFFFF"  id="titleText">평가득점 조회</font></strong></span></td>
				                <td background="<%=imgUri %>/jsp/web/images/subtitle_bg.gif">&nbsp;</td>
				                <td width="208" align="right" background="<%=imgUri %>/jsp/web/images/subtitle_bg.gif"><img src="<%=imgUri %>/jsp/web/images/subtitle_bg_02.gif" width="208" height="34"></td>
				              </tr>
				           </table>	
            <!---------///본문 컨텐츠 삽입영역 ///--------->
            <IFRAME id="page" name="contents" marginWidth="0" marginHeight="0" src="<%=imgUri%>/jsp/web/totEval/buzResult.jsp" frameBorder="0" width="100%" scrolling="auto" height="440"></IFRAME>
            <!---------///본문 컨텐츠 삽입영역  끝///--------->
						</td>
			          	<td valign="top" background="<%=imgUri %>/jsp/web/images/box_right.gif"><img src="<%=imgUri %>/jsp/web/images/box_right.gif" width="6" height="6"></td>
			        </tr>
			        <tr>
			          <td><img src="<%=imgUri %>/jsp/web/images/box_03.gif" width="6" height="6"></td>
			          <td background="<%=imgUri %>/jsp/web/images/box_bottom.gif"><img src="<%=imgUri %>/jsp/web/images/box_bottom.gif" width="6" height="6"></td>
			          <td><img src="<%=imgUri %>/jsp/web/images/box_04.gif" width="6" height="6"></td>
			        </tr>
			      </table>
				  <!-------// box End//--------->
				  
				  
	</td>
    <td width="2" valign="top">&nbsp;</td>
  </tr>
</table>

</body>
</html>
