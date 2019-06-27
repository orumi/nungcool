package tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.service.impl;

import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeFourthVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeProductVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeSecondVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeThirdVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.service.OilTypeProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2015-11-23.
 */
@Service("oilTypeProductService")
public class OilTypeProductServiceImpl implements OilTypeProductService {

    @Resource(name = "oilTypeProductDAO")
    OilTypeProductDAO oilTypeProductDAO;

    @Override
    public List selectOilTypeProductList() throws Exception {
        return oilTypeProductDAO.selectOilTypeProductList();
    }

    @Override
    public List selectSecondList(OilTypeSecondVO secondVO) throws Exception {
        return oilTypeProductDAO.selectSecondList(secondVO);
    }

    @Override
    public List selectThirdList(OilTypeThirdVO thirdVO) throws Exception {
        return oilTypeProductDAO.selectThirdList(thirdVO);
    }

    @Override
    public void saveOilTypeProductList(List<OilTypeProductVO> list) throws Exception {

        for (OilTypeProductVO vo : list) {
            if (vo.getState().equals("updated")) {
                oilTypeProductDAO.updateOilTypeProductDAO(vo);
            } else if (vo.getState().equals("created")) {
                oilTypeProductDAO.insertOilTypeProductDAO(vo);
            } else if (vo.getState().equals("deleted")) {
                oilTypeProductDAO.deleteOilTypeProductDAO(vo);
            }
        }
    }

    @Override
    public void saveOilTypeSecondList(List<OilTypeSecondVO> list) throws Exception {

        for (OilTypeSecondVO vo : list) {
            if (vo.getState().equals("updated")) {
                oilTypeProductDAO.updateOilTypeSecondDAO(vo);
            } else if (vo.getState().equals("created")) {
                oilTypeProductDAO.insertOilTypeSecondDAO(vo);
            } else if (vo.getState().equals("deleted")) {
                oilTypeProductDAO.deleteOilTypeSecondDAO(vo);
            }
        }
    }

    @Override
    public void saveOilTypeThirdList(List<OilTypeThirdVO> list) throws Exception {

        for (OilTypeThirdVO vo : list) {
            if (vo.getState().equals("updated")) {
                oilTypeProductDAO.updateOilTypeThirdDAO(vo);
            } else if (vo.getState().equals("created")) {
                oilTypeProductDAO.insertOilTypeThirdDAO(vo);
            } else if (vo.getState().equals("deleted")) {
                oilTypeProductDAO.deleteOilTypeThirdDAO(vo);
            }
        }
    }

    @Override
    public List selectThirdJoinList(OilTypeThirdVO thirdVO) throws Exception {
        return oilTypeProductDAO.selectThirdJoinList(thirdVO);
    }

    @Override
    public List selectFourthList(OilTypeFourthVO fourthVO) throws Exception {
        return oilTypeProductDAO.selectFourthList(fourthVO);
    }

    @Override
    public void insertOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception {
        oilTypeProductDAO.insertOilTypeFourthDAO(fourthVO);
    }

    @Override
    public void updateOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception {
        oilTypeProductDAO.updateOilTypeFourthDAO(fourthVO);
    }

    @Override
    public void deleteOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception {
        oilTypeProductDAO.deleteOilTypeFourthDAO(fourthVO);
    }


}
