<%@ page language    = "java"
         contentType = "text/html; charset=euc-kr"
         import      = "java.util.*,
         				java.net.*,
         				java.io.*,
						java.text.SimpleDateFormat,
                        com.nc.cool.*,
                   		com.nc.commu.*,
                        com.nc.util.*"
%>
<%
	String imgUri 		= request.getRequestURI();
	//System.out.println("#1");
	String imgUriC		= imgUri.substring(1);
	imgUri 				= "../../../../" + imgUriC.substring(0, imgUriC.indexOf("/"));
	String imgUriPath 	= "/" + imgUriC.substring(0, imgUriC.indexOf("/"));
	//System.out.println("#2");
	
	String groupId 		= (String) session.getAttribute("groupId");
	String userName 	= (String) session.getAttribute("userName");
	String userId 		= (String) session.getAttribute("userId");
	//System.out.println("#3");

	String result		= "";
	String[] result_split;
	
	String acceptable	= "Y";
%>
<%	
    if (userId == null || ("".equals(userId))) {
%>
<script language="javascript">
<!--
		var id = "<%=userId%>";
		var sure;
		if(id == "null" || id == "")	{
			alert("다시 로그인접속하여 주십시오.");
			top.location.href = "../loginProc.jsp";
		}
//-->
</script>
<%
    } else {
    	Common_Data cd = null;
    	cd = new Common_Data();
		try {
			CommuBoard cB = new CommuBoard();
			//System.out.println("qstnSeq@@@@@@@@>"+qstnSeq+" || "+"ansrSeq@@@@@@@>"+ansrSeq);
			/**********************
			**********************/
			//cB.setCommuRecordSave(request, response, userId, div_cd, tag, title, email, content, getFilePath, seq, qstnSeq, ansrSeq, depth);  
			
			result = cB.setCommuRecordSave(request, response); 
			
			acceptable = request.getAttribute("acceptable")==null?"":(String)request.getAttribute("acceptable");
			if(acceptable.trim().equals("N"))	{
				 throw new IOException("NoAffected"); 
			}
			result_split = result.split("@#@");
			//System.out.println("#4");
			
			if(result_split[1].equals("nullVal"))	{
				result_split[1] = "";
			}
			
			if(result_split[2].equals("nullVal"))	{
				result_split[2] = "";
			}
			
			if(result_split[3].equals("nullVal"))	{
				result_split[3] = "";
			}
			
			if(result_split[4].equals("nullVal"))	{
				result_split[4] = "";
			}
			
			if(result_split[5].equals("nullVal"))	{
				result_split[5] = "";
			}
			//System.out.println("#5");
			
			//System.out.println("result_split[0] ==> " + result_split[0] + "\n");
			//System.out.println("result_split[1] ==> " + result_split[1] + "\n");
			//System.out.println("result_split[2] ==> " + result_split[2] + "\n");
			//System.out.println("result_split[3] ==> " + result_split[3] + "\n");
			//System.out.println("result_split[4] ==> " + result_split[4] + "\n");
			//System.out.println("result_split[5] ==> " + result_split[5] + "\n");
		
			if(result_split[0].equals("C"))	{
				String error_msg = cd.Alert_Window("정상적으로 등록되었습니다.", 2, "./bbs_list.jsp?div_cd="+result_split[1]+"&currentPage=1");
				out.println(error_msg);
			}else if(result_split[0].equals("R"))	{
				String error_msg = cd.Alert_Window("답변글이 정상적으로 등록되었습니다.", 2, "./bbs_list.jsp?div_cd="+result_split[1]+"&currentPage="+result_split[3]+"&keyWord="+result_split[4]+"&searchCode="+result_split[5]);
				out.println(error_msg);
			}else if(result_split[0].equals("U"))	{
				String error_msg = cd.Alert_Window("정상적으로 수정되었습니다.", 2, "./bbs_read.jsp?div_cd="+result_split[1]+"&seq="+result_split[2]+"&currentPage="+result_split[3]+"&keyWord="+result_split[4]+"&searchCode="+result_split[5]);
				out.println(error_msg);
			}else if(result_split[0].equals("FD"))	{
				//String error_msg = cd.Alert_Window("선택하신 파일이 삭제되었습니다.", 2, "./bbs_read.jsp?div_cd="+result_split[1]+"&seq="+result_split[2]+"&currentPage="+result_split[3]+"&keyWord="+result_split[4]+"&searchCode="+result_split[5]);
				String error_msg = cd.Alert_Window("선택하신 파일이 삭제되었습니다.", 2, "./bbs_write.jsp?div_cd="+result_split[1]+"&seq="+result_split[2]+"&currentPage="+result_split[3]+"&keyWord="+result_split[4]+"&searchCode="+result_split[5]+"&tag=U");
				out.println(error_msg);
			}
		} catch(IOException e) {
%>			
			<script> 
			 alert("선택하신 파일의 용량이 큽니다.\n첨부하실 수 있는 파일의 용량은 최대 크기가 30M입니다.");  
			 history.back(); 
			</script> 
<%			
		} catch (Exception ex) {
	    	System.out.println(ex);
		} finally {
		}
    }
%>

