<!-- 
�����ۼ��� : ������ 
�Ҽ� 		 : ����
�����ۼ��� : 
>-------------- ���� ����  --------------<
������ : 2007.07.05 ������ : ������ 


 -->


<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
    request.setCharacterEncoding("euc-kr");

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	TaskAdmin util = new TaskAdmin();

	util.setProject(request, response);
	DataSet ds = (DataSet)request.getAttribute("ds");	//������Ʈ ����Ʈ



	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
%>
<script>
		alert("�߸��� �����Դϴ�.");
  		top.location.href = "../loginProc.jsp";
</script>
<%  }%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">
		var prjList = new Array();

		function openDetail(pid,pname) {
			parent.taskList.form1.pid.value=pid;

			parent.taskList.form1.submit();
		}

</script>
<body>
          <form name="form2" method="post" action="" >
          </form>
			<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
					<tr bgcolor="#FFFFFF">
        				<td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
         	 			�������� ����Ʈ</strong></td>
					</tr>
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="30%"><strong><font color="#003399">����</font></strong></td>
		                <td align="center" width="45%"><strong><font color="#003399">��Ī</font></strong></td>
		                <td align="center" width="25%"><strong><font color="#003399">�о�</font></strong></td>
					</tr>
<%
					if(ds != null)
						while(ds.next()) {
							String convStr = ds.getString("PNAME");
							if(convStr.length() > 15)
								convStr = convStr.substring(0, 12) + "...";
%>
	                <tr bgcolor="#FFFFFF">
		                <td align="center"><%=ds.getString("TNAME") %></td>
						<td title="<%=ds.getString("PNAME") %>">
							<a href="javascript:openDetail('<%=ds.getString("PID")%>');">
							<%=convStr %>
							</a>
						</td>
						<td align="center"><%=ds.getString("FNAME") %></td>
	                </tr>
<%
						}
%>
				</table>
            </table>
</body>
</html>