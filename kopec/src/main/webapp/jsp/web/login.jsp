<%@ page contentType="text/html; charset=euc-kr"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script language="javascript">

	function go_login(){
		frm.submit();
	}
//-----------------------------------------------------------------------------
//ID ���� ��Ű�� ����
//-----------------------------------------------------------------------------
    function setCookie (name, value, expires) {
      document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
    }

    function getCookie(Name) {
      var search = Name + "="
        if (document.cookie.length > 0) {                  // ��Ű�� �����Ǿ� �ִٸ�
          offset = document.cookie.indexOf(search)
          if (offset != -1) {                                        // ��Ű�� �����ϸ�
            offset += search.length
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset)
            // ��Ű ���� ������ ��ġ �ε��� ��ȣ ����
            if (end == -1)
              end = document.cookie.length
            return unescape(document.cookie.substring(offset, end))
         }
      }
      return "";
   }

   function saveid(form) {
      var expdate = new Date();
        // �⺻������ 30�ϵ��� ����ϰ� ��. �ϼ��� �����Ϸ��� * 30���� ���ڸ� �����ϸ� ��
        if (form.checksaveid.checked)
          expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30��
        else
          expdate.setTime(expdate.getTime() - 1);      // ��Ű ��������

          setCookie("saveid", frm.userId.value, expdate);
   }


   function getid(form) {
     //form.checksaveid.checked = ((frm.userId.value = getCookie("saveid")) != "");
   }



</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="getid(document.frm)">
<div id="Layer1" style="position:absolute; left:40px; top:68px; width:180px; height:53px; z-index:1"><img src="images/login_tilte_logo.gif" width="230" height="60"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="35" background="images/login_top_line_bg.jpg">
	<script type="text/javascript" src="./FlashactiveX.js"></script>
	<script type="text/javascript">
	<!--
		swf('images/login_top_text.swf',300,35);
	//-->
	</script>
<!--  ���� �̹���
<img src="images/login_top_text.gif" width="220" height="35">
-->
    </td>
  </tr>

  <tr>
    <td background="images/login_bg.gif"><table width="100%" height="450" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="510" valign="top"><img src="images/1px.gif" width="8" height="8"><br>
            <img src="images/login_visual.jpg" width="502" height="303">
          <td valign="top">


		  <table width="290" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="55">&nbsp;</td>
              </tr>
              <tr>
                <td height="224" valign="top" background="images/login_box.gif">
                  <!-----------//login Box//--------->
                  <form  name="frm" method="post" action="loginProc.jsp">
                  <input type="hidden" name="flag" value="Y">
                  <table width="290" border="0" cellspacing="0" cellpadding="0">

                      <tr>
                        <td width="68" height="103"></td>
                        <td width="212">&nbsp;</td>
                      </tr>
					  <tr>
                        <td height="24">&nbsp;</td>
                        <td><input name="userId" type="text"  size="20" value="38937" ><input type="checkbox" name="checksaveid" onClick="saveid(this.form)"><font size="1.5pt">ID ����</font></td>
                      </tr>
                      <tr>
                        <td height="24">&nbsp;</td>
                        <td><input name="passwd" type="password"  size="20"></td>
                      </tr>
                      <tr>
                        <td height="34"><br>&nbsp;</td>
                        <td align="center"><img src="images/login_btn.gif" alt="�α���" width="94" height="34" border="0" onclick="go_login()" style="cursor:hand"></td>
                      </tr>
                  </table>
                  </form>
                  <!-------------//login box End//---------->
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
     </tr>
  <tr>
    <td height="42" align="center"><img src="images/login_footer.gif" width="600" height="42"></td>

  </tr>
</table>
<iframe name="ifrm" width="100" height="100" style="display:none"></iframe>
</body>
</html>