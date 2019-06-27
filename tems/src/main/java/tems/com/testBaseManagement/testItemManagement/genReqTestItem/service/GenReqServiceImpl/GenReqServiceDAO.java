package tems.com.testBaseManagement.testItemManagement.genReqTestItem.service.GenReqServiceImpl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.GenReqVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.PopUpVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-11-26.
 */
@Repository("genReqServiceDAO")
public class GenReqServiceDAO extends EgovComAbstractDAO {


    public List<?> selectGenReqServiceList() throws Exception {
        return list("genReqServiceDAO.selectGenReqServiceDAO");
    }

    public List<?> searchGenReqServiceDAO(GenReqVO genReqVO) throws Exception {
        return list("genReqServiceDAO.searchGenReqServiceDAO", genReqVO);
    }

    public void insertGenReqServiceDAO(GenReqVO genReqVO) throws Exception {

        insert("genReqServiceDAO.insertGenReqServiceDAO", genReqVO);
    }

    public void updateGenReqServiceDAO(GenReqVO genReqVO) throws Exception {
        update("genReqServiceDAO.updateGenReqServiceDAO", genReqVO);
    }

    public void deleteGenReqServiceDAO(GenReqVO genReqVO) throws Exception {
        delete("genReqServiceDAO.deleteGenReqServiceDAO", genReqVO);
    }

    public List selectTNEResult(GenReqVO genReqVO) throws Exception {
        return list("genReqServiceDAO.selectTNEResult", genReqVO);
    }

    public List selectTestConditionDAO(PopUpVO popUpVO) throws Exception {
        return list("genReqServiceDAO.selectTestConditionDAO", popUpVO);
    }

    public void insertTestConditionDAO(PopUpVO popUpVO) throws Exception {
        insert("genReqServiceDAO.insertTestConditionDAO", popUpVO);
    }

    public void deleteTestConditionDAO(PopUpVO popUpVO) throws Exception {
        delete("genReqServiceDAO.deleteTestConditionDAO", popUpVO);
    }

    public void updateTestConditionDAO(PopUpVO popUpVO) throws Exception {
        update("genReqServiceDAO.updateTestConditionDAO", popUpVO);
    }

    public List selectTestUnitDAO() throws Exception {
        return list("genReqServiceDAO.selectTestUnitDAO");
    }

    public Integer selectSubPropertyCheck(GenReqVO vo) throws Exception {
        int count =  (Integer) select("genReqPropServiceDAO.selectSubPropertyCheck", vo);
        return count;
    }

}
