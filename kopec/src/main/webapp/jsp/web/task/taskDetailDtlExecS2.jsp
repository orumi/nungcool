<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
    TaskActualUtil tAc2 = new TaskActualUtil();
    tAc2.taskActual(request, response);


	DataSet prtDetail = (DataSet)request.getAttribute("prjDetail");
%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>

<script language="javascript">

    function ifrResize()
    {
        window.parent.formResize(document.body.scrollHeight);
    }

    function frmSend(detailid, stepid)
    {
                        window.open('taskDetail_P.jsp?detailid=' + detailid +
                                                     '&typeid=' + parent.form1.typeSelect.value +
                                                     '&projectid='+ parent.form1.projectSel.value +
                                                     '&fieldid='+ parent.form1.fieldSelect.value +
                                                     '&stepid=' + stepid, '세부실행과제추가', 'width=600', 'height=500');
    }

</script>
<body onload="ifrResize()">
    <form name="form4" method="post" action="">
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                  2단계 추진업무(세부실행과제 및 목표수준)</strong></td>
              </tr>
            </table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr bgcolor="#D4DCF4">
                <td align="center"><strong><font color="#003399">세부실행과제</font></strong></td>
                <td align="center"><strong><font color="#003399">추진기간</font></strong></td>
                <td align="center"><strong><font color="#003399">목표수준</font></strong></td>
                <td align="center"><strong><font color="#003399">주관부서</font></strong></td>
              </tr>

<%
            if(prtDetail != null)
            {
    			while(prtDetail.next())
    			{
%>
              <tr bgcolor="#FFFFFF">
                <td><a href="javascript:frmSend('<%=prtDetail.getString("detailid")%>','1')"><%=prtDetail.getString("execwork") %></a></td>
                <td align="center"><%=prtDetail.getString("drvperi") %></td>
                <td><%=prtDetail.getString("goallev") %></td>
                <td align="center"><%=prtDetail.getString("mgrdept") %></td>
              </tr>
<%
            }
			    }
%>

              <tr bgcolor="#FFFFFF">
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
              </tr>
            </table>
            <input type="hidden" name="step" value="2">
    </form>
</body>
</html>