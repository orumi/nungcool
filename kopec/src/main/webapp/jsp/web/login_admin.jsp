<%@ page contentType="text/html; charset=euc-kr"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script language="javascript">
	function go_login(){
		frm.submit();
	}
	
</script>
</head>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="350" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<form name="frm" method="post" action="loginProc_admin.jsp">
	<tr align="center" bgcolor="#D4DCF4">
		<td width="150"><strong><font color="#003399">�����ID</font></strong></td>
		<td width="200"  bgcolor="#FFFFFF"><input type="text" name="userId" value="40437"></td>
		<td width="0"  bgcolor="#FFFFFF"><input type="hidden" name="flag" value="Y"></td>		
	</tr>
</table>
<table width="350" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align=right><input type="button" value="�α���" onclick="go_login();"></td>
	</tr>
</form>
</table>
</body>
</html>