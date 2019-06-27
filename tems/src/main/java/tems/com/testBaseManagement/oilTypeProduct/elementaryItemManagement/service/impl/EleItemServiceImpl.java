package tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.service.impl;

import org.springframework.stereotype.Service;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.ElePopUpVO;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.RightOneVO;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.service.EleItemService;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by owner1120 on 2015-12-10.
 */
@Service
public class EleItemServiceImpl implements EleItemService {

    @Resource(name = "eleItemServiceDAO")
    EleItemServiceDAO eleItemServiceDAO;


    @Override
    public List loadTesTCondtion() throws Exception {
        return eleItemServiceDAO.loadTesTCondtion();
    }

    @Override
    public void saveRightOne(List<RightOneVO> list) throws Exception {

        for (RightOneVO vo : list) {
            eleItemServiceDAO.updateRightOne(vo);
        }

    }

    @Override
    public void deleteRightOne(List<RightOneVO> list) throws Exception {

        for (RightOneVO vo : list) {
            eleItemServiceDAO.deleteRightOne(vo);
        }
    }

    @Override
    public List loadDataLeft(List<RightOneVO> list) throws Exception {

        List result = null;

        for (RightOneVO vo : list) {
            result = eleItemServiceDAO.loadDataLeft(vo);
        }

        return result;

    }

    @Override
    public List modalSearch(String str) throws Exception {

       List list = eleItemServiceDAO.modalSearch(str);

        return list;
    }

    @Override
    public List identDupl(ElePopUpVO vo) throws Exception {
        return eleItemServiceDAO.identDupl(vo);
    }

    @Override
    public void mergeIntoForParentsCheck(ElePopUpVO vo) throws Exception {
        eleItemServiceDAO.mergeIntoForParentsCheck(vo);
    }

    @Override
    public List selectEleItemPopUp() throws Exception {
        return eleItemServiceDAO.selectElePopUP();
    }

    @Override
    public void insertElePopUP(ElePopUpVO vo) throws Exception {
        eleItemServiceDAO.insertElePopUP(vo);
    }

    @Override
    public List childsCheck(ElePopUpVO vo) throws Exception {
       List list = eleItemServiceDAO.childsCheck(vo);
        return list;
    }



    @Override
    public List selectRightOne(RightOneVO vo) throws Exception {

        List list = eleItemServiceDAO.selectRightOne(vo);

        return list;
    }

    public List checkParents(ElePopUpVO vo) throws Exception {

        List list = eleItemServiceDAO.checkParents(vo);

        return list;
    }

    @Override
    public List getOneFromTCEITEM(ElePopUpVO vo) throws Exception {

        List list = eleItemServiceDAO.getOneFromTCEITEM(vo);

        return list;
    }

    @Override
    public List loadTestMethod(RightOneVO vo) throws Exception {

        List list = eleItemServiceDAO.loadTestMethod(vo);

        return list;
    }

}
