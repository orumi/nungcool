<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>

<%

    String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");


	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		
		return;
	}



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
	<Script Language="javaScript">

        function reloadPage(idx)
        {
            window.location.reload();

            if(idx == "I")
            {
                alert("��� �Ǿ����ϴ�.");
            }
            else if(idx == "U")
            {
                alert("���� �Ǿ����ϴ�.");
            }
            else
            	alert("���� �Ǿ����ϴ�.");

        }


		function stepChange()
		{
			if(form5.projectID.value == "")
				alert("������Ʈ�� �����ϼ���.");
			else
			{
				detail.form5.projectID.value = form5.projectID.value;
				detail.form5.stepID.value = form5.stepID.value;
				detail.form5.idx.value= "E";
				detail.form5.action = "./taskAdminChild.jsp";
				detail.form5.submit();
			}
		}


		
		function frm5Send()
		{
			 var frm=dlist.form5;
			 frm.mode.value = form1.mode.value;
			 frm.execWork.value = form1.execWork.value
			 frm.pid.value=form1.pid.value;
			 frm.did.value=form1.did.value;
			 frm.sid.value=form1.selStep.options[form1.selStep.selectedIndex].value;
			 frm.sYear.value=form1.sYear.options[form1.sYear.selectedIndex].value;
			 frm.sQtr.value=form1.selsQtr.options[form1.selsQtr.selectedIndex].value;
			 frm.eYear.value=form1.eYear.options[form1.eYear.selectedIndex].value;
			 frm.eQtr.value=form1.seleQtr.options[form1.seleQtr.selectedIndex].value;
			 frm.mgr.value=form1.selUser.options[form1.selUser.selectedIndex].value;
			 frm.goalLev.value = form1.goalLev.value;
			 frm.mainDesc.value = form1.mainDesc.value;
			 frm.drvMthd.value = form1.drvMthd.value;
			 frm.errcnsdr.value = form1.errcnsdr.value;
			 
			 frm.submit();
		}
	</Script>

<body>
            <table width="100%" height="100%">
            <form name="form1">

            	<tr>
            		<td  valign="top" height="50%">
            			<table vspace="4">
							<tr bgcolor="#FFFFFF">
	              				<td height="15" colspan="3"><strong>&nbsp;&nbsp;<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
	               	 				�������� ����Ʈ</strong>
	               	 			</td>
							</tr>
            			</table>
           		<iframe frameborder="0" id="list" src="taskAdminList.jsp" scrolling="no" style="body" width="100%" height="80%">&nbsp;</iframe>
	            	</td>
	            	<td valign="top" height="50%">
            			<table vspace="4">
							<tr bgcolor="#FFFFFF">
								<td height="15" colspan="4" bgcolor="#FFFFFF"><strong>&nbsp;&nbsp;<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				                  	Sub ����</strong>
				                </td>
							</tr>
            			</table>	            	
            		<iframe frameborder="0" id="detail" src="taskAdminDetail.jsp" style="body" width="100%" height="80%" >&nbsp;</iframe>
	            	</td>
	            </tr>
	            <tr>
	            	<td colspan="2">
            			<table vspace="4">
							<tr bgcolor="#FFFFFF">
			  				<td height="15" colspan="8" bgcolor="#FFFFFF"><strong>&nbsp;&nbsp;<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				   	 			���� ����Ʈ</strong>&nbsp;&nbsp;&nbsp;
				   	 			<a href="javascript:dlist.paCall();"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="���ν����ȹ�߰�" width="50" height="20" border="0" align="absmiddle"></a>
				   	 			</td> 
							</tr>
            			</table>	            		            	
             		<iframe frameborder="0" id="dlist" src="taskAdminChild.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
	            	</td>
	           </tr>
	          </form>
            </table>

</body>
</html>