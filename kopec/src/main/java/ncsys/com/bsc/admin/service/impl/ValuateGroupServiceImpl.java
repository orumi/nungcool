package ncsys.com.bsc.admin.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.admin.service.ValuateGroupService;
import ncsys.com.bsc.admin.service.mapper.ValuateGroupMapper;


@Service("valuateGroupService")
public class ValuateGroupServiceImpl implements ValuateGroupService{

	@Resource(name="valuateGroupMapper")
	private ValuateGroupMapper valuateGroupMapper;

	@Override
	public List<Map<String, Object>> selectValuate(Map<String, Object> map) throws Exception {
		return valuateGroupMapper.selectValuate(map);
	}

	@Override
	public List<Map<String, Object>> selectEvaler(Map<String, Object> map) throws Exception{

		return valuateGroupMapper.selectEvaler(map);
	}


	@Override
	public List<Map<String, Object>> adjustValuate(Map<String, Object> map) throws Exception{

		String grpid = (String)map.get("grpid");

		if(grpid==null || "".equals(grpid)){
			valuateGroupMapper.insertEvalGrp(map);
			valuateGroupMapper.insertEvalDept(map);
		}

		if(valuateGroupMapper.updateEvaler(map) < 1){
			valuateGroupMapper.insertEvaler(map);
		}

		return valuateGroupMapper.selectValuate(map);
	}

	@Override
	public List<Map<String, Object>> deleteValuate(Map<String, Object> map) throws Exception{

		valuateGroupMapper.deleteEvaler(map);

		return valuateGroupMapper.selectValuate(map);
	}



	public List<Map<String, Object>> selectOrgAddScore(Map<String, Object> map) throws Exception {

		return valuateGroupMapper.selectOrgAddScore(map);

	}

	public Map<String, Object> selectOrgAddScoreDetail(Map<String, Object> map) throws Exception {

		return valuateGroupMapper.selectOrgAddScoreDetail(map);

	}

	@Override
	public int adjustOrgAddScore(Map<String, Object> map) throws Exception {
		int reVal = 0;

		if( (reVal = valuateGroupMapper.updateOrgAddScore(map))<1 ){
			reVal = valuateGroupMapper.insertOrgAddScore(map);
		}
		return reVal;
	}


	@Override
	public int updateOrgAddScore(Map<String, Object> map) throws Exception {

		return valuateGroupMapper.updateOrgAddScore(map);
	}


	@Override
	public int insertOrgAddScore(Map<String, Object> map) throws Exception {

		return valuateGroupMapper.insertOrgAddScore(map);
	}


	@Override
	public int deleteOrgAddScore(Map<String, Object> map) throws Exception {
		return valuateGroupMapper.deleteOrgAddScore(map);
	}



}
