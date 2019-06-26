<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@ page language="java" import="java.awt.image.BufferedImage"%>
<%@ page language="java" import="java.io.ByteArrayOutputStream"%>
<%@ page language="java" import="java.util.HashMap"%>
<%@ page language="java" import="javax.servlet.http.HttpServletRequest"%>
<%@ page language="java" import="javax.servlet.http.HttpServletResponse"%>
<%@ page language="java" import="javax.servlet.http.HttpSession"%>

<%@ page language="java" import="org.apache.commons.logging.Log"%>
<%@ page language="java" import="org.apache.commons.logging.LogFactory"%>
<%@ page language="java" import="com.cabsoft.GlobalParams"%>
<%@ page language="java" import="com.cabsoft.progress.SimpleExportProgressMonitor"%>
<%@ page language="java" import="com.cabsoft.rx.engine.RXException"%>
<%@ page language="java" import="com.cabsoft.rx.engine.RXExporterParameter"%>
<%@ page language="java" import="com.cabsoft.rx.engine.ReportExpressPrint"%>
<%@ page language="java" import="com.cabsoft.rx.engine.export.RXPdfExporter"%>
<%@ page language="java" import="com.cabsoft.rx.engine.export.RXPdfExporterParameter"%>
<%@ page language="java" import="com.cabsoft.rx.engine.util.RXSaver"%>
<%@ page language="java" import="com.cabsoft.smartcert.mobile.ApplySmartCode"%>
<%@ page language="java" import="com.cabsoft.text.pdf.PdfWriter"%>
<%@ page language="java" import="com.cabsoft.utils.Crypt"%>
<%@ page language="java" import="com.cabsoft.utils.StringUtils"%>
<%@ page language="java" import="com.cabsoft.utils.SystemUtils"%>
<%@ page language="java" import="com.cabsoft.utils.IssuerID"%>
<%@ page language="java" import="com.cabsoft.utils.Files"%>
<%@ page language="java" import="com.cabsoft.RXSession"%>
<%@ page language="java" import="com.cabsoft.utils.SimpleQuery"%>
<%@ page language="java" import="com.cabsoft.RXSession"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSAKey"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSAKeyInstance"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.RSA"%>
<%@ page language="java" import="com.cabsoft.jscrypt.cipher.TEA"%>

<%@ page language="java" import="java.util.List"%>
<%@ page language="java" import="com.cabsoft.RXHDBarCode"%>
<%@ page language="java" import="com.cabsoft.hdbarcode.MakeBarcodeData"%>
<%@ page language="java" import="com.cabsoft.hdbarcode.ApplyBarcode"%>
<%@ page language="java" import="com.cabsoft.utils.RXobjLoader"%>

<%@ page language="java" import="org.apache.commons.io.FileUtils"%>
<%@ page language="java" import="java.io.File"%>

<%@ page language="java" import="com.cabsoft.hdbarcode.CheckRXCode"%>

<%@ page language="java" import="com.cabsoft.smartcert.mobile.PdfPKCS7Info"%>
<%@ page language="java" import="com.cabsoft.sign.service.PdfSignService"%>

<%!@SuppressWarnings({ "deprecation", "unused" })
	public class PDFExportService {
		final Log log = LogFactory.getLog(PDFExportService.class);

		public PDFExportService() {
			
		}
		
		public String processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
			HttpSession session = request.getSession();
			String jobID = "";
			String ret = "";
			String pwd  = "";
			RXSession ss = null;
			String jobIDOrg = (String) session.getAttribute("jobID");
			
			try {
				String __p = (String)request.getParameter("__p");
				String __q = (String)request.getParameter("__q");

				if(null == jobIDOrg){
					throw new Exception("[전자문서 생성]서버에 생성 정보가 없습니다.");
				}
				
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
					pwd = qry.getQuery("p");
					
					ss = (RXSession)request.getSession().getAttribute(jobID+"_session");
					
					if(ss==null){
						throw new Exception("no_rxsession");
					}
					
					if(ss.getPdfData() != null && ss.getPdfData().length > 0){
						ret = "OK";
						return ret;
					}
					
					if(!jobID.equals(jobIDOrg)){
						throw new Exception("[전자문서 생성]서버에 생성 정보가 일치하지 않습니다.");
					}
					
					if(!StringUtils.isEmpty(pwd)){
						ss.setUserpwd(pwd);
					}
				}else{
					throw new Exception("[전자문서 생성]요청 정보가 올바르지 않습니다.");
				}
				
				String rxprintData = ss.getRxprintData();

				ReportExpressPrint rxPrint = (ReportExpressPrint) RXobjLoader.loadObjectFromCompressed(rxprintData);

				if (rxPrint != null) {

					GlobalParams globalParams = GlobalParams.getInstance();

					if (globalParams == null) {
						globalParams = GlobalParams.getInstance(request.getRealPath("/WEB-INF/"));
					}

					if(ss.isExistRXCode()){
						MakeBarcodeData makebarcodedata = new MakeBarcodeData(rxPrint);
						String data = makebarcodedata.getBarcodeData();
						RXHDBarCode barcode = new RXHDBarCode();
						List<String> barcodelist = barcode.makeFile(data, 0, 0, rxPrint.getPages().size(), globalParams.getBarcodePath());
						ApplyBarcode.applyBarcodeFromFile(rxPrint, globalParams.getBarcodePath(), barcodelist);
						
// 						List<BufferedImage> barcodelist = barcode.makeBuffer(data, 0, 0, rxPrint.getPages().size());
// 						ApplyBarcode.applyBarcode(rxPrint, barcodelist);
					}
					
					String OriginalName = (String)session.getAttribute("OriginalName");


					/*******************************************************************************************************
					 * 
					 * PDF 문서에 적용될 스마트 코드 및 발급 번호에 대한 설정
					 * 
					 *******************************************************************************************************/

					/*
					 * 스마트 코드에 원본 대조를 위한 URL 설정. WAS 환경에 따라 수정이 요구됨
					 */
					String ProbeServer = request.getScheme() + "://" + request.getServerName() + ":" + String.valueOf(request.getServerPort()) + request.getContextPath() 
					 					+ "/cdoc/eform/" + "mobile_probe.jsp";

					/*
					 * PDF 문서에 표시된 발급 번호 삭제 및 생성
					 */
					String issuerID = ss.getIssueID();

					// 신규발급
					IssuerID id = new IssuerID();
					issuerID = id.getIssuerID();
					ss.setIssueID(issuerID);
					String serialString = id.getIssuerIDString(issuerID);
//					String serialString = "발급 번호: " + id.getIssuerIDString(issuerID);

					/*
					 * PDF 문서에 삽입될 스마트 코드 생성
					 */
					String code = ProbeServer + "?s=" + issuerID;
					
					log.info(code);
					
					BufferedImage smartcode = com.cabsoft.smartcodem.build.Make.getCode(code, 600);

					/*
					 * 발급번호 문자열과 스마트 코드를 해시맵에 설정한다.
					 */
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("SmartCode", smartcode);
					map.put("IssuerID", serialString);

					/*
					 * 발급번호와 스마트 코드를 rxprint 클래스에 적용한다.
					 */
					ApplySmartCode apply = new ApplySmartCode(rxPrint);
					ReportExpressPrint smartcodeRxPrint = apply.getReportExpressPrint(map);

					byte[] pdfBytes = Pdf(jobID, smartcodeRxPrint, globalParams);

					ss.setPdfData(pdfBytes);
					session.setAttribute(jobID+"_session", ss);
					ret = "OK";

					//saveRxPrint(globalParams.getCabsoftPath() + "original/" + issuerID, rxPrint);
					
				} else {
					ret = "세션에 저장된 보고서가 없습니다.";
					log.error("세션에 저장된 보고서가 없습니다.");
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
				ret = e.getMessage();
			}
			return ret;
		}

		private byte[] Pdf(String jobID, ReportExpressPrint rxPrint, GlobalParams globalParams) throws Exception {
			try {
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				RXPdfExporter exporter = new RXPdfExporter();

				// PDF 보안 설정
				exporter.setParameter(RXPdfExporterParameter.PERMISSIONS, new Integer(PdfWriter.ALLOW_PRINTING));

				// PDF 메타데이터 설정
				exporter.setParameter(RXPdfExporterParameter.METADATA_TITLE, rxPrint.getName() + " generated by ReportExpress");
				exporter.setParameter(RXPdfExporterParameter.METADATA_AUTHOR, globalParams.getProperty("com.cabsoft.rx.pdf.author"));
				exporter.setParameter(RXPdfExporterParameter.METADATA_SUBJECT, globalParams.getProperty("com.cabsoft.rx.pdf.subject"));
				exporter.setParameter(RXPdfExporterParameter.METADATA_KEYWORDS, globalParams.getProperty("com.cabsoft.rx.pdf.keywords"));
				exporter.setParameter(RXPdfExporterParameter.METADATA_CREATOR, globalParams.getProperty("com.cabsoft.rx.pdf.creator"));

				exporter.setParameter(RXExporterParameter.REPORTEXPRESS_PRINT, rxPrint);
				exporter.setParameter(RXExporterParameter.OUTPUT_STREAM, out);
				// exporter.setParameter(RXExporterParameter.PROGRESS_MONITOR, new
				// SimpleExportProgressMonitor(jobID, rxPrint.getName(), "PDF"));
				exporter.exportReport();
				return out.toByteArray();
			} catch (RXException e) {
				log.error(e);
				throw new Exception(e);
			}
		}

		private void saveRxPrint(String fs, ReportExpressPrint rxprint) throws RXException {
			RXSaver.saveObject(rxprint, fs + ".rxprint");
		}
	}%>
