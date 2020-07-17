<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import ="com.nc.util.*, com.nc.component.ComponentUtil" %>

<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String mode = 	request.getParameter("mode");

	ComponentUtil util = new ComponentUtil();
	util.setComponent(request,response);

	DataSet ds = (DataSet)request.getAttribute("ds");


	String errMsg = (String) request.getAttribute("errMsg");

	//에러메시지 errMsg.trim은 문자열 마지막줄 추가  제거 (안하면 에러발생)
	if (errMsg != null) {	%>
	<script language="JavaScript" type="text/JavaScript">
	<!--
	alert("<%= errMsg.trim() %>");
	-->
	</script>
	<%}
%>

<html>
<head>

<script type="text/javascript">
<!--
	function fnDetailView(id, code, desc, link){

		document.frmDetail.id.value = id;
		document.frmDetail.txtCode.value = code;
		document.frmDetail.txtDesc.value = desc;
	}

	function fnApply(mode){

		if (mode =='N') {

			if (document.frmDetail.txtCode.value != '<new>'){

				fnInit();
				document.frmDetail.txtDesc.focus();
			} else {

				if (document.frmDetail.txtDesc.value == '') {

					alert("필수입력요소입니다.");
					document.frmDetail.txtDesc.focus();
				}
				else {
					parent.vRefresh = true;
					document.frmDetail.kind.value = "com";
					document.frmDetail.mode.value = mode;
					document.frmDetail.submit();
				}
			}
		}

		else if (mode == 'U') {
			if (document.frmDetail.txtCode.value == '<new>'){
				alert("수정할  정보를 선택하십시오.");
			}
			else if (document.frmDetail.txtDesc.value == '') {
				alert("필수입력요소입니다.");
				document.frmDetail.txtDesc.focus();
			}
			else if(confirm("정보를  수정하시겠습니까?")){
				parent.vRefresh = true;
				document.frmDetail.kind.value = "com";
				document.frmDetail.mode.value = mode;
				document.frmDetail.submit();
			}
		}
		else if (mode == 'D') {
			if (document.frmDetail.txtCode.value == '<new>'){
				alert("삭제할 정보를 선택하십시오.");
			}
			else if(confirm("정보를 삭제하시겠습니까?")){
				parent.vRefresh = true;
				document.frmDetail.kind.value = "com";
				document.frmDetail.mode.value = mode;
				document.frmDetail.submit();
			}
		}

	}

	function fnInit() {

		document.frmDetail.mode.value = '';
		document.frmDetail.searchKey.value = '';
		document.frmDetail.id.value = '';
		document.frmDetail.txtCode.value = '<new>';
		document.frmDetail.txtDesc.value = '';

	}

	function fnDetailRefresh(){

		parent.fnRefresh();
		fnInit();
	}

//-->
</script>

<title>companyDetail</title>
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name = "frmDetail" action method = "post">
<input type = "hidden"  name = "kind">
<input type = "hidden"  name = "mode">
<input type = "hidden"  name = "searchKey">
<input type = "hidden"  name = "id">

<table id="tab" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <!-------/코드 , 명칭, 링크, 설명/------>
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#c1c1c1">
              <tr>
                <td width="80" align="center" style="height:36px;font-size:13px;background-color:#f6f6f6;"><font color="#333333"><strong>코드</strong></font></td>
                <td bgcolor="#FFFFFF"><input name = "txtCode" type="text" size="12" disabled class="input_box"></td>
                <td width="80" align="center" style="height:36px;font-size:13px;background-color:#f6f6f6;"><font color="#333333"><strong>명칭</strong></font></td>
                <td bgcolor="#FFFFFF"><input name="txtDesc" type="text" size="52" class="input_box"></td>
              </tr>
            </table>
            <!-----/End/-------->
          </td>
        </tr>
        <tr> <!-----/버튼/--->
          <td height="30" align="right">
            <img src="<%=imgUri%>/jsp/web/images/btn_add.gif" alt="추가" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('N');" style="cursor:hand">&nbsp;
            <img src="<%=imgUri%>/jsp/web/images/btn_edit.gif" alt="수정" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('U');" style="cursor:hand">&nbsp;
            <img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('D');" style="cursor:hand">
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>

      <!---------//상단검색 폼 끝//--------->
      <!-------//하단 리스트 //------->
      <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
        <tr align="center" bgcolor="#375f9c">
          <td width="80"><strong><font color="#ffffff">코드</font></strong></td>
          <td><strong><font color="#ffffff">명칭</font></strong></td>
        </tr>
      </table>
      <div style="width:100%;height:400px;overflow:auto;overflow-x:hidden;">
        <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
        <% if (ds != null){
			while(ds.next()) {%>

	          <tr bgcolor="#FFFFFF" onclick = "javascript:fnDetailView('<%=ds.getInt("ID")%>','<%=ds.getString("CODE")%>','<%=ds.getString("NAME") %>')" ONMOUSEOVER="this.style.backgroundColor='#E5F2FF';"
				ONMOUSEOUT="this.style.backgroundColor='FFFFFF';" STYLE="cursor:hand">
	            <td width="80" align="center"><%=ds.getString("CODE")%> </td>
	            <td><%=ds.getString("NAME")%> </td>

	          </tr>
	        <%
			}
		}
		%>
        </table>
      </div>
      <!------//리스트 end//------>
      <!-------------------//Page Contents Area End//-------------------->
    </td>
  </tr>
</table>
</form>
</body>
</html>

