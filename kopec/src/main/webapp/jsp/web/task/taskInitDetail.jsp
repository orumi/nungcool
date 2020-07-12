<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%@ page import="com.nc.actual.ActualUtil"%>
<%
	request.setCharacterEncoding("euc-kr");

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
	
	TaskInitiative util = new TaskInitiative();
	//util.setInitMeasure(request, response);
	
	util.setTaskDetail(request, response);
	DataSet ds = (DataSet)request.getAttribute("ds");
	DataSet dsTask = (DataSet)request.getAttribute("dsTask");
	
	String projectId = request.getParameter("projectId")==null?"":request.getParameter("projectId").equals("null")?"":request.getParameter("projectId");
	String detailId = request.getParameter("detailId")==null?"":request.getParameter("detailId").equals("null")?"":request.getParameter("detailId");
	String bscId = request.getParameter("bscId")==null?"":request.getParameter("bscId").equals("null")?"":request.getParameter("bscId");
	String year = request.getParameter("year")==null?"":request.getParameter("year").equals("null")?"":request.getParameter("year");
	
	
	String tName = "";
	String pName = "";
	String dName = "";
	
	if (dsTask!=null) while(dsTask.next()){
		tName = dsTask.getString("TYPENAME");
		pName = dsTask.getString("NAME");
		dName = dsTask.getString("EXECWORK");
	}
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<Script>
	var arrOrg = new Array();

	function initrs(code,name,parent,level) {
		arrOrg[arrOrg.length] = new orgCD(code,name,parent,level);
	}

	function orgCD(code,name,parent,level) {
		this.code = code;
		this.name = name;
		this.parent = parent;
		this.level = level;
	}
	
	function changeType() {
		form1.selProj.length=0;
		var length = arrOrg.length;
		var typeCode = form1.selType.options[form1.selType.selectedIndex].value;
		
		var j=0;
		var cid ;
		for(var i=0;i<length;i++){
			if (arrOrg[i].level==1){
				if (arrOrg[i].parent ==typeCode){
					form1.selProj.options[form1.selProj.length] = new Option(arrOrg[i].name,arrOrg[i].code);
					if(j==0){
						cid = arrOrg[i].code;
						j++;
					}
				}
			}
		}
		
		form1.selField.length=0;
		
		for(var k=0;k<length;k++){
			if (arrOrg[k].level==2){
				if (arrOrg[k].parent == cid){
					form1.selField.options[form1.selField.length] = new Option(arrOrg[k].name,arrOrg[k].code);
				}
			}
		}
		
	}
	
	
	function changeProj() {
		form1.selField.length=0;
		var length = arrOrg.length;
		
		var projCode = form1.selProj.options[form1.selProj.selectedIndex].value;
		
		for (i=0;i<length;i++) {
			if (arrOrg[i].level==2) {
				if (arrOrg[i].parent==projCode) {
					form1.selField.options[form1.selField.length] = new Option(arrOrg[i].name,arrOrg[i].code);
				}
			}
		}
	}

	function actionPerformed(){
		parent.refresh=true;
		form1.mode.value="U";
		form1.submit();
	
	
	}

	function refreshList(){
		if (parent.refresh){
			parent.list.form1.year.value="<%=year %>";
			parent.list.form1.bscId.value="<%=bscId %>";
			parent.list.form1.submit();
			parent.refresh=false;
		}
	}
    
</Script>
<body onload="javascript:refreshList();" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                	과제연계 지표 리스트</strong></td>
            </tr>
       </table>
       <table width="102%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
		<form name="form1" method="post" action="">
              <input type="hidden" name="mode" value="">
              <input type="hidden" name="projectId" value="<%=projectId %>">
              <input type="hidden" name="detailId" value="<%=detailId %>">
              <input type="hidden" name="bscId" value="<%=bscId %>">
			  <input type="hidden" name="year" value="<%=year %>">
              <tr bgcolor="#D4DCF4">
                <td width="80" align="center"><strong><font color="#003399">혁신전략</font></strong></td>
                <td align=left bgcolor="#FFFFFF"><%=tName %></td>
              </tr>
              <tr bgcolor="#D4DCF4">
                <td width="80" align="center"><strong><font color="#003399">Sub전략</font></strong></td>
                <td align=left bgcolor="#FFFFFF"><%=pName %></td>
              </tr>
              <tr bgcolor="#D4DCF4">
                <td width="80" align="center"><strong><font color="#003399">과제</font></strong></td>
                <td align=left bgcolor="#FFFFFF"><%=dName %></td>
              </tr>
              <tr bgcolor="#D4DCF4">
              	<td width="80" align="center"><strong><font color="#003399">지표</font></strong></td>
              	<td bgcolor="#FFFFFF">
              		<div style="overflow-y:auto;width:100%;height:350px;valign:top;">
        			<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">    	
<%
	if(ds != null){
%>
<!---------//좌측  KPI 선택 전청 리스트//-------->
	<% int j=0;
    
    if(ds != null){
        
   		while (ds.next()) {
   			String mName = ((String)ds.getString("MNAME")).trim();
   			String ObjChk = ds.getString("OBJID")==null?"":ds.getString("OBJID");
    %>
		              <tr bgcolor="#FFFFFF">
		                <td id="cell<%=ds.getInt("MCID")%>">
		                	<a style="cursor:hand;">
		                	<font color="#0066FF"><input type=checkbox name="chkObj" value="<%=ds.getString("MCID") %>" <%=ObjChk.equals("")?"":"checked" %> ><%=mName%></font></a></td>
		              </tr>
    <%
    	}	
    	j++;
    %>
<%  } %>
<%}else{ %>
					<tr>
						<td colspan="2" align="center" bgcolor="#ffffff" height="200"><strong><font size=4 color='#cc0000'>&nbsp;</font></strong></td>
					</tr>
<%} %>
				</table>
				</div>
				</td>
        	</tr>
        </table>
        <table width="100%" align="right">
	 	<tr>
	        <td align="right"><a href="javascript:actionPerformed();" ><img src="<%=imgUri %>/jsp/web/images/btn_regi.gif" alt="적용" width="50" height="20" border="0" align="absmiddle" ></a></td>
	  	</tr>
		</table>                   	
</form>
</body>
</html>