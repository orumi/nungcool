<%@page contentType="text/html;charset=EUC-KR"%>
<%@page import="com.oreilly.servlet.MultipartRequest,
                com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
                java.util.*,
                java.io.*"
%>


<%

try{
      int sizeLimit = 10 * 1024 * 1024; // 2M, ���� ������ ����, ���� ������ �ʰ��� exception�߻�.
      String UPLOADROOT = getServletContext().getRealPath("mapImage"); // ��� ����(���� ��� | ROOT�� �������� �� �����)


      String UPLOADPATH = UPLOADROOT + File.separator;
      MultipartRequest multi=new MultipartRequest(request,UPLOADPATH,sizeLimit,"UTF-8",
                                                    new DefaultFileRenamePolicy()); // �̺κп��� upload�� ��.


    } catch(Exception e) {
         out.print(e.getMessage());

    }

%>