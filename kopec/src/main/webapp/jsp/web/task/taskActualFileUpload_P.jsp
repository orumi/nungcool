<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
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
	alert("�߸��� �����Դϴ�.");
	top.location.href = "../loginProc.jsp";
</script>
<%  }

	String year = request.getParameter("year");
	String qtr = request.getParameter("qtr");
	String typeid = request.getParameter("typeid");
	String did = request.getParameter("did");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="<%=imgUri %>/jsp/web/css/bsc.css" rel="stylesheet" type="text/css">
<title>������� �ٰ��ڷ�</title>
</head>

<script language="javascript">
// ���ϴ� ������ŭ ÷������ �߰�
//window.resizeTo(200,100);
function fi_add(ari_num)
{
   var lo_row,   lo_cell;
   var i = 0;
//   var p_height = 20;
   var a_height = 0;

//   window.resizeTo(310,0);
   // ���������� �����Ǹ�
   if(fi_del() == "delete_ok")
   {
      var lo_tbody = tbl_attach.childNodes(0); // table�� tbody�� �о
      for(i=0; i< ari_num; i++)
      {

         // ���ο� tr�� �����.
         lo_row = document.createElement("TR");
         lo_tbody.appendChild(lo_row);

         // ����÷�� td�� �����ϰ� file���� �־��ش�.
         lo_cell = document.createElement("TD");
         lo_row.appendChild(lo_cell);
         lo_cell.innerHTML = "<input type='file' name='img"+ (i+1) + "' size='30'>";
//         alert("<input type='file' name='img" + (i+1) + "' size='30'>");
      }
   }

   frmName2.fileCnt.value = ari_num;
}

// table�� �ο츦 �����ϴ� �Լ�
function fi_del()
{
   var lo_table = document.getElementById("tbl_attach");

   for(var i=parseInt(lo_table.rows.length)-1; i>=0; i--)
   {
      lo_table.deleteRow(i);
   }
   return "delete_ok";
}


function addTr()
{
    var lo_row,   lo_cell;

    var lo_tbody = tbl.childNodes(0); // table�� tbody�� �о
    for(var i=0; i<5;i++)
    {
        lo_row = document.createElement("TR");
        lo_tbody.appendChild(lo_row);

        lo_cell = document.createElement("TD");
        lo_row.appendChild(lo_cell);
        lo_cell.innerHTML = "<input type=\"file\" name=\"img2\" size=\"30\">";
    }
}


</script>
<body>
    <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="30"><strong><img src="<%=imgUri %>/jsp/web/images/icon_point_00.gif" width="15" height="15" align="absmiddle">
                  	������� �ٰ��ڷ� ���</strong></td>
              </tr>
	</table>
<table width="98%" border="0" name="selTbl" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7" align="center">
    <tr bgcolor="#FFFFFF">
    <td width="70" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">������ϼ�</font></strong></td>
        <td>
            <select name="sbx_num" onchange="fi_add(this.value);">
               <option value="0">0</option>
               <option value="1" selected>1</option>
               <option value="2">2</option>
               <option value="3">3</option>
               <option value="4">4</option>
               <option value="5">5</option>
               <option value="6">6</option>
               <option value="7">7</option>
               <option value="8">8</option>
               <option value="9">9</option>
               <option value="10">10</option>
            </select>
        </td>
    </tr>
</table>
<form name="frmName2" method="post" enctype="multipart/form-data" action="./upload/upload_2.jsp">
<table id="tbl_attach" border="0">
   <tr>
		<input type="file" name="img1" size="30">
   </tr>
</table>
    <input type="hidden" name="fileCnt" value="1">  <!-- ����� ������ ����   -->
    <input type="hidden" name="qtr" value="<%=qtr%>">
    <input type="hidden" name="did" value="<%=did%>">
    <input type="hidden" name="year" value="<%=year%>">
    <input type="hidden" name="typeid" value="<%=typeid%>">
    <input type="submit" value="���">
</form>
           <iframe frameborder="0" id="fileList" SCROLLING="no" src="./achvDeleteFileList.jsp?year=<%=year %>&qtr=<%=qtr %>&typeid=<%=typeid %>&did=<%=did %>" style="body" width="100%" height="90%" >&nbsp;</iframe>
</body>
</html>
