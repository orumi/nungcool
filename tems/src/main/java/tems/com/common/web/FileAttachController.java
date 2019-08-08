package tems.com.common.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.apache.commons.lang.time.FastDateFormat;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovBasicLogger;
import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import tems.com.attachFile.model.AttachFileVO;
import tems.com.common.StringUtils;
import tems.com.common.model.CondComboVO;
import tems.com.common.model.FileAttachVO;
import tems.com.common.model.MethodComboVO;
import tems.com.common.model.SearchVO;
import tems.com.common.model.UnitComboVO;
import tems.com.common.service.ComboService;
import tems.com.common.service.FileAttachService;
import tems.com.exam.req.model.ItemListVO;
import tems.com.exam.req.model.ReqResultVO;
import tems.com.exam.req.service.ReqDetailService;

@Controller
public class FileAttachController {


	@Resource(name = "FileAttachService")
    private FileAttachService fileAttachService;

	/**
     *
     * @exception Exception
     */
	@RequestMapping("/common/fileattach.json")
    public void fileAttach(HttpServletRequest req, HttpServletResponse resp, FileAttachVO fileAttachVO) throws Exception {


		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
		MultipartFile file = (MultipartFile) multipartRequest.getFile("attach");

		String newFileName = System.currentTimeMillis() + UUID.randomUUID().toString() +file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		Date date = new Date();
		//SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM");
		FastDateFormat dateFormat = FastDateFormat.getInstance( "yyyyMM", Locale.getDefault());

		String osname = System.getProperty("os.name");
		String saveDir = dateFormat.format(date);

		//저장할 디렉토리	임시
		if(osname.equals("Windows 7")){
			saveDir = EgovProperties.getProperty("Globals.WinfilePath")+saveDir+"\\";
		} else {
			saveDir = EgovProperties.getProperty("Globals.LinuxfilePath")+saveDir+"/";
		}
		String filePath = saveDir + newFileName;

		File target = new File(saveDir, newFileName);
		target.mkdirs();
        file.transferTo(target);

        fileAttachVO.setFilepath(filePath);
        fileAttachVO.setFilesize(Long.toString(file.getSize()));
        fileAttachVO.setOrgname(new String(file.getOriginalFilename().getBytes("8859_1"),"UTF-8"));
        fileAttachVO.setSavename(newFileName);

        JSONObject nJson = new JSONObject();

        try{
        	fileAttachService.inSampleFile(fileAttachVO);
    		nJson.put("RESULT_YN"     ,"Y");
    		nJson.put("RESULT_MESSAGE","");
		}catch(Exception e){
			nJson.put("RESULT_YN"     ,"N");
			nJson.put("RESULT_MESSAGE",e.getMessage());
		}

        String jsonText = nJson.toString();
        PrintWriter out = resp.getWriter();
        out.print(jsonText);
        out.flush();
        out.close();
	}

    @RequestMapping(value="/common/getSampleFile.json")
    public @ResponseBody List<FileAttachVO>   getSampleFile(
    		HttpServletRequest req,
    		SearchVO searchVO) throws Exception {

    	List<FileAttachVO> FileAttachList = fileAttachService.getSampleFile(searchVO);

        return FileAttachList;
    }

    @RequestMapping(value="/common/getAdminSampleFile.json")
    public @ResponseBody List<FileAttachVO>   getAdminSampleFile(
    		HttpServletRequest req,
    		SearchVO searchVO) throws Exception {

    	List<FileAttachVO> FileAttachList = fileAttachService.getAdminSampleFile(searchVO);

        return FileAttachList;
    }

	@RequestMapping("/common/delSampleFile.json")
    public void delSampleFile(HttpServletRequest req, HttpServletResponse resp, FileAttachVO fileAttachVO) throws Exception {

		JSONObject nJson = new JSONObject();
        try{
        	fileAttachService.delSampleFile(fileAttachVO);

        	File target = new File(fileAttachVO.getFilepath());
    		target.delete();
    		nJson.put("RESULT_YN"     ,"Y");
    		nJson.put("RESULT_MESSAGE","");
		}catch(Exception e){
			nJson.put("RESULT_YN"     ,"N");
			nJson.put("RESULT_MESSAGE",e.getMessage());
		}

        String jsonText = nJson.toString();
        PrintWriter out = resp.getWriter();
        out.print(jsonText);
        out.flush();
        out.close();
	}


	/**
	 * 브라우저 구분 얻기.
	 *
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
			return "Trident";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}

	/**
	 * Disposition 지정하기.
	 *
	 * @param filename
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
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
		} else {
			throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}

	/**
	 * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/common/getFileDown.json")
	public void cvplFileDownload(HttpServletRequest req, HttpServletResponse response) throws Exception {

		String filenick = (String) req.getParameter("filenick");
		filenick = new String(filenick.getBytes("8859_1"),"UTF-8");
		String fileName = (String) req.getParameter("fileName");
		fileName = new String(fileName.getBytes("8859_1"),"UTF-8");

			File uFile = new File(filenick);
			int fSize = (int) uFile.length();

			if (fSize > 0) {
				String mimetype = "application/x-msdownload";

				//response.setBufferSize(fSize);	// OutOfMemeory 발생
				response.setContentType(mimetype);
				//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				setDisposition(fileName, req, response);
				response.setContentLength(fSize);

				/*
				 * FileCopyUtils.copy(in, response.getOutputStream());
				 * in.close();
				 * response.getOutputStream().flush();
				 * response.getOutputStream().close();
				 */
				BufferedInputStream in = null;
				BufferedOutputStream out = null;

				try {
					in = new BufferedInputStream(new FileInputStream(uFile));
					out = new BufferedOutputStream(response.getOutputStream());

					FileCopyUtils.copy(in, out);
					out.flush();
				} catch (IOException ex) {
					// 다음 Exception 무시 처리
					// Connection reset by peer: socket write error
					EgovBasicLogger.ignore("IO Exception", ex);
				} finally {
					EgovResourceCloseHelper.close(in, out);
				}

			} else {
				response.setContentType("application/x-msdownload");

				PrintWriter printwriter = response.getWriter();

				printwriter.println("<html>");
				printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fileName + "</h2>");
				printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
				printwriter.println("<br><br><br>&copy; webAccess");
				printwriter.println("</html>");

				printwriter.flush();
				printwriter.close();
			}
	}

}
