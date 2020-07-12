package com.nc.totEval;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EstScrManager {
	public ArrayList companys;
	public ArrayList measures;
	
	public EstScrManager(){
		companys = new ArrayList();
		measures = new ArrayList();
	}
	
	public void setMeasure(ResultSet rs) throws SQLException{
		EstMeasure mea = new EstMeasure();
		mea.id = rs.getInt("MID");
		mea.section=rs.getString("SNAME");
		mea.bscDivision = rs.getString("BNAME");
		mea.allot = rs.getDouble("ALLOT");
		mea.name = rs.getString("MNAME");
		
		measures.add(mea);
	}
	
	public void setCompany(ResultSet rs) throws SQLException {
		EstCompany com = new EstCompany();
		com.id = rs.getInt("ID");
		com.name = rs.getString("NAME");
		
		companys.add(com);
	}
	
	public void setScore(ResultSet rs) throws SQLException {
		/*
		 * 1. 해당 지표를 가져온다.
		 * 2. detail를 생성한다.
		 * 3. 해당 지표에 등록한다.
		 */
		EstMeasure mea = getMeasure(rs.getInt("MID"));
		if (mea==null) return;
		EstCompany com = getCompany(rs.getInt("COMID"));
		if (com==null) return;
		
		EstScore src = new EstScore();
		src.mid = mea.id;
		src.comId = com.id;
		src.score = rs.getDouble("SCORE");
		src.avg = rs.getDouble("AVG");
		src.diff = rs.getDouble("DIFFER");
		src.rankB = rs.getInt("RANK");
		src.rankB1 = rs.getInt("B1RANK");
		src.rankB2 = rs.getInt("B2RANK");
		src.rankB3 = rs.getInt("B3RANK");
		src.allotAvg = rs.getDouble("ALLOTAVG");
		src.allotDiff = rs.getDouble("ALLOTDIFFER");
		
		mea.setScore(com,src);
		
	}
	
	public EstMeasure getMeasure(int mid){
		for (int i = 0; i < measures.size(); i++) {
			EstMeasure tmp = (EstMeasure)measures.get(i);
			if (tmp.id==mid) return tmp;
		}
		return null;
	}
	
	public EstCompany getCompany(int cid){
		for (int i = 0; i < companys.size(); i++) {
			EstCompany com = (EstCompany)companys.get(i);
			if (com.id==cid) return com;
		}
		return null;
	}
	
	public EstCompany[] getCompanys(){
		EstCompany[] coms = new EstCompany[companys.size()];
		
		for (int i = 0; i < companys.size(); i++) {
			EstCompany com = (EstCompany)companys.get(i);
			coms[i]=com;
		}
		return coms;
	}
}
