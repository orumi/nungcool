<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.eval.*,
				 com.nc.util.*"%>
    
<%

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

	
	AdminValuate util = new AdminValuate();
	util.setEvalDetail(request,response);
	
	DataSet ds = (DataSet) request.getAttribute("ds");
	
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String MID = request.getParameter("mId");
	String evalrId = request.getParameter("evalrId");
	
	String mName="";
	String frequency="";
	String file="";
	String evalGrade = "";
	String evalScore = "";
	String eval = "";
	
	String userName="";
	String sPlanned = "";
	String sDetail = "";
	
	String confirm = "0";
	
	String strCon = "";
	int mId = 0;
	if (ds!=null)
		while(ds.next()){
			mId = ds.getInt("ID");
			mName = ((String)ds.getString("NAME")).trim();
			frequency = ds.isEmpty("FREQUENCY")?"":ds.getString("FREQUENCY");
			evalGrade = ds.isEmpty("EVALGRADE")?"":ds.getString("EVALGRADE");
			evalScore = ds.isEmpty("EVALSCORE")?"":ds.getString("EVALSCORE");
			eval = ds.isEmpty("EVALDGDF")?"":ds.getString("EVALDGDF");
			
			confirm = ds.isEmpty("CONFIRM")?"0":ds.getString("CONFIRM");
			
			strCon = "0".equals(confirm)?"�ӽ�����":"�Ϸ�";
			
			userName = ds.isEmpty("USERNAME")?"":ds.getString("USERNAME");
			sPlanned = ds.isEmpty("PLANNED")?"":ds.getString("PLANNED");
			sDetail = ds.isEmpty("DETAIL")?"":ds.getString("DETAIL");
			
			file = ds.isEmpty("FILEPATH")?"":"<a href='#'> <img src='"+imgUri+"/jsp/web/images/icon_file.gif' width='12' height='12' onClick=\"download('"+ds.getString("FILEPATH")+"');\"> </a>";
		}
	
%>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<html>
<head>
<script>
	function actionClose(){
		self.close();
	}
	
	var chkGrade='<%=eval%>';
	function actionPerformed(tag) {
	
		if (confirm('������ �򰡰���� �ʱ�ȭ �Ͻðڽ��ϱ�?')){
			form1.tag.value=tag;
			form1.submit();
		}
	}
	
	function clickGrade(val) {
		chkGrade=val;
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Evaluation Detail Information </title>
</head>
<body leftmargin="8" topmargin="0" marginwidth="0">
			<!---//�ش��� �μ�����//----->
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong>
                	<img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle"> 
                  		������ǥ ����</strong></td>
              </tr>
            </table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr align="center" bgcolor="#D4DCF4"> 
                <td bgcolor="#D4DCF4"><strong><font color="#003399">������ǥ��</font></strong></td>
                <td><strong><font color="#003399">�ֱ�</font></strong></td>
                <td><strong><font color="#003399">÷�ι���</font></strong></td>
                <td><strong><font color="#003399">�򰡵��</font></strong></td>
                <td><strong><font color="#003399">����</font></strong></td>
                <td><strong><font color="#003399">����</font></strong></td>
                <td><strong><font color="#003399">����</font></strong></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td><%= mName %></td>
                <td align="center"><%=frequency %></td>
                <td align="center"><%=file%></td>
                <td align="center"><%=evalGrade %></td>
                <td align="center"><%=evalScore %></td>
                <td align="center"><%=userName %></td>
                <td align="center"><%=strCon %></td>
              </tr>
            </table>
            <br>
              <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
                <tr> 
                  <td width="13%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�����ȹ</font></strong></td>
                  <td bgcolor="#FFFFFF"><textarea name="textarea" cols="45" rows="5" class="textarea_box"><%=sPlanned %></textarea> 
                  </td>
                  <td width="13%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">�������</font></strong></td>
                  <td bgcolor="#FFFFFF"><textarea name="textarea2" cols="45" rows="5" class="textarea_box"><%=sDetail %></textarea></td>
                </tr>
              </table>            
			<form name="form1" method="post" action="">
			<input type="hidden" name="mId" value=<%=MID %>>
			<input type="hidden" name="year" value=<%=year %>>
			<input type="hidden" name="month" value=<%=month %>>
			<input type="hidden" name="evalrId" value=<%=evalrId %>>
			<input type="hidden" name="tag" >
			
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
				  <tr> 
				    <td colspan="2" rowspan="2" bgcolor="#D4DCF4">����</td>
				    <td colspan="5" bgcolor="#D4DCF4">�ο� ���� ���� ��� ���� ��ȹ ���̵�</td>
				  </tr>
				  <tr> 
				    <td width="15%" bgcolor="#D4DCF4">�ſ����</td>
				    <td width="15%" bgcolor="#D4DCF4">����</td>
				    <td width="15%" bgcolor="#D4DCF4">�߰�</td>
				    <td width="15%" bgcolor="#D4DCF4">����</td>
				    <td width="15%" bgcolor="#D4DCF4">�ſ쳷��</td>
				  </tr>
				  <tr> 
				    <td rowspan="5" bgcolor="#EEEEEE">��������</td>
				    <td bgcolor="#EEEEEE">Ź��</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="11|A+" onClick="javascript:clickGrade(this.value);" <%="11|A+".equals(eval)?"checked":"" %>>A+</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="12|A" onClick="javascript:clickGrade(this.value);" <%="12|A".equals(eval)?"checked":"" %>>A</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="13|B+" onClick="javascript:clickGrade(this.value);" <%="13|B+".equals(eval)?"checked":"" %>>B+</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="14|B" onClick="javascript:clickGrade(this.value);" <%="14|B".equals(eval)?"checked":"" %>>B</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="15|C" onClick="javascript:clickGrade(this.value);" <%="15|C".equals(eval)?"checked":"" %>>C</td>
				  </tr>
				  <tr> 
				    <td bgcolor="#EEEEEE">���</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="21|A" onClick="javascript:clickGrade(this.value);" <%="21|A".equals(eval)?"checked":"" %>>A</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="22|B+" onClick="javascript:clickGrade(this.value);" <%="22|B+".equals(eval)?"checked":"" %>>B+</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="23|B" onClick="javascript:clickGrade(this.value);" <%="23|B".equals(eval)?"checked":"" %>>B</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="24|C" onClick="javascript:clickGrade(this.value);" <%="24|C".equals(eval)?"checked":"" %>>C</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="25|D+" onClick="javascript:clickGrade(this.value);" <%="25|D+".equals(eval)?"checked":"" %>>D+</td>
				  </tr>
				  <tr> 
				    <td bgcolor="#EEEEEE">����</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="31|B+" onClick="javascript:clickGrade(this.value);" <%="31|B+".equals(eval)?"checked":"" %>>B+</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="32|B" onClick="javascript:clickGrade(this.value);" <%="32|B".equals(eval)?"checked":"" %>>B</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="33|C" onClick="javascript:clickGrade(this.value);" <%="33|C".equals(eval)?"checked":"" %>>C</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="34|D+" onClick="javascript:clickGrade(this.value);" <%="34|D+".equals(eval)?"checked":"" %>>D+</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="35|D" onClick="javascript:clickGrade(this.value);" <%="35|D".equals(eval)?"checked":"" %>>D</td>
				  </tr>
				  <tr> 
				    <td bgcolor="#EEEEEE">����</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="41|B" onClick="javascript:clickGrade(this.value);" <%="41|B".equals(eval)?"checked":"" %>>B</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="42|C" onClick="javascript:clickGrade(this.value);" <%="42|C".equals(eval)?"checked":"" %>>C</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="43|D+" onClick="javascript:clickGrade(this.value);" <%="43|D+".equals(eval)?"checked":"" %>>D+</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="44|D" onClick="javascript:clickGrade(this.value);" <%="44|D".equals(eval)?"checked":"" %>>D</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="45|E+" onClick="javascript:clickGrade(this.value);" <%="45|E+".equals(eval)?"checked":"" %>>E+</td>
				  </tr>
				  <tr> 
				    <td bgcolor="#EEEEEE">����</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="51|C" onClick="javascript:clickGrade(this.value);" <%="51|C".equals(eval)?"checked":"" %>>C</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="52|D+" onClick="javascript:clickGrade(this.value);" <%="52|D+".equals(eval)?"checked":"" %>>D+</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="53|D" onClick="javascript:clickGrade(this.value);" <%="53|D".equals(eval)?"checked":"" %>>D</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="54|E+" onClick="javascript:clickGrade(this.value);" <%="54|E+".equals(eval)?"checked":"" %>>E+</td>
				    <td bgcolor="#FFFFFF"><input type="radio" name="rdo" value="55|E" onClick="javascript:clickGrade(this.value);" <%="55|E".equals(eval)?"checked":"" %>>E</td>
				  </tr>				  
            </table>
            <table width="98%" border="0" align="center" cellpadding="5" cellspacing="0" bgcolor="#9DB5D7">
              <tr bgcolor="#FFFFFF"> 
                  <td colspan="9" align="right"> 
                    <a href="javascript:actionPerformed('R');"><img src="<%=imgUri %>/jsp/web/images/btn_reset_eval.gif" alt="�ӽ�����" width="84" height="20" border="0" align="absmiddle"></a> 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:actionClose();"><img src="<%=imgUri %>/jsp/web/images/btn_close.gif" alt="���" width="50" height="20" border="0" align="absmiddle"></a> 
                  </td>
              </tr>
            </table>            
            </form>
            <!--------//������ǥ �����Է�//-------->

<form name="downForm" method="post" action="<%=imgUri%>/jsp/web/valuate/download.jsp">
	<input type="hidden" name="fileName">
</form>

<!---------//����  KPI ���� ��û ����Ʈ ��//-------->
<SCRIPT>
<!--

	function download(filename){
		downForm.fileName.value=filename;
		downForm.submit();
	}
	
	
	//mergeCell(document.getElementById('tbl0'), '0', '2', '1','1');
	//mergeCell(document.getElementById('tbl0'), '0', '1', '1','0');
	//mergeCell(document.getElementById('tbl0'), '0', '0', '1','');
//-->
</SCRIPT>
</body>
</html>