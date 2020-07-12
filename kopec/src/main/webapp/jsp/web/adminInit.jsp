<%@ page contentType="text/html; charset=euc-kr" language="java" import="java.sql.*" errorPage="" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri%>/jsp/web/css/nungcool_bsc.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript"><!--

//function MM_swapImgRestore() { //v3.0
  //var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
//}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}


//2006.06.19
//mouse over event
var oldSelectObj;

function MM_swapImage(obj, imgSrc) { //v3.0
  	if (oldSelectObj == null) oldSelectObj = document.images.sub1;
	if (obj != oldSelectObj) obj.src = imgSrc;	
}
//mouse out event
function MM_swapImgRestore(obj) { 
  	if (oldSelectObj == null) oldSelectObj = document.images.sub1;
	if (obj != oldSelectObj) obj.src = 	obj.src.substring(0,obj.src.lastIndexOf("_")) + "_off.gif";	  	
}

//mouse click event
function MM_OnImage(obj, imgSrc) {
	//초기화 
	if (oldSelectObj == null) oldSelectObj = document.images.sub1;	
	if (obj != oldSelectObj) {
		obj.src = imgSrc;	
	  	oldSelectObj.src = oldSelectObj.src.substring(0,oldSelectObj.src.lastIndexOf("_")) + "_off.gif";	  	
	  	oldSelectObj = obj;  	
  	}
}

var holdId = "1";
var selectButton;

function changeButtonImg(oImgButton, mode) {
    if (holdId == oImgButton.subid)
        return ;
	var sUrl = oImgButton.src.substring(0, oImgButton.src.lastIndexOf("_"));
	if(sUrl == -1) alert("버튼 이미지명이 올바르지 않습니다...");
	if (mode.toUpperCase() == "ONMOUSEOVER" && sUrl != -1) {
		oImgButton.src = sUrl + "_over.gif";
		oImgButton.style.cursor = "hand";
		return;
	}
    if (mode.toUpperCase() == "ONMOUSEOUT" && sUrl != -1) {
		oImgButton.src = sUrl + "_off.gif";
		oImgButton.style.cursor = "auto";
		return;
	}
}

function holdButton(oImgButton) {
    if (oImgButton != null) {
	    holdId = oImgButton.subid;
    }
	if (selectButton != null){
		changeButtonImg(selectButton, "ONMOUSEOUT");
	} else {
		changeButtonImg(eval("document.all.topmenu1"), "ONMOUSEOUT");
	}
	selectButton = oImgButton;
}


function openMenu(tag){
	if (tag == 'component'){
		adminContent.location.href="component/componentInit.jsp";
	} else if (tag == 'import'){
		adminContent.location.href="import/importInit.jsp";
	} else if (tag == 'evalImport'){
	    adminContent.location.href="eval/evalImportInit.jsp";
	} else if (tag == 'evalView'){
	    adminContent.location.href="eval/evalViewInit.jsp";
	} else if (tag == 'user'){
	    adminContent.location.href="user/userInit.jsp"; 
	} else if (tag == 'measure'){
		adminContent.location.href="adminMeasure/meaInit.jsp"; 
	}
}

//--></script>
</head>

<body background="images/page_bg.gif" leftmargin="5" topmargin="0" marginwidth="5" onLoad="MM_preloadImages('images/sumenu8_01_over.gif','images/sumenu8_02_over.gif','images/sumenu8_03_over.gif','images/sumenu8_04_over.gif','images/sumenu8_05_over.gif')">
<!--------//Page Layout Table //---------->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="160" valign="top"> 
      <!----//관리자 서브메뉴//---->
      <table width="160" height="500" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="46"><img src="images/submenu_title_08.gif" width="160" height="46"></td>
        </tr> 
        <tr> 
          <td valign="top" background="images/submenu_bg.gif"><table width="140" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td>
                <img src="images/sumenu8_01_over.gif" id="topmenu1" idx="1" subid="1" alt="기초정보" width="140" height="25" border="0" onMouseOver="changeButtonImg(this,'onMouseOver')" onMouseOut="changeButtonImg(this, 'onMouseOut');" onclick="holdButton(this);openMenu('component');" style="cursor:hand">
                </td>
              </tr>
              <tr> 
                <td>
                <img src="images/sumenu8_02_off.gif" id="topmenu2" idx="2" subid="2" alt="IMPORT" width="140" height="25" border="0" onMouseOver="changeButtonImg(this,'onMouseOver')" onMouseOut="changeButtonImg(this, 'onMouseOut');" onclick="holdButton(this);openMenu('import');" style="cursor:hand">
                </td>                
              </tr>
              <tr> 
                <td>
                <img src="images/sumenu8_03_off.gif" id="topmenu3" idx="3" subid="3" alt="평가결과 생성" width="140" height="25" border="0" onMouseOver="changeButtonImg(this,'onMouseOver')" onMouseOut="changeButtonImg(this, 'onMouseOut');" onclick="holdButton(this);openMenu('evalImport');" style="cursor:hand">
                </td>
              </tr>																																					  
              <tr> 
                <td>
                <img src="images/sumenu8_04_off.gif" id="topmenu4" idx="4" subid="4" alt="평가결과 실적관리" width="140" height="25" border="0" onMouseOver="changeButtonImg(this,'onMouseOver')" onMouseOut="changeButtonImg(this, 'onMouseOut');" onclick="holdButton(this);openMenu('evalView');" style="cursor:hand">
                </td>
              </tr>
              <tr> 
                <td>
                <img src="images/sumenu8_05_off.gif" id="topmenu5" idx="5" subid="5" alt="사용자 관리" width="140" height="25" border="0" onMouseOver="changeButtonImg(this,'onMouseOver')" onMouseOut="changeButtonImg(this, 'onMouseOut');" onclick="holdButton(this);openMenu('user');" style="cursor:hand">
				</td>
              </tr>
              <tr> 
                <td>
                <img src="images/sumenu8_06_off.gif" id="topmenu6" idx="6" subid="6" alt="지표정의서 승인 관리" width="140" height="25" border="0" onMouseOver="changeButtonImg(this,'onMouseOver')" onMouseOut="changeButtonImg(this, 'onMouseOut');" onclick="holdButton(this);openMenu('measure');" style="cursor:hand">
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table>
      <!----//관리자 서브메뉴 끝//---->
    </td>
    <td width="10">&nbsp;</td>
    <td valign="top">
	<!-- start contents //-->
	    <iframe frameborder="0" id="adminContent" src="component/componentInit.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
	<!-- end of contents //-->  
    </td></tr>
</table>
<!--------//Page Layout Table End//---------->
</body>
</html>
