<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
	String curYear = Util.getToDay().substring(0,4);
%>
<script>

    function funcSetDate(curYear) {
      for (i=0,j=curYear-5; i<=10;i++,j++) {
      	 form1.year.options[i] = new Option(j, j);
      }
      form1.year.options[5].selected=true;
    }
 
	function getList(){
		detail.clearSelect();
		detail.form1.tag.value="G";
		detail.form1.strDate.value = form1.year.options[form1.year.selectedIndex].value+form1.semester.options[form1.semester.selectedIndex].value;
//		detail.form1.strDate.value = form1.year.options[form1.year.selectedIndex].value+12;
		detail.form1.submit();	
	}
	
	function clearDetail(){
		detail.clearSelect();
	}
</script>
<html>
<head>
<title>::: 평가관리 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<table width="100%" height="450" border="0" cellpadding="0" cellspacing="0">
  <tr><td valign="top">
      <!-------------------//Page Contents Area(iframe & include)//-------------------->
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="100%" valign="top"> 
            <!------//상단검색//----->
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
              <form name="form1" method="post" action="">
                <tr bgcolor="#DCEDF6"> 
                  <td width="14%" align="center"><strong><font color="#006699">평가년월</font></strong></td>
                  <td width="86%" bgcolor="#FFFFFF">
		             <select name="year" onChange="javascript:clearDetail();">
						<script>funcSetDate(<%=curYear%>)</script>
		             </select>년 
                        <select name="semester" onChange="javascript:clearDetail();">
		                <option value="03" >1/4분기</option>
		                <option value="06" >2/4분기</option>
		                <option value="09" >3/4분기</option>
		                <option value="12" >4/4분기</option>
                    </select>
    
                    <a href="javascript:getList();"><img src="<%=imgUri%>/jsp/web/images/btn_ok.gif" alt="확인" width="50" height="20" border="0" align="absmiddle"></a> 
                  </td>
                </tr>
              </form>
            </table>
            <!-------//상단검색 끝//------->
          </td>
        </tr>
      </table>
	  
	  <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
	  <tr><td>
	  	<iframe frameborder="0" id="detail" src="adminGroupDetail.jsp" style="body" width="100%" height="450" >&nbsp;</iframe>	
      </td></tr>
      </table>

      <!-------------------//Page Contents Area End//-------------------->
    </td>
  </tr>

</table>
</body>
</html>