<!-- 
�����ۼ��� : ������ 
�Ҽ� 		 : ����
�����ۼ��� : 2007.07.11 ������ : ������ 
>-------------- ���� ����  --------------<
������ : 


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
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
    
    
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	RenovActual util = new RenovActual();

	util.actualRenov(request, response);
	DataSet ds = (DataSet)request.getAttribute("ds");	//���Ű���



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
		cellMergeChk(document.all.renovList, 1, 0);		//ù��° td ó��
	}

/////////////////////////////////////////////////////////////////////////////////// cellmarge
//tableId :  table id�� 
//rowIndex : table�� ���� row index(0���� ����)
//cellIndex : �ش� row�� cell index(0���� ����)
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
		var compareCellsLen = tableObj.rows(rowIndex).cells.length;		//���� row�� cell ����
		
		//�ʱ�ȭ	
		var compareObj = tableObj.rows(rowIndex).cells(cellIndex);
		var compareValue = compareObj.innerHTML;
		var cn = 1;
		var delCells = new Array();
		var arrCellIndex = new Array();
		for(i=rowIndex+1; i < rowsCn; i++)
		{
			var cellsLen = tableObj.rows(i).cells.length;
			var bufCellIndex = cellIndex

			//�������� row�� cellIndex�� ������.			
			if(compareCellsLen != cellsLen) 
			{
				bufCellIndex = bufCellIndex - (compareCellsLen - cellsLen);
			}
			cellObj = tableObj.rows(i).cells(bufCellIndex);
			
			if(compareValue == cellObj.innerHTML)
			{
				delCells[cn-1] = tableObj.rows(i);		//������ cell�� row�� �����Ѵ�.
				arrCellIndex[cn - 1] = bufCellIndex;	//�ش� row cell index�� �����Ѵ�.
				cn++;
			}
			else
			{
				//����
				compareObj.rowSpan = cn;
				
				//����
				for(j=0; j < delCells.length; j++)
				{
					delCells[j].deleteCell(arrCellIndex[j]);
				}
				
				//�ʱ�ȭ	
				compareObj = cellObj;
				compareValue = cellObj.innerHTML;
				cn = 1;
				delCells = new Array();
				arrCellIndex = new Array();
			}
		}

		//����		
		compareObj.rowSpan = cn;
		//����
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
               	 			�������� ����Ʈ</strong></td>
					</tr>
-->
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="30%"><strong><font color="#003399">���Ű�����</font></strong></td>
		                <td align="center" width="40%"><strong><font color="#003399">��������������ȹ</font></strong></td>
<!--  		                <td align="center" width="10%"><strong><font color="#003399">�б�</font></strong></td>	-->
		                <td align="center" width="10%"><strong><font color="#003399">��ǥ</font></strong></td>
   		                <td align="center" width="10%"><strong><font color="#003399">����</font></strong></td>
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