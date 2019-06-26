package tems.com.testBaseManagement.testItemManagement.genReqTestItem.service.GenReqServiceImpl;

import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeProductVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.GenReqVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.LoadUnitVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.PopUpVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.service.GenReqService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by owner1120 on 2015-11-26.
 */

@Service
public class GenReqServiceImpl implements GenReqService {

    @Resource(name = "genReqServiceDAO")
    GenReqServiceDAO genReqServiceDAO;

    @Override
    public List selectGenReqServiceList() throws Exception {
        List list = genReqServiceDAO.selectGenReqServiceList();
        return list;
    }

    public List searchGenReqServiceList(GenReqVO genReqVO) throws Exception {
        List list = genReqServiceDAO.searchGenReqServiceDAO(genReqVO);
        return list;
    }

    @Override
    public List selectTNEResult(GenReqVO genReqVO) throws Exception {
        List list = genReqServiceDAO.selectTNEResult(genReqVO);
        return list;
    }

    @Override
    public void deleteGenReqServiceDAO(GenReqVO genReqVO) throws Exception {
        genReqServiceDAO.deleteGenReqServiceDAO(genReqVO);
    }

    @Override
    public void subItemAddData(GenReqVO genReqVO) throws Exception {
        genReqServiceDAO.insertGenReqServiceDAO(genReqVO);
    }

    @Override
    public List selectTestCondition(PopUpVO popUpVO) throws Exception {
        return genReqServiceDAO.selectTestConditionDAO(popUpVO);
    }

    @Override
    public void saveTestCondition(List<PopUpVO> list) throws Exception {

        for (PopUpVO vo : list) {
            if (vo.getState().equals("updated")) {
                genReqServiceDAO.updateTestConditionDAO(vo);
            } else if (vo.getState().equals("created")) {
                genReqServiceDAO.insertTestConditionDAO(vo);
            } else if (vo.getState().equals("deleted")) {
                genReqServiceDAO.deleteTestConditionDAO(vo);
            }
        }
    }

    @Override
    public List selectTestUnitDAO() throws Exception {
        List list = genReqServiceDAO.selectTestUnitDAO();
        return list;
    }

    @Override
    public void saveGenReqServiceList(List<GenReqVO> list) throws Exception {

        for (GenReqVO vo : list) {
            if (vo.getState().equals("updated")) {
                genReqServiceDAO.updateGenReqServiceDAO(vo);
            } else if (vo.getState().equals("created")) {
                genReqServiceDAO.insertGenReqServiceDAO(vo);
            } else if (vo.getState().equals("deleted")) {
                genReqServiceDAO.deleteGenReqServiceDAO(vo);
            }
        }
    }
}

