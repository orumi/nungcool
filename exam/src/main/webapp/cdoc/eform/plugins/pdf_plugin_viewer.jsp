<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="com.cabsoft.utils.sysinfo"%>
<%
String time = String.valueOf(System.currentTimeMillis());

String protocol = request.getScheme(); 
String server = request.getServerName();
int port = request.getServerPort();
String path = request.getContextPath();
String mode = (String)request.getParameter("mode");
mode = (mode==null || "".equals(mode)) ? "html" : mode;

String url0 = protocol + "://" + server + ":" + port + path + "/cdoc/eform/" + mode + "_serviceexport.jsp";

String __p = (String)request.getParameter("__p");
String __q = (String)request.getParameter("__q");
String url = url0 + "?__p=" + __p + "&__q=" + __q;

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko-KR">
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8" Cache-control="no-cache" Pragma="no-cache">
<title>ReportExpress eForm PDF Viewer</title>
<script type="text/javascript" src="./js/eformplugins.js?<%=time%>"></script>
<script type="text/javascript" src="./js/rxAcrobatInfo.js?<%=time%>"></script>
<script language="JavaScript">
	var pluginobj;
	
	function makeForm(target_url){
		var f = document.createElement("form");
	    f.setAttribute("method", "post");
	    f.setAttribute("action", target_url);
	    document.body.appendChild(f);
	      
	    return f;
	}
	
	function addData(name, value){
		var i = document.createElement("input");
		i.setAttribute("type","hidden");
		i.setAttribute("name",name);
		i.setAttribute("value",value);
		return i;
	}
	
	function Close(){
		top.window.opener = top;
		top.window.open('', '_parent', '');
		top.window.close();
		window.close();
		self.close();
	}

	// ie 전용 함수
	function Run() {
		try{
			var pluginobj = document.getElementById("RXPdfViewer");
			pluginobj.Initialize();
			pluginobj.Server="<%=url%>";
			pluginobj.Timeout = 20;
			pluginobj.FileName = "테스트.pdf";
			pluginobj.PrintOnly = false;

			var result = pluginobj.RunViewer();
			if(result=="OK"){
				Close();
			}else{
				alert(result);
				Close();
			}

		}catch(e){
			alert(e.description);
		}
	}

    /* instantiate the plugin */
	window.onload = function(){
		init();
		//checkPluginsF() cabsoft pdf viewer Plugins
		if(checkPluginsF()==false){
//if(checkPlugins()==false){
			try{
				/*
				 * 플러그인 설치
				 */
				var frm = makeForm("./loading.jsp");
				frm.appendChild(addData('__url', "pdf_plugin_viewer.jsp"));
				frm.appendChild(addData('__p',"<%= __p%>"));
				frm.appendChild(addData('__q', "<%=__q%>"));
				frm.submit();
			}catch(e){
				alert(e.description);
			}
		}else{
			/*
			 * 설치되어 있는 경우 ,installedActiveX() : cabsoft plugin 을 기본으로 사용
			 * getpluginname() : 설치되어 있는 plugin 명
			 */
			if(bw()=="ie" && getpluginname()=="cabsoft"){
				Run();
			} else {
				try{
					var frm = makeForm("<%=url0%>");
					frm.appendChild(addData('__p',"<%= __p%>"));
					frm.appendChild(addData('__q', "<%=__q%>"));
					frm.submit();
				}catch(e){
					alert(e.description);
				}
			}
		}
	}
  </script>
<style type="text/css">
html,body{
	height:100%;
	margin: 0
}
</style>
 </head>
 <body>
	<div id="viewer"></div>
 </body>
</html>
