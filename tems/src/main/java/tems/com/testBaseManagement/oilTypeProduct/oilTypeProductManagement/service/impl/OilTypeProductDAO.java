package tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeFourthVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeProductVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeSecondVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeThirdVO;
import tems.com.testBaseManagement.testMethodManagement.model.TestMethodManagementVO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2015-11-23.
 */
@Repository("oilTypeProductDAO")
public class OilTypeProductDAO extends EgovComAbstractDAO {

    public List<?> selectOilTypeProductList() throws Exception {
        return list("oilTypeProductDAO.selectOilTypeProductList");
    }
    public List<?> selectSecondList(OilTypeSecondVO secondVO) throws Exception {
        return list("oilTypeProductDAO.selectSecondList", secondVO);
    }
    public List<?> selectThirdList(OilTypeThirdVO thirdVO) throws Exception {
        return list("oilTypeProductDAO.selectThirdList", thirdVO);
    }
    public List<?> selectFourthList(OilTypeFourthVO fourthVO) throws Exception {
        return list("oilTypeProductDAO.selectFourthList", fourthVO);
    }
    public void insertOilTypeProductDAO(OilTypeProductVO oilTypeProductVO) throws Exception {
        insert("oilTypeProductDAO.insertOilTypeProductDAO", oilTypeProductVO);
    }
    public void insertOilTypeSecondDAO(OilTypeSecondVO secondVO) throws Exception {
        insert("oilTypeProductDAO.insertOilTypeSecondDAO", secondVO);
    }
    public void insertOilTypeThirdDAO(OilTypeThirdVO thirdVO) throws Exception {
        insert("oilTypeProductDAO.insertOilTypeThirdDAO", thirdVO);
    }
    public void insertOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception {
        insert("oilTypeProductDAO.insertOilTypeFourthDAO", fourthVO);
    }
    public void updateOilTypeProductDAO(OilTypeProductVO oilTypeProductVO) throws Exception {
        update("oilTypeProductDAO.updateOilTypeProductDAO", oilTypeProductVO);
    }
    public void updateOilTypeSecondDAO(OilTypeSecondVO secondVO) throws Exception {
        update("oilTypeProductDAO.updateOilTypeSecondDAO", secondVO);
    }
    public void updateOilTypeThirdDAO(OilTypeThirdVO thirdVO) throws Exception {
        update("oilTypeProductDAO.updateOilTypeThirdDAO", thirdVO);
    }
    public void updateOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception {
        update("oilTypeProductDAO.updateOilTypeFourthDAO", fourthVO);
    }
    public void deleteOilTypeProductDAO(OilTypeProductVO oilTypeProductVO) throws Exception {
        delete("oilTypeProductDAO.deleteOilTypeProductDAO", oilTypeProductVO);
    }
    public void deleteOilTypeSecondDAO(OilTypeSecondVO secondVO) throws Exception {
        delete("oilTypeProductDAO.deleteOilTypeSecondDAO", secondVO);
    }
    public void deleteOilTypeThirdDAO(OilTypeThirdVO thirdVO) throws Exception {
        delete("oilTypeProductDAO.deleteOilTypeThirdDAO", thirdVO);
    }
    public void deleteOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception {
        delete("oilTypeProductDAO.deleteOilTypeFourthDAO", fourthVO);
    }
    public List<?> selectThirdJoinList(OilTypeThirdVO thirdVO) throws Exception {
        return list("oilTypeProductDAO.selectThirdJoinList", thirdVO);
    }

}
