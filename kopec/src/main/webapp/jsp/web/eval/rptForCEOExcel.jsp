<%@ page contentType="application/vnd.ms-excel; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*,
				 com.nc.xml.*;" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(1);

	String sName = (String)(request.getParameter("sname")==null?"��������":Util.getEUCKR(request.getParameter("sname")));
	String year = (String)(request.getParameter("year")==null?"":Util.getEUCKR(request.getParameter("year")));
	String month = (String)(request.getParameter("month")==null?"":Util.getEUCKR(request.getParameter("month")));

	MeasReportUtil util = new MeasReportUtil();

	util.getCeoOrgBscStatus(request,response);
	DataSet dsBsc = (DataSet)request.getAttribute("ds");

	util.getCeoOrgMeasList(request,response);
	DataSet dsMea = (DataSet)request.getAttribute("ds");

	String strClient = request.getHeader("user-agent");
	if( strClient.indexOf("MSIE 5.5") != -1 ) {
//	 explorer 5.5 ���� ��
		response.setHeader("Content-Disposition", "inline; filename=CEOReport"+year+month+".xls");
		response.setHeader("Content-Description", "JSP Generated Data");
	} else {
		response.setHeader("Content-Disposition", "attachment; filename=CEOReport"+year+month+".xls");
		response.setHeader("Content-Description", "JSP Generated Data");
	}

%>
<html>
<head>
<title>::: CEO Report :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!--
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<link href="<%=imgUri %>/jsp/web/css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">

-->
</style>
</head>
<body style="margin:10px">
<table width="650" border="1" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
	<tr bgcolor="#FFFFFF">
   		<td align="center" colspan="11" style="padding-top:6;padding-right:5;"><p class="title_b"><font size="3">CEO REPORT</font></p></td>
	</tr>
	<tr bgcolor="#FFFFFF">
   		<td colspan="11">&nbsp;</td>
 	</tr>
	<tr bgcolor="#FFFFFF">
		<td colspan="11" height="25"><strong> <%=sName%> (<%=year %>/<%=month %>)</strong></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="12" align="center" bgcolor="#D4DCF4" rowspan="2"><font color="#003399"></td>
		<td width="298" align="center" bgcolor="#D4DCF4" rowspan="2"><font color="#003399"><strong>������</strong></font></td>
		<td width="30" align="center" bgcolor="#D4DCF4" rowspan="2"><font color="#003399"><strong>����</strong></font></td>
		<td width="60" align="center" bgcolor="#D4DCF4" rowspan="2"><font color="#003399"><strong>���ռ���</strong></font></td>
		<td width="250" align="center" bgcolor="#D4DCF4" colspan="7"><font color="#003399"><strong>������ǥ</strong></font></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>Ź��</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>���</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>����</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>����</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>����</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>�̵��</strong></font></td>
		<td width="50" align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>�Ұ�</strong></font></td>
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
	   				state = "bgcolor='#0000FF'";
	   			}else if(Double.parseDouble(bscore) > 80){
	   				state = "bgcolor='#00FF00'";
	   			}else if(Double.parseDouble(bscore) > 70){
	   				state = "bgcolor='#FFFF00'";
	   			}else if(Double.parseDouble(bscore) > 60){
	   				state = "bgcolor='#FFCC00'";
	   			}else if(Double.parseDouble(bscore) <= 60){
	   				state = "bgcolor='#FF0000'";
	   			}
   			}
    %>
              <tr bgcolor="<%=bgcolor %>">
              	<td align="center"><%=j+1 %></td>
             	<td align="center"><%=bname%></td>
               	<td align="center" <%=state.equals("")?"&nbsp":state%>>&nbsp;</td>
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
	<tr bgcolor="#FFFFFF">
  		<td colspan="11">&nbsp;</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td colspan="11" height="25" bgcolor="#9DB5D7"><strong> ���κм��ǰ�</strong></td>
	</tr>
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
	   				bstate = "Ź��";
	   			}else if(Double.parseDouble(bcscore) > 80){
	   				bstate = "���";
	   			}else if(Double.parseDouble(bcscore) > 70){
	   				bstate = "����";
	   			}else if(Double.parseDouble(bcscore) > 60){
	   				bstate = "����";
	   			}else if(Double.parseDouble(bcscore) <= 60){
	   				bstate = "����";
	   			}
   			}

   			if(!mcscore.equals("")){
	   			if(Double.parseDouble(mcscore) > 90){
	   				mstate = "Ź��";
	   			}else if(Double.parseDouble(mcscore) > 80){
	   				mstate = "���";
	   			}else if(Double.parseDouble(mcscore) > 70){
	   				mstate = "����";
	   			}else if(Double.parseDouble(mcscore) > 60){
	   				mstate = "����";
	   			}else if(Double.parseDouble(mcscore) <= 60){
	   				mstate = "����";
	   			}
   			}
 %>
 <%			if(tmpbcid != bcid){ %>
	<tr bgcolor="#F0F0F0">
		<td colspan="11"> <strong><%=bname %></strong></td>
	</tr>
<% 				tmpbcid = bcid;
			}
%>
	<tr bgcolor="#FFFFFF">
		<td colspan="11">&nbsp; <%=mname %> (<%=mstate %>, <%=mcscore %>)</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td></td>
<%			if(!comments.equals("")){
				comments = comments.replaceAll("\r\n", "<br>");
%>
		<td width="645" colspan="10"><%=comments %></td>
<%			}else{ %>
		<td width="645" colspan="10">&nbsp;</td>
<%			} %>
	</tr>
<% 		}
	} %>
</table>
</body>
</html>