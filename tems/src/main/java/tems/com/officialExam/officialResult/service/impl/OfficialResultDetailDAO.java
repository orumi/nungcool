package tems.com.officialExam.officialResult.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.common.model.SearchVO;
import tems.com.officialExam.officialResult.model.*;

import java.util.List;

@Repository("officialResultDetailDAO")
public class OfficialResultDetailDAO extends EgovComAbstractDAO {

    public ResultDetailVO getResultDetail(SearchVO searchVO) {
        return (ResultDetailVO) select("officialResultDetailDAO.getResultDetail", searchVO);
    }

    public List<?> getResultSmpList(SearchVO searchVO) {
        return list("officialResultDetailDAO.getResultSmpList", searchVO);
    }

    public List<?> getResultList(SearchVO searchVO) {
        return list("officialResultDetailDAO.getResultList", searchVO);
    }

    public void upResultDetail(ResultlVO resultlVO) {
        update("officialResultDetailDAO.upResultDetail", resultlVO);
    }

    public List<?> getCalculation(SearchVO searchVO) {
        return list("officialResultDetailDAO.getCalculation", searchVO);
    }

    public void inCalResult(CalculationVO calculationVO) {
        insert("officialResultDetailDAO.inCalResult", calculationVO);
    }

    public List<?> getResultListAll(SearchVO searchVO) {
        return list("officialResultDetailDAO.getResultListAll", searchVO);
    }

    public SmpDetailVO getSmpDetail(SearchVO searchVO) {
        return (SmpDetailVO) select("officialResultDetailDAO.getSmpDetail", searchVO);
    }

    public void delApprConf(CoopApprVO coopApprVO) {
        delete("officialResultDetailDAO.delApprConf", coopApprVO);
    }

    public void inApprConf(CoopApprVO coopApprVO) {
        insert("officialResultDetailDAO.inApprConf", coopApprVO);
    }

    public void delCoopReq(CoopApprVO coopApprVO) {
        delete("officialResultDetailDAO.delCoopReq", coopApprVO);
    }

    public void inCoopReq(CoopApprVO coopApprVO) {
        insert("officialResultDetailDAO.inCoopReq", coopApprVO);
    }

    public void upCoopResult(CoopApprVO coopApprVO) {
        update("ResultDetailDAO.upCoopResult", coopApprVO);
    }

}
