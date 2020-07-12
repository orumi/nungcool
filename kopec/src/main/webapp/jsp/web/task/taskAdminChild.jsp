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
	util.setDetailList(request, response);

	String pid = request.getParameter("projectId");

	DataSet ds = (DataSet)request.getAttribute("ds");
	String typeid = (String)request.getAttribute("typeid")==null?"1":(String)request.getAttribute("typeid");
	String msg = (String)request.getAttribute("msg");
	if(msg != null)
	{
		if(msg.equals("false"))
		{
			out.println("<script>");
			out.println("alert('관련 정보가 있어 삭제 할 수 없습니다.');");
			out.println("</script>");
		}
		else
		{
			out.println("<script>");
			out.println("alert('처리 완료 되었습니다.');");
			out.println("</script>");
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<Script>

	var exeWin;
    function openExecWord(tag,projectId,detailId) {

    	if (exeWin!=null) exeWin.close();


		if(parent.detail.form1.pid.value == "") {
		    alert('선택된 프로젝트가 없습니다');
		    return;
		}  else {
				
				var url = "taskAdmin_P.jsp?tag="+tag+"&projectId="+projectId+"&detailId="+detailId ;
			    exeWin = window.open(url, '실행과제추가', 'toolbar=no,Width=600px,Height=650px,scroll=yes,resizable=no,menubar:yes,help=no,status=yes');
			    exeWin.focus();

		}
	}



        var projectDetail = new Array();

        function projectDtl(projectid, stepid, typeid, fieldid, execwork, drvperi, goallev, maindesc, drvmthd, errcnsdr, mgrdept, i) {
		      projectDetail[i] = new projectDtlObj(projectid, stepid, typeid, fieldid, execwork, drvperi, goallev, maindesc, mgrdept);
		}

		function projectDtlObj(projectid, stepid, typeid, fieldid, execwork, drvperi, goallev, maindesc, mgrdept) {
		      this.projectid = projectid;
		      this.stepid = stepid;
		      this.typeid = typeid;
		      this.fieldid = fieldid;
		      this.execwork = execwork;
		      this.drvperi = drvperi;
		      this.goallev = goallev;
		      this.maindesc = maindesc;
		      this.mgrdept = mgrdept;
		}



		function projectDtlCho() {
		      for(var i=0; i < projectDetail.length; i++)  {
		            alert(projectDetail[i].projectid);
		      }
		}



       function delItem(pid,did) {
       		if (confirm("선택한 항목을 삭제하시겠습니까?")) {
	          	form1.projectId.value=pid;
	          	form1.detailId.value=did;
	          	form1.mode.value="D";
	          	form1.submit();
          	}
       }
	  function paCall() {
	  	openExecWord('C','<%=pid %>','-1','-1');
	  }

    function openChildPop(did, sqtr, eqtr, syear, eyear) 
    {
   		var exeWin;
		var url = "taskAdmin_Pc.jsp?syear="+syear+"&eyear="+eyear+"&did="+did+"&sqtr="+sqtr+"&eqtr="+eqtr;
	    exeWin = window.open(url, '세부실행과제추가', 'toolbar=no,Width=600px,Height=650px,scroll=yes,resizable=no,menubar=no,help=no,status=yes');
	    exeWin.focus();
	}
      </Script>

<body>
		<form name="form1" method="post" action="">
              <input type="hidden" name="mode" value="">
              <input type="hidden" name="projectId" value="">
              <input type="hidden" name="detailId" value="">
				
              <input type="hidden" name="execWork">
              <input type="hidden" name="sYear" value="">
              <input type="hidden" name="sQtr" value="">
              <input type="hidden" name="eYear" value="">
              <input type="hidden" name="eQtr" value="">
              <input type="hidden" name="mgr" value="">
              <input type="hidden" name="define" value="">
              <input type="hidden" name="drvgoal" value="">
              <input type="hidden" name="dept" value="">
              <input type="hidden" name="budget" value="">
              <input type="hidden" name="manhour" value="">
              <input type="hidden" name="mng_no" value="">
              <input type="hidden" name="link" value="">
              
            <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">

            <tr bgcolor="#D4DCF4">
            	<td align="center" width="3%" bgcolor="#D4DCF4"><strong><font color="#003399">ID</font></strong></td>
                <td align="center" width="22%"><strong><font color="#003399">과제명</font></strong></td>
                <td align="center" width="15%"><strong><font color="#003399">기간(년/분기)</font></strong></td>
                <td align="center" width="26%"><strong><font color="#003399">추진 배경</font></strong></td>
                <td align="center" width="14%"><strong><font color="#003399">주관 부서</font></strong></td>
                <td align="center" width="8%"><strong><font color="#003399">주요<BR>추진내용</font></strong></td>
                <td align="center" width="5%"><strong><font color="#003399">LINK</font></strong></td>
                <td align="center" width="7%"><strong><font color="#003399">삭제</font></strong></td>
			</tr>
<%
      if(ds != null)   {
		while(ds.next()) {
			String convStr=ds.isEmpty("EXECWORK")?"":ds.getString("EXECWORK");
			String convMain=ds.isEmpty("DEFINE")?"":ds.getString("DEFINE");

			if(convStr.length() >= 18)
				convStr = convStr.substring(0,12).trim() + "...";
			         	  
			if(convMain.length() >= 23)
				convMain = convMain.substring(0,18).trim() + "...";
			
			String link = ds.getString("LINKURL")==null?"":ds.getString("LINKURL");
%>					

              <tr bgcolor="#FFFFFF">
                <td align="center"><%=ds.getString("DETAILID")%></td>
                <td width="250" title="<%=ds.getString("EXECWORK") %>"><a href="javascript:openExecWord('G','<%=ds.getString("PROJECTID") %>','<%=ds.getString("DETAILID") %>');">
<%
						out.println(convStr);
%>
				</a>
				</td>
 				<td align="center"><%=ds.getString("PERIOD")%></td>
                <td width="250" ><%=convMain%></td>
                <td widtn="150" align="center"><%=ds.isEmpty("DNAME")?"":ds.getString("DNAME")%></td>
<%			if(typeid.equals("1")){ %> 
                <td align="center" width="100"><a href="javascript:openChildPop('<%=ds.getString("DETAILID")%>','<%=ds.getString("sqtr")%>','<%=ds.getString("eqtr")%>','<%=ds.getString("syear")%>','<%=ds.getString("eyear")%>');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" alt="세부실행계획" width="21" height="20" border="0" align="absmiddle"></a></td>
<%			} %>
<%			if(link.equals("")){ %> 
                <td width="250" align="center">&nbsp;</td>
<%			}else{ %>
				 <td width="250" align="center"><a href="<%=ds.getString("LINKURL")%>" target="_blank">LINK</a></td>
<%			} %>             
                <td align="center"><a href="javascript:delItem(<%=ds.getString("PROJECTID")%>,'<%=ds.getString("DETAILID")%>');"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a></td>
              </tr>
<%   	}

      } else {
%>
             <tr bgcolor="#FFFFFF">
               <td colspan=8 align="center">등록된 데이터가 없습니다.</td>
             </tr>
<%
      }
%>
            </table>

		</form>
</body>
</html>