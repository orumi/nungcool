package ncsys.com.util.commoncd.service.impl;


import java.util.List;

import javax.annotation.Resource;

import ncsys.com.util.commoncd.service.CommonCdService;
import ncsys.com.util.commoncd.service.mapper.CommonCdMapper;
import ncsys.com.util.commoncd.service.model.CommonCd;

import org.springframework.stereotype.Service;


@Service("commonCdService")
public class CommonCdServiceImpl implements CommonCdService{

	@Resource(name="commonCdMapper")
	private CommonCdMapper commonCdMapper;

	@Override 
	public List<CommonCd> selectCommonCdList(CommonCd commonCd) throws Exception {
		return commonCdMapper.selectCommonCdList(commonCd );
	}
	
	
}
