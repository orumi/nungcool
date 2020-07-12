<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*,
				 com.nc.xml.*;" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(1);
	
	String sName = (String)(request.getParameter("sname")==null?"조직구분":Util.getEUCKR(request.getParameter("sname")));
	String year = (String)(request.getParameter("year")==null?"":Util.getEUCKR(request.getParameter("year")));
	String month = (String)(request.getParameter("month")==null?"":Util.getEUCKR(request.getParameter("month")));
	
	MeasReportUtil util = new MeasReportUtil();
	
	util.getCeoOrgBscStatus(request,response);	
	DataSet dsBsc = (DataSet)request.getAttribute("ds");
	
	util.getCeoOrgMeasList(request,response);
	DataSet dsMea = (DataSet)request.getAttribute("ds");
%>
<html> 
<head> 
<title>::: CEO Report :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<link href="<%=imgUri %>/jsp/web/css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
	
-->
</style>
</head>
<body style="margin:10px">
<div id="DivAndPrint">
<table height="45" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="11" style="padding-top:5;"><img src="<%=imgUri%>/jsp/web/images/bulet01.jpg" width="11" height="21"></td>
    <td width="5">&nbsp;</td>
    <td valign="middle" style="padding-top:6;padding-right:5;"><p class="title_b"><font size="3">CEO REPORT</font></p></td>
  </tr>
</table>
<br/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8" 
			height="8" align="absmiddle"> <%=sName%> (<%=year %>/<%=month %>)</strong></td>
	</tr>
</table>
<table width="100%" border="1" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
	<tr bgcolor="#FFFFFF">
		<td align="center" bgcolor="#D4DCF4" rowspan="2"><font color="#003399"><strong>조직명</strong></font></td>
		<td width="10%" align="center" bgcolor="#D4DCF4" rowspan="2"><font color="#003399"><strong>상태</strong></font></td>
		<td width="10%" align="center" bgcolor="#D4DCF4" rowspan="2"><font color="#003399"><strong>종합성과</strong></font></td>
		<td width="250" align="center" bgcolor="#D4DCF4" colspan="7"><font color="#003399"><strong>성과지표</strong></font></td>		
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>탁월</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>우수</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>보통</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>미흡</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>저조</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>미등록</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>소계</strong></font></td>		
	</tr>
<% if(dsBsc != null){
		int j=0;
   		while (dsBsc.next()) {
   			String bname = ((String)dsBsc.getString("bname")).trim();
   			String bscid = ((String)dsBsc.getString("bcid")).trim();
   			String bscore = dsBsc.isEmpty("bscore")?"":dsBsc.getString("bscore")==null?"":dsBsc.getString("bscore");
   			String grade_s = dsBsc.isEmpty("grade_s")?"":dsBsc.getString("grade_s");
   			String grade_a = dsBsc.isEmpty("grade_a")?"":dsBsc.getString("grade_a");
   			String grade_b = dsBsc.isEmpty("grade_b")?"":dsBsc.getString("grade_b");
   			String grade_c = dsBsc.isEmpty("grade_c")?"":dsBsc.getString("grade_c");
   			String grade_d = dsBsc.isEmpty("grade_d")?"":dsBsc.getString("grade_d");
   			String notinput  = dsBsc.isEmpty("notinput")?"":dsBsc.getString("notinput");   			
   			String total        = dsBsc.isEmpty("total")?"":dsBsc.getString("total");   		   		   			
   			
   			String state="";
   			String bgcolor="";
   			if(j%2 == 1)
   				bgcolor = "#F0F0F0";
   			else
   				bgcolor = "#FFFFFF";
   			if(!bscore.equals("")){
	   			if(Double.parseDouble(bscore) > 90){
	   				state = "<img src='"+imgUri+"/jsp/web/images/img_state_s.gif' width='18' height='18' align='absmiddle'>";
	   			}else if(Double.parseDouble(bscore) > 80){
	   				state = "<img src='"+imgUri+"/jsp/web/images/img_state_a.gif' width='18' height='18' align='absmiddle'>";
	   			}else if(Double.parseDouble(bscore) > 70){
	   				state = "<img src='"+imgUri+"/jsp/web/images/img_state_b.gif' width='18' height='18' align='absmiddle'>";
	   			}else if(Double.parseDouble(bscore) > 60){
	   				state = "<img src='"+imgUri+"/jsp/web/images/img_state_c.gif' width='18' height='18' align='absmiddle'>";
	   			}else if(Double.parseDouble(bscore) <= 60){
	   				state = "<img src='"+imgUri+"/jsp/web/images/img_state_d.gif' width='18' height='18' align='absmiddle'>";
	   			}
   			}
    %>
              <tr bgcolor="<%=bgcolor %>"> 
                <td align="center"><%=bname%></td>
               	<td align="center"><%=state.equals("")?"&nbsp":state%></td>
               	<td align="center"><%=bscore.equals("")?"&nbsp":bscore%></td>
               	<td align="center"><%=grade_s%></td>
               	<td align="center"><%=grade_a%></td>
               	<td align="center"><%=grade_b%></td>
               	<td align="center"><%=grade_c%></td>
               	<td align="center"><%=grade_d%></td>
               	<td align="center"><%=notinput%></td>
               	<td align="center"><%=total%></td>                      	
              </tr>
    <%
    		j++;
    	}
	} %>
</table>
<br/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_01.gif" width="8" 
			height="8" align="absmiddle"> 내부분석의견</strong></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
<% if(dsMea != null){
		int tmpbcid = 0;
   		while (dsMea.next()) {
   			int bcid = dsMea.getString("bcid")==null?0:dsMea.getInt("bcid");
   			String bname = (String)(dsMea.isEmpty("bname")?"":(dsMea.getString("bname")==null?"":dsMea.getString("bname")));
   			String mname = (String)(dsMea.isEmpty("mname")?"":(dsMea.getString("mname")==null?"":dsMea.getString("mname")));
   			String bcscore = (String)(dsMea.isEmpty("bcscore")?"":(dsMea.getString("bcscore")==null?"":dsMea.getString("bcscore")));
   			String mcscore = (String)(dsMea.isEmpty("mcscore")?"":(dsMea.getString("mcscore")==null?"":dsMea.getString("mcscore")));
   			String comments = (String)(dsMea.isEmpty("comments")?"":(dsMea.getString("comments")==null?"":dsMea.getString("comments")));
   			String bstate = "";
   			String mstate = "";

   			if(!bcscore.equals("")){
	   			if(Double.parseDouble(bcscore) > 90){
	   				bstate = "탁월";
	   			}else if(Double.parseDouble(bcscore) > 80){
	   				bstate = "우수";
	   			}else if(Double.parseDouble(bcscore) > 70){
	   				bstate = "보통";
	   			}else if(Double.parseDouble(bcscore) > 60){
	   				bstate = "미흡";
	   			}else if(Double.parseDouble(bcscore) <= 60){
	   				bstate = "저조";
	   			}
   			}
   			
   			if(!mcscore.equals("")){
	   			if(Double.parseDouble(mcscore) > 90){
	   				mstate = "탁월";
	   			}else if(Double.parseDouble(mcscore) > 80){
	   				mstate = "우수";
	   			}else if(Double.parseDouble(mcscore) > 70){
	   				mstate = "보통";
	   			}else if(Double.parseDouble(mcscore) > 60){
	   				mstate = "미흡";
	   			}else if(Double.parseDouble(mcscore) <= 60){
	   				mstate = "저조";
	   			}
   			}
 %> 
 <%			if(tmpbcid != bcid){ %>
	<tr bgcolor="#F0F0F0">
		<td>&nbsp;<img
			src="<%=imgUri%>/jsp/web/images/icon_point_02.gif" align="absmiddle"> <strong><%=bname %></strong></td>
	</tr>
<% 				tmpbcid = bcid;
			}	
%>	<tr bgcolor="#FFFFFF">
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img
			src="<%=imgUri%>/jsp/web/images/icon_point_03.gif" align="absmiddle"> <%=mname %> (<%=mstate %>, <%=mcscore %>)
<%			if(!comments.equals("")){ 
				comments = comments.replaceAll("\n", "<br/>");
%>	
		<table width="92%" align="center" border="1" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
			<tr>
				<td bgcolor="#FFFFFF"><%=comments %></td>
			</tr>
		</table>
<%			}else{ %>	
		<table width="92%" height="40" align="center" border="1" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
			<tr>
				<td bgcolor="#FFFFFF">&nbsp;</td>
			</tr>
		</table>
<%			} %>	
		</td>
	</tr>
<% 		}
	} %>
</table>
</div>
</body>
<script language="JavaScript" type="text/javascript">

	window.print();
		
</script>
</html>