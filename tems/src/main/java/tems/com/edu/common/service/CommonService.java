package tems.com.edu.common.service;

import java.util.List;

import tems.com.edu.common.model.CodeVO;

public interface CommonService {
	
	//교육훈련 상태 가져오기
	public List<CodeVO> listCourseStateCode() throws Exception ;
	
	//개인별 접수 상태 가져오기
	public List<CodeVO> listEnrollStateCode() throws Exception ;

	//결제 상태 가져오기
	public List<CodeVO> listPayStateCode() throws Exception ;
	
	//결제 방법 가져오기
	public List<CodeVO> listPayTypeCode() throws Exception ;
	
	//결제 시기 가져오기
	public List<CodeVO> listPayTimeCode() throws Exception ;
	
	//세금계산서 방식 가져오기
	public List<CodeVO> listTaxTypeCode() throws Exception ;
	
	//수료유무 가져오기
	public List<CodeVO> listPassCode() throws Exception ;
	
}
