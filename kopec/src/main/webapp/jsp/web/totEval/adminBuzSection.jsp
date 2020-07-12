<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.totEval.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%
	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) {
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		return;
	}
    
    
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	ESTAdminUtil util = new ESTAdminUtil();
	util.setDivision(request, response);
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
		function openDetail(id, name)  {
			//alert(pid);
			var frm = form1;
			frm.id.value=id;
			frm.name.value=name;
		}
		
		function actionPerformed(tag){
			if ("C"==tag) {
				if (form1.id.value!="") {
					form1.id.value="";
					form1.name.value="";
				
				} else {
					if (form1.name.value==""){
						alert("입력되지 않은 정보가 있습니다.");
						return;
					}
					
					form1.mode.value=tag;
					form1.submit();
				}
			} else if ("U"==tag) {
				if (form1.id.value=="") {
						alert("수정할 항목을 선택하십시오");
						return;		
				}
			
				if (form1.name.value==""){
						alert("입력되지 않은 정보가 있습니다.");
						return;
				}
				form1.mode.value=tag;
				form1.submit();			
			
			} else if ("D"==tag) {
				if (form1.id.value=="") {
						alert("삭제할 항목을 선택하십시오");
						return;		
				}
				
				if (confirm("선택한 항목을 삭제하시겠습니까?")){
					form1.mode.value=tag;
					form1.submit();
				}
			
			}
		
		
		}

	function parentSend() {
		if (opener!=null){
			opener.form1.mode.value="G";
			opener.form1.submit();		
		}
	}
</script>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onunload="parentSend();">
<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" >
	<tr><td>
				<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
			<form name="form1" method="post" >
			<input type=hidden name=mode>
			<input type=hidden name=id>
				<tr>
	                <td width="30%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">명칭</font></strong></td>
	                <td width="70%" bgcolor="#FFFFFF" colspan="3">
	                    <input name="name" type="text" class="input_box" size="50" >
	                </td>
	         	</tr>
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="4">
	                	<a href="javascript:actionPerformed('C')"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="추가" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('U')"><img src="<%=imgUri %>/jsp/web/images/btn_edit.gif" alt="수정" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('D')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a></td>
	              </tr>
	           </form>
	           </table>
	           
	 </td>
	 <tr><td>
				<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="25%"><strong><font color="#003399">중장기 중점전략부문</font></strong></td>
					</tr>
<%
					if(ds !=null && ds.getRowCount()!=0) {
						while(ds.next()) {
							String dname = ds.isEmpty("NAME")?"":ds.getString("NAME");
%>
	                <tr bgcolor="#FFFFFF">
						<td align="left">
						<a href="javascript:openDetail('<%=ds.getString("ID")%>','<%=ds.getString("NAME")%>');" title="<%=ds.isEmpty("NAME")?"":ds.getString("NAME") %>">
							<%=dname %>						
						</td>
	                </tr>
<%
						}
					}
%>
            </table>
            
      </td></tr>
</table>            
</body>
</html>