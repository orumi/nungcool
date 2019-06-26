<%@page import="exam.com.card.model.ReportCardVO"%>
<%@page import="exam.com.card.model.EquipCardVO"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="exam.com.card.service.CardService"%>
<%@page import="javax.annotation.Resource"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@page import="exam.com.main.model.LoginUserVO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%------------------------------------------------------------------------------
 FILE NAME : INIsecurestart.jsp
 AUTHOR : ts@inicis.com
 DATE : 2007/08
 USE WITH : INIsecureresult.jsp, INIpay50.jar
 
 �̴����� �÷������� �̿��Ͽ� ������ ��û�Ѵ�.
 
 Copyright 2007 Inicis, Co. All rights reserved.
------------------------------------------------------------------------------%>
<%@ page language = "java" contentType = "text/html;charset=euc-kr" %>

<%@page import="exam.com.card.model.ReqCardVO"%>
<%@page import="exam.com.main.model.*"%>
<%@page import="java.util.List"%>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/exam/sub.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/exam/common.css'/>"/>
<%


	LoginUserVO loginUser = (LoginUserVO)request.getSession().getAttribute("loginUserVO");

	try {
		
		/* list ReqCardVO   */
	    /*
	    	List<ReqCardVO> listVO = cardService.selectReqCard(map);
			request.setAttribute("reqcardvo_list", listVO);
	    */
	    
	    
		ServletContext servletContext = getServletContext();
		WebApplicationContext waContext = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		CardService cardService = (CardService) waContext.getBean("cardService");
		
		String selchk = request.getParameter("selchk");
			
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("regid", loginUser.getMemid());
		
		/* equipid */
		String[] aIds = selchk.split("\\|");
		ArrayList< String> reportlist = new ArrayList<String>();
		
		for (int i = 0; i < aIds.length; i++) {
			String id = aIds[i];
			if( id !=null && !"".equals(id) ){
				reportlist.add(id);
			}
		}
		
		map.put("reportlist", reportlist);
			
		if(reportlist.size()>0){
			List<ReportCardVO> listVO = ( List<ReportCardVO> )cardService.selectReportCard(map);
			request.setAttribute("reportcardvo_list", listVO);
			request.setAttribute("reports", selchk);
			 
		}

	} catch(Exception e) {
		System.out.println(e);
		request.setAttribute("msg", "failure");
	}



    
    
    List<ReportCardVO> listVO = (List<ReportCardVO>) request.getAttribute("reportcardvo_list");
    
    String sumPrice = "0";
    String strSumPrice = "0";
    String goodname = "";
    String buyername = loginUser.getMemname();
    String buyertel = loginUser.getHp();
    String buyeremail = loginUser.getEmail();
    
    
    if(listVO!=null && listVO.size()>0){
    	ReportCardVO vo = listVO.get(0);
    	sumPrice = vo.getSumprice();
    	strSumPrice = vo.getTotalsumprice();
    	
    	if(listVO.size()==1){
    		goodname = (vo.getSmpname()!=null && vo.getSmpname().length()>25)?vo.getSmpname().substring(0,23):(vo.getSmpname()!=null?vo.getSmpname():"");
    	} else {
    		goodname = (vo.getSmpname()!=null && vo.getSmpname().length()>25)?vo.getSmpname().substring(0,23):(vo.getSmpname()!=null?vo.getSmpname():"");
    	}
    }
    
%>


<%

	if("0".equals(sumPrice)){
%>		
		<script>
		
			alert("������ ������ ������ �����ϴ�. ");
			close();
		
		</script>		
<%		
	}


    sumPrice = "1001"; 
%>




<%-- 
     ***************************************
     * 1. INIpay ���̺귯��                * 
     *************************************** 
--%>
<%@ page import = "com.inicis.inipay.*" %>
<%

    request.setCharacterEncoding("euc-kr");
    /***************************************
     * 2. INIpay �ν��Ͻ� ����             *
     ***************************************/
    INIpay50 inipay = new INIpay50();
    
    /***************************************
     * 3. ��ȣȭ ���/�� ����              *
     ***************************************/
    inipay.SetField("inipayhome", EgovProperties.getProperty("INIpay.inipayhome")  ); // �̴����� Ȩ���͸�(�������� �ʿ�)
    inipay.SetField("admin", "1111"); 							  // Ű�н�����(�������̵� ���� ����)
    //***********************************************************************************************************
    //* admin �� Ű�н����� �������Դϴ�. �����Ͻø� �ȵ˴ϴ�. 1111�� �κи� �����ؼ� ����Ͻñ� �ٶ��ϴ�.      *
    //* Ű�н������ ���������� ������(https://iniweb.inicis.com)�� ��й�ȣ�� �ƴմϴ�. ������ �ֽñ� �ٶ��ϴ�.*
    //* Ű�н������ ���� 4�ڸ��θ� �����˴ϴ�. �� ���� Ű���� �߱޽� �����˴ϴ�.                               *
    //* Ű�н����� ���� Ȯ���Ͻ÷��� �������� �߱޵� Ű���� ���� readme.txt ������ ������ �ֽʽÿ�.             *
    //***********************************************************************************************************
    inipay.SetField("type", "chkfake");							  // ���� (���� ���� �Ұ�)
    
    inipay.SetField("enctype","asym"); 			                  // ���� (���� ���� �Ұ�) asym:���Ī, symm:��Ī
    inipay.SetField("checkopt", "false"); 		                  // ���� (���� ���� �Ұ�) base64��:false, base64����:true
    inipay.SetField("debug","true");                              // �α׸��("true"�� �����ϸ� �󼼷αװ� ������.)
    inipay.SetField("crypto", "execure");						  // Extrus ��ȣȭ��� ���(����)
    
    //�ʼ��׸� : mid, price, nointerest, quotabase
    //�߰����� : INIregno, oid
    //*����* : 	�߰������� �׸��� ��ȣȭ ����׸� �߰��� �ʵ�� �ݵ�� hidden �ʵ忡�� �����ϰ� 
    //          SESSION�̳� DB�� �̿��� ����������(INIsecureresult.jsp)�� ����/���õǾ�� �մϴ�.
    inipay.SetField("mid", EgovProperties.getProperty("INIpay.mid"));                           //�������̵�
    inipay.SetField("price", sumPrice);                           // ����
    inipay.SetField("nointerest", "no");                            //�����ڿ���
    inipay.SetField("quotabase", "����:�Ͻú�:2����:3����:6����");  //�ҺαⰣ
    String[] parameters = {"price","nointerest", "quotabase"};
    inipay.SetField("parameters",parameters);
    
    /********************************
     * 4. ��ȣȭ ���/���� ��ȣȭ�� *
     ********************************/

    
    inipay.startAction();

    /*********************
     * 5. ��ȣȭ ���    *
     *********************/
    String rn_resultMsg = "";
 		if( inipay.GetResult("ResultCode") != "00" ) 
		{
		    rn_resultMsg = inipay.GetResult("ResultMsg");
		}

    /*********************
     * 6. �������� ����  *
     *********************/
    session.setAttribute("INI_MID"    , inipay.GetResult("mid"));
    session.setAttribute("INI_RN"     , inipay.GetResult("rn"));
    session.setAttribute("INI_ENCTYPE", inipay.GetResult("enctype"));
    session.setAttribute("INI_PRICE"  , inipay.GetResult("price") );
    session.setAttribute("admin"      , inipay.GetResult("admin"));
    
    /*
    	6.1 session attribute 
    */
    session.setAttribute("INI_REQS"   , listVO );
    session.setAttribute("INI_TYPE"   , "report" );

    /*******************************************
     * 7. �÷����� ���� ����, hidden field ����*
     *******************************************/
    String ini_encfield = inipay.GetResult("encfield");
    String ini_certid   = inipay.GetResult("certid");
   
    /*********************
     * 6. �ν��Ͻ� ����  *
     *********************/
    inipay = null;
    
// ��ȣȭ���� ���� �����߻� üũ, ��ȣȭ ó�� ���� ���� ���� ����
if ( rn_resultMsg.trim().length() == 0 ){
%>

<html>    
<head>
<title>INIpay50 ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Cache-Control" content="no-cache"/> 
<meta http-equiv="Expires" content="0"/> 
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="X-UA-Compatible" content="requiresActiveX=true" />

<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body, tr, td {font-size:10pt; font-family:����,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/ 
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:����,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/ 
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}
</style>

<!------------------------------------------------------------------------------- 
* ��SITE �� https�� �̿��ϸ� https://plugin.inicis.com/pay61_secunissl_cross.js�� ��� 
* ��SITE �� Unicode(UTF-8)�� �̿��ϸ� http://plugin.inicis.com/pay61_secuni_cross.js�� ��� 
* ��SITE �� https, unicode�� �̿��ϸ� https://plugin.inicis.com/pay61_secunissl_cross.js ��� 
--------------------------------------------------------------------------------> 
<!---------------------------------------------------------------------------------- 
�� ���� �� 
 ��� �ڹٽ�ũ��Ʈ�� ������������ ���� �����ϽǶ� ���������� ������ ��ġ���� 
 �����Ͽ��� ���Ͽ� �߻��Ҽ� �ִ� �÷����� ������ �̿��� ������ �� �ֽ��ϴ�. 
 
  <script language=javascript src="http://plugin.inicis.com/pay61_secuni_cross.js"></script> 
  <script language=javascript> 
  StartSmartUpdate();   // �÷����� ��ġ(Ȯ��) 
  </script> 
----------------------------------------------------------------------------------->  
<!-- �÷����� 6.0 ������ ��� ũ�ν� ����¡ pay61_secuni_cross.js-->
<script language=javascript src="http://plugin.inicis.com/pay61_secuni_cross.js"></script>
<script language=javascript>
StartSmartUpdate();
</script>

<script language=javascript>

var openwin;

function pay(frm)
{
	// MakePayMessage()�� ȣ�������ν� �÷������� ȭ�鿡 ��Ÿ����, Hidden Field
	// �� ������ ä������ �˴ϴ�. �Ϲ����� ���, �÷������� ����ó���� �����ϴ� ����
	// �ƴ϶�, �߿��� ������ ��ȣȭ �Ͽ� Hidden Field�� ������ ä��� �����ϸ�,
	// ���� �������� INIsecureresult.php�� �����Ͱ� ����Ʈ �Ǿ� ���� ó������ �����Ͻñ� �ٶ��ϴ�.

	if(document.ini.clickcontrol.value == "enable")
	{
		
		if(document.ini.goodname.value == "")  // �ʼ��׸� üũ (��ǰ��, ��ǰ����, �����ڸ�, ������ �̸����ּ�, ������ ��ȭ��ȣ)
		{
			alert("��ǰ���� �������ϴ�. �ʼ��׸��Դϴ�.");
			return false;
		}
		else if(document.ini.buyername.value == "")
		{
			alert("�����ڸ��� �������ϴ�. �ʼ��׸��Դϴ�.");
			return false;
		} 
		else if(document.ini.buyeremail.value == "")
		{
			alert("������ �̸����ּҰ� �������ϴ�. �ʼ��׸��Դϴ�.");
			return false;
		}
		else if(document.ini.buyertel.value == "")
		{
			alert("������ ��ȭ��ȣ�� �������ϴ�. �ʼ��׸��Դϴ�.");
			return false;
		}
		else if(ini_IsInstalledPlugin() == false)  // �÷����� ��ġ���� üũ
		{
			alert("\n�̴����� �÷����� 128�� ��ġ���� �ʾҽ��ϴ�. \n\n������ ������ ���Ͽ� �̴����� �÷����� 128�� ��ġ�� �ʿ��մϴ�. \n\n�ٽ� ��ġ�Ͻ÷��� Ctrl + F5Ű�� �����ðų� �޴��� [����/���ΰ�ħ]�� �����Ͽ� �ֽʽÿ�.");
			return false;
		}
		else
		{
			/******
			 * �÷������� �����ϴ� ���� �����ɼ��� �̰����� ������ �� �ֽ��ϴ�.
			 * (�ڹٽ�ũ��Ʈ�� �̿��� ���� �ɼ�ó��)
			 */
			
						 
			if (MakePayMessage(frm))
			{
				disable_click();
				openwin = window.open("childwin.html","childwin","width=299,height=149");		
				return true;
			}
			else
			{
				if(IsPluginModule()) {
					alert("������ ����ϼ̽��ϴ�.");
				}
				return false;
			}
		}
	}
	else
	{
		return false;
	}
}


function enable_click()
{
	document.ini.clickcontrol.value = "enable"
}

function disable_click()
{
	document.ini.clickcontrol.value = "disable"
}

function focus_control()
{
	if(document.ini.clickcontrol.value == "disable")
		openwin.focus();
}
</script>


<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
</head>

<!-----------------------------------------------------------------------------------------------------
�� ���� ��
 �Ʒ��� body TAG�� �����߿� 
 onload="javascript:enable_click()" onFocus="javascript:focus_control()" �� �κ��� �������� �״�� ���.
 �Ʒ��� form TAG���뵵 �������� �״�� ���.
------------------------------------------------------------------------------------------------------->

<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0 onload="javascript:enable_click()" onFocus="javascript:focus_control()"><center>
<form name=ini method=post action="<c:url value='/INIpay/INIpayresult.jsp'/>" onSubmit="return pay(this)" style="border:0px;"> 
			<div class="m_screen01" style="background: url(../images/exam/bg/member02.jpg) no-repeat;margin:0px;padding:0px;">
				<p class="name" style="padding:16px;">
					<span class="txt01">������û</span>
					<span class="txt03">- ������ üũ ���� ����</span>
				</p>
				<!-- m_screen01_in -->
				<div class="m_screen01_in" style="padding-top:14px;">
					<p class="txt01" style="width:80%; font-size:14px; text-align:left; padding-bottom:14px; ">
					- "����" ��ư�� ������ ���� ������ �����ϰ� ��ȣȭ�ϱ� ���� �÷����� â�� ��µ˴ϴ�.<br>
                   <br>
			        - ���ȯ�濡 ���� �ټ� �ð��� �ɸ����� ������ ��������� ǥ�õɶ����� "����" ��ư�� �����ų� �������� �����Ͻ��� ����  ��ø� ��ٷ� �ֽʽÿ�.
                    </p>
                    
                    <div style="width:100%;float:left;padding-top:14px;padding-left:80px;" id="div_display">
                          <img style="float:left;padding-left:84px;" src="<c:url value='/images/exam/ico/ico06.gif'/>" alt=""/>
                          <span class="txt_color03" style="float:left;padding-left:10px;" id="span_msg"> ������ Ȯ���Ͻ� �� ������ư�� �����ֽʽÿ�. </span>
			        </div> 
                    
					
					 

				</div>
				
				
				<div style="width:80%;">
				
				<div class="table_bg" style="width:100%;float:left; overflow-y: auto;overflow-x:hidden; height:150px; margin-bottom: 20px;">
				        <table summary="��û��������" class="table_h">
				            <colgroup>
				                <col width="30%"/>
				                <col width="40%"/>
				                <col width="30%"/>
				            </colgroup>
				            <tr>
				                <th>������ȣ</th>
				                <th>�÷��</th>
				                <th>������</th>
				            </tr>
				            <tbody>
				            <%
				                for (ReportCardVO vo : listVO) {
				            %>
				
				            <tr>
				                <td class="txt_C"><%=vo.getAcceptno()!=null?vo.getAcceptno():"" %>
				                </td>
				                <td class="txt_L">
				                <%=(vo.getSmpname()!=null && vo.getSmpname().length()>25)?vo.getSmpname().substring(0,23)+" ...":(vo.getSmpname()!=null?vo.getSmpname():"") %>
				                </td>
				                <td class="txt_R"><%=vo.getCharprice()!=null?vo.getCharprice():"" %>
				                </td>
				            </tr>
				            <%
				                }
				            %>
				            </tbody>
				        </table>
				    </div>				
				
				</div>
				<br>
					<table style="width:80%;" border="0" cellspacing="0" cellpadding="0">
					<tr> 
                      <td height="1" colspan="4" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="20%" height="25"><img src="img/icon02.gif" width="7" height="7"> �� �� �� �� </td>
                      <td width="30%">�ſ�ī�� ���� 
                      <input type="hidden" name="gopaymethod" id="gopaymethod" value="Card">
                      </td>
                      <td width="20%" height="25"><img src="img/icon02.gif" width="7" height="7"> ��ǰ�� </td>
                      <td width="30%"><%=goodname %>
                      <input type="hidden" name="goodname" id="goodname" value="<%=goodname %>">
                      </td>
                    </tr>
                    <tr> 
                      <td width="20%" height="25"><img src="img/icon02.gif" width="7" height="7"> ����ݾ� </td>
                      <td width="30%"><%=strSumPrice %></td>
                      <td width="20%" height="25"><img src="img/icon02.gif" width="7" height="7"> ���� </td>
                      <td width="30%"><%=buyername%>
                      <input type="hidden" name="buyername" id="buyername" value="<%=buyername%>"></td>
                    </tr>
                    <tr> 
                      <td width="20%" height="25"><img src="img/icon02.gif" width="7" height="7"> �� �� �� �� </td>
                      <td width="30%"><input type=text name=buyeremail size=20 value="<%=buyeremail%>"></td>
                      <td width="20%" height="25"><img src="img/icon02.gif" width="7" height="7"> �� �� �� ȭ </td>
                      <td width="30%"><input type=text name=buyertel size=20 value="<%=buyertel%>"></td>
                    </tr>
                    
                    <tr valign="bottom"> 
                      <td height="40" colspan="4" align="center"><input type=image src="img/button_03.gif" width="63" height="25"></td>
                    </tr>
                    <tr valign="bottom">
                      <td height="50" colspan="4">���ڿ���� �̵���ȭ��ȣ�� �Է¹޴� ���� ������ �������� ������ E-MAIL �Ǵ� SMS ��  �˷��帮�� �����̿��� �ݵ�� �����Ͻñ� �ٶ��ϴ�.</td>
                    </tr>
                  </table>



<!-- 
<table width="632" border="0" cellspacing="0" cellpadding="0">
  
  <tr> 
    <td align="center" bgcolor="6095BC"><table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td bgcolor="#FFFFFF" style="padding:8 0 0 56"> <table width="530" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                 "����" ��ư�� ������ ���� ������ �����ϰ� ��ȣȭ�ϱ� ���� �÷����� â�� ��µ˴ϴ�.<br>
                  �÷����ο��� �����ϴ� �ܰ迡 ���� ������ �Է��� �� <b>[���� ���� Ȯ��]</b> �ܰ迡�� "Ȯ��" ��ư�� ������ 
                  ����ó���� ���۵˴ϴ�.<br>
                  ���ȯ�濡 ���� �ټ� �ð��� �ɸ����� ������ ��������� ǥ�õɶ����� "����" ��ư�� �����ų� �������� �����Ͻ��� ����
                  ��ø� ��ٷ� �ֽʽÿ�.<br></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7"><img src="img/life.gif" width="7" height="30"></td>
                <td background="img/center.gif"><img src="img/icon03.gif" width="12" height="10"> 
                  <b>������ �����Ͻ� �� ������ư�� �����ֽʽÿ�.</b></td>
                <td width="8"><img src="img/right.gif" width="8" height="30"></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="510" colspan="2"  style="padding:0 0 0 23"> 
                  </td>
              </tr>
            </table>
            <br>
          </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td></td>
  </tr>
</table> -->



<!-- ��Ÿ���� -->
<!--
SKIN : �÷����� ��Ų Į�� ���� ��� - 5���� Į��(ORIGINAL, GREEN, YELLOW, RED,PURPLE)
HPP : ������ �Ǵ� �ǹ� ���� ���ο� ���� HPP(1)�� HPP(2)�� ���� ����(HPP(1):������, HPP(2):�ǹ�).
Card(0): �ſ�ī�� ���ҽÿ� �̴Ͻý� ��ǥ �������� ��쿡 �ʼ������� ���� �ʿ� ( ��ü �������� ��쿡�� ī����� ��࿡ ���� ����) - �ڼ��� ������ �޴���  ����.
OCB : OK CASH BAG ���������� �ſ�ī�� �����ÿ� OK CASH BAG ������ �����Ͻñ� ���Ͻø� "OCB" ���� �ʿ� �� �ܿ� ��쿡�� �����ؾ� �������� ���� �̷����.
no_receipt : ���������ü�� ���ݿ����� ���࿩�� üũ�ڽ� ��Ȱ��ȭ (���ݿ����� �߱� ����� �Ǿ� �־�� ��밡��)
-->
<input type=hidden name=acceptmethod value="SKIN(ORIGINAL):HPP(1)">
<input type=hidden name=currency value="WON">


<!--
���� �ֹ���ȣ : �������Ա� ����(������� ��ü),��ȭ���� ���� �ʼ��ʵ�� �ݵ�� ������ �ֹ���ȣ�� �������� �߰��ؾ� �մϴ�.
�������� �߿� ���� ������ü �̿� �ÿ��� �ֹ� ��ȣ�� ��������� ��ȸ�ϴ� ���� �ʵ尡 �˴ϴ�.
���� �ֹ���ȣ�� �ִ� 40 BYTE �����Դϴ�.
## ����:���� �ѱ۰��� �Է��Ͻø� �ȵ˴ϴ�. ##
-->
<input type=hidden name=oid size=40 value="orderid_of_merchant">



<!--
�÷����� ���� ��� ���� �ΰ� �̹��� ���
�̹����� ũ�� : 90 X 34 pixels
�÷����� ���� ��ܿ� ���� �ΰ� �̹����� ����Ͻ� �� ������,
�ּ��� Ǯ�� �̹����� �ִ� URL�� �Է��Ͻø� �÷����� ��� �κп� ���� �̹����� �����Ҽ� �ֽ��ϴ�.
-->
<!--input type=hidden name=ini_logoimage_url  value="http://[����� �̹����ּ�]"-->

<!--
���� �����޴� ��ġ�� �̹��� �߰�
�̹����� ũ�� : ���� ���� ���� - 91 X 148 pixels, �ſ�ī��/ISP/������ü/������� - 91 X 96 pixels
���� �����޴� ��ġ�� �̹����� �߰��Ͻ� ���ؼ��� ��� ������ǥ���� ��뿩�� ����� �Ͻ� ��
�ּ��� Ǯ�� �̹����� �ִ� URL�� �Է��Ͻø� �÷����� ���� �����޴� �κп� �̹����� �����Ҽ� �ֽ��ϴ�.
-->
<!--input type=hidden name=ini_menuarea_url value="http://[����� �̹����ּ�]"-->

<!--
�÷����ο� ���ؼ� ���� ä�����ų�, �÷������� �����ϴ� �ʵ��
����/���� �Ұ�
uid �ʵ忡 ����� ������ ���� ���� �ʵ��� �Ͻñ� �ٶ��ϴ�.
-->
<input type=hidden name=ini_encfield value="<%=ini_encfield%>">
<input type=hidden name=ini_certid value="<%=ini_certid%>">
<input type=hidden name=quotainterest value="">
<input type=hidden name=paymethod value="">
<input type=hidden name=cardcode value="">
<input type=hidden name=cardquota value="">
<input type=hidden name=rbankcode value="">
<input type=hidden name=reqsign value="DONE">
<input type=hidden name=encrypted value="">
<input type=hidden name=sessionkey value="">
<input type=hidden name=uid value=""> 
<input type=hidden name=sid value="">
<input type=hidden name=version value=5000>
<input type=hidden name=clickcontrol value="">
</form>
</body>
</html>
<%
} else {

 // ��ȣȭ ������ó���� ������ ���
%>
<html>    
<head>
<title>INIpay50 ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body, tr, td {font-size:10pt; font-family:����,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/ 
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:����,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/ 
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}
</style>
</head>
<body>
<center>
<table align='center' width="70%">
    <tr>
        <td>��ȣȭ �ʼ��׸� ���� �� ������ ���Ŀ� ���� ���� �߻��Դϴ�. Ȯ�� �ٶ��ϴ�.<br/><%=rn_resultMsg%>
        </td>
    </tr>
</table>
</center>
</body>
</html>
<%
}
%>
