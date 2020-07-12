<%@page contentType="text/html;charset=EUC-KR"%>
<%@page import="com.oreilly.servlet.MultipartRequest,
                com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
                java.util.*,
                java.io.*"
%>


<%

try{
      int sizeLimit = 10 * 1024 * 1024; // 2M, 파일 사이즈 제한, 제한 사이즈 초과시 exception발생.
      String UPLOADROOT = getServletContext().getRealPath("mapImage"); // 경로 지정(절대 경로 | ROOT를 기준으로 한 상대경로)


      String UPLOADPATH = UPLOADROOT + File.separator;
      MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"UTF-8",
                                                    new DefaultFileRenamePolicy()); // 이부분에서 upload가 됨.


    } catch(Exception e) {
         out.print(e.getMessage());

    }

%>