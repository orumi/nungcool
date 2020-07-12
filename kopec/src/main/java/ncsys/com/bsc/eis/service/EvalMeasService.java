package ncsys.com.bsc.eis.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface EvalMeasService {

	public List<Map<String, Object>> selectEvalMeaRst(HashMap<String, Object> param) throws Exception;
	//selectEvalMeasQtyRst
	public List<Map<String, Object>> selectEvalMeasQtyRst(HashMap<String, Object> param) throws Exception;
}

