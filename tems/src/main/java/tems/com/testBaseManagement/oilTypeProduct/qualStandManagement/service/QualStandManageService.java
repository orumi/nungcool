package tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.service;

import java.util.List;

import tems.com.system.model.AuthorGrpVO;
import tems.com.system.model.AuthorListVO;
import tems.com.system.model.OfficeUserListVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualInsertVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualPopVO;
import tems.com.testBaseManagement.oilTypeProduct.qualStandManagement.model.QualStandListVO;

public interface QualStandManageService {
	
	List getQualStandList(String str) throws Exception;
	
	void upQualStand(QualStandListVO qualStandListVO) throws Exception;

	void insertQualStandList(QualInsertVO vo) throws Exception;

	List selectStandPopList(String str) throws Exception;

	void saveStandPopList(List<QualPopVO> list) throws Exception;

	void deletePopUp(List<QualPopVO> modifiedList);

	List firstSelectList() throws Exception;

	List secondSelectList() throws Exception;

	List thirdSelectList() throws Exception;

}
