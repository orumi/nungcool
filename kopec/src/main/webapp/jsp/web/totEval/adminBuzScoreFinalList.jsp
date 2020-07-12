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
	DataSet dsSCR = (DataSet)request.getAttribute("dsSCR");
	
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
	
	double[] eScr = null;
	double[] rScr = null;
	double[] aScr = null;
	HashMap divsMap = null;
	int[] divs = null;
	
	double[] max = new double[3];
	double[] min = new double[3];
	
	int dCNT = dsSCR.getRowCount();
	
	if (dsSCR!=null) {
		eScr = new double[dCNT];
		rScr = new double[dCNT];
		aScr = new double[dCNT];
		divs = new int[dCNT];
		
		divsMap = new HashMap();
		int r = 0;
		while (dsSCR.next()){
			eScr[r]=dsSCR.getDouble("ESCR");			
			rScr[r]=dsSCR.getDouble("RSCR");
			aScr[r]=dsSCR.getDouble("ASCR");
			divsMap.put(dsSCR.getString("DIViSIONID"),new Integer(r));
			divs[r]=dsSCR.getInt("DIVISIONID");
			if (r==0){
				max[0]=eScr[r];
				min[0]=eScr[r];
				max[1]=eScr[r];
				min[1]=eScr[r];
				max[2]=eScr[r];
				min[2]=eScr[r];
			}
			if (max[0]<eScr[r]) max[0]=eScr[r];
			if (min[0]>eScr[r]) min[0]=eScr[r];
			if (max[1]<rScr[r]) max[1]=rScr[r];
			if (min[1]>rScr[r]) min[1]=rScr[r];
			if (max[2]<aScr[r]) max[2]=aScr[r];
			if (min[2]>aScr[r]) min[2]=aScr[r];			
			r++;
		}
	}
%>
<SCRIPT>   
	
	var divs = new Array();
	var eScr = new Array();
	var rScr = new Array();
	var aScr = new Array();
	
	var max0 = <%=max[0]%>;
	var max1 = <%=max[1]%>; 
	var max2 = <%=max[2]%>;
	var min0 = <%=min[0]%>;
	var min1 = <%=min[1]%>;
	var min2 = <%=min[2]%>;
	
	<% for(int j=0;j<dCNT;j++) { %>
		eScr[<%=j%>] = <%=eScr[j] %>;
		rScr[<%=j%>] = <%=rScr[j] %>;
		aScr[<%=j%>] = <%=aScr[j] %>;
		
		divs[<%=j%>] = <%=divs[j]%>;
	<% } %>
	                               
    function actionPerformed(tag){
    	listFrm.mode.value=tag;
    	listFrm.year.value = parent.form1.year.options[parent.form1.year.selectedIndex].value;
    	
    	listFrm.submit();
    }
    
    function reCal(){
    	//alert(listFrm.s00_1.value);
    	var wgt0=listFrm.w00.value;
    	var dif0=listFrm.d00.value;
    	
    	var wgt1=listFrm.w01.value;
    	var dif1=listFrm.d01.value;
    	
    	var wgt2=listFrm.w02.value;
    	var dif2=listFrm.d02.value;
    	    	
    	for(var i=0;i<divs.length;i++){
    		eval("listFrm.s00_"+divs[i]).value = exRound((wgt0-(max0-eScr[i])/(max0-min0)*dif0),3);
    		eval("listFrm.s01_"+divs[i]).value = exRound((wgt1-(max1-rScr[i])/(max1-min1)*dif1),3);
    		eval("listFrm.s02_"+divs[i]).value = exRound((wgt2-(max2-aScr[i])/(max2-min2)*dif2),3);    		    		
    	}
    }
    
	function exRound(val, pos) {
	    var rtn;
	    rtn = Math.round(val * Math.pow(10, Math.abs(pos)-1))
	    rtn = rtn / Math.pow(10, Math.abs(pos)-1)
	    
	
	    return rtn;
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
		<td>지표득점</td>
		<td><input type=text name="w00" value="<%=weight[0] %>" style="width:60px;text-align:right"></td>
		<td><input type=text name="d00" value="<%=distribute[0] %>" style="width:60px;text-align:right"></td>
	<% for(int k=0;k<cnt;k++){ %>	
		<td><input type=text name="s00_<%=dId[k] %>" value="<%=scores[k][0] %>" style="width:60px;text-align:right"></td>
	<% }%>
	</tr>
	<tr align="center" bgcolor="#FFFFFF">
		<td>순위득점</td>
		<td><input type=text name="w01" value="<%=weight[1] %>" style="width:60px;text-align:right"></td>
		<td><input type=text name="d01" value="<%=distribute[1] %>" style="width:60px;text-align:right"></td>
	<% for(int k=0;k<cnt;k++){ %>	
		<td><input type=text name="s01_<%=dId[k] %>" value="<%=scores[k][1] %>" style="width:60px;text-align:right"></td>
	<% }%>
	</tr>
	<tr align="center" bgcolor="#FFFFFF">
		<td>향상득점</td>
		<td><input type=text name="w02" value="<%=weight[2] %>" style="width:60px;text-align:right"></td>
		<td><input type=text name="d02" value="<%=distribute[2] %>" style="width:60px;text-align:right"></td>
	<% for(int k=0;k<cnt;k++){ %>	
		<td><input type=text name="s02_<%=dId[k] %>" value="<%=scores[k][2] %>" style="width:60px;text-align:right"></td>
	<% }%>
	</tr>		
</table>
   <input type=hidden name="pmDivs" value="<%=pmDivs %>">

</form>
<table width=640>
	<tr><td align=right>
		<img src="<%=imgUri%>/jsp/web/images/btn_recal.gif" alt="저장" onClick="javascript:reCal();" style="cursor:hand" width="65" height="20" border="0" align="absmiddle">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" onClick="javascript:actionPerformed('A');" style="cursor:hand" width="50" height="20" border="0" align="absmiddle">
		<img src="<%=imgUri%>/jsp/web/images/btn_reset.gif" alt="초기화" onClick="javascript:actionPerformed('R');" style="cursor:hand" width="65" height="20" border="0" align="absmiddle">
	</td></tr>
</table>
<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	var WinDetail;
 	function openDetail(mId,evalrId){
		if (WinDetail!=null) WinDetail.close();
		var yyyy = parent.form1.year.options[parent.form1.year.selectedIndex].value;
		var month = parent.form1.month.options[parent.form1.month.selectedIndex].value;
		var url = "adminValuateDetail.jsp?year="+yyyy+"&month="+month+"&evalrId="+evalrId+"&mId="+mId;
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
