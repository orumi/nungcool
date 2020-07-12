<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	String userId = (String)session.getAttribute("userId");
	if (userId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<%} else { 
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(1);

	String schDate = request.getAttribute("schDate")!=null?(String)request.getAttribute("schDate"):Util.getToDay().substring(0,6);
	
	DataSet rs = null;
	
	ActualUtil util = new ActualUtil();
	
	request.setAttribute("config",config);
	util.setActual(request,response);
	
	DataSet dsMea = (DataSet)request.getAttribute("dsMea");
	DataSet dsItem = (DataSet)request.getAttribute("dsItem");
	DataSet dsAut = (DataSet)request.getAttribute("dsAut");
	
	String mid = (String)request.getAttribute("mid");
	Boolean aut = (Boolean)request.getAttribute("aut");
	boolean bAut = (aut!=null)?aut.booleanValue():false;
	
	
	String mname="";
	String equation="";
	String planned="";
	String base="";
	String limit="";
	String actual="";
	String score="";
	String unit="";
	String updater="";
	String comments="";
	String strFile="";
	
	String upper="";
	String high="";
	String low="";
	String lower="";	
	
	if (dsMea!=null) while(dsMea.next()){
		mname= dsMea.getString("NAME");
		equation=dsMea.isEmpty("EQUATION")?"":dsMea.getString("EQUATION");
		unit=dsMea.isEmpty("UNIT")?"":dsMea.getString("UNIT");
		planned = dsMea.isEmpty("PLANNED")?"":dsMea.getString("PLANNED");
		base = dsMea.isEmpty("BASE")?"":dsMea.getString("BASE");
		limit = dsMea.isEmpty("LIMIT")?"":dsMea.getString("LIMIT");
		actual = dsMea.isEmpty("ACTUAL")?"":dsMea.getString("ACTUAL");
		score = dsMea.isEmpty("SCORE")?"":dsMea.getString("SCORE");
		comments = dsMea.isEmpty("COMMENTS")?"":dsMea.getString("COMMENTS");
		updater = dsMea.isEmpty("UNAME")?"":dsMea.getString("UNAME");
		
		upper = dsMea.isEmpty("UPPER")?"":dsMea.getString("UPPER");
		high = dsMea.isEmpty("HIGH")?"":dsMea.getString("HIGH");
		low = dsMea.isEmpty("LOW")?"":dsMea.getString("LOW");
		lower = dsMea.isEmpty("LOWER")?"":dsMea.getString("LOWER");		
		
		strFile = dsMea.isEmpty("FILENAME")?"":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+dsMea.getString("FILENAME")+"');\"> </a>"+dsMea.getString("FILENAME")+((bAut)?"&nbsp;&nbsp;&nbsp;&nbsp; <img src='"+imgUri+"/jsp/web/images/btn_file_delete.gif' width='70' height='18' onClick=\"actionDeleteFile();\" style=\"cursor:hand\"> <br>":"");
	}
	updater = updater+" / ";
	int k = 0;
	if (dsAut!=null) while(dsAut.next()){
		if (k!=0) updater += ",";		
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
		if (confirm("선택한 문서를 삭제하시겠습니까? ")){
			parent.refresh = true;
			detailForm.tag.value = "FD";
			detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
			detailForm.submit();
		}
	}
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
			height="8" align="absmiddle"> 성과지표</strong></td>
	</tr>
</table>
	
<!---------//우측  변수(항목)실적입력 //-------->
<table width="98%" border="0" cellpadding="5" cellspacing="1"
	bgcolor="#9DB5D7">
	<tr bgcolor="#FFFFFF">
		<td width="20%" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>지표</strong></font></td>
		<td width="50%"><strong><font color="#3366CC"><%= mname %></font></strong></td>
		<td width="15%" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>단위</strong></font></td>
		<td width="20%"><strong><font color="#3366CC"><%= unit %></font></strong></td>		
	</tr>
	<tr bgcolor="#FFFFFF">
		<td align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>계산식</strong></font></td>
		<td colspan="3"><strong><font color="#333333"><%=equation%></font></strong></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="15%" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>실적담당자(정/부)</strong></font></td>
		<td colspan="3"><%= updater %></td>
	</tr>	
</table>
<table><tr><td></td></tr></table>
<table width="98%" border="0" cellspacing="1" cellpadding="5" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#D2E1F0" height="23">
		<td width="20%"><font color="#003399"><strong>구분</strong></font></td>
		<td width="20%"><font color="#003399"><strong>목표값</strong></font></td>
		<td width="20%"><font color="#003399"><strong>기준선</strong></font></td>
		<td width="20%"><font color="#003399"><strong>하한선</strong></font></td>
		<td width="20%"><font color="#003399"><strong>최저점수</strong></font></td>
	</tr>
	<tr align="center" bgcolor="#FFFFFF" height="23">
		<td bgcolor="#D2E1F0"><font color="#003399"><strong>실적</strong></font></td>
		<td><%=planned %></td>
		<td><%=base %></td>
		<td><%=limit %></td>
		<td>&nbsp;</td>
	</tr>	
	<tr align="center" bgcolor="#FFFFFF" height="23">
		<td bgcolor="#D2E1F0"><font color="#003399"><strong>점수</strong></font></td>
		<td><%=upper %></td>
		<td><%=high %></td>
		<td><%=low %></td>
		<td><%=lower %></td>
	</tr>			
</table>

<table><tr><td></td></tr></table>
	          <!-- 근거 자료  -->
	          	<table width="98%" border="0" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC">
			      <tr bgcolor="#EEEEEE">
			        <td align="center" bgcolor="#DCEDF6"><font color="#006699"><strong>부진사유 원인 분석/대책</strong></font></td>
			      </tr>
			      <tr>
			        <td valign="top" bgcolor="#ffffff"><textarea cols="64" rows="9" name="comments"><%=comments %></textarea></td>
			      </tr>
			    </table>
<!---------//우측  변수(항목)실적입력  끝//-------->


	          <br>
	          <!-- 첨부파일  -->
	          	<table width="98%" border="0" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC">
			      <tr bgcolor="#EEEEEE">
			        <td width="100" align="center" bgcolor="#DCEDF6"><font color="#006699"><strong>첨부문서</strong></font></td>
			        <td valign="top" bgcolor="#ffffff">
			        <%=strFile%>
			        <input name="attach_file" type="file" class="input_box" style="width:300;x;">
			        </td>
			      </tr>
			    </table>
<br>


</td><td valign="top">

<!---------//우측  항목실적  //-------->

<table width="98%" border="0" cellspacing="0" cellpadding="3">
	<tr>
		<td height="25"><strong><img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="9" align="absmiddle"> 항목실적</strong></td>	
		<td align="right">
			<img src="<%=imgUri%>/jsp/web/images/btn_go_list.gif" alt="목록" width="65" height="20" border="0" onClick="javascript:openList();" style="cursor:hand">	
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
<% //if ((userId==updaterId)||(userGroup<4)){ 
	
	if (bAut) {
%>			
		<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50"
			height="20" border="0" onClick="javascript:actionPerformed('U');" style="cursor:hand">
			<img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50"
			height="20" border="0" onClick="javascript:actionPerformed('D');" style="cursor:hand">	
<% } %>	
		</td>				
	</tr>
</table>

<table width="98%" border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
	<tr align="center" bgcolor="#EEEEEE" height="20">
		<td width="08%" rowspan="2"><font color="#333333"><strong>코드</strong></font></td>
		<td width="50%" colspan="2"><font color="#333333"><strong>항목</strong></font></td>
		<td width="12%" rowspan="2"><font color="#333333"><strong>산식적용</strong></font></td>
		<td width="30%" rowspan="2"><font color="#333333"><strong>주기별 항목실적</strong></font></td>
	</tr>
	<tr align="center" bgcolor="#EEEEEE" height="23">
		<td width="15%"><font color="#333333"><strong>누적값</strong></font></td>
		<td width="15%"><font color="#333333"><strong>평균값</strong></font></td>	
	</tr>
	<input type=hidden name=itemCode value="<%=contentId%>">
	<% 
		if(dsItem!=null){
			String itemCD = "";
			while(dsItem.next()){
				itemCD += dsItem.getString("CODE")+"|";
		%>
			<tr align="center" bgcolor="#FFFFFF" height="23">
				<td rowspan="2"><%=dsItem.getString("CODE") %></td>
				<td align="left" colspan="2"><%=dsItem.getString("ITEMNAME") %></td>
				<td rowspan="2"><%=dsItem.getString("ITEMTYPE") %></td>

				<td rowspan="2"><input type=text name="itemAcutal<%=dsItem.getString("CODE")%>"  style="text-align:right" value=<%=dsItem.isEmpty("ACTUAL")?"":dsItem.getString("ACTUAL") %>></td>
			</tr>
			<tr align="center" bgcolor="#FFFFFF" height="23">
				<td ><%=dsItem.isEmpty("ACCUM")?"":dsItem.getString("ACCUM") %></td>
				<td ><%=dsItem.isEmpty("AVERAGE")?"":dsItem.getString("AVERAGE") %></td>			
			</tr>
			<input type="hidden" name="itemType<%=dsItem.getString("CODE")%>" value="<%=dsItem.getString("ITEMTYPE") %>" >	
		<%
			}  %>
			
			<input type="hidden" name="itemCD" value="<%=itemCD %>" >	
			
	<%		
		}else{	
	%>
	<tr bgcolor="#FFFFFF" height="23">
		<td colspan="4" align="center">항목이 존재하지 않습니다.</td>
	</tr>
	<%
		} 
	%>
</table>
 <!---------//우측  항목실적 점수계산 결과  //-------->
<br>
<table width="98%" border="0" cellspacing="1" cellpadding="2">
	<tr>
		<td width="19%" align="center" bgcolor="#E1F0FF">
			<strong><font color="#006699">실적</font></strong>
		</td>
		<td width="32%" bgcolor="#F3F3F3">
			<strong><font color="#333333"><%="".equals(actual)?"":nf.format(Double.valueOf(actual))%></font></strong>
		</td>
		<td width="18%" align="center" bgcolor="#FFCC99"><strong><font color="#993300">점수</font></strong></td>
		<td width="31%" bgcolor="#FFFFCC"><strong><%="".equals(score)?"":nf.format(Double.valueOf(score))  %></strong></td>
	</tr>
</table>


</td></tr>
</table>
</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/actual/download.jsp">
	<input type="hidden" name="fileName">
</form>

<script language=javascript>
	function actionPerformed(tag){
	
		if ("D"==tag){
			if (confirm("실적정보를 삭제하시겠습니까?")){
			
			} else {
				return;
			}
		}
		parent.refresh = true;
		detailForm.tag.value = tag;
		detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
		detailForm.submit();
	
	}

	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}
	
	
//-->
</script>
</body>
</html>
<% }%>
