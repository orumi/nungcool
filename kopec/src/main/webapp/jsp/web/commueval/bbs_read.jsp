<%@ page language    = "java"
    contentType = "text/html; charset=euc-kr"
    import      = "java.util.*,
                   java.io.*,                   
                   com.nc.util.*,
                   com.nc.commu.*
                   "
%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	String groupId = (String) session.getAttribute("groupId");
	String userName = (String) session.getAttribute("userName");
	String userId = (String) session.getAttribute("userId");
%>
<% 	if (userId == null || ("".equals(userId))) {%>
<script language="javascript">
<!--
		var id = "<%=userId%>";
		var sure;
		if(id == "null" || id == "")	{
			alert("다시 로그인접속하여 주십시오.");
			top.location.href = "../loginProc.jsp";
		}
//-->
</script>
<%	}%>
<%
	/**********************
	String tableName 	= request.getParameter("tableName") == null ? "TBLPUBLICBOARD" : (request.getParameter("tableName")).trim();
	**********************/
	String div_cd 		= request.getParameter("div_cd") == null ? "1" : (request.getParameter("div_cd")).trim();
	String seq			= request.getParameter("seq") == null ? "1" : (request.getParameter("seq")).trim();
	String currentPage	= request.getParameter("currentPage") == null ? "1" : (request.getParameter("currentPage")).trim();
	String keyWord		= request.getParameter("keyWord") == null ? "" : (request.getParameter("keyWord")).trim();
	String searchCode	= request.getParameter("searchCode") == null ? "" : (request.getParameter("searchCode")).trim();
 
	String qstnSeq 		= request.getParameter("qstnSeq") == null ? "" : (request.getParameter("qstnSeq")).trim();
    String ansrSeq 		= request.getParameter("ansrSeq") == null ? "" : (request.getParameter("ansrSeq")).trim();
    String depth 		= request.getParameter("depth") == null ? "" : (request.getParameter("depth")).trim();
       
    String getUserName	= "";
    String getTitle		= "";
    String getEmail		= "";
    String getContent	= "";
    String getFilePath	= ""; 
    String getFiles		= "";
	String spFiles[];
	String vwFiles		= "";
    String getQstnseq	= "";
    String getAnsrseq	= "";
    String getDepth		= "";
    String getRegir		= "";
    String tblGbn		= "";
    
    boolean isWritable = false;
	if (session != null && (session.getAttribute("userId") != null)) {
		isWritable = true;
	}else	{
		isWritable = false;
	}
	
	if(div_cd.equals("0"))	{
		if(!groupId.equals("1"))	{
			isWritable = false;
		}
	}

/*
    if(div_cd.equals("1"))	{
    	tblGbn = "공지사항";
    }else if(div_cd.equals("2"))	{
    	tblGbn = "Q & A";
    }else if(div_cd.equals("3"))	{
    	tblGbn = "자료실";
    }
*/

if(div_cd.equals("0"))	{
	tblGbn = "공지사항";
}else if(div_cd.equals("1"))	{
	tblGbn = "한전경영평가자료";
}else if(div_cd.equals("2"))	{
	tblGbn = "내부평가자료";
}else if(div_cd.equals("3"))	{
	tblGbn = "경영정보공유 회의자료";
}

	CommuBoard cB = new CommuBoard();
	cB.setCommuBoardRead(request, response, userId, div_cd, seq); 
	
	DataSet ds1 = (DataSet) request.getAttribute("ds");
	
	if(ds1 != null)	{
		if(ds1.getRowCount() > 0)	{
   			while (ds1.next()) {
   			    getUserName	= ds1.getString("USERNAME");
   			    getTitle	= ds1.getString("TITLE");
   			 	getEmail	= ds1.getString("EMAIL");
   			    getContent	= ds1.getString("CONTENT");
   			    getFilePath	= ds1.getString("FILEPATH");
   			    getFiles	= ds1.getString("FILES");
   			 	getQstnseq	= ds1.getString("QSTNSEQ");
   			 	getAnsrseq	= ds1.getString("ANSRSEQ");
   			 	getDepth	= ds1.getString("DEPTH");
   			 	getRegir	= ds1.getString("REGIR");
   			 	
   			 	if(getEmail	== null)	{
   			 		getEmail = "";
   			 	}

				/*
   			 	if(getFiles != null)	{
					if(getFiles.length() > 0)	{
						spFiles = getFiles.split("/");
						vwFiles = spFiles[spFiles.length-1];
					}
				}
				*/

   			 	if(getFiles	== null)	{
   			 		vwFiles = "첨부된 파일이 없습니다";
   			 	}
   			 	
   			 	getContent = getContent.replaceAll("<","&lt;");
   			 	getContent = getContent.replaceAll(">","&gt;");
   			 	//getContent = getContent.replaceAll("\"",&quot;");
   			 	getContent = getContent.replaceAll("&","&amp;");
   			 	getContent = getContent.replaceAll("\n","<br>");
   			}
		}
	}
%>
<HTML>
<HEAD>
<TITLE><%=tblGbn%> 상세조회</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="javascript">
function list(check)
{
    document.forms[0].action="board.html?color=3&check="+check;
    document.forms[0].submit();
}
function checkForm(tableName) {
    var submitChk = true;
    /*
    if (document.forms[0].name.value == 0) {
        alert("글쓴이를 입력하세요");
        submitChk = false;
        document.forms[0].name.focus();
    }
    */
    if (document.forms[0].title.value == 0) {
        alert("제목을 입력하세요");
        submitChk = false;
        document.forms[0].title.focus();
    }
    if (document.forms[0].content.value == 0) {
        alert("내용을 입력하세요");
        submitChk = false;
        document.forms[0].content.focus();
    }
    /*
    if (document.forms[0].email.value != 0) { 
        var mail;
        mail = document.forms[0].email.value;      
        ans = mail.indexOf("@",0);
        ans2 = mail.indexOf(".",0);         
        if (ans==-1 || ans==0 || ans2 ==0 || ans2==-1 ||ans2 ==1 || ans2==2) {
            alert("올바른 메일주소가 아닙니다.")
            document.forms[0].email.focus();
            return false;
        }
    }
    */

    return submitChk;
//    document.forms[0].action="board_write_complete.jsp?tableName="+tableName;
    //document.forms[0].submit();
}

function goSave()	{
	document.WRITE.tag.value = "C";
	if(checkForm('<%=div_cd%>'))	{
		document.WRITE.submit();
	}
}

function goList()	{
	document.WRITE.tag.value = "C";
	if(checkForm('<%=div_cd%>'))	{
		document.WRITE.submit();
	}
}

function goDelete(goUrl)	{
	if(confirm("삭제하시겠습니까?"))	{
		document.firm.action = goUrl;
		document.firm.target = "if_xbox";
		document.firm.submit();
	}else	{
		return;
	}
}
</script>
</HEAD>
<BODY leftmargin="0" topmargin="0">

<table width="100%" height="26" cellspacing="0" cellpadding="0" border="0">
	<tr> 
		<td width="1%" height="26"></td>
		<td width="98%" height="26">
			<img src="<%=imgUri %>/jsp/admin/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
			<span class="Text01"><%=tblGbn%> 상세조회</span>
		</td>
		<td width="1%" height="26"></td>
	</tr>
</table>	

<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td width="1%" height="3"></td>
		<td width="98%" height="3" bgcolor="#699FDB"></td>
		<td width="1%" height="3"></td>
	</tr>
</table>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#A4CBE3">
<form action="bbs_write.jsp" method="POST" name="WRITE" enctype="multipart/form-data">
<input type="hidden" name="div_cd" value="<%=div_cd%>">
<input type="hidden" name="currentPage" value="<%=currentPage%>">
<input type="hidden" name="seq" value="">
<input type="hidden" name="tag" value="">
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">글쓴이</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10"><%=getUserName%></td>
	</tr>
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">제목</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10">
			<%=getTitle%>
		</td>
	</tr>
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">E-mail</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10">
			<a href="mailto:<%=getEmail%>"><%=getEmail%></a>
		</td>
	</tr>
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">첨부파일</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10">
		<%
			if(getFiles != null)	{
				if(getFiles.length() > 0)	{
		%>
				<a href='#'><img src="<%=imgUri %>/jsp/web/images/icon_file.gif" onClick="download('<%=getFiles%>');"></a>
				<%=getFiles%>
		<%		}else	{%>
				첨부된 파일이 없습니다
		<%
				}
			}else	{
		%>
				첨부된 파일이 없습니다
		<%}%>
		</td>
	</tr>
	<tr>
		<td width="15%" height="270" bgcolor="#DCEDF6" align="center">내용</td>
		<td width="85%" height="270" bgcolor="#FFFFFF" style="padding-left:10;padding-top:10">
			<table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" height="100%" valign="top">
						<%=getContent%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td width="100%" height="10" align="center"></td>
	</tr>
</table>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td width="1%" height="3"></td>
		<td width="98%" height="3" bgcolor="#699FDB"></td>
		<td width="1%" height="3"></td>
	</tr>
</table>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
	<tr bgcolor="#DCEDF6">
		<td width="100%" height="30" align="right" bgcolor="#FFFFFF">
			<a href="bbs_list.jsp?div_cd=<%=div_cd%>&currentPage=<%=currentPage%>&keyWord=<%=keyWord%>&searchCode=<%=searchCode%>"><img src="../images/btn_list.gif" border="0"></a>
			<!--<a href="javascript:goSave();"><img src="../images/btn_save.gif" border="0"></a>-->
<%	
			if(isWritable == true)	{ 
				if(getRegir.equals(userId))	{ 
%>
			<% if ( ("4".equals(div_cd))||("5".equals(div_cd)) ) {%>
			<a href="bbs_reply.jsp?div_cd=<%=div_cd%>&currentPage=<%=currentPage%>&seq=<%=seq%>&tag=U&keyWord=<%=keyWord%>&searchCode=<%=searchCode%>&tag=R&qstnSeq=<%=getQstnseq%>&ansrSeq=<%=getAnsrseq %>&depth=<%=getDepth %>"><img src="../images/btn_reply.gif" border="0"></a>
			<% } %>
			<a href="bbs_write.jsp?div_cd=<%=div_cd%>&currentPage=<%=currentPage%>&seq=<%=seq%>&tag=U&keyWord=<%=keyWord%>&searchCode=<%=searchCode%>"><img src="../images/btn_edit.gif" border="0"></a>
			<!--<a href="bbs_delete_complete.jsp?div_cd=<%//=div_cd%>&currentPage=1&seq=<%//=seq%>&tag=D" target="if_xbox"><img src="../images/btn_delete.gif" border="0"></a>-->
			<a href="javascript:goDelete('bbs_delete_complete.jsp?div_cd=<%=div_cd%>&currentPage=1&seq=<%=seq%>&tag=D');"><img src="../images/btn_delete.gif" border="0"></a>
<%	
				} else if(groupId.equals("1"))	{
					%>
					<% if ( ("4".equals(div_cd))||("5".equals(div_cd)) ) {%>
					<a href="bbs_reply.jsp?div_cd=<%=div_cd%>&currentPage=<%=currentPage%>&seq=<%=seq%>&tag=U&keyWord=<%=keyWord%>&searchCode=<%=searchCode%>&tag=R&qstnSeq=<%=getQstnseq%>&ansrSeq=<%=getAnsrseq %>&depth=<%=getDepth %>"><img src="../images/btn_reply.gif" border="0"></a>
					<%} %>
					<a href="javascript:goDelete('bbs_delete_complete.jsp?div_cd=<%=div_cd%>&currentPage=1&seq=<%=seq%>&tag=D');"><img src="../images/btn_delete.gif" border="0"></a>
	<%					
				}
			}else	{
				if(groupId.equals("1"))	{
%>
				<% if ( ("4".equals(div_cd))||("5".equals(div_cd)) ) {%>
				<a href="bbs_reply.jsp?div_cd=<%=div_cd%>&currentPage=<%=currentPage%>&seq=<%=seq%>&tag=U&keyWord=<%=keyWord%>&searchCode=<%=searchCode%>&tag=R&qstnSeq=<%=getQstnseq%>&ansrSeq=<%=getAnsrseq %>&depth=<%=getDepth %>"><img src="../images/btn_reply.gif" border="0"></a>
				<%} %>
				<a href="javascript:goDelete('bbs_delete_complete.jsp?div_cd=<%=div_cd%>&currentPage=1&seq=<%=seq%>&tag=D');"><img src="../images/btn_delete.gif" border="0"></a>
<%					
				}
			}
%>
		</td>
	</tr>
</table>
<form method="POST" name="firm">
	<input type="hidden" name="tmpFileName" value="<%=getFiles%>">
</form>
<form name="downForm" method="post" action="download.jsp">
	<input type="hidden" name="fileName">
</form>
<script language=javascript>
	function download(filename){
		
		if(confirm("본 문서는 한국전력기술㈜의 비밀, 재산적 정보를 포함하며 한국전력기술㈜의 사전 서면 승인된 경우를 제외하고는 일체의 복사, 복제, 공개, 제공 및/또는 사을 금합니다.\n\nTHIS DOCUMENT CONTAINS CONFIDENTIAL AND PROPRIETARY INFORMATION OF KEPCO ENGINEERING & CONSTRUCTION CO.,INC. (“KEPCO E&C”) AND MAY NOT BE COPIED, REPRODUCED, DISCLOSED, TRANSFERRED AND/OR USED IN THE WHOLE OR IN PART EXCEPT IN ACCORDANCE WITH PRIOR WRITTEN APPROVAL OF KEPCO E&C.")){
			downForm.fileName.value=filename;
			downForm.submit();	
		}
		
	}
//-->
</script>
<iframe name="if_xbox" style="width=100%;display:none"></iframe>
</BODY>
</HTML>
