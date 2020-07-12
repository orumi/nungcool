package ncsys.com.bsc.admin.service.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("PerformMapper")
public interface PerformMapper {

	public List<Map<String, Object>> selectPsnBaseLine(Map<String, Object> map);

	public int insertPsnBaseLine(Map<String, Object> map);
	public int updatePsnBaseLine(Map<String, Object> map);


	public List<Map<String, Object>> selectPsnJikgub(Map<String, Object> map);

	public int deletePsnJikgub(Map<String, Object> map);
	public int insertPsnJikgub(Map<String, Object> map);

	public int  deletePsnBaseLine(Map<String, Object> map);

	public int deletePsnBizMh(Map<String, Object> map);
	public int deletePsnBscScore(Map<String, Object> map);
	public int deletePsnScore(Map<String, Object> map);


	public List<Map<String, Object>> selectPsnSubMapping(Map<String, Object> map);
	public List<Map<String, Object>> selectPsnBscMapping(Map<String, Object> map);
	public int deletePsnSubMapping(Map<String, Object> map);
	public int insertPsnSubMapping(Map<String, Object> map);



	/* psn except */

	public List<Map<String, Object>> selectSbuGroup(Map<String, Object> map);
	public List<Map<String, Object>> selectExceptBsc(Map<String, Object> map);
	public List<Map<String, Object>> selectPsnEmp(Map<String, Object> map);
	public List<Map<String, Object>> selectPsnExceptEmp(Map<String, Object> map);

	public int resetPsnExceptEmpbySbu(Map<String, Object> map);
	public int deletePsnExceptEmp(Map<String, Object> map);
	public int insertPsnExceptEmp(Map<String, Object> map);


	public List<Map<String, Object>> selectPsnLabor(Map<String, Object> map);
	public int deletePsnLabor(Map<String, Object> map);
	public int insertPsnLabor(Map<String, Object> map);


	/* psn grade */

	public List<Map<String, Object>> selectPsnGradeBase(Map<String, Object> map);
	public int deletePsnGradeBase(Map<String, Object> map);
	public int insertPsnGradeBase(Map<String, Object> map);

	/* psg bsc grade */
	public List<Map<String, Object>> selectPsnBscGrade(Map<String, Object> map);

    /* psnBizMh */
	public List<Map<String, Object>> selectPsnBizMh(Map<String, Object> map);

	public List<Map<String, Object>> selectPsnScore(Map<String, Object> map);
	public List<Map<String, Object>> selectPsnScoreList(Map<String, Object> map);



}
