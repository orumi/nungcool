<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.nc.util.*" %>
<% String userName = (String)session.getAttribute("userName");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>pass change</title>
<style type="text/css">
 	#input{
 		width:130px;
 		border:1px solid black;
 	}
</style>
<script language="javascript">
	function pass_change(){
		frpass.submit();
	}
	onload=function() {
		 moveTo(300,250);
	}
</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/login_visual.jpg">
                  <form  name="frpass" method="post" action="passProc.jsp">
				<br>
				<left><b><h4>&nbsp;&nbsp;��й�ȣ ����</h4></left>

                  <table align="center" width="290" border="0" cellspacing="0" cellpadding="0">
                    <tr>
						<td height="24"><b>����� �̸� &nbsp;&nbsp;&nbsp;: </td>
                        <td><input name="cnpass" type="text" id="input" disabled value ="<%= userName %>" ></td>
					</tr>
                      <tr> 
                        <td height="24"><b>���� ��й�ȣ : </td>
                        <td><input name="passwd" type="password" id="input"></td>
                      </tr>
                      <tr> 
                        <td height="24"><b>�ű� ��й�ȣ : </td>
                        <td><input name="npass" type="password" id="input"></td>
                      </tr>
                      <tr> 
                        <td height="24"><b>��й�ȣ Ȯ�� : </td>
                        <td><input name="cnpass" type="password" id="input"></td>
                      </tr>
                      <tr> 
                        <td height="43">&nbsp;</td>
                        <td align="right"><img src="images/btn_ok.gif" alt="��й�ȣ ����" width="50" height="20" border="0" onclick="pass_change()" style="cursor:hand">
										  <img src="images/btn_cancel.gif" alt="���" width="50" height="20" border="0" onclick="javascript:window.close(); " style="cursor:hand"></td>
                      </tr>

                    
                  </table>
  
</body>
</html>