<%-----------------------------------------------------
 * INIcancel.jsp
 *
 * Date : 2007/09
 * Author : ts@inicis.com
 * Project : INIpay V5.0 for JAVA(JSP)
 * 
 * http://www.inicis.com
 * Copyright (C) 2007 Inicis, Co. All rights reserved.
-------------------------------------------------------%>
<%@ page language = "java" contentType = "text/html; charset=euc-kr" %>
<%-- 
     ***************************************
     * 1. INIpay ���̺귯��                * 
     *************************************** 
--%>
<%@ page import = "com.inicis.inipay.INIpay" %>
<%
    request.setCharacterEncoding("euc-kr");
	/***************************************
	 * 2. INIpay Ŭ������ �ν��Ͻ� ���� *
	 ***************************************/
	INIpay inipay = new INIpay();
	
	/*********************
	 * 3. ��� ���� ���� *
	 *********************/
  inipay.SetField("inipayhome", "C:\\INIpay50");  // �̴����� Ȩ���͸�(�������� �ʿ�)
  inipay.SetField("type", "cancel");                            // ���� (���� ���� �Ұ�)
  inipay.SetField("debug", "true");                             // �α׸��("true"�� �����ϸ� �󼼷αװ� ������.)
  inipay.SetField("mid", request.getParameter("mid") );         // �������̵�
  inipay.SetField("admin", "1111");                             //���� Ű�н����� (���ĪŰ)
  inipay.SetField("cancelreason", request.getParameter("cancelreason") );   // ���ݿ����� ����ڵ�
  //***********************************************************************************************************
  //* admin �� Ű�н����� �������Դϴ�. �����Ͻø� �ȵ˴ϴ�. 1111�� �κи� �����ؼ� ����Ͻñ� �ٶ��ϴ�.      *
  //* Ű�н������ ���������� ������(https://iniweb.inicis.com)�� ��й�ȣ�� �ƴմϴ�. ������ �ֽñ� �ٶ��ϴ�.*
  //* Ű�н������ ���� 4�ڸ��θ� �����˴ϴ�. �� ���� Ű���� �߱޽� �����˴ϴ�.                               *
  //* Ű�н����� ���� Ȯ���Ͻ÷��� �������� �߱޵� Ű���� ���� readme.txt ������ ������ �ֽʽÿ�.             *
  //***********************************************************************************************************
  inipay.SetField("tid", request.getParameter("tid") );         // ����� �ŷ��� �ŷ����̵�
  inipay.SetField("cancelmsg", request.getParameter("msg") );   // ��һ���
  inipay.SetField("crypto", "execure");						    // Extrus ��ȣȭ��� ���(����)

	/****************
	 * 4. ��� ��û *
	 ****************/
	inipay.startAction();
	
	
	/****************************************************************
	 * 5. ��� ���
	 *
	 * ����ڵ� : inipay.GetResult("ResultCode") ("00"�̸� ��� ����)
	 * ������� : inipay.GetResult("ResultMsg") (��Ұ���� ���� ����)
	 * ��ҳ�¥ : inipay.GetResult("CancelDate") (YYYYMMDD)
	 * ��ҽð� : inipay.GetResult("CancelTime") (HHMMSS)
	 * ���ݿ����� ��� ���ι�ȣ : inipay.GetResult("CSHR_CancelNum")
	 * (���ݿ����� �߱� ��ҽÿ��� ���ϵ�)
	 ****************************************************************/
%>

<html>
<head>
<title>INIpayTX50 ��ҿ�û ������ ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body, tr, td {font-size:9pt; font-family:����,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/ 
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:����,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/ 
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}
</style>

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0><center> 
<table width="632" border="0" cellspacing="0" cellpadding="0">
  <tr> 
<%
    // ���� ���ܿ� ���� ��� �̹����� ����ȴ�.
   	String background_img = "img/spool_top.gif";    //default image
   	if ("01".equals(inipay.GetResult("ResultCode") ) )
   	{
   	    background_img = "img/cancle_top.gif";
   	}
%>
    <td height="83" background="<%=background_img%>"style="padding:0 0 0 64">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%" valign="top"><img src="img/title_01.gif" width="8" height="27" vspace="5"></td>
          <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>��Ұ��</b></font></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center" bgcolor="6095BC"><table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td bgcolor="#FFFFFF" style="padding:0 0 0 56">
		  <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7"><img src="img/life.gif" width="7" height="30"></td>
                <td background="img/center.gif"><img src="img/icon03.gif" width="12" height="10"> 
                  <b>�����Բ��� �̴����̸� ���� ����Ͻ� �����Դϴ�. </b></td>
                <td width="8"><img src="img/right.gif" width="8" height="30"></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="407"  style="padding:0 0 0 9"><img src="img/icon.gif" width="10" height="11"> 
                  <strong><font color="433F37">��ҳ���</font></strong></td>
                <td width="103">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2"  style="padding:0 0 0 23">
		  <table width="470" border="0" cellspacing="0" cellpadding="0">
                    
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="26">�� �� �� ��</td>
                      <td width="343"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td><%=inipay.GetResult("ResultCode")%></td>
                            <td width='142' align='right'>&nbsp;</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">�� �� �� ��</td>
                      <td width="343"><%=inipay.GetResult("ResultMsg")%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">�� �� �� ȣ</td>
                      <td width="343"><%=request.getParameter("tid")%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>�� �� �� ¥</td>
                      <td width='343'><%=inipay.GetResult("CancelDate")%></td>
                    </tr>                	    
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>�� �� �� ��</td>
                      <td width='343'><%=inipay.GetResult("CancelTime")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>                    
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>���ݿ�����<br>��ҽ��ι�ȣ</td>
                      <td width='343'><%=inipay.GetResult("CSHR_CancelNum")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    
                    
                  </table></td>
              </tr>
            </table>
            <br>
           </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td><img src="img/bottom01.gif" width="632" height="13"></td>
  </tr>
</table>
</center></body>
</html>