<%@ page language    = "java"
         contentType = "text/html; charset=utf-8"
         import      = "java.util.*,
         				java.net.*,
         				java.io.*,
                        com.nc.cool.*,
                        com.nc.util.*"
%>
<%
	System.out.println("upload import...");
	SmartUpload myUpload = new SmartUpload();
	Common_Data cd = null;

	myUpload.init(config);
	myUpload.service(request,response);

	myUpload.upload();
	String jobProc = "";
	try {
		cd = new Common_Data();

		CoolFile myfile = myUpload.getFiles().getFile(0);
		String filename = myfile.getFileName();
		String filetype = myfile.getFileExt();
		String filesize = Long.toString(myfile.getSize());
		String savepath = "";
		String new_filename = "";
		int result_val = 0;
		String date_val = cd.getDate();
		String file_no = "";

		if (!myfile.isMissing()) {

			savepath = ServerStatic.REAL_CONTEXT_ROOT+"/import/"; //"/import/";
			int pos = 0;

			if((pos=filename.indexOf(".")) != -1){
				String left = filename.substring(0, pos);
				String right = filename.substring(pos, filename.length());
				//new_filename = left + System.currentTimeMillis() + right;
			}

			myfile.saveAs(savepath + filename);

			file_no = "F" + System.currentTimeMillis();


		}
		//String error_msg = cd.Alert_Window("정상적으로 등록되었습니다.", 2, "./taskImportExl.jsp");
		//out.println(error_msg);

		//등록된 파일을 처리
		try{
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		} catch(Exception ee) {}

		String imgUri = request.getRequestURI();
		imgUri = imgUri.substring(1);
		imgUri = "../../../../"+imgUri.substring(0, imgUri.indexOf("/"));

		ImportUtil importutil = null;
		HashMap rtnMap = new HashMap();

		try {
			importutil = new ImportUtil();
			//System.out.println("importing starting..."+filename);
			importutil.importTaskActual(filename, rtnMap, request,response);

		}catch (Exception e) {
			System.out.println("Importing Error :"+e);
			String temp = e.toString();
			temp = temp.replaceAll("\r\n","  ");
			temp = temp.replaceAll("\r","  ");
			temp = temp.replaceAll("\n","");
			System.out.println(temp);
			rtnMap.put("error", temp);
		} finally {
			File file = new File(ServerStatic.REAL_CONTEXT_ROOT+File.separator+"import"+File.separator+filename);
			System.out.println("파일 삭제중..."+ServerStatic.REAL_CONTEXT_ROOT+File.separator+"import"+File.separator+filename);
			try{
	 			file.delete();
	 		}catch(Exception e){
	   			System.out.println("파일 삭제 실패 : "+ e.getMessage());
	 		}finally {
	 		}
		}
		jobProc = "S";
	} catch (Exception ex) {
    	out.println(ex);
    	jobProc = "F";
	} finally {
		System.out.println("End Of Importing!!!");
	}
%>
<html>
<script language='javascript'">
	window.opener.document.getElementById("detail").style.display="none";
<% if(jobProc == "S"){ %>
	self.close();
<% } else{ %>
	self.close();
<% } %>
</script>
</html>