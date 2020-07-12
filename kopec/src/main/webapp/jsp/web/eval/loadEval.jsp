<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
<br>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
              <form action="" method="post" enctype="multipart/form-data" name="form1">
                <tr bgcolor="#DCEDF6"> 
                  <td width="14%" align="center"><strong><font color="#006699"> 
                    해당년월</font></strong></td>
                  <td bgcolor="#FFFFFF"><select name="select">
                      <option value="2007">2007</option>
                    </select> <select name="select2">
                      <option value="01">01</option>
                      <option value="02">02</option>
                    </select> </td>
                  <td width="14%" align="center" bgcolor="#DCEDF6"><strong><font color="#006699">부서그룹</font></strong></td>
                  <td bgcolor="#FFFFFF"><select name="select3">
                      <option value="01">생산 관리처</option>
                    </select>
                    <a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_ok.gif" alt="확인" width="50" height="20" border="0" align="absmiddle"></a></td>
                </tr>
                <tr bgcolor="#DCEDF6"> 
                  <td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">파일선택</font></strong></td>
                  <td colspan="3" bgcolor="#FFFFFF"><input name="file" type="file" class="input_box"> 
                  </td>
                </tr>
              </form>
            </table> 
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table>
			<!---// 리스트//----->
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr align="center" bgcolor="#D4DCF4"> 
                <td bgcolor="#D4DCF4"><strong><font color="#003399">부서명</font></strong></td>
                <td><strong><font color="#003399">BSC 점수(A)</font></strong></td>
                <td><strong><font color="#003399">부서평가점수(B)</font></strong></td>
                <td><strong><font color="#003399">합계(A+B)</font></strong></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td align="center">생산관리처</td>
                <td align="center">90</td>
                <td align="center">93.5</td>
                <td align="center" bgcolor="#FFFFCC"><strong>90.5</strong></td>
              </tr>
            </table> 
</body>
</html>