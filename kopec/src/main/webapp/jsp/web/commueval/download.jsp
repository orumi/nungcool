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

			String fullPath = "";
			String fileName = Util.getEUCKR(request.getParameter("fileName"));
			//String fileName = (request.getParameter("fileName"));

			//System.out.println(fileName);

//			System.out.println(strFileName);
			//String strFileName = Util.getEUCKR(request.getParameter("fileName"));
			//fullPath = request.getRealPath(File.separator)+File.separator+"bsc_pdsfile"+File.separator+fileName;
			fullPath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"bsc_pdsfile"+File.separator+fileName;
			//System.out.println("fullPath="+fullPath);


			System.out.println(" :" + fullPath);

			File file1 = new File(fullPath);
			if (file1.exists()){
				FileDownload.flush( request,  response, fullPath, fileName );
			}else{
				error_msg = cd.Alert_Window("���ϰ�ΰ� �߸��Ǿ����ϴ�.", 1, "");
				out.println(error_msg);
			}

} catch (Exception ex) {
	error_msg = cd.Alert_Window(ex.toString(), 1, "");
	out.println(error_msg);
} finally {
}
%>
