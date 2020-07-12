package ncsys.com.bsc.eis.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("evalMngMapper")
public interface EvalMngMapper {

	public List<Map<String, Object>> selectOrgCd(HashMap<String, Object> param);
	public List<Map<String, Object>> selectMeasDivCd(HashMap<String, Object> param);
	public List<Map<String, Object>> selectMeasGrpCd(HashMap<String, Object> param);
	public List<Map<String, Object>> selectMeasCd(HashMap<String, Object> param);

	public List<Map<String, Object>> selectMeasList(HashMap<String, Object> param);

	public List<Map<String, Object>> selectOrgList(HashMap<String, Object> param);

	public int insertOrgMeas(HashMap<String, Object> param);
	public int updateOrgMeas(HashMap<String, Object> param);
	public int deleteOrgMeas(HashMap<String, Object> param);

	public int insertMeasComCd(HashMap<String, Object> param);


	public int deleteEvalOrg(HashMap<String, Object> param);
	public int insertEvalOrg(HashMap<String, Object> param);
	public int deleteEvalOrgMeas(HashMap<String, Object> param);
	public int insertEvalOrgMeas(HashMap<String, Object> param);

	public int deleteEvalOrgMeasByOrgCd(HashMap<String, Object> param);
	public int insertEvalOrgMeasByOrgCd(HashMap<String, Object> param);

	public List<Map<String, Object>> selectEvalOrgRst(HashMap<String, Object> param);
	public int insertEvalOrgRst(HashMap<String, Object> param);
	public int updateEvalOrgRst(HashMap<String, Object> param);
	public int deleteEvalOrgRst(HashMap<String, Object> param);


	public int updateEvalMeasRst(HashMap<String, Object> param);

}
