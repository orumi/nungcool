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
<%@ page import="com.nc.util.*"%>

<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	TaskActualUtil tau = new TaskActualUtil();

    tau.taskActualQtr(request, response);

    DataSet ds = (DataSet)request.getAttribute("ds");


    String group = (String)session.getAttribute("groupId"); //���ǿ� �ִ� user ����
    if (!group.equals("1") || group == null) return;
    
    String did = request.getParameter("did");

//-- �� �б� ���� �ѹ� ó�� ���ؼ� �� �׸��� �б⿡ �°� �迭�� ����.
	String[] target = new String[4];    //�� �б��ǥ
	String[] actual = new String[4];    //�� �б����
	String[] realize = new String[4];   //�� �б� �޼���
    String[] achvid = new String[4];
    String[] qtrN = new String[4];
    String[] file = new String[4];
    String[] detailid = new String[4];

	if (ds!=null) {
		while (ds.next()) {
			int i = ds.getInt("QTR");
			i = i-1;
			target[i] = ds.isEmpty("QTRGOAL")?"":ds.getString("QTRGOAL");
			actual[i] = ds.isEmpty("QTRACHV")?"":ds.getString("QTRACHV");
			realize[i]  = ds.isEmpty("REALIZE")?"":ds.getString("REALIZE");

			achvid[i] = ds.isEmpty("ACHVID")?"":ds.getString("ACHVID");
            qtrN[i] = ds.isEmpty("QTR")?"":ds.getString("QTR");
            file[i] = ds.isEmpty("FILE")?" ":ds.getString("FILE");
            detailid[i] = ds.isEmpty("DETAILID")?" ":ds.getString("DETAILID");
		}
    }

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
%>
<script>
		alert("�߸��� �����Դϴ�.");
  		top.location.href = "../loginProc.jsp";
</script>
<%  }%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">

    function formSend() {
        form1.did.value = <%=did%>;
        form1.year.value = parent.selYear.options[parent.selYear.selectedIndex].value;
       	form1.mode.value="U";
        form1.submit();
    }

	var fileWin;
	
    function openFilePopup(did,qtr) { 
     	var year = parent.selYear.options[parent.selYear.selectedIndex].value;
		var url = "./taskActualFileUpload_P.jsp?did="+did+"&qtr="+qtr+"&year="+year; 
        fileWin =  window.open(url, '���ν�������߰�', 'width=310,height=500' );
    }

    function goalChk(qtr)
    {
    	if(qtr == "1")
    	{
    		if(form1.qtrGoal1.value == "0")
    		{
    			alert("1�б� ��ǥ���� �Էµ��� �ʾҽ��ϴ�.\n�����ڿ��� ���� �ϼ���.");
    		}
    	}
    	else if(qtr == "2")
    	{
    		if(form1.qtrGoal2.value == "0")
			{
    			alert("2�б� ��ǥ���� �Էµ��� �ʾҽ��ϴ�.\n�����ڿ��� ���� �ϼ���.");
    		}
    	}
    	else if(qtr == "3")
    	{
    		if(form1.qtrGoal3.value == "0")
    		{
    			alert("3�б� ��ǥ���� �Էµ��� �ʾҽ��ϴ�.\n�����ڿ��� ���� �ϼ���.");
    		}
    	}
    	else
    	{
    		if(form1.qtrGoal4.value == "0")
    		{
    			alert("4�б� ��ǥ���� �Էµ��� �ʾҽ��ϴ�.\n�����ڿ��� ���� �ϼ���.");
    		}
    	}
    }
</script>
<body>
        <form name="form1" action="" method="post">
        <input type="hidden" name="mode">
        <input type="hidden" name="pid" >
        <input type="hidden" name="did" value="<%=did %>">
        <input type="hidden" name="year">
            <table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
              <tr align="center" bgcolor="#E8E8E8">
                <td><strong>�б�</strong></td>
                <td><strong>�б��ǥ(%)</strong></td>
                <td><strong>�б����(%)</strong></td>
                <td><strong>�޼���(%)</strong></td>
                <td><strong>�ٰ��ڷ�</strong></td>
              </tr>

<% for (int k=0;k<4;k++){ %>
              <tr align="center" bgcolor="#FFFFFF" >
                <td><%=k+1 %>�б�</td>
                <td><input name="qtrGoal<%=k+1 %>" type="text" class="input_box" value="<%=target[k]!=null?target[k]:"" %>" <% if(!(group.equals("1"))){out.println("readonly");}else{out.println("");}%>></td>
                <td><input name="qtrAchv<%=k+1 %>" type="text" class="input_box" value="<%=actual[k]!=null?actual[k]:"" %>" onfocus="goalChk('1')"></td>
                <td><input name="qtrRealize<%=k+1 %>" type="text" class="input_box" value="<%=realize[k]!=null?realize[k]:"" %>" readonly></td>
                <td><a href="javaScript:openFilePopup('<%=did %>','<%=k+1%>');"><img src="<%=imgUri %>/jsp/web/images/btn_file_upload.gif" alt="�ڷ���" width="65" height="20" border="0" align="absmiddle"></a></td>
              </tr><input type="hidden" name="file1" value="<%=file[k]!=null?file[k]:""%>">
                   <input type="hidden" name="achvid1" value="<%=achvid[k]!=null?achvid[k]:""%>">
                   <input type="hidden" name="detailid1" value="<%=detailid[k]!=null?detailid[k]:""%>">
  <% } %>            
              <tr align="center" bgcolor="#FFFFCC">
                <td><strong><font color="#CC6600">��ü</font></strong></td>
                <td><strong><font color="#CC6600"></font></strong></td>
                <td><strong><font color="#CC6600"></font></strong></td>
                <td></td>
                <td></td>
              </tr>

            </table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
              <tr>
                <td align="right"><a href="javascript:formSend();"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;</td>
              </tr>
            </table>
        </form>
</body>
</html>