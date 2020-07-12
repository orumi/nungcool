<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*,
				 com.nc.cool.PeriodUtil,				 
				 com.nc.xml.HierarchyUtil" %>
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
		int group = Integer.parseInt(Common.numfilter((String)session.getAttribute("groupId")));
		int updaterId = 0;
	
	
	DataSet rs = null;
	
	ActualUtil util = new ActualUtil();
	
	request.setAttribute("config",config);
	util.setPlanned(request,response);
	
	String schDate = request.getAttribute("schDate")!=null?(String)request.getAttribute("schDate"):Util.getToDay().substring(0,6);
	
	// 마감일정검사 시작 ===============================================================
	PeriodUtil periodutil = new PeriodUtil();
	String periodvalidate = null;
	String div_cd = "B01";
	String message = "계획  등록기간이 아닙니다.";
	String year = "";//request.getParameter("year");
	
	//year = (year == null || "".equals(year)) ? Util.getToDay().substring(0,4) : year;
	year = schDate.substring(0,4);
	periodvalidate = periodutil.validatePeriod(div_cd, year);
	periodvalidate = (periodvalidate == null || "".equals(periodvalidate)) ? "N" : periodvalidate;
			
	//System.out.println("year ===> " + year);
	//System.out.println("periodvalidate ===> " + periodvalidate);
	// 마감일정검사 끝 =================================================================		
	
	
	DataSet dsMea = (DataSet)request.getAttribute("dsMea");
	DataSet dsDetail = (DataSet)request.getAttribute("dsDetail");
	String  mid = (String)request.getAttribute("mid");
	
	String mname="";
	String frequency="";
	String planned="";
	String plannedbaseplus="";
	String plannedbase="";
	String baseplus="";
	String base="";
	String baselimitplus="";
	String baselimit="";
	String limitplus="";
	String limit="";
	
	if (dsMea!=null) while(dsMea.next()){
		mname        = dsMea.getString("NAME");
		frequency    = dsMea.isEmpty("FREQUENCY")?"":dsMea.getString("FREQUENCY");
		planned      = dsMea.isEmpty("PLANNED")?"":dsMea.getString("PLANNED");
		
		plannedbaseplus  = dsMea.isEmpty("PLANNEDBASEPLUS")?"":dsMea.getString("PLANNEDBASEPLUS");
		plannedbase  = dsMea.isEmpty("PLANNEDBASE")?"":dsMea.getString("PLANNEDBASE");
		
		baseplus         = dsMea.isEmpty("BASEPLUS")?"":dsMea.getString("BASEPLUS");
		base         = dsMea.isEmpty("BASE")?"":dsMea.getString("BASE");
		
		baselimitplus    = dsMea.isEmpty("BASELIMITPLUS")?"":dsMea.getString("BASELIMITPLUS");
		baselimit    = dsMea.isEmpty("BASELIMIT")?"":dsMea.getString("BASELIMIT");
		
		limitplus        = dsMea.isEmpty("LIMITPLUS")?"":dsMea.getString("LIMITPLUS");
		limit        = dsMea.isEmpty("LIMIT")?"":dsMea.getString("LIMIT");
		
	}
	
	String[] aS = new String[12];
	String[] aAp = new String[12];
	String[] aA = new String[12];
	String[] aBp = new String[12];
	String[] aB = new String[12];
	String[] aCp = new String[12];
	String[] aC = new String[12];
	String[] aDp = new String[12];
	String[] aD = new String[12];
	
	int m ;
	if (dsDetail!=null)
		while(dsDetail.next()){
			m = dsDetail.getInt("MONTH");
			aS[m-1] = dsDetail.getString("PLANNED");
			aAp[m-1] = dsDetail.getString("PLANNEDBASEPLUS");
			aA[m-1] = dsDetail.getString("PLANNEDBASE");
			
			aBp[m-1] = dsDetail.getString("BASEPLUS");
			aB[m-1] = dsDetail.getString("BASE");
			
			aCp[m-1] = dsDetail.getString("BASELIMITPLUS");
			aC[m-1] = dsDetail.getString("BASELIMIT");
			
			aDp[m-1] = dsDetail.getString("LIMITPLUS");
			aD[m-1] = dsDetail.getString("LIMIT");
		}
	
	HierarchyUtil quation= new HierarchyUtil();
	quation.getEquType(request, response);
    DataSet dsQua = (DataSet)request.getAttribute("ds");
    
    String lstQuation = "";
    String lstQuaVal = "";
    if (dsQua!=null){
    	while(dsQua.next()){ 
    		lstQuation = lstQuation + "<option value='" + dsQua.getString("TYPE") + "'>" + dsQua.getString("TYPE_NM") + "</option>";
    		lstQuaVal = lstQuaVal + "<option value='" + dsQua.getString("PLANNED") + "|" + dsQua.getString("PLANNEDBASE") + "|" + dsQua.getString("BASE") + "|" + dsQua.getString("BASELIMIT") + "|" + dsQua.getString("LIMIT") + "|" + "'>" + dsQua.getString("TYPE") + "</option>";
    	}
    }
	
%>

<script>
	function listRefresh(){
		parent.refreshList();
	}
	
	function setPlanned(obj){
		clearValue();
		var val = document.detailForm.cboQuaVal.options[obj.selectedIndex].value;

		var arr = val.split("|");
		
		if("<%=frequency%>" == "년") {
			document.detailForm.s11.value = arr[0];
			document.detailForm.a11.value = arr[1];
			document.detailForm.b11.value = arr[2];
			document.detailForm.c11.value = arr[3];
			document.detailForm.d11.value = arr[4];
		} else if("<%=frequency%>" == "반기") {
			document.detailForm.s5.value = arr[0];
			document.detailForm.a5.value = arr[1];
			document.detailForm.b5.value = arr[2];
			document.detailForm.c5.value = arr[3];
			document.detailForm.d5.value = arr[4];
			
			document.detailForm.s11.value = arr[0];
			document.detailForm.a11.value = arr[1];
			document.detailForm.b11.value = arr[2];
			document.detailForm.c11.value = arr[3];
			document.detailForm.d11.value = arr[4];
		} else if("<%=frequency%>" == "분기") {
			for(i=2;i<12;i=i+3) {
				eval("document.detailForm.s"+i).value = arr[0];
				eval("document.detailForm.a"+i).value = arr[1];
				eval("document.detailForm.b"+i).value = arr[2];
				eval("document.detailForm.c"+i).value = arr[3];
				eval("document.detailForm.d"+i).value = arr[4];		
			}
		} else if("<%=frequency%>" == "월") {
			for(i=0;i<12;i++) {
				eval("document.detailForm.s"+i).value = arr[0];
				eval("document.detailForm.a"+i).value = arr[1];
				eval("document.detailForm.b"+i).value = arr[2];
				eval("document.detailForm.c"+i).value = arr[3];
				eval("document.detailForm.d"+i).value = arr[4];		
			}
		} 
	}
	
	function clearValue(){
		for(i=0;i<12;i++) {
			eval("document.detailForm.s"+i).value = "";
			eval("document.detailForm.a"+i).value = "";
			eval("document.detailForm.b"+i).value = "";
			eval("document.detailForm.c"+i).value = "";
			eval("document.detailForm.d"+i).value = "";		
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
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	bgcolor="#ffffff" >
<form name="detailForm" method="post" >
	<input type=hidden name=tag>
	<input type=hidden name=contentId value="<%=mid%>">
	<input type=hidden name=schDate >
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8"
			height="8" align="absmiddle"> 성과지표 목표값 설정</strong></td>
	</tr>
</table>
	
<!---------//우측  변수(항목)실적입력 //-------->
<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
	<tr bgcolor="#FFFFFF">
		<td width="19%" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>성과지표 명</strong></font></td>
		<td width="81%"><strong><font color="#3366CC"><%= mname %></font></strong></td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="3" bgcolor="#9DB5D7">
	<tr align="center" bgcolor="#D2E1F0" height="23">
		<td><font color="#003399"><strong>해당월</strong></font></td>
		<td><font color="#003399"><strong>S</strong></font></td>
		
		<td><font color="#003399"><strong>A+</strong></font></td>
		<td><font color="#003399"><strong>A</strong></font></td>
		
		<td><font color="#003399"><strong>B+</strong></font></td>
		<td><font color="#003399"><strong>B</strong></font></td>
		
		<td><font color="#003399"><strong>C+</strong></font></td>
		<td><font color="#003399"><strong>C</strong></font></td>
		
		<td><font color="#003399"><strong>D+</strong></font></td>
		<td><font color="#003399"><strong>D</strong></font></td>
	</tr>
	
	<% for (int i=0;i<12;i++){ %>
	<tr align="center" bgcolor="#FFFFFF" height="23">
		<td><font color="#003399"><strong><%=i+1 %> 월</strong></font></td>
		<td><input type="text" name="s<%=i %>" size=9 value="<%=aS[i]!=null?aS[i]:"" %>" style="text-align:right"></td>
		<td><input type="text" name="ap<%=i %>" size=9 value="<%=aAp[i]!=null?aAp[i]:"" %>" style="text-align:right" ></td>
		<td><input type="text" name="a<%=i %>" size=9 value="<%=aA[i]!=null?aA[i]:"" %>" style="text-align:right" ></td>
		
		<td><input type="text" name="bp<%=i %>" size=9 value="<%=aBp[i]!=null?aBp[i]:"" %>" style="text-align:right" ></td>
		<td><input type="text" name="b<%=i %>" size=9 value="<%=aB[i]!=null?aB[i]:"" %>" style="text-align:right" ></td>
		
		<td><input type="text" name="cp<%=i %>" size=9 value="<%=aCp[i]!=null?aCp[i]:"" %>" style="text-align:right" ></td>
		<td><input type="text" name="c<%=i %>" size=9 value="<%=aC[i]!=null?aC[i]:"" %>" style="text-align:right" ></td>
		
		<td><input type="text" name="dp<%=i %>" size=9 value="<%=aDp[i]!=null?aDp[i]:"" %>" style="text-align:right" ></td>
		<td><input type="text" name="d<%=i %>" size=9 value="<%=aD[i]!=null?aD[i]:"" %>" style="text-align:right" ></td>
	</tr>
	<% } %>
			
</table>

<!---------//우측  항목실적 점수계산 결과  끝 //--------> <!----/저장버튼/--->
<% //if ((userId==updaterId)||(userGroup==1)){
  	if ((group==1||group==3)){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top:5;">
	<tr>
		<td align="left" style="width:230;x;"><table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#9DB5D7">
			<tr bgcolor="#FFFFFF">
				<td align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>목표구분</strong></font></td>
				<td><select name="cboQuation" style="width:170;x;" onchange="javascript:setPlanned(this);">
     				<%=lstQuation%>
     			</select><select name="cboQuaVal" style="width:0;x;" style="display:none;">
     				<%=lstQuaVal%>
     			</select></td>
     		</tr>
     	</table></td>
		<td align="right"><img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50"
			height="20" border="0" onClick="javascript:actionPerformed('U');" style="cursor:hand">
			<img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50"
			height="20" border="0" onClick="javascript:actionPerformed('D');" style="cursor:hand"></td>			
	</tr>
</table>
<% } %>
<!----/저장버튼 끝/--->
</form>
<script language=javascript>
	function actionPerformed(tag){
	
		if ("<%=periodvalidate%>" == "N") {	
				alert("계획 등록기간이 아닙니다.");
				return;
		}
				
		if (tag=="D"){
			if (confirm('계획은 삭제하시겠습니까?')){
			
			} else {
				return;
			}
		}
		detailForm.tag.value = tag;
		detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value;
		detailForm.submit();
	
	}

//-->
</script>
</body>
</html>
<% }%>
