<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 
>-------------- 수정 사항  --------------<
수정일 : 2007.07.05 수정자 : 조영훈 


 -->
 
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%
	request.setCharacterEncoding("EUC-KR");
    


	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
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

    TaskProceed tp = new TaskProceed();
    tp.achvFile(request,response);

	DataSet ds = (DataSet)request.getAttribute("fileList");	//프로젝트 리스트


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

		function openDetail(did, dtlid) 
		{
			//alert(pid);
			if (parent.dtl.form1.did.value !=null) 
			{

				parent.dtl.form1.syear.length = 0;
				parent.dtl.form1.eyear.length = 0;
				parent.dtl.form1._sQtr.length = 0;
				parent.dtl.form1._eQtr.length = 0;
				
				parent.dtl.form1.dtlid.value=dtlid;
				parent.dtl.form1.did.vlaue=did;
				parent.dtl.form1.submit();
			}
		}

		var refresh = false;


</script>
<body>
    <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				근거자료
                  	</strong></td>
              </tr>
	</table>
				<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				<form name="form2" method="post">
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="25%"><strong><font color="#003399">근거자료</font></strong></td>
					</tr>
					<%if(ds != null){ 
						while(ds.next())
						{
							String fileNM[] = ds.getString("FILEPATH").split("\\|");
							for(int i = 0; i < fileNM.length; i++)
							{
								out.println("<tr bgcolor='#FFFFFF'><td>");
								out.println("<a href='./download.jsp?clips=" + fileNM[i] + "'>" + fileNM[i] + "</a>");
							}
						}
					}
					%>

					<tr bgcolor="#FFFFFF">
						<td>
							&nbsp;
						</td>
					</tr>
            </table>
</body>
</html>