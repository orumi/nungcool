<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 
>-------------- 수정 사항  --------------<
수정일 : 2007.07.05 수정자 : 조영훈 


 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.renov.*" %>
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
	}



	request.setCharacterEncoding("euc-kr");

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	RenovWorkMgr util = new RenovWorkMgr();

	util.setDetailList(request, response);

	String pid = request.getParameter("pid");

	DataSet ds = (DataSet)request.getAttribute("ds");
	
	String proc = (String)request.getAttribute("msg");
	
	if(proc != null)
		if(proc.equals("ok"))
		{
			out.print("<script>");
			out.print("parent.openDetail();");
			out.print("</script>");			
		}
		else if(proc.equals("fail"))
		{
			out.print("<script>");
			out.print("alert('관련 정보가 있어 삭제할수 없습니다.');");
			out.print("</script>");	
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

	function parentReload(pid, pnm)
	{
		parent.list.openDetail(pid, pnm);
		parent.openDetail();
	}
	
    function openExecWord(tag, pid, did) {

    	if (exeWin!=null) exeWin.close();


		if(parent.detail.form1.pid.value == "") {
		    alert('선택된 혁신과제가 없습니다');
		    return;
		} else {
			var url = "renovWork_P.jsp?tag="+tag+"&pid="+pid+"&did="+did ;
		    exeWin = window.open(url, '세부실행과제추가', 'toolbar=no,width=600,height=650,scrollbars=yes,resizable=no,menubar=no,status=no');
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
	          	form5.pid.value=pid;
	          	form5.did.value=did;
	          	form5.mode.value="D";
	          	form5.submit();
          	}
       }


      </Script>

<body>
		<form name="form5" method="post" action="">
              <input type="hidden" name="pid" value="">
              <input type="hidden" name="mode" value="">
              <input type="hidden" name="did" value="">

              <input type="hidden" name="execWork">
              <input type="hidden" name="sid" value="">
              <input type="hidden" name="sYear" value="">
              <input type="hidden" name="sQtr" value="">
              <input type="hidden" name="eYear" value="">
              <input type="hidden" name="eQtr" value="">
              <input type="hidden" name="mgr" value="">
              <input type="hidden" name="goalLev" value="">
              <input type="hidden" name="mainDesc" value="">
              <input type="hidden" name="drvMthd" value="">
              <input type="hidden" name="errcnsdr" value="">
<!-- 
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
          			 	<tr>
			                <td height="30" align="right">
			                	<a href="javascript:openExecWord('C','<%//=pid %>','','');"><img src="<%=imgUri %>/jsp/web/images/btn_add_kwaje.gif" alt="실행과제추가" width="84" height="20" border="0"></a>
			                </td>
           				</tr>
         	</table>
-->
            <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id="listTbl">
<!-- 			<tr>
  				<td height="30" colspan="8" bgcolor="#FFFFFF"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
   	 			실행계획(추진계획) 리스트</strong>&nbsp;&nbsp;&nbsp;
   	 			<a href="javascript:openExecWord('C','<%//=pid %>','','');"><img src="<%=imgUri %>/jsp/web/images/btn_add_kwaje.gif" align="absmiddle" alt="실행과제추가" width="84" height="20" border="0"></a>
   	 			</td>
   	 		</tr>
-->
            <tr bgcolor="#D4DCF4">
                <td align="center" width="21%"><strong><font color="#003399">세부추진업무계획</font></strong></td>
                <td align="center" width="28%"><strong><font color="#003399">내용</font></strong></td>
                <td align="center" width="15%"><strong><font color="#003399">부서</font></strong></td>
                <td align="center" width="10%"><strong><font color="#003399">담당자</font></strong></td>
                <td align="center" width="8%"><strong><font color="#003399">삭제</font></strong></td>
			</tr>

<%
      if( ds != null)   {
                  while(ds.next()) {
					String renoNm = ds.isEmpty("RENOVDTLNAME")?"":ds.getString("RENOVDTLNAME");
					String renoDesc = ds.isEmpty("RENOVDTLDESC")?"":ds.getString("RENOVDTLDESC");
					if(renoNm.length() >= 20)
						renoNm = renoNm.substring(0,17).trim() + "...";					
					if(renoDesc.length() >= 20)
						renoDesc = renoDesc.substring(0,17).trim() + "...";					
%>
              <tr bgcolor="#FFFFFF">
                <td width="21%" title="<%=ds.isEmpty("RENOVDTLNAME")?"":ds.getString("RENOVDTLNAME") %>>"><a href="javascript:openExecWord('U', '<%=ds.isEmpty("RENOVID")?"":ds.getString("RENOVID") %>', '<%=ds.isEmpty("RENOVDTLID")?"":ds.getString("RENOVDTLID") %>');"><%=renoNm%></a></td>
                <td widtn="28%" align="left"><%=renoDesc%></td>
                <td align="center" width="15%"><%=ds.isEmpty("DEPTNM")?"":ds.getString("DEPTNM")%></td>
                <td align="center" width="10%"><%=ds.isEmpty("USERNM")?"":ds.getString("USERNM")%></td>
                <td align="center" width="8%"><a href="javascript:delItem('<%=ds.getString("RENOVID")%>','<%=ds.getString("RENOVDTLID")%>');"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a></td>
              </tr>
<%                }

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