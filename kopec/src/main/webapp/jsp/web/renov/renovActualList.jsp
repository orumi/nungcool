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
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.StrConvert"%>
<%

    String modir = session.getAttribute("groupId")==null?"":(String)session.getAttribute("groupId");
    request.setCharacterEncoding("euc-kr");
    String auth = session.getAttribute("auth01")==null?"":(String)session.getAttribute("auth01");

	if(modir.equals(""))
	{
		out.print("<script>");
		out.print("alert('잘못된 접속입니다.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}

	String imgUri = request.getRequestURI();
	String dtlDesc = "";
	String goal = "";
	String achv = "";
	String qtr = "";
	String rid = "";
	String did = "";
	String execWork = "";
	StringBuffer comb = new StringBuffer();
	String achvid = "";


	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	RenovActual util = new RenovActual();

	util.actualDtl(request, response);

	DataSet dtl = (DataSet)request.getAttribute("ds");

	DataSet userChk = (DataSet)request.getAttribute("userChk");
	String mgrYn = "N";	//담당자 여부
	if(modir.equals("1"))
		mgrYn = "Y";

	if(userChk.getRowCount() != 0)
		mgrYn = "Y";	//담당자 여부





	if(dtl != null)
	{
		while(dtl.next())
		{
			dtlDesc = dtl.isEmpty("RENOVDTLNAME")?"":dtl.getString("RENOVDTLNAME");

			goal = dtl.isEmpty("GOAL")?"":dtl.getString("GOAL");
			achv = dtl.isEmpty("ACHV")?"":dtl.getString("ACHV");
			qtr = dtl.isEmpty("qtr")?"":dtl.getString("qtr");
			rid = dtl.isEmpty("RENOVID")?"":dtl.getString("RENOVID");
			did = dtl.isEmpty("RENOVDTLID")?"":dtl.getString("RENOVDTLID");
			execWork = dtl.isEmpty("DRVEXECACHV")?"":dtl.getString("DRVEXECACHV");
			achvid = dtl.isEmpty("ACHVID")?"":dtl.getString("ACHVID");
		}


	}

	for(int i = 1; i <= 4; i++)
	{
		if(String.valueOf(i).equals(qtr))
		{
			comb.append("<option value=" + i +" selected>" + i + " 분기" + "</option>\n");
		}
		else
		{
			comb.append("<option value=" + i +">" + i + " 분기" + "</option>\n");
		}
	}







	String msg = (String) request.getAttribute("msg");


    if (msg!=null)
    {
    	if(msg.equals("1"))
    	{
%>
		<script>
			parent.openDetail();
		</script>

<%    	}
    }

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javaScript">
		var prjList = new Array();

		function projectIUD(idx, dtlCnt, achvCnt) {
		}


		function actionPerformed(tag, dnm)
		{
			if('<%=mgrYn%>' == 'N')
			{
				alert("부서의 담당자가 아닙니다.\n담당자에게 문의 하세요.");
				return;
			}

			if (tag=="C"){

				if (form1.achvid.value==""){
					if (form1.goal.value=="")
					{

						alert("목표를 입력 하십시오");
						return;
					}

					if(form1.achv.value=="")
					{

						alert("실적를 입력 하십시오");
						return;
					}

					if(form1.pgDesc.value=="")
					{

						alert("추진실적를 기술 하십시오");
						return;
					}

					isdigit(form1.goal.value, form1.achv.value);

//					parent.list.refresh=true;
					form1.qtr.value = parent.form1.qtr.options[parent.form1.qtr.selectedIndex].value;
					alert(form1.qtr.value);
					form1.mode.value=tag;
					form1.submit();
				} else {
					clearComponent();
				}

			} else if (tag=="U") {
				if (form1.achvid.value=="") {
					alert("수정할 목록을 선택하십시오");
					return;
				}
				isdigit(form1.goal.value, form1.achv.value);
				form1.mode.value=tag;
				form1.submit();
				clearComponent();

			} else if (tag=="D") {
				var qtr = parent.form1.qtr.options[parent.form1.qtr.selectedIndex].value
				if (form1.rid.value=="") {
					alert("삭제할 목록을 선택하십시오");
					return;
				}
				if (confirm("선택한 세부추진내용의 "+qtr+"분기 실적을 삭제하시겠습니까?")){
//					parent.list.refresh=true;

					form1.mode.value=tag;
					form1.submit();
				}

			}
		}

		function saveAct()
		{
			if('<%=mgrYn%>' == 'N')
			{
				alert("부서의 담당자가 아닙니다.\n담당자에게 문의 하세요.");
				return;
			}

			if (form1.goal.value=="")
			{

				alert("목표를 입력 하십시오");
				return;
			}

			if(form1.achv.value=="")
			{
				alert("실적를 입력 하십시오");
				return;
			}

			if(form1.pgDesc.value=="")
			{

				alert("추진실적를 기술 하십시오");
				return;
			}

			isdigit(form1.goal.value, form1.achv.value);

			parent.list.refresh=true;
			form1.qtr.value = parent.form1.qtr.options[parent.form1.qtr.selectedIndex].value;

			form1.mode.value="C"
			form1.submit();




		}

		function clearComponent()
		{
			form1.achvid.value="";
			form1.goal.value="";
			form1.achv.value="";
			form1.pgDesc.value="";
		}

		function detailRefresh(){
			//alert(parent.list.refresh);
			if (parent.list.refresh==true){
				parent.list.form1.submit();
			}
		}



		function isdigit(goal, achv)
		{
		    if (goal.search(/[^0-9]/g)!=-1)
		    {
		       	alert("목표/실적에는 숫자만 입력 가능 합니다.");
		       	return ;
		    }


		    if (achv.search(/[^0-9]/g)!=-1)
		    {
		       	alert("목표/실적에는 숫자만 입력 가능 합니다.");
		       	return ;
			}
		}

	    function openFilePopup(did)
	    {
	    	if('<%=mgrYn%>' == 'N')
			{
				alert("부서의 담당자가 아닙니다.\n담당자에게 문의 하세요.");
				return;
			}
			if (form1.achvid.value=="")
			{
				alert("세부추진내용 선택하십시오");
				return;
			}
//	     	var year = parent.selYear.options[parent.selYear.selectedIndex].value;
			var url = "./renovActualFileUpload_P.jsp?did="+did;
	        fileWin =  window.open(url, '세부실행과제추가', 'width=310,height=120' );
	    }

</script>
<body>
			<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
<!--  				<tr>
					<td height="30" colspan="4" bgcolor="#FFFFFF"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
	                  	세부사항</strong>
	                </td>
	           </tr>
-->
			<form name="form1" action="" method="post">
			<input type="hidden" name="mode">
			<input type="hidden" name="rid" value="<%=rid %>">
			<input type="hidden" name="did" value="<%=did %>">
			<input type="hidden" name="achvid" value="<%=achvid %>">
			<input type="hidden" name="qtr" value="">


				<tr>
	                <td width="25%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">세부<br>추진업무계획</font></strong></td>
	                <td width="75%" bgcolor="#FFFFFF" colspan="4" colspan="3"><textarea name="dtlDesc" cols="45" readonly ><%=dtlDesc %></textarea></td>
	         	</tr>
	             <tr>
	                <td width="25%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">목표</font></strong></td>
	                <td bgcolor="#FFFFFF" width="25%" >
						<input name="goal" value="<%=goal %>" size="3" maxlength="3" <%if(!(mgrYn.equals("Y") || auth.equals("1")))out.print("readonly"); %>>%
	                 </td>
	                <td width="25%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">실적</font></strong></td>
	                <td width="25%" bgcolor="#FFFFFF" >
	                	<input name="achv" value="<%=achv %>" size="3" maxlength="3" <%if(!(mgrYn.equals("Y") || auth.equals("1")))out.print("readonly"); %>>%
	                 </td>
	              </tr>
	              <tr bgcolor="#FFFFFF">
	                <td width="25%" align="center" bgcolor="#D4DCF4" colspan="6"><strong><font color="#003399">추진실적</font></strong></td>
  				  </tr>
  				  <tr bgcolor="#FFFFFF">
	                <td width="75%" colspan="4">
	                    <textarea name="pgDesc" rows="18" cols="59" class="textarea_box" <%if(!(mgrYn.equals("Y") || auth.equals("1")))out.print("readonly"); %>><%=execWork %></textarea>
	               </td>
	              </tr>
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="4">
<!--                	<a href="javascript:actionPerformed('C')"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="추가" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;	-->
<!-- 	                	<a href="javascript:actionPerformed('U')"><img src="<%=imgUri %>/jsp/web/images/btn_edit.gif" alt="수정" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;	-->
						<%if(!(mgrYn.equals("Y") || auth.equals("1"))){ %>
 	                	<a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="추가" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a>
	                	<a href="#"><img src="<%=imgUri %>/jsp/web/images/btn_file_upload.gif" alt="파일등록" width="65" height="20" border="0" align="absmiddle"></a>
	                	<%}else{ %>
 	                	<a href="javascript:saveAct()"><img src="<%=imgUri %>/jsp/web/images/btn_save.gif" alt="추가" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('D','<%=dtlDesc %>')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a>
	                	<a href="javaScript:openFilePopup('<%=did %>');"><img src="<%=imgUri %>/jsp/web/images/btn_file_upload.gif" alt="파일등록" width="65" height="20" border="0" align="absmiddle"></a>
						<%} %>
					</td>
	              </tr>
	           </form>
            </table>

</body>
</html>