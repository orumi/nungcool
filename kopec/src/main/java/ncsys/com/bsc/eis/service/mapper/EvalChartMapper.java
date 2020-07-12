package ncsys.com.bsc.eis.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("evalChartMapper")
public interface EvalChartMapper {

	public List<Map<String, Object>> selectEvalOrgRst(HashMap<String, Object> param);


}
