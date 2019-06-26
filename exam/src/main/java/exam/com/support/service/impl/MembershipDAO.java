package exam.com.support.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.exam.req.model.ApprDetailVO;
import tems.com.exam.req.model.ApprListVO;
import tems.com.exam.req.model.RequestListVO;
import tems.com.exam.req.model.RequestSearchVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
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

@Repository("MembershipDAO")
public class MembershipDAO extends EgovComAbstractDAO  {
		
	public List<?> selectMembership(LoginUserVO loginUser){
        return list("membership_DAO.selectMembership", loginUser);
    }
	
	public void insertMembership(MembershipVO membershipVO){
		insert("membership_DAO.insertMemebership",membershipVO);
	}

	public void updateMembership(MembershipVO membershipVO){
		update("membership_DAO.updateMembership", membershipVO);
	}
	
	
	
	
	/* 설비 계약 목록 */
	public List<?> selectEquipReq(String comid){
		return list("membership_DAO.selectEquipReq", comid);
	}
	
	public List<?> selectEquipReqDetail(HashMap<String, String> map){
		return list("membership_DAO.selectEquipReqDetail", map);
	}
	
	/*게약장비 목록*/
	public List<?> selectEquipDetailList(String equipreqid){
		return list("membership_DAO.selectEquipDetailList", equipreqid);
	}
	
	/* 장비 검색 목록*/
	public List<?> selectSearchEquip(String searchkey){
		return list("membership_DAO.selectSearchEquip",searchkey);
	}
	
	/* 장비계약정보 저장 */
	public void insertEquipReq(EquipReqVO equipReqVO){
		insert("membership_DAO.insertEquipReq", equipReqVO);
	}
	
	public void updateEquipReq(EquipReqVO equipReqVO){
		update("membership_DAO.updateEquipReq",equipReqVO);
	}
	
	public void deleteEquipContract(String equipreqid){
		delete("membership_DAO.deleteEquipContract", equipreqid);
	}
	
	public void insertEquipContract(EquipDetailVO equipDetailVO){
		insert("membership_DAO.insertEquipContract", equipDetailVO);
	}
	
	
	public void deleteEquipReq(String equipreqid){
		deleteEquipContract(equipreqid);
		delete("membership_DAO.deleteEquipReq", equipreqid);
	}
	
	public void updateTotPay(String equipreqid){
		delete("membership_DAO.updateTotpay",equipreqid);
	}
	
	
	
}
