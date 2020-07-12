<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String id = (String)session.getAttribute("groupId")==null?"0":"1";
	if(id.equals("0")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		
		return;
	}

    TaskActualUtil tAc = new TaskActualUtil();

    tAc.taskActualList(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds");
	DataSet dsP = (DataSet)request.getAttribute("dsP");

    String lifeSession = (String)session.getAttribute("groupId")==null?"0":"1";

	String pname = "";
	if (dsP!=null)
		while(dsP.next()){
			pname = dsP.getString("NAME");
		}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javascript">

    function setAchv(did)  {
			parent.detailDtl.form1.detailid.value = did;
			parent.detailDtl.form1.submit();
    }


</script>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
    <form name="form1" method="post" action="">
    <input type="hidden" name="pid">
        <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#9DB5D7">
            <tr bgcolor="#FFFFFF" >
  				        <td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
   	 			        <%=pname %></strong></td>
            </tr>
          <tr bgcolor="#D4DCF4">
            <td align="center" width="75%"><strong><font color="#003399">실행계획(추진계획)</font></strong></td>
            <td align="center" width="25%"><strong><font color="#003399" >추진기간<BR>(년/분기)</font></strong></td>
<!--                 <td align="center"><strong><font color="#003399" width="45%">목표수준</font></strong></td> -->
          </tr>
<%
            if(ds != null)  {
    			while(ds.next()) {
    				String execWork = ds.isEmpty("EXECWORK")?"":ds.getString("EXECWORK");
%>
          <tr bgcolor="#FFFFFF">
            <td width="75%" ><a href="javascript:setAchv('<%=ds.getString("DETAILID")%>')"><%=execWork %></a></td>
            <td width="25%" align="center"><%=ds.getString("PERIOD") %></td>
          </tr>
<%
            }
		}
%>
         </table>
    </form>
</body>
</html>