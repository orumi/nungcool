package ncsys.com.isms.main.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import ncsys.com.isms.main.service.MainMngService;
import ncsys.com.isms.main.service.mapper.MainMngMapper;
import ncsys.com.isms.main.service.model.RadarDetail;


@Service("mainMngService")
public class MainMngServiceImpl implements MainMngService{

	@Resource(name="mainMngMapper")
	private MainMngMapper mainMngMapper;

	@Override
	public List<RadarDetail> selectRadar(RadarDetail radarDetail) throws Exception {
		return mainMngMapper.selectRadar(radarDetail);
	}
		
}
