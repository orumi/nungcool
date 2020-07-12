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
			String fileName = request.getParameter("clips");


//			System.out.println(strFileName);
			//String strFileName = Util.getEUCKR(request.getParameter("fileName"));
//			fullPath = request.getRealPath(File.separator)+"actual"+File.separator+"upload"+File.separator+fileName;
			fullPath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"jsp/web/upload/"+fileName;
//			ServerStatic.REAL_CONTEXT_ROOT+File.separator+"relate"+File.separator+"/jsp/web/upload/";
			//fullPath = request.getRealPath(File.separator)+fileName;


			System.out.println(" :" + fullPath);

			File file1 = new File(fullPath);
			if (file1.exists()){
				FileDownload.flush( request,  response, fullPath, fileName );
			}else{
				error_msg = cd.Alert_Window("파일이 존재하지 않습니다.", 1, "");
				out.println(error_msg);
			}

} catch (Exception ex) {
	error_msg = cd.Alert_Window(ex.toString(), 1, "");
	out.println(error_msg);
} finally {
}
%>
