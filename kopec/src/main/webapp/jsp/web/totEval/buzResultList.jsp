<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
				com.nc.totEval.*,
				com.nc.util.*"%>
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
	<% 
		return;
	}

	ESTAdminUtil util = new ESTAdminUtil();
	util.setAdminBuzScoreFinal(request, response);
	
	ArrayList list = (ArrayList)request.getAttribute("list");

	int cnt = list!=null?list.size():0;
	double[][] scores = new double[cnt][3];
	String[] dNames = new String[cnt];
	String[] dId = new String[cnt];
	String pmDivs = "";
	
	double[] weight = new double[3];
	double[] distribute = new double[3];
	
	if (list!=null){
		for(int i=0;i<cnt;i++){
			EstFinalScore scr = (EstFinalScore)list.get(i);
			weight[0] = scr.weight[0];
			weight[1] = scr.weight[1];
			weight[2] = scr.weight[2];
			
			distribute[0] = scr.distribute[0];
			distribute[1] = scr.distribute[1];
			distribute[2] = scr.distribute[2];
			
			scores[i][0]=scr.score[0];
			scores[i][1]=scr.score[1];
			scores[i][2]=scr.score[2];
			
			dNames[i] = scr.dName;
			pmDivs += "|"+scr.divisionId;
			dId[i]=String.valueOf(scr.divisionId);
		}
	}
	for (int l=0;l<3;l++){
		if (weight[l]==0) weight[l]=10;
		if (distribute[l]==0) distribute[l]=0.5;
	}
%>
<SCRIPT>                                  
    function actionPerformed(tag){
    	listFrm.mode.value=tag;
    	listFrm.year.value = parent.form1.year.options[parent.form1.year.selectedIndex].value;
    	
    	listFrm.submit();
    }

</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="8" topmargin="0" marginwidth="0">
<form name="listFrm" method="post">

<input type=hidden name=mode >
<input type=hidden name=year>


<!---------//좌측  KPI 선택 전청 리스트//-------->


<table width="660" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="140" rowspan=2><strong><font color="#003399">구분</font></strong></td>
		<td width="50" rowspan=2><strong><font color="#003399">배점</font></strong></td>
		<td width="60" rowspan=2><strong><font color="#003399">변별력</font></strong></td>
		<td colspan=<%=cnt %>><strong><font color="#003399">부서</font></strong></td>
	</tr>
	<tr align="center" bgcolor="#D4DCF4">
	<% for(int j=0;j<dNames.length;j++){ %>	
		<td width="70" ><strong><font color="#003399"><%=dNames[j] %></font></strong></td>
	<% } %>
	</tr>
	<tr align="center" bgcolor="#FFFFFF">
		<td align=left><a href="javascript:openDetail(0);">지표득점</a></td>
		<td align=right><%=weight[0] %></td>
		<td align=right><%=distribute[0] %></td>
	<% for(int k=0;k<cnt;k++){ %>	
		<td align=right><%=scores[k][0] %></td>
	<% }%>
	</tr>
	<tr align="center" bgcolor="#FFFFFF">
		<td align=left><a href="javascript:openDetail(1);">순위득점</a></td>
		<td align=right><%=weight[1] %></td>
		<td align=right><%=distribute[1] %></td>
	<% for(int k=0;k<cnt;k++){ %>	
		<td align=right><%=scores[k][1] %></td>
	<% }%>
	</tr>
	<tr align="center" bgcolor="#FFFFFF">
		<td align=left><a href="javascript:openDetail(2);">향상득점</a></td>
		<td align=right><%=weight[2] %></td>
		<td align=right><%=distribute[2] %></td>
	<% for(int k=0;k<cnt;k++){ %>	
		<td align=right><%=scores[k][2] %></td>
	<% }%>
	</tr>		
</table>
   <input type=hidden name="pmDivs" value="<%=pmDivs %>">

</form>

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	var WinApp;
 	function openDetail(tag){
		if (WinApp!=null) WinApp.close();
		var yyyy = parent.form1.year.options[parent.form1.year.selectedIndex].value;
		var url = "";
		if (tag==0) {
			url = "popupBuzScoreList.jsp?year="+yyyy;
		} else if (tag==1) {
			url = "popupBuzScoreList01.jsp?year="+yyyy;
		} else if (tag==2) {
			url = "popupBuzScoreList02.jsp?year="+yyyy;
		}
		WinApp = window.open(url,"","toolbar=no,width=700,height=500,scrollbars=yes,resizable=yes,menubar=no,status=no" ); 	
 	}
	
	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}
	
	
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	//mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
