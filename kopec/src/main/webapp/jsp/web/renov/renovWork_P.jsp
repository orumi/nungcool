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
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.lang.String"%>
<%
	request.setCharacterEncoding("euc-kr");
	StringBuffer optUser = new StringBuffer();

	

	String userId = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(userId.equals("")) 
	{
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	

	RenovWorkMgr ta = new RenovWorkMgr();

	ta.getDetailExe(request, response);
	
	
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	
//	DataSet detail = (DataSet)request.getAttribute("ds");
    DataSet dsUser = (DataSet)request.getAttribute("dsUser");
  
    StringBuffer sq = new StringBuffer();
    StringBuffer eq = new StringBuffer();
    
    String renovWork = "";
    String renovExec = "";
    String renovDtlDEsc = "";
    
    String sqtr = "";
    String eqtr = "";

    String pid = request.getParameter("pid");
    String did = request.getParameter("did");
    String tag = request.getParameter("tag");
	
    String proc = (String)request.getAttribute("proc")==null?"":(String)request.getAttribute("proc");
 
    if(dsUser != null)
    {
    	while(dsUser.next())
    	{
    		renovWork = dsUser.isEmpty("RENOVNAME")?"":dsUser.getString("RENOVNAME");
    		sqtr = dsUser.isEmpty("sqtr")?"":dsUser.getString("sqtr");
    		eqtr = dsUser.isEmpty("eqtr")?"":dsUser.getString("eqtr");
    		if(tag.equals("U"))
    		{
    			renovExec = dsUser.isEmpty("RENOVDTLNAME")?"":dsUser.getString("RENOVDTLNAME");
    			renovDtlDEsc = dsUser.isEmpty("RENOVDTLDESC")?"":dsUser.getString("RENOVDTLDESC");
    		}
    	}
    }
	
    for(int i = 1; i < 5 ; i++)
    {
    	if(String.valueOf(i).equals(sqtr))
    	{
    		sq.append("<option value='" + i + "' selected>" + i + " �б�</option>");
    	}
    	else
    	{
    		sq.append("<option value='" + i + "'>" + i + " �б�</option>");
    	}
    }
	
    
    for(int i = 1; i < 5 ; i++)
    {
    	if(String.valueOf(i).equals(eqtr))
    	{
    		eq.append("<option value='" + i + "' selected>" + i + " �б�</option>");
    	}
    	else
    	{
    		eq.append("<option value='" + i + "'>" + i + " �б�</option>");
    	}
    }
    
    
    
    
	if(proc.equals("pop"))
	{
%>
		<script>
			window.opener.parentReload('<%=pid%>', '<%=renovWork%>');
			window.self.close();
		</script>
<%
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>���� ������� �߰�</title>
</head>

<script>

	function addExecWork() {
	
		var sqtr = parseInt(form1.sqtr.options[form1.sqtr.selectedIndex].value);
		var eqtr = parseInt(form1.eqtr.options[form1.eqtr.selectedIndex].value);
		
		if(sqtr > eqtr)
		{
			alert("���ۺбⰡ ���б� ���� Ŭ�� �����ϴ�.");
			return;
		}
		
		if (form1.execWork.value==""){
			alert("����������� ����Ͻʽÿ�");
			return;
		}
		
		if (form1.renovExec.value==""){
			alert("�������������� ����Ͻʽÿ�");
			return;
		}
		
//		if (form1.renovDtl.value==""){
//			alert("���γ����� ����Ͻʽÿ�");
//			return;
//		}

		 form1.submit();
	}


</script>
<body>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">

            <!------//������Ʈ �Է� //---->
            <form name="form1" method="post" action="">
            <input type="hidden" name="mode" value="<%=tag.equals("I")?"G":"T" %>">
            <input type="hidden" name="pid" value="<%=pid %>">
            <input type="hidden" name="did" value="<%=did %>">
            
            
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
		                  ������������</strong></td>
              </tr>
            </table>
			<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">���Ű���</font></strong></td>
                <td width="46%">
                    <input name="execWork" type="text" class="input_box" readonly size="65" value="<%=renovWork%>">
                  <strong></strong></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4" ><strong><font color="#003399">��������������ȹ</font></strong></td>
                <td bgcolor="#FFFFFF">
<!--                     <textarea name="renovExec" class="textarea_box" cols="88" rows="2" disable="true"><%=renovExec %></textarea> -->
					<input type="textbox" name="renovExec" size="65" class="input_box" value="<%=renovExec %>">
                 </td>

              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�б�</font></strong></td>
                <td width="46%">
                    <select name="sqtr">
						<%=sq.toString() %>
                   	</select>
						~ 
                    <select name="eqtr">
						<%=eq.toString() %>
                   	</select>

                 </td>
              </tr>

              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4" colspan="2"><strong><font color="#003399">��������</font></strong></td>
              </tr>
              <tr>
                <td  colspan="2" bgcolor="#FFFFFF">
                    <textarea name="renovDtl" cols="88" rows="30" class="textarea_box" disable="true"><%=renovDtlDEsc%></textarea>
                 </td>
              </tr>

            <table width="90%" border="0" align="right" cellpadding="5" cellspacing="1">
              <tr>
                <td align="right"><a href="javascript:addExecWork();"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;</td>
              </tr>
            </table>
            </form>
</body>
</html>