package com.nc.totEval;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EstManager {
	public ArrayList divisions;
	public ArrayList measures;
	
	public EstManager(){
		divisions = new ArrayList();
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
	
	public void setMeasureDetail(ResultSet rs) throws SQLException{
		EstMeasureDetail mea = new EstMeasureDetail();
		mea.id = rs.getInt("MID");
		mea.section=rs.getString("SNAME");
		mea.bscDivision = rs.getString("BNAME");
		mea.allot = rs.getDouble("ALLOT");
		mea.name = rs.getString("MNAME");
		
		mea.score = rs.getDouble("SCORE");
		mea.rank = rs.getInt("RANK");
		mea.avg = rs.getDouble("AVG");
		mea.allotAvg = rs.getDouble("ALLOTAVG");
		mea.differ = rs.getDouble("DIFFER");
		mea.allotDiffer = rs.getDouble("ALLOTDIFFER");
		
		measures.add(mea);
	}
	
	public void setDivision(ResultSet rs) throws SQLException {
		Division div = new Division();
		div.id = rs.getInt("ID");
		div.name = rs.getString("NAME");
		
		divisions.add(div);
	}
	
	public void setDetails(ResultSet rs) throws SQLException {
		/*
		 * 1. 해당 지표를 가져온다.
		 * 2. detail를 생성한다.
		 * 3. 해당 지표에 등록한다.
		 */
		EstMeasure mea = getMeasure(rs.getInt("MID"));
		if (mea==null) return;
		Division div = getDivision(rs.getInt("DIVISIONID"));
		if (div==null) return;
		
		EstDetail detail = new EstDetail();
		detail.meaId = mea.id;
		detail.divId = div.id;
		detail.allot = rs.getDouble("ALLOT");
		
		mea.setDetails(div,detail);
		
	}
	
	public void setDetailsScore(ResultSet rs,int tag) throws SQLException {
		/*
		 * 1. 해당 지표를 가져온다.
		 * 2. detail를 생성한다.
		 * 3. 해당 지표에 등록한다.
		 */
		EstMeasure mea = getMeasure(rs.getInt("MID"));
		if (mea==null) return;
		Division div = getDivision(rs.getInt("DIVISIONID"));
		if (div==null) return;
		
		EstDetail detail = new EstDetail();
		detail.meaId = mea.id;
		detail.divId = div.id;
		detail.allot = rs.getDouble("ALLOT");
		if (tag==0) {
			detail.score = rs.getDouble("EARNSCR");
		} else if (tag==1) {
			detail.score = rs.getDouble("RANKSCR");
		} else if (tag==2) {
			detail.score = rs.getDouble("ACHIVSCR");
		}
		mea.setDetails(div,detail);
		
	}
	public EstMeasure getMeasure(int mid){
		for (int i = 0; i < measures.size(); i++) {
			EstMeasure tmp = (EstMeasure)measures.get(i);
			if (tmp.id==mid) return tmp;
		}
		return null;
	}
	
	public Division getDivision(int did){
		for (int i = 0; i < divisions.size(); i++) {
			Division div = (Division)divisions.get(i);
			if (div.id==did) return div;
		}
		return null;
	}
	
	public Division[] getDivisions(){
		Division[] divs = new Division[divisions.size()];
		
		for (int i = 0; i < divisions.size(); i++) {
			Division div = (Division)divisions.get(i);
			divs[i]=div;
		}
		return divs;
	}
}
