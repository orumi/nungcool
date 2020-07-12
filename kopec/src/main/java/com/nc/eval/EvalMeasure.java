package com.nc.eval;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

public class EvalMeasure {
	public int mId;
	public String sname;
	public String name;
	public String pname;
	public String bname;
	public String belong;
	public String frequency;
	public double weight;
	public double actual;
	public String grade;
	public double score;
	
	
	HashMap appScore ;
	
	public EvalMeasure(){
		appScore = new HashMap();
	}
	public void setActual(String userId,EvalDetail detail){
		appScore.put(userId,detail);
	}
	public EvalDetail getActual(String userId){
		return (EvalDetail)appScore.get(userId);
	}
	
	
	/* 
	 * 5 명이상이면 최상,최하 제거한 평균
	 * 그외는 평균점수 ... 적용.
	 */
	public double getAvg(){ 
		double totSum=0;
		int cnt=0;
		double reval=0;
						
		for(Iterator i=appScore.entrySet().iterator();i.hasNext();){
			
			Entry entry = (Entry)i.next();
			EvalDetail detail = (EvalDetail) entry.getValue();
			//System.out.println("entry =========="+entry.toString());
			//System.out.println("detail =========="+detail.toString());
			if (detail.type==0){
				totSum+= detail.evalScore;				
				//System.out.println("11111111111111totSum =========="+totSum);
				//System.out.println("11111111111111detail.evalScore =========="+detail.userId);
				//System.out.println("11111111111111detail.evalScore =========="+detail.evalScore);
				//System.out.println("11111111111111detail.evalScore =========="+detail.evalDetail);
				//System.out.println("11111111111111detail.evalScore =========="+detail.confirm);
							
				
				//if(detail.evalScore==0  ){
				//	System.out.println("222222222222222.evalScore =========="+detail.evalScore);
				//}
				cnt++;
			}
		}		
		if (cnt!=0) {
			reval = totSum/cnt;
			//System.out.println("reval getAvg =========="+reval);
		}
		return reval;
	}
	
	public double getAvgB(){
		double totSum=0;
		int cnt=0;
		double reval=0;
		for(Iterator i=appScore.entrySet().iterator();i.hasNext();){
			Entry entry = (Entry)i.next();
			EvalDetail detail = (EvalDetail)entry.getValue();
			if (detail.type==1){
				totSum+= detail.evalScore;
				//System.out.println("reval getAvgB =========="+reval);
				cnt++;
			}
		}
		
		if (cnt!=0) {
			reval = totSum/cnt;
		}
		return reval;
	}
		
}
