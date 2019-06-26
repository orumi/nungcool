package ncsys.com.isms.weekTest.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import ncsys.com.isms.asset.service.AssetService;
import ncsys.com.isms.asset.service.mapper.AssetMapper;
import ncsys.com.isms.asset.service.model.Asset;
import ncsys.com.isms.asset.service.model.AssetGroup;
import ncsys.com.isms.asset.service.model.AssetGroupList;
import ncsys.com.isms.asset.service.model.AssetGrpCnt;
import ncsys.com.isms.asset.service.model.AssetKind;
import ncsys.com.isms.asset.service.model.AssetVersion;
import ncsys.com.isms.weekTest.service.WeekTestRstService;
import ncsys.com.isms.weekTest.service.WeekTestService;
import ncsys.com.isms.weekTest.service.mapper.WeekTestMapper;
import ncsys.com.isms.weekTest.service.mapper.WeekTestRstMapper;
import ncsys.com.isms.weekTest.service.model.WeekTestAstRst;
import ncsys.com.isms.weekTest.service.model.WeekTestField;
import ncsys.com.isms.weekTest.service.model.WeekTestFieldRst;
import ncsys.com.isms.weekTest.service.model.WeekTestItem;
import ncsys.com.isms.weekTest.service.model.WeekTestItemList;

import org.springframework.stereotype.Service;


@Service("weekTestRstService")
public class WeekTestRstServiceImpl implements WeekTestRstService    {

	@Resource(name="weekTestRstMapper")
	private WeekTestRstMapper weekTestRstMapper;

	@Override
	public List<WeekTestAstRst> selectWeekTestAstRst(String astverid) throws Exception {
		return weekTestRstMapper.selectWeekTestAstRst(astverid);
	}

	@Override
	public List<WeekTestFieldRst> selectWeekTestFieldRst(String astverid) throws Exception {
		return weekTestRstMapper.selectWeekTestFieldRst(astverid);
	}
	
	@Override
	public HashMap<String, String> selectWeekTestFieldSumRst(String astverid) throws Exception {
		
		List<WeekTestFieldRst> reWeekTestFieldRst= weekTestRstMapper.selectWeekTestFieldSumRst(astverid);
		HashMap<String, String> rowMap =  new HashMap<>();
		rowMap.put("astgrpnm", "합계");
		
		for (int i = 0; i < reWeekTestFieldRst.size(); i++) {
			WeekTestFieldRst rst = reWeekTestFieldRst.get(i);
			rowMap.put(rst.getFieldcd(), rst.getTstavg());
		}
		
		return rowMap;
	}
	
	@Override
	public ArrayList<HashMap<String, String>> selectWeekTestFieldRstCrossTab(String astverid) throws Exception {
		
		List<WeekTestFieldRst> reWeekTestFieldRst = this.selectWeekTestFieldRst(astverid);
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		
		HashMap<String, String> rowMap = null;
		
		String astgrpid = null;
		for (int i = 0; i < reWeekTestFieldRst.size(); i++) {
			WeekTestFieldRst rst = reWeekTestFieldRst.get(i);
			
			if(!rst.getAstgrpid().equals(astgrpid)){
				if(rowMap!=null) list.add(rowMap);
				rowMap = new HashMap<>();
				rowMap.put("astgrpnm", rst.getAstgrpnm());
				astgrpid = rst.getAstgrpid();
			}
			rowMap.put(rst.getFieldcd(), rst.getTstavg());
		}
		if(rowMap!=null) list.add(rowMap);
		
		return list;
	}
}
