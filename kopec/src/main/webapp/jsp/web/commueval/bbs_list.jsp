<%@
	page language   = "java"
	contentType		= "text/html; charset=euc-kr"
	import			= "java.util.*,
					   java.io.*,
					   com.nc.util.*,
					   com.nc.commu.*"
%>

<%

	String imgUri			= request.getRequestURI();
	imgUri					= imgUri.substring(1);
	String imgPreUri		= imgUri.substring(0, imgUri.indexOf("/"));
	imgUri					= "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));


	String groupId			= (String) session.getAttribute("groupId");
	String userName			= (String) session.getAttribute("userName");
	String userId			= (String) session.getAttribute("userId");


	/**********************
	String tableName 		= request.getParameter("tableName");
	**********************/
	String div_cd 			= request.getParameter("div_cd");

	/**********************
    if (tableName == null || tableName.equals("null")) tableName = "TBLPUBLICBOARD";
	**********************/
    if (div_cd == null || div_cd.equals("null")) div_cd = "1";

    String jspName			= request.getServletPath() == null ? "" : (request.getServletPath()).trim();
	String lines			= request.getParameter("lines") == null ? "" : (request.getParameter("lines")).trim();

	if(lines == null || lines.equals("")) lines = "15";
    //if(lines == null || lines.equals("")) lines = "1";

    String keyWord			= request.getParameter("keyWord") == null ? "" : Util.getEUCKR((request.getParameter("keyWord")).trim());
	String keywordPrefix	= "";

    if(keyWord == null || keyWord.trim().equals("")) {
        keyWord = "";
    }else {
        keywordPrefix = "검색어 ('<font color='#FF0000'>" +  keyWord + "</font>')로 검색된";
    }

    //String bbsName		= request.getParameter("bbsNameTotal");

    String searchCode		= request.getParameter("searchCode") == null ? "" : (request.getParameter("searchCode")).trim();
    String currentPage		= request.getParameter("currentPage") == null ? "" : (request.getParameter("currentPage")).trim();
    if(currentPage == null || currentPage.trim().equals("")) currentPage = "1";

    String pages			= request.getParameter("pages") == null ? "" : (request.getParameter("pages")).trim();
    String gubun			= "";
    String tblGbn			= "";

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


// 운영시 삭제바람

	double nStopw1 = 0, nStopw2 = 0, nStopw3 = 0;
	double tStamp = System.currentTimeMillis();
	nStopw1 = tStamp;

	CommuBoard cB = new CommuBoard();
	cB.setCommuBoardList(request, response, userId, div_cd);

	DataSet ds1 = (DataSet) request.getAttribute("ds");

	String pageList			= (String)request.getAttribute("pageList");

	//System.out.println("userId ==> " + userId);
	//pageList				= cB.getCommuPageList(request, response, userId, div_cd);


	int totalNum			= ((Integer)request.getAttribute("totalNum")).intValue();

	//totalNum				= cB.getCommuRecordCount(request, response, userId, div_cd);

	int totalPages			= ((totalNum - 1) / Integer.parseInt(lines) ) + 1;
    int currNum				= (totalNum - ((Integer.parseInt(currentPage) - 1) * Integer.parseInt(lines)));

	// 타임체킹
    tStamp = System.currentTimeMillis();
    nStopw2 = tStamp - nStopw1;

    boolean isWritable = false;

	if (session != null && (session.getAttribute("userId") != null)) {
		isWritable = true;
	}else	{
		isWritable = false;
	}

	if(div_cd.equals("0"))	{
		//System.out.println("isWritable="+isWritable);
		if(!groupId.equals("1"))	{
			isWritable = false;
		}

	}

	int wid = 0;
	int strNum = 0;
	String file="";
%>
<HTML>
<HEAD>
<TITLE><%=tblGbn%> 조회</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
	function go_write(goUrl)	{
		var id = "<%=userId%>";
		var sure;
		if(id == "null" || id == "")	{
			sure = confirm("다시 로그인접속하여 주십시오");
			if (sure == true)	{
				top.location.href = "../loginProc.jsp";
			}else	{
				return;
			}
		}else	{
			//location.href = goUrl;
			document.SEARCH.action = goUrl;
			//document.SEARCH.target="if_xbox";
			document.SEARCH.tag.value = 'C';
			document.SEARCH.currentPage.value = <%=currentPage%>;
			document.SEARCH.submit();
		}
	}

	/**********************
	function goDetail(seq,tableName,currentPage,keyWord,searchCode)	{
		location.href = "bbs_read.jsp?seq="+seq+"&tableName="+tableName+"&currentPage="+currentPage+"&keyWord="+keyWord+"&searchCode="+searchCode;
	}
	**********************/
	function goDetail(seq,div_cd,currentPage,keyWord,searchCode)	{
		location.href = "bbs_read.jsp?seq="+seq+"&div_cd="+div_cd+"&currentPage="+currentPage+"&keyWord="+keyWord+"&searchCode="+searchCode;
	}
//-->
</script>
</HEAD>
<BODY leftmargin="0" topmargin="0">

<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td width="1%" height="15"></td>
		<td width="98%" height="15"></td>
		<td width="1%" height="15"></td>
	</tr>
</table>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td width="1%" ></td>
		<td width="98%"></td>
		<td width="1%" ></td>
	</tr>
</table>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
	<form action="<%=imgUri + jspName%>" method="POST" name="SEARCH">
	<input type='hidden' name='yyyy'>
	<!--*********************
	<input type='hidden' name="tableName" value="<%//=tableName%>">
	**********************-->
	<input type='hidden' name="div_cd" value="<%=div_cd%>">
	<input type='hidden' name="tag">
	<input type='hidden' name="currentPage" value="<%=currentPage%>">
	<tr bgcolor="#DCEDF6">
		<td width="100%" height="30" align="left" bgcolor="#FFFFFF">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="50%" align="left" bgcolor="#FFFFFF"><strong><font color="#006699">
						<select class=form name="searchCode" size=1>
							<option selected value="title">제 목</option>
							<option value="name">글쓴이</option>
						</select>
						<input type="text" maxLength=20 name="keyWord" value="<%=keyWord%>">
						<input type=image src="../images/btn_ok.gif" border="0" align="absmiddle">
					</td>
					<td width="50%" align="right" bgcolor="#FFFFFF"><strong><font color="#006699">
					<%
						if (isWritable) {
					%>
						<a href="javascript:go_write('bbs_write.jsp');"><img src="../images/btn_write.gif" border="0"></a></td>
					<%
						}
					%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</form>
</table>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1">
	<tr bgcolor="#DCEDF6">
		<td width="100%" height="30" align="right" bgcolor="#FFFFFF">
			<%= keywordPrefix %> 총 게시물수 <%= totalNum %> [현재페이지 : <%= currentPage %>/<%= totalPages %>]
		</td>
	</tr>
</table>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td width="1%" height="3"></td>
		<td width="98%" height="3" bgcolor="#699FDB"></td>
		<td width="1%" height="3"></td>
	</tr>
</table>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#A4CBE3" id='tbl0'>
	<tr bgcolor="#DCEDF6">
		<td width="80" height="21" align="center" bgcolor="#EEF4FB"><span class="Text02">번호</span></td>
		<td height="21" align="center" bgcolor="#EEF4FB"><span class="Text02">제목</span></td>
		<td width="100" height="21" align="center" bgcolor="#EEF4FB"><span class="Text02">글쓴이</span></td>
		<td width="100" height="21" align="center" bgcolor="#EEF4FB"><span class="Text02">파일</span></td>
		<td width="100" height="21" align="center" bgcolor="#EEF4FB"><span class="Text02">조회</span></td>
		<td width="100" height="21" align="center" bgcolor="#EEF4FB"><span class="Text02">등록일</span></td>
	</tr>
<%
	if(ds1 != null)	{
		if(ds1.getRowCount() > 0)	{
			strNum = totalNum - ((Integer.parseInt(currentPage) - 1)*15);
			//strNum = totalNum - ((Integer.parseInt(currentPage) - 1)*1);
   			while (ds1.next()) {
   	   			//file = ds1.getString("FILES")?"":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds1.getString("FILES")+"');\"> </a>";

%>
	<tr bgcolor="#FFFFFF">
		<td width="80" height="19" align="center"><span class="Text02"><%=strNum%></span></td>
		<td height="19" align="left" style="padding-left:5">
<%
				wid	= 0;
				if(Integer.parseInt(ds1.getString("ANSRSEQ")) > 0)	{
   					wid = 5 * Integer.parseInt(ds1.getString("DEPTH"));
%>
<img src="../images/level.gif" width="<%=wid%>" height="16">
<img src="../images/re.gif" width="26" height="16">
<%}%>
			<span class="Text02">
	<!--*********************
				<a href="javascript:goDetail('<%=ds1.getString("SEQ")%>','<%//=tableName%>','<%=currentPage%>','<%=keyWord%>','<%=searchCode%>');"><%=ds1.getString("TITLE")%></a>
	**********************-->
				<a href="javascript:goDetail('<%=ds1.getString("SEQ")%>','<%=div_cd%>','<%=currentPage%>','<%=keyWord%>','<%=searchCode%>');"><%=ds1.getString("TITLE")%></a>
			</span>
		</td>
		<td width="100" height="19" align="center"><span class="Text02"><%=ds1.getString("USERNAME")%></span></td>
		<td width="100" height="19" align="center">
			<span class="Text02">
			<%
				if(ds1.getString("FILES") != null)	{
					if((ds1.getString("FILES")).length() > 0)	{
			%>
			<a href='#'><img src='<%=imgUri%>/jsp/web/images/icon_file.gif' width='12' height='12' onClick="download('<%=ds1.getString("FILES")%>');"></a>
			<%
					}
				}
			%>
			</span>
		</td>
		<td width="100" height="19" align="center"><span class="Text02"><%=ds1.getString("READNUM")%></span></td>
		<td width="100" height="19" align="center"><span class="Text02"><%=ds1.getString("REGIDATE")%></span></td>
	</tr>
<%
			strNum--;
   			}
   		}else	{
%>
	<tr bgcolor="#FFFFFF">
		<td COLSPAN="6" height="30" align="center" style="padding-top:5">등록된 글이 없습니다</td>
	</tr>
<%
		}
	}else	{
%>
	<tr bgcolor="#FFFFFF">
		<td COLSPAN="6" height="30" align="center" style="padding-top:5">등록된 글이 없습니다</td>
	</tr>
<%	}%>
	<tr bgcolor="#DCEDF6">
		<td COLSPAN="6" height="21" align="center" bgcolor="#EEF4FB" style="padding-top:5"><%= (pageList) %></td>
	</tr>
</table>

<form name="downForm" method="post" action="download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//좌측  KPI 선택 전청 리스트 끝//-------->
<SCRIPT>
<!--

	function download(filename){
	
		if(confirm("본 문서는 한국전력기술㈜의 비밀, 재산적 정보를 포함하며 한국전력기술㈜의 사전 서면 승인된 경우를 제외하고는 일체의 복사, 복제, 공개, 제공 및/또는 사을 금합니다.\n\nTHIS DOCUMENT CONTAINS CONFIDENTIAL AND PROPRIETARY INFORMATION OF KEPCO ENGINEERING & CONSTRUCTION CO.,INC. (“KEPCO E&C”) AND MAY NOT BE COPIED, REPRODUCED, DISCLOSED, TRANSFERRED AND/OR USED IN THE WHOLE OR IN PART EXCEPT IN ACCORDANCE WITH PRIOR WRITTEN APPROVAL OF KEPCO E&C.")){
			downForm.fileName.value=filename;
			downForm.submit();	
		}
		
	} 


	/*
	mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
	*/
//-->
</SCRIPT>
<!-- DB 튜닝용 &lt;<% out.println("Elapsed Time : " + (nStopw2 / 1000) + "초"); %>&gt; -->
</BODY>
</HTML>