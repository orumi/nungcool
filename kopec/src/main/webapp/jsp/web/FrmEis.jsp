<%@ page contentType="text/html; charset=euc-kr" %>
<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));


    String groupId = (String) session.getAttribute("groupId");
	String auth01 = (String)session.getAttribute("auth01");
	if (groupId == null) {
	%>
	<script>
		alert("�߸��� �����Դϴ�.");
	  	top.location.href = "./loginProc.jsp";
	</script>
	<%
	return;
	}

	int group = new Integer(groupId).intValue();
	int auth = auth01==null?0:Integer.parseInt(auth01);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>:::  :::</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/flex02.css" rel="stylesheet" type="text/css" />
</head>
<script>
	function openContents(tag){

		// -----------------------------------------------------------------------------------------
		// �濵��
		//------------------------------------------------------------------------------------------
		if ("1" == tag){

			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisOutEvalStatus.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/eis/evaluation/evalChart.do";

			document.getElementById("titleText").innerText="�⵵�� ������";
			document.getElementById("titleText_1").innerText="�⵵�� ������";
			document.getElementById("titleText_2").innerText="�濵��";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("subTitleWidth").width = "100";
			//document.getElementById("sel1").style.display = "";
		} else if ("2" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisOutEvalMeas.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/eis/evaluation/evalMeas.do";
			document.getElementById("titleText").innerText="��ǥ�� �׷���򰡺�";
			document.getElementById("titleText_1").innerText="��ǥ�� �׷���򰡺�";
			document.getElementById("titleText_2").innerText="�濵��";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel2").style.display = "";
		} else if ("3" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/commueval/bbs_list.jsp?div_cd=1";
			document.getElementById("titleText").innerText="�����濵���ڷ�";
			document.getElementById("titleText_1").innerText="�����濵���ڷ�";
			document.getElementById("titleText_2").innerText="�濵��";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel3").style.display = "";
		} else if ("4" == tag){
			//document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/adminValuate.jsp";
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/commueval/bbs_list.jsp?div_cd=2";
			//imgTitle.src="images/1_sub_title04.jpg";
			document.getElementById("titleText").innerText="�������ڷ�";
			document.getElementById("titleText_1").innerText="�������ڷ�";
			document.getElementById("titleText_2").innerText="�濵��";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel4").style.display = "";

		// -----------------------------------------------------------------------------------------
		// �濵����
		//------------------------------------------------------------------------------------------
		} else if ("5" == tag){
			//document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/loadEval.jsp";
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/construction.jsp";
			//imgTitle.src="images/1_sub_title05.jpg";
			document.getElementById("titleText").innerText="���հ濵��������";
			document.getElementById("titleText_1").innerText="���հ濵��������";
			//document.getElementById("sel5").style.display = "";
		} else if ("6" == tag){
			//document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/effectiveEval.jsp";
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisManagement.jsp";
			//imgTitle.src="images/1_sub_title06.jpg";
			document.getElementById("titleText").innerText="�濵����";
			document.getElementById("titleText_1").innerText="�濵����";
			document.getElementById("titleText_2").innerText="�濵����";
			document.getElementById("titleText_3").innerText="���հ濵�������� > ";
			//document.getElementById("sel6").style.display = "";
		} else if ("7" == tag){
			//document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/evalView.jsp";
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisSales.jsp";
			//imgTitle.src="images/1_sub_title07.jpg";
			document.getElementById("titleText").innerText="�������";
			document.getElementById("titleText_1").innerText="�������";
			document.getElementById("titleText_2").innerText="�濵����";
			document.getElementById("titleText_3").innerText="���հ濵�������� > ";
			//document.getElementById("sel7").style.display = "";
		} else if ("8" == tag){
			//document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/evalView.jsp";
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisContract.jsp";
			//imgTitle.src="images/1_sub_title08.jpg";
			document.getElementById("titleText").innerText="�������";
			document.getElementById("titleText_1").innerText="�������";
			document.getElementById("titleText_2").innerText="�濵����";
			document.getElementById("titleText_3").innerText="���հ濵�������� > ";
			//document.getElementById("sel8").style.display = "";
		} else if ("9" == tag){
			//document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/evalView.jsp";
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisTechnology.jsp";
			//imgTitle.src="images/1_sub_title09.jpg";
			document.getElementById("titleText").innerText="�������";
			document.getElementById("titleText_1").innerText="�������";
			document.getElementById("titleText_2").innerText="�濵����";
			document.getElementById("titleText_3").innerText="���հ濵�������� > ";
			//document.getElementById("sel9").style.display = "";
		} else if ("10" == tag){
			//document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/evalView.jsp";
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/commueval/bbs_list.jsp?div_cd=3";
			//imgTitle.src="images/1_sub_title10.jpg";
			document.getElementById("titleText").innerText="�濵�������� ȸ���ڷ�";
			document.getElementById("titleText_1").innerText="�濵�������� ȸ���ڷ�";
			document.getElementById("titleText_2").innerText="�濵����";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel10").style.display = "";

		// -----------------------------------------------------------------------------------------
		// ������
		//------------------------------------------------------------------------------------------

		} else if ("11" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisBizInsert.jsp";
			//imgTitle.src="images/1_sub_title11.jpg";
			document.getElementById("titleText").innerText="�濵��Ȳ���";
			document.getElementById("titleText_1").innerText="�濵��Ȳ���";
			document.getElementById("titleText_2").innerText="�濵���� ������";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel11").style.display = "";
		} else if ("12" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisOutEvalInsert.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/eis/evalMng/evalMng.do";
			//imgTitle.src="images/1_sub_title11.jpg";
			document.getElementById("titleText").innerText="�濵�򰡵��";
			document.getElementById("titleText_1").innerText="�濵�򰡵��";
			document.getElementById("titleText_2").innerText="�濵���� ������";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel11").style.display = "";
		} else if ("13" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisSimsaInsert.jsp";
			//imgTitle.src="images/1_sub_title11.jpg";
			document.getElementById("titleText").innerText="�濵�������";
			document.getElementById("titleText_1").innerText="�濵�������";
			document.getElementById("titleText_2").innerText="�濵���� ������";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel12").style.display = "";

		// -----------------------------------------------------------------------------------------
		// �濵����
		//------------------------------------------------------------------------------------------
		} else if ("17" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisBizMain.jsp";
			document.getElementById("titleText").innerText="�濵������Ȳ";
			document.getElementById("titleText_1").innerText="�濵������Ȳ";
			document.getElementById("titleText_2").innerText="�濵��Ȳ";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel16").style.display = "";
		} else if ("18" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisBizManStatus.jsp";
			document.getElementById("titleText").innerText="�η���Ȳ";
			document.getElementById("titleText_1").innerText="�η���Ȳ";
			document.getElementById("titleText_2").innerText="�濵��Ȳ";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel16").style.display = "";
		} else if ("19" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisBizSalesStatus.jsp";
			document.getElementById("titleText").innerText="������Ȳ";
			document.getElementById("titleText_1").innerText="������Ȳ";
			document.getElementById("titleText_2").innerText="�濵��Ȳ";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel16").style.display = "";
		} else if ("20" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/eis/eisBizContractStatus.jsp";
			document.getElementById("titleText").innerText="���������Ȳ";
			document.getElementById("titleText_1").innerText="���������Ȳ";
			document.getElementById("titleText_2").innerText="�濵��Ȳ";
			document.getElementById("titleText_3").innerText="";
			//document.getElementById("sel16").style.display = "";
		}
	}

</script>
<body leftmargin="0" topmargin="0"  >
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200" height="100%" align="center" valign="top">
	  <table width="170" height="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center" colspan="3" height="50"><img src="images/sub_title01.jpg" width="163" height="50"></td>
        </tr>
        <tr>
          <td valign="top" colspan="3"><img src="images/menu_title.jpg" width="170" height="29" /></td>
        </tr>
	    <tr>
		  <td width="5" height="100%" background="images/menu_leftbg.jpg" valign="top">
			<img src="images/menu_leftbg.jpg" width="5" height="4" valign="top"/>
		  </td>
		  <td width="160" valign="top">
		    <table width="160" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2" align="center"><img src="images/blank.gif" height="5" /></td>
              </tr>
              <tr>
                <td width="30" height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>
                <td width="130" align="left" class="title_text">�濵��</td>
              </tr>
              <tr>
                <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
              </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left" class="text"><a href="javascript:openContents(1);">������ ������</a></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
              </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><span class="text"><a href="javascript:openContents(2);">��ǥ�� �׷���򰡺�</a></span></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
              </tr>
<!--
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><span class="text"><a href="javascript:openContents(3);">�����濵���ڷ�</a></span></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
              </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><a href="javascript:openContents(4);">�������ڷ�</a> </td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>
 -->

              <tr>
                <td height="25">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>


<%	if(auth01.equals("1"))	{%>
              <tr>
                <td height="25" align="right"><img src="images/bulet.jpg" width="10" height="15" hspace="7" align="absmiddle" /></td>
                <td align="left" class="title_text">�濵�� ������</td>
              </tr>
              <tr>
                <td colspan="2"><img src="images/title_line.jpg" width="160" height="6" /></td>
                </tr>
              <tr>
                <td height="25">&nbsp;</td>
                <td align="left"><a href="javascript:openContents(12);">�濵�򰡵��</a></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                </tr>

			  <tr>
                <td height="100%">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
<%	}%>
            </table>
		  </td>
          <td width="5" background="images/menu_rightbg.jpg">
			<img src="images/menu_rightbg.jpg" width="5" height="6" />
		  </td>
		</tr>
        <tr>
          <td colspan="3"><img src="images/menu_bottom.jpg" width="170" height="6" /></td>
        </tr>
      </table>
	</td>
    <!--<td width="5" valign="top">&nbsp;</td>-->
    <td valign="top">
	  <!--<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">-->
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td>
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom: 1px solid #c1c1c1;">
              <tr>
                <td width="300" valign="bottom">
				  <table height="45" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="11" style="padding-top:5;"><img src="images/bulet01.jpg" width="11" height="21"></td>
                      <td width="5">&nbsp;</td>
                      <td valign="middle" style="padding-top:6;padding-right:5;"><p class="title_b"><font size="3" id="titleText_1">�⵵�� ������</font></p></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="3" background="images/line01.jpg"><img src="images/line01.jpg" width="6" height="5"></td>
                    </tr>
                  </table>
				</td>
                <td align="right" valign="bottom" style="padding-right:15;">
				  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right" class="td">Ȩ &gt; �濵�� &gt; <font id="titleText_2">�濵��</font> &gt; <font id="titleText_3"></font><strong><font id="titleText">�⵵�� ������</font></strong></td>
                    </tr>
                    <tr>
                      <td><img src="images/blank.gif" width="1" height="5"></td>
                    </tr>
                  </table>
				</td>
              </tr>
              <tr>
                <td colspan="2" bgcolor="#FFFFFF"><img src="images/blank.gif" width="1" height="5"></td>
              </tr>
            </table>
		  </td>
        </tr>


        <tr>
		  <td valign="top" width="100%" height="100%">
		    <!---------///���� ������ ���Կ��� ///--------->
            <!--<IFRAME id="page" name="contents" marginWidth="0" marginHeight="0" src="<%//=imgUri%>/jsp/web/component/componentInit.jsp" frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>-->
            <IFRAME id="page" name="contents" marginWidth="0" marginHeight="0" src="<%=imgUri%>/eis/evaluation/evalChart.do" frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>
		    <!---------///���� ������ ���Կ���  ��///--------->
		  </td>
        </tr>
	  </table>
	</td>
    <td width="3" valign="top">&nbsp;</td>
  </tr>
</table>

</body>
</html>
