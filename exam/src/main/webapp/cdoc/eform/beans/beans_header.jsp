<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSAKey"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSAKeyInstance"%>
<%@ page language="java" import="com.cabsoft.RXSession"%>
<%@ page language="java" import="com.cabsoft.RXMSession"%>
<%@ page language="java" import="javax.servlet.http.HttpSession"%>

<%!public class HeaderBeans {
		
		private boolean useAbsolutePosition = false;
		
		private boolean devel = false;
		private String toolBarType = RXSession.TOOLBAR_DEFAULT;
		private HttpSession session = null;
		private String jobID = null;
		
		public HeaderBeans(){
			devel = true;
			toolBarType = RXSession.TOOLBAR_DEFAULT;
		}
		
		public void setJobID(String jobID){
			this.jobID = jobID;
		}
		
		public void setUseAbsolutePosition(boolean useAbsolutePosition){
			this.useAbsolutePosition = useAbsolutePosition;
		}
		
		public void setDevel(boolean dev){
			this.devel = dev;
		}
		
		public void setToolBarType(String type){
			this.toolBarType = type;
		}
		
		public String getToolBarType(){
			return this.toolBarType;
		}
		
		public void setSession(HttpSession session){
			this.session = session;
		}
		
		public String downloadForm(String jobID, String exportfileName, String pwd) {
			StringBuffer sb = new StringBuffer();

			sb.append("<form action=\"post\" name=\"frmcert\">\n");
			sb.append("<input type=\"hidden\" name=\"jobID\" value=\"")
					.append(jobID).append("\"></input>\n");
			sb.append("<input type=\"hidden\" name=\"exportFileName\" value=\"")
					.append(exportfileName).append("\"></input>\n");
			sb.append("<input type=\"hidden\" name=\"userpwd\" value=\"").append(pwd).append("\"></input>\n");
			sb.append("</form>\n");
			return sb.toString();
		}

		public String addPageViewMenu(String path) {
			StringBuffer sb = new StringBuffer();
			
			sb.append("<div id='pageNavi' class='chromestyle'></div>\n");
			
			sb.append("<div id=\"showMsg\"></div>\n");

			return sb.toString();
		}

		public String addMenu(String id, String path, String title, String tag,
				String ico) {
			StringBuffer sb = new StringBuffer();

			sb.append("<li id=\"").append(id).append("\"><a href=\"#\"")
					.append(" onclick=\"doMenu('").append(tag).append("');\" title=\"").append(title).append("\">")
					.append("<img alt=\"").append(title).append("\" src=\"")
					.append(path).append("images/").append(ico)
					.append("\" border=\"0\" align=\"top\" />&nbsp;")
					.append(title).append("</a></li>");

			return sb.toString();
		}

		public String addCertMenu(String id, String path, String title,
				String tag, String ico) {
			StringBuffer sb = new StringBuffer();

			sb.append("<li id=\"").append(id)
					.append("\"><a href=\"#\" onclick=\"doMenu('").append(tag)
					.append("');\" title=\"").append(title).append("\"><img alt=\"").append(title).append("\" src=\"").append(path)
					.append("images/").append(ico)
					.append("\" border=\"0\" align=\"top\"/>&nbsp;")
					.append(title).append("</a></li>");

			return sb.toString();
		}
		
		public String addCertKey(String path){
			StringBuffer sb = new StringBuffer();
			String time = String.valueOf(System.currentTimeMillis());
			
			RSAKeyInstance key = RSAKeyInstance.getInstance();
			String e = RSAKey.toHex(key.getKey().getPublicExponent());
			String m = RSAKey.toHex(key.getKey().getModulus());
			
			if(session!=null){
				session.setAttribute("__RSAKEY__", key.getKey());
			}
			
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
				.append("jscrypt/tea-block.js?").append(time).append("\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
				.append("jscrypt/base64.js?").append(time).append("\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
				.append("jscrypt/utf8.js?").append(time).append("\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
				.append("jscrypt/jsbn.js?").append(time).append("\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
				.append("jscrypt/rsa.js?").append(time).append("\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
				.append("jscrypt/crypt.js?").append(time).append("\"></script>\n");
			
			sb.append("<script type=\"text/javascript\" >\n");
			sb.append("mm=\"").append(m).append("\";ee=\"").append(e).append("\";");
			sb.append("</script>\n");
			
			return sb.toString();
		}
		
		public String MenuStart(String bodyID, String path, String title,
				String charset, String jobID, String exportFileName, String rxe) {
			StringBuffer sb = new StringBuffer();
			String time = String.valueOf(System.currentTimeMillis());

			sb.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n");
			sb.append("<html lang=\"ko\">\n");
			sb.append("<head>\n");
			sb.append("<title>").append(title).append("</title>\n");
			sb.append("<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"/>\n");
			sb.append("<meta name=\"reportexpress\" content=\"notranslate\"/>\n");

			sb.append("<meta id=\"Viewport\" name=\"viewport\" width=\"initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no\">\n");
						
 			sb.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=8,IE=9\"/>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
					.append(path).append("css/rxe.css?").append(time)
					.append("\"/>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
					.append(path).append("css/print.css?").append(time)
					.append("\" media=\"print\"/>\n");
			
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
			.append(path).append("css/navi.css?").append(time)
			.append("\" media=\"screen\"/>\n");


			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
			.append(path).append("../css/popbox.css?").append(time)
			.append("\" media=\"screen\"/>\n");
			
			if((RXSession.TOOLBAR_DEFAULT).equalsIgnoreCase(toolBarType)){
				sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
				.append(path).append("../css/popbox.css?").append(time)
				.append("\" media=\"screen\"/>\n");
			}else if((RXSession.TOOLBAR_IOS).equalsIgnoreCase(toolBarType)){
				sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
				.append(path).append("css/toolbarIOS.css?").append(time)
				.append("\" media=\"screen\"/>\n");
			}

			sb.append("<script type=\"text/javascript\" >\n");
				if(jobID!=null && session!=null){
					Object obj = session.getAttribute(jobID + "_session");
					boolean pluginMode = false;
					if (obj instanceof RXSession) {
						RXSession ss = (RXSession)obj;
						pluginMode = ss.isPluginMode();
					}else if (obj instanceof RXMSession) {
						RXMSession ss = (RXMSession)obj;
						pluginMode = ss.isPluginMode();
					}
					if(pluginMode){
						sb.append("var pluginmode=true;\n");
					}else{
						sb.append("var pluginmode=false;\n");
					}
				}else{
					sb.append("var pluginmode=false;\n");
				}
			sb.append("</script>\n");
			
			if(!devel){
				/*
				 * 마우스 우클릭, 선택방지 , 드래그 방지
				 */
				sb.append("<script type=\"text/javascript\" >\n");
				sb.append("document.oncontextmenu=new Function('return false');\n");
				sb.append("document.ondragstart=new Function('return false'); \n");
				sb.append("document.onselectstart=new Function('return false');\n");
				sb.append("</script>\n");

				/*
				 * 키보드 이벤트
				 */
				sb.append("<script type=\"text/javascript\" >\n");

				// CTRL
				sb.append("var isCtrl = false;\n");
				sb.append("document.onkeyup=function(e){ \n");
				sb.append("var keyCode = e.keyCode || window.event.keyCode;\n");
				sb.append("if(keyCode == 17) isCtrl=false;\n");
				sb.append("};\n");
				
				// ALT
				sb.append("var isAlt = false;\n");
				sb.append("document.onkeyup=function(e){ \n");
				sb.append("var event = window.event || e;\n");
				sb.append("if(event.keyCode == 18) isAlt=false;\n");
				sb.append("};\n");

				sb.append("document.onkeydown=function(e){\n");
				sb.append("var event = window.event || e;\n");

				// F5 및 F12 키 -- 사파리에서 동작 안함 ㅠ.ㅠ
				sb.append("if(event.keyCode == 116 || event.keyCode == 123){\n");
				sb.append("event.keyCode = 0;\n");
				sb.append("event.returnValue=false;\n");
				sb.append("return false;\n");
				sb.append("}\n");
						
				sb.append("if(event.keyCode == 17) isCtrl=true;\n");
				sb.append("if(event.keyCode == 18) isAlt=true;\n");
				
				//run code for ALT+F4 -- ie, open!
				sb.append("if(event.keyCode == 115 && isAlt == true) {\n");
				sb.append("event.Handled = true;");
				sb.append("event.returnValue=false;\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+S -- ie, save!
				sb.append("if(event.keyCode == 83 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+O -- ie, open!
				sb.append("if(event.keyCode == 79 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");
				
				//run code for CTRL+P -- ie, open!
				sb.append("if(event.keyCode == 80 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+T -- ie, new tab!  
				sb.append("if(event.keyCode == 84 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+N -- ie 새창
				sb.append("if(event.keyCode == 78 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+A
				sb.append("if(event.keyCode == 65 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+C
				sb.append("if(event.keyCode == 67 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");
				sb.append("};\n");

				sb.append("</script>\n");

			}
			
			/*
			 * JQUERY
			 */
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("js/jquery-1.9.1.js?").append(time)
					.append("\"> </script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("js/jquery.blockUI.js?").append(time)
					.append("\"> </script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("js/jquery.fileDownload.js?").append(time)
					.append("\"> </script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("js/jquery-ui.js?").append(time)
					.append("\"> </script>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
					.append(path).append("css/jquery-ui.css?").append(time)
					.append("\" media=\"screen\"/>\n");


			/*
			 * rxAcrobatInfo.js
			 */
				sb.append("<script type=\"text/javascript\" src=\"").append(path)
				.append("js/rxAcrobatInfo.js").append("?").append(time).append("\"></script>\n");
			
				// 추가 javascript
				sb.append("<script type=\"text/javascript\" src=\"").append(path)
				.append("js/lastadd.js").append("?").append(time).append("\"></script>\n");
			
			
			/*
			 * MODAL WINDOW
			 */
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
					.append(path).append("window/dhtmlxwindows.css\"/>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
					.append(path)
					.append("window/skins/dhtmlxwindows_dhx_skyblue.css\"/>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("window/dhtmlxcommon.js\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("window/dhtmlxwindows.js\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("window/dhtmlxcontainer.js\"></script>\n");
			
			sb.append("<script type=\"text/javascript\">var toolBarType='"+toolBarType+"';</script>\n");			

			/*
			 * rxe.js
			 */
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("js/").append(rxe).append("?").append(time)
					.append("\"></script>\n");
			
			/*
			 * popbox.js
			 */
			sb.append("<script type=\"text/javascript\" src=\"").append(path)
					.append("../js/").append("popbox.js").append("?").append(time)
					.append("\"></script>\n");
			
			/*
			 * MENU STYLE
			 */
			if((RXSession.TOOLBAR_DEFAULT).equalsIgnoreCase(toolBarType)){
				sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"")
						.append(path).append("css/chromestyle.css\" media=\"screen\"/>\n");
			}
			sb.append("</head>\n");
			
			sb.append("<body id=\"").append(bodyID)
				.append("\" bgcolor=\"#ffffff\">\n");

			/*
			 * AJAX
			 */
			 sb.append("<div id=\"ajax_indicator\" style=\"display: none;\">\n");
			 sb.append("<div class=\"barMain\">\n");
			 sb.append("<div class=\"msg\" id=\"msg\">작업 처리 중입니다.</div>\n");
			 sb.append("<div class=\"captions\">작업이 완료되는 동안 잠시만 기다려 주십시오</div>\n");
			 sb.append("</div>\n");
			 sb.append("</div>\n");

			 if((RXSession.TOOLBAR_DEFAULT).equalsIgnoreCase(toolBarType)){
				 /*
				 * 말풍선
				 */
				sb.append("<div class='popbox'>\n");
				sb.append("<div class='collapse'>\n");
				sb.append("<div class='box'>\n");
				sb.append("<div class='arrow'></div>\n");
				sb.append("<div class='arrow-border'></div>\n");
				sb.append("<p id='popboxDes'>\n");
				sb.append("</p>\n");
				sb.append("</div>\n");
				sb.append("</div>\n");
				sb.append("</div>\n");
								 
			 }else if((RXSession.TOOLBAR_IOS).equalsIgnoreCase(toolBarType)){
				 if("htmlViewer".equalsIgnoreCase(bodyID)){
					sb.append("<div id='toolbar-modal-controls' style='display: block;'>\n");
					sb.append("<a title='PDF내보내기' onclick=\"doMenu('pdf');\" class='pdf' href='#'>PDF내보내기</a>\n");
					sb.append("<a title='엑셀내보내기' onclick=\"doMenu('xls');\" class='xls' href='#'>엑셀내보내기</a>\n");
					sb.append("<a title='이전 페이지로 이동' onclick=\"doMenu('before');\" class='first' href='#'>이전 페이지로 이동</a>\n");
					sb.append("<a id='hpageno' title='현재 페이지' class='hpageno' href='#'><div id=\"pageno\" style=\"cursor:default\">-</div></a>\n");
					sb.append("<a title='다음 페이지로 이동' onclick=\"doMenu('next');\" class='last' href='#'>다음 페이지로 이동</a>\n");
					
					sb.append("<a title='닫기' onclick=\"doMenu('close');\" class='close' href='#'>닫기</a>\n");
					sb.append("</div>\n");
				 }else if("smartCertViewer".equalsIgnoreCase(bodyID)){
					sb.append("<div id='toolbar-modal-controls' style='display: block;'>\n");
					sb.append("<a title='전자문서 발급' onclick=\"doMenu('save_signedpdf');\" class='pdf' href='#'>전자문서 발급</a>\n");
					sb.append("<a title='이전 페이지로 이동' onclick=\"doMenu('before');\" class='first' href='#'>이전 페이지로 이동</a>\n");
					sb.append("<a id='hpageno' title='현재 페이지' class='hpageno' href='#'><div id=\"pageno\" style=\"cursor:default\">-</div></a>\n");
					sb.append("<a title='다음 페이지로 이동' onclick=\"doMenu('next');\" class='last' href='#'>다음 페이지로 이동</a>\n");
					
					sb.append("<a title='닫기' onclick=\"doMenu('close');\" class='close' href='#'>닫기</a>\n");
					sb.append("</div>\n");
				 }
						 
			 }
			
			sb.append("<iframe id='eFormDown' name='eFormDown' style='width: 0px;height: 0px;display: none;'></iframe>");

			sb.append("<div class=\"chromestyle\" id=\"chromemenu\">\n");
			sb.append("<ul>\n");

			return sb.toString();
		}

		public String MarkAnyStart(String bodyID, String path, String title, String charset, String jobID, String rxe) {
			StringBuffer sb = new StringBuffer();
			String time = String.valueOf(System.currentTimeMillis());

//			sb.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n");
//			sb.append("<html lang=\"ko\">\n");
			
			sb.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
			sb.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">");
			sb.append("<head>\n");
			sb.append("<title>").append(title).append("</title>\n");
			sb.append("<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"/>\n");
			sb.append("<meta name=\"reportexpress\" content=\"notranslate\"/>\n");
			sb.append("<meta name=\"viewport\" content=\"user-scalable=yes,width=device-width;\"/>\n");
			sb.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=8,IE=9,chrome=1\"/>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"").append(path).append("css/rxe.css?").append(time).append("\"/>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"").append(path).append("css/print.css?").append(time)
					.append("\" media=\"print\"/>\n");

			if(!devel){
				
				/*
				 * 마우스 우클릭, 선택방지 , 드래그 방지
				 */
				sb.append("<script type=\"text/javascript\" >\n");
				sb.append("document.oncontextmenu=new Function('return false');\n");
				sb.append("document.ondragstart=new Function('return false'); \n");
				sb.append("document.onselectstart=new Function('return false');\n");
				sb.append("</script>\n");

				/*
				 * 키보드 이벤트
				 */
				sb.append("<script type=\"text/javascript\" >\n");

				// CTRL
				sb.append("var isCtrl = false;\n");
				sb.append("document.onkeyup=function(e){ \n");
				sb.append("if(e.which == 17) isCtrl=false;\n");
				sb.append("};\n");

				// ALT
				sb.append("var isAlt = false;\n");
				sb.append("document.onkeyup=function(e){ \n");
				sb.append("if(e.which == 18) isAlt=false;\n");
				sb.append("};\n");

				sb.append("document.onkeydown=function(e){\n");

				// F5 및 F12 키 -- 사파리에서 동작 안함 ㅠ.ㅠ
				sb.append("if(e.keyCode == 116 || e.keyCode == 123){\n");
				sb.append("e.returnValue=false;\n");
				sb.append("return false;\n");
				sb.append("}\n");

				sb.append("if(e.which == 17) isCtrl=true;\n");
				sb.append("if(e.which == 18) isAlt=true;\n");

				//run code for ALT+F4 -- ie, open!
				sb.append("if(e.keyCode == 115 && isAlt == true) {\n");
				sb.append("e.Handled = true;");
				sb.append("e.returnValue=false;\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+S -- ie, save!
				sb.append("if(e.which == 83 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+O -- ie, open!
				sb.append("if(e.which == 79 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+P -- ie, open!
				sb.append("if(e.which == 80 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+T -- ie, new tab!  
				sb.append("if(e.which == 84 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+N -- ie 새창
				sb.append("if(e.which == 78 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+A
				sb.append("if(e.which == 65 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");

				//run code for CTRL+C
				sb.append("if(e.which == 67 && isCtrl == true) {\n");
				sb.append("return false;\n");
				sb.append("}\n");
				sb.append("};\n");

				sb.append("</script>\n");

			}

			/*
			 * rxe.js
			 */
			sb.append("<script type=\"text/javascript\" src=\"").append(path).append("js/").append(rxe).append("?").append(time)
					.append("\"></script>\n");

			sb.append("</head>\n");

			if (useAbsolutePosition == false) {
				sb.append("<body id=\"").append(bodyID).append("\" bgcolor=\"#eeeeee\">\n");
			} else {
				sb.append("<body id=\"").append(bodyID).append("\" bgcolor=\"#ffffff\">\n");
			}
			return sb.toString();
		}

		public String MenuEnd(String path) {
			StringBuffer sb = new StringBuffer();

			sb.append("<li><a href=\"#\" onclick=\"doMenu('first');\" title=\"첫 페이지로 이동\"><img alt=\"첫 페이지\" src=\"").append(path)
					.append("images/first.gif\" border=\"0\" align=\"top\" /></a></li>\n");
			sb.append("<li><a href=\"#\" onclick=\"doMenu('before');\" title=\"이전 페이지로 이동\"><img alt=\"이전 페이지\" src=\"").append(path)
					.append("images/before.gif\" border=\"0\" align=\"top\" /></a></li>\n");
			sb.append("<li><a id=\"hpageno\" href=\"#\" title=\"현재 페이지\"><span id=\"pageno\" style=\"cursor:default\">-</span></a></li>\n");
			sb.append("<li><a href=\"#\" onclick=\"doMenu('next');\" title=\"다음 페이지로 이동\"><img alt=\"다음 페이지\" src=\"").append(path)
					.append("images/next.gif\" border=\"0\" align=\"top\" /></a></li>\n");
			sb.append("<li><a href=\"#\" onclick=\"doMenu('last');\" title=\"마지막 페이지로 이동\"><img alt=\"마지막 페이지\" src=\"").append(path)
					.append("images/last.gif\" border=\"0\" align=\"top\" /></a></li>\n");


			/*
			PDF 플러그인 체크로 자동 다운로드 할수있게 변경 2013.08.19 박용준
			sb.append("<li><a href=\"http://get.adobe.com/kr/reader/\" target=\"pdf_viewer_install\" title=\"PDF 뷰어 설치\"><img alt=\"PDF 뷰어 설치\" src=\"")
					.append(path)
					.append("images/reader.gif\" border=\"0\" align=\"top\"/>&nbsp;PDF 뷰어 설치</a></li>");
			*/
			
			sb.append("<li><a href=\"#\" onclick=\"doMenu('close');\" title=\"뷰어 닫기\"><img alt=\"닫기\" src=\"").append(path)
					.append("images/close.gif\" border=\"0\" align=\"top\"/>&nbsp;닫기</a></li>\n");
			sb.append("<li><a id=\"hversion\" href=\"#\"><span id=\"version\" style=\"cursor:default; font-weight: normal;\"></span></a></li>\n");

			sb.append("</ul>\n");
			sb.append("</div>\n");

			sb.append("<script type=\"text/javascript\">\n");
			sb.append("cssdropdown.startchrome(\"chromemenu\");\n");
			sb.append("</script>\n");
			return sb.toString();
		}

		public String ProbeMenuEnd(String path) {
			StringBuffer sb = new StringBuffer();

			sb.append("<li><a href=\"#\" onclick=\"doMenu('first');\" title=\"첫 페이지로 이동\"><img alt=\"첫 페이지\" src=\"").append(path)
					.append("images/first.gif\" border=\"0\" align=\"top\" /></a></li>\n");
			sb.append("<li><a href=\"#\" onclick=\"doMenu('before');\" title=\"이전 페이지로 이동\"><img alt=\"이전 페이지\" src=\"").append(path)
					.append("images/before.gif\" border=\"0\" align=\"top\" /></a></li>\n");
			sb.append("<li><a id=\"hpageno\" href=\"#\" title=\"현재 페이지\"><span id=\"pageno\" style=\"cursor:default\">-</span></a></li>\n");
			sb.append("<li><a href=\"#\" onclick=\"doMenu('next');\" title=\"다음 페이지로 이동\"><img alt=\"다음 페이지\" src=\"").append(path)
					.append("images/next.gif\" border=\"0\" align=\"top\" /></a></li>\n");
			sb.append("<li><a href=\"#\" onclick=\"doMenu('last');\" title=\"마지막 페이지로 이동\"><img alt=\"마지막 페이지\" src=\"").append(path)
					.append("images/last.gif\" border=\"0\" align=\"top\" /></a></li>\n");
			sb.append("<li><a href=\"#\" onclick=\"doMenu('close');\" title=\"뷰어 닫기\"><img alt=\"닫기\" src=\"").append(path)
					.append("images/close.gif\" border=\"0\" align=\"top\"/>&nbsp;닫기</a></li>\n");
			sb.append("<li><a id=\"hversion\" href=\"#\"><span id=\"version\" style=\"cursor:default; font-weight: normal;\"></span></a></li>\n");

			sb.append("</ul>\n");
			sb.append("</div>\n");

			sb.append("<script type=\"text/javascript\">\n");
			sb.append("cssdropdown.startchrome(\"chromemenu\");\n");
			sb.append("</script>\n");
			return sb.toString();
		}

		public String TabletMenu(String bodyID, String path, String title, String charset, String jobID, String exportFileName, String rxe) {

			StringBuffer sb = new StringBuffer();
			String time = String.valueOf(System.currentTimeMillis());

			sb.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n");
			sb.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">\n");
			sb.append("<head>\n");
			sb.append("<title>").append(title).append("</title>\n");
			sb.append("<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"/>\n");
			sb.append("<meta name=\"reportexpress\" content=\"notranslate\"/>\n");
			sb.append("<meta name=\"viewport\" content=\"user-scalable=yes; initial-scale=1;\"/>\n");
			sb.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=8;IE=9;\"/>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"").append(path).append("css/rxe.css?").append(time).append("\"/>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"").append(path).append("css/print.css?").append(time)
					.append("\" media=\"print\"/>\n");

			sb.append("<script type=\"text/javascript\" src=\"").append(path).append("js/jquery-1.9.1.js?").append(time).append("\"> </script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path).append("js/jquery.blockUI.js?").append(time).append("\"> </script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path).append("js/jquery.fileDownload.js?").append(time)
					.append("\"> </script>\n");

			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"").append(path).append("window/dhtmlxwindows.css\"/>\n");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"").append(path).append("window/skins/dhtmlxwindows_dhx_skyblue.css\"/>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path).append("window/dhtmlxcommon.js\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path).append("window/dhtmlxwindows.js\"></script>\n");
			sb.append("<script type=\"text/javascript\" src=\"").append(path).append("window/dhtmlxcontainer.js\"></script>\n");

			sb.append("<script type=\"text/javascript\" src=\"").append(path).append("js/").append(rxe).append("?").append(time)
					.append("\"></script>\n");

			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"").append(path).append("css/menu_style.css\"/>\n");
			sb.append("</head>\n");

			if (useAbsolutePosition == false) {
				sb.append("<body id=\"").append(bodyID).append("\" bgcolor=\"#eeeeee\">\n");
			} else {
				sb.append("<body id=\"").append(bodyID).append("\" bgcolor=\"#ffffff\">\n");
			}
			/*
			 * AJAX
			 */
			sb.append("<div id=\"ajax_indicator\" style=\"display: none;\">\n");
			sb.append("<p style=\"text-align: center; padding: 0 0 0 0; left: 50%; top: 50%; position: absolute;\">\n");
			sb.append("<img src=\"").append(path).append("loading/loading.gif\" style=\"border: 0px solid;\" alt=\"loading image\"/>\n");
			sb.append("</p>\n");
			sb.append("</div>\n");

			sb.append("<div id=\"menu\" class=\"toolbar_menu\" style=\"width: 1000px;\">\n");
			sb.append("<ul>\n");
			return sb.toString();
		}
	}%>