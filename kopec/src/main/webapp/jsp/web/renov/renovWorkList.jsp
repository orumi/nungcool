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

	RenovWorkMgr util = new RenovWorkMgr();

	util.setProject(request, response);
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




</script>
<body onload="init()">
				<table width="100%" id="renovList" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
					<form name="form1" method="post" >
						<input type="hidden" name="deptid" value="">
						<input type="hidden" name="year" value="">
<!--  					<tr bgcolor="#FFFFFF">
              				<td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
               	 			�������� ����Ʈ</strong></td>
					</tr>
-->
					<tr bgcolor="#D4DCF4">
		                <td align="center" width="30%"><strong><font color="#003399">���Ű�����</font></strong></td>
		                <td align="center" width="45%"><strong><font color="#003399">��������������ȹ</font></strong></td>
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