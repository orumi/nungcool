package ncsys.com.bsc.analysis.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.analysis.service.MboPsnScoreService;
import ncsys.com.bsc.analysis.service.MeaRankService;
import ncsys.com.bsc.analysis.service.mapper.MboPsnScoreMapper;
import ncsys.com.bsc.analysis.service.mapper.MeaRankMapper;
import ncsys.com.bsc.scorecard.service.MapScoreService;
import ncsys.com.bsc.scorecard.service.mapper.MapScoreMapper;


@Service("mboPsnScoreService")
public class MboPsnScoreServiceImpl implements MboPsnScoreService{

	@Resource(name="mboPsnScoreMapper")
	private MboPsnScoreMapper mboPsnScoreMapper;


	@Override
	public List<Map<String, Object>> selectInitCon(HashMap<String, Object> param) throws Exception {
		return mboPsnScoreMapper.selectInitCon(param);
	}

	@Override
	public List<Map<String, Object>> selectPsnRoot(HashMap<String, Object> param) throws Exception {

		List<Map<String, Object>> psnRoot = mboPsnScoreMapper.selectPsnRoot(param);

		for (Map<String, Object> map : psnRoot) {
			List<Map<String, Object>> items = new ArrayList<>();

			String strVal = map.get("empNo")+"|"+map.get("inSeq")+"|"+map.get("inRev")+"|"+map.get("ANo");
			HashMap<String, Object> item = new HashMap<>();
			item.put("value", strVal);
			item.put("label", "Loading...");

			items.add(item);
			map.put("items", items);
			map.put("value", strVal);
			map.put("icon", "../../resource/jqwidgets/images/folder.png");
		}



		return psnRoot;
	}

	@Override
	public List<Map<String, Object>> selectPsnTreeList(HashMap<String, Object> param) throws Exception {

		List<Map<String, Object>> psnList = mboPsnScoreMapper.selectPsnTreeList(param);

		for (Map<String, Object> map : psnList) {
            /* for to select children */

			String strVal = map.get("empNo")+"|"+map.get("inSeq")+"|"+map.get("inRev")+"|"+map.get("ANo");
			map.put("value", strVal);
			if("Y".equals(map.get("child"))){
				List<Map<String, Object>> items = new ArrayList<>();

				HashMap<String, Object> item = new HashMap<>();
				item.put("value", strVal);
				item.put("label", "Loading...");

				items.add(item);
				map.put("items", items);

				map.put("icon", "../../resource/jqwidgets/images/folder.png");
			} else {

				map.put("icon", "../../resource/jqwidgets/images/notesIcon.png");
			}
		}


		return psnList;
	}


	@Override
	public List<Map<String, Object>> selectAccoutList(HashMap<String, Object> param) throws Exception {
		return mboPsnScoreMapper.selectAccoutList(param);
	}

	@Override
	public List<Map<String, Object>> selectAccoutDetail(HashMap<String, Object> param) throws Exception {
		return mboPsnScoreMapper.selectAccoutDetail(param);
	}





	@Override
	public List<Map<String, Object>> selectTargetRoot(HashMap<String, Object> param) throws Exception {
		List<Map<String, Object>> targetRoot = mboPsnScoreMapper.selectTargetRoot(param);

		for (Map<String, Object> map : targetRoot) {
			List<Map<String, Object>> items = new ArrayList<>();

			String strVal = map.get("empNo")+"|"+map.get("inSeq")+"|"+map.get("inRev")+"|"+map.get("ANo")+"|"+map.get("ONo");
			HashMap<String, Object> item = new HashMap<>();
			item.put("value", strVal);
			item.put("label", "Loading...");

			items.add(item);
			map.put("items", items);
			map.put("value", strVal);
			map.put("icon", "../../resource/jqwidgets/images/folder.png");
		}



		return targetRoot;
	}

	@Override
	public List<Map<String, Object>> selectTargetList(HashMap<String, Object> param) throws Exception {
		List<Map<String, Object>> targetList = mboPsnScoreMapper.selectTargetList(param);

		for (Map<String, Object> map : targetList) {
            /* for to select children */

			String strVal = map.get("empNo")+"|"+map.get("inSeq")+"|"+map.get("inRev")+"|"+map.get("ANo")+"|"+map.get("ONo");
			map.put("value", strVal);
			if("Y".equals(map.get("child"))){
				List<Map<String, Object>> items = new ArrayList<>();

				HashMap<String, Object> item = new HashMap<>();
				item.put("value", strVal);
				item.put("label", "Loading...");

				items.add(item);
				map.put("items", items);

				map.put("icon", "../../resource/jqwidgets/images/folder.png");
			} else {

				map.put("icon", "../../resource/jqwidgets/images/notesIcon.png");
			}
		}


		return targetList;
	}

	@Override
	public List<Map<String, Object>> selectTargetDetail(HashMap<String, Object> param) throws Exception {
		return mboPsnScoreMapper.selectTargetDetail(param);
	}



}
