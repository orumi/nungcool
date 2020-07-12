<!-- 
최초작성자 : 조영훈 
소속 		 : 넝쿨
최초작성일 : 
>-------------- 수정 사항  --------------<
수정일 : 2007.07.05 수정자 : 조영훈 


 -->


<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>

<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String id = (String)session.getAttribute("userId")!=null?(String)session.getAttribute("userId"):""; 
	if(id.equals("")) 
	{
%>
<script>
		alert("잘못된 접속입니다.");
  		top.location.href = "../loginProc.jsp";
</script>
<%  }%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script language="javaScript">

	function setYear(sYear,eYear,cYear){
		selYear.length=0;

		for(var i=sYear;i<=eYear;i++){
			selYear.options[selYear.length] = new Option(i,i);
		}

		selYear.value=cYear;
	}

	function changeYear(){
		pdetail.form1.mode.value="G";
		pdetail.form1.year.value = selYear.options[selYear.selectedIndex].value;
		pdetail.form1.submit();
	}

</script>




<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<!-------------->

            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="200">
                	<!------//프로젝트//---->
             		<iframe frameborder="0" id="proList" SCROLLING="auto" src="./taskActualProjectNM.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
            		<!------//프로젝트 끝//---->
            	</td>
            	<td>
					<!--------//리스트 //------->
		             <iframe frameborder="0" id="taskList" SCROLLING="auto" src="./taskActualList.jsp" style="body" width="100%" height="100%" >&nbsp;</iframe>
					<!--------//리스트 끝 //------->
            	</td>
              </tr>
              <tr>
              	<td colspan="2" valign="top">

				    <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				      <tr bgcolor="#FFFFFF">
				        <td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
         	 			실적등록</strong></td>
				      </tr>
				      <tr bgcolor="#FFFFFF">
				        <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">실행계획(추진계획)</font></strong></td>
				        <td width="85%"><strong><font color="#FF3300">
				        <input type="text" name="achvNm" value="" style="width:280px" readonly></font></strong></td>
				      </tr>
				      <tr bgcolor="#FFFFFF">
				        <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">해당년도</font></strong></td>
				        <td><select name="selYear" onChange="javascript:changeYear();">
				            <option value="2008">2008</option>
				          </select> <a href="javascript:getQtr();"><img src="<%=imgUri %>/jsp/web/images/btn_ok.gif" alt="확인" width="50" height="20" border="0" align="absmiddle"></a>
				          <strong></strong></td>
				      </tr>
				    </table>
              	</td>
              </tr>
              <tr><td colspan="2">
                <iframe frameborder="0" id="pdetail" src="./taskActualAchvIns.jsp" SCROLLING="NO" style="body" width="100%" height="150%" ></iframe>
              </td></tr>
            </table>
</body>
</html>