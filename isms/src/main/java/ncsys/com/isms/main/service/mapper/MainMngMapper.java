package ncsys.com.isms.main.service.mapper;

import java.util.List;

import ncsys.com.isms.actual.service.model.ActualDetail;
import ncsys.com.isms.actual.service.model.ActualFile;
import ncsys.com.isms.actual.service.model.ActualList;
import ncsys.com.isms.main.service.model.RadarDetail;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mainMngMapper")
public interface MainMngMapper {
	
	public List<RadarDetail> selectRadar(RadarDetail radarDetail);
	
	
}
