package tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.system.model.OfficeUserListVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeProductVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualInsertVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualPopVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualStandListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("QualStandManageDAO")
public class QualStandManageDAO extends EgovComAbstractDAO {

    public List<?> getQualStandList(String str) {

        return list("QualStandDAO.selQualStandList", str);
    }

    public void upQualStand(QualStandListVO qualStandListVO) {
        update("QualStandDAO.upQualStandList", qualStandListVO);
    }

    public void insertQualStandList(QualInsertVO vo) {

        insert("QualStandDAO.insertQualStandList", vo);
    }

    public List<?> selectStandPopList(String str) {

        return list("QualStandDAO.selectStandPopList", str);
    }

    public void updatePopUp(QualPopVO vo) {

        update("QualStandDAO.updatePopUp", vo);
    }

    public void insertPopUp(QualPopVO vo) {

        insert("QualStandDAO.insertPopUp", vo);
    }

    public void deletePopUp(QualPopVO vo) {
        delete("QualStandDAO.deletePopUp", vo);
    }


    public List<?> firstSelectList () {
        return list("QualStandDAO.firstSelectList");
    }

    public List<?> secondSelectList () {
        return list("QualStandDAO.secondSelectList");
    }

    public List<?> thirdSelectList () {
        return list("QualStandDAO.thirdSelectList");
    }



}
