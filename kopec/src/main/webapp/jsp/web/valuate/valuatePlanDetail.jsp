<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.cool.PeriodUtil,
				 com.nc.util.*" %>
<%


	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	String schDate = request.getParameter("schDate")!=null?request.getParameter("schDate"):Util.getToDay().substring(0,6);
		
	DataSet rs = null;
	ValuateUtil util = new ValuateUtil();

	request.setAttribute("config",config);
	util.setActual2(request,response);

	// 마감일정검사 시작 ===============================================================
	PeriodUtil periodutil = new PeriodUtil();
	String periodvalidate = null;
	String div_cd = "B01";
	String message = "계획  등록기간이 아닙니다.";
	//String year = request.getParameter("year");
	
	//year = (year == null || "".equals(year)) ? Util.getToDay().substring(0,4) : year;
	String year = (String)request.getAttribute("year");
	year = (year == null || "".equals(year)) ? Util.getToDay().substring(0,4) : year;
	
	periodvalidate = periodutil.validatePeriod(div_cd, year);
	periodvalidate = (periodvalidate == null || "".equals(periodvalidate)) ? "N" : periodvalidate;
			
	// 월마감 체크
	String message2   = "마감되었습니다. 조회만 가능합니다.";                                   
	String month      = schDate.substring(4,6);
	String mmclose_yn = periodutil.getCheckCloseMM(year, div_cd, month);  
	if(mmclose_yn.equalsIgnoreCase("N")) message2 = "";	
	// 마감일정검사 끝 =================================================================		
	
	DataSet dsMea = (DataSet)request.getAttribute("dsMea");
	String mid = (String)request.getAttribute("mid");

	String mname="";
	String planned="";	
	String planned1="";	
	String planned2="";	
	String planned3="";	
	String planned4="";	
	String updateId="";
	String effectivedate="";
	String effectivedate2="";
	String freq    = "";
	String fileNm = "";
	String filePath = "";
	String freq1    = "";
		
	String fileNm1 = "";
	String fileNm2 = "";
	String fileNm3 = "";
	String fileNm4 = "";
	
	String filePath1 = "";
	String filePath2 = "";
	String filePath3 = "";
	String filePath4 = "";
	
	String fileIconStr1 = "";
	String fileIconStr2 = "";
	String fileIconStr3 = "";
	String fileIconStr4 = "";
	
	
	int pConf = 0;

	if(dsMea != null)
	{
		while(dsMea.next())
		{
			//ID = dsMea.isEmpty("ID")?"":dsMea.getString("ID");
			mname         = dsMea.getString("NAME");
			updateId      = dsMea.isEmpty("UPDATEID")?"":dsMea.getString("UPDATEID");
			effectivedate = dsMea.isEmpty("EFFECTIVEDATE")?"":dsMea.getString("EFFECTIVEDATE");
			planned       = dsMea.isEmpty("PLANNED")?"":dsMea.getString("PLANNED");
			pConf         = dsMea.isEmpty("pconfirm")?0:dsMea.getInt("pconfirm"); 
			freq          = dsMea.isEmpty("FREQUENCY")?"":dsMea.getString("FREQUENCY");
			fileNm        = dsMea.isEmpty("FILENAME_PLAN")?"":dsMea.getString("FILENAME_PLAN");
			filePath      = dsMea.isEmpty("FILEPATH_PLAN")?"":dsMea.getString("FILEPATH_PLAN");
			//System.out.println("freq   ===>   "+freq);
			
			System.out.println("freq1   ===>   "+freq1);
			freq1 = "년";
			//freq1 = freq;
			System.out.println("freq   ===>   "+freq);
			if(!effectivedate.equals("")){
				effectivedate2 = effectivedate.substring(4,6);
				effectivedate2 = "12";
				//out.println("effectivedate2  =============       "+effectivedate2+"<br>");
				if(effectivedate2.equals("03")){
					planned1 = planned;
					fileNm1 = fileNm;
					filePath1 = filePath;
					if(!(filePath1==null?"":filePath1).equals("")){
						fileIconStr1 = "<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+filePath1+"','"+fileNm1+"');\"> </a>";
					}
				}else if(effectivedate2.equals("06")){
					planned2 = planned;
					fileNm2 = fileNm;
					filePath2 = filePath;
					if(!(filePath2==null?"":filePath2).equals("")){
						fileIconStr2 = "<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+filePath2+"','"+fileNm2+"');\"> </a>";
					}					
				}else if(effectivedate2.equals("09")){
					planned3 = planned;
					fileNm3 = fileNm;
					filePath3 = filePath;
					if(!(filePath3==null?"":filePath3).equals("")){
						fileIconStr3 = "<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+filePath3+"','"+fileNm3+"');\"> </a>";
					}					
				}else if(effectivedate2.equals("12")){
					planned4 = planned;
					fileNm4 = fileNm;
					filePath4 = filePath;
					if(!(filePath4==null?"":filePath4).equals("")){
						fileIconStr4 = "<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+filePath4+"','"+fileNm4+"');\"> </a>";
					}					
				}				
			}
			//out.println("mname  =============       "+mname+"<br>");
			//out.println("updateId  ======   "+updateId+"<br>");
			//out.println("effectivedate  ========       "+effectivedate+"<br>");
			//out.println("planned  ========       "+planned+"<br>");
			//out.println("pConf  ========       "+pConf+"<br>");
			//out.println("==============================<br>");
		}
	}
%>
<%

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

	function download(filepath, filename){
		downForm.fileName.value=filename;
		downForm.filePath.value=filepath;
		downForm.submit();
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
<table width="98%" border="0" cellspacing="0" cellpadding="0">
<form name="detailForm" method="post" ENCTYPE="multipart/form-data">
	<input type=hidden name=tag>
	<input type=hidden name=contentId value="<%=mid%>">
	<input type=hidden name=schDate >
	<input type=hidden name=itemCode value="<%=contentId%>">

	<tr>
		<td height="25"><strong> <img src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="8" align="absmiddle"> 실행계획 </strong></td>
	</tr>
</form>		
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" style="display:none;">
	<tr bgcolor="#FFFFFF">
		<td width="30%" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>성과지표 명</strong></font></td>
		<td width="70%"><strong><font color="#3366CC"><%= mname %></font></strong></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr bgcolor="#FFFFFF">
		<td width="30%" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>성과지표 명</strong></font></td>
		<td width="70%"><strong><font color="#3366CC"><%= mname %></font></strong></td>
	</tr>
</table>
<br>
<!---------//우측  항목실적  //-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1"	bgcolor="#CCCCCC">
	<tr align="center" bgcolor="#EEEEEE" height="22">
		<td width="30%"><font color="#333333"><strong></strong></font></td>
		<td width="70%"><font color="#333333"><strong>실행계획(500자이내)</strong></font></td>
	</tr>
	
<%-- 	

	String mname="";
	String planned="";	
	String updateId="";
	String effectivedate="";
	String effectivedate2="";
	
	int pConf = 0;

	if(dsMea != null)
	{
		while(dsMea.next())
		{
			//ID = dsMea.isEmpty("ID")?"":dsMea.getString("ID");
			mname= dsMea.getString("NAME");
			updateId = dsMea.isEmpty("UPDATEID")?"":dsMea.getString("UPDATEID");
			effectivedate = dsMea.isEmpty("EFFECTIVEDATE")?"":dsMea.getString("EFFECTIVEDATE");
			planned = dsMea.isEmpty("PLANNED")?"":dsMea.getString("PLANNED");
			pConf = dsMea.isEmpty("pconfirm")?0:dsMea.getInt("pconfirm"); 
			
			if(!effectivedate.equals("")){
				effectivedate2 = effectivedate.substring(2,4);
				out.println("effectivedate2  =============       "+effectivedate2+"<br>");
			}
			//out.println("mname  =============       "+mname+"<br>");
			//out.println("updateId  ======   "+updateId+"<br>");
			//out.println("effectivedate  ========       "+effectivedate+"<br>");
			//out.println("planned  ========       "+planned+"<br>");
			//out.println("pConf  ========       "+pConf+"<br>");
			out.println("==============================<br>");
		}
	}
--%>
		
<%System.out.println("freq   ===>   "+freq1); if ("분기".equals(freq1)){ %>
	<form name="file1" method="post" ENCTYPE="multipart/form-data">			
	<tr align="center" bgcolor="#FFFFFF" >
		<td ><font color="#333333"><strong>1/4분기</strong></font>
		<%=fileIconStr1 %>
		</td>
		<td valign="top"><textArea name="planned1" style="width:98%;height:80px"><%=planned1 %></textArea></td>
	</tr>
	
		<input type=hidden name=schDate >
		<input type=hidden name=qtr value="1">
		<input type=hidden name=tag>
		<input type=hidden name=contentId value="<%=mid%>">
		<tr bgcolor="#FFFFFF" >
				<td colspan=2>
					<input size="40%" type="file" name="fileNm1" class="input_box">
					<% if (groupId<2){ %>
					<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" align="absmiddle" alt="계획초기화" width="65" height="20" border="0" onClick="javascript:actionPerformed('RP','file1');" style="cursor:hand">
					<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" align="absmiddle" alt="계획저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('P','file1');" style="cursor:hand">
					<% } else { %>
					<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" align="absmiddle" alt="계획초기화" width="65" height="20" border="0" onClick="javascript:actionPerformed('RP','file1');" style="cursor:hand">
					<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" align="absmiddle" alt="계획저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('P','file1');" style="cursor:hand">
					<%} %>					
				</td>
		</tr>
	</form>
<% } %>
<% if ("분기".equals(freq1)||"반기".equals(freq1)){ %>	
	<form name="file2" method="post" ENCTYPE="multipart/form-data">						
	<tr align="center" bgcolor="#FFFFFF" >
		<td ><font color="#333333"><strong>2/4분기</strong></font>
		<%=fileIconStr2 %>
		</td>
		<td valign="top"><textArea name="planned2" style="width:98%;height:80px"><%=planned2 %></textArea></td>
	</tr>
	<input type=hidden name=qtr value="2">
	<input type=hidden name=tag>
	<input type=hidden name=schDate >
	<input type=hidden name=contentId value="<%=mid%>">
		<tr bgcolor="#FFFFFF" >
				<td colspan=2>
					<input size="40%" type="file" name="fileNm2" class="input_box">
					<% if (groupId<2){ %>
					<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" align="absmiddle" alt="계획초기화" width="65" height="20" border="0" onClick="javascript:actionPerformed('RP','file2');" style="cursor:hand">
					<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" align="absmiddle" alt="계획저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('P','file2');" style="cursor:hand">				</td>
					<% } else { %>
					<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" align="absmiddle" alt="계획초기화" width="65" height="20" border="0" onClick="javascript:actionPerformed('RP','file2');" style="cursor:hand">
					<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" align="absmiddle" alt="계획저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('P','file2');" style="cursor:hand">
					<%} %>	
		</tr>
	</form>
<% } %>	
<% if ("분기".equals(freq1)){ %>	
<form name="file3" method="post" ENCTYPE="multipart/form-data">		
	<tr align="center" bgcolor="#FFFFFF" >
		<td ><font color="#333333"><strong>3/4분기</strong></font>
		<%=fileIconStr3 %>
		</td>
		<td valign="top"><textArea name="planned3" style="width:98%;height:80px"><%=planned3 %></textArea></td>
	</tr>
	<input type=hidden name=qtr value="3">
	<input type=hidden name=tag>
	<input type=hidden name=schDate >
	<input type=hidden name=contentId value="<%=mid%>">
		<tr bgcolor="#FFFFFF" >
				<td colspan=2>
					<input size="40%" type="file" name="fileNm3" class="input_box">
					<% if (groupId<2){ %>
					<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" align="absmiddle" alt="계획초기화" width="65" height="20" border="0" onClick="javascript:actionPerformed('RP','file3');" style="cursor:hand">
					<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" align="absmiddle" alt="계획저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('P','file3');" style="cursor:hand">				</td>
					<% } else { %>
					<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" align="absmiddle" alt="계획초기화" width="65" height="20" border="0" onClick="javascript:actionPerformed('RP','file3');" style="cursor:hand">
					<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" align="absmiddle" alt="계획저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('P','file3');" style="cursor:hand">

					<%} %>
		</tr>
	
	</form>
<% } %>	
<form name="file4" method="post" ENCTYPE="multipart/form-data">
	<tr align="center" bgcolor="#FFFFFF" >
		<td ><font color="#333333"><strong>년 계획</strong></font>
		<%=fileIconStr4 %>
		</td>
		<td valign="top"><textArea name="planned4" style="width:98%;height:120px"><%=planned4 %></textArea></td>
	</tr>
	<input type=hidden name=qtr value="<%= freq %>">
	<input type=hidden name=tag>
	<input type="hidden" name="freq1">
	<input type=hidden name=schDate >
	<input type=hidden name=contentId value="<%=mid%>">
		<tr bgcolor="#FFFFFF" >
				<td colspan=2>
					<input size="40%" type="file" name="fileNm4" class="input_box">
					<% if (groupId<2){ %>
					<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" align="absmiddle" alt="계획초기화" width="65" height="20" border="0" onClick="javascript:actionPerformed('RP','file4');" style="cursor:hand">
					<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" align="absmiddle" alt="계획저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('P','file4');" style="cursor:hand">				</td>
					<% } else { %>
					<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" align="absmiddle" alt="계획초기화" width="65" height="20" border="0" onClick="javascript:actionPerformed('RP','file4');" style="cursor:hand">
					<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" align="absmiddle" alt="계획저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('P','file4');" style="cursor:hand">

					<%} %>
		</tr>
	
	</form>

</table>
<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
	<input type="hidden" name="filePath">	
</form>
<!---------//우측  항목실적 점수계산 결과  끝 //--------> <!----/저장버튼/--->
<%// if (groupId<2){ %>
<!--  <table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td width="100%" align="right">
			<img src="<%//=imgUri%>/jsp/web/images/btn_reset_planned.gif" alt="계획초기화" width="84" height="20" border="0" onClick="javascript:actionPerformed('RP');" style="cursor:hand">
			<img src="<%//=imgUri%>/jsp/web/images/btn_save_planned.gif" alt="계획저장" width="84" height="20" border="0" onClick="javascript:actionPerformed('P');" style="cursor:hand">
		</td>
	</tr>
</table>
<%// } else { %>
<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td width="100%" align="right">
			<img src="<%//=imgUri%>/jsp/web/images/btn_save_planned.gif" alt="계획저장" width="84" height="20" border="0" onClick="javascript:actionPerformed('P');" style="cursor:hand">
		</td>
		<%-- if (aConf!=1){ %>
		<td width="33%" align="right">
		    <img src="<%=imgUri%>/jsp/web/images/btn_save_temp.gif" alt="임시저장" width="84" height="20" border="0" onClick="javascript:actionPerformed('T');" style="cursor:hand">
			<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('U');" style="cursor:hand">
			<!-- img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" onClick="javascript:actionPerformed('D');" style="cursor:hand"> -->
		</td>
		<td width="33%" align="right">
			<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('E');" style="cursor:hand">
		</td>
		<% }else{ %>
		<td width="67%" align="right">
		</td>
		<% } --%>
	</tr>
	
</table>
-->
<%// } %>


<script language=javascript>
	function actionPerformed(tag, div){

		// 마감되었슴
		if ("<%=mmclose_yn%>" == "Y") {	
				alert("<%=message2%>");
				return;
		}		
			
		if ("<%=periodvalidate%>" == "N") {	
				alert("계획 등록기간이 아닙니다.");
				return;
		}
		
		if ("D"==tag){
			if (confirm("실적정보를 삭제하시겠습니까?")){

			} else {
				return;
			}
		}
		
		if ("RP"==tag){
			if (confirm("계획을 초기화하시겠습니까?")){

			} else {
				return;
			}
		}
		
		if ("P"==tag){
			if (confirm("계획을 저장하시겠습니까?")){

			} else {
				return;
			}
		}
		
		if(div == 'file1'){
			parent.refresh = true;
			file1.tag.value = tag;
			//detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
			file1.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+"03";
			file1.submit();
		}
		else if(div == 'file2'){
			parent.refresh = true;
			file2.tag.value = tag;
			//detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
			file2.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+"06";
			file2.submit();		
		
		}
		else if(div == 'file3'){
			parent.refresh = true;
			file3.tag.value = tag;
			//detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
			file3.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+"09";
			file3.submit();		
		
		}
		else if(div == 'file4'){
			parent.refresh = true;
			file4.tag.value = tag;
			//detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
			file4.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+"12";;			
			file4.submit();		
		
		}
		

	}

//-->
</script>
</body>
</html>
<% }%>
