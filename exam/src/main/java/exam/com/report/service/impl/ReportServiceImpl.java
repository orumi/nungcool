package exam.com.report.service.impl;

import exam.com.report.model.CopyReportVO;
import exam.com.report.model.CopyRequestVO;
import exam.com.report.model.MergeSaveVO;
import exam.com.report.service.ReportService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by owner1120 on 2016-02-12.
 */

@Service("reportService")
public class ReportServiceImpl implements ReportService {

    @Resource(name = "reportServiceDAO")
    private ReportServiceDAO reportServiceDAO;

    @Override
    public List<?> selectReceiptInfo(Map map) throws Exception {
        return reportServiceDAO.selectReceiptInfo(map);
    }

    @Override
    public CopyRequestVO selectCopyRequest(Map map) throws Exception {
        return reportServiceDAO.selectCopyRequest(map);
    }

    @Override
    public CopyReportVO selectCopyReport(Map map) throws Exception {
        return reportServiceDAO.selectCopyReport(map);
    }

    @Override
    public void insertCopyReport(CopyReportVO vo) throws Exception {
        /**
         *   위에줄 아랫줄 각각, TNE_REPORT, TNE_REPORT_SAMPLE 에 자기 자신을 집어 넣는다.
         * */
        CopyReportVO vo2 = reportServiceDAO.insertCopyReport(vo);
        reportServiceDAO.insertCopyReport2(vo2);
    }

    @Override
    public CopyReportVO getReportIdMaxVal(CopyReportVO vo) throws Exception {
        return reportServiceDAO.getReportIdMaxVal(vo);
    }

    @Override
    public List<?> selectReportCopyList(Map map) throws Exception {
        return reportServiceDAO.selectReportCopyList(map);
    }

    @Override
    public int selectReportCopyListCnt(Map map) throws Exception {
        int cnt = reportServiceDAO.selectReportCopyListCnt(map);
        return cnt;
    }

    @Override
    public void deletCopyList(Map map) throws Exception {
        reportServiceDAO.deleteCopyList1(map);
        reportServiceDAO.deleteCopyList2(map);
    }

    @Override
    public CopyReportVO selectCopyReportWithReportId(Map map) throws Exception {
        return reportServiceDAO.selectCopyReportWithReportId(map);
    }

    @Override
    public void updateCopyReport(CopyReportVO copyReportVO) throws Exception {
        reportServiceDAO.updateCopyReport(copyReportVO);
    }

    @Override
    public List<?> selectMergeList(Map map) throws Exception {
        return reportServiceDAO.selectMergeList(map);
    }

    @Override
    public void insertMergeCopy(MergeSaveVO vo) throws Exception {

        /**
         *   1.위에줄 아랫줄 각각, TNE_REPORT, TNE_REPORT_SAMPLE 에 자기 자신을 집어 넣는다.
         *   2.insert에서 vo2가 반환되는 이유는 reportId 의 맥스값을 찾아서 1증가시킨 값을 넣고
         *   그 값을 그대로 vo2에 넣어서 반환하면 그것을 이용하여 TNE_REPORT_SAMPLE에 넣는다.
         *   3.- 데이터 꼬임 방지용 -
         * */
        CopyReportVO vo2 = reportServiceDAO.insertCopyReport(vo);
        reportServiceDAO.insertCopyReport2(vo2);

        /**
         *   통합이므로 통합되려는 데이터는 별도로 TNE_REPORT_SAMPLE에 담겨줘야 한다.
         *   아래, mergereqid 다수로 올 수 있고, 각각의 mergereqid는 위에서 반환받은 vo2의 reportid와 매치되어 들어가야 한다.
         * */
        String arr[] = vo.getMergereqid().split(",");

        for (String anArr : arr) {
            vo.setMergereqid(anArr);
            reportServiceDAO.insertMergeCopyReport2(vo);
        }

    }

    @Override
    public List<?> selectMergeSavedList(Map map) throws Exception {
        return reportServiceDAO.selectMergeSavedList(map);
    }

    @Override
    public void updateMergeCopy(MergeSaveVO mergeSaveVO) throws Exception {

        Map map = new HashMap();
        map.put("reqId", mergeSaveVO.getReqid());
        map.put("reportId", mergeSaveVO.getReportid());

        reportServiceDAO.deleteCopyList2(map); // tne_report_sample 관련 전체 삭제//


        CopyReportVO copyReportVO = mergeSaveVO;
        reportServiceDAO.updateCopyReport(copyReportVO); // tne_report 수정

        // tne_report_sample 다시 주입
        String arr[] = mergeSaveVO.getMergereqid().split(",");

        for (String anArr : arr) {
            mergeSaveVO.setMergereqid(anArr);
            reportServiceDAO.insertMergeCopyReport2(mergeSaveVO);
        }
    }

    @Override
    public int selectReceiptInfoCnt(Map map) throws Exception {
        int cnt = reportServiceDAO.selectReceiptInfoCnt(map);
        return cnt;

    }


}