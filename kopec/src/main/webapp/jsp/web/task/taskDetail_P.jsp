<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 
>-------------- 수정 사항  --------------<
수정일 : 2007.07.05 수정자 : 조영훈 


 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.StringTokenizer"%>

<%
	String imgUri = request.getRequestURI();

	ArrayList al = new ArrayList();

	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	String div = request.getParameter("typediv");	//유형 구분
	String detailid = request.getParameter("detailid");	//중점 추진 없무/실행 계획  detailid
	String stopYn = "";
	String stopY = "";
	String stopQ = "";
	
	
    DataSet dtlInfo = null;
    DataSet fileInfo = null;
    DataSet ds = null;
    try{
        request.setAttribute("detailid", request.getParameter("detailid"));
        request.setAttribute("typeid", request.getParameter("typediv"));
        request.setAttribute("projectid", request.getParameter("projectid"));
        request.setAttribute("fieldid", request.getParameter("fieldid"));
        request.setAttribute("stepid", request.getParameter("stepid"));


        TaskActualUtil tac = new TaskActualUtil();
        tac.taskActualPop(request, response);

        fileInfo = (DataSet)request.getAttribute("fileInfo");
        dtlInfo = (DataSet)request.getAttribute("dtlInfo");
        ds = (DataSet)request.getAttribute("ds");
		

        while(dtlInfo.next())
        {
        	stopYn = dtlInfo.isEmpty("STOPYN")?"":dtlInfo.getString("STOPYN");
			stopY = dtlInfo.isEmpty("STOPYEAR")?"":dtlInfo.getString("STOPYEAR");
			stopQ = dtlInfo.isEmpty("STOPQTR")?"":dtlInfo.getString("STOPQTR");
        	
        	
        	al.add(dtlInfo.isEmpty("PROJECTNAME")?"":dtlInfo.getString("PROJECTNAME"));	//프로젝트명
        	al.add(dtlInfo.isEmpty("PROJECTDESC")?"":dtlInfo.getString("PROJECTDESC"));	//--프로젝트 설명
        	al.add(dtlInfo.isEmpty("PROJECTGOALDESC")?"":dtlInfo.getString("PROJECTGOALDESC"));	//--프로젝트 목ss표
        	al.add(dtlInfo.isEmpty("MGRUSER")?"":dtlInfo.getString("MGRUSER"));	//--담당자
        	al.add(dtlInfo.isEmpty("EXECWORK")?"":dtlInfo.getString("EXECWORK"));	//--세부실행과제
        	al.add(dtlInfo.isEmpty("DRVPERI")?"":dtlInfo.getString("DRVPERI"));	//--추진기간
        	al.add(dtlInfo.isEmpty("GOALLEV")?"":dtlInfo.getString("GOALLEV"));	//--목표수준
        	al.add(dtlInfo.isEmpty("MAINDESC")?"":dtlInfo.getString("MAINDESC"));	//--주요내용
        	al.add(dtlInfo.isEmpty("MGRDEPT")?"":dtlInfo.getString("MGRDEPT"));	//--주관부서
        }

//        System.out.println("adsfasljfa;ldsjf;alsfj        :    " + al.get(0));

    }catch(Exception e){System.out.println(e);}
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>세부 실행 과제 조회</title>
</head>

<script>

	var detailWin;
    function openDetail(detailid, did) {
//    	var div = parent.form1.selType.options[parent.form1.selType.selectedIndex].value;
//    	alert(div);
    	var url = 'taskDetail_PDtl.jsp?detailid='+detailid+'&dtlid='+did;
    	detailWin = window.open(url, '' , 'toolbar=no,width=580,height=250,scrollbars=no,resizable=no,menubar=no,status=no');
    }
    
    function openChildPop(detailid, did)
	{
		if('<%=div%>' == '1')
		{
//			alert(detailid);
	//		var typeid = parent.detail.form1.selType.options[parent.detail.form1.selType.selectedIndex].value;
			var url = "taskActual_P.jsp?detailid="+did+"&typeid="+<%=div%>+"&mode=P" ;
	//		var url = "taskActual_P.jsp?";
		    exeWin = window.open(url, '실행과제추가', 'toolbar=no,Width=650px,Height=500px,scroll=yes,resizable=no,menubar:no,help=no,status=no');

		    exeWin.focus();
	    }
	    else
	    {
	//		var typeid = parent.detail.form1.selType.options[parent.detail.form1.selType.selectedIndex].value;
			var url = "taskActual_P.jsp?detailid="+<%=detailid%>+"&typeid="+<%=div%>+"&mode=P" ;
	//		var url = "taskActual_P.jsp?";
		    exeWin = window.open(url, '실행과제추가', 'toolbar=yes,Width=650px,Height=500px,scroll=yes,resizable=no,menubar:yes,help=no,status=yes');
				    
		    exeWin.focus();
	    
	    }
	}
    
</script>
<body>
    <table width="90%" border="0"  cellpadding="0" cellspacing="0">
              <tr align="left">
                <td height="30" ><strong>&nbsp;<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				<%if(div.equals("1")){out.print("실행계획 상세조회");}else{out.print("추진업무 상세조회");} %>
                  </strong></td>
              </tr>
            </table>
            <!------//프로젝트 입력 //---->
           <%if(div.equals("2") && stopYn.equals("Y")){%>
           <center><b><font color="#FF0000" size="3">중단된 추진업무 입니다.</font></b></center>
           <%} %>
			<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
			 <form name="form1" method="post" action="">
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">실행계획</font></strong></td>
                <td width="46%">
                    <%=al.get(4)%>
                  <strong></strong>
           		<%if(div.equals("2")){ %>
		            <a href="javascript:openChildPop();">
        			<img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
        			</a>
	        	<%} %>
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진기간</font></strong></td>
                <td width="46%">
                    <%=al.get(5)%>
                 </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주관부서</font></strong></td>
                <td width="46%">
                <%=al.get(8)%>
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">담당자</font></strong></td>
                <td width="46%">
                <%=al.get(3)%>
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">목표수준</font></strong></td>
                <td width="46% colspan="3">
                    <textarea name="_goallev" cols="63" rows="4" class="textarea_box" readonly="readonly"><%=al.get(6)%></textarea>
                 </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주요내용</font></strong></td>
                <td width="46% colspan="3">
                    <textarea name="_maindesc" cols="63" rows="10" readonly="readonly" class="textarea_box"><%=al.get(7)%></textarea>
                  </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="14%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">첨부파일</font></strong></td>
				<td width="46%">
<%
				if(fileInfo!=null)
					
					while(fileInfo.next())
					{
				
				//        StringTokenizer stk = new StringTokenizer(fileInfo.getString("FILEPATH"));
				//        while(stk.hasMoreTokens())
				//        {
				//        	out.println("sdfsfsf    " + stk.nextToken() + "<br>");
				//        }
						if(fileInfo.getString("FILEPATH") != null)
						{
							String fileNM[] = fileInfo.getString("FILEPATH").split("\\|");
					
							for(int i=0; i < fileNM.length; i++)
							{
%>
						<a href="./download.jsp?clips=<%=fileNM[i]%>"><%=fileNM[i]%></a><br>
<%
							}
						}
					}
%>
               	</td>
              </tr>
	          </form>
            </table>
            <%if(div.equals("1")) {%>
                <table width="90%" border="0"  cellpadding="0" cellspacing="0">
            	  <tr align="left">
                	<td height="30" ><strong>&nbsp;<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
						세부실행계획 리스트
    	              </strong>
    	            </td>
	              </tr>
        	    </table>
				<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				<form name="form2" method="post">
<!--  					<tr bgcolor="#FFFFFF">
              				<td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
               	 			전략과제 리스트</strong></td>
					</tr>
-->
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="25%"><strong><font color="#003399">세부실행계획</font></strong></td>
		                <td align="center" width="25%"><strong><font color="#003399">계획ㆍ실적</font></strong></td>
					</tr>
<%
					if(ds.getRowCount() != 0 && ds !=null)
					{
						while(ds.next()) 
						{
							String dname = ds.isEmpty("DTLNAME")?"":ds.getString("DTLNAME");
%>
	                <tr bgcolor="#FFFFFF">
						<td align="left">
						<a href="javascript:openDetail('<%=ds.getString("DETAILID")%>','<%=ds.getString("DTLID")%>');" title="<%=ds.isEmpty("DTLNAME")?"":ds.getString("DTLNAME") %>">
<% 
							if(	dname.length() > 20) 
								out.print(dname.subSequence(0, 17)+"..."      );
							else
								out.print(dname);
%>
						</td>
						<td align="center">
							<a href="javascript:openChildPop('<%=ds.getString("DETAILID")%>','<%=ds.getString("DTLID")%>');">
			        		<img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
	        				</a>
						</td>
	                </tr>
<%
						}
					}
%>
					<tr bgcolor="#FFFFFF">
						<td>
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
				</form>
            </table>
		<%} %>
		<br>
	<table align="right">
		<tr align="right" bgcolor="#FFFFFF">
			<td>
	                	<a href="javascript:window.close();"><img src="<%=imgUri %>/jsp/web/images/btn_close.gif" alt="닫기" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
 			</td>

       </tr>
   </table>
</body>
</html>