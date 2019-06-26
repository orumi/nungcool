package exam.com.report.service;

import exam.com.report.model.CopyReportVO;
import exam.com.report.model.CopyRequestVO;
import exam.com.report.model.MergeSaveVO;

import java.util.List;
import java.util.Map;

/**
 * Created by owner1120 on 2016-02-12.
 */

public interface ReportService {

    public List<?> selectReceiptInfo(Map map) throws Exception;

    public CopyRequestVO selectCopyRequest(Map map) throws Exception;

    public CopyReportVO selectCopyReport(Map map) throws Exception;

    public void insertCopyReport(CopyReportVO vo) throws Exception;

    public CopyReportVO getReportIdMaxVal( CopyReportVO vo ) throws Exception;

    public List<?> selectReportCopyList(Map map) throws Exception;

    public int selectReportCopyListCnt(Map map) throws Exception;

    public void deletCopyList(Map map) throws Exception;

    public CopyReportVO selectCopyReportWithReportId (Map map) throws Exception;

    public void updateCopyReport(CopyReportVO copyReportVO) throws Exception;

    public List<?> selectMergeList(Map map) throws Exception;

    public void insertMergeCopy(MergeSaveVO mergeSaveVO) throws Exception;

    public List<?> selectMergeSavedList(Map map) throws Exception;

    public void updateMergeCopy(MergeSaveVO mergeSaveVO) throws Exception;

    public int selectReceiptInfoCnt(Map map) throws Exception;

}
