package exam.com.report.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import exam.com.report.model.CopyReportVO;
import exam.com.report.model.CopyRequestVO;
import exam.com.report.model.MergeSaveVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by owner1120 on 2016-02-12.
 */

@Repository("reportServiceDAO")
public class ReportServiceDAO extends EgovComAbstractDAO {

    public List<?> selectReceiptInfo(Map map) throws Exception {
        return list("reportServiceDAO.selectReceiptInfo", map);
    }

    public Integer selectReceiptInfoCnt(Map map) throws Exception {
        return (Integer) select("reportServiceDAO.selectReceiptInfoCnt", map);
    }

    public CopyRequestVO selectCopyRequest(Map map) throws Exception {
        return (CopyRequestVO) select("reportServiceDAO.selectCopyRequest",map);
    }

    public CopyReportVO selectCopyReport(Map map) throws Exception {
        return (CopyReportVO) select("reportServiceDAO.selectCopyReport", map);
    }

    public CopyReportVO insertCopyReport(CopyReportVO vo) throws Exception {
        insert("reportServiceDAO.insertCopyReport", vo);
        return vo;
    }

    public void insertCopyReport2(CopyReportVO vo) throws Exception {
        insert("reportServiceDAO.insertCopyReport2", vo);
    }

    public CopyReportVO getReportIdMaxVal (CopyReportVO vo) throws Exception {
        return (CopyReportVO) select("reportServiceDAO.getReportIdMaxVal",vo);
    }

    public List selectReportCopyList (Map map) throws Exception {
        return list("reportServiceDAO.selectReportCopyList", map);
    }

    public void deleteCopyList1(Map map) throws Exception {
        delete("reportServiceDAO.deleteCopyList1", map);
    }
    public void deleteCopyList2(Map map) throws Exception {
        delete("reportServiceDAO.deleteCopyList2", map);
    }

    public CopyReportVO selectCopyReportWithReportId(Map map) throws Exception{
        return (CopyReportVO) select("reportServiceDAO.selectCopyReportWithReportId", map);
    }

    public void updateCopyReport(CopyReportVO copyReportVO) throws Exception {
        update("reportServiceDAO.updateCopyReport", copyReportVO);
    }

    public List<?> selectMergeList (Map map) throws Exception {
        return list("reportServiceDAO.selectMergeList", map);
    }

    public void insertMergeCopyReport2 (MergeSaveVO vo) throws Exception {
       insert("reportServiceDAO.insertMergeCopyReport2", vo);
    }

    public List<?> selectMergeSavedList(Map map) throws Exception {
        return list("reportServiceDAO.selectMergeSavedList", map);
    }

    public Integer selectReportCopyListCnt(Map map) throws Exception {
        return (Integer) select("reportServiceDAO.selectReportCopyListCnt", map);
    }

}

