package ncsys.com.isms.certification.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import ncsys.com.isms.certification.service.CertiService;
import ncsys.com.isms.certification.service.mapper.CertiMapper;
import ncsys.com.isms.certification.service.model.CertiDetail;
import ncsys.com.isms.certification.service.model.CertiList;


@Service("certiService")
public class CertiServiceImpl implements CertiService{

	@Resource(name="certiMapper")
	private CertiMapper certiMapper;

	@Override
	public List<CertiList> selectCertiList(CertiList certiList) throws Exception {
		return certiMapper.selectCertiList(certiList );
	}
	
	
	@Override
	public void insertCertiDetail(CertiDetail certiDetail) throws Exception{
		certiMapper.insertCertiDetail(certiDetail);
		
	}
	@Override
	public void updateCertiDetail(CertiDetail certiDetail) throws Exception{
		certiMapper.updateCertiDetail(certiDetail);
		
	}
	@Override
	public void deleteCertiDetail(CertiDetail certiDetail) throws Exception{
		certiMapper.deleteCertiDetail(certiDetail);
		
	}
	@Override
	public CertiDetail selectCertiDetail(CertiDetail certiDetail) throws Exception {
		return certiMapper.selectCertiDetail(certiDetail );
	}
	
	@Override
	public CertiDetail selectCertiDetailByName(CertiDetail certiDetail) throws Exception {
		return certiMapper.selectCertiDetailByName(certiDetail);
	}
	
}
