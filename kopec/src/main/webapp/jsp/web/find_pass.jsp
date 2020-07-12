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
<h3> 사용자 패스워드 초기화</h3>
<table>
	<tr>
	</tr>
	<tr>
		<td>사용자 Id : </td>
		<td><input Type="text" name = "find_pass"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><img src="images/btn_ok.gif" alt="비밀번호 수정" width="50" height="20" border="0" onclick="change()" style="cursor:hand">
		<img src="images/btn_cancel.gif" alt="취소" width="50" height="20" border="0" onclick="javascript:window.close(); " style="cursor:hand"></td>
	</tr>
</table>
※ 사용자 ID를 입력 후 "확인"버튼을 누르면 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color ="red">"kopec"</font>로 비밀번호가 초기화 됨니다. 
</form>

</body>
</html>