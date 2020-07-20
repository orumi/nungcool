<%@ page language    = "java"
         contentType = "text/html; charset=euc-kr"
         import      = "java.util.*,
         				java.net.*,
         				java.io.*,
                        com.nc.cool.*,
                        com.nc.util.*"
%>

<%

	System.out.println("upload.jsp init...");
	SmartUpload myUpload = new SmartUpload();
	Common_Data cd = null;

	myUpload.init(config);
	myUpload.service(request,response);

	myUpload.upload();

	try {
		cd = new Common_Data();


		String subject = cd.ReplaceCode(myUpload.getRequest().getParameter("subject")); // 제목
		String content = cd.ReplaceCode(myUpload.getRequest().getParameter("content")); // 내용
		content = cd.Replace_String(content, "\n", "<br>");

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

			//savepath = "/import/";
			savepath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"import"+File.separator;
			int pos = 0;

			if((pos=filename.indexOf(".")) != -1){
				String left = filename.substring(0, pos);
				String right = filename.substring(pos, filename.length());
				//new_filename = left + System.currentTimeMillis() + right;
			}

			myfile.saveAs(savepath + filename);

			file_no = "F" + System.currentTimeMillis();


		}
			String error_msg = cd.Alert_Window("정상적으로 등록되었습니다.", 2, "./importFile.jsp");
			out.println(error_msg);


	} catch (Exception ex) {
    	out.println(ex);
	} finally {
	}
%>
