package ncsys.com.isms.concern.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.concern.service.CriteriaItemService;
import ncsys.com.isms.concern.service.mapper.CriteriaItemMapper;
import ncsys.com.isms.concern.service.model.CriteriaItem;
import ncsys.com.isms.concern.service.model.CriteriaVersion;

import org.springframework.stereotype.Service;


@Service("criteriaItemService")
public class CriteriaItemServiceImpl implements CriteriaItemService{

	@Resource(name="criteriaItemMapper")
	private CriteriaItemMapper criteriaItemMapper;

	
	@Override
	public List<CriteriaVersion> selectCriteriaVersion() throws Exception{
		return criteriaItemMapper.selectCriteriaVersion();
	}
	@Override
	public int insertCriteriaVersion(CriteriaVersion criteriaVersion) throws Exception{
		return criteriaItemMapper.insertCriteriaVersion(criteriaVersion);
	}
	@Override
	public int updateCriteriaVersion(CriteriaVersion criteriaVersion) throws Exception{
		return criteriaItemMapper.updateCriteriaVersion(criteriaVersion);
	}
	@Override
	public int deleteCriteriaVersion(CriteriaVersion criteriaVersion) throws Exception{
		return criteriaItemMapper.deleteCriteriaVersion(criteriaVersion);
	}
	@Override
	public CriteriaVersion selectCriteriaVersionByName(CriteriaVersion criteriaVersion) throws Exception{
		return criteriaItemMapper.selectCriteriaVersionByName(criteriaVersion);
	}
	
	@Override
    public List<CriteriaItem> selectCriteriaItem(CriteriaItem criteriaItem) throws Exception{
    	return criteriaItemMapper.selectCriteriaItem(criteriaItem);
    }
	@Override
	public int insertCriteriaItem(CriteriaItem criteriaItem) throws Exception{
		return criteriaItemMapper.insertCriteriaItem(criteriaItem);
	}
	@Override
	public int updateCriteriaItem(CriteriaItem criteriaItem) throws Exception{
		return criteriaItemMapper.updateCriteriaItem(criteriaItem);
	}
	@Override
	public int deleteCriteriaItem(CriteriaItem criteriaItem) throws Exception{
		return criteriaItemMapper.deleteCriteriaItem(criteriaItem);
	}
	
	@Override
	public CriteriaItem selectCriteriaItemDetail(CriteriaItem criteriaItem) throws Exception {
		return criteriaItemMapper.selectCriteriaItemDetail(criteriaItem);
	}

}
