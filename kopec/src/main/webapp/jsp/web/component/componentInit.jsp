<%@ page contentType="text/html; charset=euc-kr" language="java" errorPage="" %>

<%  String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
%>

<html>
<head>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

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

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

//2006.06.19

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
	
	if (tag == 'company'){		
		adminContent.location.href="company.jsp";					
	} else if (tag == 'SBU'){		
		adminContent.location.href="SBU.jsp";						
	} else if (tag == 'BSC'){
	    adminContent.location.href="BSC.jsp";
	} else if (tag == 'PST'){
	    adminContent.location.href="PST.jsp";
	} else if (tag == 'objective'){
	    adminContent.location.href="objective.jsp";
	} else if (tag == 'measure'){
	    adminContent.location.href="measure.jsp";    
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

//-->
</script>
</head>

<body leftmargin="5" topmargin="0" marginwidth="5" onLoad="MM_preloadImages('<%=imgUri%>/jsp/web/images/sumenu8_01_over.gif','images/sumenu8_02_over.gif','images/sumenu8_03_over.gif','images/sumenu8_04_over.gif','images/sumenu8_05_over.gif')">
	<!-----//Box layout//----->
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td colspan="2" valign="top" bgcolor="#FFFFFF"> 
				<!-----//탭메뉴 8개구분하는 테이블//----->
			<br>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr><td background="<%=imgUri%>/jsp/web/images/tapmenu_line_bg.gif">

				<table border="0" cellspacing="0" cellpadding="0">
                    <tr><td>
					  <!----//탭메뉴1(선택시)//---->
					  <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="5"><img src="<%=imgUri%>/jsp/web/images/tap_over_01.gif" id = 'sub11'   width="5" height="23"></td>
                            <td align="center" background="<%=imgUri%>/jsp/web/images/tap_over_bg.gif" id = 'sub12'><img src="<%=imgUri%>/jsp/web/images/tap_over_point.gif"  id = 'sub13' width="5" height="3" align="absmiddle"> 
                              <strong><a href="#"  onClick = "javascript:openFrame('company', sub11, sub12, sub13, sub14);"><font color="#003399">회사&nbsp;</font></a></strong></td>
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
                            <strong><a href="#" onClick = "javascript:openFrame('SBU', sub21, sub22, sub23, sub24);"><font color="#003399">조직구분</font></a></strong></td>
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
                            <strong><a href="#" onClick = "javascript:openFrame('BSC', sub31, sub32, sub33, sub34);"><font color="#003399">조직</font></a></strong></td>
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
                            <strong><a href="#" onClick = "javascript:openFrame('PST', sub41, sub42, sub43, sub44);" ><font color="#003399">관점</font></a></strong></td>
                            <td width="6"><img src="<%=imgUri%>/jsp/web/images/tap_off_02.gif" id = 'sub44' width="6" height="23"></td>
                          </tr>
                      </table>
						<!----//탭메뉴4 끝//---->
					</td><td>
					  <!----//탭메뉴5//---->
					  <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="5"><img src="<%=imgUri%>/jsp/web/images/tap_off_01.gif" id = 'sub51' width="5" height="23"></td>
                            <td align="center" background="<%=imgUri%>/jsp/web/images/tap_off_bg.gif" id = 'sub52'><img src="#"  id = 'sub53' width="5" height="3" align="absmiddle"> 
                            <strong><a href="#" onClick = "javascript:openFrame('objective', sub51, sub52, sub53, sub54);"><font color="#003399">전략과제</font></a></strong></td>
                            <td width="6"><img src="<%=imgUri%>/jsp/web/images/tap_off_02.gif" id = 'sub54' width="6" height="23"></td>
                          </tr>
                      </table>
						<!----//탭메뉴5 끝//---->
					</td><td>
					  <!----//탭메뉴6//---->
					  <table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="5"><img src="<%=imgUri%>/jsp/web/images/tap_off_01.gif" id = 'sub61' width="5" height="23"></td>
                            <td align="center" background="<%=imgUri%>/jsp/web/images/tap_off_bg.gif" id = 'sub62'><img src="#"  id = 'sub63' width="5" height="3" align="absmiddle"> 
                            <strong><a href="#"  onClick = "javascript:openFrame('measure', sub61, sub62, sub63, sub64);"><font color="#003399">성과지표</font></a></strong></td>
                            <td width="6"><img src="<%=imgUri%>/jsp/web/images/tap_off_02.gif" id = 'sub64' width="6" height="23"></td>
                          </tr>
                      </table>
						<!----//탭메뉴6 끝//---->
					</td>
					</tr>
                </table>
				<!-----//탭메뉴 8개구분하는 테이블//----->
			  </td></tr>
              <tr>
                  <td>&nbsp;</td>
              </tr>
            </table> 
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0"><tr><td>
		        <iframe frameborder="0" id="adminContent" src="company.jsp" style="body" width="100%" height="100%" scrolling="no">&nbsp;</iframe>
            </td></tr>
            </table>
          </td>
        </tr>
    </table>
	  <!-----//Box layout end//----->
</body>
</html>
