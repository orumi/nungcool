<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	String schDate = request.getAttribute("schDate")!=null?(String)request.getAttribute("schDate"):Util.getToDay().substring(0,6);
	
	DataSet rs = null;
	
	ValuateUtil util = new ValuateUtil();
	
	request.setAttribute("config",config);
	util.setViewActual(request,response);
	
	DataSet ds = (DataSet)request.getAttribute("ds");
	
	String mname="";
	String bname="";
	String planned="";
	String actual="";
	String estimate="";
	String updateId="";
	String estigrade="";
	
	String fileNm = "";
	String filePath = "";
	String file = "";
	String fileIconStr = "";
	
	String fileNmPlan = "";
	String filePathPlan = "";
	String fileIconStrPlan = "";
	
	int aConf = 0;
	int pConf = 0;
	if (ds!=null) while(ds.next()){
		mname= ds.getString("NAME");
		bname=ds.getString("BNAME");
		planned = ds.isEmpty("PLANNED")?"":ds.getString("PLANNED");
		actual = ds.isEmpty("DETAIL")?"":ds.getString("DETAIL");
		//updateId = ds.isEmpty("UPDATEID")?"":ds.getString("UPDATEID");
		estimate= ds.isEmpty("ESTIMATE")?"":ds.getString("ESTIMATE")==null?"":ds.getString("ESTIMATE");
		estigrade= ds.isEmpty("ESTIGRADE")?"":ds.getString("ESTIGRADE")==null?"":ds.getString("ESTIGRADE");
		
		pConf = ds.isEmpty("pconfirm")?0:ds.getInt("pconfirm");
		aConf = ds.isEmpty("aconfirm")?0:ds.getInt("aconfirm");
		
		filePath = ds.isEmpty("FILEPATH")?"":ds.getString("FILEPATH");
		fileNm = ds.isEmpty("FILENAME")?"":ds.getString("FILENAME");

		filePathPlan = ds.isEmpty("FILEPATH_PLAN")?"":ds.getString("FILEPATH_PLAN");
		fileNmPlan = ds.isEmpty("FILENAME_PLAN")?"":ds.getString("FILENAME_PLAN");
		
		System.out.println("filePath   ===>   "+filePath);
		System.out.println("fileNm     ===>   "+fileNm);
		file = ds.isEmpty("FILEPATH")?"&nbsp;":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILEPATH")+"');\"> </a>" + ds.getString("FILENAME") ;
	}
	
	if(!(filePath==null?"":filePath).equals("")){
		fileIconStr = "<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+fileNm+"','"+filePath+"');\"> </a>";
	}	

	if(!(filePathPlan==null?"":filePathPlan).equals("")){
		fileIconStrPlan = "<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+fileNmPlan+"','"+filePathPlan+"');\"> </a>";
	}
	
	String userId = (String)session.getAttribute("userId");
	if (userId == null){ %>
		<script>
			alert("�ٽ� �����Ͽ� �ֽʽÿ�");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else { 
		int groupId = Integer.parseInt(Common.numfilter((String)session.getAttribute("groupId")));
	
		String contentId = (String)request.getParameter("contentId");

	
%>
<script>

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��Է� ��ǥ ���� ����</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	bgcolor="#ffffff" scroll="no">
<form name="detailForm" method="post" ENCTYPE="multipart/form-data">
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="8" align="absmiddle"> ��跮 ��ȹ �� ����</strong></td>
	</tr>
</table>
	
<table width="100%" border="0" cellpadding="5" cellspacing="1"
	bgcolor="#9DB5D7">
	<tr bgcolor="#FFFFFF">
		<td width="19%" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>������</strong></font></td>
		<td width="81%"><strong><font color="#3366CC"><%= bname %></font></strong></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="19%" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>������ǥ</strong></font></td>
		<td width="81%"><strong><font color="#3366CC"><%= mname %></font></strong></td>
	</tr>
</table>
<br>

<!---------//����  �׸����  //-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1" height="490"
	bgcolor="#CCCCCC">
	<tr align="center" bgcolor="#EEEEEE" >
		<td width="19%" ><font color="#333333"><strong>�����ȹ</strong></font>
			<%=fileIconStrPlan %>
		</td>
		<td width="81%" bgcolor="#FFFFFF" valign="top"><textArea name="planned" style="width:450px;height:150px" ><%=planned %></textArea></td>
	</tr>
	<tr align="center" bgcolor="#EEEEEE" height="40">
		<td width="19%"><font color="#333333"><strong>�������</strong></font>
			<%=fileIconStr %>
		</td>
		<td width="81%" bgcolor="#FFFFFF"><textArea name="actual" style="width:450px;height:150px" ><%=actual %> </textArea></td>
	</tr>
<!--	<tr align="center" bgcolor="#EEEEEE" height="23">-->
<!--		<td width="19%"><font color="#333333"><strong>��ü�� ����</strong></font></td>-->
<!--		<td width="81%" bgcolor="#FFFFFF"><inputtype="text" name="estigrade" readonly><%=estigrade %></td>-->
<!--	</tr>-->
	<tr align="center" bgcolor="#EEEEEE" height="40">
		<td width="19%"><font color="#333333"><strong>���κм��ǰ�</strong></font></td>
		<td width="81%" bgcolor="#FFFFFF"><textArea name="estimate" style="width:450px;height:150px" ><%=estimate %> </textArea></td>
	</tr>		

	<tr bgcolor="#FFFFFF">
		<td align="right" colspan="2"><a href="javascript:self.close();"><img src="<%=imgUri%>/jsp/web/images/btn_close.gif" alt="�ݱ�" width="50" height="20" border="0"></a></td>
	</tr>
</table>
<!---------//����  �׸���� ������� ���  �� //--------> <!----/�����ư/--->
</form>
<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
	<input type="hidden" name="filePath">
</form>

<SCRIPT>
<!--

	function download(filename,filepath){
		downForm.fileName.value=filename;
		downForm.filePath.value=filepath;
		downForm.submit();
	}
	
	
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	//mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
<% }%>
