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
	
	//�����޽��� errMsg.trim�� ���ڿ� �������� �߰�  ���� (���ϸ� �����߻�) 
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
	function fnDetailView(id, code, desc, type){
		
		document.frmDetail.id.value = id;
		document.frmDetail.txtCode.value = code;
		document.frmDetail.txtDesc.value = desc;	
		document.frmDetail.cboType.value = type;
	}	
	
	function fnApply(mode){			
		
		if (mode =='N') {
			
			if (document.frmDetail.txtCode.value != '<new>'){
				
				fnInit();
				document.frmDetail.txtDesc.focus();
			} else {
				
				if (document.frmDetail.txtDesc.value == '') {
					
					alert("�ʼ��Է¿���Դϴ�.");
					document.frmDetail.txtDesc.focus();
				}	
				else {				
					parent.vRefresh = true;
					document.frmDetail.kind.value = "mea";
					document.frmDetail.mode.value = mode;					
					document.frmDetail.submit();
				}
			}						
		}	   
		
		else if (mode == 'U') {							
			if (document.frmDetail.txtCode.value == '<new>'){				
				alert("������  ������ �����Ͻʽÿ�.");									
			}				
			else if (document.frmDetail.txtDesc.value == '') {					
				alert("�ʼ��Է¿���Դϴ�.");
				document.frmDetail.txtDesc.focus();
			}	
			else if(confirm("������  �����Ͻðڽ��ϱ�?")){
				parent.vRefresh = true;
				document.frmDetail.kind.value = "mea";
				document.frmDetail.mode.value = mode;
				document.frmDetail.submit();			
			}
		}					
		else if (mode == 'D') {								
			if (document.frmDetail.txtCode.value == '<new>'){				
				alert("������ ������ �����Ͻʽÿ�.");	
			}		
			else if(confirm("������ �����Ͻðڽ��ϱ�?")){
				parent.vRefresh = true;
				document.frmDetail.kind.value = "mea";
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
            <!-------/�ڵ� , ��Ī, ��ũ, ����/------>
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
              <tr>
                <td width="80" align="center" bgcolor="#DCEDF6"><font color="#006699"><strong>�ڵ�</strong></font></td>
                <td bgcolor="#FFFFFF"><input name = "txtCode" type="text" size="12" disabled class="input_box"></td>
                <td width="80" align="center" bgcolor="#DCEDF6"><font color="#006699"><strong>��Ī</strong></font></td>
                <td bgcolor="#FFFFFF"><input name="txtDesc" type="text" size="52" class="input_box"></td>
                <td width="80" align="center" bgcolor="#DCEDF6"><font color="#006699"><strong>����</strong></font></td>
                <td bgcolor="#FFFFFF"><select name="cboType">
                	<option value="C">������ǥ</option>
            		<option value="I">������ǥ</option>
                </td>
              </tr>
            </table>
            <!-----/End/-------->
          </td>
        </tr>
        <tr> <!-----/��ư/--->
          <td height="30" align="right">
            <img src="<%=imgUri%>/jsp/web/images/btn_add.gif" alt="�߰�" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('N');" style="cursor:hand">&nbsp;
            <img src="<%=imgUri%>/jsp/web/images/btn_edit.gif" alt="����" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('U');" style="cursor:hand">&nbsp;
            <img src="<%=imgUri%>/jsp/web/images/btn_delete.gif" alt="����" width="50" height="20" border="0" align="absmiddle" onclick="javascript:fnApply('D');" style="cursor:hand">
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>      
            
      <!---------//��ܰ˻� �� ��//--------->
      <!-------//�ϴ� ����Ʈ //------->
      <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
        <tr align="center" bgcolor="#D4DCF4">
          <td width="80" align="center"><font color="#003399"><strong>�ڵ�</strong></font></td>
          <td width="520" align="center"><font color="#003399"><strong>��Ī</strong></font></td>
          <td align="center"><font color="#003399"><strong>����</strong></font></td>
        </tr>
      </table>
      <div style="width:100%;height:400px;overflow:auto;overflow-x:hidden;">
        <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
        <% if (ds != null){ 
			while(ds.next()) {%>
	        
	          <tr bgcolor="#FFFFFF" onclick = "javascript:fnDetailView('<%=ds.getInt("ID")%>','<%=ds.getString("CODE")%>','<%=ds.getString("NAME") %>','<%=ds.getString("MEASCHAR") %>')" ONMOUSEOVER="this.style.backgroundColor='#E5F2FF';" 
				ONMOUSEOUT="this.style.backgroundColor='FFFFFF';" STYLE="cursor:hand">
	            <td width="80" align="center"><%=ds.getString("CODE")%> </td>
	            <td width="520"><%=ds.getString("NAME")%> </td>
	            <td align="center"><%=ds.getString("MEASCHAR").equals("I")?"������ǥ":"������ǥ"%> </td>
	          </tr>
	        <% 
			}
		}
		%>	  
        </table>
      </div>
      <!------//����Ʈ end//------>
      <!-------------------//Page Contents Area End//-------------------->
    </td>
  </tr>
</table>
</form>
</body>
</html>

