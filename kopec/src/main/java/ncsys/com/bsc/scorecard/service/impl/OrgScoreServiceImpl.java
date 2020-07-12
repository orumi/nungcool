package ncsys.com.bsc.scorecard.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.admin.service.AppConfigService;
import ncsys.com.bsc.admin.service.mapper.AppConfigMapper;
import ncsys.com.bsc.scorecard.service.OrgScoreService;
import ncsys.com.bsc.scorecard.service.mapper.OrgScoreMapper;


@Service("orgScoreService")
public class OrgScoreServiceImpl implements OrgScoreService{

	@Resource(name="orgScoreMapper")
	private OrgScoreMapper orgScoreMapper;

	@Override
	public List<Map<String, Object>> selectConfig() throws Exception {
		return orgScoreMapper.selectConfig();
	}

	@Override
	public List<Map<String, Object>> selectSbuBsc(Map<String, Object> map) throws Exception{
		return orgScoreMapper.selectSbuBsc(map);
	}

	@Override
	public List<Map<String, Object>> selectState(Map<String, Object> map) throws Exception{
		return orgScoreMapper.selectState(map);
	}

	@Override
	public List<Map<String, Object>> selectOrgScore(Map<String, Object> map) throws Exception{
		return orgScoreMapper.selectOrgScore(map);
	}

	@Override
	public List<Map<String, Object>> selectMeasureActual(Map<String, Object> map) throws Exception{
		return orgScoreMapper.selectMeasureActual(map);
	}

	@Override
	public List<Map<String, Object>> selectItemActual(Map<String, Object> map) throws Exception{
		return orgScoreMapper.selectItemActual(map);
	}

	@Override
	public List<Map<String, Object>> selectItemActuals(Map<String, Object> map) throws Exception{
		return orgScoreMapper.selectItemActuals(map);
	}

}
