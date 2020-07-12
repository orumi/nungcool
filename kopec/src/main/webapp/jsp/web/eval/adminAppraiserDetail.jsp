<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*" %>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
	String strDate = request.getParameter("strDate")!=null?request.getParameter("strDate"):Util.getToDay();

    String year = strDate.substring(0,4);
    String selGroup = request.getParameter("selGroup")==null?"":request.getParameter("selGroup");
    
    EvalAdminUtil util = new EvalAdminUtil();
    util.setAdminAppraiser(request, response);
    
    DataSet dsUser = (DataSet)request.getAttribute("dsUser");
    DataSet dsGroup = (DataSet)request.getAttribute("dsGroup");
    DataSet dsAppraiser = (DataSet)request.getAttribute("dsAppraiser");
    
    StringBuffer sbUser = new StringBuffer();
    StringBuffer sbGroup = new StringBuffer();
    StringBuffer sbApp = new StringBuffer();
    try{
    	if (dsUser !=null)
    	while(dsUser.next()){
    		sbUser.append("<option value='"+dsUser.getString("USERID")+"'>"+dsUser.getString("USERNAME")+"</option>");
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
   		form1.selAppraiser.length = 0;
    	
   		for ( i = 0; i < length; i++ ){
    		if ( arrayOrg[i].level == '1'){
    			if ( arrayOrg[i].parent == parentcode ){
    				form1.selAppraiser.options[form1.selAppraiser.length] = new Option(arrayOrg[i].name, arrayOrg[i].code);
    			}
    		}
    	}
    }
    
    function clearSelect(){
    	form1.selUser.length = 0;
    	form1.selGroup.length = 0;
    	form1.selAppraiser.length = 0;
    }

	function actionPerformed(mode){
		if ('AI'==mode){
			form1.mode.value = mode;
			form1.grpCode.value=form1.selGroup.options[form1.selGroup.selectedIndex].value;
			form1.userId.value=form1.selUser.options[form1.selUser.selectedIndex].value;
			form1.submit();
			
		} else if ('AD'==mode){
			if (confirm('평가자를 삭제하시겠습니까?')){
				form1.mode.value=mode;
				form1.grpCode.value=form1.selGroup.options[form1.selGroup.selectedIndex].value;
				form1.appCode.value=form1.selAppraiser.options[form1.selAppraiser.selectedIndex].value;
				form1.submit();
			}
		}
	}

	function addUser(){
		if (-1 == form1.selUser.selectedIndex){
			alert('평가자를 선택하셔야 됩니다.');
			return;
		}
		if (-1 == form1.selGroup.selectedIndex){
			alert('해당 평가 그룹을 선택하셔야 됩니다.');
			return;
		}
		actionPerformed('AI');
	}
	
	function delUser(){
		if (-1 == form1.selGroup.selectedIndex){
			alert('해당 평가 그룹을 선택하셔야 됩니다.');
			return;
		}
		if (-1 == form1.selAppraiser.selectedIndex){
			alert('평가자를 선택하셔야 됩니다.');
			return;
		}
		actionPerformed('AD');		
	}
</script>

<%
int cnt = 0;
int gid = 0;
if (dsGroup!=null){
	while(dsGroup.next()){ 
		if (cnt == 0) gid=dsGroup.getInt("GRPID");
	%>
		<script>
		initrs('<%=dsGroup.getInt("GRPID")%>','<%=dsGroup.getString("GRPNM")%>','0','0',<%=cnt++%>);
		</script>	
	<%
		sbGroup.append("<option value='"+dsGroup.getInt("GRPID")+"'>"+dsGroup.getString("GRPNM")+"</option>");
	}
}

if (dsAppraiser!=null){
	while(dsAppraiser.next()){ %>
		<script>
		initrs('<%=dsAppraiser.getString("EVALRID")%>','<%=dsAppraiser.getString("USERNAME")%>','<%=dsAppraiser.getInt("GRPID")%>','1',<%=cnt++%>);
		</script>			
		
	<% 
		if (dsAppraiser.getInt("GRPID")==gid){
			sbApp.append("<option value='"+dsAppraiser.getString("EVALRID")+"'>"+dsAppraiser.getString("USERNAME")+"</option>");	
		}
	}
}
%>


<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
	<form name="form1" method="post" action="">
	<input type="hidden" name="tag">
	<input type="hidden" name="mode">
	<input type="hidden" name="strDate" value="<%=strDate %>">
	<input type="hidden" name="grpCode">
	<input type="hidden" name="appCode">
	<input type="hidden" name="userId">
        <table width="100" border="0" align="left" cellpadding="5" cellspacing="1">
          <tr> 
            <td valign="top"> 
              <!-------//평가단목록 테이블//----->
              <table width="200" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
                <tr> 
                  <td align="center" bgcolor="#D4DCF4"><font color="#003399"><strong>평가단 목록</strong></font></td>
                </tr>
                <tr> 
                  <td align="center" bgcolor="#FFFFFF">
                    <select name="selUser" style="width:200px;" size="20">
                    <%= sbUser.toString() %>
                    </select>
                   </td>
                </tr>
              </table>
              <!-------//부서목록 테이블 끝//----->
            </td>
            <td width="35"> 
              <!------/좌우 화살표 버튼/------>
              <a href="javascript:addUser();"><img src="<%=imgUri%>/jsp/web/images/icon_go_right.gif" alt="우측이동" width="17" height="17" border="0"></a><br> 
              <br> <a href="javascript:delUser();"><img src="<%=imgUri%>/jsp/web/images/icon_go_left.gif" alt="좌측이동" width="17" height="17" border="0"></a> 
            </td>
            <td valign="top"> 
              <!-------//평가단정보 테이블//----->
              <table width="200" border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
                <tr> 
                  <td align="center" bgcolor="#E0E0E0"><font color="#000000"><strong>평가단 정보</strong></font></td>
                </tr>
                <tr> 
                  <td bgcolor="#FFFFFF">평가그룹: 
                    <select name=selGroup style="width:120px;" onChange="javascript:changeGroup();">
                    <%=sbGroup.toString() %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td align="center" bgcolor="#FFFFFF">
                  	<select name="selAppraiser" style="width:200px;" size="18">
                  	<%=sbApp.toString() %>
                    </select>
                  </td>
                </tr>
              </table>
              <!-------//평가단정보 테이블 끝//----->
              
            </td>
          </tr>
        </table>
	   </form>
<% 		if(selGroup != ""){ %>      
	      <script>
	      	form1.selGroup.value = "<%=selGroup%>";
	      	changeGroup();
	      </script>
 <%  	} %>
<%
	} catch (Exception e){
    	System.out.println(e);
    }
%>