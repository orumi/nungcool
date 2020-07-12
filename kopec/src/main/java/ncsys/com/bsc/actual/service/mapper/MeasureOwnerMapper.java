package ncsys.com.bsc.actual.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("measureOwnerMapper")
public interface MeasureOwnerMapper {

	public List<Map<String, Object>> selectSBU(HashMap<String, Object> param);
	public List<Map<String, Object>> selectMeasureList(HashMap<String, Object> param);

	public List<Map<String, Object>> selectMeasureOwner(HashMap<String, Object> param);
	public List<Map<String, Object>> selectUserList(HashMap<String, Object> param);


	public int deleteAuthoritybyMeasure(HashMap<String, Object> param);
	public int insertAuthority(HashMap<String, Object> param);
	public int updateMeasureUpdater(HashMap<String, Object> param);


	public int insertAuthorityWithTo(HashMap<String, Object> param);
	public int deleteAthorityWithTo(HashMap<String, Object> param);
	public int updateUpdaterWithTo(HashMap<String, Object> param);



}
