package exam.com.report.web;


import exam.com.common.PageMaker;
import exam.com.main.model.LoginUserVO;
import exam.com.report.model.CopyReportVO;
import exam.com.report.model.CopyRequestVO;
import exam.com.report.model.MergeSaveVO;
import exam.com.report.model.ReportCriteria;
import exam.com.report.service.ReportService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class ReportController {

    @Resource(name = "reportService")
    private ReportService reportService;

    private static final Logger LOGGER = LoggerFactory.getLogger(ReportController.class);

    /* egov-com-servlet.xml setting
     * servlet context */
    @RequestMapping("/report/testReport.do")
    public String pageReqList(HttpServletRequest req, HttpServletResponse resp, ReportCriteria cri) throws Exception {


        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
        String memid = loginUserVO.getMemid();
        Map map = new HashMap();


        map.put("memid", memid);
        map.put("startNum", cri.getFirst());
        map.put("endNum", cri.getEnd());
        map.put("keyword", ((cri.getKeyword() == null) ? "" : cri.getKeyword()));
        map.put("issueDate1", ((cri.getIssueDate1() == null) ? "" : cri.getIssueDate1()));
        map.put("issueDate2", ((cri.getIssueDate2() == null) ? "" : cri.getIssueDate2()));
        map.put("requestDate1", ((cri.getRequestDate1() == null) ? "" : cri.getRequestDate1()));
        map.put("requestDate2", ((cri.getRequestDate2() == null) ? "" : cri.getRequestDate2()));


        int totalCount = 1;

        List list = reportService.selectReceiptInfo(map);
        totalCount = reportService.selectReceiptInfoCnt(map);

        PageMaker pageMaker = new PageMaker(cri, totalCount);


        req.setAttribute("issueDate1", map.get("issueDate1"));
        req.setAttribute("issueDate2", map.get("issueDate2"));
        req.setAttribute("requestDate1", map.get("requestDate1"));
        req.setAttribute("requestDate2", map.get("requestDate2"));
        req.setAttribute("keyword", map.get("keyword"));
        req.setAttribute("list", list);
        req.setAttribute("pageMaker", pageMaker);
        req.setAttribute("crtPage", cri.getCrtPage());


 		/* tiles setting tiles.xml */
        return "exam/report/testReport";
    }

    /* go Page */
    @RequestMapping("/report/copyReportRequest.do")
    public String copyReportDetail(HttpServletRequest req, HttpServletResponse resp, @RequestParam("reqId") int reqId) throws Exception {

        Map map = new HashMap();

        map.put("reqId", reqId);

        CopyReportVO reportList = reportService.selectCopyReport(map);
        CopyRequestVO requestList = reportService.selectCopyRequest(map);

        req.setAttribute("reportList", reportList);
        req.setAttribute("requestList", requestList);

        return "exam/report/copyReportRequest";
    }

    @ResponseBody
    @RequestMapping("/report/copyReportRequestSave.json")
    public String copyReportDetailSave(HttpServletRequest req, HttpServletResponse resp, CopyReportVO copyReportVO) throws Exception {

        String message = "";

        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
        copyReportVO.setRegid(loginUserVO.getMemid());

        try {
            reportService.insertCopyReport(copyReportVO); // impl 안에 DAO 2개 있음
            message = "성공적으로 저장 되었습니다.";
        } catch (Exception e) {
            message = "저장에 실패 하였습니다 이유 :" + e;
        }

        return message;
    }

    @RequestMapping("/report/copyReport.do")
    public String pageState(HttpServletRequest req, HttpServletResponse resp, ReportCriteria cri) throws Exception {



        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
        String memid = loginUserVO.getMemid();
        Map map = new HashMap();

        map.put("memid", memid);
        map.put("startNum", cri.getFirst());
        map.put("endNum", cri.getEnd());
        map.put("keyword", ((cri.getKeyword() == null) ? "" : cri.getKeyword()));
        map.put("requestDate1", ((cri.getRequestDate1() == null) ? "" : cri.getRequestDate1()));
        map.put("requestDate2", ((cri.getRequestDate2() == null) ? "" : cri.getRequestDate2()));

        int totalCount = 1;

        List list = reportService.selectReportCopyList(map);
        totalCount = reportService.selectReportCopyListCnt(map);

        PageMaker pageMaker = new PageMaker(cri, totalCount);

        req.setAttribute("issueDate1", map.get("issueDate1"));
        req.setAttribute("issueDate2", map.get("issueDate2"));
        req.setAttribute("requestDate1", map.get("requestDate1"));
        req.setAttribute("requestDate2", map.get("requestDate2"));
        req.setAttribute("keyword", map.get("keyword"));
        req.setAttribute("list", list);
        req.setAttribute("pageMaker", pageMaker);
        req.setAttribute("crtPage", cri.getCrtPage());


        return "exam/report/copyReport";

    }

    @RequestMapping("/report/deleteCopyList.json")
    public void deleteCopyList(HttpServletRequest request, HttpServletResponse response,
                               @RequestParam("reqId") String reqId, @RequestParam("reportId") String reportId) throws Exception {

        Map map = new HashMap();

        map.put("reqId", reqId);
        map.put("reportId", reportId);

        reportService.deletCopyList(map);

    }

    @RequestMapping("/report/reviseCopyReport.do")
    public String reviseCopyList(HttpServletRequest request, HttpServletResponse response,
                                 @RequestParam("reqId") String reqId, @RequestParam("reportId") String reportId) throws Exception {


        Map map = new HashMap();

        map.put("reqId", reqId);
        map.put("reportId", reportId);

        CopyReportVO reportList = reportService.selectCopyReportWithReportId(map);
        CopyRequestVO requestList = reportService.selectCopyRequest(map);

        request.setAttribute("reportList", reportList);
        request.setAttribute("requestList", requestList);

        return "exam/report/copyReportRevise";
    }

    @RequestMapping("/report/reviseCopyListUpdate.do")
    public String reviseCopyListUpdate(HttpServletRequest request, HttpServletResponse response, CopyReportVO copyReportVO) throws Exception {

        reportService.updateCopyReport(copyReportVO);

        return "redirect:/report/copyReport.do?sub=report&menu=copyReport";
    }

    @RequestMapping("/report/mergeCopyRequest.do")
    public String mergeCopyRequest(HttpServletRequest req, HttpServletResponse resp, @RequestParam("reqId") int reqId) throws Exception {


        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
        String memId = loginUserVO.getMemid();

        Map map = new HashMap();

        map.put("reqId", reqId);
        map.put("memId", memId);

        /**
         *   일반 등본신청과 같은 정보 가져옴 From DB
         *   위에 뿌려주는 정보는 같으므로..
         **/
        CopyReportVO reportList = reportService.selectCopyReport(map);
        CopyRequestVO requestList = reportService.selectCopyRequest(map);


        /**
         *   지금 아래 걷어 오는건 추가적인 통합 할 정보,
         * */
        List mergeList = reportService.selectMergeList(map);

        /**
         *   위에는 이름만 list이고 실제론 VO 단일객체
         *   지금 아래 걷어 오는건 리스트 타입,
         * */

        req.setAttribute("mergeList", mergeList);
        req.setAttribute("reportList", reportList);
        req.setAttribute("requestList", requestList);

        return "exam/report/mergeCopyRequest";
    }

    @ResponseBody
    @RequestMapping("/report/mergeCopyRequestSave.json")
    public String mergeCopyRequestSave(HttpServletRequest req, HttpServletResponse resp, MergeSaveVO mergeSaveVO) throws Exception {

        String message = "";
        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
        mergeSaveVO.setRegid(loginUserVO.getMemid());
        /**
         *reportService.insertMergeCopy(mergeSaveVO); impl 안에 DAO 2개 있음
         * */
        try {
            reportService.insertMergeCopy(mergeSaveVO);
            message = "성공적으로 저장 되었습니다.";
        } catch (Exception e) {
            System.out.println(e);
            message = "통합등본을 신청 하시려면 최소 1개 이상의 통합본이 필요 합니다.";
        }
        return message;
    }

    @RequestMapping("/report/reviseMergeReport.do")
    public String reviseMergeReport(HttpServletRequest req, HttpServletResponse resp,
                                    @RequestParam("reqId") String reqId, @RequestParam("reportId") String reportId) throws Exception {


        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
        String memId = loginUserVO.getMemid();

        Map map = new HashMap();

        map.put("reqId", reqId);
        map.put("memId", memId);
        map.put("reportId", reportId);

        /**
         *   일반 등본신청과 같은 정보 가져옴 From DB
         *   위에 뿌려주는 정보는 같으므로..
         **/
        CopyReportVO reportList = reportService.selectCopyReportWithReportId(map);
        CopyRequestVO requestList = reportService.selectCopyRequest(map);

        /**
         *   지금 아래 걷어 오는건 추가적인 통합 할 정보,
         * */
        List mergeList = reportService.selectMergeList(map);

        /**
         *   위에는 이름만 list이고 실제론 VO 단일객체
         *   지금 아래 걷어 오는건 리스트 타입,
         * */

        List mergeSavedList = reportService.selectMergeSavedList(map);

        req.setAttribute("mergeList", mergeList);
        req.setAttribute("reportList", reportList);
        req.setAttribute("requestList", requestList);
        req.setAttribute("mergeSavedList", mergeSavedList);

        return "exam/report/mergeCopyRevise";
    }

    @ResponseBody
    @RequestMapping("/report/mergeCopyRequestUpdate.json")
    public String mergeCopyRequestUpdate(HttpServletRequest req, HttpServletResponse resp, MergeSaveVO mergeSaveVO) throws Exception {


        String message = "";

        LoginUserVO loginUserVO = (LoginUserVO) req.getSession().getAttribute("loginUserVO");
        mergeSaveVO.setRegid(loginUserVO.getMemid());

        /**
         *reportService.insertMergeCopy(mergeSaveVO); impl 안에 DAO 2개 있음
         **/

        try {
            reportService.updateMergeCopy(mergeSaveVO);
            message = "성공적으로 저장 되었습니다.";
        } catch (Exception e) {
            System.out.println(e);
            message = "통합등본을 신청 하시려면 최소 1개 이상의 통합본이 필요 합니다.";
        }
        return message;

    }

}


