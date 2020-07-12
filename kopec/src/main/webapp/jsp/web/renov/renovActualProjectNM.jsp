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

	RenovActual util = new RenovActual();

	util.actualRenov(request, response);
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


		function openDtl(rid, did, achvid) 
		{

			parent.dtl.form1.rid.value = rid;
			parent.dtl.form1.did.value = did;
			parent.dtl.form1.achvid.value = achvid;
			parent.dtl.form1.qtr.value = parent.form1.qtr.options[parent.form1.qtr.selectedIndex].value;
			

			parent.dtl.form1.submit();
			
		}

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
//////////////////////////////////////////////////////////////////////////


</script>
<body onload="init()">
				<table width="100%" border="0" align="left" id="renovList" cellpadding="3" cellspacing="1" bgcolor="#9DB5D7">
					<form name="form1" method="post" action="">
						<input type="hidden" name="deptid" value="">
						<input type="hidden" name="year" value="">
						<input type="hidden" name="qtr" value="">
<!--  					<tr bgcolor="#FFFFFF">
              				<td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
               	 			전략과제 리스트</strong></td>
					</tr>
-->
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="30%"><strong><font color="#003399">혁신과제명</font></strong></td>
		                <td align="center" width="40%"><strong><font color="#003399">세부추진업무계획</font></strong></td>
<!--  		                <td align="center" width="10%"><strong><font color="#003399">분기</font></strong></td>	-->
		                <td align="center" width="10%"><strong><font color="#003399">목표</font></strong></td>
   		                <td align="center" width="10%"><strong><font color="#003399">실적</font></strong></td>
					</tr>
<%
				if(ds != null)
				{
					String renovNM = "";
					String renovDtl = "";
					String renovId = "";
					String renovDid = "";
					String goal = "";
					String achv = "";
					String achvid = "";
					
					
					while(ds.next())
					{
						renovNM = ds.isEmpty("RENOVNAME")?"":ds.getString("RENOVNAME");
						renovDtl = ds.isEmpty("RENOVDTLNAME")?"":ds.getString("RENOVDTLNAME");
						renovId = ds.isEmpty("RENOVID")?"":ds.getString("RENOVID");
						renovDid = ds.isEmpty("RENOVDTLID")?"":ds.getString("RENOVDTLID");
						goal = ds.isEmpty("GOAL")?"":ds.getString("GOAL");
						achv = ds.isEmpty("ACHV")?"":ds.getString("ACHV");
						achvid = ds.isEmpty("achvid")?"":ds.getString("achvid");
						if(!goal.equals(""))
							goal += "%";
						if(!achv.equals(""))
							achv += "%";
						
						if(renovNM.length() >= 10)
							renovNM = renovNM.substring(0, 7) + "...";
						
						if(renovDtl.length() >= 13)
							renovDtl = renovDtl.substring(0, 11) + "...";						
					
%>
					<tr>
						<td bgcolor="#FFFFFF" title="<%=ds.isEmpty("RENOVNAME")?"":ds.getString("RENOVNAME") %>"><%=renovNM %></td>
						<td bgcolor="#FFFFFF" title="<%=ds.isEmpty("RENOVDTLNAME")?"":ds.getString("RENOVDTLNAME") %>"><a href="javaScript:openDtl('<%=renovId %>','<%=renovDid %>','<%=achvid %>');"><%=renovDtl %></a></td>
						<td align="center" bgcolor="#FFFFFF"><%=goal %></td>
						<td align="center" bgcolor="#FFFFFF"><%=achv %></td>
					</tr>
<%
						
					}
				}
%>
	                </tr>
				</form>
            </table>
</body>
</html>