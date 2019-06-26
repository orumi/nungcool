package tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.system.model.OfficeUserListVO;
import tems.com.system.service.UserInfoService;
import tems.com.system.service.impl.UserInfoDAO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualInsertVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualPopVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualStandListVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.service.QualStandManageService;

@Service("QualStandManageService")
public class QualStandManageServiceImpl implements QualStandManageService {

    @Resource(name = "QualStandManageDAO")
    private QualStandManageDAO QualStandManageDAO;

    @Override
    public List<?> getQualStandList(String str) throws Exception {
        return QualStandManageDAO.getQualStandList(str);
    }

    @Override
    public void upQualStand(QualStandListVO qualStandListVO) throws Exception {
        QualStandManageDAO.upQualStand(qualStandListVO);
    }

    @Override
    public void insertQualStandList(QualInsertVO vo) throws Exception {
        QualStandManageDAO.insertQualStandList(vo);
    }

    @Override
    public List selectStandPopList(String str) throws Exception {
        return QualStandManageDAO.selectStandPopList(str);
    }

    @Override
    public void saveStandPopList(List<QualPopVO> list) throws Exception {

        for (QualPopVO qualPopVO : list) {
            if (qualPopVO.getState().equals("updated")) {
                QualStandManageDAO.updatePopUp(qualPopVO);
            } else if (qualPopVO.getState().equals("created")) {
                QualStandManageDAO.insertPopUp(qualPopVO);
            }
        }
    }

    @Override
    public void deletePopUp(List<QualPopVO> modifiedList) {

        for (QualPopVO vo : modifiedList) {
            QualStandManageDAO.deletePopUp(vo);
        }

    }

}
