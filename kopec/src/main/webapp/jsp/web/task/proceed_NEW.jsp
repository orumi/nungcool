<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
<br>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
              <form name="form1" method="post" action="">
                <tr bgcolor="#DCEDF6">
                  <td width="10%" align="center" bgcolor="#DCEDF6"><strong><font color="#006699">
                    ������Ʈ</font></strong></td>
                  <td width="38%" bgcolor="#FFFFFF"><select name="select">
                      <option value="01">�̷����信 ����� ����ɷ�</option>
                    </select> </td>
                  <td width="9%" align="center" bgcolor="#DCEDF6"><strong><font color="#006699">�о�</font></strong></td>
                  <td width="43%" bgcolor="#FFFFFF"><select name="select3">
                      <option value="01">�߼��� �о�</option>
                    </select> <a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_ok.gif" alt="Ȯ��" width="50" height="20" border="0" align="absmiddle"></a></td>
                </tr>
              </form>
            </table>
			<!-------------->
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                  �̷����信 ����� ����ɷ�&nbsp;&nbsp;&nbsp;<a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_detailview.gif" alt="�󼼳�������" width="84" height="20" border="0" align="absmiddle"></a></strong></td>
              </tr>
            </table>
			<!--------//����Ʈ //------->
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr align="center" bgcolor="#FFFFFF">
                <td rowspan="3" bgcolor="#D4DCF4"><strong><font color="#003399">���ν������</font></strong></td>
                <td rowspan="3" bgcolor="#D4DCF4"><strong><font color="#003399">�ְ��μ�</font></strong></td>
                <td colspan="9" bgcolor="#D4DCF4"><strong><font color="#003399">1�ܰ�</font></strong></td>
                <td colspan="5" bgcolor="#D4DCF4"><strong><font color="#003399">2�ܰ�</font></strong></td>
                <td colspan="4" bgcolor="#D4DCF4"><strong><font color="#003399">3�ܰ�</font></strong></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td colspan="2" align="center">'07</td>
                <td colspan="4" align="center">'08</td>
                <td width="15" rowspan="2" align="center">'09</td>
                <td width="15" rowspan="2" align="center">'10</td>
                <td width="15" rowspan="2" align="center">'11</td>
                <td width="15" rowspan="2" align="center">'12</td>
                <td width="15" rowspan="2" align="center">'13</td>
                <td width="15" rowspan="2" align="center">'14</td>
                <td width="15" rowspan="2" align="center">'15</td>
                <td width="15" rowspan="2" align="center">'16</td>
                <td width="15" rowspan="2" align="center">'17</td>
                <td width="15" rowspan="2" align="center">'18</td>
                <td width="15" rowspan="2" align="center">'19</td>
                <td width="15" rowspan="2" align="center">'20</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="15">&nbsp;</td>
                <td width="15">&nbsp;</td>
                <td width="15">&nbsp;</td>
                <td width="15">&nbsp;</td>
                <td width="15">&nbsp;</td>
                <td width="15">&nbsp;</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td><a href="#">�Ǻ��� �غ��������ɷ� Ȯ��</a></td>
                <td>�߼��ο���ó</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
</body>
</html>