package tems.com.edu.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import tems.com.edu.common.model.CodeVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("commonDAO")
public class CommonDAO extends EgovComAbstractDAO {
	
	
	//교육훈련 상태 가져오기
	public List<CodeVO> listCourseStateCode() throws Exception {
		
		System.out.println(list("commonDAO.listCourseStateCode")); 
		return (List<CodeVO>) list("commonDAO.listCourseStateCode");
	}
	
	
	//개인별 접수 상태 가져오기
	public List<CodeVO> listEnrollStateCode() throws Exception {
		return (List<CodeVO>) list("commonDAO.listEnrollStateCode");
	}
		

	//결제 상태 가져오기
	public List<CodeVO> listPayStateCode() throws Exception {
		return (List<CodeVO>) list("commonDAO.listPayStateCode");
	}
	
	//결제 방법 가져오기
	public List<CodeVO> listPayTypeCode() throws Exception {
		return (List<CodeVO>) list("commonDAO.listPayTypeCode");
	}
	
	//결제 시기 가져오기
	public List<CodeVO> listPayTimeCode() throws Exception {
		return (List<CodeVO>) list("commonDAO.listPayTimeCode");
	}
	
	//세금계산서 방식 가져오기
	public List<CodeVO> listTaxTypeCode() throws Exception {
		return (List<CodeVO>) list("commonDAO.listTaxTypeCode");
	}
	
	//수료유무 가져오기
	public List<CodeVO> listPassCode() throws Exception {
		return (List<CodeVO>) list("commonDAO.listPassCode");
	}
}