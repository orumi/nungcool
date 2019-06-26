package exam.com.card.service;


import java.util.HashMap;
import java.util.List;

import exam.com.main.model.CompanyVO;
import exam.com.main.model.LoginOldUserVO;
import exam.com.main.model.LoginUserVO;
import exam.com.main.model.MemberVO;

/**
 * Created by  on 2015-11-09.
 */
public interface CardService {

	public List<?> selectReqCard(HashMap<String, Object> map) throws Exception ;
	public void updateReqCard(HashMap<String, Object> map) throws Exception;
	public void updateCancelCard(HashMap<String, Object> map) throws Exception;
	
    public List<?> selectEquipCard(HashMap<String, Object> map) throws Exception ;
    public void updateEquipCard(HashMap<String, Object> map) throws Exception ;
    public void updateCancelEquipCard(HashMap<String, Object> map) throws Exception ;
	
    public List<?> selectReportCard(HashMap<String, Object> map) throws Exception;
    public void updateReportCard(HashMap<String, Object> map) throws Exception ;
    public void updateCancelReportCard(HashMap<String, Object> map) throws Exception ;
	
}
