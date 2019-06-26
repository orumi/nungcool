<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@ page language="java" import="java.io.ByteArrayOutputStream"%>
<%@ page language="java" import="java.net.URLEncoder"%>
<%@ page language="java" import="java.io.File"%>
<%@ page language="java" import="java.io.FileOutputStream"%>
<%@ page language="java" import="javax.servlet.ServletOutputStream"%>
<%@ page language="java" import="javax.servlet.http.HttpServletRequest"%>
<%@ page language="java" import="javax.servlet.http.HttpServletResponse"%>
<%@ page language="java" import="org.apache.commons.logging.Log"%>
<%@ page language="java" import="org.apache.commons.logging.LogFactory"%>
<%@ page language="java" import="com.cabsoft.utils.RXobjSaver"%>
<%@ page language="java" import="com.cabsoft.rx.engine.RXException"%>
<%@ page language="java" import="com.cabsoft.smartcert.mobile.PdfPKCS7Info"%>
<%@ page language="java" import="com.cabsoft.utils.StringUtils"%>
<%@ page language="java" import="com.cabsoft.utils.Crypt"%>
<%@ page language="java" import="com.cabsoft.utils.StringUtils"%>
<%@ page language="java" import="com.cabsoft.utils.SystemUtils"%>
<%@ page language="java" import="com.cabsoft.utils.IssuerID"%>
<%@ page language="java" import="com.cabsoft.utils.StackTrace"%>
<%@ page language="java" import="com.cabsoft.sign.service.PdfSignService"%>
<%@ page language="java" import="com.cabsoft.utils.sysinfo"%>
<%@ page language="java" import="com.cabsoft.RXSession"%>
<%@ page language="java" import="com.cabsoft.utils.SimpleQuery"%>
<%@ page language="java" import="com.cabsoft.RXSession"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSAKey"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSAKeyInstance"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSA"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.TEA"%>

<%@ page language="java" import="com.cabsoft.GlobalParams"%>

<%!@SuppressWarnings({ "deprecation", "unused" })
	public class SmartCertSignService {
		private final Log log = LogFactory.getLog(SmartCertSignService.class);

		public void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
			try{
				HttpSession session = request.getSession();
				ServletOutputStream out = response.getOutputStream();
				
				String ua = request.getHeader("User-Agent");
				String os = sysinfo.os(ua);
				String bw = sysinfo.bw(ua);
				float version = sysinfo.version(ua);
				
				String jobID = "";
				RXSession ss = null;
				String jobIDOrg = (String) session.getAttribute("jobID");
				
				if(null == jobIDOrg){
					throw new Exception("[전자문서 서명]서버에 생성 정보가 없습니다.");
				}
				
				
				String __p = (String)request.getParameter("__p");
				String __q = (String)request.getParameter("__q");

				__p = __p==null ? "" : __p;
				__q = __q == null ? "" : __q;
				if(!"".equals(__p) && !"".equals(__q)){
					RSAKeyInstance key = RSAKeyInstance.getInstance();
					RSAKey rsaKey = key.getKey();
					RSA rsa = new RSA(rsaKey);
					String teaKey = rsa.decrypt(__q);
					TEA tea = new TEA(teaKey);
					__p = tea.decrypt(__p);
					
					log.debug("params = " + __p);
					
					SimpleQuery qry = new SimpleQuery();
					qry.setQuery(__p);
					jobID = qry.getQuery("jobID");
					
					ss = (RXSession)request.getSession().getAttribute(jobID+"_session");
					
					if(!jobID.equals(jobIDOrg)){
						throw new Exception("[전자문서 서명]서버에 생성 정보가 일치하지 않습니다.");
					}

				}else{
					throw new Exception("[전자문서 서명]요청 정보가 올바르지 않습니다.");
				}
								
				String issuerID = ss.getIssueID();
				
				String exptFileName = (String) request.getParameter("exptFileName");
				if (exptFileName == null || exptFileName.equals(""))
					exptFileName = (String) request.getSession().getAttribute("exptFileName");
				
				exptFileName = getDisposition(os, bw, StringUtils.nvl(exptFileName, "cert"),version);
				exptFileName += SystemUtils.getDateTime("_yyyyMMdd_hhmmss");
				exptFileName = exptFileName.replaceAll(" ", "");
				
				if (StringUtils.isEmpty(issuerID)) {
					log.error("세션에 발급과 관련된 발급 번호가 없습니다.");
					throw new Exception("[전자문서 서명]발급과 관련된 발급 번호가 없습니다.");
				}
	
				String userpwd = ss.getUserpwd();
				byte[] pdfBytes = ss.getPdfData();
	
				if (pdfBytes == null) {
					log.error("세션에 전자서명할 PDF 데이터가 없습니다.");
					throw new Exception("[전자문서 서명]전자서명할 PDF 데이터가 없습니다.");
				}
				
				//ss.setPdfData(null);
	
				String webinf = request.getRealPath("/WEB-INF/");
	
				/*
				 * 전자서명만 하는 경우
				 */
				response.setHeader("Set-Cookie", "cabsoftfileDownload=true; path=/");
				
				response.setContentType("application/pdf;charset=utf-8");
				/*
				 * 운영체제가 MS Windows이고 브라우저가 크롬인 경우
				 * 보안경고 메시지 때문에 브라우저에서 직접 열리도록 설정
				 */
				 if(ss.isPluginMode()==false){
					 response.addHeader("Content-Disposition", "attachment; filename=" + exptFileName + ".pdf;");
				 }

				// 서버 인증서 사용여부체크
				GlobalParams globalParams = GlobalParams.getInstance();

				if (globalParams == null) {
					globalParams = GlobalParams.getInstance(request.getRealPath("/WEB-INF/"));
				}
				
				String certUse = StringUtils.nvl(globalParams.getProperty("com.cabsoft.rx.cert.use"), "");
				if(!"".equals(certUse) && "true".equalsIgnoreCase(certUse)){
					ByteArrayOutputStream pdf = new ByteArrayOutputStream();
					pdf.write(pdfBytes);
					pdf.flush();
					pdf.close();
					
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					
					PdfPKCS7Info info = PdfSignService.signPdfSelf(baos, pdf, webinf, userpwd, ss.isExistRXCode());
					baos.flush();
					baos.close();
		
					out.write(baos.toByteArray());
				}else{
					out.write(pdfBytes);
				}
				
				out.flush();
				out.close();

				// 문서 다운로드 후에 메모리 지우기(다운로드  url이 2번 호출되는 경우는 메모리 값 지우면 안됨 예.safeguard,모바일브라우져(크롬))
				//ss.setPdfData(null);
				
				session.setAttribute(jobID+"_session", ss);
				
				log.debug("End");
	
				//			/*
				//			 * 타임스탬프를 적용하는 경우
				////			 */
				////			info = sign.signPdfWithTsaYessign(out, pdf, webinf, pwd);
				//			
				//			savePdfPKCS7Info(OriginalName, info);
				//
			}catch(Exception e){
				String se = StackTrace.getStackTrace(e);
				if(se.indexOf("SocketException")<0){
					log.error(StackTrace.getStackTrace(e));
					throw new Exception(e);
				}
			}
		}

		private String getDisposition(String os, String browser, String filename,float version ) {
			
			try{
				String encodedFilename = null;
				if (browser.equals("ie")) {
					
					if(version > 8.0){
						encodedFilename = URLEncoder.encode(filename, "UTF-8") .replaceAll("\\+", "%20");
					}else if(version <= 8.0){
						encodedFilename = URLEncoder.encode(filename, "UTF-8") .replaceAll("\\+", "");
					}
				
				} else if (browser.equals("firefox") || browser.equals("safari") || !"ms".equals(os)) {
					encodedFilename = new String(filename.getBytes("UTF-8"), "8859_1");
				} else {
					StringBuffer sb = new StringBuffer();
					for (int i = 0; i < filename.length(); i++) {
						char c = filename.charAt(i);
						if (c > '~') {
							sb.append(URLEncoder.encode("" + c, "UTF-8"));
						} else {
							sb.append(c);
						}
					}
					encodedFilename = sb.toString();
				}
				return encodedFilename;
			}catch(Exception e){
				return "";
			}
			
		}
		
		private void savePDF(String fs, byte[] data) throws Exception {
			String pdf_fs = fs + ".pdf";
			FileOutputStream fout = new FileOutputStream(new File(pdf_fs));
			fout.write(data);
			fout.flush();
			fout.close();

		}

		private void savePdfPKCS7Info(String fs, PdfPKCS7Info info) throws Exception {
			RXobjSaver.saveObject(info, fs + ".info");
		}
	}%>
