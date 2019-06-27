package tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.service;

import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.ElePopUpVO;
import tems.com.testBaseManagement.oilTypeProduct.elementaryItemManagement.model.RightOneVO;

import java.util.List;

/**
 * Created by owner1120 on 2015-12-10.
 */
public interface EleItemService {

    public List selectEleItemPopUp() throws Exception;

    public void insertElePopUP(ElePopUpVO vo) throws Exception;

    public List childsCheck(ElePopUpVO vo) throws Exception;

    public List selectRightOne(RightOneVO vo) throws Exception;

    public List checkParents(ElePopUpVO vo) throws Exception;

    public List getOneFromTCEITEM(ElePopUpVO vo) throws Exception;

    public List loadTestMethod(RightOneVO vo) throws Exception;

    public List loadTesTCondtion() throws Exception;

    public void saveRightOne(List<RightOneVO> list) throws Exception;

    public void deleteRightOne(List<RightOneVO> list) throws Exception;

    public List loadDataLeft(List<RightOneVO> list) throws Exception;

    public List modalSearch(String str) throws Exception;

    public List identDupl(ElePopUpVO vo) throws Exception;

    public void mergeIntoForParentsCheck(ElePopUpVO vo) throws Exception;

}
