package tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.ElePopUpVO;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.RightOneVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeFourthVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeProductVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-12-10.
 */

@Repository("eleItemServiceDAO")
public class EleItemServiceDAO extends EgovComAbstractDAO {

    public List<?> selectElePopUP() throws Exception {
        return list("eleItemServiceDAO.selectElePopUP");
    }

    public void insertElePopUP(ElePopUpVO vo) throws Exception {
        insert("eleItemServiceDAO.insertElePopUP", vo);
    }

    public void updateElePopUP() throws Exception {
        update("eleItemServiceDAO.updateElePopUP");
    }

    public void deleteElePopUP() throws Exception {
        delete("eleItemServiceDAO.deleteElePopUP");
    }

    public List<?> duplicateCheck(ElePopUpVO vo) throws Exception {
        return list("eleItemServiceDAO.duplicateCheck", vo);
    }

    public List<?> selectRightOne(RightOneVO vo) throws Exception {
        return list("eleItemServiceDAO.selectRightOne", vo);
    }

    public List<?> checkParents(ElePopUpVO vo) throws Exception {
        return list("eleItemServiceDAO.checkParents", vo);
    }

    public List<?> getOneFromTCEITEM(ElePopUpVO vo) throws Exception {
        return list("eleItemServiceDAO.getOneFromTCEITEM", vo);
    }

    public List<?> loadTestMethod(RightOneVO vo) throws Exception {
        return list("eleItemServiceDAO.loadTestMethod", vo);
    }

    public List<?> loadTesTCondtion() throws Exception {
        return list("eleItemServiceDAO.loadTesTCondtion");
    }

    public void updateRightOne(RightOneVO vo) throws Exception {
        update("eleItemServiceDAO.updateRightOne", vo);
    }

    public void deleteRightOne(RightOneVO vo) throws Exception {
        delete("eleItemServiceDAO.deleteRightOne", vo);
    }

    public List<?> loadDataLeft(RightOneVO vo) throws Exception {
        return list("eleItemServiceDAO.loadDataLeft", vo);
    }


}
