<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	String sn = request.getParameter("sn");
	String strdate = request.getParameter("strDate")!=null?request.getParameter("strDate"):Util.getSemi(Util.getToDay().substring(0,6));
	
    EvalAdminUtil util = new EvalAdminUtil();
    util.setAdminGroup(request, response);
    
    DataSet dsDiv = (DataSet)request.getAttribute("dsDiv");
	DataSet dsGrp = (DataSet)request.getAttribute("dsGrp");
	DataSet dsDetail = (DataSet)request.getAttribute("dsDetail");
    
    StringBuffer sbDiv = new StringBuffer();
    StringBuffer sbGrp = new StringBuffer();
    String selGroup = request.getParameter("selGroup")==null?"":request.getParameter("selGroup");
    
    try{
    	if (dsDiv != null)
    	while(dsDiv.next()){
    		sbDiv.append("<option value='"+dsDiv.getInt("ID")+"'>"+dsDiv.getString("NAME")+"</option>");
    	}
    	
    	
    } catch (Exception e){
    	System.out.println(e);
    }
%>

<script>
	var arrayOrg = new Array();
	
	function initrs(code,name,parent,level,i){
		var rslength = 0;
		arrayOrg[i] = new orgCD(code,name,parent,level);
	}
	
	function orgCD(code,name,parent,level){
		this.code = code;
		this.name = name;
		this.parent = parent;
		this.level = level;
	}
	
	function changeGroup(){ 
    	var length = arrayOrg.length;

   		var parentcode = form1.selGroup.options[form1.selGroup.selectedIndex].value;
   		form1.selGroupDetail.length = 0;
    	
   		for ( i = 0; i < length; i++ ){
    		if ( arrayOrg[i].level == '1'){
    			if ( arrayOrg[i].parent == parentcode ){
    				form1.selGroupDetail.options[form1.selGroupDetail.length] = new Option(arrayOrg[i].name, arrayOrg[i].code);
    			}
    		}
    	}
    	
    	for (j=0;j<length;j++){
			if (arrayOrg[j].code==parentcode){
				form1.groupNameR.value=arrayOrg[j].name;
				return;
			}
		}
    }
    
    function clearSelect(){
    	form1.selDiv.length = 0;
    	form1.selGroup.length = 0;
    	form1.selGroupDetail.length = 0;
    }
    
    
	function actionPerformed(mode){
		if ('GI'==mode){
			if (form1.groupName.value=='') {
				alert('�׷���� �Է��Ͻʽÿ�');
				return;
			}
			form1.tag.value = 'G';
			form1.mode.value = mode;
			form1.submit();
			
		} else if ('GM'==mode){
			if (-1 == form1.selGroup.selectedIndex){
				alert('�ش� �� �׷��� �����ϼž� �˴ϴ�.');
				return;
			}
			if (form1.groupNameR.value==""){
				alert('������ �׷���� �Է��Ͻʽÿ�');
				return;
			}
			form1.mode.value=mode;
			form1.grpCode.value=form1.selGroup.options[form1.selGroup.selectedIndex].value;
			form1.submit();			
		} else if ('GD'==mode){
			if (-1 == form1.selGroup.selectedIndex){
				alert('�ش� �� �׷��� �����ϼž� �˴ϴ�.');
				return;
			}
			if (confirm('�ش��� �׷��� �����Ͻðڽ��ϱ�?')){
				form1.mode.value=mode;
				form1.grpCode.value=form1.selGroup.options[form1.selGroup.selectedIndex].value;
				form1.submit();
			}
		} else if ('DI'==mode){
			form1.mode.value=mode;
			form1.grpCode.value=form1.selGroup.options[form1.selGroup.selectedIndex].value;
			form1.divCode.value=form1.selDiv.options[form1.selDiv.selectedIndex].value;
			form1.submit();
		} else if ('DD'==mode){
			if(confirm('�ش����� �����Ͻðڽ��ϱ�?')){
				form1.mode.value=mode;
				form1.grpCode.value=form1.selGroup.options[form1.selGroup.selectedIndex].value;
				form1.divCode.value=form1.selGroupDetail.options[form1.selGroupDetail.selectedIndex].value;
				form1.submit();
			}			
		}
	}
	
	function sendItem(){
		if (-1 == form1.selDiv.selectedIndex){
			alert('�ش� ��ǥ�� �����ϼž� �˴ϴ�.');
			return;
		}
		if (-1 == form1.selGroup.selectedIndex){
			alert('�ش� �� �׷��� �����ϼž� �˴ϴ�.');
			return;
		}
		actionPerformed('DI');
	}
	
	function delItem(){
		if (-1 == form1.selGroup.selectedIndex){
			alert('�ش� �� �׷��� �����ϼž� �˴ϴ�.');
			return;
		}
		if (-1 == form1.selGroupDetail.selectedIndex){
			alert('�ش� ��ǥ�� �����ϼž� �˴ϴ�.');
			return;
		}
		actionPerformed('DD');		
	}
</script>
<%
	int cnt = 0;
	if (dsGrp!=null){
		while(dsGrp.next()){ %>
			<script>
			initrs('<%=dsGrp.getInt("GRPID")%>','<%=dsGrp.getString("GRPNM")%>','0','0',<%=cnt++%>);
			</script>	
		<%
			sbGrp.append("<option value='"+dsGrp.getInt("GRPID")+"'>"+dsGrp.getString("GRPNM")+"</option>");
		}
		
	}

	if (dsDetail!=null){
		while(dsDetail.next()){ %>
			<script>
			initrs('<%=dsDetail.getInt("EVALDEPTID")%>','<%=dsDetail.getString("NAME")%>','<%=dsDetail.getInt("GRPID")%>','1',<%=cnt++%>);
			</script>			
		<% 
		
		}
	}
%>
	<form name="form1" method="post" action="">
	<input type="hidden" name="tag">
	<input type="hidden" name="mode">
	<input type="hidden" name="strDate" value="<%=strdate %>">
	<input type="hidden" name="divCode">
	<input type="hidden" name="divName">
	<input type="hidden" name="grpCode">
	<input type="hidden" name="grpName">
	<input type="hidden" name="detCode">
	<input type="hidden" name="detName">
	
	<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
	  <!-------------// //-------------->
      <table width="100" border="0" align="left" cellpadding="5" cellspacing="1">
        <tr> 
          <td rowspan="2" valign="top">
		  
		  <!-------//�μ���� ���̺�//----->
		  <table width="200" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr>
                <td align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>��跮 ��ǥ���</strong></font></td>
              </tr>
              <tr>
                <td align="center" bgcolor="#FFFFFF">
                
                  <select name="selDiv" style="width:200px;" size="25">
                  	<%= sbDiv %>
                  </select>
                 
                 </td>
              </tr>
            </table>
			 <!-------//�μ���� ���̺� ��//----->
			</td>
          <td width="35">&nbsp;</td>
          <td valign="top">
		  
		   <!-------//�򰡱׷� ���̺�//----->
		  <table width="210" border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
              <tr> 
                <td align="center" bgcolor="#E0E0E0"><font color="#000000"><strong>�򰡱׷�</strong></font></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF">
                  <input name="groupName" type="text" class="input_box">
                  <a href="javascript:actionPerformed('GI');"><img src="<%=imgUri%>/jsp/web/images/btn_ss_add.gif" alt="�߰�" width="34" height="14" border="0" align="absmiddle"></a></td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#FFFFFF">
                  <select name="selGroup" style="width:200px;" size="10" onChange="javascript:changeGroup();">
                  	<%= sbGrp.toString() %>
                  </select>
                </td>
              </tr>
              <tr> 
                <td bgcolor="#FFFFFF"><input name="groupNameR" type="text" class="input_box" size="15">
                  <a href="javascript:actionPerformed('GM');"><img src="<%=imgUri%>/jsp/web/images/btn_ss_edit.gif" alt="����" width="34" height="14" border="0" align="absmiddle"></a> 
                  <a href="javascript:actionPerformed('GD');"><img src="<%=imgUri%>/jsp/web/images/btn_ss_delete.gif" alt="����" width="34" height="14" border="0" align="absmiddle"></a> 
                </td>
              </tr>
            </table>
			 <!-------//�򰡱׷� ���̺� ��//----->
			
			</td>
        </tr>
        <tr> 
            <td align="center"> 
              <!------/�¿� ȭ��ǥ ��ư/------>
              <a href="javascript:sendItem();"><img src="<%=imgUri%>/jsp/web/images/icon_go_right.gif" alt="�����̵�" width="17" height="17" border="0"></a><br>
              <br>
            <a href="javascript:delItem();"><img src="<%=imgUri%>/jsp/web/images/icon_go_left.gif" alt="�����̵�" width="17" height="17" border="0"></a> 
          </td>
          <td valign="top">
		  
		  <!--------//�򰡺μ� ���̺�//------->
		  <table width="210" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr> 
                <td align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>����ǥ</strong></font></td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#FFFFFF">
                  <select name="selGroupDetail" style="width:200px;" size="6">
                  </select>
                </td>
              </tr>
            </table>
			<!--------//�򰡺μ� ���̺�//------->
			
			</td>
        </tr>
      </table>
      <!-------// //------->
      </form>
<% if(selGroup != ""){ %>      
      <script>
      	form1.selGroup.value = "<%=selGroup%>";
      	changeGroup();
      </script>
 <% } %>