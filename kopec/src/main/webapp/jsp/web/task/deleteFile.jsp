<!-- 
�����ۼ��� : ������ 
�Ҽ� 		 : ����
�����ۼ��� : 
>-------------- ���� ����  --------------<
������ : 2007.07.05 ������ : ������ 


 -->
 
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="com.nc.cool.*"%>
<%@ page import="com.nc.util.DataSet"%>
<%@ page import="com.nc.task.*" %>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("EUC-KR");
	String modir = session.getAttribute("userId")==null?"":(String)session.getAttribute("userId");
	if(modir.equals("")) 
	{
		out.print("<script>");
		out.print("alert('�߸��� �����Դϴ�.');");
		out.print("top.location.href = '../loginProc.jsp';");
		out.print("</script>");
	}
	String imgUri = request.getRequestURI();
//	imgUri = imgUri.substring(1);
//	imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));
	
	String year = request.getParameter("year");
	String qtr = request.getParameter("qtr");
	String did = request.getParameter("did");
	String typeid = request.getParameter("typeid");
	String fileS = request.getParameter("file");
	String udpFile = "";
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	ArrayList fileAl = new ArrayList();
	
	String fileList[] = fileS.split("\\|");
	
	
	for(int i=0; i < fileList.length; i++)
	{
		fileAl.add(fileList[i]);
	}
//	out.println(imgUri+"/jsp/web/upload/"+fileAl.get(idx));
	String filePh = "d:\\BSC\\knfc\\jsp\\web\\upload\\"+fileAl.get(idx);	//--����ΰ� �ȸԳ�...�Ѥ�;; ����� ������ ������..�ϴ� pass~
//	String filePh = "fiel:///imgUri"+fileAl.get(idx);
//	URI ri = new URI(imgUri);
//	out.println(filePh);
	
	File f = new File(filePh);
	f.delete();
	
	fileAl.remove(idx);
//	out.println("size" + fileAl.size());
	for(int i=0; i < fileAl.size(); i++)
	{
		udpFile = udpFile + fileAl.get(i) + "|";
//		out.println("aaa    " + udpFile);
	}
	
	if(!udpFile.equals(""))
	{
		udpFile = udpFile.substring(0, udpFile.lastIndexOf("|"));	//--�������� ���� "|" �̳��� �����.
	}
//	out.println("bbb    " + udpFile);
	request.setAttribute("year", year);
	request.setAttribute("qtr", qtr);
	request.setAttribute("did", did);
	request.setAttribute("typeid", typeid);
	request.setAttribute("fileNM", udpFile);

    TaskActualUtil tau = new TaskActualUtil();
    tau.taskDeletefile( request, response );
	
	
	String msg = (String)request.getAttribute("msg")==null?"":(String)request.getAttribute("msg");
	
	if(msg.equals("true"))
	{
		out.print("<script>");
		out.print("alert('ó���Ǿ����ϴ�.');");
//		out.print("location.href('./achvDeleteFileList.jsp?did='" + did +"&qtr=" +qtr+ "&year="+year+ "&idx="+idx+"&typeid="+typeid +");'");
//		out.print("location.href('./taskActualFileUpload_P.jsp');");
		out.print("window.close();");
		out.print("</script>");
	}
	
%>
<script>
	location.href("./achvDeleteFileList.jsp?did="+did+"&qtr="+qtr+"&year="+year+"&file="+file+"&idx="+idx+"&typeid="+<%=typeid%>);
</script>