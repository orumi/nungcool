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

	TaskActualUtil tau = new TaskActualUtil();
	tau.achvFile(request,response);

	String typeid = (String)request.getAttribute("typeid");
	DataSet ds = (DataSet)request.getAttribute("fileList");	//프로젝트 리스트
//	out.println(typeid);

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">

	function delFile(did, qtr, year, file, idx)
	{
		if(confirm("삭제 하시겠습니까?"))
		{
			form1.typeid.value = <%=typeid%>;
			form1.year.value = year;
			form1.qtr.value = qtr;
			form1.did.value = did;
			form1.file.value = file;
			form1.idx.value = idx;
			form1.div.value = "D";
			form1.submit();
//			location.href("./deleteFile.jsp?did="+did+"&qtr="+qtr+"&year="+year+"&file="+file+"&idx="+idx+"&typeid="+<%=typeid%>);
		}
	}
</script>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
    <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    	
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				근거자료
                  	</strong></td>
              </tr>
	</table>
				<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				<form name="form1" method="post">
					<input type="hidden" name="typeid" value="" >
					<input type="hidden" name="year" value="" >
					<input type="hidden" name="qtr" value="" >
					<input type="hidden" name="did" value="" >
					<input type="hidden" name="file" value="" >
					<input type="hidden" name="idx" value="" >
					<input type="hidden" name="div" value="" >
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="75%"><strong><font color="#003399">근거자료</font></strong></td>
	                <td align="center" width="25%"><strong><font color="#003399">삭제</font></strong></td>
					</tr>
					<%if(ds != null){ 
						while(ds.next())
						{
							if(ds.getString("FILEPATH") != null)
							{
								String fileNM[] = ds.getString("FILEPATH").split("\\|");
								for(int i = 0; i < fileNM.length; i++)
								{
%>
									<tr bgcolor='#FFFFFF'>
										<td align="left">
											<a href="./download.jsp?clips=<%=fileNM[i]%>"><%=fileNM[i]%></a>
										</td>
 										
										<td align="center">
<!-- 											<a href="javaScript:#"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" width="50" height="20" align="absmiddle"></a> -->
 											<a href="javaScript:delFile('<%=ds.getString("DID")%>','<%=ds.getString("QTR") %>','<%=ds.getString("YEAR")%>','<%=ds.getString("FILEPATH")%>','<%=i %>')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" width="50" height="20" align="absmiddle"></a>
										</td>

									</tr>
<%
								}
							}
						}
					}
					%>

					<tr bgcolor="#FFFFFF">
						<td>
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
				</form>
            </table>

</body>
</html>