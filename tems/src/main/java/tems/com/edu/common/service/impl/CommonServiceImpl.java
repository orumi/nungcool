package tems.com.edu.common.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import tems.com.edu.common.model.CodeVO;
import tems.com.edu.common.service.CommonService;


@Service("commonService")
public class CommonServiceImpl implements CommonService {
	
	@Resource(name = "commonDAO")
	private CommonDAO commonDAO;
	
	
	
	//교육훈련 상태 가져오기
	@Override
	public List<CodeVO> listCourseStateCode() throws Exception {
		return commonDAO.listCourseStateCode();
	}
	
	
	//개인별 접수 상태 가져오기
	@Override
	public List<CodeVO> listEnrollStateCode() throws Exception {
		return commonDAO.listEnrollStateCode();
	}
		

	//결제 상태 가져오기
	@Override
	public List<CodeVO> listPayStateCode() throws Exception {
		return commonDAO.listPayStateCode();
	}
	
	//결제 방법 가져오기
	@Override
	public List<CodeVO> listPayTypeCode() throws Exception {
		return commonDAO.listPayTypeCode();
	}
	
	//결제 시기 가져오기
	@Override
	public List<CodeVO> listPayTimeCode() throws Exception {
		return commonDAO.listPayTimeCode();
	}
	
	//세금계산서 방식 가져오기
	@Override
	public List<CodeVO> listTaxTypeCode() throws Exception {
		return commonDAO.listTaxTypeCode();
	}
	
	//수료유무 가져오기
	@Override
	public List<CodeVO> listPassCode() throws Exception {
		return commonDAO.listPassCode();
	}
	
	
}