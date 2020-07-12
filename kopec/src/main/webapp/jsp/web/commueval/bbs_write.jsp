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
	String imgPreUri		= imgUri.substring(0, imgUri.indexOf("/"));
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
	String tableName 	= request.getParameter("tableName");
    if (tableName == null || tableName.equals("null")) tableName = "TBLPUBLICBOARD";
	**********************/
	String div_cd 	= request.getParameter("div_cd");
    if (div_cd == null || div_cd.equals("null")) div_cd = "1";

    String tag 			= request.getParameter("tag") == null ? "C" : (request.getParameter("tag")).trim();
    String seq 			= request.getParameter("seq") == null ? "" : (request.getParameter("seq")).trim();
    String currentPage 	= request.getParameter("currentPage") == null ? "1" : (request.getParameter("currentPage")).trim();
	String keyWord		= request.getParameter("keyWord") == null ? "" : (request.getParameter("keyWord")).trim();
	String searchCode	= request.getParameter("searchCode") == null ? "" : (request.getParameter("searchCode")).trim();

	String qstnSeq 		= request.getParameter("qstnSeq") == null ? "" : (request.getParameter("qstnSeq")).trim();
    String ansrSeq 		= request.getParameter("ansrSeq") == null ? "" : (request.getParameter("ansrSeq")).trim();
    String depth 		= request.getParameter("depth") == null ? "" : (request.getParameter("depth")).trim();
    String tblGbn		= "";
    String tblGbnDtl	= "";

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

    if(tag.equals("C"))	{
    	tblGbnDtl = "등록";
    }else if(tag.equals("U"))	{
    	tblGbnDtl = "수정";
    }else if(tag.equals("R"))	{
    	tblGbnDtl = "답변";
    }

    String getUserName	= "";
    String getUserEmail	= "";
    String getEmail		= "";
    String getTitle		= "";
    String getContent	= "";
    String getFiles		= "";
	String spFiles[];
	String vwFiles		= "";

    if(tag.equals("U") || tag.equals("R"))	{
   		CommuBoard cB = new CommuBoard();
		/**********************
    	//cB.setCommuBoardRead(request, response, userId, tableName, seq);
		**********************/
    	cB.setCommuBoardRead(request, response, userId, div_cd, seq);

    	DataSet ds1 = (DataSet) request.getAttribute("ds");

    	if(ds1 != null)	{
    		if(ds1.getRowCount() > 0)	{
       			while (ds1.next()) {
       			    getUserName		= ds1.getString("USERNAME");
       			    getUserEmail	= ds1.getString("USEREMAIL");
       			    getEmail		= ds1.getString("EMAIL");
       			    getTitle		= ds1.getString("TITLE");
       			    getContent		= ds1.getString("CONTENT");
       			    getFiles		= ds1.getString("FILES");

       			    if(getUserEmail == null)	{
       			    	getUserEmail = "";
       			    }

					if(getFiles != null)	{
						if(getFiles.length() > 0)	{
							spFiles = getFiles.split("/");
							vwFiles = spFiles[spFiles.length-1];
						}
					}
       			}
    		}
    	}
    }

    if(vwFiles.length() < 1)	{
    	vwFiles = "첨부된 파일이 없습니다";
    }
%>
<HTML>
<HEAD>
<TITLE><%=tblGbn%> <%=tblGbnDtl%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="javascript">
function list(check)
{
    document.forms[0].action="board.html?color=3&check="+check;
    document.forms[0].submit();
}
function checkForm(div_cd) {
    var submitChk = true;
    /*
    if (document.forms[0].name.value == 0) {
        alert("글쓴이를 입력하세요");
        submitChk = false;
        document.forms[0].name.focus();
    }
    */
    if (document.forms[0].title.value.replace(/(^ *)|( *$)/g, "") == "") {
        alert("제목을 입력하여 주십시오");
        submitChk = false;
        document.forms[0].title.focus();
        return;
    }
    /*
    if (document.forms[0].email.value.replace(/(^ *)|( *$)/g, "") == "") {
        alert("E-mail을 입력하여 주십시오");
        submitChk = false;
        document.forms[0].email.focus();
        return;
    }
    if (document.forms[0].email.value.replace(/(^ *)|( *$)/g, "") != "") {
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
    if (document.forms[0].content.value.replace(/(^ *)|( *$)/g, "") == "") {
        alert("내용을 입력하여 주십시오");
        submitChk = false;
        document.forms[0].content.focus();
        return;
    }

    return submitChk;
//    document.forms[0].action="board_write_complete.jsp?tableName="+tableName;
    //document.forms[0].submit();
}

function goSave()	{
	var confirmMsg = "";
	document.WRITE.tag.value = "<%=tag%>";
	if(document.WRITE.tag.value == "C")	{
		confirmMsg = "등록";
	}else if(document.WRITE.tag.value == "U")	{
		confirmMsg = "수정";
	}else if(document.WRITE.tag.value == "R")	{
		confirmMsg = "답변";
	}

	if (confirm(confirmMsg+"하시겠습니까?")) {
		if(document.WRITE.tag.value == "U")	{
			document.WRITE.seq.value = "<%=seq%>";
		}else	{
			document.WRITE.seq.value = "";
		}
		if(checkForm('<%=div_cd%>'))	{
		/*
			alert(document.WRITE.qstnSeq.value);
			alert(document.WRITE.ansrSeq.value);
		*/
			document.WRITE.submit();
		}
	}else	{
		return;
	}
}

function goList()	{
	var getDiv_cd 	= "<%=div_cd%>";
	var getCurrentPage 	= "<%=currentPage%>";
	var getKeyWord 		= "<%=keyWord%>";
	var getSearchCode	= "<%=searchCode%>";
	location.href = "bbs_list.jsp?div_cd="+getDiv_cd+"&currentPage="+getCurrentPage+"&keyWord="+getKeyWord+"&searchCode="+getSearchCode;
}

	function actionDeleteFile(){
		if (confirm("선택한 파일을  삭제하시겠습니까? ")){
			//parent.refresh = true;
			document.WRITE.tag.value = "FD";
			document.WRITE.seq.value = "<%=seq%>";
			//detailForm.schDate.value = parent.form1.year.options[parent.form1.year.selectedIndex].value+parent.form1.month.options[parent.form1.month.selectedIndex].value;
			document.WRITE.submit();
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
			<span class="Text01"><%=tblGbn%> <%=tblGbnDtl%></span>
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
<form action="bbs_write_complete.jsp" method="POST" name="WRITE" enctype="multipart/form-data">
<input type="hidden" name="div_cd" value="<%=div_cd%>">
<input type="hidden" name="tag">
<input type="hidden" name="seq">
<input type="hidden" name="imgPreUri">
<input type="hidden" name="fileChk" value="1">
<%	if(tag.equals("R") || tag.equals("U"))	{%>
<input type="hidden" name="qstnSeq" value="<%=qstnSeq%>">
<input type="hidden" name="ansrSeq" value="<%=ansrSeq%>">
<input type="hidden" name="depth" value="<%=depth%>">
<input type="hidden" name="keyWord" value="<%=keyWord%>">
<input type="hidden" name="searchCode" value="<%=searchCode%>">
<input type="hidden" name="currentPage" value="<%=currentPage%>">
<%
		if(getFiles != null)	{
			if(getFiles.length() > 1)	{
%>
<input type="hidden" name="tmpFileName" value="<%=getFiles%>">
<%
			}
		}
	}
%>
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">제목</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10">
			<input  name="title" type="text" class="form1" id="title22" maxlength="100" size="100" <%if(tag.equals("U") || tag.equals("R")) {%><%if(tag.equals("R")) {%>value="[답변] <%=getTitle%>"<%}else {%>value="<%=getTitle%>"<%}%><%}%>>
		</td>
	</tr>
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">작성자</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10"><%if(tag.equals("U")) {%><%=getUserName%><%}else {%><%=userName%><%}%></td>
	</tr>
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">E-mail</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10">
			<input  name="email" type="text" class="form1" id="email22" maxlength=100 size=30 value="<%if(tag.equals("U")) {%><%=getEmail%><%}else {%><%=getUserEmail%><%}%>">
		</td>
	</tr>
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">첨부파일</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10">
			<input name="file" type="file" class="form1" id="email22" size="42" maxlength="150">
			<%
				if(tag.equals("U"))	{
					if(getFiles != null)	{
						if(getFiles.length() > 1)	{
			%>
			[ 기존파일 : <%=vwFiles%> ]
			<a href='#'><img src="<%=imgUri %>/jsp/web/images/btn_file_delete.gif" onClick="actionDeleteFile();" align="absmiddle"></a>
			<%
						}
					}
				}
			%>
		</td>
	</tr>
	<tr>
		<td width="15%" height="30" bgcolor="#DCEDF6" align="center">내용</td>
		<td width="85%" height="30" bgcolor="#FFFFFF" style="padding-left:10">
			<textarea name="content" cols="100" rows="16" class="form1" id="textarea3"><%if(tag.equals("U")) {%><%=getContent%><%}%></textarea>
		</td>
	</tr>
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
			<%if(!tag.equals("U"))	{%>
			<a href="javascript:goSave();"><img src="../images/btn_save.gif" border="0"></a>
			<%}%>
			<%if(tag.equals("U"))	{%>
			<a href="javascript:goSave();"><img src="../images/btn_edit.gif" border="0"></a>
			<%}%>
			<a href="javascript:goList();"><img src="../images/btn_list.gif" border="0"></a>
		</td>
	</tr>
</table>
<iframe name="if_xbox" style="width=100%;display:none"></iframe>
</BODY>
</HTML>
