<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%

    String modir = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 

	if(modir.equals("")) 
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

	TaskActualUtil taz = new TaskActualUtil();
	taz.taskDetail(request, response);


	DataSet dsType = (DataSet)request.getAttribute("dsType");
	DataSet dsProj = (DataSet)request.getAttribute("dsProj");

	StringBuffer sbType = new StringBuffer();
	StringBuffer sbProj = new StringBuffer();


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<Script Language="javaScript">
	var arrOrg = new Array();

	function initrs(code,name,parent,level) {
		arrOrg[arrOrg.length] = new orgCD(code,name,parent,level);
	}



	function orgCD(code,name,parent,level) {
		this.code = code;
		this.name = name;
		this.parent = parent;
		this.level = level;
	}

	function typeChange() {
        prjCnt = 0; //유형별 프로젝트 카운트
		if(form1.rowCnt.value != 0) {
			var length = arrOrg.length;

			var parentcode = form1.typeSelect.options[form1.typeSelect.selectedIndex].value;
			form1.projectSel.length = 0;
	   		for ( i = 0; i < length; i++ )
	   		{
      	    		if( arrOrg[i].level == '1')
      	    		{
      	    			if ( arrOrg[i].parent == parentcode )
      	    			{
      	    			    prjCnt++;
      	    				form1.projectSel.options[form1.projectSel.length] = new Option(arrOrg[i].name, arrOrg[i].code);
      	    			}
          			}
       		}
		}

	}

	function changeType() {
		form1.selProj.length=0;
		var length = arrOrg.length;
		var typeCode = form1.selType.options[form1.selType.selectedIndex].value;

		var j=0;
		var cid ;
		for(var i=0;i<length;i++){
			if (arrOrg[i].level==1){
				if (arrOrg[i].parent ==typeCode){
					form1.selProj.options[form1.selProj.length] = new Option(arrOrg[i].name,arrOrg[i].code);
					if(j==0){
						cid = arrOrg[i].code;
						j++;
					}
				}
			}
		}

	}

	function changeProj() {

	}

    function modiProject() {
            detail.form1.projectId.value = form1.selProj.options[form1.selProj.selectedIndex].value;

            detail.form1.submit();
	}



	</Script>
<%
	int i = 0;
	int curType = 0;

	if (dsType!=null) {
		while(dsType.next()) {
			sbType.append("<option value='"+dsType.getString("TYPEID")+"'>"+dsType.getString("TYPENAME")+"</option>");
			if (i==0){
				curType = dsType.getInt("TYPEID");
			}
			i++;
		}
	}

	if (dsProj!=null) {
		int j = 0;
		while(dsProj.next()){
				j++;
				%>
					<script>
					initrs('<%=dsProj.getString("ID")%>','<%=dsProj.getString("NAME")%>','<%=dsProj.getString("TYPEID")%>','1');
					</script>
				<%

				if (curType==dsProj.getInt("TYPEID")){
					sbProj.append("<option value='"+dsProj.getString("ID")+"'>"+dsProj.getString("NAME")+"</option>")	;
				}
		}

	}	%>
<body >
<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
              <form name="form1" method="post" action="">
                <tr bgcolor="#DCEDF6">
                  <td width="15%" align="center" bgcolor="#DCEDF6">
                  	<strong>
	                  	<font color="#006699">혁신전략
	                  	</font>
                  	</strong>
                  </td>
                  <td width="20%" bgcolor="#FFFFFF">
                  	<select name="selType" style="width:180px;" onChange="javascript:changeType();">
						<%=sbType.toString() %>
                    </select>
                  </td>
                  <td width="15%" align="center" bgcolor="#DCEDF6">
                  	<strong>
	                  	<font color="#006699">Sub 전략
	                  	</font>
                  	</strong>
                  </td>
                  <td bgcolor="#FFFFFF">
                  	<select name="selProj" style="width:200px;" onChange="javascript:changeProj();">
						<%= sbProj.toString() %>
                    </select>

                    	<a href="javascript:modiProject();" >
                    		<img src="<%=imgUri %>/jsp/web/images/btn_ok.gif" alt="확인" width="50" height="20" border="0" align="absmiddle" >
                    	</a>
                  </td>
                </tr>
              </form>
            </table>
			<!-------------->
			<!------//프로젝트 세부정보//---->
             
             <iframe frameborder="0" id="detail" SCROLLING="yes" src="./taskDetailProject.jsp" style="body" width="100%" height="90%" >&nbsp;</iframe>
			<!--------//리스트 //------->

</body>
</html>
