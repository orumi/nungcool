<%@ page contentType="text/html; charset=euc-kr"%>

<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	

%>
<html>
<head>
<title>::: 평가관리 :::</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
    function funcSetDate(curYear) {
      for (i=0,j=curYear-5; i<=10;i++,j++) {
      	 form1.year.options[i] = new Option(j, j);
      }
      form1.year.options[5].selected=true;
    }
	
	function changeDate(){
		 document.getElementById("list").style.display = "none";
	}    
    
    function actionPerformed(){
		list.form1.strDate.value = form1.year.options[form1.year.selectedIndex].value+form1.month.options[form1.month.selectedIndex].value;
		list.form1.submit();
		document.getElementById("list").style.display = "inline";
    }
</script>
</head>
<br>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="100%" valign="top"> 
            <!------//상단검색//----->
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
              <form name="form1" method="post" action="">
                <tr bgcolor="#DCEDF6"> 
                  <td width="14%" align="center"><strong><font color="#006699">평가년도</font></strong></td>
                  <td width="86%" bgcolor="#FFFFFF">
                    <select name="year" onChange="javascript:changeDate();">
                    <script> funcSetDate(<%="2007"%>); </script>
                    </select>
                    <select name="month" onChange="javascript:changeDate();">
                      <option value="06" >상반기</option>
                      <option value="12" >하반기</option>
                    </select>
                    <a href="javascript:actionPerformed();"><img src="<%=imgUri%>/jsp/web/images/btn_ok.gif" alt="확인" width="50" height="20" border="0" align="absmiddle"></a> 
                  </td>
                </tr>
              </form>
            </table>
            <!-------//상단검색 끝//------->
          </td>
        </tr>
      </table>
      <br>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	   <tr><td width="100%" valign="top"> 
          <iframe frameborder="0" id="list" src="adminViewList.jsp" style="body" width="100%" height="400" >&nbsp;</iframe>	
       </td></tr>
      </table>
</body>
</html>