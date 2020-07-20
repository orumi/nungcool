<%@ page contentType="text/html; charset=euc-kr" language="java" errorPage="" %>
<%@ page import ="com.nc.util.*,com.nc.user.UserApp" %>

<%  String imgUri = request.getRequestURI();
    imgUri = imgUri.substring(1);
    imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

    String mode = 	request.getParameter("mode");

	String searchKey = 	request.getParameter("searchKey");

	UserApp user = new UserApp();
	user.setList(request, response);

	String errMsg = (String) request.getAttribute("errMsg");

	DataSet ds = (DataSet)request.getAttribute("ds");

	//에러메시지 errMsg.trim은 문자열 마지막줄 추가  제거 (안하면 에러발생)
	if (errMsg != null) {	%>
		<script language="JavaScript" type="text/JavaScript">
		<!--
		alert("<%= errMsg.trim() %>");
		-->
		</script>
	<%}

%>

<html>
<head>
<title>::: 사용자 관리Detail 01 :::</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">

function fnDetailView(userId,userName,email,groupId,auth01,app,charge,bscId,deptname,position){

	/* parent.document.getElementById('detail').contentWindow.document.form2 */

		parent.document.getElementById('detail').contentWindow.document.form2.userId.value = userId;
		parent.document.getElementById('detail').contentWindow.document.form2.txtUserId.value = userId;
		parent.document.getElementById('detail').contentWindow.document.form2.txtUserName.value = userName;
		parent.document.getElementById('detail').contentWindow.document.form2.txtEmail.value = email;
		parent.document.getElementById('detail').contentWindow.document.form2.cboType.value = groupId;
		parent.document.getElementById('detail').contentWindow.document.form2.cboAuth01.value = auth01;


		parent.document.getElementById('detail').contentWindow.document.form2.chkApp.checked = ((app==1)||(app==2));
		parent.document.getElementById('detail').contentWindow.document.form2.selCharge.value = charge;
		parent.document.getElementById('detail').contentWindow.document.form2.bcid.value = bscId;
		parent.document.getElementById('detail').contentWindow.document.form2.txtDeptName.value = deptname;

		parent.document.getElementById('detail').contentWindow.document.form2.selCharge.value = position;

		parent.document.getElementById('detail').contentWindow.document.form2.txtUserId.disabled = true;
		parent.document.getElementById('detail').contentWindow.document.form2.txtUserId.readonly = true;

	}


</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<!--------//Page Layout Table //---------->
	<form name="form1" method="post" action="">
		<input type="hidden"  name="mode">
		<input type="hidden"  name="searchKey">
		<input type="hidden" name="selDiv">

		<input type="hidden" name="userId">
		<input type="hidden" name="userName">
		<input type="hidden" name="email">
		<input type="hidden" name="groupId">
		<input type="hidden" name="auth01">
		<input type="hidden" name="chkApp">
		<input type="hidden" name="appType">
		<input type="hidden" name="selCharge">
		<input type="hidden" name="bscId">


	</form>
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" >
      <tr align="center" bgcolor="#375f9c" style="height:32px;">
        <td width="70"><strong><font color="#ffffff">아이디</font></strong></td>
        <td width="60"><strong><font color="#ffffff">사용자명</font></strong></td>
        <td width="150"><strong><font color="#ffffff">평가부서명</font></strong></td>
        <td width="90"><strong><font color="#ffffff">성과관리권한</font></strong></td>
        <td><strong><font color="#ffffff">경영정보권한</font></strong></td>
      </tr>
</table>
<div style="width:100%;height:515px;overflow:auto;overflow-x:hidden;">
     <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" >
         <% if (ds!=null) {
         		while(ds.next()){ %>
         			<tr bgcolor="#FFFFFF" onclick = "javascript:fnDetailView('<%=ds.getString("USERID")%>'
	                 	,'<%=ds.getString("USERNAME")==null?"":ds.getString("USERNAME") %>'
	                 	,'<%=ds.getString("EMAIL")==null?"":ds.getString("EMAIL") %>'
	   					,'<%=ds.getInt("GROUPID")%>'
	   					,'<%=ds.isEmpty("AUTH01")?"0":(ds.getString("AUTH01")==null?"0":ds.getString("AUTH01")) %>'
	   					,'<%=ds.isEmpty("APPRAISER")?"0":ds.getString("APPRAISER")%>'
	   					,'<%=ds.isEmpty("CHARGE")?"0":ds.getString("CHARGE")%>'
	   					,'<%=ds.getString("DIVCODE")==null?"":ds.getString("DIVCODE") %>'
	   					,'<%=ds.getString("DEPTNAME")==null?"":ds.getString("DEPTNAME") %>'
	   					,'<%=ds.getString("POSITION")==null?"0":ds.getString("POSITION") %>' );"
                 	ONMOUSEOVER="this.style.backgroundColor='#E5F2FF';"
                 	ONMOUSEOUT="this.style.backgroundColor='FFFFFF';" STYLE="cursor:hand">

						<td width="70" align="left"><%=ds.getString("USERID")==null?"&nbsp;":ds.getString("USERID") %></td>
		           		<td width="60" align="left"><%=ds.getString("USERNAME")==null?"&nbsp;":ds.getString("USERNAME") %></td>
		           		<td width="150" align="left"><%=ds.getString("DIVNAME")==null?"&nbsp;":ds.getString("DIVNAME") %></td>
		           		<%if (ds.getInt("GROUPID") == 5){  %>
			           		<td width="90" align="left">일반</td>
			           	<%}else if (ds.getInt("GROUPID") == 3){ %>
           		         	<td width="90" align="left">성과담당자</td>
			           	<%}else if (ds.getInt("GROUPID") == 2){ %>
           		         	<td width="90" align="left">평가자</td>
           		        <%}else if (ds.getInt("GROUPID") == 1){ %>
           		        	<td width="90" align="left">관리자</td>
           		        <%}else{ %>
           		        	<td width="90" align="left"></td>
           		        <%}%>
           		        <td align="left"><%=ds.isEmpty("AUTH01")?"일반":(ds.getInt("AUTH01")==1?"경영정보관리자":"일반") %></td>
         			</tr>
         	<%
         		}
         	}
         	else {
         		%>
         		<tr bgcolor="#FFFFFF" >

	         		<td align = "middle" colspan = "3">
	         			<B> 사용자정보를 조회하려면 확인버튼을 클릭하십시오.</B>
	         		</td>

         		</tr>
         		<%
         	}
         %>

  </table>
</div>

<!--------//Page Layout Table End//---------->
</body>
</html>
