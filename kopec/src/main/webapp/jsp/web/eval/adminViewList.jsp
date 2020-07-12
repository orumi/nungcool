<%@ page contentType="text/html; charset=euc-kr"%>

<% 

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
	
	//if (ds != null) out.println(ds);
%>

<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

<script>
  var dwin;
  function openDetail(grpId,sbuId){
  	dwin = window.open("./evalPopup.jsp?grpId="+grpId+"&sbuId="+sbuId+"&strDate=<%="200706"%>","ActualDetail","toolbar=no,location=no,width=800,height=600,scrollbars=yes,resizable=yes");
  	dwin.focus();
  }
  
	function mergeCell(tbl, startRow, cNum, length, add) {
		var isAdd = false;
		if(tbl == null) return;
		if(startRow == null || startRow.length == 0) startRow = 1;
		if(cNum == null || cNum.length == 0) return ;
		if(add  == null || add.length == 0) {
			isAdd = false;
		} else {
			isAdd = true;
			add   = parseInt(add);
		}
		cNum   = parseInt(cNum);
		length = parseInt(length);
	
		rows   = tbl.rows;
		rowNum = rows.length;
	
		tempVal  = '';
		cnt      = 0;
		startRow = parseInt(startRow);
	
		for( i = startRow; i < rowNum; i++ ) { 
			curVal = rows[i].cells[cNum].innerHTML;
			if(isAdd) curVal += rows[i].cells[add].innerHTML;
			if( curVal == tempVal ) {
				if(cnt == 0) {
					cnt++;
					startRow = i - 1;
				}
				cnt++;
			}else if(cnt > 0) {
				merge(tbl, startRow, cnt, cNum, length);
				startRow = endRow = 0;
				cnt = 0;
			}else {
			}
			tempVal = curVal;
		}
	
		if(cnt > 0) {
			merge(tbl, startRow, cnt, cNum, length);
		}
	}
	
	/*******************************************
	    mergeCell
	********************************************/
	function merge(tbl, startRow, cnt, cellNum, length) {
		rows = tbl.rows;
		row  = rows[startRow];
	
		for( i = startRow + 1; i < startRow + cnt; i++ ) {
			for( j = 0; j < length; j++) {
				rows[i].deleteCell(cellNum);
			}
		}
		for( j = 0; j < length; j++) {
			row.cells[cellNum + j].rowSpan = cnt;
		}
	}
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="form1" method="post" action="">
	<input type="hidden" name="mode">
	<input type="hidden" name="strDate" value="<%="200706" %>">

	  <!-------//평가결과 조회 리스트//------->
	  <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" id="tbl01">
        <tr align="center" valign="middle"  bgcolor="#D4DCF4"> 
		    <td width="20%" ><strong><font color="#003399">평가그룹</font></strong></td>
		    <td width="25%" ><strong><font color="#003399">평가 조직명</font></strong></td>
		    <td width="15%" ><strong><font color="#003399">BSC 점수</font></strong></td>
		    <td width="15%" ><strong><font color="#003399">평가 점수</font></strong></td>
		    <td width="15%" ><strong><font color="#003399">최종 점수</font></strong></td>
		    <td width="10%" ><strong><font color="#003399">순위</font></strong></td>
		  </tr>

        <tr bgcolor="#FFFFFF"> 
          <td align="left"><%="NAME" %></td>
          <td align="left"><%="DNAME" %></a></td>
          <td align="center"><%="WSCORE" %></td>
          <td align="center"><%="WESCORE" %></td>
          <td align="center"><%="FSCORE" %></td>
          <td align="center"><%="RANK" %></td>
        </tr>



      </table>
      
</form>      
      <!-------------//하단 테이블  Layout End//-------------->
</body>
<script>
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	mergeCell(document.getElementById('tbl01'), '0', '0', '1','');
</script>