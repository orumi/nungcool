package com.nc.eval;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

public class EvalMeasureUtil {
	public ArrayList meaList;
	public HashMap appMap;
	public HashMap appMapB;
	
	public EvalMeasureUtil(){
		meaList = new ArrayList();
		appMap = new HashMap();
		appMapB = new HashMap();
	}
	
	public void AddMeasure(ResultSet rs) throws SQLException{
		EvalMeasure mea = new EvalMeasure();
		mea.mId = rs.getInt("MCID");
		mea.sname = rs.getString("SNAME");
		mea.pname = rs.getString("PNAME");
		mea.name = rs.getString("MNAME");
		mea.bname = rs.getString("BNAME");
		mea.belong = rs.getString("MKIND");
		mea.frequency = rs.getString("FREQUENCY");
		mea.weight = rs.getDouble("MWEIGHT");
		//mea.grade = rs.getString("GRADE");
		//mea.score = rs.getDouble("SCORE");
		
		meaList.add(mea);
	}
	
	//=======================================
	public void AddMeasure2(ResultSet rs) throws SQLException{
		EvalMeasure mea = new EvalMeasure();
		mea.mId = rs.getInt("MCID");
		
		mea.sname = rs.getString("mname");
		mea.pname = rs.getString("sname");
		mea.name = rs.getString("bname");
		mea.bname = rs.getString("avg_score");
		mea.belong = rs.getString("grade");
		mea.frequency = rs.getString("meas_score");
		mea.weight = rs.getDouble("MWEIGHT");
		//mea.grade = rs.getString("GRADE");
		mea.score = rs.getDouble("grade_score");
		
			
		
		meaList.add(mea);
	}
	
	//=======================================
	
	public void AddMeasureDetail(ResultSet rs ) throws SQLException {
		EvalMeasure mea = new EvalMeasure();
		mea.mId = rs.getInt("MCID");
		mea.sname = rs.getString("SNAME");
		mea.pname = rs.getString("PNAME");
		mea.name = rs.getString("MNAME");
		mea.bname = rs.getString("BNAME");
		mea.belong = rs.getString("MKIND");
		mea.frequency = rs.getString("FREQUENCY");
		mea.weight = rs.getDouble("MWEIGHT");
		//mea.actual = rs.getDouble("ACTUAL");
		//mea.grade = rs.getString("GRADE");
		
		meaList.add(mea);	
	}
	public void setActual(ResultSet rs) throws SQLException{
		EvalMeasure evalmeasure = getMeasure(rs.getInt("EVALID"));
		if (evalmeasure!=null){
			//setAppName(rs.getString("UNAME")!=null?rs.getString("UNAME"):"");
			String userId = rs.getString("EVALRID");
			if ((isExitUser(userId))||(isExitUserB(userId))){
				EvalDetail detail = new EvalDetail();
				detail.type = isExitUser(userId)?0:1;
				detail.userId = rs.getString("EVALRID");
				detail.evalDetail = rs.getString("EVALGRADE");
				detail.evalScore = rs.getFloat("EVALSCORE");
				detail.confirm = rs.getInt("CONFIRM");
				
				evalmeasure.setActual(detail.userId,detail);
			}
		}
	}
	
	private EvalMeasure getMeasure(int meaid){
		for (int i = 0; i < meaList.size(); i++) {
			EvalMeasure temp = (EvalMeasure)meaList.get(i);
			if (temp.mId==meaid) return temp; 
		}
		return null;
	}
	

	public void setAppName(ResultSet rs) throws SQLException{
		if (1==rs.getInt("APP")){
			appMap.put(rs.getString("EVALRID"),rs.getString("USERNAME"));
		} else {
			appMapB.put(rs.getString("EVALRID"),rs.getString("USERNAME"));
		}
	}
	
	public String[] getAppName(){
		String[] reval = new String[appMap.size()];
		
		int i = 0;
		for (Iterator it = appMap.entrySet().iterator();it.hasNext();) {
			Entry entry = (Entry)it.next();
			reval[i] = (String) entry.getValue();
			
			i++;
		}
		
		return reval;                            
	}
	
	public String[] getAppNameB(){
		String [] reval = new String[appMapB.size()];
		
		int i=0;
		for (Iterator it = appMapB.entrySet().iterator();it.hasNext();){
			Entry entry = (Entry)it.next();
			reval[i] = (String) entry.getValue();
			i++;
		}
		return reval;
	}
	
	public String[] getAppUserId(){
		String[] reval = new String[appMap.size()];
		
		int i=0;
		for (Iterator it=appMap.entrySet().iterator();it.hasNext();){
			Entry entry = (Entry)it.next();
			reval[i] = (String)entry.getKey();
			i++;
		}
		return reval;
	}
	
	public String[] getAppUserIdB() {
		String[] reval = new String[appMapB.size()];
		
		int i=0;
		for (Iterator it=appMapB.entrySet().iterator();it.hasNext();){
			Entry entry = (Entry)it.next();
			reval[i] = (String)entry.getKey();
			i++;
		}
		return reval;
	}
	
	private boolean isExitUser(String userId){
		return appMap.containsKey(userId);
	}
	
	private boolean isExitUserB(String userId){
		return appMapB.containsKey(userId);
	}
}
