<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):"";
	if(id.equals("")) {
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		
		return;
	}

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
    TaskProceed tp = new TaskProceed();
    tp.procGetGrap(request, response);

	int minYear = 2007;
	int maxYear = 2015;
    DataSet proc = (DataSet)request.getAttribute("proc");
    DataSet year = (DataSet)request.getAttribute("year");
    int yearCnt = 0;    //--시작년도와 마지막 년도 count

    if(year != null)    {
        while(year.next()) {
            minYear = 2007;
            maxYear = (year.isEmpty("MAXYEAR"))?2015:Integer.parseInt(year.getString("MAXYEAR"));
        }
    }

    if(maxYear < 2015)
    	maxYear = 2015;

    for(int i = 2007; i <= maxYear; i++) {
        yearCnt++;
    }
    yearCnt = yearCnt*4;    //--년도 * 4 (년도별 분기의 총합)
    
    int wdt=23;

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>실행 계획 조회</title>
</head>
<script language="javaScript">

    function procDetail(prjid, dtlid, sdtlid)
    {
    	var div = parent.form1.selType.options[parent.form1.selType.selectedIndex].value;
//        window.open('./proceedGraph_P.jsp?prjid=' + prjid +
//                                        '&dtlid=' + dtlid +
//                                        '&div='   + div   +
//                                        '&sdtlid=' + sdtlid,'','width=700, height=500',scrollbars='yes');

    	var div = parent.form1.selType.options[parent.form1.selType.selectedIndex].value;
        window.open('./proceedGraph_P.jsp?prjid=' + prjid +
                                        '&dtlid=' + dtlid +
                                        '&div='   + div   +
                                        '&sdtlid=' + sdtlid +
                                        '&pdtlid=' + dtlid,'','toolbar=no,Width=700,Height=600px,scroll=yes,resizable=no,menubar:no,help=no,status=no');

    }
</script>
<body>
		<table align="right">
			<tr align="right">
			    <td>
                    <img src="<%=imgUri %>/jsp/web/images/imageBar_Blue.JPG" hspace="0" border="0" width="20" height="9"> : 계획
                    <img src="<%=imgUri %>/jsp/web/images/imageBar_Pink.JPG" hspace="0" border="0" width="20" height="9"> : 진행
                    <img src="<%=imgUri %>/jsp/web/images/imageBar_Grey.JPG" hspace="0" border="0" width="20" height="9"> : 중단
			    </td>
		    </tr>
			<tr align="right">
				<td>
                    <font color="#292ffa">실제진도율%/목표진도율%(목표달성도%)</font>
			    </td>
		   </tr>
		</table>
        &nbsp;
        <form name="form1" method="post" action="">
        <input type="hidden" name="projId">
			<!--------//리스트 //------->
            <table border="0" cellpadding="0" cellspacing="1" width=100% bgcolor="#9DB5D7" >
              <tr bgcolor="#FFFFFF">
                <td rowspan="3" bgcolor="#D4DCF4" width="250" align="center"><img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" border="0" width="250" height="1" align="absmiddle"><strong><font color="#003399" size="2"><br>실행과제</font></strong></td>
                <td rowspan="3" bgcolor="#D4DCF4" width="100" align="center"><img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" border="0" width="80" height="1" align="absmiddle"><strong><font color="#003399" size="2"><br>주관부서</font></strong></td>
                <td rowspan="3" bgcolor="#D4DCF4" width="80" align="center"><strong><font color="#003399" size="2">진도율<br>(달성률)</font></strong></td>
                <td colspan="<%=yearCnt%>" bgcolor="#D4DCF4" align="center"><strong><font color="#003399" size="2">1단계</font></strong></td>
              </tr>
              <tr bgcolor="#FFFFFF" align="center"><!-- 년도 -->
<%
                for(int i = 2007; i <= 2015; i++) {
%>
                    <td colspan="4" align="center" ><%=i %></td>
<%
                }
%>
              </tr>
              <tr bgcolor="#FFFFFF">
              <!-- 분기 -->
<%
                int qtrCnt = 1;
                for(int i = 0; i < yearCnt; i++)
                {
%>
                    <td width="37" align="center">&nbsp;<%=qtrCnt%></td>
<%
                    qtrCnt++;
                    if(qtrCnt > 4)
                    {
                        qtrCnt=1;
                    }
                }
%>
              </tr>
<%
				if(proc!=null)
                while(proc.next())
                {
                	int acP = 0;
                	double acA = proc.isEmpty("REALIZE")?0:proc.getDouble("REALIZE");
                	double acAVG = proc.isEmpty("REAVG")?0:proc.getDouble("REAVG");
                	String planned = proc.isEmpty("QTRGOAL")?"":proc.getString("QTRGOAL");
                	String actual = proc.isEmpty("QTRACHV")?"":proc.getString("QTRACHV");

					String execWork = proc.isEmpty("EXECWORK")?"":proc.getString("EXECWORK");
					String deep = proc.isEmpty("LEV")?"":proc.getString("LEV");
					String stopYn = "N";
					String sdtlid = proc.isEmpty("SDTLID")?"":proc.getString("SDTLID");

					if(deep.equals("1"))
					{
						if(execWork.length() >= 30)
						{
							execWork = execWork.substring(0,15)+"...";
						}
						execWork = "&nbsp;&nbsp;&nbsp;&nbsp;▶" + execWork;
					}
					else
					{
						if(execWork.length() >= 35)
						{
							execWork = execWork.substring(0,20)+"...";
						}
					}
//	                else{out.print(execWork);}
%>
              <tr bgcolor="#FFFFFF">
                <td align="left" height="10" width=300><a href="javaScript:procDetail('<%=proc.getString("PROJECTID")%>','<%=proc.getString("DETAILID")%>','<%=sdtlid %>');">
<%
				if(deep.equals("0"))
				{
					out.print("<b>" + execWork);
				}
				else
				{
					out.print(execWork);
				}
%>
                </a></td>
                <td align="left" height="10" width="100" ><%=proc.isEmpty("DNAME")?"":proc.getString("DNAME")%></td>
                <td align="center" height=10 width="80">
					<table align="center" height=10 width="80" cellpadding="0" cellspacing="2" >
						<tr>
						<%if(stopYn.equals("N")){%>
							<td  align="center" width="100%">
							<%if(deep.equals("0")){ %>
	  						 <img src="<%=imgUri %>/jsp/web/images/imageBar_Red.JPG" hspace="0" border="0" width="4" height="<%if(15*acAVG/100 > 15){out.println(15);}else if(15*acAVG/100 == 0){out.println(0);}else if(15*acAVG/100 <= 20){out.println(15*acAVG/100);}else{out.println(18);} %>" align="bottom">
							<%}else{ %>
							 <img src="<%=imgUri %>/jsp/web/images/imageBar_Red.JPG" hspace="0" border="0" width="4" height="<%if(15*acA/100 > 15){out.println(15);}else if(15*acA/100 == 0){out.println(0);}else if(15*acA/100 <= 20){out.println(15*acA/100);}else{out.println(18);} %>" align="bottom">
							<%} %> 
							 <img src="<%=imgUri %>/jsp/web/images/imageBar_Green.JPG" hspace="0" border="0" width="4" height="15" align="bottom">
							</td>
						<%}%>
						</tr>
						<tr><td align="center">
						<% if(stopYn.equals("N")){
							if(deep.equals("0"))
								out.println("("+acAVG+")");
							else
								out.println(actual+"/"+planned+"("+acA+")");
						}else{
							out.println("<font color='#FF0000'>중단</font>");
						}
						%>
						    </td>
						</tr>
					</table>
				</td>
<%

				int s = Integer.parseInt((proc.isEmpty("SYEAR")?"0":proc.getString("SYEAR"))+(proc.isEmpty("SQTR")?"0":proc.getString("SQTR")));
				int e = Integer.parseInt((proc.isEmpty("EYEAR")?"0":proc.getString("EYEAR"))+(proc.isEmpty("EQTR")?"0":proc.getString("EQTR")));
				int p = Integer.parseInt((proc.isEmpty("AYEAR")?"0":proc.getString("AYEAR"))+(proc.isEmpty("AQTR")?"0":proc.getString("AQTR")));
				int stYear = Integer.parseInt((proc.isEmpty("SYEAR")?"0":proc.getString("SYEAR")));
				int edYear = Integer.parseInt((proc.isEmpty("EYEAR")?"0":proc.getString("EYEAR")));
				boolean step1=false;

				for(int i = 2007; i <= 2015; i++)  //-- 년도
                {
					if(i >= stYear || i <= edYear)
					{
	                    for(int j = 1; j < 5; j++)          //-- 분기
	                    {

	                    	out.println("<td align=\"left\" height=\"10\" width=\"35\">");
	                    	if(deep.equals("1"))	//-- 세부실행과제
	                    	{
	                    		if(stopYn.equals("N"))
	                    		{

			                    	if(Util.getBetween(s,e,i,j))
			                    	{
				                    	if (Util.getBetween(s,p,i,j)) { %>
		 		                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Pink.JPG" vspace="4" hspace="0" border="0" width="<%=wdt %>" height="5" align="absmiddle">
				<%                			step1=true;
				    					} else {
				    					%>
		 		    						<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" vspace="4" border="0" width="<%=wdt %>" height="5" align="absmiddle">
				<%
				    					}
			%>
		  	                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Blue.JPG" vspace="4" hspace="0" border="0" width="<%=wdt %>" height="5" align="absmiddle">
			<%
			                        }
			                    	else
			                    	{
		%>
		 								<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" vspace="4" border="0" width="<%=wdt %>" height="5" align="absmiddle">
		<%
			                    	}
	                    		}
	                    		else	//--중단 되었을때.
	                    		{
			                    	if(Util.getBetween(s,e,i,j))
			                    	{
				                    	if (Util.getBetween(s,p,i,j)) { %>
		 		                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Pink.JPG" vspace="4" hspace="0" border="0" width="<%=wdt %>" height="5" align="absmiddle">
				<%                			step1=true;
				    					} else {
				    					%>
		 		    						<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" vspace="4" border="0" width="<%=wdt %>" height="5" align="absmiddle">
				<%
				    					}
			%>
		  	                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Grey.JPG" vspace="4" hspace="0" border="0" width="<%=wdt %>" height="5" align="absmiddle">
			<%
			                        }
			                    	else
			                    	{
		%>
		 								<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" vspace="4" border="0" width="<%=wdt %>" height="5" align="absmiddle">
		<%
			                    	}

	                    		}
	                    	}
	                    	else	//-- 실행과제
	                    	{
	                    		if(stopYn.equals("N"))
	                    		{
			                    	if(Util.getBetween(s,e,i,j))
			                    	{
				                    	if (Util.getBetween(s,p,i,j)) { %>
		 		                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Pink.JPG" vspace="4" hspace="0" border="0" width="<%=wdt %>" height="10" align="absmiddle">
				<%                			step1=true;
				    					} else {
				    					%>
		 		    						<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" vspace="4" border="0" width="<%=wdt %>" height="10" align="absmiddle">
				<%
				    					}
			%>
		  	                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Blue.JPG" vspace="4" hspace="0" border="0" width="<%=wdt %>" height="10" align="absmiddle">
			<%
			                        }
			                    	else
			                    	{
		%>
		 								<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" vspace="4" border="0" width="<%=wdt %>" height="10" align="absmiddle">
		<%
			                    	}
	                    		}
	                    		else	//--중단 되었을때.
	                    		{
			                    	if(Util.getBetween(s,e,i,j))
			                    	{
				                    	if (Util.getBetween(s,p,i,j)) { %>
		 		                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Pink.JPG" vspace="4" hspace="0" border="0" width="<%=wdt %>" height="10" align="absmiddle">
				<%                			step1=true;
				    					} else {
				    					%>
		 		    						<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" vspace="4" border="0" width="<%=wdt %>" height="10" align="absmiddle">
				<%
				    					}
			%>
		  	                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Grey.JPG" vspace="4" hspace="0" border="0" width="<%=wdt %>" height="10" align="absmiddle">
			<%
			                        }
			                    	else
			                    	{
		%>
		 								<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" vspace="4" border="0" width="<%=wdt %>" height="10" align="absmiddle">
		<%
			                    	}

	                    		}
	                    	}
	                        out.println("</td>");
	                    }
					}
					else
					{
%>
 							<img src="<%=imgUri %>/jsp/web/images/tp.gif" hspace="0" border="0" width="<%=wdt %>" height="10" align="absmiddle">
<%
					}
                }
%>
              </tr>
<%
            }
%>
            </table>

        </form>
</body>
</html>