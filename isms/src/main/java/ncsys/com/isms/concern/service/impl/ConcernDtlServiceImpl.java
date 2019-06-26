package ncsys.com.isms.concern.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.concern.service.ConcernDtlService;
import ncsys.com.isms.concern.service.mapper.ConcernDtlMapper;
import ncsys.com.isms.concern.service.model.ConcernDtlAsset;
import ncsys.com.isms.concern.service.model.ConcernDtlDetail;

import org.springframework.stereotype.Service;


@Service("concernDtlService")
public class ConcernDtlServiceImpl implements ConcernDtlService{

	@Resource(name="concernDtlMapper")
	private ConcernDtlMapper concernDtlMapper;

	@Override
	public List<ConcernDtlAsset> selectConcernDtlAsset(ConcernDtlAsset concernDtlAsset) throws Exception {
		return concernDtlMapper.selectConcernDtlAsset(concernDtlAsset);
	}

	@Override
	public List<ConcernDtlDetail> selectConcernDtlDetail(ConcernDtlDetail concernDtlDetail) throws Exception {
		return concernDtlMapper.selectConcernDtlDetail(concernDtlDetail);
	}
	
	@Override
	public int deleteConcernDtl(ConcernDtlDetail concernDtlDetail) throws Exception{
		return concernDtlMapper.deleteConcernDtl(concernDtlDetail);
	}
	
	@Override
	public int insertConcernDtl(ConcernDtlDetail concernDtlDetail) throws Exception{
		return concernDtlMapper.insertConcernDtl(concernDtlDetail);
	}
	
	@Override
	public int updateConcernDtlDetail(ConcernDtlDetail concernDtlDetail) throws Exception{
		return concernDtlMapper.updateConcernDtlDetail(concernDtlDetail);
	}
	
	
	@Override
	public ConcernDtlDetail selectConcernDetail(ConcernDtlDetail concernDtlDetail) throws Exception{
		return concernDtlMapper.selectConcernDetail(concernDtlDetail);
	}

}
