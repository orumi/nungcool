
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
<title>::: ���� ��������(BSC)�ý��� �Ŵ��� :::</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
<!--
	//�ʱ�ȭ 
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
		//search�϶� 
		if (mode=='Q') {			
			//frameDetail�� searchkey�� ���� �Ѱ��ְ� submit�Ѵ�.
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
<!----------//��� �˻�  //---------->
	<table width = "100%" height="4.4%" border = "0" align = "center" cellpadding = "0" cellspacing = "0">
		<tr>
        	<td height="30"><img src="<%=imgUri%>/images/icon_point_01.gif" width="8" height="9" align="absmiddle">
            	<strong>������ǥ :</strong> <input name="txtSearch" type="text" class="input_box" size="40" onKeypress="javascript: if (event.keyCode =='13') fnSearch('Q');">
            <img src="<%=imgUri%>/jsp/web/images/btn_search.gif" name = "btnSearch" alt="�˻�" width="50" height="20" border="0" align="absmiddle" style="cursor:hand" onclick="javascript:fnSearch('Q');">
          </td>
        </tr>
      </table>
      <table width="100%" height="95.6%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <!--iframe ����-->
            <iframe id="frameDetail" frameborder="0" src="measureDetail.jsp" width="100%" height="100%" scrolling="no">&nbsp;</iframe>	
            <!--iframe ��-->
          </td>
        </tr>
      </table>
</body>
</html>
