package ncsys.com.bsc.eis.service.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("evalMeasMapper")
public interface EvalMeasMapper {

	public List<Map<String, Object>> selectEvalMeaRst(HashMap<String, Object> param);

	public List<Map<String, Object>> selectEvalMeasQtyRst(HashMap<String, Object> param);


}
