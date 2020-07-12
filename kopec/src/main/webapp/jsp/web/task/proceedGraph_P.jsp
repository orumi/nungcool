<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="java.util.ArrayList"%>

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
    tp.procDetailQtr1(request,response);

    DataSet qtrSt_Ed = (DataSet)request.getAttribute("qtrSt_Ed");
    DataSet detailQtr1 = (DataSet)request.getAttribute("detailQtr1");
	
    String div = request.getParameter("div");	//유형id
	String sdtlid = request.getParameter("sdtlid");
	String pdtlid = request.getParameter("pdtlid");
	String dtlid = "";
	if(div.equals("1"))
	{
		dtlid = sdtlid;
	}
	else
	{
		dtlid = pdtlid;
	}
	

    String prjNm = "";
    String execwork = "";
	String dtlname = "";
	String deptNm = "";
	String relaDept_1 = "";
	String relaDept_2 = "";
	String stopYn = "";
	String stopY = "";
	String stopQ = "";
	String sQtr = "";
	String eQtr = "";
	String stopStr = ""	;
    int syear = 0;
    int eyear = 0;
    if(qtrSt_Ed != null)
    {
        while(qtrSt_Ed.next())
        {
            prjNm = qtrSt_Ed.isEmpty("NAME")?"":qtrSt_Ed.getString("NAME");
            execwork = qtrSt_Ed.isEmpty("EXECWORK")?"":qtrSt_Ed.getString("EXECWORK");
            deptNm = qtrSt_Ed.isEmpty("MGRDEPT")?"":qtrSt_Ed.getString("MGRDEPT");
            syear = qtrSt_Ed.isEmpty("SYEAR")?0:qtrSt_Ed.getInt("SYEAR");
            eyear = qtrSt_Ed.isEmpty("EYEAR")?0:qtrSt_Ed.getInt("EYEAR");
            sQtr = qtrSt_Ed.isEmpty("SQTR")?"":qtrSt_Ed.getString("SQTR");
            eQtr = qtrSt_Ed.isEmpty("EQTR")?"":qtrSt_Ed.getString("EQTR");
            dtlname = qtrSt_Ed.isEmpty("DTLNAME")?"":qtrSt_Ed.getString("DTLNAME");
            //relaDept_1 = qtrSt_Ed.isEmpty("RELADEPT_1")?"":qtrSt_Ed.getString("RELADEPT_1");
            //relaDept_2 = qtrSt_Ed.isEmpty("RELADEPT_2")?"":qtrSt_Ed.getString("RELADEPT_2");
            //stopYn = qtrSt_Ed.isEmpty("STOPYN")?"":qtrSt_Ed.getString("STOPYN");
            //stopY = qtrSt_Ed.isEmpty("STOPYEAR")?"":qtrSt_Ed.getString("STOPYEAR");
            //stopQ = qtrSt_Ed.isEmpty("STOPQTR")?"":qtrSt_Ed.getString("STOPQTR");
        }
    }
    if(stopYn.equals("Y"))
		stopStr = stopY + "년도 " + stopQ + "분기";
    
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<%if(div.equals("2")) {%>
<title>추진계획 상세정보</title>
<%}	else if(div.equals("1")) 
		if(!sdtlid.equals("0"))
		{ 
			out.print("<title>세부실행계획 상세정보</title>");
		}
		else
		{
			out.print("<title>실행계획 상세정보</title>");
		}
%>

</head>

<script>
	var exeWin;
	function openChildPop()
	{

//				var typeid = parent.detail.form1.selType.options[parent.detail.form1.selType.selectedIndex].value;
				var url = "taskActual_P.jsp?detailid="+<%=dtlid%>+"&typeid="+<%=div%>+"&mode=P" ;
//				var url = "taskActual_P.jsp?";
			    exeWin = window.open(url, '실행과제추가', 'toolbar=no,Width=650px,Height=500px,scroll=yes,resizable=no,menubar:yes,help=no,status=yes');

			    exeWin.focus();
	}
	
	function filePop(year, qtr)
	{
//				var typeid = parent.detail.form1.selType.options[parent.detail.form1.selType.selectedIndex].value;
//				var url = "achvFile_P.jsp?did="+<%=dtlid%>+"&typeid="+<%=div%>+"&year="+year+"&qtr="+qtr;
//				var url = "achvFile_P.jsp?detailid="+;
//			    exeWin = window.open(url, '실행과제추가', 'toolbar=yes,Width=400px,Height=500px,scroll=yes,resizable=no,menubar:yes,help=no,status=yes');

//			    exeWin.focus();
		
		fileList.form1.typeid.value = <%=div%>;
		fileList.form1.qtr.value = qtr;
		fileList.form1.did.value = <%=dtlid%>;
		fileList.form1.year.value = year;
		fileList.form1.submit();
	}
</script>
<body>
    <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
<%if(div.equals("2")) {%>
추진계획 진척목표달성율
<%}	else if(div.equals("1")) 
		if(!sdtlid.equals("0"))
		{ 
			out.print("세부실행계획 진도율");
		}
		else
		{
			out.print("실행계획 진척목표달성율");
		}
%>
                  	</strong></td>
              </tr>
	</table>
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">Sub 전략</font></strong></td>
        <td width="85%" colspan="3"><strong><input name="projectNmText" type="text" class="input_box" size="80" readonly value="<%=prjNm%>"></strong></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주관부서</font></strong></td>
        <td width="20%" colspan=3><strong><input name="projectNmText" type="text" class="input_box" size="20" readonly value="<%=deptNm%>"></strong></td>

      </tr>      
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">실행과제<br>(추진과제)</font></strong></td>
        <td colspan="3"><input name="projectNmText" type="text" class="input_box" size="75" readonly value="<%=execwork%>">
		<%if(div.equals("2")){ %>
            <a href="javascript:openChildPop();">
        		<img src="<%=imgUri %>/jsp/web/images/btn_plann_actual01.gif" width="81" height="20" align="absmiddle">
        	</a>
        	<%} %>
        </td>
      </tr>
      <%if(div.equals("2")){ %>
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진기간</font></strong></td>
        <td width="30%" ><%=syear+"년 " + sQtr + "분기 ~ " + eyear + "년 " + eQtr + "분기"  %></td>
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">중단시점</font></strong></td>
        <td width="50%" ><%=stopStr %></td>
      </tr> 
      <%} %>      
      
      
	<%if(div.equals("1")&& !sdtlid.equals("0")) { %>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주요추진내용</font></strong></td>
        <td colspan="3"><input name="projectNmText" type="text" class="input_box" size="75" readonly value="<%=dtlname%>">

        </td>
      </tr>	
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진기간</font></strong></td>
        <td width="30%" colspan=3><%=syear+"년 " + sQtr + "분기 ~ " + eyear + "년 " + eQtr + "분기"  %></td>
      </tr>      
	<%}%>
    </table><!------//프로젝트 끝//---->
      	<%if(stopYn.equals("Y")&&div.equals("1")){ %>
      	<br><center><b><font color="#FF0000" size="3">중단된 추진과제 입니다.</font></b></center>
		<%}else if(stopYn.equals("Y")&&div.equals("2")){ %>
		<br><center><b><font color="#FF0000" size="3">중단된 추진업무 입니다.</font></b></center>
		<%} %>
<table>
	<tr>
		<td>
		</td>
	</tr>
</table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<%if(div.equals("1")&& sdtlid.equals("0")) { //전략적 프로젝트의 실행 과제 일때.%>	
		      <tr bgcolor="#D4DCF4">
                <td align="center"><strong><font color="#003399">년도</font></strong></td>
                <td align="center"><strong><font color="#003399">1분기 달성률</font></strong></td>
                <td align="center"><strong><font color="#003399">2분기 달성률</font></strong></td>
                <td align="center"><strong><font color="#003399">3분기 달성률</font></strong></td>
                <td align="center"><strong><font color="#003399">4분기 달성률</font></strong></td>
              </tr>
<%
            if(detailQtr1 != null && detailQtr1.getRowCount() != 0)
            {
                for(int i = syear; i <= eyear; i++)	//--세부실행 과제의 추진기간 년도를 가져와서 추진기간에 입력이 안된 년도 까지 표시
                {
               		detailQtr1.next();
               		if(i == detailQtr1.getInt("YEAR"))
               		{
               			String realize = detailQtr1.isEmpty("REALIZE")?"":detailQtr1.getString("REALIZE");
						if(realize == null)
							realize = "";
%>              
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=detailQtr1.isEmpty("YEAR")?"":detailQtr1.getString("YEAR")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR1")?"":detailQtr1.getString("QTR1")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR2")?"":detailQtr1.getString("QTR2")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR3")?"":detailQtr1.getString("QTR3")%></td>
                <td align="center"><%=detailQtr1.isEmpty("QTR4")?"":detailQtr1.getString("QTR4")%></td>
              </tr>
<%
               		}
               		else
               		{
%>              
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=i %></td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>                
                <td align="center">&nbsp;</td>  
              </tr>
<%
               		}
                }
            }
%>
              <tr bgcolor="#FFFFFF">
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>                
                <td align="center">&nbsp;</td>                
              </tr> 
<%} else { //전략적프로젝트의 세부실행 과제 일때 & 중점 추진 업무 %>	
             <tr bgcolor="#D4DCF4">
                <td align="center"><strong><font color="#003399">년도</font></strong></td>
                <td align="center"><strong><font color="#003399">1분기<br>실적/목표(달성률)</font></strong></td>
                <td align="center"><strong><font color="#003399">2분기<br>실적/목표(달성률)</font></strong></td>
                <td align="center"><strong><font color="#003399">3분기<br>실적/목표(달성률)</font></strong></td>
                <td align="center"><strong><font color="#003399">4분기<br>실적/목표(달성률)</font></strong></td>
              </tr>
<%
            if(detailQtr1 != null && detailQtr1.getRowCount() != 0)
            {
                for(int i = syear; i <= eyear; i++)	//--세부실행 과제의 추진기간 년도를 가져와서 추진기간에 입력이 안된 년도 까지 표시
                {
               		detailQtr1.next();
               		if(i == detailQtr1.getInt("YEAR"))
               		{
%>
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=detailQtr1.isEmpty("YEAR")?"":detailQtr1.getString("YEAR")%>
                </td>
                <td align="center"><%=detailQtr1.isEmpty("QTR1")?"":detailQtr1.getString("QTR1")%>
	                <a href="javascript:filePop('<%=detailQtr1.getString("YEAR")%>','1');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
                </td>
                <td align="center"><%=detailQtr1.isEmpty("QTR2")?"":detailQtr1.getString("QTR2")%>
	                <a href="javascript:filePop('<%=detailQtr1.getString("YEAR")%>','2');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
                </td>
                <td align="center"><%=detailQtr1.isEmpty("QTR3")?"":detailQtr1.getString("QTR3")%>
	                <a href="javascript:filePop('<%=detailQtr1.getString("YEAR")%>','3');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
                </td>
                <td align="center"><%=detailQtr1.isEmpty("QTR4")?"":detailQtr1.getString("QTR4")%>
	                <a href="javascript:filePop('<%=detailQtr1.getString("YEAR")%>','4');"><img src="<%=imgUri %>/jsp/web/images/btn_search_go.gif" width="21" height="20" align="absmiddle">
                </td>
              </tr>
<%
               		}
               		else
               		{
%>
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=i %></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
              </tr>
<%
               		}
                }
            }
%>
<%} %>
            </table>
<%if(!(div.equals("1")&& sdtlid.equals("0"))) { //전략적 프로젝트의 실행 과제가 아닐때.%>	            
            <iframe frameborder="0" id="fileList" SCROLLING="no" src="./achvFiles.jsp" style="body" width="100%" height="90%" >&nbsp;</iframe>
<%} %>
</body>
</html>