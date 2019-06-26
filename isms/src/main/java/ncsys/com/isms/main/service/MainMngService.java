package ncsys.com.isms.main.service;

import java.util.List;

import ncsys.com.isms.main.service.model.RadarDetail;


public interface MainMngService {

	public List<RadarDetail> selectRadar(RadarDetail radarDetail) throws Exception;
	
}
