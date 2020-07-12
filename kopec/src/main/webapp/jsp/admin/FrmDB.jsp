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
<link href="css/bsc.css" rel="stylesheet" type="text/css">
<jsp:include page="js/js.jsp" flush="true"/>
</head>
<script>

	var selPage =null;
	function openContents(tag){
		if ("1" == tag){

			if (selPage!=null){
				selPage.width="0%";
				selPage.height="0%";
			}
			selPage = document.getElementById("page1");
			document.getElementById("page1").width="100%";
			document.getElementById("page1").height="100%";			
			//imgTitle.src="images/title_img1_01.gif";
		} else if ("2" == tag){

			if (selPage!=null){
				selPage.width="0%";
				selPage.height="0%";
			}
			selPage = document.getElementById("page2");	
			document.getElementById("page2").width="100%";
			document.getElementById("page2").height="100%";							
			//imgTitle.src="images/title_img1_02.gif";
		} else if ("3" == tag){

			if (selPage!=null){
				selPage.width="0%";
				selPage.height="0%";
			}
			selPage = document.getElementById("page3");	
			selPage.width="100%";
			selPage.height="100%";						
			//imgTitle.src="images/title_img1_03.gif";		
		} else if ("4" == tag){

			if (selPage!=null){
				selPage.width="0%";
				selPage.height="0%";
			}
			selPage = document.getElementById("page4");	
			document.getElementById("page4").width="100%";
			document.getElementById("page4").height="100%";						
			//imgTitle.src="images/title_img1_04.gif";		
		}
	}
	
	function openScoreTable(dId,tId,level,year,month){
		var scoreTable=document.getElementById("page3");

			if (selPage!=null){
				selPage.width="0%";
				selPage.height="0%";
			}
			selPage = scoreTable;
			scoreTable.width="100%";
			scoreTable.height="100%";						
			imgTitle.src="images/title_img1_03.gif";	
			
			page3.openScoreIcon(dId,tId,level,year,month);
		
	}
	
	function openMeasureTable(year,sbuId,bscId,mid){
		var measureTable=document.getElementById("page4");
		
			if (selPage!=null){
				selPage.width="0%";
				selPage.height="0%";
			}
			selPage = document.getElementById("page4");	
			document.getElementById("page4").width="100%";
			document.getElementById("page4").height="100%";						
			imgTitle.src="images/title_img1_04.gif";	
			
			page4.openMeasureTable(year,sbuId,bscId,mid);
	
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
</script>
<body background="images/page_bg.gif" leftmargin="0" topmargin="0"  >
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="160" valign="top" id="leftMenu" style="display:inline"> 
	  <table width="160" height="500" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="46"><img src="<%=imgUri %>/jsp/admin/images/submenu_title_02.gif" width="160" height="46"></td>
        </tr>
        <tr> 
          <td valign="top" background="../web/images/submenu_bg.gif">
          <table width="140" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
          <td><a href="javascript:openContents(1);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub1','','<%=imgUri %>/jsp/admin/images/submenu2_01.over.gif',0)"><img src="<%=imgUri %>/jsp/admin/images/submenu2_01.off.gif" name="sub1" width="140" height="25" border="0"></a></td>
              </tr>
              <tr> 
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
    <td width="10">&nbsp;</td>
    <td valign="top">
	
	<!-----// 우측 본문Box layout//----->
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">

        <tr> 
          <td background="images/box_side_left.gif">&nbsp;</td>
          <td colspan="2" valign="top" bgcolor="#FFFFFF">
            <!---------///본문 컨텐츠 삽입영역 ///--------->
            <IFRAME id="page1" name="contents1" marginWidth="0" marginHeight="0" src="<%=imgUri%>/jsp/admin/dbCheck.jsp" frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>
            <!---------///본문 컨텐츠 삽입영역  끝///--------->
          </td>
          <td background="images/box_side_right.gif">&nbsp;</td>
        </tr>
        <tr> 
          <td height="5"><img src="images/box_down_left.gif" width="5" height="5"></td>
          <td colspan="2" background="images/box_down_bg.gif"><img src="images/box_down_bg.gif" width="5" height="5"></td>
          <td><img src="images/box_down_right.gif" width="5" height="5"></td>
        </tr>
        <tr> 
          <td height="5" colspan="4"><img src="images/5px.gif" width="5" height="5"></td>
        </tr>
      </table>
	  </td>
  </tr>
</table>

</body>
</html>
<script>
   selPage = document.getElementById("page1");
</script>
