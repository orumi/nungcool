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
<%@ page import="com.nc.util.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%
    request.setCharacterEncoding("euc-kr");
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.')");
		out.print("top.location.href='../loginProc.jsp'");
		out.print("</script>");
	}
	
	
	RenovActual ta = new RenovActual();
	ta.setDivision(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");

		

	StringBuffer sbPBSC = new StringBuffer();
	StringBuffer sbBSC = new StringBuffer();
	StringBuffer years = new StringBuffer();
	int currYear = Integer.parseInt(Util.getToDay().substring(0,4));

	for(int i = currYear-5; i <= currYear+5; i++)
	{
		if(i == currYear)
			years.append("<option value=" + i + " selected>" + i + "</option>");
		else
		{
			years.append("<option value=" + i + ">" + i + "</option>");
		}
	}

	
	String bscId = request.getParameter("bscId")!=null?request.getParameter("bscId"):"";
	String objId = request.getParameter("objId")!=null?request.getParameter("objId"):"";
	



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<Script Language="javaScript">

	var arrOrg = new Array();

	function initrs(code,name,parent,level) {
		arrOrg[arrOrg.length] = new orgCD(code,name,parent,level);
	}



	function orgCD(code,name,parent,level) {
		this.code = code;
		this.name = name;
		this.parent = parent;
		this.level = level;
	}


	function changePBSC() {
		form1.selBSC.length=0;
//		form1.selBSC.options[form1.selBSC.length] = new Option('-',-1);
		var length = arrOrg.length;

		var pCode = form1.selPBSC.options[form1.selPBSC.selectedIndex].value;

		for (i=0;i<length;i++) {
			if (arrOrg[i].level==1) {
				if (arrOrg[i].parent==pCode) {
					form1.selBSC.options[form1.selBSC.length] = new Option(arrOrg[i].name,arrOrg[i].code);
				}
			}
		}
	}

/*
	function resChange()	//coolChart
	{
		var tblRow = chartList.listTbl.rows.length-1;
		
		if(chartList.listTbl.rows.length != 0)
		{
			for(var i = tblRow; i >= 0; i--)
			{
				chartList.listTbl.deleteRow(i);
			}
		}
		
		if(chartList.titleTbl.rows.length != 0)
			chartList.titleTbl.deleteRow(0);
	}

*/
		function openDetail() 
		{

//			if(form1.selBSC.options[form1.selBSC.selectedIndex].text == '-')
//				alert('ó �Ǵ� ���� �����ϼ���.');

				list.form1.year.value = form1.year.options[form1.year.selectedIndex].value;
				list.form1.deptid.value = form1.selBSC.options[form1.selBSC.selectedIndex].value;
				list.form1.qtr.value = form1.qtr.options[form1.qtr.selectedIndex].value;
            	list.form1.submit();
		}

		function chCombo() 
		{		
			dtl.form1.dtlDesc.value="";
			dtl.form1.goal.value="";
			dtl.form1.achv.value="";
			dtl.form1.pgDesc.value="";
		}
		
		
</Script>
<%
	int cnt = 0;
	int cId = -1;
//	sbBSC.append("<option value='-1'>-</option>");
	if (ds!=null) {
		while(ds.next()) {

			if (ds.isEmpty("PARENTID")){
				if (cnt == 0){
					cId = ds.getInt("ID");
					cnt++;
				}
				sbPBSC.append("<option value='"+ds.getString("ID")+"'>"+ds.getString("NAME")+"</option>");
			} else {
				if ( cId == ds.getInt("PARENTID")){
					sbBSC.append("<option value='"+ds.getString("ID")+"'>"+ds.getString("NAME")+"</option>");
				}
				%>
				<script>
				initrs('<%=ds.getString("ID")%>','<%=ds.getString("NAME")%>','<%=ds.getString("PARENTID")%>','1');
				</script>
				<%
			}


		}
	}

%>




<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>

		<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
			<form name="form1" method="post" action="">
								<tr>
	                  <td width="10%" align="center" bgcolor="#DCEDF6">
	                  	<strong>
		                  	<font color="#006699">�ش�⵵
		                  	</font>
	                  	</strong>
	                  </td>
	                  <td width="20%" align="left" bgcolor="#FFFFFF">
	                 	 <select name="year" style="width:100px;" onchange="chCombo()">
	                 	 <%=years.toString() %>
	                 	 </select>
	                  </td>
	                  <td width="10%" align="center" bgcolor="#DCEDF6">
	                  	<strong>
		                  	<font color="#006699">�б�
		                  	</font>
	                  	</strong>
	                  </td>
	                  <td width="60%" align="left" bgcolor="#FFFFFF">
	                 	 <select name="qtr" style="width:100px;" onchange="chCombo()">
							<option value="1">1�б�</option>
							<option value="2">2�б�</option>
							<option value="3">3�б�</option>
							<option value="4">4�б�</option>
	                 	 </select>
	                  </td>
				</tr>
	              <tr>
	                  <td width="10%" align="center" bgcolor="#DCEDF6">
	                  	<strong>
		                  	<font color="#006699">�μ� ����
		                  	</font>
	                  	</strong>
	                  </td width="90%">
	                  <td bgcolor="#FFFFFF" colspan="3">
	                  	<select name="selPBSC" style="width:200px;" onChange="javascript:changePBSC();chCombo();">
							<%= sbPBSC.toString() %>
	                    </select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                  	<select name="selBSC" style="width:200px;" onchange="chCombo()">
							<%= sbBSC.toString() %>
	                    </select> &nbsp;&nbsp;
	                    	<a href="javascript:openDetail();" >
	                    		<img src="<%=imgUri %>/jsp/web/images/btn_ok.gif" alt="Ȯ��" width="50" height="20" border="0" align="absmiddle" >
	                    	</a>
	                  </td>
	                </tr>
				</form>
            </table>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="500" width="45%" align="left" cellpadding="0" cellspacing="0">
                	<!------//������Ʈ//---->
             		<iframe frameborder="0" id="list" SCROLLING="auto" src="./renovActualProjectNM.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
            		<!------//������Ʈ ��//---->
            	</td>
            	<td align="left" width="55%" cellpadding="0" cellspacing="0">
					<!--------//����Ʈ //------->
		             <iframe frameborder="0" id="dtl" SCROLLING="auto" src="./renovActualList.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
					<!--------//����Ʈ �� //------->
            	</td>
              </tr>
            </table>
</body>
</html>