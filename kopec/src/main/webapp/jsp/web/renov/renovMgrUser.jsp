<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 
>-------------- 수정 사항  --------------<
수정일 : 2007.07.10 수정자 : 조영훈 


 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>


<%
    String userid = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
    request.setCharacterEncoding("euc-kr");





//	DataSet ds = new DataSet();
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	
	if(userid.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.')");
		out.print("top.location.href='../loginProc.jsp'");
		out.print("</script>");
	}


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
	<Script Language="javaScript">
//		var arrOrg1 = new Array();
//		var projectArr = new Array();
//
//
//        function reloadPage(idx)
 //       {
  //          window.location.reload();
//
//            if(idx == "I")
//            {
//                alert("등록 되었습니다.");
//            }
//            else if(idx == "U")
//            {
//                alert("수정 되었습니다.");
//            }
//            else
//            	alert("삭제 되었습니다.");
//
//        }
//
//		function initrs(code,name,parent,level,i)
//		{
//			var rslength = 0;
//			arrOrg1[i] = new orgCD(code,name,parent,level);
//		}
//
//		function projectInfo(projectid, fieldid, typeid, projectname, i)
//		{
//			projectArr[i] = new projectObj(projectid, fieldid, typeid, projectname);
//		}
//
//		function projectObj(projectid, fieldid, typeid, projectname)
//		{
//			this.projectid =       projectid;
//			this.fieldid =         fieldid;
//			this.typeid = 	     typeid;
//			this.projectname =     projectname;
//
//		}
//
//		function orgCD(code,name,parent,level)
//		{
//			this.code = code;
//			this.name = name;
//			this.parent = parent;
//			this.level = level;
//		}
//
//		function typeChange()
//		{
//
//			if(form1.rowCnt.value != "0")
//			{
//				var length = arrOrg1.length;
//
//				var parentcode = form1.typeSelect.options[form1.typeSelect.selectedIndex].value;
//				form1.projectSel.length = 0;
//		   		for ( i = 0; i < length; i++ )
//		   		{
//	      	    		if( arrOrg1[i].level == '1')
//	      	    		{
//	      	    			if(arrOrg1[i].parent == parentcode )
//	      	    			{
//	      	    				form1.projectSel.options[form1.projectSel.length] = new Option(arrOrg1[i].name, arrOrg1[i].code);
//	      	    			}
//	          			}
//	       		}
//			}
//
//		}
//
//		function modiProject()
//		{
//
////			alert(projectArr.length);
//            if(form1.rowCnt.value != "0")
//            {
//            	prjDetail.form2.projectID.value = form1.projectSel.value;
//            	prjDetail.form2.type.value = form1.typeSelect.value;
//            	prjDetail.form2.fieldID.value = form1.fieldSelect.value;
//
//            	prjDetail.form2.submit();
//
//            }
//            else
//            {
//                  alert("프로젝트 데이터가 없습니다.");
//            }
//
//		//	form2.projectDesTxt.value = <%//=project.getString("PROJECTDESC")%>
//
//
//		}
//


//		function stepChange()
//		{
//			if(form5.projectID.value == "")
//				alert("프로젝트를 선택하세요.");
//			else
//			{
//				detail.form5.projectID.value = form5.projectID.value;
//				detail.form5.stepID.value = form5.stepID.value;
//				detail.form5.idx.value= "E";
//				detail.form5.action = "./taskAdminChild.jsp";
//				detail.form5.submit();
//			}
//		}

//		function btnClick()
//		{
//			dlist.openExecWord();
//		}
		
	</Script>


<body>
            <table width="100%" height="100%">
            	<tr>
            		<td  valign="top" height="50%">
            			<table vspace="4">
							<tr bgcolor="#FFFFFF">
	              				<td height="15" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
	               	 				혁신과제 담당자</strong>
	               	 			</td>
							</tr>
            			</table>
	            		<iframe frameborder="0" id="list" src="renovMgrList.jsp" scrolling="auto" style="body" width="100%" height="80%" >&nbsp;</iframe>
	            	</td>
	            	<td valign="top" height="50%">
            			<table vspace="4">
							<tr bgcolor="#FFFFFF">
								<td height="15" colspan="4" bgcolor="#FFFFFF"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				                  	담당자등록</strong>
				                </td>
							</tr>
            			</table>	            	
	            		<iframe frameborder="0" id="detail" src="renovMgrDetail.jsp" style="body" width="100%" height="80%" >&nbsp;</iframe>
	            	</td>
	            </tr>
            </table>

</body>
</html>