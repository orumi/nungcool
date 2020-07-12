<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%
	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		
		return;
	}
    
    
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	TaskAdmin util = new TaskAdmin();

	util.setDtlWork(request, response);
	DataSet ds = (DataSet)request.getAttribute("ds");	//프로젝트 리스트


%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">
		var prjList = new Array();

		function openDetail(detailId,dtlId,syear,eyear,sqtr,eqtr,dname,define,mgrdept,mgruser,weight) {

			var frm = parent.dtl.form1;
				
			frm.dtlid.value=dtlId;
			frm.syear.value=syear;
			frm.eyear.value=eyear;
			frm._sQtr.value=sqtr;
			frm._eQtr.value=eqtr;
			frm.dtlname.value=dname;
			frm.define.value=define.replace(/<br>/g,'\n');
			frm.weight.value=weight;
			//frm.dept.value=mgrdept;
			//frm.mgruser.value=mgruser;
		}

		var refresh = false;


</script>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
				<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				<form name="form1" method="post">
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="25%"><strong><font color="#003399">세부실행계획</font></strong></td>
					</tr>
<%
					if(ds.getRowCount() != 0 && ds !=null) {
						while(ds.next())  {
							String dname = ds.isEmpty("DTLNAME")?"":ds.getString("DTLNAME");
							String detailId = ds.getString("DETAILID");
							String dtlId = ds.getString("DTLID");
							String syear = ds.getString("SYEAR");
							String eyear = ds.getString("EYEAR");
							String sqtr = ds.getString("SQTR");
							String eqtr = ds.getString("EQTR");
							String define = ds.getString("DEFINE");
							String mgrdept = ds.getString("MGRDEPT");
							String mgruser = ds.getString("MGRUSER");
							String weight = ds.getString("WEIGHT");
							
							define = define.replaceAll("\n","<br>");
%>					
	                <tr bgcolor="#FFFFFF">
						<td align="left">
						<a href="javascript:openDetail('<%=detailId%>','<%=dtlId%>','<%=syear%>','<%=eyear%>','<%=sqtr%>','<%=eqtr%>','<%=dname%>','<%=define%>','<%=mgrdept%>','<%=mgruser%>','<%=weight %>');" >
<% 
								out.print(dname);
%>
						</td>
	                </tr>
<%
						}
					}
%>
            </table>
</body>
</html>