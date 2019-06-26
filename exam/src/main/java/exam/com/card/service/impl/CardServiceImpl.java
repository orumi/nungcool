package exam.com.card.service.impl;

import java.util.HashMap;
import java.util.List;

import exam.com.card.service.CardService;
import exam.com.main.model.LoginUserVO;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by  on 2015-11-09.
 */
@Service("cardService")
public class CardServiceImpl implements CardService {

     @Resource(name = "cardDAO")
     private CardDAO cardDAO;
 
     
     @Override
     public List selectReqCard(HashMap<String, Object> map) throws Exception {
          return cardDAO.selectReqCard(map);
     }
     @Override
     public void updateReqCard(HashMap<String, Object> map) throws Exception {
    	 cardDAO.updateReqCard(map);
     }
     @Override
     public void updateCancelCard(HashMap<String, Object> map) throws Exception {
   	  	cardDAO.updateCancelCard(map);
     }
     
     @Override
     public List<?> selectEquipCard(HashMap<String, Object> map) throws Exception {
   	  	return cardDAO.selectEquipCard(map);
     }
     @Override
     public void updateEquipCard(HashMap<String, Object> map) throws Exception {
   	  	cardDAO.updateEquipCard(map);
     }
     @Override
     public void updateCancelEquipCard(HashMap<String, Object> map) throws Exception {
   	  	cardDAO.updateCancelEquipCard(map);
     }
     
     
     @Override
     public List selectReportCard(HashMap<String, Object> map) throws Exception {
    	 return cardDAO.selectReportCard(map);
     }
     @Override
     public void updateReportCard(HashMap<String, Object> map) throws Exception {
    	  	cardDAO.updateReportCard(map);
     }
     @Override
     public void updateCancelReportCard(HashMap<String, Object> map) throws Exception {
    	  	cardDAO.updateCancelReportCard(map);
     }
     
}
