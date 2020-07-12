<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,
					com.nc.totEval.*,
					com.nc.util.*"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	String userId = (String)session.getAttribute("userId");

	if (userId == null){ %>
		<script>
			alert("다시 접속하여 주십시오");
		  	top.location.href = "<%=imgUri%>/jsp/web/loginProc.jsp";
		</script>
	<% 
	return;
	}

	ESTAdminUtil util = new ESTAdminUtil();
	util.setAdminBuzMeaDetail(request, response);
	
	
	DataSet dsSec = (DataSet)request.getAttribute("dsSec");
	DataSet dsMea = (DataSet)request.getAttribute("dsMea");
	DataSet dsBSC = (DataSet)request.getAttribute("dsBSC");

%>

<SCRIPT>                                  
    function actionPerformed(mode){
    	var frm = form1;
    	var list = parent.list.listFrm;
     	if (mode == "C"){
     		list.mode.value=mode;
     		list.year.value=parent.form1.year.options[parent.form1.year.selectedIndex].value;
     		list.measure.value = frm.measure.options[frm.measure.selectedIndex].value;
     		list.allot.value = frm.allot.value;
     		list.bscId.value = frm.bscId.options[frm.bscId.selectedIndex].value;
     		list.factor.value = frm.factor.value;
     		list.orderby.value = frm.orderby.value;
     		
     		list.submit();

     	} else if (mode == "U") {

     		list.mode.value=mode;
     		list.year.value=parent.form1.year.options[parent.form1.year.selectedIndex].value;
     		list.measure.value = frm.measure.options[frm.measure.selectedIndex].value;
     		list.allot.value = frm.allot.value;
     		list.bscId.value = frm.bscId.options[frm.bscId.selectedIndex].value;
     		list.factor.value = frm.factor.value;
     		list.orderby.value = frm.orderby.value;
     		list.submit();
     		
     	} else if (mode == "D") {
			if (frm.mid.value.length==0){
     			alert("수정할 지표를 선택하시오");
     			return;
     		}
     		if ( confirm ("선택한 지표를 삭제하시겠습니까?")) {
     		list.mode.value=mode;
     		list.measure.value = frm.measure.options[frm.measure.selectedIndex].value;
     		list.year.value=parent.form1.year.options[parent.form1.year.selectedIndex].value;
     		
     		list.submit();
     		}
     	}
    }

	var WinDetail;
 	function openPopDetail(){
		if (WinDetail!=null) WinDetail.close();
		var url = "adminBuzMeasure.jsp";
		WinApp = window.open(url,"","toolbar=no,width=600,height=400,scrollbars=yes,resizable=yes,menubar=no,status=no" ); 	
 	} 
 	
 	var arrayOrg = new Array();
  
	function initrs(code,name,parent_code,levelgb,i){
	       arrayOrg[i] = new orgCD(code, name, parent_code, levelgb);
	}
	
	function orgCD(code, name, parent_cd, levelgb){
       this.code = code;
       this.name = name;
       this.parent_cd = parent_cd;
       this.levelgb = levelgb;
   	}
    
    function chgOrg(level){ 
    	var length = arrayOrg.length;

    	if ( level == 1 ){ //change level 1
    		
    		var parentcode = form1.section.options[form1.section.selectedIndex].value;
    		
    		form1.measure.length = 0;
    
    		for ( i = 0; i < length; i++ ){
    			if ( arrayOrg[i].levelgb == '1'){
    				if ( arrayOrg[i].parent_cd == parentcode ){
    					form1.measure.options[form1.measure.length] = new Option(arrayOrg[i].name, arrayOrg[i].code);
    				}
    			}
    		}
    
    
    	} 

    }
</SCRIPT>

<%
	StringBuffer sbSec = new StringBuffer();
	StringBuffer sbMea = new StringBuffer();
	
	
	int parent = 0;
	if (dsSec!=null) while (dsSec.next()) {
		if (parent==0) parent = dsSec.getInt("ID");
		sbSec.append("<option value='" + dsSec.getInt("ID") + "'");
		sbSec.append(">");
		sbSec.append(dsSec.getString("NAME"));
		sbSec.append("</option>");	
	}
	int i = 0;
	if (dsMea!=null) while(dsMea.next()){
		%>
		<script>
		initrs('<%=dsMea.getInt("ID")%>','<%=dsMea.getString("NAME")%>','<%=dsMea.getInt("SECTIONID")%>',1,<%=i++%>);
		</script>
		<%		
		if (parent == dsMea.getInt("SECTIONID")) {
			sbMea.append("<option value='" + dsMea.getInt("ID") + "'");
			sbMea.append(">");
			sbMea.append(dsMea.getString("NAME"));
			sbMea.append("</option>");
		} 
	}	

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="8" topmargin="0" marginwidth="0">
<form name="form1" method="post">
<input type=hidden name=mode>
<input type=hidden name=mid>
<input type=hidden name=year>

<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25"><strong> <img
			src="<%=imgUri%>/jsp/web/images/icon_point_00.gif" width="15"
			height="15" align="absmiddle"> 경영지표 세부 내용 </strong></td>
	</tr>
</table>

<!---------//좌측  KPI 선택 전청 리스트//-------->


<table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id='tbl0'>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="10%" ><strong><font color="#003399">평가부문</font></strong></td>
		<td width="20%" bgcolor="#FFFFFF" align=left>
		<select style="width:180px" name=section onchange="chgOrg(1)">
			<%=sbSec.toString()%>
		</select>
		</td>
	</tr>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="10%" ><strong><font color="#003399">지표명</font></strong></td>
		<td width="20%" bgcolor="#FFFFFF" align=left >
		<select style="width:180px" name=measure>
			<%=sbMea.toString() %>
		</select>
		<a href="javascript:openPopDetail();"><img src="<%=imgUri %>/jsp/web/images/btn_detail.gif" alt="추가" width="30" height="20" border="0" align="absmiddle"></a>
		</td>
	</tr>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="10%" ><strong><font color="#003399">배점</font></strong></td>
		<td width="20%" bgcolor="#FFFFFF" align=left><input type="text" name=allot style="width:140px">%</td>
	</tr>		
	<tr align="center" bgcolor="#D4DCF4">
		<td width="10%"><strong><font color="#003399">주관부서</font></strong></td>
		<td width="20%" bgcolor="#FFFFFF" align="left">
		<select style="width:200px" name=bscId>
		<% if(dsBSC!=null) while(dsBSC.next()) { %>
			<option value="<%=dsBSC.getString("ID") %>"><%=dsBSC.getString("NAME") %></option>
		<% } %>
		</select></td>
	</tr>	
	<tr align="center" bgcolor="#D4DCF4">
		<td width="10%"><strong><font color="#003399">평가요소</font></strong></td>
		<td width="20%" height=100 bgcolor="#FFFFFF" align="left">
			<textarea rows=10 cols=40 name="factor"></textarea>
	</tr>
	<tr align="center" bgcolor="#D4DCF4">
		<td width="10%" ><strong><font color="#003399">지표순서</font></strong></td>
		<td width="20%" bgcolor="#FFFFFF" align=left><input type="text" name=orderby style="width:100px"></td>
	</tr>			
</table>
			<table width="100%">
			<tr><td align="right">
			<img src="<%=imgUri%>/jsp/web/images/btn_save.gif" alt="저장" width="50" height="20" border="0" onClick="javascript:actionPerformed('C');" style="cursor:hand">	
			<img src="<%=imgUri%>/jsp/web/images/btn_edit.gif" alt="수정" width="50" height="20" border="0" onClick="javascript:actionPerformed('U');" style="cursor:hand">	
			<img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" onClick="javascript:actionPerformed('D');" style="cursor:hand">							
			</td></tr>
			</table>

</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	var WinDetail;
 	function openDetail(mId,evalrId){
		if (WinDetail!=null) WinDetail.close();
		var yyyy = parent.form1.year.options[parent.form1.year.selectedIndex].value;
		var month = parent.form1.month.options[parent.form1.month.selectedIndex].value;
		var url = "adminValuateDetail.jsp?year="+yyyy+"&month="+month+"&evalrId="+evalrId+"&mId="+mId;
		WinApp = window.open(url,"","toolbar=no,width=700,height=500,scrollbars=yes,resizable=yes,menubar=no,status=no" ); 	
 	}
	
	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}
	
	
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	//mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>
