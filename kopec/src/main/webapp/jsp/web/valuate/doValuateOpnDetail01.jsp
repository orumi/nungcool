<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>
    
<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	
	ValuateUtil util = new ValuateUtil();
	util.setOpinionDetail01(request,response);
	
	DataSet ds = (DataSet) request.getAttribute("ds");
	
	String grpId = request.getParameter("grpId");
	String year = request.getParameter("year");
	
	String best = "";
	String worst = "";
	
	if (ds!=null) while (ds.next()){
		best = ds.getString("BEST");
		worst = ds.getString("WORST");
	}
%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<html>
<head>
<script>

	function actionPerformed(tag) {
		if (tag=='A') {
			form1.mode.value = tag;
			form1.submit();
		} else if (tag == 'D'){
			if (confirm("�ۼ��� ������ �����Ͻðڽ��ϱ�?")){
				form1.mode.value = tag;
				form1.submit();			
			}
		}
	}
	

</script>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body leftmargin="8" topmargin="0" marginwidth="0">
			<form name="form1" method="post" action="">
			<input type="hidden" name="year" value="<%=year %>">
			<input type="hidden" name="grpId" value="<%=grpId %>">
			<input type=hidden name=mode>
			<!---//�ش��� �μ�����//----->
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong>
                	<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle"> 
                  		�򰡰�� �ǰ߼�</strong></td>
              </tr>
            </table>
            <table id="tbl0" width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				  <tr> 
				    <td width="15%" bgcolor="#D4DCF4">�ֻ��� ���� �ǰ�</td>
				  </tr>
				  <tr bgcolor="#FFFFFF">
				  	<td><textarea cols="70" rows="11" name=best><%=best %></textarea></td>
				  </tr>
				  <tr> 
				    <td width="15%" bgcolor="#D4DCF4">������ ���� �ǰ�</td>
				  </tr>
				  <tr bgcolor="#FFFFFF">
				  	<td><textarea cols="70" rows="11" name=worst><%=worst %></textarea></td>
				  </tr>			  							  	  				  			  				  				  				  				  		  
            </table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
              <tr bgcolor="#FFFFFF"> 
                  <td colspan="9" align="right"> 
                    <a href="javascript:actionPerformed('A');"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a> 
                    &nbsp;
                    <a href="javascript:actionPerformed('D');"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a> 
                  </td>
              </tr>
            </table>            
            </form>
            <!--------//������ǥ �����Է�//-------->

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//����  KPI ���� ��û ����Ʈ ��//-------->
<SCRIPT>
<!--

	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}

//-->
</SCRIPT>
</body>
</html>