<%@ page contentType="text/html; charset=euc-kr"%>

<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>::: :::</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
<jsp:include page="js/js.jsp" flush="true" />
</head>
<script>
	function openContents(tag){
		if ("1" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/component/componentInit.jsp";

			document.getElementById("titleText").innerText="��������";
			document.getElementById("titleText_1").innerText="��������";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("2" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/organization.jsp";

			document.getElementById("titleText").innerText="����ü�豸��";
			document.getElementById("titleText_1").innerText="����ü�豸��";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("3" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/mapIcon.jsp";
			document.getElementById("titleText").innerText="�����ʱ���";
			document.getElementById("titleText_1").innerText="�����ʱ���";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("4" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/actual/actWeight.jsp";
			document.getElementById("titleText").innerText="��ǥ����ġ���";
			document.getElementById("titleText_1").innerText="��ǥ����ġ���";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("5" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/task/taskInitiative.jsp";
			document.getElementById("titleText").innerText="��ǥ����������";
			document.getElementById("titleText_1").innerText="��ǥ����������";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("6" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/import/importInit.jsp";
			document.getElementById("titleText").innerText="�����ڷ���";
			document.getElementById("titleText_1").innerText="�����ڷ���";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("7" == tag){
			document.getElementById("page").src = "<%=imgUri%>/admin/deptMapping/list.do";
			document.getElementById("titleText").innerText="�μ�����";
			document.getElementById("titleText_1").innerText="�μ�����";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("8" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/userSearch.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/user/userInit.jsp";
			document.getElementById("titleText").innerText="���������";
			document.getElementById("titleText_1").innerText="���������";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("9" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/adminGroup.jsp";
			document.getElementById("titleText").innerText="�򰡱׷켳��";
			document.getElementById("titleText_1").innerText="�򰡱׷켳��";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("10" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/adminAppraiser.jsp";
			document.getElementById("titleText").innerText="���ڼ���";
			document.getElementById("titleText_1").innerText="���ڼ���";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("11" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/adminValuate.jsp";
			document.getElementById("titleText").innerText="���������";
			document.getElementById("titleText_1").innerText="���������";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("12" == tag){
			document.getElementById("page").src = "<%=imgUri%>/admin/valuate/orgAddScore.do";
			document.getElementById("titleText").innerText="�򰡰����� ���";
			document.getElementById("titleText_1").innerText="�򰡰����� ���";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("13" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/construction.jsp";
			document.getElementById("titleText").innerText="�ý��ۿ��赥��Ÿ��ȸ";
			document.getElementById("titleText_1").innerText="�ý��ۿ��赥��Ÿ��ȸ";
		} else if ("14" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/construction.jsp";
			document.getElementById("titleText").innerText="ETL�α���ȸ";
			document.getElementById("titleText_1").innerText="ETL�α���ȸ";
		} else if ("15" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/construction.jsp";
			document.getElementById("titleText").innerText="ETL��������";
			document.getElementById("titleText_1").innerText="ETL��������";
		} else if ("16" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/construction.jsp";
			document.getElementById("titleText").innerText="ETL�������";
			document.getElementById("titleText_1").innerText="ETL�������";
		} else if ("17" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/valuate/adjustValuate.jsp";
			document.getElementById("titleText").innerText="�򰡰���ݿ�";
			document.getElementById("titleText_1").innerText="�򰡰���ݿ�";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("18" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/evalPersonBonusRate.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/admin/perform/paymentRate.do";
			document.getElementById("titleText").innerText="������ ���޷�";
			document.getElementById("titleText_1").innerText="������ ���޷�";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("19" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/actual/actual.jsp";
			document.getElementById("titleText").innerText="������ �跮�������";
			document.getElementById("titleText_1").innerText="������ �跮�������";
			document.getElementById("titleText_2").innerText="�跮����";
		} else if ("20" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/eval/adminGroup2007.jsp";
			document.getElementById("titleText").innerText="�򰡱׷켳�� 2007";
			document.getElementById("titleText_1").innerText="�򰡱׷켳�� 2007";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("21" == tag){
			document.getElementById("page").src = "<%=imgUri%>/admin/config/schedule.do";
			document.getElementById("titleText").innerText="����������";
			document.getElementById("titleText_1").innerText="����������";
			document.getElementById("titleText_2").innerText="�򰡰���";
		}  else if ("22" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/flex/BscTreeMain.jsp";
			document.getElementById("page").src = "<%=imgUri%>/admin/organization/organizationMng.do";
			document.getElementById("titleText").innerText="�����ʱ���";
			document.getElementById("titleText_1").innerText="�����ʱ���";
			document.getElementById("titleText_2").innerText="������������";
		}  else if ("120" == tag){
			document.getElementById("page").src = "<%=imgUri%>/admin/hierarchy/hierarchyMng.do";
			document.getElementById("titleText").innerText="����ü����������";
			document.getElementById("titleText_1").innerText="����ü����������";
			document.getElementById("titleText_2").innerText="������������";
		}  else if ("121" == tag){
			document.getElementById("page").src = "<%=imgUri%>/admin/measure/measureMng.do";
			document.getElementById("titleText").innerText="����ü����ǥ����";
			document.getElementById("titleText_1").innerText="����ü����ǥ����";
			document.getElementById("titleText_2").innerText="������������";
		} else if ("23" == tag){
			document.getElementById("page").src = "<%=imgUri%>/admin/valuate/list.do";
			document.getElementById("titleText").innerText="���� ����(�μ�)";
			document.getElementById("titleText_1").innerText="���� ����(�μ�)";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("24" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/analyDivisions.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/admin/score/scoreChart.do";
			document.getElementById("titleText").innerText="������ ��������";
			document.getElementById("titleText_1").innerText="������ ��������";
			document.getElementById("titleText_2").innerText="������ȸ";
		}  else if ("25" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/analyAnnually.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/admin/score/annuallyChart.do";

			document.getElementById("titleText").innerText="������ ��������";
			document.getElementById("titleText_1").innerText="������ ��������";
			document.getElementById("titleText_2").innerText="������ȸ";
		} else if ("26" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/rptOrgMeasEvalComment.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/admin/score/qlyComment.do";

			document.getElementById("titleText").innerText="��跮��ǥ ���ǰ�";
			document.getElementById("titleText_1").innerText="��跮��ǥ ���ǰ�";
			document.getElementById("titleText_2").innerText="������ȸ";
		} else if ("27" == tag){
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/actual/planned.jsp";
			document.getElementById("titleText").innerText="�跮��ǥ ��ޱ������";
			document.getElementById("titleText_1").innerText="�跮��ǥ ��ޱ������";
			document.getElementById("titleText_2").innerText="�跮����";
		} else if ("28" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/AppConfig.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/admin/config/appConfig.do";
			document.getElementById("titleText").innerText="ȯ�漳��";
			document.getElementById("titleText_1").innerText="ȯ�漳��";
			document.getElementById("titleText_2").innerText="������������";

		} else if ("29" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/evalPersonScore.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/admin/psn/psnEmpScore.do";
			document.getElementById("titleText").innerText="���μ����� ���޷�";
			document.getElementById("titleText_1").innerText="���μ����� ���޷�";
			document.getElementById("titleText_2").innerText="�򰡰���";
		} else if ("30" == tag){
			<%-- document.getElementById("page").src = "<%=imgUri%>/jsp/flex/CodeManager.jsp"; --%>
			document.getElementById("page").src = "<%=imgUri%>/jsp/web/cmcdmng/cmcdmng.jsp";
			document.getElementById("titleText").innerText="�ڵ����";
			document.getElementById("titleText_1").innerText="�ڵ����";
			document.getElementById("titleText_2").innerText="������������";
		}
	}
	var viewMenu = true;

	function showMenu(){
		if (viewMenu) {
			document.getElementById("leftMenu").style.display="none";
			top.closeTopMenu();
			viewMenu = false;
		} else {
			document.getElementById("leftMenu").style.display="inline";
			top.openTopMenu();
			viewMenu = true;
		}
	}
</script>
<body
	onLoad="MM_preloadImages('images/menu01_over.jpg','images/menu02_over.jpg','images/menu03_over.jpg','images/menu04_over.jpg','images/menu05_over.jpg','images/menu06_over.jpg')">
	<table width="100%" height="100%" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td width="200" height="100%" align="center" valign="top">
				<table width="170" height="100%" border="0" cellspacing="0"
					cellpadding="0">
					<tr>
						<td align="center" colspan="3" height="50"><img
							src="images/sub_title06.jpg" width="163" height="50"></td>
					</tr>
					<tr>
						<td valign="top" colspan="3"><img src="images/menu_title.jpg"
							width="170" height="29" /></td>
					</tr>
					<tr>
						<td width="5" height="100%" background="images/menu_leftbg.jpg"
							valign="top"><img src="images/menu_leftbg.jpg" width="5"
							height="4" valign="top" /></td>
						<td width="160" valign="top">
							<table width="160" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2" align="center"><img src="images/blank.gif"
										height="5" /></td>
								</tr>
								<tr>
									<td width="30" height="25" align="right"><img
										src="images/bulet.jpg" width="10" height="15" hspace="7"
										align="absmiddle" /></td>
									<td width="130" align="left" class="title_text">������������</td>
								</tr>
								<tr>
									<td colspan="2"><img src="images/title_line.jpg"
										width="160" height="6" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left" class="text"><a
										href="javascript:openContents(1);">�������� </a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><span class="text"><a
											href="javascript:openContents(120);">����ü����������</a></span></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><span class="text"><a
											href="javascript:openContents(121);">����ü����ǥ����</a></span></td>
								</tr>


								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><span class="text"><a
											href="javascript:openContents(22);">�����ʱ���</a></span></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(27);">�跮��ǥ
											��ޱ������</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(4);">��ǥ����ġ���</a>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<!--                  <td height="25">&nbsp;</td>-->
									<!--                  <td align="left"><a href="javascript:openContents(5);">��ǥ����������</a></td>-->
									<!--                </tr>-->
									<!--                <tr>-->
									<!--                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>-->
									<!--                  </tr>-->
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(6);">�����ڷ���</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(7);">�μ�����</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(8);">���������</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(30);">�ڵ����</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(28);">ȯ�漳��</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><span
										style="cursor: hand; font-size: 10pt;"
										onclick="window.open('./find_pass.jsp','win1',  'toolbar=0, status=0, scrollbars=no, location=0, menubar=0, width=350, height=160')"><FONT
											color=#2A4775>��й�ȣ �ʱ�ȭ</FONT></span></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>

								<tr>
									<td height="25" align="right"><img src="images/bulet.jpg"
										width="10" height="15" hspace="7" align="absmiddle" /></td>
									<td align="left" class="title_text">�򰡰���</td>
								</tr>
								<tr>
									<td colspan="2"><img src="images/title_line.jpg"
										width="160" height="6" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(21);">����������</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>


									<!--
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(20);">�򰡱׷켳�� 2007</a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                  </tr>
                <tr>

                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(9);">�򰡱׷켳��</a></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                  </tr>
                <tr>
                  <td height="25">&nbsp;</td>
                  <td align="left"><a href="javascript:openContents(10);">���ڼ���</a></td>
                </tr>

                <tr>
                  <td colspan="2" align="center"><img src="images/dot_line.jpg" width="149" height="1" /></td>
                  </tr>
-->
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(23);">���ڼ���(�μ�)</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(11);">���������</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(17);">�򰡰���ݿ�</a>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left" class="text"><a
										href="javascript:openContents(19);">������ �跮������� </a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(12);">�򰡰�����
											���</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(18);">������
											���޷�</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(29);">���μ�����
											���޷�</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td height="25" align="right"><img src="images/bulet.jpg"
										width="10" height="15" hspace="7" align="absmiddle" /></td>
									<td align="left" class="title_text">������ȸ</td>
								</tr>
								<tr>
									<td colspan="2"><img src="images/title_line.jpg"
										width="160" height="6" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><span class="text"><a
											href="javascript:openContents(24);">������ ��������</a></span></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><span class="text"><a
											href="javascript:openContents(25);">������ ��������</a></span></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>
								<tr>
									<td height="25">&nbsp;</td>
									<td align="left"><a href="javascript:openContents(26);">��跮��ǥ
											���ǰ�</a></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><img
										src="images/dot_line.jpg" width="149" height="1" /></td>
								</tr>

								<tr>
									<td height="25">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</td>
						<td width="5" background="images/menu_rightbg.jpg"><img
							src="images/menu_rightbg.jpg" width="5" height="6" /></td>
					</tr>
					<tr>
						<td colspan="3"><img src="images/menu_bottom.jpg" width="170"
							height="6" /></td>
					</tr>
				</table>
			</td>
			<!--<td width="5" valign="top">&nbsp;</td>-->
			<td valign="top">
				<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" background="images/bsub_title_bg.jpg" style="background-repeat: repeat-x">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								style="border-bottom: 1px solid #c1c1c1;">
								<tr>
									<td width="300" valign="bottom">
										<table height="45" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td width="11" style="padding-top: 5;"><img
													src="images/bulet01.jpg" width="11" height="21"></td>
												<td width="5">&nbsp;</td>
												<td valign="middle"
													style="padding-top: 6; padding-right: 5;"><p
														class="title_b">
														<font size="3" id="titleText_1">��������</font>
													</p></td>
											</tr>
											<tr>
												<td height="5" colspan="3" background="images/line01.jpg"><img
													src="images/line01.jpg" width="6" height="5"></td>
											</tr>
										</table>
									</td>
									<td align="right" valign="bottom" style="padding-right: 15;">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="right" class="td">Ȩ &gt; ������ &gt; <font
													id="titleText_2">������������</font> &gt; <strong><font
														id="titleText">��������</font></strong></td>
											</tr>
											<tr>
												<td><img src="images/blank.gif" width="1" height="5"></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="2" bgcolor="#FFFFFF"><img
										src="images/blank.gif" width="1" height="5"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td valign="top" width="100%" height="100%">
							<!---------///���� ������ ���Կ��� ///---------> <IFRAME id="page"
								name="contents" marginWidth="0" marginHeight="0"
								src="<%=imgUri%>/jsp/web/component/componentInit.jsp"
								frameBorder="0" width="100%" scrolling="auto" height="100%"></IFRAME>
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
