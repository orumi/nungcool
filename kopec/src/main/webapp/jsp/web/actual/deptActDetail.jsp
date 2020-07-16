<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.cool.PeriodUtil,
				 com.nc.util.*" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	String userId = (String)session.getAttribute("userId");
	if (userId == null){ %>
		<script>
			alert("�ٽ� �����Ͽ� �ֽʽÿ�");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else {

	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(1);

	DataSet rs = null;

	ActualUtil util = new ActualUtil();
	request.setAttribute("config",config);
	util.setActual(request,response);

	String schDate = request.getAttribute("schDate")!=null?(String)request.getAttribute("schDate"):Util.getToDay().substring(0,6);

	// ���������˻� ���� ===============================================================
	PeriodUtil periodutil = new PeriodUtil();
	String periodvalidate = null;
	String div_cd  = "B02";
	String message = "����  ��ϱⰣ�� �ƴմϴ�.";
	String year    = "";//request.getParameter("year");

	year           = schDate.substring(0,4);
	periodvalidate = periodutil.validatePeriod(div_cd, year);
	periodvalidate = (periodvalidate == null || "".equals(periodvalidate)) ? "N" : periodvalidate;

	// ������ üũ
	String message2   = "�����Ǿ����ϴ�. ��ȸ�� �����մϴ�.";
	String month      = schDate.substring(4,6);
	String mmclose_yn = periodutil.getCheckCloseMM(year, div_cd, month);
	if(mmclose_yn.equalsIgnoreCase("N")) message2 = "";
	// ���������˻� �� ==================================================================

	DataSet dsMea   = (DataSet)request.getAttribute("dsMea");
	DataSet dsItem  = (DataSet)request.getAttribute("dsItem");
	DataSet dsAut   = (DataSet)request.getAttribute("dsAut");
	String msg      = (String)request.getAttribute("msg");

	String mid     = (String)request.getAttribute("mid");
	Boolean aut    = (Boolean)request.getAttribute("aut");
	boolean bAut   = (aut!=null)?aut.booleanValue():false;

	String bname ="";
	String mname="";
	String equation="";
	String planned="";
	String plannedbase="";
	String base="";
	String baselimit="";
	String limit="";
	String actual="";
	String score="";
	String unit="";
	String updater="";
	String comments="";
	String strFile="";
	String trend="";
	String grade="";
	String grade_score="";
	String weight="";

	String plannedbaseplus = "";
	String baseplus        = "";
	String baselimitplus   = "";
	String limitplus       = "";

	/*
	String upper= Integer.toString(ServerStatic.UPPER);
	String high= Integer.toString(ServerStatic.HIGH);
	String low= Integer.toString(ServerStatic.LOW);
	String lower= Integer.toString(ServerStatic.LOWER);
	String lowst= Integer.toString(ServerStatic.LOWST);
	*/

	String upper     = "100";
	String highplus  = "87.5";
	String high      = "75";
	String lowplus   = "62.5";
	String low       = "50";
	String lowerplus = "37.5";
	String lower     = "25";
	String lowstplus = "12.5";
	String lowst     = "0";

	if (dsMea!=null) while(dsMea.next()){
		bname = dsMea.getString("BNAME");
		mname = dsMea.getString("NAME");
		equation = dsMea.isEmpty("EQUATION")?"":dsMea.getString("EQUATION");
		unit = dsMea.isEmpty("UNIT")?"":dsMea.getString("UNIT");
		planned = dsMea.isEmpty("PLANNED")?"":dsMea.getString("PLANNED");
		plannedbase = dsMea.isEmpty("PLANNEDBASE")?"":dsMea.getString("PLANNEDBASE");
		base = dsMea.isEmpty("BASE")?"":dsMea.getString("BASE");
		baselimit = dsMea.isEmpty("BASELIMIT")?"":dsMea.getString("BASELIMIT");
		limit = dsMea.isEmpty("LIMIT")?"":dsMea.getString("LIMIT");
		actual = dsMea.isEmpty("ACTUAL")?"":dsMea.getString("ACTUAL");
		score = dsMea.isEmpty("SCORE")?"":dsMea.getString("SCORE");
		grade = dsMea.isEmpty("GRADE")?"":dsMea.getString("GRADE");
		grade_score = dsMea.isEmpty("GRADE_SCORE")?"":dsMea.getString("GRADE_SCORE");
		comments = dsMea.isEmpty("COMMENTS")?"":dsMea.getString("COMMENTS");
		updater = dsMea.isEmpty("UNAME")?"":dsMea.getString("UNAME");
		trend = dsMea.getString("TREND");
		weight = dsMea.getString("WEIGHT");

		plannedbaseplus = dsMea.isEmpty("PLANNEDBASEPLUS")?"":dsMea.getString("PLANNEDBASEPLUS");
		baseplus        = dsMea.isEmpty("BASEPLUS")?"":dsMea.getString("BASEPLUS");
		baselimitplus   = dsMea.isEmpty("BASELIMITPLUS")?"":dsMea.getString("BASELIMITPLUS");
		limitplus       = dsMea.isEmpty("LIMITPLUS")?"":dsMea.getString("LIMITPLUS");

		/*
		upper = dsMea.isEmpty("S")?"":dsMea.getString("S");
		high = dsMea.isEmpty("A")?"":dsMea.getString("A");
		low = dsMea.isEmpty("B")?"":dsMea.getString("B");
		lower = dsMea.isEmpty("C")?"":dsMea.getString("C");
		lowst = dsMea.isEmpty("D")?"":dsMea.getString("D");
		*/

		strFile = dsMea.isEmpty("FILENAME")?"":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+dsMea.getString("FILENAME")+"','"+dsMea.getString("FILEPATH")+"');\"> </a>"+dsMea.getString("FILENAME")+((bAut)?"&nbsp;&nbsp;&nbsp;&nbsp; <img src='"+imgUri+"/jsp/web/images/btn_file_delete.gif' width='70' height='18' onClick=\"actionDeleteFile();\" style=\"cursor:hand\"> <br>":"");

		if(planned.equals("") || plannedbase.equals("") || base.equals("") || baselimit.equals("") || limit.equals("")){
			out.println("<script language=javascript>alert('�ش� ��ǥ�� ��ǥ���� �����ϴ�. ��ǥ������ �Է��ϼ���!'); parent.actionPerformed();parent.funcDivVisible();</script>");
		}
	}
	int k = 0;
	if (dsAut!=null) while(dsAut.next()){
		if (k!=0) updater += ",";
		else updater += " / ";
		updater += dsAut.getString("UNAME");
		k++;
	}

	String contentId = (String)request.getParameter("contentId");
%>
<script>
	function listRefresh(){
		parent.refreshList();
	}

	function openList(){
		parent.funcDivVisible();
	}

	function actionDeleteFile(){
		if (confirm("������ ������ �����Ͻðڽ��ϱ�? ")){
			parent.refresh = true;
			detailForm.tag.value = "FD";
			detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
			detailForm.submit();
		}
	}

	<% if (msg!=null) { %>
		alert('<%=msg%>');
	<%  } %>
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	bgcolor="#ffffff" onLoad="javascript:listRefresh();">
<form name="detailForm" method="post" ENCTYPE="multipart/form-data">
	<input type=hidden name=tag>
	<input type=hidden name=contentId value="<%=mid%>">
	<input type=hidden name=schDate >

<table width="100%"><tr><td width="50%" valign="top">


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="8" align="absmiddle"> ������ǥ : <font color="#3366CC"><strong><%= bname %></strong></td>
	</tr>
</table>

<!---------//����  ����(�׸�)�����Է� //-------->
<table width="98%" border="0" cellpadding="5" cellspacing="1"
	bgcolor="#9DB5D7">
	<tr bgcolor="#FFFFFF">
		<td width="20%" align="center" bgcolor="#f6f6f6"><font color="#333333"><strong>��ǥ</strong></font></td>
		<td width="50%"><strong><font color="#3366CC"><%= mname %></font></strong></td>
		<td width="15%" align="center" bgcolor="#f6f6f6"><font color="#333333"><strong>����</strong></font></td>
		<td width="20%"><strong><font color="#3366CC"><%= unit %></font></strong></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="20%" align="center" bgcolor="#f6f6f6"><font color="#333333"><strong>����</strong></font></td>
		<td width="50%"><strong><font color="#333333"><%=equation%></font></strong></td>
		<td width="15%" align="center" bgcolor="#f6f6f6"><font color="#333333"><strong>����ġ</strong></font></td>
		<td width="20%"><strong><font color="#3366CC"><%= weight %></font></strong></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="15%" align="center" bgcolor="#f6f6f6"><font color="#333333"><strong>���������<br>(��/��)</strong></font></td>
		<td ><%= updater %></td>
		<td width="15%" align="center" bgcolor="#f6f6f6"><font color="#333333"><strong>���⼺</strong></font></td>
		<td width="20%"><strong><font color="#3366CC"><%= trend %></font></strong></td>
	</tr>
</table>
<table><tr><td></td></tr></table>
<table width="98%" border="0" cellspacing="1" cellpadding="5" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#375f9c" height="32">
		<td width="7%"><font color="#ffffff"><strong>����</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>S</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>A+</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>A</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>B+</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>B</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>C+</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>C</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>D+</strong></font></td>
		<td width="5%"><font color="#ffffff"><strong>D</strong></font></td>
	</tr>
	<tr align="center" bgcolor="#FFFFFF" height="32">
		<td bgcolor="#375f9c"><font color="#ffffff"><strong>��ǥ����</strong></font></td>
		<td><%=planned %></td>
		<td><%=plannedbaseplus %></td>
		<td><%=plannedbase %></td>
		<td><%=baseplus %></td>
		<td><%=base %></td>
		<td><%=baselimitplus %></td>
		<td><%=baselimit %></td>
		<td><%=limitplus %></td>
		<td><%=limit %></td>
	</tr>
	<tr align="center" bgcolor="#FFFFFF" height="32">
		<td bgcolor="#375f9c"><font color="#ffffff"><strong>����</strong></font></td>
		<td><%=upper %></td>
		<td><%=highplus %></td>
		<td><%=high %></td>
		<td><%=lowplus %></td>
		<td><%=low %></td>
		<td><%=lowerplus %></td>
		<td><%=lower %></td>
		<td><%=lowstplus %></td>
		<td><%=lowst %></td>
	</tr>
</table>

<table><tr><td></td></tr></table>
	          <!-- �ٰ� �ڷ�  -->
	          	<table width="98%" border="0" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC">
			      <tr bgcolor="#EEEEEE">
			        <td align="center" bgcolor="#375f9c" height=32><font color="#ffffff"><strong>���κм��ǰ�</strong></font></td>
			      </tr>
			      <tr>
			        <td valign="top" bgcolor="#ffffff"><textarea cols="75" rows="9" name="comments"><%=comments %></textarea></td>
			      </tr>
			    </table>
<!---------//����  ����(�׸�)�����Է�  ��//-------->


	          <br>
	          <!-- ÷������  -->
	          	<table width="98%" border="0" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC">
			      <tr bgcolor="#EEEEEE">
			        <td width="100" align="center" bgcolor="#375f9c"><font color="#ffffff"><strong>÷�ι���</strong></font></td>
			        <td valign="top" bgcolor="#ffffff">
			        <%=strFile%>
			        <input name="attach_file" type="file" class="input_box" style="width:363;x;">
			        </td>
			      </tr>
			    </table>
<br>


</td><td valign="top">

<!---------//����  �׸����  //-------->

<table width="98%" border="0" cellspacing="0" cellpadding="3">
	<tr>
		<td height="25"><strong><img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="9" align="absmiddle"> �׸����</strong></td>
		<td align="right">
			<img src="<%=imgUri%>/jsp/web/images/btn_go_list.gif" alt="���" width="65" height="20" border="0" onClick="javascript:openList();" style="cursor:hand">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% //if ((userId==updaterId)||(userGroup<4)){

	if (bAut) {
%>
		<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="����" width="50"
			height="20" border="0" onClick="javascript:actionPerformed('U');" style="cursor:hand">
			<img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="����" width="50"
			height="20" border="0" onClick="javascript:actionPerformed('D');" style="cursor:hand">
<% } %>
		</td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
	<tr align="center" bgcolor="#EEEEEE" height="32">
<!--		<td width="08%" rowspan="2"><font color="#333333"><strong>�ڵ�</strong></font></td>-->
		<td width="08%" ><font color="#333333"><strong>�ڵ�</strong></font></td>
<!--		<td width="55%" colspan="2"><font color="#333333"><strong>�׸�</strong></font></td>-->
		<td width="55%" ><font color="#333333"><strong>�׸�</strong></font></td>
<!--		<td width="12%" rowspan="2"><font color="#333333"><strong>�������</strong></font></td>-->
<!--		<td width="12%" ><font color="#333333"><strong>�������</strong></font></td>-->
<!--		<td width="25%" rowspan="2"><font color="#333333"><strong>�ֱ⺰<br>�׸����(����)</strong></font></td>-->
		<td width="25%"><font color="#333333"><strong>�ֱ⺰<br>�׸����(����)</strong></font></td>
	</tr>
<!--	<tr align="center" bgcolor="#EEEEEE" height="23">-->
<!--		<td width="15%"><font color="#333333"><strong>������</strong></font></td>-->
<!--		<td width="15%"><font color="#333333"><strong>��հ�</strong></font></td>	-->
<!--	</tr>-->
	<input type=hidden name=itemCode value="<%=contentId%>">
	<%
		if(dsItem!=null){
			String itemCD = "";
			while(dsItem.next()){
				itemCD += dsItem.getString("CODE")+"|";
		%>
			<tr align="center" bgcolor="#FFFFFF" height="32">
<!--				<td rowspan="2"><%=dsItem.getString("CODE") %></td>-->
				<td ><%=dsItem.getString("CODE") %></td>
<!--				<td align="left" colspan="2"><%=dsItem.getString("ITEMNAME") %></td>-->
				<td align="left" ><%=dsItem.getString("ITEMNAME") %></td>
<!--				<td rowspan="2"><%=dsItem.getString("ITEMTYPE") %></td>-->
<!--				<td><%=dsItem.getString("ITEMTYPE") %></td>-->

<!--				<td rowspan="2"><input type=text name="itemAcutal<%=dsItem.getString("CODE")%>"  style="text-align:right" value=<%=dsItem.isEmpty("ACTUAL")?"":dsItem.getString("ACTUAL") %>></td>-->
				<td><input type=text name="itemAcutal<%=dsItem.getString("CODE")%>"  style="text-align:right" value=<%=dsItem.isEmpty("ACTUAL")?"":dsItem.getString("ACTUAL") %>></td>
			</tr>
<!--			<tr align="center" bgcolor="#FFFFFF" height="23">-->
<!--				<td ><%=dsItem.isEmpty("ACCUM")?"":dsItem.getString("ACCUM") %></td>-->
<!--				<td ><%=dsItem.isEmpty("AVERAGE")?"":dsItem.getString("AVERAGE") %></td>			-->
<!--			</tr>-->
			<input type="hidden" name="itemType<%=dsItem.getString("CODE")%>" value="<%=dsItem.getString("ITEMTYPE") %>" >
		<%
			}  %>

			<input type="hidden" name="itemCD" value="<%=itemCD %>" >

	<%
		}else{
	%>
	<tr bgcolor="#FFFFFF" height="23">
		<td colspan="4" align="center">�׸��� �������� �ʽ��ϴ�.</td>
	</tr>
	<%
		}
	%>
</table>
 <!---------//����  �׸���� ������� ���  //-------->
<br>
<table width="98%" border="0" cellspacing="1" cellpadding="2">
	<tr height="34">
		<td width="7%" align="center" bgcolor="#FFCC99"><strong><font color="#993300">����</font></strong></td>
		<td width="18%" bgcolor="#FFFFCC"><strong><%="".equals(actual)?"":Double.valueOf(actual)%></strong></td>
		<td width="7%" align="center" bgcolor="#E1F0FF"><strong><font color="#006699">���</font></strong></td>
		<td width="18%" bgcolor="#F3F3F3"><strong><font color="#333333"><%="".equals(grade)?"":grade %></font></strong></td>
		<td width="7%" align="center" bgcolor="#FFCC99"><strong><font color="#993300">����</font></strong></td>
		<td width="18%" bgcolor="#FFFFCC"><strong><%="".equals(score)?"":score%></strong></td>
		<td width="7%" align="center" bgcolor="#E1F0FF"><strong><font color="#006699">����</font></strong></td>
		<td width="18%" bgcolor="#F3F3F3"><strong><font color="#333333"><%="".equals(grade_score)?"":grade_score %></font></strong></td>
	</tr>
</table>


</td></tr>
</table>
</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/actual/download.jsp">
	<input type="hidden" name="fileName">
	<input type="hidden" name="filePath">
</form>

<script language=javascript>
	function actionPerformed(tag){

		// �����Ǿ���
		if ("<%=mmclose_yn%>" == "Y") {
				alert("<%=message2%>");
				return;
		}

		if ("<%=periodvalidate%>" == "N") {
				alert("���� ��ϱⰣ�� �ƴմϴ�.");
				return;
		}

		if ("D"==tag){
			if (confirm("���������� �����Ͻðڽ��ϱ�?")){

			} else {
				return;
			}
		}
		parent.refresh = true;
		detailForm.tag.value = tag;
		detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
		detailForm.submit();

	}

	function download(filename, filepath){
		downForm.fileName.value=filename;
		downForm.filePath.value=filepath;
		downForm.submit();
	}


//-->
</script>
</body>
</html>
<% }%>
