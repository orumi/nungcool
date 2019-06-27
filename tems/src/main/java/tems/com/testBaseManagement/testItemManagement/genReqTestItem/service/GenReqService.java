package tems.com.testBaseManagement.testItemManagement.genReqTestItem.service;

import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.GenReqVO;
import tems.com.testBaseManagement.testItemManagement.genReqTestItem.model.PopUpVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-11-26.
 */
public interface GenReqService {

    public List selectGenReqServiceList() throws Exception;

    public void saveGenReqServiceList(List<GenReqVO> list) throws Exception;

    public List searchGenReqServiceList(GenReqVO genReqVO) throws Exception;

    public List selectTNEResult(GenReqVO genReqVO) throws Exception;

    public void deleteGenReqServiceDAO(GenReqVO genReqVO) throws Exception;

    public void subItemAddData(GenReqVO genReqVO) throws Exception;

    public List selectTestCondition(PopUpVO popUpVO) throws Exception;

    public void saveTestCondition(List<PopUpVO> list) throws Exception;

    public List selectTestUnitDAO() throws Exception;

    public int selectSubPropertyCheck(GenReqVO vo) throws Exception;

}
