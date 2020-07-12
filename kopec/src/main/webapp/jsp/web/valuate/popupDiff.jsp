<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table width="96%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
  <tr align="center" bgcolor="#D4DCF4"> 
    <td bgcolor="#D4DCF4"><strong><font color="#003399">조직명</font></strong></td>
    <td bgcolor="#D4DCF4"><strong><font color="#003399">성과지표명</font></strong></td>
    <td><strong><font color="#003399">BSC실적</font></strong></td>
    <td><strong><font color="#003399">평가점수</font></strong></td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td>자재관리팀</td>
    <td><a href="#">고객 만족도 제고</a></td>
    <td align="center">87</td>
    <td align="center">34</td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>