<%@ page language    = "java"
         contentType = "text/html; charset=euc-kr"
         import      = "java.util.*,
         				java.net.*,
         				java.io.*,
         				com.nc.util.*"
%>
<%
	try{
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
	} catch(Exception ee) {}

  String imgUri = request.getRequestURI();
  imgUri = imgUri.substring(1);
  imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
%>
<%
	String user = request.getParameter("user")!=null?request.getParameter("user"):"";
	String hierarchy = request.getParameter("hierarchy")!=null?request.getParameter("hierarchy"):"";
	String planned = request.getParameter("planned")!=null?request.getParameter("planned"):"";
	String item = request.getParameter("item")!=null?request.getParameter("item"):"";
	String itemactual = request.getParameter("itemActual")!=null?request.getParameter("itemActual"):"";
	String authority = request.getParameter("authority")!=null?request.getParameter("authority"):"";

	String work = request.getParameter("work")!=null?request.getParameter("work"):"";
	String execgoal = request.getParameter("execgoal")!=null?request.getParameter("execgoal"):"";

	ImportUtil importutil = null;
	System.out.println("importing starting...");
	HashMap rtnMap = new HashMap();
	try {
	    	importutil = new ImportUtil();
	    	if (!("".equals(user))){

	    		importutil.importUser(user,rtnMap);

	    	} else if (!("".equals(authority))){

	    		importutil.importAuthority(authority,rtnMap);

	    	} else if (!("".equals(hierarchy))){

	    		importutil.importStructure(hierarchy, rtnMap);

	    	} else if (!("".equals(item))){

	    		importutil.importItem(item,rtnMap);

	    	} else if (!("".equals(itemactual))){

	    		importutil.importItemActual(itemactual, rtnMap);

	    	} else if (!("".equals(planned))) {

	    		importutil.importPlanned(planned, rtnMap);

	    	} else if(!("".equals(work))){

	    		importutil.importWork(work, rtnMap, request);

	    	} else if(!("".equals(execgoal))) {

	    		importutil.importGoal(execgoal, rtnMap, request);

	    	}
	} catch (Exception e) {
		System.out.println("Importing Error :"+e);
		String temp = e.toString();
		temp = temp.replaceAll("\r\n","  ");
		temp = temp.replaceAll("\r","  ");
		temp = temp.replaceAll("\n","");
		System.out.println(temp);
		rtnMap.put("error", temp);
	} finally {

	}
	    File file = new File(ServerStatic.REAL_CONTEXT_ROOT+"/import");
		//File file = new File(request.getRealPath("/import"));

		if(!file.exists()) {
		    file.mkdirs();
		}
		String[] csv = file.list();
		int csvCount=0;
		if (csv != null) csvCount = csv.length;
		int i;
		StringBuffer opt = new StringBuffer();
		if (csv != null) {
			for (i=0; i<csvCount;i++){
			  opt.append(" <option value="+csv[i] +">"+csv[i]+"</option> \n");
			}
		}

%>
<SCRIPT>
     function actionPerformed(){
       importDetailForm.submit();
     }


</SCRIPT>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cool Package</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%=imgUri%>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#ffffff">
      <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">

	    <tr>
          <td width="14%" align="center" bgcolor="#f6f6f6"><strong><font color="#333333">파일목록</font></strong></td>
          <td width="86%" bgcolor="#FFFFFF"><textarea name="fileList" cols="60" rows="10" class="textarea_box"
          readonly="readonly"><% if (csv != null){  for (int i1=0; i1<csv.length;i1++){ %><%=csv[i1]+"\n"%> <% }} %>
          </textarea>
            <br>
           <iframe name="importFile" id="importFile" frameborder="0" src="importFile.jsp" style="body" width="460" height="23" scrolling="no" ></iframe>
            </td>
        </tr>
      </table>
	  <!-----/여백 테이블/----->
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
	  <!----/하단 테이블(파일선택)/-->
      <form name="importDetailForm" method="post" action="" >
      <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
        <tr align="center" bgcolor="#375f9c" style="height:32px;">
          <td width="14%"><font color="#ffffff"><strong>구분</strong></font></td>
          <td width="23%"><font color="#ffffff"><strong>세부항목</strong></font></td>
          <td width="63%"><font color="#ffffff"><strong>파일선택</strong></font></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td align="center" rowspan="2"><font color="#333333" ><strong>사용자</strong></font></td>
          <td align="center"><font color="#666666">사용자</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="user">
                <option value=''>화일선택</option>
                <%= opt.toString() %>
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=imgUri%>/jsp/web/import/exportExl.jsp?type=user"><img src="<%=imgUri%>/jsp/web/images/btn_excel_save.gif" STYLE="cursor:hand" alt="적용" width="65" height="20" border="0" align="absmiddle"></a>
        </td></tr>
        <tr bgcolor="#FFFFFF">
          <td align="center"><font color="#666666">성과담당자</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="authority">
                <option value=''>화일선택</option>
                <%= opt.toString() %>
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </td></tr>
        <tr bgcolor="#FFFFFF">
          <td align="center"><font color="#333333"><strong>스코어카드</strong></font></td>
          <td align="center"><font color="#666666">조직구성</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="hierarchy">
            <option value=''>화일선택</option>
             <%= opt.toString() %>
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=imgUri%>/jsp/web/import/exportExl.jsp?type=hierarchy"><img src="<%=imgUri%>/jsp/web/images/btn_excel_save.gif" STYLE="cursor:hand" alt="적용" width="65" height="20" border="0" align="absmiddle"></a>
        </td></tr>
        <!--
        <tr bgcolor="#FFFFFF">
          <td align="center"><font color="#666666">계산된 식 등록</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="equation">
            <option value=''>화일선택</option>
              <%= opt.toString() %>
            </select></td>

        </tr>
         -->

        <tr bgcolor="#FFFFFF">
          <td align="center"><font color="#333333"><strong>계획</strong></font></td>
          <td align="center"><font color="#666666">계획(ETL KEY)</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="planned">
            <option value=''>화일선택</option>
              <%= opt.toString() %>
            </select>
          </td></tr>



        <tr bgcolor="#FFFFFF">
          <td align="center" rowspan="2"><font color="#333333"><strong>항목</strong></font></td>
          <td align="center"><font color="#666666">항목목록 및 산식</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="item">
            <option value=''>화일선택</option>
              <%= opt.toString() %>
            </select></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td align="center"><font color="#666666">항목 실적 </font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="itemActual">
            <option value=''>화일선택</option>
             <%= opt.toString() %>
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=imgUri%>/jsp/web/import/exportExl.jsp?type=itemActual"><img src="<%=imgUri%>/jsp/web/images/btn_excel_save.gif" STYLE="cursor:hand" alt="적용" width="65" height="20" border="0" align="absmiddle"></a>
        </td></tr>

 		<tr bgcolor="#FFFFFF">
          <td align="center" rowspan="2"><font color="#666666">과제관리</font></td>
          <td align="center"><font color="#666666">과제목록</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="work">
            <option value=''>화일선택</option>
              <%= opt.toString() %>
            </select></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td align="center"><font color="#666666">실행계획</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="execgoal">
            <option value=''>화일선택</option>
              <%= opt.toString() %>
            </select></td>
        </tr>
        <!--
        <tr bgcolor="#FFFFFF">
          <td align="center"rowspan="1"><font color="#333333"><strong>전략맵</strong></font></td>
          <td align="center"><font color="#666666">전략맵 아이콘</font></td>
          <td><img src="<%=imgUri%>/jsp/web/images/icon_file2.gif" width="12" height="12">
            <select name="mapicon">
            <option value=''>화일선택</option>
              <%= opt.toString() %>
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=imgUri%>/jsp/web/import/exportExl.jsp?type=map"><img src="<%=imgUri%>/jsp/web/images/btn_excel_save.gif" STYLE="cursor:hand" alt="적용" width="65" height="20" border="0" align="absmiddle"></a>
        </td></tr>
         -->
      </table>
	  <!-----/적용버튼/--->
      <table width="98%" height="30" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="right"><img src="<%=imgUri%>/jsp/web/images/btn_regi.gif" ONCLICK="javascript:actionPerformed('submit');"  STYLE="cursor:hand" alt="적용" width="50" height="20" border="0"></td>
        </tr>

      </table>
      </form>
</body>
</html>
<% if (rtnMap.containsKey("error")) {%>
  <script>
      alert("<%=(String)rtnMap.get("error")%>");
  </script>
<% } else if (rtnMap.containsKey("count")) { %>
  <script>
      alert("<%=(String)rtnMap.get("count")%>개의 ROW을 등록 되었습니다.");
  </script>
<% } %>

