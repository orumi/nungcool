
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%
	request.setCharacterEncoding("EUC-KR");

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

    TaskActualUtil tac = new TaskActualUtil();
    tac.taskActualPopDtl(request, response);
    
	String did = request.getParameter("did");	// 실행계획 id
	
	StringBuffer stYear = new StringBuffer();
	StringBuffer edYear = new StringBuffer();
	StringBuffer sqtr = new StringBuffer();
	StringBuffer eqtr = new StringBuffer();
	
//	for(int i = sYear; i <= eYear; i++)
//	{
//		year.append("<option value=" + i + ">" + i + "</option>");
//	}

//	for(int i = stQtr; i <= 4; i++)
//	{
//		sqtr.append("<option value=" + i + ">" + i + "</option>");
//	}
	
//	for(int i = edQtr; i <= 4; i++)
//	{
//		eqtr.append("<option value=" + i + ">" + i + "</option>");
//	}
	
	
	
	
	DataSet ds = (DataSet)request.getAttribute("ds");
	DataSet ds2 =(DataSet)request.getAttribute("ds2");
	String dtlid = "";
	String prjnm = "";
	String dtlnm = "";
	String dtlWork = "";
	String drvMthd = "";
	String goalLev = "";
	String mgrdept = "";
	String relaDept_1 = "";
	String relaDept_2 = "";
	
	
	String detailnm = "";
	String projnm = "";
	String stopYn = "";
	String stopY = "";
	String stopQ = "";
	
	
	int stY = 0;
	int edY = 0;
	int sQt = 0;
	int eQt = 0;
	if(ds.getRowCount() != 0)
	{
		while(ds.next())
		{
			dtlnm = ds.isEmpty("DTLNAME")?"":ds.getString("DTLNAME");
			drvMthd = ds.isEmpty("DRVMTHD")?"":ds.getString("DRVMTHD");
			goalLev = ds.isEmpty("GOALLEV")?"":ds.getString("GOALLEV");
			dtlid = ds.isEmpty("DTLID")?"":ds.getString("DTLID");
			stY = ds.isEmpty("SYEAR")?0:ds.getInt("SYEAR");
			edY = ds.isEmpty("EYEAR")?0:ds.getInt("EYEAR");
			sQt = ds.isEmpty("SQTR")?0:ds.getInt("SQTR");
			eQt = ds.isEmpty("EQTR")?0:ds.getInt("EQTR");
			mgrdept = ds.isEmpty("MGRDEPT")?"":ds.getString("MGRDEPT");
			relaDept_1 = ds.isEmpty("RELADEPT_1")?"":ds.getString("RELADEPT_1");
			relaDept_2 = ds.isEmpty("RELADEPT_2")?"":ds.getString("RELADEPT_2");
			stopYn = ds.isEmpty("stopyn")?"":ds.getString("stopyn");
			stopY = ds.isEmpty("stopyear")?"":ds.getString("stopyear");
			stopQ = ds.isEmpty("stopqtr")?"":ds.getString("stopqtr");
			
			
		}

	}
	
	
	
	

	if(ds2 !=null)
	{
		while(ds2.next())
		{
			detailnm = ds2.isEmpty("EXECWORK")?"":ds2.getString("EXECWORK");
			projnm = ds2.isEmpty("PNM")?"":ds2.getString("PNM");
		}
	}
	
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>세부실행계획 상세조회 </title>
</head>
<script language="javaScript">

</script>
<body>
    <table width="90%" border="0"  cellpadding="0" cellspacing="0">
              <tr align="left">
                <td height="30" ><strong>&nbsp;<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
				세부실행계획 상세조회
                  </strong></td>
              </tr>
            </table>
		<table width="100%" border="0"  cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				<tr>
	                <td width="19%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">전략적 프로젝트</font></strong></td>
	                <td width="80%" bgcolor="#FFFFFF"><%=projnm %></td>
	         	</tr>
				<tr>
	                <td width="19%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">실행계획</font></strong></td>
	                <td width="80%" bgcolor="#FFFFFF"><%=detailnm %></td>
	         	</tr>
		</table>
		<table>
			<tr>
				<td>
				</td>
			</tr>
		</table>
		<%if(stopYn.equals("Y")){ %>
			<center><b><font color="#FF0000" size="3">중단된 세부실행계획 입니다.</font></b></center>
		<%} %>
			<table width="100%" border="0"  cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<!--  				<tr>
					<td height="30" colspan="4" bgcolor="#FFFFFF"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
	                  	세부사항</strong>
	                </td>
	           </tr>
-->
			<form name="form1" method="post" >
			<input type="hidden" name="mode" value="">
			<input type="hidden" name="did" value="<%=did %>">	<!-- 실행계획id -->
			<input type="hidden" name="dtlid" value="<%=dtlid %>"> <!-- 세부실행계획 id -->
				<tr>
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">세부실행계획</font></strong></td>
	                <td width="80%" bgcolor="#FFFFFF" colspan="3"><%=dtlnm %></td>
	         	</tr>
     		    <tr bgcolor="#FFFFFF">
			      <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주관부서</font></strong></td>
			      <td width="20%" ><strong><input name="projectNmText" type="text" class="input_box" size="17" readonly value="<%=mgrdept%>"></strong></td>
			      <td width="15%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">관련부서</font></strong></td>
			      <td width="45%" >
			       	  <%=relaDept_1%>,&nbsp;
				      <%=relaDept_2%>
			      </td>
			    </tr> 	         	
	             <tr>
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진기간</font></strong></td>
	                <td width="80%" bgcolor="#FFFFFF" colspan="3">
	                    <%=stY%> 년
		                <%=sQt %> 분기
					    ~
	                    <%=edY %> 년
		                <%=sQt %> 분기
	                 </td>
	              </tr>
<!-- 
	              <tr bgcolor="#FFFFFF">
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진방안</font></strong></td>
	                <td width="80%" colspan="3">
	                    <textarea name="pDesc" cols="67" rows="4" class="textarea_box" readonly><%=drvMthd %></textarea>
	                 </td>
	              </tr>
	              <tr bgcolor="#FFFFFF">
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">달성목표</font></strong></td>
	                <td width="80%" colspan="3">
	                    <textarea name="pgDesc" cols="67" rows="4" class="textarea_box" readonly><%=goalLev %></textarea>
	               </td>
	              </tr>
 -->
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="4">
	                	<a href="javascript:window.close();"><img src="<%=imgUri %>/jsp/web/images/btn_close.gif" alt="닫기" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	              </tr>
	           </form>
            </table>
				
</body>
</html>