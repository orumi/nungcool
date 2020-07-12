package ncsys.com.bsc.admin.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.admin.service.PsnEmpScoreService;
import ncsys.com.bsc.admin.service.mapper.PsnEmpScoreMapper;


@Service("psnEmpScoreService")
public class PsnEmpScoreServiceImpl implements PsnEmpScoreService{

	@Resource(name="psnEmpScoreMapper")
	private PsnEmpScoreMapper psnEmpScoreMapper;

	@Override
	public List<Map<String, Object>> selectEmp(Map<String, Object> map) throws Exception {
		return psnEmpScoreMapper.selectEmp(map);
	}

	@Override
	public List<Map<String, Object>> selectPeriod(Map<String, Object> map) throws Exception{

		return psnEmpScoreMapper.selectPeriod(map);
	}

	@Override
	public List<Map<String, Object>> selectPsnLabor(Map<String, Object> map) throws Exception{

		return psnEmpScoreMapper.selectPsnLabor(map);
	}

	@Override
	public List<Map<String, Object>> selectPsnScore(Map<String, Object> map) throws Exception{

		return psnEmpScoreMapper.selectPsnScore(map);
	}

	@Override
	public List<Map<String, Object>> selectPsnBizmh(Map<String, Object> map) throws Exception{

		return psnEmpScoreMapper.selectPsnBizmh(map);
	}


}
