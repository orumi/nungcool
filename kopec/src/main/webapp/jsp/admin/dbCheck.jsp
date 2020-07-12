<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nc.admin.MessageSet" %>
<%@ page import="com.nc.admin.Message" %>
<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

  //String tag = (String)getServletContext().getAttribute("login");
  ArrayList al = (ArrayList)request.getAttribute("serviceList");
  String toForm = (String)request.getAttribute("toForm");
  MessageSet mSet = (MessageSet)request.getAttribute("mSet");
  
  int count=0;
  if (al!=null)
  	count = al.size();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cool Package </title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
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
//-->
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table height=10><tr><td></td></tr></table>
<img src="<%=imgUri %>/jsp/admin/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
<span class="Text01">DB Check</span>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%" align="center" valign="top" style="padding-top:10pt">
	</td>

    <td width="35%" align="center" valign="top" style="padding-top:10pt"> 
      <!--데이터 베이트 체크 테이블 시작-->
      <form name="" method="post" action="">
      <input type="hidden" name="page" value="dbChecker">
        <table width="553" border="0" cellspacing="2" cellpadding="3" class=s_text>

          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252"><input type="checkbox" name="fixData" value="true">
              데이터 완결성 체크</td>
            <td width="233">&nbsp;</td>
          </tr>
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252"><input type="checkbox" name="fixAddTable" value="true">
              필요한 테이블 추가 </td>
            <td width="233">&nbsp;</td>
          </tr>
          <!--
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252"><input type="checkbox" name="fixAddField" value="true">
              필요한 필드 추가</td>
            <td width="233">&nbsp;</td>
          </tr>
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252"><input type="checkbox" name="fixDrop" value="true">
              불필요한 필드 삭제</td>
            <td width="233">&nbsp;</td>
          </tr>
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252"><input type="checkbox" name="fixType" value="true">
              필드 타입 수정</td>
            <td width="233">&nbsp;</td>
          </tr>
          //-->
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252">&nbsp;</td>
            <td width="233">&nbsp;</td>
          </tr>
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252"><input type="checkbox" name="emptyTable" value="true">
              모든 테이블 내용 삭제</td>
            <td width="233">&nbsp;</td>
          </tr>
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252"><input type="checkbox" name="emptyTableNotUser" value="true">
              사용자 제외 모든 테이블 내용 삭제</td>
            <td width="233">&nbsp;</td>
          </tr>
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252">&nbsp;</td>
            <td width="233">&nbsp;</td>
          </tr>
          <tr> 
            <td width="42" align="right">&nbsp;</td>
            <td width="252"><input type="checkbox" name="dropTable" value="true">
              모든 테이블 삭제</td>
            <td width="233">&nbsp;</td>
          </tr>
          <tr> 
            <td height="22">&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right" valign="bottom" style="padding-top:15pt"><input type="image" name="submit" src="<%=imgUri%>/jsp/web/images/btn_ok.gif" width="50" height="20" border="0"></a></td>
          </tr>
        </table>
      </form> 
      <!--데이터 베이스 체크 테이블 끝-->
    </td>
    <td width="5%">&nbsp;</td>
    <td width="45%" valign="top">&nbsp;</td>
  </tr>
  
  	  <% if(mSet != null){ 
  	  %>
  	      <tr height="16"> 
            <td width="15%" ></td>
            <td width="25%" >
        
  	  <% for (int k=0;k<mSet.getCount();k++){
  	      Message msg = (Message)mSet.getObject(k);  %>
  	    <hr>
  	      <table width="100%" border="0" cellpadding="0" cellspacing="0" ><tr><td width="50"></td><td width="150"></td><td></td></tr>
  	      <tr bgcolor="#CC9966"><td width=60>&nbsp;</td><td> 테이블 명 : </td><td><%= msg.tblName%></td></tr>
  	  <% if(!("".equals(msg.message))&&(msg.message != null)){ %>
  	      <tr><td width=60>&nbsp;</td><td> 메세지 : </td><td><%= msg.message%></td></tr>
  	  <%}%>
      <% if(!("".equals(msg.error))&&(msg.error != null)){ %>
  	      <tr bgcolor="#EADCAA"><font color="#990000"><td width=60>&nbsp;</td><td> 경고 : </td><td><%= msg.error%></td></font></tr>
  	  <%}%>
  	  <% if(!("".equals(msg.define))&&(msg.define != null)){ %>
  	      <tr><td width=60>&nbsp;</td><td> 세부내용 : </td><td><%= msg.define%></td></tr>
  	  <%}%>  	      </table>
        	  <% if(msg.getFieldCount() > 0){  %> <table width="100%" border="0" cellpadding="0" cellspacing="0" ><tr bgcolor="#E3E3F4"><td width="80"></td><td width="150">필드명</td><td width="130">상태</td><td width="110">정보</td><td>처리</td></tr>
  	          <% for (int l=0;l<msg.getFieldCount();l++){  %>
  	            <tr><td width="80"></td><td><%=msg.getNodeFieldName(l)%></td><td><%=msg.getStatus(l)%></td><td><%=msg.getInfo(l)%></td><td><%=msg.getRecom(l)%></td></tr>
  	          <% } %>
  	        </table>
            <% } %>  
  	  <%}%> 
            </td>
            <td width="45%" ></td>
            <td width="5%" valign="top" ></td>
          </tr>
  	  <%}%>
  	  
  	  
  <tr height="16"> 
    <td width="5%" ></td>
    <td width="35%" ></td>
    <td width="5%" ></td>
    <td width="45%" valign="top" ></td>
  </tr>
  <tr height="5" > 
    <td width="5%"  bgcolor="E3E3E3"></td>
    <td width="35%" bgcolor="1D7DAF"></td>
    <td width="5%"  bgcolor="E3E3E3"></td>
    <td width="45%" valign="top"  bgcolor="E3E3E3"></td>
  </tr>

</table>
</body>
</html>
