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

    String modir = session.getAttribute("groupId")==null?"":(String)session.getAttribute("groupId");
    request.setCharacterEncoding("euc-kr");
    String auth = session.getAttribute("auth01")==null?"":(String)session.getAttribute("auth01");

	if(modir.equals(""))
	{
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}

	String imgUri = request.getRequestURI();
	String dtlDesc = "";
	String goal = "";
	String achv = "";
	String qtr = "";
	String rid = "";
	String did = "";
	String execWork = "";
	StringBuffer comb = new StringBuffer();
	String achvid = "";


	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	RenovActual util = new RenovActual();

	util.actualDtl(request, response);

	DataSet dtl = (DataSet)request.getAttribute("ds");

	DataSet userChk = (DataSet)request.getAttribute("userChk");
	String mgrYn = "N";	//����� ����
	if(modir.equals("1"))
		mgrYn = "Y";

	if(userChk.getRowCount() != 0)
		mgrYn = "Y";	//����� ����





	if(dtl != null)
	{
		while(dtl.next())
		{
			dtlDesc = dtl.isEmpty("RENOVDTLNAME")?"":dtl.getString("RENOVDTLNAME");

			goal = dtl.isEmpty("GOAL")?"":dtl.getString("GOAL");
			achv = dtl.isEmpty("ACHV")?"":dtl.getString("ACHV");
			qtr = dtl.isEmpty("qtr")?"":dtl.getString("qtr");
			rid = dtl.isEmpty("RENOVID")?"":dtl.getString("RENOVID");
			did = dtl.isEmpty("RENOVDTLID")?"":dtl.getString("RENOVDTLID");
			execWork = dtl.isEmpty("DRVEXECACHV")?"":dtl.getString("DRVEXECACHV");
			achvid = dtl.isEmpty("ACHVID")?"":dtl.getString("ACHVID");
		}


	}

	for(int i = 1; i <= 4; i++)
	{
		if(String.valueOf(i).equals(qtr))
		{
			comb.append("<option value=" + i +" selected>" + i + " �б�" + "</option>\n");
		}
		else
		{
			comb.append("<option value=" + i +">" + i + " �б�" + "</option>\n");
		}
	}







	String msg = (String) request.getAttribute("msg");


    if (msg!=null)
    {
    	if(msg.equals("1"))
    	{
%>
		<script>
			parent.openDetail();
		</script>

<%    	}
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


		function actionPerformed(tag, dnm)
		{
			if('<%=mgrYn%>' == 'N')
			{
				alert("�μ��� ����ڰ� �ƴմϴ�.\n����ڿ��� ���� �ϼ���.");
				return;
			}

			if (tag=="C"){

				if (form1.achvid.value==""){
					if (form1.goal.value=="")
					{

						alert("��ǥ�� �Է� �Ͻʽÿ�");
						return;
					}

					if(form1.achv.value=="")
					{

						alert("������ �Է� �Ͻʽÿ�");
						return;
					}

					if(form1.pgDesc.value=="")
					{

						alert("���������� ��� �Ͻʽÿ�");
						return;
					}

					isdigit(form1.goal.value, form1.achv.value);

//					parent.list.refresh=true;
					form1.qtr.value = parent.form1.qtr.options[parent.form1.qtr.selectedIndex].value;
					alert(form1.qtr.value);
					form1.mode.value=tag;
					form1.submit();
				} else {
					clearComponent();
				}

			} else if (tag=="U") {
				if (form1.achvid.value=="") {
					alert("������ ����� �����Ͻʽÿ�");
					return;
				}
				isdigit(form1.goal.value, form1.achv.value);
				form1.mode.value=tag;
				form1.submit();
				clearComponent();

			} else if (tag=="D") {
				var qtr = parent.form1.qtr.options[parent.form1.qtr.selectedIndex].value
				if (form1.rid.value=="") {
					alert("������ ����� �����Ͻʽÿ�");
					return;
				}
				if (confirm("������ �������������� "+qtr+"�б� ������ �����Ͻðڽ��ϱ�?")){
//					parent.list.refresh=true;

					form1.mode.value=tag;
					form1.submit();
				}

			}
		}

		function saveAct()
		{
			if('<%=mgrYn%>' == 'N')
			{
				alert("�μ��� ����ڰ� �ƴմϴ�.\n����ڿ��� ���� �ϼ���.");
				return;
			}

			if (form1.goal.value=="")
			{

				alert("��ǥ�� �Է� �Ͻʽÿ�");
				return;
			}

			if(form1.achv.value=="")
			{
				alert("������ �Է� �Ͻʽÿ�");
				return;
			}

			if(form1.pgDesc.value=="")
			{

				alert("���������� ��� �Ͻʽÿ�");
				return;
			}

			isdigit(form1.goal.value, form1.achv.value);

			parent.list.refresh=true;
			form1.qtr.value = parent.form1.qtr.options[parent.form1.qtr.selectedIndex].value;

			form1.mode.value="C"
			form1.submit();




		}

		function clearComponent()
		{
			form1.achvid.value="";
			form1.goal.value="";
			form1.achv.value="";
			form1.pgDesc.value="";
		}

		function detailRefresh(){
			//alert(parent.list.refresh);
			if (parent.list.refresh==true){
				parent.list.form1.submit();
			}
		}



		function isdigit(goal, achv)
		{
		    if (goal.search(/[^0-9]/g)!=-1)
		    {
		       	alert("��ǥ/�������� ���ڸ� �Է� ���� �մϴ�.");
		       	return ;
		    }


		    if (achv.search(/[^0-9]/g)!=-1)
		    {
		       	alert("��ǥ/�������� ���ڸ� �Է� ���� �մϴ�.");
		       	return ;
			}
		}

	    function openFilePopup(did)
	    {
	    	if('<%=mgrYn%>' == 'N')
			{
				alert("�μ��� ����ڰ� �ƴմϴ�.\n����ڿ��� ���� �ϼ���.");
				return;
			}
			if (form1.achvid.value=="")
			{
				alert("������������ �����Ͻʽÿ�");
				return;
			}
//	     	var year = parent.selYear.options[parent.selYear.selectedIndex].value;
			var url = "./renovActualFileUpload_P.jsp?did="+did;
	        fileWin =  window.open(url, '���ν�������߰�', 'width=310,height=120' );
	    }

</script>
<body>
			<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<!--  				<tr>
					<td height="30" colspan="4" bgcolor="#FFFFFF"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
	                  	���λ���</strong>
	                </td>
	           </tr>
-->
			<form name="form1" action="" method="post">
			<input type="hidden" name="mode">
			<input type="hidden" name="rid" value="<%=rid %>">
			<input type="hidden" name="did" value="<%=did %>">
			<input type="hidden" name="achvid" value="<%=achvid %>">
			<input type="hidden" name="qtr" value="">


				<tr>
	                <td width="25%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">����<br>����������ȹ</font></strong></td>
	                <td width="75%" bgcolor="#FFFFFF" colspan="4" colspan="3"><textarea name="dtlDesc" cols="45" readonly ><%=dtlDesc %></textarea></td>
	         	</tr>
	             <tr>
	                <td width="25%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">��ǥ</font></strong></td>
	                <td bgcolor="#FFFFFF" width="25%" >
						<input name="goal" value="<%=goal %>" size="3" maxlength="3" <%if(!(mgrYn.equals("Y") || auth.equals("1")))out.print("readonly"); %>>%
	                 </td>
	                <td width="25%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">����</font></strong></td>
	                <td width="25%" bgcolor="#FFFFFF" >
	                	<input name="achv" value="<%=achv %>" size="3" maxlength="3" <%if(!(mgrYn.equals("Y") || auth.equals("1")))out.print("readonly"); %>>%
	                 </td>
	              </tr>
	              <tr bgcolor="#FFFFFF">
	                <td width="25%" align="center" bgcolor="#D4DCF4" colspan="6"><strong><font color="#003399">��������</font></strong></td>
  				  </tr>
  				  <tr bgcolor="#FFFFFF">
	                <td width="75%" colspan="4">
	                    <textarea name="pgDesc" rows="18" cols="59" class="textarea_box" <%if(!(mgrYn.equals("Y") || auth.equals("1")))out.print("readonly"); %>><%=execWork %></textarea>
	               </td>
	              </tr>
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="4">
<!--                	<a href="javascript:actionPerformed('C')"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="�߰�" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;	-->
<!-- 	                	<a href="javascript:actionPerformed('U')"><img src="<%=imgUri %>/jsp/web/images/btn_edit.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;	-->
						<%if(!(mgrYn.equals("Y") || auth.equals("1"))){ %>
 	                	<a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="�߰�" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>
	                	<a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_file_upload.gif" alt="���ϵ��" width="65" height="20" border="0" align="absmiddle"></a>
	                	<%}else{ %>
 	                	<a href="javascript:saveAct()"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="�߰�" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('D','<%=dtlDesc %>')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>
	                	<a href="javaScript:openFilePopup('<%=did %>');"><img src="<%=imgUri %>/jsp/web/images/btn_file_upload.gif" alt="���ϵ��" width="65" height="20" border="0" align="absmiddle"></a>
						<%} %>
					</td>
	              </tr>
	           </form>
            </table>

</body>
</html>