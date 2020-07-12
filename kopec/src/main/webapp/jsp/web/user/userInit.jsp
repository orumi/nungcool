
<%@ page contentType="text/html; charset=euc-kr" language="java" errorPage="" %>
<%@ page import ="com.nc.util.*,
					com.nc.user.UserApp" %>

<%  String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

    UserApp app = new UserApp();
    app.setUserDetail(request, response);

    DataSet ds = (DataSet)request.getAttribute("ds");
%>

<script src="<%=imgUri %>/bootstrap/js/libs/jquery-2.1.1.min.js"></script>

<html>
<head>
<title>::: ����� ���� :::</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">


	function fnSearch(mode){
		if (mode=='Q') {
			document.getElementById('list').contentWindow.document.form1.mode.value = mode;
			document.getElementById('list').contentWindow.document.form1.searchKey.value = $("#txtSearch").val();
			document.getElementById('list').contentWindow.document.form1.selDiv.value = $("#selDiv option:selected").val();

			document.getElementById('list').contentWindow.document.form1.submit();

			document.getElementById('detail').contentWindow.fnInit();
		}
	}

</script>
</head>

<body leftmargin="5" topmargin="0" marginwidth="5" >
<!--------//Page Layout Table //---------->

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">

	<!-----//Box layout//----->
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td colspan="2" valign="top" bgcolor="#FFFFFF">
          	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="25"><strong><img src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                  ����� ��ȸ</strong></td>
              </tr>
            </table>
            <!---------///���� ������ ���Կ��� ///--------->
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		        <tr>
		          <td width="100%" valign="top">
		            <!------//��ܰ˻�//----->
		            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">

		                <tr bgcolor="#DCEDF6">
		                  <td align="center" bgcolor="#DCEDF6" style = "width:100px"><strong><font color="#006699">����ڸ�</font></strong></td>
		                  <td bgcolor="#FFFFFF">
		                  	<input name="txtSearch" id="txtSearch" type="text" class="input_box" size = 35 onKeypress="javascript: if (event.keyCode =='13') fnSearch('Q');"> </input>
						  </td>

		                  <td align="center" bgcolor="#DCEDF6" style = "width:100px"><strong><font color="#006699">�򰡺μ���</font></strong></td>
		                  <td bgcolor="#FFFFFF">
		                  	<select name="selDiv" id="selDiv">
		                  		<option value=-1> ��ü</option>
						        <% if (ds!=null) {
						         		while(ds.next()){ %>
						            <option value="<%=ds.getInt("id")%>"><%=ds.getString("name")==null?"":ds.getString("name")%></option>
						        <% }} %>
					        </select>
							<a href="#"><img src="<%=imgUri%>/jsp/web/images/btn_ok.gif" alt="Ȯ��" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnSearch('Q');"></a>
						  </td>
		                </tr>

		            </table>
		            <!-------//��ܰ˻� ��//------->
		          </td>
		        </tr>
	        <tr>
	          <td valign="top">&nbsp;</td>
	        </tr>
	      </table>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr valign="top">
          <td width="55%">
		  	<!------//���� ����� ���//------>
            <table width="98%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                      <td height="25"><strong> <img src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                        ����� ���</strong></td>
              </tr>
            </table>

            <!--iframe ����-->
            <iframe id="list" frameborder="0" src="userList.jsp" width="100%" height= "580" scrolling="no">&nbsp;</iframe>
            <!--iframe ��-->
            <!------//���� ����� ��� ��//------>

		</td>
		<td width="1%">
			&nbsp;
		</td>
        <td width="44%">
		  <!------//���� ���������//------>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                    <td height="25"><strong> <img src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                      ����� ����</strong></td>
            </tr>
          </table>
                <!------//���� ��������� �Է���//------>

               <!--iframe ����-->
	            <iframe id="detail" frameborder="0" src="userDetail.jsp" width="100%" height= "580" scrolling="no">&nbsp;</iframe>
	            <!--iframe ��-->
                <!------//���� ����� ����  ��//------>
              </td>
        </tr>
      </table>

            <br>
            <!---------///���� ������ ���Կ���  ��///--------->
          </td>
        </tr>

      </table>
	  <!-----//Box layout end//----->

	  </td>
  </tr>
</table>
<!--------//Page Layout Table End//---------->
</body>
</html>
