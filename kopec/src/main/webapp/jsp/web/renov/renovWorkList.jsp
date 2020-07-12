<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 2007.07.11 수정자 : 조영훈 
>-------------- 수정 사항  --------------<
수정일 : 


 -->
 
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.renov.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    
    request.setCharacterEncoding("euc-kr");

	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
    
    
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	RenovWorkMgr util = new RenovWorkMgr();

	util.setProject(request, response);
	DataSet ds = (DataSet)request.getAttribute("ds");	//혁신과제



%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">
		var prjList = new Array();

		function openDetail(pid, pname) {
//			alert(pid);
			if (parent.detail.form1.pid.value !=null) {
				parent.detail.form1.pid.value=pid;
//				alert("aaa");
				parent.detail.form1.pname.value=pname;
//				parent.detail.form1.submit();

				parent.dlist.form5.pid.value=pid;
				parent.dlist.form5.submit();
			}
		}

		var refresh = false;

	function init()
	{
		cellMergeChk(document.all.renovList, 1, 0);		//첫번째 td 처리
	}

/////////////////////////////////////////////////////////////////////////////////// cellmarge
//tableId :  table id를 
//rowIndex : table의 시작 row index(0부터 시작)
//cellIndex : 해당 row의 cell index(0부터 시작)
// created by singi(20030611)
///////////////////////////////////////////////////////////////////////////////////
	function cellMergeChk(tableObj, rowIndex, cellIndex)
	{
		var rowsCn = tableObj.rows.length;
		
		if(rowsCn-1 > rowIndex)
			cellMergeProcess(tableObj, rowIndex, cellIndex);
			
	}
	
	function cellMergeProcess(tableObj, rowIndex, cellIndex)
	{
		var rowsCn = tableObj.rows.length;
		var compareCellsLen = tableObj.rows(rowIndex).cells.length;		//시작 row에 cell 개수
		
		//초기화	
		var compareObj = tableObj.rows(rowIndex).cells(cellIndex);
		var compareValue = compareObj.innerHTML;
		var cn = 1;
		var delCells = new Array();
		var arrCellIndex = new Array();
		for(i=rowIndex+1; i < rowsCn; i++)
		{
			var cellsLen = tableObj.rows(i).cells.length;
			var bufCellIndex = cellIndex

			//실질적인 row에 cellIndex를 구하자.			
			if(compareCellsLen != cellsLen) 
			{
				bufCellIndex = bufCellIndex - (compareCellsLen - cellsLen);
			}
			cellObj = tableObj.rows(i).cells(bufCellIndex);
			
			if(compareValue == cellObj.innerHTML)
			{
				delCells[cn-1] = tableObj.rows(i);		//삭제할 cell의 row를 저장한다.
				arrCellIndex[cn - 1] = bufCellIndex;	//해당 row cell index를 저장한다.
				cn++;
			}
			else
			{
				//병합
				compareObj.rowSpan = cn;
				
				//삭제
				for(j=0; j < delCells.length; j++)
				{
					delCells[j].deleteCell(arrCellIndex[j]);
				}
				
				//초기화	
				compareObj = cellObj;
				compareValue = cellObj.innerHTML;
				cn = 1;
				delCells = new Array();
				arrCellIndex = new Array();
			}
		}

		//병합		
		compareObj.rowSpan = cn;
		//삭제
		for(j=0; j < delCells.length; j++)
		{
			delCells[j].deleteCell(arrCellIndex[j]);
		}
	}




</script>
<body onload="init()">
				<table width="100%" id="renovList" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
					<form name="form1" method="post" >
						<input type="hidden" name="deptid" value="">
						<input type="hidden" name="year" value="">
<!--  					<tr bgcolor="#FFFFFF">
              				<td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
               	 			전략과제 리스트</strong></td>
					</tr>
-->
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="30%"><strong><font color="#003399">혁신과제명</font></strong></td>
		                <td align="center" width="45%"><strong><font color="#003399">세부추진업무계획</font></strong></td>
					</tr>

<%
					if(ds != null)
						while(ds.next()) 
						{
%>
	                <tr bgcolor="#FFFFFF">
		                <td align="left">
							<a href="javascript:openDetail('<%=ds.getString("RENOVID")%>','<%=ds.getString("RENOVNAME")%>');">
								<%=ds.getString("RENOVNAME") %>
		                </a>
		                </td>
						<td>

<% 
							String dtlname = ds.isEmpty("RENOVDTLNAME")?"":ds.getString("RENOVDTLNAME");
							if(dtlname.length() > 15) 
								out.print(dtlname.subSequence(0, 12)+"..."      );
							else
								out.print(dtlname);
%>
							</a>
						</td>
	                </tr>
<%
						}
%>				</form>
            </table>
</body>
</html>