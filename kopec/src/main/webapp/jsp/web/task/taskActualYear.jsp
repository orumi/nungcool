<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%
	request.setCharacterEncoding("euc-kr");
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	String typeid = "1";
    TaskActualUtil tAc = new TaskActualUtil();
    tAc.taskActualDtl(request, response);
	
	String detailid = request.getParameter("detailid");
	String detailNm = "";

	StringBuffer dtl = new StringBuffer();
	StringBuffer year1 = new StringBuffer();
	StringBuffer year2 = new StringBuffer();	
	
	String execNm = (String)request.getAttribute("detailNm")==null?"":(String)request.getAttribute("detailNm");

	
	DataSet ds = (DataSet)request.getAttribute("ds");
    DataSet dsDtl = (DataSet)request.getAttribute("poDs");

    
    int curYear = Integer.parseInt(Util.getToDay().substring(0,4));
    int cnt = 0;
    
    int sYear = 2007;
    int eYear = 2015;
 	
    if( ds != null) {
		while(ds.next()) {
			dtl.append("<option value=" + ds.getString("DTLID") + " >" + ds.getString("DTLNAME") + "</option>");
		}
		ds.resetCursor();
			
	}

    if (dsDtl!=null) while(dsDtl.next()){
    	execNm = dsDtl.getString("EXECNAME");
    	sYear = dsDtl.getInt("SYEAR");
    	eYear = dsDtl.getInt("EYEAR");
    }
    
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<script language="javascript">
	var arrOrg = new Array();
	
	
	function initrs(code, syear, eyear, level, cnt, stopyn)  {
		arrOrg[cnt] = new orgCD(code, syear, eyear, level, stopyn);
	}



	function orgCD(code, syear, eyear, level, stopyn)  {
		this.code = code;
		this.syear = syear;
		this.eyear = eyear;
		this.level = level;
		this.stopyn = stopyn;
	}
	
	function changePBSC()  {
		
		if('<%=typeid%>' == '1')
		{
			form1.stopyn.value = "";
			form1.selYear.length=0;
	//		form1.selYear.options[form1.selYear.length] = new Option('-',-1);
			var length = arrOrg.length;
			if(form1.ddtl.length != 0)
			var pCode = form1.ddtl.options[form1.ddtl.selectedIndex].value;
//			alert(form1.ddtl.length);
	//		alert(pCode);
			for (i=0;i<length;i++) {
				if (arrOrg[i].level==1) {
					if (arrOrg[i].code==pCode) 
					{
						for(var j = arrOrg[i].syear; j <= arrOrg[i].eyear; j++)
							form1.selYear.options[form1.selYear.length] = new Option(j,j);
						
						if(arrOrg[i].stopyn == "Y")
							form1.stopyn.value = "중단된 세부실행과제 입니다.";		
							
						changeYear();
					}
				}
			}
		}
		
	}
	
	function getActual(){
		parent.pdetail.form1.dtlid.value= form1.ddtl.options[form1.ddtl.selectedIndex].value;
		parent.pdetail.form1.year.value = form1.year.options[form1.year.selectedIndex].value;
		parent.pdetail.form1.detailid.value=<%=detailid%>
		
		parent.pdetail.form1.submit();
	}
	
	function changeExec(){
	
	}
	
	function changeCom() 
	{
		parent.pdetail.form1.typeid.value='<%=typeid%>';
		parent.pdetail.form1.year.value = form1.selYear.options[form1.selYear.selectedIndex].value;
	}
	
	
	function changeYear()
	{
		if('<%=typeid%>' == '2')
		{
			if(form1.selYear.length != 0)
			{
				parent.pdetail.form1.mode.value="G";
			
				parent.pdetail.form1.year.value = form1.selYear.options[form1.selYear.selectedIndex].value;
	
				parent.pdetail.form1.typeid.value='<%=typeid%>';
				parent.pdetail.form1.submit();
			}
		}
		else
		{
			if(form1.ddtl.length != 0)
			{
				parent.pdetail.form1.did.value = form1.ddtl.options[form1.ddtl.selectedIndex].value;
				parent.pdetail.form1.detailid.value='<%=detailid%>';
				parent.pdetail.form1.mode.value="G";
				parent.pdetail.form1.year.value = form1.selYear.options[form1.selYear.selectedIndex].value;
				parent.pdetail.form1.typeid.value='<%=typeid%>';
				parent.pdetail.form1.submit();
			}
		}
	}
	
	function clsInput()
	{
		parent.pdetail.form1.qtrGoal1.value = "";
		parent.pdetail.form1.qtrAchv1.value = "";
		parent.pdetail.form1.qtrRealize1.value = ""; 
		
		parent.pdetail.form1.qtrGoal2.value = "";
		parent.pdetail.form1.qtrAchv2.value = "";
		parent.pdetail.form1.qtrRealize2.value = ""; 

		parent.pdetail.form1.qtrGoal3.value = "";
		parent.pdetail.form1.qtrAchv3.value = "";
		parent.pdetail.form1.qtrRealize3.value = ""; 
		
		parent.pdetail.form1.qtrGoal4.value = "";
		parent.pdetail.form1.qtrAchv4.value = "";
		parent.pdetail.form1.qtrRealize4.value = ""; 
	}
	
</script>
<%
    if(ds != null) {
		while(ds.next()) {
%>
		<script>
			initrs('<%=ds.getString("DTLID")%>','<%=ds.getString("syear")%>','<%=ds.getString("eyear")%>','1',<%=cnt%>, '');
		</script>
<%  		cnt++;
		}

	}
%>
<body topmargin=10 leftmargin=0 marginwidth=0 marginheight=0>
		<table width="98%" border="0" align="left" cellpadding="2" cellspacing="1" bgcolor="#9DB5D7">
						<form name="form1" method="post" action="">
							<input type="hidden" name="detailid" value="">
				      <tr bgcolor="#FFFFFF">
				        <td height="30" colspan="3"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
         	 			실적등록&nbsp;&nbsp;&nbsp;실행계획:<%=execNm %>
         	 			&nbsp;&nbsp;&nbsp;
         	 			</strong></td>

				      </tr>
				      <tr bgcolor="#FFFFFF">
				        <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">세부실행계획<br>(추진계획)</font></strong></td>
				        <td width="85%"><strong><font color="#FF3300">

							<select name="ddtl" onchange="changeExec()">
								<%=dtl.toString() %>
							</select>
				        </tr>
				      <tr bgcolor="#FFFFFF">
				        <td align="center" bgcolor="#D4DCF4"s><strong><font color="#003399">해당년도</font></strong></td>
				        <td>
		            <select name="year" style="width:60px;">
<%
							for(int i = sYear; i <= eYear; i++) {
								if(curYear == i)
									out.println("<option value=" + i + " selected>" + i + "</option>");
								else
									out.println("<option value=" + i + ">" + i + "</option>");
							}
%>
					</select>
							
				          <a href="javascript:getActual();"><img src="<%=imgUri %>/jsp/web/images/btn_ok.gif" alt="저장" width="50" height="20" border="0" align="absmiddle"></a></td>
				      </tr>
						</form>
				    </table>

    </body>
</html>