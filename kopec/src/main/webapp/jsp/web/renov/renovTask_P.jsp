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
<%@ page import="java.util.ArrayList"%>

<%

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):"";
	if(id.equals(""))
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	RenovTask tp = new RenovTask();
    tp.procDetailQtr1(request,response);

    DataSet qtrSt_Ed = (DataSet)request.getAttribute("qtrSt_Ed");
    DataSet detailQtr1 = (DataSet)request.getAttribute("detailQtr1");

    String prjNm = "";
    String dtlNm = "";
    String desc = "";
    String execwork = "";
    String files = "";


    if(qtrSt_Ed != null)
    {
        while(qtrSt_Ed.next())
        {
            prjNm = qtrSt_Ed.isEmpty("RENOVNAME")?"":qtrSt_Ed.getString("RENOVNAME");
            dtlNm = qtrSt_Ed.isEmpty("RENOVDTLNAME")?"":qtrSt_Ed.getString("RENOVDTLNAME");
            desc = qtrSt_Ed.isEmpty("RENOVDTLDESC")?"":qtrSt_Ed.getString("RENOVDTLDESC");
            execwork = qtrSt_Ed.isEmpty("RENOVEXECWORK")?"":qtrSt_Ed.getString("RENOVEXECWORK");
            files = qtrSt_Ed.isEmpty("FILEPATH")?"":qtrSt_Ed.getString("FILEPATH");
        }
    }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>실행계획(추진계획) 상세정보</title>
</head>
<body>
    <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                  	실행계획(추진계획) 상세정보</strong></td>
              </tr>
	</table>
	<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
      <tr bgcolor="#FFFFFF">
        <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">혁신과제</font></strong></td>
        <td width="85%"><strong><%=prjNm%></strong></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">세부추진내용</font></strong></td>
        <td><%=dtlNm%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">첨부파일</font></strong></td>
        <td>
<%
				if(files!=null)
				{

				//        StringTokenizer stk = new StringTokenizer(fileInfo.getString("FILEPATH"));
				//        while(stk.hasMoreTokens())
				//        {
				//        	out.println("sdfsfsf    " + stk.nextToken() + "<br>");
				//        }

						String fileNM[] = files.split("\\|");

						for(int i=0; i < fileNM.length; i++)
						{
%>
						<a href="./download.jsp?clips=<%=fileNM[i]%>"><%=fileNM[i]%></a><br>
<%
						}
				}
%>

        </td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4" colspan="2" width="98%"><strong><font color="#003399">세부내역</font></strong></td>
	  </tr>
      <tr bgcolor="#FFFFFF">
        <td colspan="2"><taxtarea name="projectNmText" class="input_box" row="10" size="100%" readonly >&nbsp;<%=desc %></taxtarea></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td align="center" bgcolor="#D4DCF4" colspan="2" width="98%"><strong><font color="#003399">추진실적</font></strong></td>
	  </tr>
      <tr bgcolor="#FFFFFF">
        <td colspan="2"><taxtarea name="projectNmText" class="input_box" row="10" size="100%" readonly >&nbsp;<%=execwork %></taxtarea></td>
      </tr>

    </table><!------//프로젝트 끝//---->
<table>
	<tr>
		<td>
		</td>
	</tr>
</table>

            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr bgcolor="#D4DCF4">
                <td align="center"><strong><font color="#003399">분기</font></strong></td>
                <td align="center"><strong><font color="#003399">목표</font></strong></td>
                <td align="center"><strong><font color="#003399">실적</font></strong></td>

              </tr>
<%
			if(detailQtr1 != null && detailQtr1.getRowCount() != 0)
				for(int i=1; i <= 4; i++)
				{
					detailQtr1.next();
//					out.println(detailQtr1.isEmpty("qtr")?0:detailQtr1.getInt("QTR"));
					if(i == (detailQtr1.isEmpty("qtr")?0:detailQtr1.getInt("QTR")))
					{

%>
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=i %></td>
                <td align="center"><%=detailQtr1.isEmpty("GOAL")?"":detailQtr1.getString("GOAL") %></td>
                <td align="center"><%=detailQtr1.isEmpty("ACHV")?"":detailQtr1.getString("ACHV") %></td>
              </tr>
<%					}
					else
					{
%>
              <tr bgcolor="#FFFFFF">
                <td align="center"><%=i %></td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
              </tr>
<%
					}
				}

%>
            </table>
</body>
</html>