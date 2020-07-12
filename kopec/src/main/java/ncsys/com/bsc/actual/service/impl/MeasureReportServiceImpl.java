package ncsys.com.bsc.actual.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ncsys.com.bsc.actual.service.MeasureReportService;
import ncsys.com.bsc.actual.service.mapper.MeasureReportMapper;


@Service("measureReportService")
public class MeasureReportServiceImpl implements MeasureReportService{

	@Resource(name="measureReportMapper")
	private MeasureReportMapper measureReportMapper;



	@Override
	public List<Map<String, Object>> selectMeasureQty(HashMap<String, Object> param) throws Exception {
		return measureReportMapper.selectMeasureQty(param);
	}

	@Override
	public List<Map<String, Object>> selectMeasureQly(HashMap<String, Object> param) throws Exception {
		return measureReportMapper.selectMeasureQly(param);
	}



	public List<Map<String, Object>> selectMeasureStatus(HashMap<String, Object> param) throws Exception {

		if("1".equals(param.get("type"))){
			return measureReportMapper.selectMeasureStatusCnt(param);
		} else {
			return measureReportMapper.selectMeasureStatusWgt(param);
		}


	}
}
