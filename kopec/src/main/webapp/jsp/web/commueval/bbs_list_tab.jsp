<%@
	page language   = "java"
	contentType		= "text/html; charset=euc-kr"
	import			= "java.util.*,
					   java.io.*,
					   com.nc.util.*,
					   com.nc.commu.*"
%>
<%
	String imgUri = "";
	StringBuffer reqUrl = request.getRequestURL();
	if("\\".equals(System.getProperty("file.separator"))){
		imgUri = reqUrl.substring(0,reqUrl.lastIndexOf(request.getContextPath()))+request.getContextPath()+"/";
	}else{
		imgUri = reqUrl.substring(0,reqUrl.lastIndexOf(request.getRequestURI()))+"/";
	}
	
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

	if(lines == null || lines.equals("")) lines = "7";
    //if(lines == null || lines.equals("")) lines = "1";

    lines = "7";
    
    String keyWord			= request.getParameter("keyWord") == null ? "" : Util.getEUCKR((request.getParameter("keyWord")).trim());
	String keywordPrefix	= "";

    if(keyWord == null || keyWord.trim().equals("")) {
        keyWord = "";
    }else {
        keywordPrefix = "�˻��� ('<font color='#FF0000'>" +  keyWord + "</font>')�� �˻���";
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
    	tblGbn = "��������";
	}else if(div_cd.equals("2"))	{
		tblGbn = "Q & A";
    }else if(div_cd.equals("3"))	{
    	tblGbn = "�ڷ��";
    }
*/

if(div_cd.equals("0"))	{
	tblGbn = "��������";
}else if(div_cd.equals("1"))	{
	tblGbn = "�����濵���ڷ�";
}else if(div_cd.equals("2"))	{
	tblGbn = "�濵�򰡺���";
}else if(div_cd.equals("3"))	{
	tblGbn = "�濵�������� ȸ���ڷ�";
}


// ��� �����ٶ�

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
	int totalPages			= ((totalNum - 1) / Integer.parseInt(lines) ) + 1;
    int currNum				= (totalNum - ((Integer.parseInt(currentPage) - 1) * Integer.parseInt(lines)));

	// Ÿ��üŷ
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
	int strNum  = 0;
	int strLine = 0;
	String file="";
	String title="";
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri %>/jsp/web/css/kopec.css" rel="stylesheet" type="text/css"/>
<script language="javascript">
<!--
	function go_write(goUrl)	{
		var id = "<%=userId%>";
		var sure;
		if(id == "null" || id == "")	{
			sure = confirm("�ٽ� �α��������Ͽ� �ֽʽÿ�");
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
		
		if("0" == div_cd){ //��������
	        top.FrmBoard.page.location.href = "bbs_read.jsp?seq="+seq+"&div_cd="+div_cd+"&currentPage="+currentPage+"&keyWord="+keyWord+"&searchCode="+searchCode;

			top.FrmBoard.document.getElementById("titleText").innerText="��������";
			top.FrmBoard.document.getElementById("titleText_1").innerText="��������";
			top.document.all.mainFrm.document.all.contentFrm.rows = "0, 0,0,0, 0,0,*, 0"
		}else if("3" == div_cd){ // �濵����ȸ�� �����ڷ�
			top.topFrm.openBoard(); 		    
			top.FrmBoard.page.location.href = "bbs_read.jsp?seq="+seq+"&div_cd="+div_cd+"&currentPage="+currentPage+"&keyWord="+keyWord+"&searchCode="+searchCode;

			top.FrmBoard.document.getElementById("titleText").innerText="��������";
			top.FrmBoard.document.getElementById("titleText_1").innerText="�濵����ȸ�� �����ڷ�";
		}else if("1" == div_cd){ // �����濵���ڷ�
			top.topFrm.openBoard(); 		    
			top.FrmBoard.page.location.href = "bbs_read.jsp?seq="+seq+"&div_cd="+div_cd+"&currentPage="+currentPage+"&keyWord="+keyWord+"&searchCode="+searchCode;

			top.FrmBoard.document.getElementById("titleText").innerText="��������";
			top.FrmBoard.document.getElementById("titleText_1").innerText="�����濵���ڷ�";
		}else if("2" == div_cd){ // �������ڷ�
			top.topFrm.openBoard(); 		    
			top.FrmBoard.page.location.href = "bbs_read.jsp?seq="+seq+"&div_cd="+div_cd+"&currentPage="+currentPage+"&keyWord="+keyWord+"&searchCode="+searchCode;

		    top.FrmBoard.document.getElementById("titleText").innerText="��������";	    
			top.FrmBoard.document.getElementById("titleText_1").innerText="�������ڷ�";
		}
	}
//-->
</script>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" id='tbl0'>
	<tr>
		<td height="10" colspan="3"></td>
	</tr>                
<%
	if(ds1 != null)	{
		if(ds1.getRowCount() > 0)	{
			strNum = totalNum - ((Integer.parseInt(currentPage) - 1)*7);
			//strNum = totalNum - ((Integer.parseInt(currentPage) - 1)*1);
   			while (ds1.next()) {
   	   	   		title = ds1.getString("TITLE").length() > 20 ? ds1.getString("TITLE").substring(0,20) + "...":ds1.getString("TITLE");
%>
	<tr bgcolor="#FFFFFF">
		<td height="20" align="left" style="padding-left:5">
		<img src="<%=imgUri %>images/bullet01.gif" width="2" height="2"/> 		
<%
				wid	= 0;
				if(Integer.parseInt(ds1.getString("ANSRSEQ")) > 0)	{
   					wid = 5 * Integer.parseInt(ds1.getString("DEPTH"));
%>
<img src="../images/level.gif" width="<%=wid%>" height="16">
<img src="../images/re.gif" width="26" height="16">
<%}%>
			<span class="Text02">
				<a href="javascript:goDetail('<%=ds1.getString("SEQ")%>','<%=div_cd%>','<%=currentPage%>','<%=keyWord%>','<%=searchCode%>');"><%=title%></a>
			</span>
		</td>
	<!-- 
		<td width="10%" height="20" align="center"><span class="Text02"><%=ds1.getString("USERNAME")%></span></td>
	 -->	
		<td width="10%" height="20" align="center">
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
		<td width="20%" height="20" align="center"><span class="Text02"><%=ds1.getString("REGIDATE")%></span></td>
	</tr>
<%
			strLine++;
			strNum--;
   			}
   		}else	{
%>
	<tr bgcolor="#FFFFFF">
		<td COLSPAN="3" height="20" align="center" style="padding-top:5">��ϵ� ���� �����ϴ�</td>
	</tr>
<%
		}
	}else	{
%>
	<tr bgcolor="#FFFFFF">
		<td COLSPAN="3" height="20" align="center" style="padding-top:5">��ϵ� ���� �����ϴ�</td>
	</tr>
<%	}%>
</table>

<form name="downForm" method="post" action="download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//����  KPI ���� ��û ����Ʈ ��//-------->
<SCRIPT>
<!--

	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}

	/*
	mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
	*/
//-->
</SCRIPT>
<!-- DB Ʃ�׿� &lt;<% out.println("Elapsed Time : " + (nStopw2 / 1000) + "��"); %>&gt; -->
</BODY>
</HTML>