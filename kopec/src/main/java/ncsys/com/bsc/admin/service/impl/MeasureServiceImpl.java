package ncsys.com.bsc.admin.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import ncsys.com.bsc.admin.service.MeasureService;
import ncsys.com.bsc.admin.service.mapper.MeasureMapper;
import ncsys.com.bsc.admin.service.model.Component;
import ncsys.com.bsc.admin.service.model.HierarchyNode;
import ncsys.com.bsc.admin.service.model.Item;
import ncsys.com.bsc.admin.service.model.MeasureDefine;
import ncsys.com.bsc.admin.service.model.MeasureDetail;
import ncsys.com.bsc.admin.service.model.MeasureList;
import ncsys.com.bsc.admin.service.model.MeasureUser;
import ncsys.com.bsc.admin.service.model.TreeScoreTree;


@Service("MeasureService")
public class MeasureServiceImpl implements MeasureService{

	@Resource(name="MeasureMapper")
	private MeasureMapper measureMapper;

	@Override
	public List<MeasureList> selectMeasureList(MeasureList measureList) throws Exception {
		return measureMapper.selectMeasureList(measureList);
	}

	@Override
	public List<Component> selectPst() throws Exception {
		return measureMapper.selectPst();
	}

	@Override
	public List<Component> selectObject() throws Exception{
		return measureMapper.selectObject();
	}

	@Override
	public List<Component> selectMeasure() throws Exception{
		return measureMapper.selectMeasure();
	}




	@Override
	public TreeScoreTree selectTreeScoreByContentid(TreeScoreTree  treeScoreTree) throws Exception{

		return measureMapper.selectTreeScoreByContentid(treeScoreTree);

	}

	@Override
	public List<MeasureUser> selectMeasureUserS() throws Exception{
		return measureMapper.selectMeasureUserS();
	}

	@Override
	public List<Item> selectMeasureItems(MeasureDefine measureDefine) throws Exception{
		return measureMapper.selectMeasureItems(measureDefine);
	}

	@Override
	public List<MeasureUser> selectMeasureUpdaters(MeasureDefine measureDefine) throws Exception{
		return measureMapper.selectMeasureUpdaters(measureDefine);
	}


	@Override
	public int adjustMeasure(MeasureDefine measureDefine) throws Exception{
		int reVal = 0;

		if("update".equals(measureDefine.getMode()) ){
			measureMapper.updateMeasureDefine(measureDefine);

			/*equation item*/
			measureMapper.deleteMeasureItems(measureDefine);

			ArrayList<Item> items = measureDefine.getItems();
			for (int i = 0; i < items.size(); i++) {
				Item aItem = items.get(i);
				aItem.setMeasureid(measureDefine.getId());

				measureMapper.insertMeasureItem(aItem);

			}

			measureMapper.deleteMeasureAuthority(measureDefine);
			ArrayList<MeasureUser> measureUsers = measureDefine.getAuthority();

			for (int i = 0; i < measureUsers.size(); i++) {
				MeasureUser aMeasureUser = measureUsers.get(i);
				aMeasureUser.setYear(measureDefine.getYear());
				aMeasureUser.setMeasureid(measureDefine.getId());

				measureMapper.insertMeasureAuthority(aMeasureUser);
			}


			/* authority */
		} else {


			/* perspective */
			HierarchyNode pstNode = new HierarchyNode();
			pstNode.setContentid(measureDefine.getPcid());
			pstNode.setParentid(measureDefine.getBid());
			pstNode.setYear(measureDefine.getYear());
			pstNode.setTreelevel("3");

			HierarchyNode pNode = measureMapper.selectTreeScoreByParentid(pstNode);
			if(pNode != null){
				pstNode.setId(pNode.getId());
			} else {
				measureMapper.insertTreeScore(pstNode);
			}

			/* objective */
			HierarchyNode objNode = new HierarchyNode();
			objNode.setContentid(measureDefine.getOcid());
			objNode.setParentid(pstNode.getId());
			objNode.setYear(measureDefine.getYear());
			objNode.setTreelevel("4");

			HierarchyNode oNode = measureMapper.selectTreeScoreByParentid(objNode);
			if(oNode != null){
				objNode.setId(oNode.getId());
			} else {
				measureMapper.insertTreeScore(objNode);
			}


			/* insert into measuredefine */
			measureMapper.insertMeasureDefine(measureDefine);

			/*equation item*/
			measureMapper.deleteMeasureItems(measureDefine);

			ArrayList<Item> items = measureDefine.getItems();
			for (int i = 0; i < items.size(); i++) {
				Item aItem = items.get(i);
				aItem.setMeasureid(measureDefine.getId());

				measureMapper.insertMeasureItem(aItem);

			}

			measureMapper.deleteMeasureAuthority(measureDefine);
			ArrayList<MeasureUser> measureUsers = measureDefine.getAuthority();

			for (int i = 0; i < measureUsers.size(); i++) {
				MeasureUser aMeasureUser = measureUsers.get(i);
				aMeasureUser.setYear(measureDefine.getYear());
				aMeasureUser.setMeasureid(measureDefine.getId());

				measureMapper.insertMeasureAuthority(aMeasureUser);
			}


			/* measure */
			HierarchyNode MeaNode = new HierarchyNode();
			MeaNode.setContentid(measureDefine.getId());
			MeaNode.setParentid(objNode.getId());
			MeaNode.setYear(measureDefine.getYear());
			MeaNode.setTreelevel("5");

			HierarchyNode mNode = measureMapper.selectTreeScoreByParentid(MeaNode);
			if(mNode != null){
				MeaNode.setId(mNode.getId());
			} else {
				measureMapper.insertTreeScore(MeaNode);
			}
		}



		_setMeasDetailValue(measureDefine);



		return reVal;
	}

	/* 목표 자동 등록 */
	private int _setMeasDetailValue(MeasureDefine measureDefine) {
        /* 주기별 목표 목록 가져오기 */

		List<MeasureDetail> measureDetail = measureMapper.selectMeasurePlanned(measureDefine);

		List<String> months = new ArrayList<>();
		MeasureDetail dtl = null;
		for (MeasureDetail detail : measureDetail) {
			if(measureMapper.updateMeasureDetail(detail)<1){
				measureMapper.insertMeasureDetail(detail);
			}
			months.add(detail.getYm().substring(4,6));
			if(dtl == null) dtl = detail;
		}

		dtl.setMonths(months);

		measureMapper.deleteMeasureDetailClear(dtl);


		return 0;
	}




	public int deleteMeasure(MeasureDefine measureDefine) throws Exception {
		int reVal = 0;
        /* delete authority
         * delete item
         * delete treesocre
         * delete measuredefine
		*/

		measureMapper.deleteMeasureAuthority(measureDefine);

		measureMapper.deleteMeasureItems(measureDefine);

		measureMapper.deleteTreeMeasure(measureDefine);

		measureMapper.deleteMeasureDefine(measureDefine);

		measureMapper.clearTreescoreObject(measureDefine);
		measureMapper.clearTreescorePst(measureDefine);



		return reVal;
	}


	public MeasureDefine selectMeasureDefine(MeasureDefine measureDefine) throws Exception{
		return measureMapper.selectMeasureDefine(measureDefine);
	}


	public Map<String, Object> selectMeasureId(Map<String, Object> param) throws Exception {
		return measureMapper.selectMeasureId(param);
	}
}
