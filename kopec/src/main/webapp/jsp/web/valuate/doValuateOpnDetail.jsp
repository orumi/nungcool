<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	ValuateUtil util = new ValuateUtil();
	util.setOpinionDetail(request,response);
	
	DataSet ds = (DataSet) request.getAttribute("ds");
	
	String year = request.getParameter("year")!=null?request.getParameter("year"):"";
	String month = request.getParameter("month")!=null?request.getParameter("month"):"";
	String grpId = request.getParameter("grpId")!=null?request.getParameter("grpId"):"";
	String measureId = request.getParameter("measureId")!=null?request.getParameter("measureId"):"";
	String mcId = request.getParameter("mcId")!=null?request.getParameter("mcId"):"";
	String mode = request.getParameter("mode")!=null?request.getParameter("mode"):"";
	String bname = request.getParameter("bname")==null?"":Util.getEUCKR(request.getParameter("bname"));
	
	String opinion = "";
	
	if (ds!=null) while (ds.next()){
		opinion = ds.getString("EVALOPINION");
	}
%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<html>
<head>
<script>

	function actionPerformed(tag) {
		if (tag=='A') {
			parent.showOpn('<%=mcId%>','<%=bname%>',tag);
		} else if (tag == 'D'){
			if (confirm("작성한 내용을 삭제하시겠습니까?")){
				parent.showOpn('<%=mcId%>','<%=bname%>',tag);
			}
		}
	}
	

</script>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body leftmargin="0" topmargin="3" marginwidth="0">
<!---//해당년월 부서선택//----->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<form name="form1" method="post" action="">
<input type="hidden" name="year">
<input type="hidden" name="month">
<input type="hidden" name="grpId">
<input type="hidden" name="measureId">
<input type="hidden" name="mcId">
<input type="hidden" name="bname">
<input type=hidden name=mode>
  <tr>
    <td height="30"><strong>
    	<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle"> 
      		평가결과 의견서</strong></td>
  </tr>
</table>
<table  width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr> 
	  <td width="15%" bgcolor="#D4DCF4">
	  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  	<tr><td width="45%"><b>조직: <%=bname %></b></td>
	  		<td width="55%" align="right">※ 상단의 조직를 선택하시면 의견서를 보실 수 있습니다.</td>
	  	</tr>
	  </table>
	  </td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<%if (bname == "") { %>
		<td colspan="2"><textarea style="width:100%" rows="10" name="txtOpn"onclick="javascript:alert('조직명을 선택후 작성해주세요')"><%=opinion %></textarea></td>
		<%}else {  %>
		<td colspan="2"><textarea style="width:100%" rows="10" name="txtOpn"><%=opinion %></textarea></td>
		<%} %>
	</tr>			  							  	  				  			  				  				  				  				  		  
 </table>
 <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
   <tr bgcolor="#FFFFFF"> 
       <td colspan="9" align="right"> 
         <a href="javascript:actionPerformed('A');"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" align="absmiddle"></a> 
         &nbsp;
         <a href="javascript:actionPerformed('D');"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a> 
       </td>
   </tr>
</form>
</table>            
</body>
</html>