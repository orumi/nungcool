<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 2007.07.10
>-------------- 수정 사항  --------------<
수정일 : 


 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.renov.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
    request.setCharacterEncoding("euc-kr");

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));



	RenovMgr userinfo = new RenovMgr();
	userinfo.getUserInfo(request, response);

	String msg = (String) request.getAttribute("msg")==null?"":(String) request.getAttribute("msg");
    StringBuffer userC = new StringBuffer();
    StringBuffer deptC = new StringBuffer();

    //-- 추가, 수정 했을때 처리한 부서id, 담당자id 를 다시 가져온다.
    String reqUser = (String)request.getAttribute("reqUser")==null?"":(String)request.getAttribute("reqUser");
    String reqDept = (String)request.getAttribute("reqDept")==null?"":(String)request.getAttribute("reqDept");
    
    String proc = (String)request.getAttribute("proc");
    
    
    
    DataSet user = (DataSet)request.getAttribute("user");
    DataSet dept = (DataSet)request.getAttribute("dept");
    
    
    String pname = "";
    String type = "";
    String field = "";
    String pDesc = "";
    String pgDesc = "";
    String pid = "";


	if(proc != null)
		if(proc.equals("ok"))
		{
			out.print("<script>");
			out.print("parent.list.location.reload();");
			out.print("</script>");			
		}

	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.')");
		out.print("top.location.href='../loginProc.jsp'");
		out.print("</script>");
	}
	
	if(!msg.equals(""))
	{
		out.print("<script>");
		out.print("alert('" + msg + "')");
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
<script language="javaScript">
		var userList = new Array();
		
		
		function projectIUD(idx, dtlCnt, achvCnt) {
		}


		function initrsU(userid,username, parent) 
		{
			userList[userList.length] = new userID(userid, username, parent, '1');
		}			
	
		function userID(userid,username, parent, level) 
		{
			this.userid = userid;
			this.username = username;
			this.parent = parent;
			this.level = level;
		}

		function actionPerformed(tag)
		{
			if(form1.mgruser.options[form1.mgruser.selectedIndex].value == '-1')
			{
				alert("담당자를 선택하세요.");
				return;
			}
			if(tag == 'D')
			{
				if(confirm("선택한 항목을 삭제하시겠습니까?"))
				{
					parent.list.refresh=true;
					form1.div.value = tag;
					form1.submit();					
				}
				
			}
			else
			{
				parent.list.refresh=true;
				form1.div.value = tag;
				form1.submit();			
			}

			
		}

		
		
		
		
	function changeDept() 
	{
        var prjCnt = 0; //유형별 프로젝트 카운트
		
		var length = userList.length;

		var parentcode = form1.dept.options[form1.dept.selectedIndex].value;
		
			form1.mgruser.length = 0;
//			form1.mgruser.options[form1.mgruser.length] = new Option('-',-1);
	   		for ( i = 0; i < length; i++ )
	   		{
     	    		if( userList[i].level == '1')
    	    		{
      	    			if ( userList[i].parent == parentcode )
      	    			{
      	    			    prjCnt++;
      	    				form1.mgruser.options[form1.mgruser.length] = new Option(userList[i].username, userList[i].userid);
      	    			}
          			}
       		}


	}
		
</script>

<%
	if(dept != null)
	{
		while(dept.next())
		{
			if(reqDept.equals(dept.getString("id")))
				deptC.append("<option value='"+dept.getString("id")+"' selected>"+dept.getString("name")+"</option>")	;
			else
				deptC.append("<option value='"+dept.getString("id")+"'>"+dept.getString("name")+"</option>")	;
		}
	}


%>

<%
	if(user != null)
	{
		while(user.next())
		{
%>
			<script>
				initrsU('<%=user.getString("userid")%>','<%=user.getString("username")%>', '<%=user.getString("parent")%>');
			</script>
<%
			
			if(reqUser.equals(user.getString("userid")))
			{
				userC.append("<option value='"+user.getString("parent")+"' selected>"+user.getString("username")+"</option>")	;
			}
			else
			{
				userC.append("<option value='"+user.getString("parent")+"'>"+user.getString("username")+"</option>")	;
			}
		}
	}


%>


<body onload="javascript:changeDept()">
			<table width="100%" border="0"  cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
			<form name="form1" method="post" action="">
			<input type="hidden" name="div">
			<input type="hidden" name="pid" value="<%=pid %>">
				<tr>
	                <td width="40%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">부서</font></strong></td>
	                <td width="60%" bgcolor="#FFFFFF" colspan="3">
	                     <select name="dept" style="width:150px;" onChange="javascript:changeDept();">
	                     <%=deptC.toString() %>
	                     </select>
	                </td>
	         	</tr>
	             <tr>
	                <td width="40%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">담당자</font></strong></td>
	                <td bgcolor="#FFFFFF" width="20%">
	                    <select name="mgruser" style="width:150px;">
	                    <%=userC.toString() %>
					    </select>
	                 </td>
	              </tr>
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="4">
	                	<a href="javascript:actionPerformed('I')"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="추가" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('U')"><img src="<%=imgUri %>/jsp/web/images/btn_edit.gif" alt="수정" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('D')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a></td>
	              </tr>
	           </form>
            </table>

</body>
</html>