<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		
		return;
	}
	

    TaskActualUtil tAc2 = new TaskActualUtil();
    tAc2.taskActual(request, response);

	DataSet dsP = (DataSet)request.getAttribute("dsP");
	DataSet dsD = (DataSet)request.getAttribute("dsD");

	String projName = "";
	String type = "";

	if (dsP!=null) {
		while(dsP.next()){
			projName = dsP.getString("NAME");
			type = dsP.getString("TYPENAME");
		}
	}


%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javascript">

//    function ifrResize()
//    {
//        window.parent.formResize(document.body.scrollHeight);
//    }

	var detailWin;
    function frmSend(detailid, typeid) {
    	var div = parent.form1.selType.options[parent.form1.selType.selectedIndex].value;
    	var url = 'taskDetail_P.jsp?detailid='+detailid+'&typediv='+typeid;
    	detailWin = window.open(url, '' , 'toolbar=no,width=580,height=650,scrollbars=yes,resizable=no,menubar=no,status=no');
    }

</script>
<body>
<form name="form1" method="post" action="">
    <input type="hidden" name="projectId" value="">
    <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
      <tr bgcolor="#FFFFFF">
        <td align=left width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">혁신전략</font></strong></td>
        <td width="85%"><strong><input name="projectNmText" type="text" class="input_box" size="55" readonly value="<%=type %>"></strong></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td align=left width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">Sub 전략</font></strong></td>
        <td width="85%"><strong><input name="projectNmText" type="text" class="input_box" size="55" readonly value="<%=projName %>"></strong></td>
      </tr>    
<!--         
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">개요(필요성)</font></strong></td>
        <td><textarea name="projectDesTxt" cols="100" rows="3" class="textarea_box" readonly></textarea></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">목표</font></strong></td>
        <td><textarea name="projectGoal" cols="100" rows="3" class="textarea_box" readonly></textarea></td>
      </tr>
 -->      
    </table><!------//프로젝트 끝//---->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    	<tr>
    	    <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                  세부추진과제</strong>
            </td>
        </tr>
    </table>
            <table width="100%" border="0" align="center" cellpadding="5" cellspacing="01" bgcolor="#9DB5D7">
            <% 
            
            if (dsD!=null) { 
            	String exec = "";
            	int i=0;
            	while(dsD.next()) {
            		if (!exec.equals(dsD.getString("EXECWORK"))) {
            			exec = dsD.getString("EXECWORK");
            %> 
            <% if (i!=0){ %>
	            </table>
	            <br>
	            <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
            <% } %>
              <tr bgcolor="#FFFFFF">
                <td width="" colspan=2 align="left" bgcolor="#DCEDF6"><strong><font color="#003399"><%=exec %> </font></strong></td>
                <td width="120" align="center" bgcolor="#DCEDF6"><%=dsD.getString("PERIOD") %></td>
              </tr>
              </table>
              <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr bgcolor="#FFFFFF">
             	 <td width="120" bgcolor="#D4DCF4"><strong><font color="#003399">추진 배경 </font></strong></td>
                <td colspan=2><%=dsD.getString("DEFINE").replaceAll("\n","<br>") %></td>
              </tr>

              <tr bgcolor="#FFFFFF">
              	<td width="120" bgcolor="#D4DCF4"><strong><font color="#003399">선행 요건 </font></strong></td>
                <td colspan=2><%=dsD.getString("DRVGOAL").replaceAll("\n","<br>") %></td>
              </tr>
              </table>
              <table>
              <tr><td></td></tr>
              </table>
              <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <% } %>
              <tr bgcolor="#FFFFFF">
              	<td width="120" ><%=dsD.getString("DTLNAME").replaceAll("\n","<br>") %></td>
                <td colspan=2><%=dsD.getString("WDEFINE").replaceAll("\n","<br>") %></td>
              </tr>           
              
            <% 
            	i++;
            }
            } %>   
            </table>

</form>
</body>
</html>