<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
    request.setCharacterEncoding("euc-kr");
	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	String imgUri = request.getRequestURI();

	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	TaskInitiative util = new TaskInitiative();

	util.setObjective(request, response);
	DataSet ds = (DataSet)request.getAttribute("ds");	//프로젝트 리스트
    
	
	String pBscId = request.getParameter("pBscId")!=null?request.getParameter("pBscId"):"";
	String bscId = request.getParameter("bscId")!=null?request.getParameter("bscId"):"";

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

		function openDetail(oId,bscId,oname) {
			//alert(pid);
			parent.bscId = bscId;
			parent.objId = oId;
			parent.form1.txtObj.value=oname;
			
			
			parent.detail.form1.mode.value = "G";
			parent.detail.form1.bscId.value = bscId;
			parent.detail.form1.objId.value = oId;
			parent.detail.form1.submit();
		}
		
		var refresh = false;
		

</script>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
          <form name="form1" method="post" action="" >
          	<input type="hidden" name="pBscId" value="<%=pBscId %>">
          	<input type="hidden" name="bscId" value="<%=bscId %>">
          </form>
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
           			 	<tr>
              				<td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
               	 			전략 목표</strong></td>
          				</tr>
       			</table>	          
			<table width="102%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
					<tr bgcolor="#D4DCF4">
		                <td align="left" width="30%"><strong><font color="#003399">전략목표</font></strong></td>
		                <td align="left"><strong><font color="#003399">전략과제</font></strong></td>
					</tr>
<%

					if(ds != null) {
						String oname = "";
						String oid = "";
						String bId = "";
						StringBuffer sbExe = null;
						while(ds.next()) {
							
							if ( !oname.equals(ds.getString("NAME")) ) {
								if (!"".equals(oname)){ %>
				                <tr bgcolor="#FFFFFF">
					                <td align="left">
					                <a href="javascript:openDetail('<%=oid%>','<%=bId %>','<%=oname %>');">
					                	<%=oname %>
					                	</a>
					                	</td>
									<td>
										<%=sbExe.toString() %>						
									</td>
				                </tr>	
							<%	}
								sbExe = null;
								oname = ds.getString("NAME");
								oid = ds.getString("ID");
								bId = ds.getString("DID");
								sbExe = new StringBuffer();
								if (!ds.isEmpty("EXECWORK")){
									sbExe.append("■ "+ds.getString("EXECWORK")+"&nbsp;&nbsp;&nbsp;  ( "+ds.getString("TNAME")+" - "+ds.getString("PNAME")+" )<br>");
								}								
							} else {
								if (!ds.isEmpty("EXECWORK")){
									sbExe.append("■ "+ds.getString("EXECWORK")+"&nbsp;&nbsp;&nbsp;  ( "+ds.getString("TNAME")+" - "+ds.getString("PNAME")+" )<br>");
								}
							}
						}
%>

				                <tr bgcolor="#FFFFFF">
					                <td align="left">
					                <a href="javascript:openDetail('<%=oid%>','<%=bId %>','<%=oname %>');">
					                	<%=oname %>
					                	</a>
					                	</td>
									<td>
										<%=sbExe.toString() %>						
									</td>
				                </tr>	

<%						
					
					
					
					}
%>
            </table>
</body>
</html>