package exam.com.card.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

import org.springframework.stereotype.Repository;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;

import java.util.HashMap;
import java.util.List;

/**
 * Created by yongwoo on 2015-11-09.
 */
@Repository("cardDAO")
public class CardDAO extends EgovComAbstractDAO {

         

      public List<?> selectReqCard(HashMap<String, Object> map) throws Exception {
    	  return list("INIpay_DAO.selectReqCard", map);
      }
      public void updateReqCard(HashMap<String, Object> map) throws Exception {
    	  update("INIpay_DAO.updateReqCard", map);
      }
      public void updateCancelCard(HashMap<String, Object> map) throws Exception {
    	  update("INIpay_DAO.updateCancelCard", map);
      }
      
      
      public List<?> selectEquipCard(HashMap<String, Object> map) throws Exception {
    	  return list("INIpay_DAO.selectEquipCard", map);
      }
      public void updateEquipCard(HashMap<String, Object> map) throws Exception {
    	  update("INIpay_DAO.updateEquipCard", map);
      }
      public void updateCancelEquipCard(HashMap<String, Object> map) throws Exception {
    	  update("INIpay_DAO.updateEquipCancelCard", map);
      }
      
      
      public List<?> selectReportCard(HashMap<String, Object> map) throws Exception {
    	  return list("INIpay_DAO.selectReportCard",map);
      }
      public void updateReportCard(HashMap<String, Object> map) throws Exception {
    	  update("INIpay_DAO.updateReportCard", map);
      }
      public void updateCancelReportCard(HashMap<String, Object> map) throws Exception {
    	  update("INIpay_DAO.updateReportCancelCard", map);
      }
      
      
}
