package ncsys.com.bsc.valuate.service.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("valuateViewMapper")
public interface ValuateViewMapper {

	public List<Map<String, Object>> selectEvalGrp(Map<String, Object> map);
	public List<Map<String, Object>> selectEvalView(Map<String, Object> map);

	public List<Map<String, Object>> selectQlyComment(Map<String, Object> map);
	public List<Map<String, Object>> selectQlyCommentDetail(Map<String, Object> map);


}
