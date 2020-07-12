<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

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

	TaskAdmin util = new TaskAdmin();
	util.setProjectDetail(request, response);

	DataSet dsType = (DataSet)request.getAttribute("dsT");
	DataSet dsDetial = (DataSet)request.getAttribute("ds");

	String msg = (String) request.getAttribute("msg");

    StringBuffer typeLst = new StringBuffer();
    
    String pname = "";
    String type = "";
    String pid = "";
    String typeId = "";
    String refresh = "";
	
    if(dsDetial!=null) while(dsDetial.next()){
		pid = dsDetial.getString("ID"); 
		pname = dsDetial.getString("NAME");
		typeId = dsDetial.getString("TYPEID");
	}

   	if (dsType != null)
    	while(dsType.next()){
   		typeLst.append("<option value='"+dsType.getString("TYPEID")+"'"+((typeId.equals(dsType.getString("TYPEID")))?" selected":"")+ ">"+dsType.getString("TYPENAME")+"</option>" + "\n");
   	}

	if(refresh != null)
	{
	    if(refresh.equals("true"))
		{
			out.print("<script>");
			out.print("alert('처리 완료 되었습니다.');");
//			out.print("window.parent.list.location = window.parent.list.location;");
			out.print("</script>");			
		}
	}    
    if (msg!=null){ %>
  		<script>
  			alert("<%=msg%>");
  		</script>

<%    }

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

		function projectIUD(idx, dtlCnt, achvCnt) {
		}


		function actionPerformed(tag){
			if (tag=="C"){
				if (form1.pid.value==""){
					if (form1.pname.value==""){

						alert("프로젝트 명을 기술하십시오");
						return;
					}

					parent.list.refresh=true;
					form1.mode.value=tag;
					form1.submit();
				} else {
					clearComponent();
				}

			} else if (tag=="U") {
				if (form1.pid.value=="") {
					alert("수정할 목록을 선택하십시오");
					return;
				}
				parent.list.refresh=true;
				form1.mode.value=tag;
				form1.submit();

			} else if (tag=="D") {
				if (form1.pid.value=="") {
					alert("삭제할 목록을 선택하십시오");
					return;
				}
				if (confirm("선택한 항목을 삭제하시겠습니까?")){
					parent.list.refresh=true;
					form1.mode.value=tag;
					form1.submit();
				}

			}
		}

		function clearComponent(){
			form1.pid.value="";
			form1.pname.value="";
		}

		function detailRefresh(){
			//alert(parent.list.refresh);
			if (parent.list.refresh==true){
				window.parent.list.location = window.parent.list.location;
			}
		}
		
	var WinDetail;
 	function openType(){
		if (WinDetail!=null) WinDetail.close();
		var url = "taskAdmin_PType.jsp";
		WinApp = window.open(url,"","toolbar=no,width=600,height=400,scrollbars=yes,resizable=yes,menubar=no,status=no" ); 	
 	}   
		
</script>
<body onload="javascript:detailRefresh();">
			<table width="100%" border="0"  cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">

			<form name="form1" method="post" >
			<input type="hidden" name="mode">
			<input type="hidden" name="pid" value="<%=pid %>">
				<tr>
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">Sub 전략명</font></strong></td>
	                <td width="80%" bgcolor="#FFFFFF" >
	                    <input name="pname" type="text" class="input_box" size="53" value="<%=pname %>">
	                </td>
	         	</tr>
	             <tr>
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">혁신전략명</font></strong></td>
	                <td bgcolor="#FFFFFF" width="20%">
	                    <select name="selType">
	                    <%=typeLst.toString() %>
					    </select> <a href="javascript:openType();"><img src="<%=imgUri %>/jsp/web/images/btn_detail.gif" alt="추가" width="30" height="20" border="0" align="absmiddle"></a>
	                 </td>
	              </tr>
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="2">
	                	<a href="javascript:actionPerformed('C')"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="추가" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('U')"><img src="<%=imgUri %>/jsp/web/images/btn_edit.gif" alt="수정" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('D')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a></td>
	              </tr>
	           </form>
            </table>

</body>
</html>