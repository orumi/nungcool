package ncsys.com.isms.analysisConcern.service.impl;

import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.analysisConcern.service.AnalysisVerService;
import ncsys.com.isms.analysisConcern.service.mapper.AnalysisVerMapper;
import ncsys.com.isms.analysisConcern.service.model.AnalysisVer;
import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.mapper.AssetMapper;
import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.asset.service.model.AssetGroup;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetGrpCnt;
import ncsys.com.isms.asset.service.model.AssetKind;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.mapper.WeekTestMapper;
import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;

import org.springframework.stereotype.Service;


@Service("analysisVerService")
public class AnalysisVerServiceImpl implements AnalysisVerService{

	@Resource(name="analysisVerMapper")
	private AnalysisVerMapper analysisVerMapper;

	@Override
	public List<AnalysisVer> selectAnalysisVerList() throws Exception {
		return analysisVerMapper.selectAnalysisVerList();
	}

	@Override
	public AnalysisVer selectAnalysisVer(AnalysisVer analysisVer) throws Exception {
		return analysisVerMapper.selectAnalysisVer(analysisVer);
	}

	@Override
	public int insertAnalysisVer(AnalysisVer analysisVer) throws Exception {
		return analysisVerMapper.insertAnalysisVer(analysisVer);
	}

	@Override
	public int updateAnalysisVer(AnalysisVer analysisVer) throws Exception {
		return analysisVerMapper.updateAnalysisVer(analysisVer);
	}

	@Override
	public int deleteAnalysisVer(AnalysisVer analysisVer) throws Exception {
		return analysisVerMapper.deleteAnalysisVer(analysisVer);
	}

	
	
}
