<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.totEval.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%
	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) {
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		return;
	}
    
    
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	ESTAdminUtil util = new ESTAdminUtil();
	util.setMeasure(request, response);
	DataSet dsS = (DataSet)request.getAttribute("dsS");	//������Ʈ ����Ʈ
	DataSet dsM = (DataSet)request.getAttribute("dsM");

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">
		function openDetail(id, name,sectionId)  {
			//alert(pid);
			var frm = form1;
			frm.id.value=id;
			frm.name.value=name;
			frm.sectionId.value=sectionId;
		}
		
		function actionPerformed(tag){
			if ("C"==tag) {
				if (form1.id.value!="") {
					form1.id.value="";
					form1.name.value="";
				
				} else {
					if (form1.name.value==""){
						alert("�Էµ��� ���� ������ �ֽ��ϴ�.");
						return;
					}
					
					form1.mode.value=tag;
					form1.submit();
				}
			} else if ("U"==tag) {
				if (form1.id.value=="") {
						alert("������ �׸��� �����Ͻʽÿ�");
						return;		
				}
			
				if (form1.name.value==""){
						alert("�Էµ��� ���� ������ �ֽ��ϴ�.");
						return;
				}
				form1.mode.value=tag;
				form1.submit();			
			
			} else if ("D"==tag) {
				if (form1.id.value=="") {
						alert("������ �׸��� �����Ͻʽÿ�");
						return;		
				}
				
				if (confirm("������ �׸��� �����Ͻðڽ��ϱ�?")){
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
	
	var WinDetail;
 	function openPopDetail(){
		if (WinDetail!=null) WinDetail.close();
		var url = "adminBuzSection.jsp";
		WinApp = window.open(url,"","toolbar=no,width=600,height=400,scrollbars=yes,resizable=yes,menubar=no,status=no" ); 	
 	} 	
 	
	function mergeCell(tbl, startRow, cNum, length, add)
	{
		var isAdd = false;
		if(tbl == null) return;
		if(startRow == null || startRow.length == 0) startRow = 1;
		if(cNum == null || cNum.length == 0) return ;
		if(add  == null || add.length == 0) {
			isAdd = false;
		}else {
			isAdd = true;
			add   = parseInt(add);
		}
		cNum   = parseInt(cNum);
		length = parseInt(length);
	
		rows   = tbl.rows;
		rowNum = rows.length;
	
		tempVal  = '';
		cnt      = 0;
		startRow = parseInt(startRow);
	
		for( i = startRow; i < rowNum; i++ ) { 
			curVal = rows[i].cells[cNum].innerHTML;
			if(isAdd) curVal += rows[i].cells[add].innerHTML;
			if( curVal == tempVal ) {
				if(cnt == 0) {
					cnt++;
					startRow = i - 1;
				}
				cnt++;
			}else if(cnt > 0) {
				merge(tbl, startRow, cnt, cNum, length);
				startRow = endRow = 0;
				cnt = 0;
			}else {
			}
			tempVal = curVal;
		}
	
		if(cnt > 0) {
			merge(tbl, startRow, cnt, cNum, length);
		}
	}
	
	function merge(tbl, startRow, cnt, cellNum, length)
	{
		rows = tbl.rows;
		row  = rows[startRow];
	
		for( i = startRow + 1; i < startRow + cnt; i++ ) {
			for( j = 0; j < length; j++) {
				rows[i].deleteCell(cellNum);
			}
		}
		for( j = 0; j < length; j++) {
			row.cells[cellNum + j].rowSpan = cnt;
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
	                <td width="30%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�򰡺ι�</font></strong></td>
	                <td width="70%" bgcolor="#FFFFFF" colspan="3">
	                    <select name=sectionId style="width:200px">
	                    <% if (dsS!=null)while(dsS.next()){ %>
	                    	<option value="<%=dsS.getString("ID") %>"><%=dsS.getString("NAME") %></option>
	                    <% } %>	
	                    </select>
	                    <a href="javascript:openPopDetail();"><img src="<%=imgUri %>/jsp/web/images/btn_detail.gif" alt="�߰�" width="30" height="20" border="0" align="absmiddle"></a>
	                </td>
	         	</tr>
				<tr>
	                <td width="30%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">��Ī</font></strong></td>
	                <td width="70%" bgcolor="#FFFFFF" colspan="3">
	                    <input name="name" type="text" class="input_box" size="50" >
	                </td>
	         	</tr>	         	
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="4">
	                	<a href="javascript:actionPerformed('C')"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="�߰�" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('U')"><img src="<%=imgUri %>/jsp/web/images/btn_edit.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('D')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="����" width="50" height="20" border="0" align="absmiddle"></a></td>
	              </tr>
	           </form>
	           </table>
	           
	 </td>
	 <tr><td>
				<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id="tbl0">
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="25%"><strong><font color="#003399">�򰡺κ�</font></strong></td>
		                <td align="center" width="50%"><strong><font color="#003399">����ǥ</font></strong></td>
					</tr>
<%
					if(dsM !=null && dsM.getRowCount()!=0) {
						while(dsM.next()) {
							String dname = dsM.isEmpty("NAME")?"":dsM.getString("NAME");
%>
	                <tr bgcolor="#FFFFFF">
	                	<td ><%=dsM.getString("SNAME") %></td>
						<td align="left">
						<a href="javascript:openDetail('<%=dsM.getString("ID")%>','<%=dsM.getString("NAME")%>','<%=dsM.getString("SECTIONID") %>');">
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
<script>
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
</script>

