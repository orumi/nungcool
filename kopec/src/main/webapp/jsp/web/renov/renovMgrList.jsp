<!-- 
�����ۼ��� : ������ 
�Ҽ� 		 : ����
�����ۼ��� : 
>-------------- ���� ����  --------------<
������ : 2007.07.10 ������ : ������ 


 -->
 
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.renov.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    String userId = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
    request.setCharacterEncoding("euc-kr");

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
	RenovMgr userinfo = new RenovMgr();
	userinfo.setMgrUser(request, response);
	
	DataSet userLst = (DataSet)request.getAttribute("ds");

	if(userId.equals("")) 
	{
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href='../loginProc.jsp';");
		out.print("</script>");
	}
	
	
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">

	function renovDtl(deptid, usernm, userid)
	{
		parent.detail.form1.dept.value = deptid;
//		var address2 = document.form1.addr.options[i].text // �����׸� text

		
//		document.choiceForm.available.options[selectedItem].text;
//		parent.detail.form1.mgruser.options[parent.detail.form1.mgruser.selectedIndex].value = userid;
//		alert(aaa);
//		parent.detail.form1.mgruser.options[selectedIndex].text = usernm;
		parent.detail.changeDept();
		parent.detail.form1.mgruser.options[parent.detail.form1.mgruser.selectedIndex].text = usernm;
		parent.detail.form1.mgruser.options[parent.detail.form1.mgruser.selectedIndex].value = deptid;
		
//		alert(parent.detail.form1.mgruser.options[parent.detail.form1.mgruser.selectedIndex].value);
//		parent.detail.form1.mgruser.options[selectedItem].value = usernm;
	}


</script>
<body>
				<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<!--  					<tr bgcolor="#FFFFFF">
              				<td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
               	 			�������� ����Ʈ</strong></td>
					</tr>
-->
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="30%"><strong><font color="#003399">�μ���</font></strong></td>
		                <td align="center" width="45%"><strong><font color="#003399">�����</font></strong></td>
		                <td align="center" width="25%"><strong><font color="#003399">���̵�</font></strong></td>
					</tr>
					
<%
					if(userLst != null)
					{
						while(userLst.next())
						{
%>
				<tr bgcolor="#FFFFFF">
					<td align="center"><%=userLst.isEmpty("DEPTNAME")?"":userLst.getString("DEPTNAME") %></td>
					<td align="center">
						<a href="javascript:renovDtl('<%=userLst.getString("DEPTID")%>','<%=userLst.getString("USERNAME")%>','<%=userLst.getString("USERID")%>')">
							<%=userLst.isEmpty("USERNAME")?"":userLst.getString("USERNAME") %>
						</a>
					</td>
					<td align="center"><%=userLst.isEmpty("USERID")?"":userLst.getString("USERID") %></td>	
				</tr>
<%
						}
					}
%>
				
            </table>
</body>
</html>