<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="java.util.ArrayList"%>

<%

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) {
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		return;
	}
	
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
    TaskProceed tp = new TaskProceed();
    tp.procDetailQtr1(request,response);

    DataSet qtrSt_Ed = (DataSet)request.getAttribute("qtrSt_Ed");
    DataSet detailQtr1 = (DataSet)request.getAttribute("detailQtr1");
	
    String div = request.getParameter("div");	//����id
	String sdtlid = request.getParameter("sdtlid");
	String pdtlid = request.getParameter("pdtlid");
	String dtlid = "";
	if(div.equals("1"))
	{
		dtlid = sdtlid;
	}
	else
	{
		dtlid = pdtlid;
	}
	

    String prjNm = "";
    String execwork = "";
	String dtlname = "";
	String deptNm = "";
	String relaDept_1 = "";
	String relaDept_2 = "";
	String stopYn = "";
	String stopY = "";
	String stopQ = "";
	String sQtr = "";
	String eQtr = "";
	String stopStr = ""	;
    int syear = 0;
    int eyear = 0;
    if(qtrSt_Ed != null)
    {
        while(qtrSt_Ed.next())
        {
            prjNm = qtrSt_Ed.isEmpty("NAME")?"":qtrSt_Ed.getString("NAME");
            execwork = qtrSt_Ed.isEmpty("EXECWORK")?"":qtrSt_Ed.getString("EXECWORK");
            deptNm = qtrSt_Ed.isEmpty("MGRDEPT")?"":qtrSt_Ed.getString("MGRDEPT");
            syear = qtrSt_Ed.isEmpty("SYEAR")?0:qtrSt_Ed.getInt("SYEAR");
            eyear = qtrSt_Ed.isEmpty("EYEAR")?0:qtrSt_Ed.getInt("EYEAR");
            sQtr = qtrSt_Ed.isEmpty("SQTR")?"":qtrSt_Ed.getString("SQTR");
            eQtr = qtrSt_Ed.isEmpty("EQTR")?"":qtrSt_Ed.getString("EQTR");
            dtlname = qtrSt_Ed.isEmpty("DTLNAME")?"":qtrSt_Ed.getString("DTLNAME");
            //relaDept_1 = qtrSt_Ed.isEmpty("RELADEPT_1")?"":qtrSt_Ed.getString("RELADEPT_1");
            //relaDept_2 = qtrSt_Ed.isEmpty("RELADEPT_2")?"":qtrSt_Ed.getString("RELADEPT_2");
            //stopYn = qtrSt_Ed.isEmpty("STOPYN")?"":qtrSt_Ed.getString("STOPYN");
            //stopY = qtrSt_Ed.isEmpty("STOPYEAR")?"":qtrSt_Ed.getString("STOPYEAR");
            //stopQ = qtrSt_Ed.isEmpty("STOPQTR")?"":qtrSt_Ed.getString("STOPQTR");
        }
    }
    if(stopYn.equals("Y"))
		stopStr = stopY + "�⵵ " + stopQ + "�б�";
    
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

<script>
	var exeWin;
	function openChildPop()
	{

//				var typeid = parent.detail.form1.selType.options[parent.detail.form1.selType.selectedIndex].value;
				var url = "taskActual_P.jsp?detailid="+<%=dtlid%>+"&typeid="+<%=div%>+"&mode=P" ;
//				var url = "taskActual_P.jsp?";
			    exeWin = window.open(url, '��������߰�', 'toolbar=no,Width=650px,Height=500px,scroll=yes,resizable=no,menubar:yes,help=no,status=yes');

			    exeWin.focus();
	}
	
	function filePop(year, qtr)
	{
//				var typeid = parent.detail.form1.selType.options[parent.detail.form1.selType.selectedIndex].value;
//				var url = "achvFile_P.jsp?did="+<%=dtlid%>+"&typeid="+<%=div%>+"&year="+year+"&qtr="+qtr;
//				var url = "achvFile_P.jsp?detailid="+;
//			    exeWin = window.open(url, '��������߰�', 'toolbar=yes,Width=400px,Height=500px,scroll=yes,resizable=no,menubar:yes,help=no,status=yes');

//			    exeWin.focus();
		
		fileList.form1.typeid.value = <%=div%>;
		fileList.form1.qtr.value = qtr;
		fileList.form1.did.value = <%=dtlid%>;
		fileList.form1.year.value = year;
		fileList.form1.submit();
	}
</script>
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
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">Sub ����</font></strong></td>
        <td width="85%" colspan="3"><strong><input name="projectNmText" type="text" class="input_box" size="80" readonly value="<%=prjNm%>"></strong></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�ְ��μ�</font></strong></td>
        <td width="20%" colspan=3><strong><input name="projectNmText" type="text" class="input_box" size="20" readonly value="<%=deptNm%>"></strong></td>

      </tr>      
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�������<br>(��������)</font></strong></td>
        <td colspan="3"><input name="projectNmText" type="text" class="input_box" size="75" readonly value="<%=execwork%>">
		<%if(div.equals("2")){ %>
            <a href="javascript:openChildPop();">
        		<img src="<%=imgUri %>/jsp/web/images/btn_plann_actual01.gif" width="81" height="20" align="absmiddle">
        	</a>
        	<%} %>
        </td>
      </tr>
      <%if(div.equals("2")){ %>
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�����Ⱓ</font></strong></td>
        <td width="30%" ><%=syear+"�� " + sQtr + "�б� ~ " + eyear + "�� " + eQtr + "�б�"  %></td>
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�ߴܽ���</font></strong></td>
        <td width="50%" ><%=stopStr %></td>
      </tr> 
      <%} %>      
      
      
	<%if(div.equals("1")&& !sdtlid.equals("0")) { %>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�ֿ���������</font></strong></td>
        <td colspan="3"><input name="projectNmText" type="text" class="input_box" size="75" readonly value="<%=dtlname%>">

        </td>
      </tr>	
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�����Ⱓ</font></strong></td>
        <td width="30%" colspan=3><%=syear+"�� " + sQtr + "�б� ~ " + eyear + "�� " + eQtr + "�б�"  %></td>
      </tr>      
	<%}%>
    </table><!------//������Ʈ ��//---->
      	<%if(stopYn.equals("Y")&&div.equals("1")){ %>
      	<br><center><b><font color="#FF0000" size="3">�ߴܵ� �������� �Դϴ�.</font></b></center>
		<%}else if(stopYn.equals("Y")&&div.equals("2")){ %>
		<br><center><b><font color="#FF0000" size="3">�ߴܵ� �������� �Դϴ�.</font></b></center>
		<%} %>
<table>
	<tr>
		<td>
		</td>
	</tr>
</table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<%if(div.equals("1")&& sdtlid.equals("0")) { //������ ������Ʈ�� ���� ���� �϶�.%>	
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
<%} else { //������������Ʈ�� ���ν��� ���� �϶� & ���� ���� ���� %>	
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
                <td align="center"><%=detailQtr1.isEmpty("YEAR")?"":detailQtr1.getString("YEAR")%>
                </td>
                <td align="center"><%=detailQtr1.isEmpty("QTR1")?"":detailQtr1.getString("QTR1")%>
	                <a href="javascript:filePop('<%=detailQtr1.getString("YEAR")%>','1');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
                </td>
                <td align="center"><%=detailQtr1.isEmpty("QTR2")?"":detailQtr1.getString("QTR2")%>
	                <a href="javascript:filePop('<%=detailQtr1.getString("YEAR")%>','2');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
                </td>
                <td align="center"><%=detailQtr1.isEmpty("QTR3")?"":detailQtr1.getString("QTR3")%>
	                <a href="javascript:filePop('<%=detailQtr1.getString("YEAR")%>','3');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
                </td>
                <td align="center"><%=detailQtr1.isEmpty("QTR4")?"":detailQtr1.getString("QTR4")%>
	                <a href="javascript:filePop('<%=detailQtr1.getString("YEAR")%>','4');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
                </td>
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
<%} %>
            </table>
<%if(!(div.equals("1")&& sdtlid.equals("0"))) { //������ ������Ʈ�� ���� ������ �ƴҶ�.%>	            
            <iframe frameborder="0" id="fileList" SCROLLING="no" src="./achvFiles.jsp" style="body" width="100%" height="90%" >&nbsp;</iframe>
<%} %>
</body>
</html>