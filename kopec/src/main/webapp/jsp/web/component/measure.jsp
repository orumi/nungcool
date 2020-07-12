
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import ="com.nc.util.Common, 
					com.nc.component.ComponentUtil" %>

<%

	String imgUri = request.getRequestURI();
  	imgUri = imgUri.substring(1);
  	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
%>

<html>
<head>
<title>::: 넝쿨 성과관리(BSC)시스템 매니저 :::</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
<!--
	//초기화 
	var vRefresh;
	function fnRefresh()
	{
		if (vRefresh  != null) {			
			if (vRefresh == true) {				
				frameDetail.document.frmDetail.mode.value = 'Q';
				frameDetail.document.frmDetail.searchKey.value = txtSearch.value;
				frameDetail.document.frmDetail.submit();
				vRefresh = false;		
			}
		}	
	}

	function fnSearch(mode){		
		//search일때 
		if (mode=='Q') {			
			//frameDetail의 searchkey에 값을 넘겨주고 submit한다.
			frameDetail.document.frmDetail.kind.value = "mea";
			frameDetail.document.frmDetail.mode.value = mode;
			frameDetail.document.frmDetail.searchKey.value = txtSearch.value;
			frameDetail.document.frmDetail.submit();					
		}		
	}
//-->
</script>
</head>

<body leftmargin = "0" topmargin = "0" marginwidth = "0" marginheight = "0">
<!----------//상단 검색  //---------->
	<table width = "100%" height="4.4%" border = "0" align = "center" cellpadding = "0" cellspacing = "0">
		<tr>
        	<td height="30"><img src="<%=imgUri%>/images/icon_point_01.gif" width="8" height="9" align="absmiddle">
            	<strong>성과지표 :</strong> <input name="txtSearch" type="text" class="input_box" size="40" onKeypress="javascript: if (event.keyCode =='13') fnSearch('Q');">
            <img src="<%=imgUri%>/jsp/web/images/btn_search.gif" name = "btnSearch" alt="검색" width="50" height="20" border="0" align="absmiddle" style="cursor:hand" onclick="javascript:fnSearch('Q');">
          </td>
        </tr>
      </table>
      <table width="100%" height="95.6%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <!--iframe 시작-->
            <iframe id="frameDetail" frameborder="0" src="measureDetail.jsp" width="100%" height="100%" scrolling="no">&nbsp;</iframe>	
            <!--iframe 끝-->
          </td>
        </tr>
      </table>
</body>
</html>
