<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.cool.PeriodUtil,
				 com.nc.util.*" %>
<%
	DataSet rs = null;

	ValuateUtil util = new ValuateUtil();


	request.setAttribute("config",config);
	util.setActual(request,response);

	DataSet dsMea = (DataSet)request.getAttribute("dsMea");
	String mid = (String)request.getAttribute("mid");

	String schDate = request.getAttribute("schDate")!=null?(String)request.getAttribute("schDate"):Util.getToDay().substring(0,6);
	System.out.println("schdate :" + request.getAttribute("schDate"));
	// 마감일정검사 시작 ===============================================================
	PeriodUtil periodutil = new PeriodUtil();
	String periodvalidate = null;
	String div_cd  = "B02";
	String message = "실적  등록기간이 아닙니다.";
	String year    = "";//request.getParameter("year");

	year = schDate.substring(0,4);
	periodvalidate = periodutil.validatePeriod(div_cd, year);
	periodvalidate = (periodvalidate == null || "".equals(periodvalidate)) ? "N" : periodvalidate;

	// 월마감 체크
	String message2   = "마감되었습니다. 조회만 가능합니다.";
	String month      = schDate.substring(4,6);
	String mmclose_yn = periodutil.getCheckCloseMM(year, div_cd, month);
	if(mmclose_yn.equalsIgnoreCase("N")) message2 = "";
	// 마감일정검사 끝 =================================================================

	String mname="";
	String planned="";
	String actual="";
	String estimate="";
	String updateId="";
	String estigrade="";

	int aConf = 0;
	int pConf = 0;
	if (dsMea!=null) while(dsMea.next()){
		mname= dsMea.getString("NAME");
		planned = dsMea.isEmpty("PLANNED")?"":dsMea.getString("PLANNED")==null?"":dsMea.getString("PLANNED");
		actual = dsMea.isEmpty("DETAIL")?"":dsMea.getString("DETAIL")==null?"":dsMea.getString("DETAIL");
		updateId = dsMea.isEmpty("UPDATEID")?"":dsMea.getString("UPDATEID");
		estimate= dsMea.isEmpty("ESTIMATE")?"":dsMea.getString("ESTIMATE")==null?"":dsMea.getString("ESTIMATE");
		estigrade= dsMea.isEmpty("ESTIGRADE")?"":dsMea.getString("ESTIGRADE")==null?"":dsMea.getString("ESTIGRADE");

		pConf = dsMea.isEmpty("pconfirm")?0:dsMea.getInt("pconfirm");
		aConf = dsMea.isEmpty("aconfirm")?0:dsMea.getInt("aconfirm");
	}

%>
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
		int groupId = Integer.parseInt(Common.numfilter((String)session.getAttribute("groupId")));

		String contentId = (String)request.getParameter("contentId");
	%>
<script>
	function listRefresh(){
		parent.refreshList();
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
<table width="98%" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td height="25"><strong> <img src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="8" align="absmiddle"> 실행계획 및 실적</strong></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" style="display:none;">
	<tr bgcolor="#FFFFFF">
		<td width="13%" align="center" bgcolor="#375f9c" height=34><font color="#ffffff"><strong>성과지표 명</strong></font></td>
		<td width="48%"><strong><font color="#3366CC"><%= mname %></font></strong></td>
		<td width="13%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">자체평가 등급</font></strong></td-->
		<td width="26%" align="center">
			<table width="99%" border="0" cellpadding="0" cellspacing="1">
				<tr>
					<td width="20%" align="center" ><b>S</b><input type=radio name=rdoEst value="S" <%=estigrade.equals("S")?"checked":"" %> align="absmiddle"></td>
		            <td width="20%" align="center" ><b>A</b><input type=radio name=rdoEst value="A" <%=estigrade.equals("A")?"checked":"" %> align="absmiddle"></td>
		            <td width="20%" align="center" ><b>B</b><input type=radio name=rdoEst value="B" <%=estigrade.equals("B")?"checked":"" %> align="absmiddle"></td>
		            <td width="20%" align="center" ><b>C</b><input type=radio name=rdoEst value="C" <%=estigrade.equals("C")?"checked":"" %> align="absmiddle"></td>
		            <td width="20%" align="center" ><b>D</b><input type=radio name=rdoEst value="D" <%=estigrade.equals("D")?"checked":"" %> align="absmiddle"></td>
		        </tr>
		    </table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr bgcolor="#FFFFFF">
		<td width="13%" align="center" bgcolor="#375f9c" height=34><font color="#ffffff"><strong>성과지표 명</strong></font></td>
		<td width="87%"><strong><font color="#3366CC"><%= mname %></font></strong></td>
	</tr>
</table>
<!---------//우측  항목실적  //-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1"	bgcolor="#CCCCCC">
	<tr align="center" bgcolor="#EEEEEE" height="23">
		<td width="33%"><font color="#333333"><strong>실행계획</strong></font></td>
		<td width="34%"><font color="#333333"><strong>실행실적</strong></font></td>
		<td width="33%"><font color="#333333"><strong>내부분석의견</strong></font></td>
	</tr>
	<input type=hidden name=itemCode value="<%=contentId%>">

	<tr align="center" bgcolor="#FFFFFF" >
		<td rowspan="2" width="33%" valign="top"><textArea name="planned" style="width:98%;height:110px"><%=planned %></textArea></td>
		<td width="34%"><textArea name="actual" style="width:98%;height:80px"><%=actual %></textArea></td>
		<td rowspan="2" width="33%"><textArea name="estimate" style="width:98%;height:110px"><%=estimate %></textArea></td>
	</tr>
	<tr align="center" bgcolor="#FFFFFF" >
		<td>
		<input name="attach_file" type="file" class="input_box" style="width:98%;">
		</td>
	</tr>

</table>
<!---------//우측  항목실적 점수계산 결과  끝 //--------> <!----/저장버튼/--->
<% if (groupId<2){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td width="33%" align="right">
<!--			<img src="<%=imgUri%>/jsp/web/images/btn_reset_planned.gif" alt="계획초기화" width="84" height="20" border="0" onClick="javascript:actionPerformed('RP');" style="cursor:hand">-->
<!--			<img src="<%=imgUri%>/jsp/web/images/btn_save_planned.gif" alt="계획저장" width="84" height="20" border="0" onClick="javascript:actionPerformed('P');" style="cursor:hand">-->
		</td>
		<td width="34%" align="right">
			<img src="<%=imgUri%>/jsp/web/images/btn_reset_actual.gif" alt="실적초기화" width="84" height="20" border="0" onClick="javascript:actionPerformed('RA');" style="cursor:hand">
<!--		    <img src="<%=imgUri%>/jsp/web/images/btn_save_temp.gif" alt="임시저장" width="84" height="20" border="0" onClick="javascript:actionPerformed('T');" style="cursor:hand">-->
			<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('U');" style="cursor:hand">
			<!--<img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" onClick="javascript:actionPerformed('D');" style="cursor:hand"> -->
		</td>
		<td width="34%" align="right">
			<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('E');" style="cursor:hand">
		</td>
	</tr>
</table>
<% } else { %>
<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td width="33%" align="right">
			<% if (pConf!=1){ %>
<!--			<img src="<%=imgUri%>/jsp/web/images/btn_save_planned.gif" alt="계획저장" width="84" height="20" border="0" onClick="javascript:actionPerformed('P');" style="cursor:hand">-->
		    <% } %>
		</td>
		<% if (aConf!=1){ %>
		<td width="33%" align="right">
<!--		    <img src="<%=imgUri%>/jsp/web/images/btn_save_temp.gif" alt="임시저장" width="84" height="20" border="0" onClick="javascript:actionPerformed('T');" style="cursor:hand">-->
			<img src="<%=imgUri%>/jsp/web/images/btn_reset_actual.gif" alt="실적초기화" width="84" height="20" border="0" onClick="javascript:actionPerformed('RA');" style="cursor:hand">
			<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('U');" style="cursor:hand">
			<!-- img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" onClick="javascript:actionPerformed('D');" style="cursor:hand"> -->
		</td>
		<td width="33%" align="right">
			<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('E');" style="cursor:hand">
		</td>
		<% }else{ %>
		<td width="67%" align="right">
		</td>
		<% } %>
	</tr>
</table>

<% } %>
</form>
<script language=javascript>
	function actionPerformed(tag){

		// 마감되었슴
		if ("<%=mmclose_yn%>" == "Y") {
				alert("<%=message2%>");
				return;
		}
		if ("<%=periodvalidate%>" == "N") {
			alert("실적 등록기간이 아닙니다.");
			return;
		}

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


//-->
</script>
</body>
</html>
<% }%>
