package ncsys.com.util.commoncd.service;

import java.util.List;

import ncsys.com.util.commoncd.service.model.CommonCd;


public interface CommonCdService {

	public List<CommonCd> selectCommonCdList(CommonCd commonCd) throws Exception;	
	
}
