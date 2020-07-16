<%@ page language    = "java"
         contentType = "text/html; charset=euc-kr"
         import      = "java.util.*,
         				java.net.*,
         				java.io.*,
         				javax.sql.RowSet,
                        com.nc.cool.*,
                        com.nc.util.*"
%>
<%
	String error_msg = "";
	Common_Data cd = new Common_Data();
	try {

			String UPLOADROOT = ServerStatic.REAL_CONTEXT_ROOT;

			String fullPathPlan = "";
			String fullPathAct = "";
			String pysicalPath = Util.getEUCKR(request.getParameter("filePath"));
			String fileName = Util.getEUCKR(request.getParameter("fileName"));


			fullPathPlan = UPLOADROOT+File.separator+"actual"+File.separator+"measurementplan"+File.separator+fileName;
			fullPathAct = UPLOADROOT+File.separator+"actual"+File.separator+"measurement"+File.separator+fileName;


			File file = new File(UPLOADROOT+pysicalPath);
			File file1 = new File(fullPathAct);
			File file2 = new File(fullPathPlan);

			if(file.exists()){
				FileDownload.flush( request,  response, UPLOADROOT+pysicalPath, fileName );
			} else if (file1.exists()){
				FileDownload.flush( request,  response, fullPathAct, fileName );
			} else {
				FileDownload.flush( request,  response, fullPathPlan, fileName );
				error_msg = cd.Alert_Window("파일경로가 잘못되었습니다.", 1, "");
				out.println(error_msg);
			}

} catch (Exception ex) {
	error_msg = cd.Alert_Window(ex.toString(), 1, "");
	out.println(error_msg);
} finally {
}
%>
