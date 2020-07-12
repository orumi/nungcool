package ncsys.com.bsc.valuate.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ValuateViewService {

	public List<Map<String, Object>> selectEvalGrp(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectEvalView(HashMap<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectQlyComment(HashMap<String, Object> param) throws Exception;
	public List<Map<String, Object>> selectQlyCommentDetail(HashMap<String, Object> param) throws Exception;




}

