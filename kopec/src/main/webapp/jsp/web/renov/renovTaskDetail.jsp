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
<%@ page import="com.nc.util.*"%>
<%
	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):"";
	if(id.equals(""))
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
		
		return;
	}
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	RenovTask ta = new RenovTask();
    ta.setDetail(request, response);

    String year = request.getParameter("year")==null?"2007":request.getParameter("year");
    String qtr = request.getParameter("qtr");
    String dept = request.getParameter("dept");

    DataSet proc = (DataSet)request.getAttribute("proc");



%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>실행 계획 조회</title>
</head>
<script language="javaScript">

    function procDetail(prjid, deptid)
    {
    	var year = parent.form1.year.options[parent.form1.year.selectedIndex].value;
    	var dept = deptid;
        window.open('./renovTask_P.jsp?did='+ prjid +'&dept='+ dept + '&year=' + year,'', 'width=700, height=500',scrollbars='yes');
    }
    
    
	function init()
	{
		cellMergeChk(document.all.renovList, 2, 0);		//첫번째 td 처리
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
//		alert(compareValue);
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
//			alert(cn);
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
		<table align="right">
			<tr align="right">
			    <td>
                    <img src="<%=imgUri %>/jsp/web/images/imageBar_Blue.JPG" hspace="0" border="0" width="20" height="9"> : 계획
                    <img src="<%=imgUri %>/jsp/web/images/imageBar_Pink.JPG" hspace="0" border="0" width="20" height="9"> : 진행
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
        <input type="hidden" name="year" value="">
        <input type="hidden" name="qtr" value="">
        <input type="hidden" name="mgrdept" value="">
        <input type="hidden" name="parentid" value="">
			<!--------//리스트 //------->
            <table border="0" cellpadding="0" id="renovList" cellspacing="1" bgcolor="#9DB5D7" width="100%">
              <tr bgcolor="#FFFFFF">
                <td rowspan="2" bgcolor="#D4DCF4" width="90" align="center"><strong><font color="#003399">혁신과제명</font></strong></td>
                <td rowspan="2" bgcolor="#D4DCF4" width="190" align="center"><strong><font color="#003399">세부추진업무계획</font></strong></td>
                <td rowspan="2" bgcolor="#D4DCF4" width="90" align="center"><strong><font color="#003399">담당부서</font></strong></td>
                <td rowspan="2" bgcolor="#D4DCF4" align="center"><strong><font color="#003399">&nbsp;&nbsp;진도율<br>&nbsp;(달성률)</font></strong></td>
                <td colspan="4" align="center" bgcolor="#D4DCF4"><%=year %></td>
              </tr>
              <tr bgcolor="#FFFFFF"><!-- 분기 -->
                    <td align="center">1분기</td>
                    <td align="center">2분기</td>
                    <td align="center">3분기</td>
                    <td align="center">4분기</td>
              </tr>
<%
				if(proc!=null)
                while(proc.next())
                {
                	int acP = 0;
                	double acA = proc.isEmpty("REALIZE")?0:proc.getDouble("REALIZE");
                	String planned = proc.isEmpty("GOAL")?"":proc.getString("GOAL");
                	String actual = proc.isEmpty("ACHV")?"":proc.getString("ACHV");
					String execWork = proc.isEmpty("RENOVDTLNAME")?"":proc.getString("RENOVDTLNAME");
					String renovName= proc.isEmpty("RENOVNAME")?"":proc.getString("RENOVNAME");
					String deptnm= proc.isEmpty("deptnm")?"":proc.getString("deptnm");
					int eqtr = proc.isEmpty("eqtr")?0:proc.getInt("eqtr");
					int sqtr = proc.isEmpty("sqtr")?0:proc.getInt("sqtr");
					
					if(execWork.length() >= 25)
					{
						execWork = execWork.substring(0,23)+"...";
					}

					if(renovName.length() >= 15)
					{
						renovName = renovName.substring(0,12)+"...";
					}
%>
              <tr bgcolor="#FFFFFF">
                <td align="left" height=25  title="<%=proc.isEmpty("RENOVNAME")?"":proc.getString("RENOVNAME") %>">&nbsp;&nbsp;<%=renovName%></a></td>
                <td align="left" height="25" title="<%=proc.isEmpty("RENOVDTLNAME")?"":proc.getString("RENOVDTLNAME") %>"><a href="javaScript:procDetail('<%=proc.getString("RENOVDTLID")%>','<%=proc.getString("ID")%>');">&nbsp;&nbsp;<%=execWork%></td>
                <td align="left" height=25  title="<%=proc.isEmpty("deptnm")?"":proc.getString("deptnm") %>">&nbsp;&nbsp;<%=deptnm%></a></td>
                <td align="center" height=25 >
					<table align="center" width="50" cellpadding="0" cellspacing="1" >
						<tr><td valign="bottom" align="center">
						 <img src="<%=imgUri %>/jsp/web/images/imageBar_Red.JPG" hspace="0" border="0" width="4" height="<%if(15*acA/100 > 15){out.println(15);}else if(15*acA/100 == 0){out.println(0);}else if(15*acA/100 <= 20){out.println(15*acA/100);}else{out.println(18);} %>" align="bottom">
						 <img src="<%=imgUri %>/jsp/web/images/imageBar_Green.JPG" hspace="0" border="0" width="4" height="13" align="bottom">
						</td></tr>
						<tr><td align="center">
						 <%=actual+"/"+planned+"("+acA+")" %>
						</td></tr>
					</table>
				</td>
<%

				int s = Integer.parseInt((year)+(proc.isEmpty("SQTR")?"0":proc.getString("SQTR")));
				int e = Integer.parseInt((year)+(proc.isEmpty("EQTR")?"0":proc.getString("EQTR")));
				int p = Integer.parseInt((year)+(proc.isEmpty("QTR")?"0":proc.getString("QTR")));
//				int stYear = Integer.parseInt((proc.isEmpty("SYEAR")?"0":proc.getString("SYEAR")));
//				int edYear = Integer.parseInt((proc.isEmpty("EYEAR")?"0":proc.getString("EYEAR")));
//				boolean step1=false;
//				int minYear = Integer.parseInt(year);
//				int maxYear = Integer.parseInt(year);
				for(int j = 1; j < 5; j++)          //-- 분기
	            {
	
	              	out.println("<td align=\"left\" height=\"45\"  width=\"30\">");
	               	if(Util.getBetween(s,e,Integer.parseInt(year),j)) 
	               	{
		               	if (Util.getBetween(s,p,Integer.parseInt(year),j)) 
		               	{ 
%>
		        	   		<img src="<%=imgUri %>/jsp/web/images/imageBar_Pink.JPG" vspace="4" hspace="0" border="0" width="40" height="10" align="absmiddle">
<%      
    					} 
		               	else 
    					{
%>
		    						<img src="<%=imgUri %>/jsp/web/images/tp.gif" vspace="4" hspace="0" border="0" width="40" height="10" align="absmiddle">
		<%
		    			}
	%>
	                    		<img src="<%=imgUri %>/jsp/web/images/imageBar_Blue.JPG" vspace="4" hspace="0" border="0" width="40" height="10" align="absmiddle">
	<%
	              	}
	               	else
	               	{
%>
						<img src="<%=imgUri %>/jsp/web/images/tp.gif" vspace="4" hspace="0" border="0" width="40" height="10" align="absmiddle">
<%
	               	}
	                        out.println("</td>");
				}
%>
				
<%
            }
%>

            </table>

        </form>
</body>
</html>