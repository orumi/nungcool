<!-- 
�����ۼ��� : ������ 
�Ҽ� 		 : ����
�����ۼ��� : 
>-------------- ���� ����  --------------<
������ : 2007.07.05 ������ : ������ 
 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.renov.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
    request.setCharacterEncoding("euc-kr");

	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
    
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	RenovWorkMgr util = new RenovWorkMgr();
	util.setProjectDetail(request, response);
	
	String proc = (String)request.getAttribute("proc");
	
	if(proc != null)
		if(proc.equals("ok"))
		{
			out.print("<script>");
			out.print("parent.openDetail();");
			out.print("</script>");			
		}
		else if(proc.equals("fail"))
		{
			out.print("<script>");
			out.print("alert('���� ������ �־� �����Ҽ� �����ϴ�.');");
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
		var prjList = new Array();

		function projectIUD(idx, dtlCnt, achvCnt) {
		}


		function actionPerformed(tag){
		
			form1.year.value = parent.form1.curYear.options[parent.form1.curYear.selectedIndex].value;
			form1.deptid.value = parent.form1.selBSC.options[parent.form1.selBSC.selectedIndex].value;

			if (tag=="C"){
				if (form1.pid.value=="")
				{
					if (form1.pname.value=="")
					{

						alert("���Ű������� ����Ͻʽÿ�");
						return;
					}

//					parent.list.refresh=true;
					form1.mode.value=tag;
					form1.submit();
					resChange();
				} else {
					clearComponent();
				}

			} 
			else if (tag=="U") 
			{
				if (form1.pid.value=="") 
				{
					alert("������ ����� �����Ͻʽÿ�");
					return;
				}
				parent.list.refresh=true;
				form1.mode.value=tag;
				form1.submit();
				resChange();
			} 
			else if (tag=="D") 
			{
				if (form1.pid.value=="") 
				{
					alert("������ ����� �����Ͻʽÿ�");
					return;
				}
				if (confirm("������ �׸��� �����Ͻðڽ��ϱ�?"))
				{
					parent.list.refresh=true;
					form1.mode.value=tag;
					form1.submit();
					resChange();
				}

			}
		}

	function resChange()	//coolChart
	{
//		var tblRow = chartList.listTbl.rows.length-1;
		var tblRow = parent.dlist.listTbl.rows.length-1;	
		if(parent.dlist.listTbl.rows.length != 0)
		{
			for(var i = tblRow; i > 0; i--)
			{
				parent.dlist.listTbl.deleteRow(i);
			}
		}
		
//		if(chartList.titleTbl.rows.length != 0)
//			chartList.titleTbl.deleteRow(0);
	}


		function clearComponent(){
			form1.pid.value="";
			form1.pname.value="";
			form1.pDesc.value="";
			form1.pgDesc.value="";
		}

		function detailRefresh(){
//			alert(parent.list.refresh);
			if (parent.list.refresh==true){
				parent.list.form2.submit();
			}
		}

</script>
<body>
			<table width="100%" border="0"  cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<!--  				<tr>
					<td height="30" colspan="4" bgcolor="#FFFFFF"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
	                  	���λ���</strong>
	                </td>
	           </tr>
-->
			<form name="form1" method="post" action="">
			<input type="hidden" name="mode">
			<input type="hidden" name="year">
			<input type="hidden" name="deptid">
			<input type="hidden" name="pid" value="">
				<tr>
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">���Ű���</font></strong></td>
	                <td width="80%" bgcolor="#FFFFFF" colspan="3">
	                    <textarea name="pname" rows="3" cols="45" class="input_box" value=""></textarea>
	                </td>
	         	</tr>
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="4">
	                	<a href="javascript:actionPerformed('C')"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="�߰�" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('U')"><img src="<%=imgUri %>/jsp/web/images/btn_edit.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('D')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a></td>
	              </tr>
	           </form>
            </table>

</body>
</html>