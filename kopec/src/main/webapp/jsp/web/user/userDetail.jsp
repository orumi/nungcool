
<%@ page contentType="text/html; charset=euc-kr" language="java" errorPage="" %>
<%@ page import ="com.nc.util.*,com.nc.user.UserApp" %>

<%  String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

    String mode = 	request.getParameter("mode");
	mode = (mode!=null)?mode:"Init";

	UserApp userapp = new UserApp();
	userapp.setUserDetail(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");
	DataSet dsPst = (DataSet)request.getAttribute("dsPst");


	String errMsg = (String) request.getAttribute("errMsg");

	//�����޽��� errMsg.trim�� ���ڿ� �������� �߰�  ���� (���ϸ� �����߻�)
	if (errMsg != null) {	%>
	<script language="JavaScript" type="text/JavaScript">
	<!--
		alert("<%= errMsg.trim() %>");
	-->
	</script>
	<%}else{%>
		<script language="JavaScript" type="text/JavaScript">
		<!--
			//alert("����Ǿ����ϴ�.");
			//parent.fnRefresh();
		-->
		</script>

	<%}
%>

<html>
<head>
<title>::: ����� ����Detail 02 :::</title>
<link href="<%=imgUri%>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">

	function fnApply(mode){

		if (mode =='N') {

			if (form2.userId.value != ''){
				//textbox �ʱ�ȭ
				fnInit();
				form2.txtUserId.focus();
			}
			else {
				if (form2.txtUserId.value == '') {
					alert("�ʼ��Է¿���Դϴ�.");
					form2.txtUserId.focus();
				}
				else {
					parent.document.getElementById('list').contentWindow.document.form1.mode.value=mode;
					parent.document.getElementById('list').contentWindow.document.form1.userId.value=form2.txtUserId.value;
					parent.document.getElementById('list').contentWindow.document.form1.userName.value=form2.txtUserName.value;
					parent.document.getElementById('list').contentWindow.document.form1.email.value=form2.txtEmail.value;
					parent.document.getElementById('list').contentWindow.document.form1.groupId.value=form2.cboType.value;
					parent.document.getElementById('list').contentWindow.document.form1.auth01.value=form2.cboAuth01.value;
					parent.document.getElementById('list').contentWindow.document.form1.chkApp.value=(form2.chkApp.checked==true?1:0);
					parent.document.getElementById('list').contentWindow.document.form1.selCharge.value=form2.selCharge.value;
					parent.document.getElementById('list').contentWindow.document.form1.bscId.value=form2.bcid.value
					parent.document.getElementById('list').contentWindow.document.form1.appType.value=form2.appType.value;

					parent.document.getElementById('list').contentWindow.document.form1.searchKey.value = parent.txtSearch.value;
					parent.document.getElementById('list').contentWindow.document.form1.selDiv.value = parent.selDiv.value
					parent.document.getElementById('list').contentWindow.document.form1.submit();

				}
			}
		}
		else if (mode == 'U') {
			if (form2.userId.value == ''){
				alert("������ ����� ������ �����Ͻʽÿ�.");
			}
			else if (form2.txtUserName.value == '') {
				alert("�ʼ��Է¿���Դϴ�.");
				form2.txtUserName.focus();
			}
			else if(confirm("�����������  �����Ͻðڽ��ϱ�?")){
				/* parent.document.getElementById('list').contentWindow.document.form1 */
				parent.document.getElementById('list').contentWindow.document.form1.mode.value=mode;
				parent.document.getElementById('list').contentWindow.document.form1.userId.value=form2.userId.value;
				parent.document.getElementById('list').contentWindow.document.form1.userName.value=form2.txtUserName.value;
				parent.document.getElementById('list').contentWindow.document.form1.email.value=form2.txtEmail.value;
				parent.document.getElementById('list').contentWindow.document.form1.groupId.value=form2.cboType.value;
				parent.document.getElementById('list').contentWindow.document.form1.auth01.value=form2.cboAuth01.value;
				parent.document.getElementById('list').contentWindow.document.form1.chkApp.value=(form2.chkApp.checked==true?1:0);
				parent.document.getElementById('list').contentWindow.document.form1.appType.value=form2.appType.value;

				parent.document.getElementById('list').contentWindow.document.form1.selCharge.value=form2.selCharge.value;
				parent.document.getElementById('list').contentWindow.document.form1.bscId.value=form2.bcid.value;

				parent.document.getElementById('list').contentWindow.document.form1.searchKey.value = parent.txtSearch.value;
				parent.document.getElementById('list').contentWindow.document.form1.selDiv.value = parent.selDiv.value
				parent.document.getElementById('list').contentWindow.document.form1.submit();

			}
		}
		else if (mode == 'D') {
			if (form2.userId.value == ''){
				alert("������ ����� ������ �����Ͻʽÿ�.");
			}
			else if(confirm("����������� �����Ͻðڽ��ϱ�?")){
				parent.document.getElementById('list').contentWindow.document.form1.mode.value=mode;
				parent.document.getElementById('list').contentWindow.document.form1.userId.value=form2.userId.value;

				parent.document.getElementById('list').contentWindow.document.form1.searchKey.value = parent.txtSearch.value;
				parent.document.getElementById('list').contentWindow.document.form1.selDiv.value = parent.selDiv.value

				parent.document.getElementById('list').contentWindow.document.form1.submit();

			}
		}
	}

	function fnOnlyNumber(){
		if(((event.keyCode) < 48)||((event.keyCode) > 57)){
			alert("���̵�� ���ڸ� �����մϴ�.");
			event.returnValue = false;
		}
	}

	function fnInit() {

		form2.mode.value = '';
		form2.userId.value = '';
		form2.txtUserId.value = '';
		form2.txtUserName.value = '';
		form2.txtEmail.value = '';
		form2.cboType.value = '5';
		form2.cboAuth01.value = '0';
		form2.appType.value = '1';
		form2.bcid.value = '';

		form2.txtUserId.disabled = false;
		form2.txtUserId.readonly = false;

	}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<!--------//Page Layout Table //---------->
<form name="form2" method="post" action="">
<input type = "hidden"  name = "mode">
<input type = "hidden"  name = "userId">
<input type = "hidden"  name = "checkCode">
 <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">

      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">USERID</font></strong></td>
        <td bgcolor="#FFFFFF">

        <input name="txtUserId" type="text" class="input_box" >

        </td>
      </tr>
      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">�����</font></strong></td>
        <td bgcolor="#FFFFFF"><input name="txtUserName" type="text" class="input_box" maxlength = "50"></td>
      </tr>
      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">E-mail</font></strong></td>
        <td bgcolor="#FFFFFF"><input name="txtEmail" type="text" class="input_box" size="35"  maxlength = "50"></td>
      </tr>
      <!--
      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">��ȭ��ȣ</font></strong></td>
        <td bgcolor="#FFFFFF"><input name="textfield4" type="text" class="input_box"></td>
      </tr>
      -->
      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">������������</font></strong></td>
        <td bgcolor="#FFFFFF"><select name="cboType">
            <option value="5">�Ϲ�</option>
            <option value="3">���������</option>
            <option value="1">������</option>
          </select>
          <!--
          <input type="checkbox" name="checkbox" value="checkbox">
          <font color="#666666">&quot;�μ�������ȸ&quot;�޴�����</font>
          -->
        </td>
      </tr>

      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">�濵��������</font></strong></td>
        <td bgcolor="#FFFFFF"><select name="cboAuth01">
            <option value="0">�Ϲ�</option>
            <option value="1">�濵����������</option>
          </select>
          <!--
          <input type="checkbox" name="checkbox" value="checkbox">
          <font color="#666666">&quot;�μ�������ȸ&quot;�޴�����</font>
          -->
        </td>
      </tr>


      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">����</font></strong></td>
        <td bgcolor="#FFFFFF">
        	<input type=checkbox name=chkApp>
        	<select name=appType style="display:none;">
        		<!--option value="0">�Ϲ�</option -->
        		<option value="1" selected>����</option>
        		<!--option value=2>�ǹ��� ����</option-->
        	</select>
        </td>
      </tr>
      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">����</font></strong></td>
        <td bgcolor="#FFFFFF"><select name="selCharge">
            <option value="0">-</option>
        <% if (dsPst!=null) {
         		while(dsPst.next()){ %>
            <option value="<%=dsPst.getInt("id")%>"><%=dsPst.getString("name")==null?"":dsPst.getString("name")%></option>
        <% }} %>
          </select>
        </td>
      </tr>
      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">�򰡺μ�����</font></strong></td>
        <td bgcolor="#FFFFFF"><select name="bcid">
        	<option value="">-</option>
        <% if (ds!=null) {
         		while(ds.next()){ %>
            <option value="<%=ds.getInt("id")%>"><%=ds.getString("name")==null?"":ds.getString("name")%></option>
        <% }} %>
          </select>
        </td>
      </tr>
      <tr>
        <td align="center" bgcolor="#EEEEEE"><strong><font color="#333333">���ҼӺμ�</font></strong></td>
        <td bgcolor="#FFFFFF"><input name="txtDeptName" type="text" class="input_box" size="50" readonly></td>
    </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right" height="35"><a href="#"><img src="<%=imgUri%>/jsp/web/images/btn_add.gif" alt="�߰�" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('N');"></a>&nbsp;
    <a href="#"><img src="<%=imgUri%>/jsp/web/images/btn_edit.gif" alt="����" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('U');"></a>&nbsp;
    <a href="#"><img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="����" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('D');"></a></td>
  </tr>
</table>
</form>
<!--------//Page Layout Table End//---------->
</body>
</html>
