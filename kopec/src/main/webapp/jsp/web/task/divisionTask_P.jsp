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
<%@ page import="java.util.ArrayList"%>

<%

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
    TaskProceed tp = new TaskProceed();
    tp.procDetailQtr1(request,response);

    DataSet qtrSt_Ed = (DataSet)request.getAttribute("qtrSt_Ed");
    DataSet detailQtr1 = (DataSet)request.getAttribute("detailQtr1");
	
    String div = request.getParameter("div");
	String sdtlid = request.getParameter("sdtlid");
	
    String prjNm = "";
    String execwork = "";
	String dtlname = "";
    int syear = 0;
    int eyear = 0;
    if(qtrSt_Ed != null)
    {
        while(qtrSt_Ed.next())
        {
            prjNm = qtrSt_Ed.isEmpty("PROJECTNAME")?"":qtrSt_Ed.getString("PROJECTNAME");
            execwork = qtrSt_Ed.isEmpty("EXECWORK")?"":qtrSt_Ed.getString("EXECWORK");
            syear = qtrSt_Ed.isEmpty("SYEAR")?0:qtrSt_Ed.getInt("SYEAR");
            eyear = qtrSt_Ed.isEmpty("EYEAR")?0:qtrSt_Ed.getInt("EYEAR");
            dtlname = qtrSt_Ed.isEmpty("DTLNAME")?"":qtrSt_Ed.getString("DTLNAME");
        }
    }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<%if(div.equals("2")) {%>
<title>������ȹ ������</title>
<%}	else if(div.equals("1")) 
		if(!sdtlid.equals("0"))
		{ 
			out.print("<title>���ν����ȹ ������</title>");
		}
		else
		{
			out.print("<title>�����ȹ ������</title>");
		}
%>

</head>
<body>
    <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
<%if(div.equals("2")) {%>
������ȹ ��ô��ǥ�޼���
<%}	else if(div.equals("1")) 
		if(!sdtlid.equals("0"))
		{ 
			out.print("���ν����ȹ ������");
		}
		else
		{
			out.print("�����ȹ ��ô��ǥ�޼���");
		}
%>
                  	</strong></td>
              </tr>
	</table>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">��Ī</font></strong></td>
        <td width="85%"><strong><input name="projectNmText" type="text" class="input_box" size="80" readonly value="<%=prjNm%>"></strong></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�����ȹ<br>(������ȹ)</font></strong></td>
        <td><input name="projectNmText" type="text" class="input_box" size="80" readonly value="<%=execwork%>"></td>
      </tr>
	<%if(div.equals("1")&& !sdtlid.equals("0")) { %>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">���ν����ȹ</font></strong></td>
        <td><input name="projectNmText" type="text" class="input_box" size="80" readonly value="<%=dtlname%>"></td>
      </tr>	
	<%} %>
    </table><!------//������Ʈ ��//---->
<table>
	<tr>
		<td>
		</td>
	</tr>
</table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<%if(div.equals("1")&& sdtlid.equals("0")) { %>
		      <tr bgcolor="#D4DCF4">
                <td align="center"><strong><font color="#003399">�⵵</font></strong></td>
                <td align="center"><strong><font color="#003399">1�б� �޼���</font></strong></td>
                <td align="center"><strong><font color="#003399">2�б� �޼���</font></strong></td>
                <td align="center"><strong><font color="#003399">3�б� �޼���</font></strong></td>
                <td align="center"><strong><font color="#003399">4�б� �޼���</font></strong></td>
              </tr>
<%
            if(detailQtr1 != null && detailQtr1.getRowCount() != 0)
            {
                for(int i = syear; i <= eyear; i++)	//--���ν��� ������ �����Ⱓ �⵵�� �����ͼ� �����Ⱓ�� �Է��� �ȵ� �⵵ ���� ǥ��
                {
               		detailQtr1.next();
               		if(i == detailQtr1.getInt("YEAR"))
               		{
               			String realize = detailQtr1.isEmpty("REALIZE")?"":detailQtr1.getString("REALIZE");
						if(realize == null)
							realize = "";
%>              
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=detailQtr1.isEmpty("YEAR")?"":detailQtr1.getString("YEAR")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR1")?"":detailQtr1.getString("QTR1")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR2")?"":detailQtr1.getString("QTR2")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR3")?"":detailQtr1.getString("QTR3")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR4")?"":detailQtr1.getString("QTR4")%></td>
              </tr>
<%
               		}
               		else
               		{
%>              
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=i %></td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>                
                <td align="center">&nbsp;</td>  
              </tr>
<%
               		}
                }
            }
%>
              <tr bgcolor="#FFFFFF">
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>                
                <td align="center">&nbsp;</td>                
              </tr> 
<%} else { %>
             <tr bgcolor="#D4DCF4">
                <td align="center"><strong><font color="#003399">�⵵</font></strong></td>
                <td align="center"><strong><font color="#003399">1�б�<br>����/��ǥ(�޼���)</font></strong></td>
                <td align="center"><strong><font color="#003399">2�б�<br>����/��ǥ(�޼���)</font></strong></td>
                <td align="center"><strong><font color="#003399">3�б�<br>����/��ǥ(�޼���)</font></strong></td>
                <td align="center"><strong><font color="#003399">4�б�<br>����/��ǥ(�޼���)</font></strong></td>

              </tr>
<%
            if(detailQtr1 != null && detailQtr1.getRowCount() != 0)
            {
                for(int i = syear; i <= eyear; i++)	//--���ν��� ������ �����Ⱓ �⵵�� �����ͼ� �����Ⱓ�� �Է��� �ȵ� �⵵ ���� ǥ��
                {
               		detailQtr1.next();
               		if(i == detailQtr1.getInt("YEAR"))
               		{
%>
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=detailQtr1.isEmpty("YEAR")?"":detailQtr1.getString("YEAR")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR1")?"":detailQtr1.getString("QTR1")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR2")?"":detailQtr1.getString("QTR2")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR3")?"":detailQtr1.getString("QTR3")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR4")?"":detailQtr1.getString("QTR4")%></td>
              </tr>
<%
               		}
               		else
               		{
%>
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=i %></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
              </tr>
<%
               		}
                }
            }
%>
              <tr bgcolor="#FFFFFF">
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
              </tr>
<%} %>
            </table>
</body>
</html>