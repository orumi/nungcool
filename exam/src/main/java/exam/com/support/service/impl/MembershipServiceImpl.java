package exam.com.support.service.impl;


import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.exam.req.service.ReqListService;
import tems.com.exam.req.service.impl.ReqDetailDAO;
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
import exam.com.support.service.EstimateService;
import exam.com.support.service.MembershipService;

/**
 * Created by KMC
 */
@Service("MembershipService")
public class MembershipServiceImpl implements MembershipService  {

	 
    @Resource(name = "MembershipDAO")
    private MembershipDAO membershipDAO;
    
    
	@Override
	public List selectMembership(LoginUserVO loginUser) throws Exception {
		
		return membershipDAO.selectMembership(loginUser);
		
	}

	@Override
	public void insertMembership(MembershipVO membershipVO) throws Exception{
		membershipDAO.insertMembership(membershipVO);
	}
	
	
	@Override
	public void updateMembership(MembershipVO membershipVO) throws Exception{
		membershipDAO.updateMembership(membershipVO);
	}
	
	
	
	/* 설비 계약 목록 */
	@Override
	public List selectEquipReq(String comid){
		return membershipDAO.selectEquipReq(comid);
	}
	
	@Override
	public List selectEquipReqDetail(HashMap<String, String> map){
		return membershipDAO.selectEquipReqDetail(map);
	}
	
	/*게약장비 목록*/
	@Override
	public List selectEquipDetailList(String equipreqid){
		return membershipDAO.selectEquipDetailList(equipreqid);
	}
	
	/* 장비 검색 목록*/
	@Override
	public List selectSearchEquip(String searchkey){
		return membershipDAO.selectSearchEquip(searchkey);
	}
	
	/* 장비계약정보 저장 */
	@Override
	public void insertEquipReq(EquipReqVO equipReqVO){
		membershipDAO.insertEquipReq(equipReqVO);
	}
	
	@Override
	public void updateEquipReq(EquipReqVO equipReqVO){
		membershipDAO.updateEquipReq(equipReqVO);
	}
	
	@Override
	public void deleteEquipContract(String equipreqid){
		membershipDAO.deleteEquipContract(equipreqid);
	}
	
	@Override
	public void insertEquipContract(EquipDetailVO equipDetailVO){
		membershipDAO.insertEquipContract(equipDetailVO);
	}

	@Override
	public void deleteEquipReq(String equipreqid){
		membershipDAO.deleteEquipReq(equipreqid);
	}
	@Override
	public void updateTotPay(String equipreqid){
		membershipDAO.updateTotPay(equipreqid);
	}
	
}
