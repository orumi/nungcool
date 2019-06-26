package cdoc.com.cabsoft.smartcert.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SmartcertService {
	
	/**
	 * HTML 뷰어 출력
	 * @param request
	 * @param response
	 * @param useOverlap
	 * @throws Exception
	 */
	public void processRequest(HttpServletRequest request, HttpServletResponse response, boolean useOverlap) throws Exception;
	
	/**
	 * HTML 뷰어 출력 전 서버에 PDF 생성 (고밀도바코드, 문서확인번호 포함)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public String export(HttpServletRequest request, HttpServletResponse response) throws Exception;

	/**
	 * 직원 결재 프로세스에 사용되는 PDF 생성 (고밀도바코드, 문서확인번호 미포함)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public String exportTempPdf(HttpServletRequest request, HttpServletResponse response) throws Exception;

}
