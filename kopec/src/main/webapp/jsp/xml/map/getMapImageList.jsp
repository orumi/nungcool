<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
				 java.io.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
    String filePath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"mapImage";
	File file = new File(filePath);
	String a[]=file.list();
	StringBuffer sb = new StringBuffer();
	for(int i=0;i<a.length;i++){
		sb.append(a[i]+"|");
	}
	out.println(sb.toString());
%>