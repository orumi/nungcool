package ncsys.com.bsc.eis.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface EvalChartService {

	public List<Map<String, Object>> selectEvalOrgRst(HashMap<String, Object> param) throws Exception;
}

