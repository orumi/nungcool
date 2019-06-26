package cdoc.com.cabsoft.smartcert.service.impl;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.StringReader;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import cdoc.com.cabsoft.smartcert.service.HeaderBeans;
import cdoc.com.cabsoft.smartcert.service.SmartcertService;

import com.cabsoft.GlobalParams;
import com.cabsoft.RXHDBarCode;
import com.cabsoft.RXSession;
import com.cabsoft.datasource.RXJsonDataSource;
import com.cabsoft.fill.FillFactory;
import com.cabsoft.fill.RXFillListner;
import com.cabsoft.hdbarcode.ApplyBarcode;
import com.cabsoft.hdbarcode.CheckRXCode;
import com.cabsoft.hdbarcode.MakeBarcodeData;
import com.cabsoft.html.ExportHtml;
import com.cabsoft.pdfutils.Watermark;
import com.cabsoft.rx.engine.RXException;
import com.cabsoft.rx.engine.RXExporterParameter;
import com.cabsoft.rx.engine.RXParameter;
import com.cabsoft.rx.engine.ReportExpress;
import com.cabsoft.rx.engine.ReportExpressPrint;
import com.cabsoft.rx.engine.export.RXPdfExporter;
import com.cabsoft.rx.engine.export.RXPdfExporterParameter;
import com.cabsoft.rx.engine.query.RXXPathQueryExecuterFactory;
import com.cabsoft.rx.engine.util.RXLoader;
import com.cabsoft.sign.service.PdfSignService;
import com.cabsoft.smartcert.mobile.ApplySmartCode;
import com.cabsoft.smartcert.mobile.PdfPKCS7Info;
import com.cabsoft.text.pdf.PdfReader;
import com.cabsoft.text.pdf.PdfWriter;
import com.cabsoft.utils.CharsetDetector;
import com.cabsoft.utils.Files;
import com.cabsoft.utils.IOUtils;
import com.cabsoft.utils.IssuerID;
import com.cabsoft.utils.RXDomDocument;
import com.cabsoft.utils.RXobjLoader;
import com.cabsoft.utils.StackTrace;
import com.cabsoft.utils.StringUtils;
import com.cabsoft.utils.SystemUtils;
import com.cabsoft.utils.objSerializer;
import com.cabsoft.utils.sysinfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import exam.com.common.service.XMLService;

@Service("SmartcertService")
public class SmartcertServiceImpl extends EgovAbstractServiceImpl implements SmartcertService{
	
    private static final Logger LOGGER = LoggerFactory.getLogger(SmartcertServiceImpl.class);
    
	private GlobalParams globalParams = null;
	private final String PDF = ".pdf";
	private final String REPORT = ".report";
	
    @Resource(name = "xmlService")
    private XMLService xmlService;
	
	@Override
	public void processRequest(HttpServletRequest request, HttpServletResponse response, boolean useOverlap) throws Exception {
		
		boolean existRXCode = false;
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();

		String jobID = (String) session.getAttribute("jobID");
		RXSession ss = (RXSession)session.getAttribute(jobID+"_session");
		
		String rptTitle = (String) StringUtils.nvl(request.getParameter("rptTitle"), "");
		String filepath = (String) request.getParameter("ReportPath");
		
		try {
			globalParams = GlobalParams.getInstance();

			if (globalParams == null) {
				globalParams = GlobalParams.getInstance(request.getRealPath("/WEB-INF/"));
			}
			
//			ExportPDFServiceImpl exportService = new ExportPDFServiceImpl();
			
			ReportExpressPrint rxPrint = FillReport(jobID, request, ss);
			
			String rxprintData = objSerializer.ObjectToCompress(rxPrint);
			ss.setRxprintData(rxprintData);
			session.setAttribute(jobID+"_session", ss);		
			
			// 외부 리포트 명이 없는 경우 서식의 Report Name 적용
			if (StringUtils.isEmpty(rptTitle)) {
				rptTitle = rxPrint.getName();
			}
			
			// HTML 뷰어 출력 전 서버에 PDF를 다운로드 받는다.
			// fill 작업한 rxprint 있음
			String pdfExportResult = export(request, response);
			if("OK".equals(pdfExportResult)){
				ss = (RXSession)session.getAttribute(jobID+"_session");
				
				String ua = request.getHeader("User-Agent");
				String os = sysinfo.os(ua);

				String eformpath = (String) request.getContextPath() + globalParams.getContextpath();
				String basehref = (String) request.getContextPath() + globalParams.getContextpath() + "smartcertviewer/";
				String exptFileName = (String) StringUtils.nvl(request.getParameter("exptFileName"), rptTitle);
				String header = "";
				String webimgurl = (String) globalParams.getProperty("com.cabsoft.rx.webimgurl");
				HeaderBeans headerBeans = new HeaderBeans();

				headerBeans.setUseAbsolutePosition(true);
				headerBeans.setDevel(true);
				headerBeans.setToolBarType(ss.getToolbarType());
				headerBeans.setJobID(jobID);
				headerBeans.setSession(request.getSession());
				
				header = headerBeans.MenuStart("smartCertViewer", basehref, rptTitle, "UTF-8", jobID, exptFileName, "rxe.js");
				session.setAttribute("exptFileName", exptFileName);
				
				if((RXSession.TOOLBAR_DEFAULT).equalsIgnoreCase(headerBeans.getToolBarType())){
					if(ss.isReqpasswd()){
						header += headerBeans.addCertMenu("issue", basehref, "전자문서발급", "save_signedpdfpwd", "signedpdf.gif");
					}else{
						header += headerBeans.addCertMenu("issue", basehref, "전자문서발급", "save_signedpdf", "signedpdf.gif");
					}
					header += headerBeans.MenuEnd(basehref);
				}else{
					if(ss.isReqpasswd()){
						header = StringUtils.replaceAll(header, "save_signedpdf", "save_signedpdfpwd");
					}
				}
				
				header += headerBeans.addCertKey(eformpath);
				header += headerBeans.downloadForm(jobID, exptFileName, "");
				
				header += "<div id='issue'></div>";
	
				/*
				 * 온라인 원본 대조인 경우 아래 메뉴 추가를 제거한다.
				 */
				HashMap<String, Object> hmap = new HashMap<String, Object>();
				hmap.put("image_uri", request.getContextPath() + globalParams.getContextpath() + "imgservice.jsp?jobID=" + jobID + "&image=");
				if (StringUtils.isEmpty(webimgurl)) {
					hmap.put("webimgurl", null);
				} else {
					hmap.put("webimgurl", request.getContextPath() + webimgurl);
				}
				
				hmap.put("header", header);
				hmap.put("previewOnly", true);

				if (!StringUtils.isEmpty(filepath)) {
					filepath = StringUtils.nvl(filepath, "");
				} else {
					filepath = StringUtils.nvl(request.getRealPath(globalParams.getContextpath() + "/reports/"), "");
				}
				
				/*
				 * Smart Cert 뷰어 실행
				 */
				existRXCode = ExportHtml.Html(jobID, request, response, rxPrint, hmap, useOverlap);
				ss.setExistRXCode(existRXCode);
				session.setAttribute(jobID+"_session", ss);		
			}else{
				// TODO 서버에 PDF 다운로드 실패. 에러 던져야함
				LOGGER.error("PDF 다운로드 실패");
			}
					
		} catch (Exception e) {
			String se = StackTrace.getStackTrace(e);
			if (se.indexOf("java.net.SocketException") > -1) {

			} else {
				LOGGER.error(StackTrace.getStackTrace(e));
				throw new Exception(e.getMessage());
			}
		}
	}
	
	@Override
	public String exportTempPdf(HttpServletRequest request, HttpServletResponse response) throws Exception{

		String ret = "FAIL";
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		String filename = StringUtils.nvl(request.getParameter("ReportFile"), "");
		String certpasswd = StringUtils.nvl(request.getParameter("rptpasswd"), "");
		String requesrpasswd = StringUtils.nvl(request.getParameter("reqpasswd"), "");
		String toolbarType = StringUtils.nvl(request.getParameter("toolbarType"), "ios");
		String plugin = StringUtils.nvl(request.getParameter("plugin"), "");
		
		String jobID = SystemUtils.GenerateID();
		RXSession ss = new RXSession();
		
		ss.setJobID(jobID);
		ss.setRxprintData("");
		ss.setIssueID("");
		ss.setRptFile(filename);
		ss.setXmlData("");
		ss.setPdfData(null);
		ss.setToolbarType(toolbarType);
		ss.setPluginMode((plugin==null ? false : ("1".equals(plugin) ? true : false)));
		
		if (requesrpasswd != null && "1".equals(requesrpasswd)) {
			certpasswd = "";
			// 사용자 암호 입력이 요구됨(미리보기 후에 결정)
			ss.setUserpwd("");
			ss.setReqpasswd(true);
		} else {
			//암호 자동입력(미리보기전에 결정)
			ss.setUserpwd(certpasswd);
			ss.setReqpasswd(false);
		}
		ss.setPageView(null);
		ss.setJson(null);

		session.setAttribute("jobID", jobID);
		session.setAttribute(jobID + "_session", ss);

		try {
			globalParams = GlobalParams.getInstance();

			if (globalParams == null) {
				globalParams = GlobalParams.getInstance(request.getRealPath("/WEB-INF/"));
			}
			ReportExpressPrint rxPrint = FillReport(jobID, request, ss);
			
			byte[] pdfBytes = Pdf(jobID, rxPrint, globalParams);
			
			// 서버에 PDF 저장
			String pdfExportPath = globalParams.getProperty("com.cabsoft.rx.pdf.exportpath.temp");
			FileUtils.writeByteArrayToFile(new File(pdfExportPath + URLDecoder.decode((String) request.getParameter("rptTitle"), "UTF-8") + PDF), pdfBytes);
			ret = "OK";
			
		}catch(Exception e){
			LOGGER.error(StackTrace.getStackTrace(e));
		}
		return ret;
	}
	
	/**
	 * 보고서를 채움 보고서를 채우기 전에 바코드가 저장될 위치와 파일의 접두사를 정의하기 위해 InitBarcode() 함수 호출
	 * 
	 * @return ReportExpressPrint
	 * @throws Exception
	 */
	public ReportExpressPrint FillReport(String jobID, HttpServletRequest request, RXSession ss) throws Exception {
		
		HttpSession session = request.getSession();
		ServletContext context = request.getSession().getServletContext();
		
		String filename = ss.getRptFile();
		String xmlType = (String) request.getParameter("xmlType");
		String ReportXmlString = "";
		
		FillFactory fill = new FillFactory();
		
		/*
		 * Fill Listner 설정
		 */
		RXFillListner filllistner = new RXFillListner();
		
		try {
			globalParams = GlobalParams.getInstance();

			if (globalParams == null) {
				globalParams = GlobalParams.getInstance(request.getRealPath("/WEB-INF/"));
			}
			
			String fs = StringUtils.nvl(context.getRealPath(globalParams.getContextpath() + "/reports/" + filename + REPORT), "");
			fs = SystemUtils.replaceSystemPathString(fs);
			File reportFile = new File(fs);
			
			LOGGER.debug("fs : " + fs);
			
			if (!reportFile.exists()) {
				LOGGER.error("컴파일된 보고서 파일 " + fs + "을(를) 찾을 수 없습니다. 먼저 보고서 서식을 컴파일하기시 바랍니다.");
				throw new Exception("layoutfile$" + IOUtils.getFileName(fs));
//					throw new Exception("컴파일된 보고서 파일 " + fs + "을(를) 찾을 수 없습니다. 먼저 보고서 서식을 컴파일하기시 바랍니다.");
			}

			ReportExpress report = (ReportExpress)RXLoader.loadObject(fs);
			
//			String subreport_dir = fs.substring(0, fs.lastIndexOf(SystemUtils.FILE_SEPARATOR))+ SystemUtils.FILE_SEPARATOR;
			Document document = null;
			RXJsonDataSource datasource = null;
			Map<String, Object> params = new HashMap<String, Object>();
			
			// TODO 테스트용 파라미터. 운영 반영 전 삭제 필요 start
			// TODO 반영시에는 dbUse가 Y인 구간을 진행해야 한다.
			String dbUse = (String) request.getParameter("dbUse");
			if("Y".equals(dbUse)){
				// DB 에서 XML 데이터 가져오기
		 		HashMap<String, String> pmMap = new HashMap<String, String>();
		 		pmMap.put("reqid", "20489");
		 		pmMap.put("reportid", "1");
		 		
		 		String strXML = xmlService.selectXML(pmMap);
		 		ReportXmlString = strXML;
			}else{
				ReportXmlString = URLDecoder.decode((String) request.getParameter("xmlData"));
			}
			// TODO 테스트용 파라미터. 운영 반영 전 삭제 필요 end
	 		
	 		LOGGER.debug("dbUse : " + dbUse + " / ReportXmlString : " + ReportXmlString);
	 		
			if ("xmlstring".equals(xmlType)) {
				LOGGER.debug("ReportXmlString : " + ReportXmlString);
				document = RXDomDocument.parse(ReportXmlString);
			} else {
				String xmlfilepath = globalParams.getCabsoftPath() + "xml/" + filename + ".xml";
				String xmlfile = (String) request.getParameter("xmlfile");
				if (xmlfile != null && !"".equals(xmlfile) && xmlfile.indexOf(".xml") > 0) {
					xmlfilepath = globalParams.getCabsoftPath() + "xml/" + xmlfile;
				}
				File f = new File(xmlfilepath);
				if(f.exists()){
					byte[] bxml = Files.readFile(f);
					ReportXmlString = new String(bxml, CharsetDetector.detector(bxml));
					InputSource is = new InputSource(new StringReader(ReportXmlString));
					document = (Document) DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
					ss.setXmlData(ReportXmlString);
				}
			}
			
			if(document!=null){
				params.put(RXXPathQueryExecuterFactory.PARAMETER_XML_DATA_DOCUMENT, document);
				params.put(RXXPathQueryExecuterFactory.XML_DATE_PATTERN, "yyyy-MM-dd");
				params.put(RXXPathQueryExecuterFactory.XML_NUMBER_PATTERN, "#,##0.##");
				params.put(RXXPathQueryExecuterFactory.XML_LOCALE, Locale.KOREAN);
			}
			
			params.put(RXParameter.REPORT_LOCALE, Locale.US);
			params.put("SUBREPORT_DIR", request.getRealPath(globalParams.getContextpath() + "/reports/") + SystemUtils.FILE_SEPARATOR);
			
			params.put("imgDir", context.getRealPath(globalParams.getImagepath()) + SystemUtils.FILE_SEPARATOR);
			
			/*
			 * Fill Listner 설정
			 */
			filllistner.setSourceFile(filename);
			filllistner.setXml(ReportXmlString);
			filllistner.setEnableInterrupt(
					globalParams.getBooleanProperty("com.cabsoft.rx.interrupt", false)
			);
			filllistner.setMaxPages(
					globalParams.getIntegerProperty("com.cabsoft.rx.maxpages", 0)
			);
			filllistner.setTimeOut(
					globalParams.getIntegerProperty("com.cabsoft.rx.timeout", 0)
			);
			params.put("FillListener", filllistner);
			
			if(document!=null){
				return fill.fillReport(report, params);	
			}else{
				return fill.fillReport(report, params, new com.cabsoft.rx.engine.RXEmptyDataSource());
			}
			
		} catch (RXException e) {
			LOGGER.error(StackTrace.getStackTrace(e));
			throw new Exception("fill");
		}finally{
			filllistner.FillFinished();
		}
	}

	@Override
	public String export(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String jobID = (String) session.getAttribute("jobID");
		RXSession ss = (RXSession)request.getSession().getAttribute(jobID+"_session");
		
		String ret = "FAIL";
		String rxprintData = ss.getRxprintData();
		
		ByteArrayOutputStream baos = null;
		ByteArrayOutputStream pdf = null;

		try{
			ReportExpressPrint rxPrint = (ReportExpressPrint) RXobjLoader.loadObjectFromCompressed(rxprintData);

			if (rxPrint != null) {

				GlobalParams globalParams = GlobalParams.getInstance();

				if (globalParams == null) {
					globalParams = GlobalParams.getInstance(request.getRealPath("/WEB-INF/"));
				}

				boolean isrxcode = CheckRXCode.existRXCode(rxPrint);	// 고밀도 바코드 사용 여부
				if(isrxcode){
					MakeBarcodeData makebarcodedata = new MakeBarcodeData(rxPrint);
					String data = makebarcodedata.getBarcodeData();
					RXHDBarCode barcode = new RXHDBarCode();
					List<String> barcodelist = barcode.makeFile(data, 0, 0, rxPrint.getPages().size(), globalParams.getBarcodePath());
					ApplyBarcode.applyBarcodeFromFile(rxPrint, globalParams.getBarcodePath(), barcodelist);
					
//						List<BufferedImage> barcodelist = barcode.makeBuffer(data, 0, 0, rxPrint.getPages().size());
//						ApplyBarcode.applyBarcode(rxPrint, barcodelist);
				}
				
//				String OriginalName = (String)session.getAttribute("OriginalName");

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
//				String serialString = "발급 번호: " + id.getIssuerIDString(issuerID);

				/*
				 * PDF 문서에 삽입될 스마트 코드 생성
				 */
				String code = ProbeServer + "?s=" + issuerID;
				
				LOGGER.info(code);
				
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
				
				// 서버 PDF 저장 경로
				String pdfExportPath = globalParams.getProperty("com.cabsoft.rx.pdf.exportpath");

				// 서버 인증서 사용여부체크
				String certUse = StringUtils.nvl(globalParams.getProperty("com.cabsoft.rx.cert.use"), "");
				if(!"".equals(certUse) && "true".equalsIgnoreCase(certUse)){
					// 서버 인증서를 사용한다면
					baos = new ByteArrayOutputStream();
					String webinf = request.getRealPath("/WEB-INF/");
					String userpwd = ss.getUserpwd(); 

					pdf = new ByteArrayOutputStream();
					pdf.write(pdfBytes);
					pdf.flush();
					pdf.close(); 

					PdfPKCS7Info info = PdfSignService.signPdfSelf(baos, pdf, webinf, userpwd, isrxcode);
					baos.flush();
					baos.close(); 
					
					FileUtils.writeByteArrayToFile(new File(pdfExportPath + id.getIssuerIDString(issuerID) + PDF), baos.toByteArray());
				}else{
					FileUtils.writeByteArrayToFile(new File(pdfExportPath + id.getIssuerIDString(issuerID) + PDF), pdfBytes);
				}
				ss.setPdfData(pdfBytes);
				session.setAttribute(jobID+"_session", ss);		
				ret = "OK";
			} else {
				LOGGER.error("세션에 저장된 보고서가 없습니다.");
			}
		}catch(Exception e){
			LOGGER.error(StackTrace.getStackTrace(e));
		}finally{
			if(baos != null){
				baos.close();
			}
			if(pdf != null){
				pdf.close();
			}
		}
		return ret;
	}
	
	/**
	 * PDF 생성
	 * @param jobID
	 * @param rxPrint
	 * @param globalParams
	 * @return
	 * @throws Exception
	 */
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
//			exporter.setParameter(RXExporterParameter.OUTPUT_STREAM, out);
			// exporter.setParameter(RXExporterParameter.PROGRESS_MONITOR, new
			// SimpleExportProgressMonitor(jobID, rxPrint.getName(), "PDF"));
			
			// 워터마크 삽입
			boolean isInsertWaterMark = globalParams.getBooleanProperty("com.cabsoft.rx.smartcert.insertwatermark", false);

			if (isInsertWaterMark) {

				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				exporter.setParameter(RXExporterParameter.OUTPUT_STREAM, bos);
				exporter.exportReport();
				bos.flush();
				bos.close();

				ByteArrayInputStream is = new ByteArrayInputStream(bos.toByteArray());
				PdfReader reader = new PdfReader(is, "cabsoft".getBytes());

				float transparancy = globalParams.getFloatProperty("com.cabsoft.watermark.transparancy", -1.0f);
				Watermark.InsertWatermark(out, reader,
						globalParams.getCabsoftPath() + globalParams.getProperty("com.cabsoft.rx.smartcert.watermark"),
						transparancy);
				is.close();

			} else {
				exporter.setParameter(RXExporterParameter.OUTPUT_STREAM, out);
			}

			exporter.exportReport();
			return out.toByteArray();
		} catch (RXException e) {
			LOGGER.error(StackTrace.getStackTrace(e));
			throw new Exception(e);
		}
	}
	
}                                                                                                                                               
