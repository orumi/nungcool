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
			
			System.out.println(fileName);
			
			//String strFileName = Util.getEUCKR(request.getParameter("fileName"));			
			fullPath = request.getRealPath(File.separator)+"actual"+File.separator+"upload"+File.separator+fileName;
			//fullPath = request.getRealPath(File.separator)+fileName;			
						
			
			System.out.println("fullPath :" + fullPath);
			
			File file1 = new File(fullPath);
			if (file1.exists()){					
				FileDownload.flush( request,  response, fullPath, fileName );								    
			}else{			
				error_msg = cd.Alert_Window("파일경로가 잘못되었습니다.", 1, "");
				out.println(error_msg);
			}
					
} catch (Exception ex) {	
	error_msg = cd.Alert_Window(ex.toString(), 1, "");
	out.println(error_msg);		
} finally {
}
%>
