<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):"";
	String write = "";	//���� �Է� ���θ� ������ �ִ�.
	if(id.equals("")) {
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		
		return;
		
	}

	TaskActualUtil tau = new TaskActualUtil();
    tau.taskActualQtr(request, response);

    DataSet ds = (DataSet)request.getAttribute("ds");
	int syear = 0;
	int eyear = 0;
	int sqtr = 0;
	int eqtr = 0;
	double sum = 0;
	double cnt = 0;
	int curYear = 0;	//�� �⵵ �޺��� �ִ� �⵵


    String group = (String)session.getAttribute("groupId")==null?"":(String)session.getAttribute("groupId"); //���ǿ� �ִ� user ����
    String detailid = request.getParameter("detailid")==null?"":request.getParameter("detailid");
    
    String dtlid = request.getParameter("dtlid");
    String year = request.getParameter("year");
//-- �� �б� ���� �ѹ� ó�� ���ؼ� �� �׸��� �б⿡ �°� �迭�� ����.
	String[] target = new String[4];    //�� �б��ǥ
	String[] actual = new String[4];    //�� �б����
	String[] realize = new String[4];   //�� �б� �޼���
    String[] achvid = new String[4];
    String[] qtrN = new String[4];
    String[] file = new String[4];

	if (ds!=null) {
		while (ds.next()) {
			int i = ds.getInt("QTR");
//			out.println(i);
			i = i-1;
			target[i] = ds.isEmpty("QTRGOAL")?"":ds.getString("QTRGOAL");
			actual[i] = ds.isEmpty("QTRACHV")?"":ds.getString("QTRACHV");
			realize[i]  = ds.isEmpty("REALIZE")?"":ds.getString("REALIZE");

			achvid[i] = ds.isEmpty("ACHVID")?"":ds.getString("ACHVID");
            qtrN[i] = ds.isEmpty("QTR")?"":ds.getString("QTR");
		}
    }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">

    function formSend()   {
	    form1.mode.value="U";
        form1.submit();
    }

	var fileWin;

	function isdigit(str) {

		if(str.length >= 10)
		{
			alert("�Ҽ��� ���� 10�ڸ� ������ �Է� ���� �մϴ�.");
			return;
		}

	}
	
	function openFilePopup(dtlid,qtr){
		typeid=1;
		window.open("taskActualFileUpload_P.jsp?year=<%=year%>&qtr="+qtr+"&typeid="+typeid+"&did="+dtlid,"fileUpload","top=0,left=0,width=300,height=300");
	}
	
</script>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
        <form name="form1" method="post">
        <input type="hidden" name="mode">
        <input type="hidden" name="dtlid" value="<%=dtlid %>">
        <input type="hidden" name="year" value="<%=year %>">
        <input type="hidden" name="detailid" value="<%=detailid %>">
            <table width="98%"  border="0" align="left" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
              <tr align="center" bgcolor="#E8E8E8">
                <td><strong>�б�</strong></td>
                <td><strong>��ǥ������(%)</strong></td>
                <td><strong>����������(%)</strong></td>
                <td><strong>�޼���(%)</strong></td>
                <td colspan="2"><strong>�ٰ��ڷ�</strong></td>
              </tr>

<%
	for (int k=0;k<4;k++)
	{
		if(syear != 0 && eyear != 0)	//���۳�� ���⿡ ���� ���������� ������.
		{
			if((target[k]==null || target[k].equals("")))	//�б⿡ ���� ������...
			{
				int count = 0;
			    if(curYear == syear)	//������� ���� ���� ������.
			    {
					if(sqtr <= k+1)
					{
				    	count = ((k+1) - sqtr)+1;
//				    	out.print("sum="+sum);

				    	target[k] = Common.numRound(String.valueOf(sum*count),2);


		//				out.println(eqtr-(k+1));

					}

					if(curYear == eyear)	//���� �⵵�� ���⵵�� ����
					{
						if(sqtr == k+1 && eqtr == k+1)	//���ۺб�� ���бⰡ ������.
						{
							target[k] = "100.0";
						}
						else if(k+1 >= sqtr && k+1 <= eqtr)
						{
//					    	count = ((k+1) - sqtr)+1;

					    	target[k] = Common.numRound(String.valueOf(sum*count),2);
//					    	out.println("bbb");

						}
						else
						{
							target[k] = "";
						}
					}
			    }
			    else if(curYear > syear && curYear < eyear) //���� �⵵�� �߱�Ⱓ ��  �϶�.
			    {
			    	count = ((curYear - syear)-1)*4 +(4-sqtr+1)+(k+1);
	//		    	out.print(count);
			    	target[k] = Common.numRound(String.valueOf(sum*count),2);
//			    	out.println("ccc");

	//		    		sum = 100/cnt;

			    }
			    else
			    {
			    	if(eqtr >= k+1)
			    	{
				    	count = ((curYear - syear)-1)*4 +(4-sqtr+1)+(k+1);



				    	target[k] = Common.numRound(String.valueOf(sum*count),2);
//				    	out.print("ddd" + sum);
//			    		sum = 100/cnt;
			    	}
			    }
			}


%>
              <tr align="center" bgcolor="#FFFFFF" >
                <td><%=k+1 %>�б�</td>
                <td><input onkeyup="isdigit(this.value);" <%=write %> maxlength="10" name="qtrGoal<%=k+1 %>" type="text" class="input_box" style="text-align:right;" value="<%=target[k]!=null?target[k]:"" %>" <% //if(!(group.equals("1"))){out.println("readonly");}else{out.println("");}%>></td>
                <td><input onkeyup="isdigit(this.value);" <%=write %> maxlength="10" name="qtrAchv<%=k+1 %>" type="text" class="input_box" style="text-align:right;"  value="<%=actual[k]!=null?actual[k]:"" %>" ></td>
                <td><input onkeyup="isdigit(this.value);"  name="qtrRealize<%=k+1 %>" type="text" class="input_box" style="text-align:right;"  value="<%=realize[k]!=null?realize[k]:"" %>" readonly></td>
                <td><a href="javaScript:openFilePopup('<%=dtlid %>','<%=k+1%>');"><img src="<%=imgUri %>/jsp/web/images/btn_file_upload.gif" alt="�ڷ���" width="65" height="20" border="0" align="absmiddle"></a></td>
              </tr><input type="hidden" name="file1" value="<%=file[k]!=null?file[k]:""%>">
                   <input type="hidden" name="achvid1" value="<%=achvid[k]!=null?achvid[k]:""%>">
<%
		} else {
%>
              <tr align="center" bgcolor="#FFFFFF" >
                <td><%=k+1 %>�б�</td>
                <td><input onkeyup="isdigit(this.value);" <%=write %> maxlength="10" name="qtrGoal<%=k+1 %>" type="text" class="input_box" style="text-align:right;" value="<%=target[k]!=null?target[k]:""%>" <%// if(!(group.equals("1"))){out.println("readonly");}else{out.println("");}%>></td>
                <td><input onkeyup="isdigit(this.value);" <%=write %> maxlength="10" name="qtrAchv<%=k+1 %>" type="text" class="input_box" style="text-align:right;"  value="<%=actual[k]!=null?actual[k]:""%>" ></td>
                <td colspan="2"><input onkeyup="isdigit(this.value);"  name="qtrRealize<%=k+1 %>" type="text" class="input_box" style="text-align:right;"  value="<%=realize[k]!=null?realize[k]:"" %>" readonly></td>                <td><a href="javaScript:openFilePopup('<%=dtlid %>','<%=k+1%>');"><img src="<%=imgUri %>/jsp/web/images/btn_file_upload.gif" alt="�ڷ���" width="65" height="20" border="0" align="absmiddle"></a></td>
              </tr><input type="hidden" name="file1" value="<%=file[k]!=null?file[k]:""%>">
                   <input type="hidden" name="achvid1" value="<%=achvid[k]!=null?achvid[k]:""%>">
<%
		}

	}%>
             
			  <tr bgcolor="#FFFFFF">
			  	<td align="center" colspan="6"><a href="javascript:formSend();"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;</td>
			  </tr>
            </table>

        </form>
</body>
</html>