<%@ page language    = "java"
         contentType = "text/html; charset=euc-kr"
         import      = "java.util.*,
         				java.net.*,
         				java.io.*,
                        com.nc.cool.*,
                        com.nc.util.*,
                        com.nc.imports.*,
                        com.nc.util.*"
%>
<%
	try {
	    response.setContentType("application/vnd.ms-excel;charset=euc-kr");
	
	    String sn = request.getParameter("sn");
	    String type = request.getParameter("type");
	    
	    if ("hierarchy".equals(type)){
		    String FilePath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"excelFile"+File.separator+"download";
			String FileName  = "hierachy.xls";
		  	Common_Data cd = new Common_Data();
		  	
		    ExportUtil exportutil = new ExportUtil();
		    if(exportutil.createExHierachy(FilePath, FileName)){
		   		//myUpload.init(config);
				//myUpload.service(request,response);
		        //myUpload.downloadFile("excelFile"+File.separator+"download"+File.separator+FileName, "application/vnd.ms-excel;charset=euc-kr", cd.k2o(FileName));
		        
		        FileDownload.flush(request, response, FilePath+"/"+FileName, FileName);
		    	File file = new File(FilePath+File.separator+FileName);
		    	file.delete();
			} else {
			  throw new Exception("?? ?? ??");
			}
	    } else if ("user".equals(type)){
		    String FilePath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"excelFile"+File.separator+"download";
			String FileName  = "user.xls";
		  	Common_Data cd = new Common_Data();
		  	
		    ExportUtil exportutil = new ExportUtil();
		    if(exportutil.createExUser(FilePath, FileName)){
		   		//myUpload.init(config);
				//myUpload.service(request,response);
		        //myUpload.downloadFile("excelFile"+File.separator+"download"+File.separator+FileName, "application/vnd.ms-excel;charset=euc-kr", cd.k2o(FileName));
		        
		        FileDownload.flush(request, response, FilePath+"/"+FileName, FileName);
		    	File file = new File(FilePath+File.separator+FileName);
		    	file.delete();
			} else {
			  throw new Exception("?? ?? ??");
			}
	    } else if ("actual".equals(type)){
		    String FilePath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"excelFile"+File.separator+"download";
			String FileName  = "actual.xls";
		  	Common_Data cd = new Common_Data();
		  	
		    ExportUtil exportutil = new ExportUtil();
		    if(exportutil.createExActual(FilePath, FileName)){
		   		//myUpload.init(config);
				//myUpload.service(request,response);
		        //myUpload.downloadFile("excelFile"+File.separator+"download"+File.separator+FileName, "application/vnd.ms-excel;charset=euc-kr", cd.k2o(FileName));
		        
		        FileDownload.flush(request, response, FilePath+"/"+FileName, FileName);
		    	File file = new File(FilePath+File.separator+FileName);
		    	file.delete();
			} else {
			  throw new Exception("?? ?? ??");
			}
	    }
    } catch (Exception e){
 		out.println("File Load Fail : "+e);   	
    }
    
 %>

