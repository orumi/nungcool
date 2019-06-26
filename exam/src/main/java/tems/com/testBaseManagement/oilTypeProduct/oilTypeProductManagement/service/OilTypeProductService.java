package tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.service;

import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeFourthVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeProductVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeSecondVO;
import tems.com.testBaseManagement.oilTypeProduct.oilTypeProductManagement.model.OilTypeThirdVO;

import java.util.List;

/**
 * Created by Administrator on 2015-11-23.
 */
public interface OilTypeProductService {

     public List selectOilTypeProductList() throws Exception;

     public void saveOilTypeProductList(List<OilTypeProductVO> list) throws Exception;

     public List selectSecondList(OilTypeSecondVO secondVO) throws Exception;

     public List selectThirdList(OilTypeThirdVO thirdVO) throws Exception;

     public void saveOilTypeSecondList(List<OilTypeSecondVO> modifiedList) throws Exception;

     void saveOilTypeThirdList(List<OilTypeThirdVO> list) throws Exception;

     public List selectThirdJoinList(OilTypeThirdVO thirdVO) throws Exception;

     public List selectFourthList(OilTypeFourthVO fourthVO) throws Exception;

     public void insertOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception;

     public void updateOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception;

     public void deleteOilTypeFourthDAO(OilTypeFourthVO fourthVO) throws Exception;
}
