<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<script language="javascript">
	function change(){
		frpassfind.submit();
	}
	
	onload=function() {
	 moveTo(300,250);
	}

</script>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>find_password</title>
</head>
<body>
<form name = "frpassfind" method="post" action="./fp_Proc.jsp">
<h3> ����� �н����� �ʱ�ȭ</h3>
<table>
	<tr>
	</tr>
	<tr>
		<td>����� Id : </td>
		<td><input Type="text" name = "find_pass"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><img src="images/btn_ok.gif" alt="��й�ȣ ����" width="50" height="20" border="0" onclick="change()" style="cursor:hand">
		<img src="images/btn_cancel.gif" alt="���" width="50" height="20" border="0" onclick="javascript:window.close(); " style="cursor:hand"></td>
	</tr>
</table>
�� ����� ID�� �Է� �� "Ȯ��"��ư�� ������ <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color ="red">"kopec"</font>�� ��й�ȣ�� �ʱ�ȭ �ʴϴ�. 
</form>

</body>
</html>