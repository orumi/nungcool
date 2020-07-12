<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.task.*" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.util.*"%>
<%@ page import="com.nc.util.StrConvert"%>
<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));


    int sYear = Integer.parseInt(request.getParameter("sYear"));
	int eYear = Integer.parseInt(request.getParameter("eYear"));
	int stQtr = Integer.parseInt(request.getParameter("sQtr"));
	int edQtr = Integer.parseInt(request.getParameter("eQtr"));

	String did = request.getParameter("did");	// 실행계획 id
	String curYear = Util.getToDay().substring(0,4);
	int curMonth = Integer.parseInt(Util.getToDay().substring(5,6));
	int curQtr;
	if(curMonth >= 1 && curMonth <= 3)
		curQtr = 1;
	else if(curMonth >= 4 && curMonth <= 6)
		curQtr = 2;
	else if(curMonth >= 7 && curMonth <= 9)
		curQtr = 3;
	else
		curQtr = 4;


	StringBuffer stYear = new StringBuffer();
	StringBuffer edYear = new StringBuffer();
	StringBuffer sqtr = new StringBuffer();
	StringBuffer eqtr = new StringBuffer();


	StringBuffer deptC = new StringBuffer();
	StringBuffer userC = new StringBuffer();


	TaskAdmin util = new TaskAdmin();
	util.setDtlTak(request, response);

	DataSet ds = (DataSet)request.getAttribute("ds2");

    DataSet user = (DataSet)request.getAttribute("user");
    DataSet dept = (DataSet)request.getAttribute("dept");

	String dtlid = "";
	String execname = "";
	String dtlWork = "";
	String drvMthd = "";
	String goalLev = "";
	String stopYear = "";
	String stopQtr = "";
	String stopYN = "";
	String detailnm = "";
	String projnm = "";

	int stY = 0;
	int edY = 0;
	int sQt = 0;
	int eQt = 0;
	if(ds!=null) {
		while(ds.next()) {
			detailnm = ds.isEmpty("EXECWORK")?"":ds.getString("EXECWORK");

			dtlid = ds.isEmpty("DETAILID")?"":ds.getString("DETAILID");
			stY = ds.isEmpty("SYEAR")?0:ds.getInt("SYEAR");
			edY = ds.isEmpty("EYEAR")?0:ds.getInt("EYEAR");
			sQt = ds.isEmpty("SQTR")?0:ds.getInt("SQTR");
			eQt = ds.isEmpty("EQTR")?0:ds.getInt("EQTR");
			projnm = ds.isEmpty("NAME")?"":ds.getString("NAME");
			

			for(int i = sYear; i <= eYear; i++)
			{
				if(i == stY)
					stYear.append("<option value=" + i + " selected>" + i + "</option>");
				else
					stYear.append("<option value=" + i + ">" + i + "</option>");
			}

			for(int i = sYear; i <= eYear; i++)
			{
				if(i == edY)
					edYear.append("<option value=" + i + " selected>" + i + "</option>");
				else
					edYear.append("<option value=" + i + ">" + i + "</option>");
			}

			for(int i = 1; i <= 4; i++)
			{
				if(i == sQt)
					sqtr.append("<option value=" + i + " selected>" + i + "</option>");
				else
					sqtr.append("<option value=" + i + " >" + i + "</option>");

			}

			for(int i = 1; i <= 4; i++)
			{
				if(i == eQt)
					eqtr.append("<option value=" + i + " selected>" + i + "</option>");
				else
					eqtr.append("<option value=" + i + " >" + i + "</option>");
			}



		}

	} else {
		for(int i = sYear; i <= eYear; i++) {
			stYear.append("<option value=" + i + ">" + i + "</option>");
		}

		for(int i = sYear; i <= eYear; i++) {
			edYear.append("<option value=" + i + ">" + i + "</option>");
		}

		for(int i = 1; i <= 4; i++) {
			sqtr.append("<option value=" + i + ">" + i + "</option>");
		}

		for(int i = 1; i <= 4; i++) {
			eqtr.append("<option value=" + i + ">" + i + "</option>");
		}
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

	function actionPerformed(tag) {
		var syear = form1.syear.options[form1.syear.selectedIndex].value;
		var eyear = form1.eyear.options[form1.eyear.selectedIndex].value;
		var sqtr = form1._sQtr.options[form1._sQtr.selectedIndex].value;
		var eqtr = form1._eQtr.options[form1._eQtr.selectedIndex].value;



		if (parseInt(syear) > parseInt(eyear)) {
		 	alert("실행년도 시작년도가 끝나는 년도 보다 클수 없습니다.");
		 	return;
		}

		if(parseInt(syear) == parseInt(eyear)) {
		 	if(parseInt(sqtr) > parseInt(eqtr)) {
		 		alert("같은 년도에서 시작 분기가 클수는 없습니다.");
		 		return;
	 		}
		}



		if (tag=="C"){
			if (form1.dtlid.value=="") {
				if (form1.dtlname.value=="") {
					alert("세부실행계획명을 기술하십시오");
					return;
				}
				
				form1.mode.value=tag;
				parent.refresh=true;
				form1.submit();
			} else {
				clearComponent();
			}

		} else if (tag=="U") {
			if (form1.dtlid.value=="") {
				alert("수정할 목록을 선택하십시오");
				return;
			}
			parent.refresh=true;
			form1.mode.value=tag;
			form1.submit();

		} else if (tag=="D") {
			if (form1.dtlid.value=="") {
				alert("삭제할 목록을 선택하십시오");
				return;
			}
			if (confirm("선택한 항목을 삭제하시겠습니까?")){
				parent.list.refresh=true;
				parent.refresh=true;
				form1.mode.value=tag;
				form1.submit();
			}

		}
	}

	function clearComponent(){
		form1.dtlid.value="";
		form1.dtlname.value="";
		form1.define.value="";
		
		//form1.dept.options.selectedIndex = 0;
		//form1.mgruser.options.selectedIndex = 0;
		form1.weight.value="";

	}

	function detailRefresh(){
		if (parent.list.refresh==true) {
			parent.list.form2.submit();
		}
	}
	
	function refreshList() {
		if (parent.refresh){
			parent.list.form1.submit();
		}
		parent.refresh=false;
	}
	
</script>
<%
	if(dept != null)
	{
		deptC.append("<option value='-1'></option>")	;
		while(dept.next())
		{
				deptC.append("<option value='"+dept.getString("id")+"'>"+dept.getString("name")+"</option>")	;


		}
	}

	if(user != null)
	{
		userC.append("<option value='-1'></option>")	;
		while(user.next())
		{
				userC.append("<option value='"+user.getString("userId")+"'>"+user.getString("username")+"</option>")	;
	
	
		}
	}
%>


<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onload="javascript:refreshList();">
		<table width="100%" border="0"  cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				<tr>
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">전략과제</font></strong></td>
	                <td width="80%" bgcolor="#FFFFFF" colspan="3"><%=projnm %></td>
	         	</tr>
				<tr>
	                <td width="20%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">실행계획</font></strong></td>
	                <td width="80%" bgcolor="#FFFFFF" colspan="3"><%=detailnm %></td>
	         	</tr>
		</table>

			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" valign="bottom" align="absmiddle">
		                  세부실행계획 세부사항</strong></td>
              </tr>
            </table>

			<table width="100%" border="0"  cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
			<form name="form1" method="post" >
			<input type="hidden" name="mode" value="">
			<input type="hidden" name="dtlid"> <!-- 세부실행계획 id -->
				<tr>
	                <td width="25%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">세부실행계획</font></strong></td>
	                <td width="75%" bgcolor="#FFFFFF" colspan="3">
	                    <input name="dtlname" type="text" class="input_box" size="57" >
	                </td>
	         	</tr>
	         	<!-- tr>
	                <td align="center" width="25%" bgcolor="#D4DCF4"><strong><font color="#003399">부서</font></strong></td>
	                <td bgcolor="#FFFFFF" width="25%">
	                     <select name="dept" style="width:150px;" >
	                     <%=deptC.toString() %>
	                     </select>
	                </td>
	                <td align="center" bgcolor="#D4DCF4" width="25%"><strong><font color="#003399">입력담당자</font></strong>
                    </td>
                    <td width="25%" bgcolor="#FFFFFF">
                       <select name="mgruser" style="width:150px;">
	                    <%=userC.toString() %>
                    </td>
	         	</tr -->

	             <tr>
	                <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">추진기간</font></strong></td>
	                <td bgcolor="#FFFFFF" colspan="3" >
	                    <select name="syear">
		                    <%=stYear.toString() %>
					    </select> 년
		                <select name="_sQtr">
							<%=sqtr.toString() %>
					    </select> 분기
					    ~
	                    <select name="eyear">
		                    <%=edYear.toString() %>
					    </select> 년
		                <select name="_eQtr">
							<%=eqtr.toString() %>
					    </select> 분기
	                 </td>
	              </tr>
				<tr>
	                <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">주요 추진 내용</font></strong></td>
	                <td bgcolor="#FFFFFF" colspan="3">
	                    <textarea name="define" cols=70 rows=6></textarea>
	                </td>
	         	</tr>
	         	<tr>
	                <td width="25%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">가중치</font></strong></td>
	                <td width="75%" bgcolor="#FFFFFF" colspan="3">
	                    <input name="weight" type="text" class="input_box" size="10" >%
	                </td>
	         	</tr>
	              <tr align="right" bgcolor="#FFFFFF">
	                <td colspan="4">
	                	<a href="javascript:actionPerformed('C')"><img src="<%=imgUri %>/jsp/web/images/btn_add.gif" alt="추가" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('U')"><img src="<%=imgUri %>/jsp/web/images/btn_edit.gif" alt="수정" width="50" height="20" border="0" align="absmiddle"></a>&nbsp;
	                	<a href="javascript:actionPerformed('D')"><img src="<%=imgUri %>/jsp/web/images/btn_delete.gif" alt="삭제" width="50" height="20" border="0" align="absmiddle"></a>
	                </td>
	              </tr>
	           </form>
            </table>

</body>
</html>