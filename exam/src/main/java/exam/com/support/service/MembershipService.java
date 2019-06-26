package exam.com.support.service;


import java.util.HashMap;
import java.util.List;

import exam.com.main.model.LoginUserVO;
import exam.com.req.model.ClassVO;
import exam.com.req.model.PriceVO;
import exam.com.req.model.RequestAttachVO;
import exam.com.req.model.RequestVO;
import exam.com.req.model.ResultVO;
import exam.com.req.model.SampleVO;
import exam.com.req.model.TempletVO;
import exam.com.req.model.TreeVO;
import exam.com.support.model.EquipDetailVO;
import exam.com.support.model.EquipItemVO;
import exam.com.support.model.EquipReqVO;
import exam.com.support.model.MembershipVO;

/**
 * Created by KMC
 */

public interface MembershipService {
 
	public List selectMembership(LoginUserVO loginUser) throws Exception;

	public void insertMembership(MembershipVO membershipVO) throws Exception;
	
	public void updateMembership(MembershipVO membershipVO) throws Exception;
	
	
	/* 설비 계약 목록 */
	public List selectEquipReq(String comid) throws Exception;
	
	public List selectEquipReqDetail(HashMap<String, String> map) throws Exception;
	
	/*게약장비 목록*/
	public List selectEquipDetailList(String equipreqid) throws Exception;
	
	/* 장비 검색 목록*/
	public List selectSearchEquip(String searchkey) throws Exception;
	
	/* 장비계약정보 저장 */
	public void insertEquipReq(EquipReqVO equipReqVO) throws Exception;
	
	public void updateEquipReq(EquipReqVO equipReqVO) throws Exception;
	
	public void deleteEquipContract(String equipreqid) throws Exception;
	
	public void insertEquipContract(EquipDetailVO equipDetailVO) throws Exception;
	
	public void deleteEquipReq(String equipreqid)throws Exception;
	
	public void updateTotPay(String equipreqid)throws Exception;
}
