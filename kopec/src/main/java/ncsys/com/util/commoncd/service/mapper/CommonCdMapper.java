package ncsys.com.util.commoncd.service.mapper;

import java.util.List;

import ncsys.com.util.commoncd.service.model.CommonCd;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("commonCdMapper")
public interface CommonCdMapper {

	public List<CommonCd> selectCommonCdList(CommonCd commonCd);

}
