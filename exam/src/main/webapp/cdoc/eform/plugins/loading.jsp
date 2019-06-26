<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="com.cabsoft.utils.sysinfo"%>
<%@page import="java.net.URLDecoder"%>
<%
String time = String.valueOf(System.currentTimeMillis());
String agent = request.getHeader("User-Agent");
String os = sysinfo.os(agent);
String bw = sysinfo.bw(agent);

String __p = (String)request.getParameter("__p");
String __q = (String)request.getParameter("__q");
String url = (String)request.getParameter("__url");
%>
<html>
<head>
  <title>eForm PDF Viewer 설치/업데이트 중 ...</title>
  <META http-equiv="Content-Type" content="text/html; charset=utf-8" Cache-control="no-cache" Pragma="no-cache">
  <link rel="stylesheet" type="text/css" href="./css/Content.css">
  <script type="text/javascript" src="./js/eformplugins.js?<%=time%>"></script>
  <script type="text/javascript" src="./js/rxAcrobatInfo.js?<%=time%>"></script>
	<script type="text/javascript">
		var timer = null;
		
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
		
		function Check(){
			if((checkPluginsF())==false){
				setTimeout("Check()",100);
			}else{
				doRun();
			}
		}
		
		function doRun(){
			var frm = makeForm("<%=url%>");
			frm.appendChild(addData('__p',"<%= __p%>"));
			frm.appendChild(addData('__q', "<%=__q%>"));
			frm.submit();
		}
		
		function Plugins() {
			if(bw()=="ie"){
				initF();
				if(checkPluginsF()==false){
					Check();
// 					if(timer){clearInterval(timer);timer=null;}
// 					timer=setInterval("Check();", 1000);
				}
			}
		}
	</script>
</head>

<body onload="Plugins();">
<div id="viewer"></div>
<table cellspacing="0" cellpadding="0" align="center" style="height:100%;">
  <tr>
    <td>
      <div class="loading_bg">
        <h1 class="title"><span class="f_blue">eForm PDF Viewer™</span> 프로그램을 설치/업데이트</h1>
        <div class="lo_top_con">
          <ul class="lo_img">
            <li><img src="images/loading_img_01.gif" alt="" /></li>
            <li>
              <span class="bl mt22"><img src="images/loading_text_01.gif" alt="" /></span>
              <span class="bl mt5"><img src="images/loading_bar.gif" alt="" /></span>
              <span class="bl mt7"><img src="images/loading_text_02.gif" alt="" /></span>
            </li>
          </ul>
          <ul class="g_dot">
<%if("ie".equals(bw)){%>          
            <li><span class="f_blue">eForm PDF Viewer™</span> 설치여부를 묻는 ‘보안경고창’이 나타나면 반드시 <span class="f_ora">“예”</span>를<br>선택하여 주십시오.</li>
            <li>이는 제품 설치/업데이트에 필요한 프로그램 설치이므로 “아니오” 를 선택하시면<br>서비스를 이용하실 수 없습니다.</li>
<%}else{%>
            <li><span class="f_blue">eForm PDF Viewer™</span> <a
							href="./cab/rxpdfviewerPlugin.exe"><span class="f_ora"><b>“설치 파일”</b></span></a>을 다운로드하여 설치하십시오.</li>
            <li>이는 제품 설치/업데이트에 필요한 프로그램 설치이므로 “아니오” 를 선택하시면<br>서비스를 이용하실 수 없습니다.</li>
<%}%>
          </ul>
        </div>
        <div class="ml32"><img src="images/lo_box_top.gif" alt="" /></div>
        <div class="lo_box_bg">
          <ul>
            <li><span class="f_blue">eForm PDF Viewer™</span>가 고객님의 컴퓨터에 제품을 설치/업데이트 중입니다.</li>
<%if("ie".equals(bw)){%>
            <li><span class="f_blue">eForm PDF Viewer™</span> 설치에 문제가 있으시면 <a
							href="./cab/rxpdfviewerPlugin.exe"><span class="f_ora"><b>“여기”</b></span></a>를 눌러서 수동설치 파일을
              다운로드한 후에 설치하세요.
            </li>
<%}%>
            <li>프로그램을 설치/업데이트 한 후 플러그인을 실행 시키려면<a
                    href="javascript:doRun();"><span class="f_ora"><b>“플러그인 실행”</b></span></a>을 눌러주세요.
            </li>
          </ul>
        </div>
        <div class="ml32"><img src="images/lo_box_bottom.gif" alt="" /></div>
      </div>
    </td>
  </tr>
</table>
</body>
</html>