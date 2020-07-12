package com.nc.actual;

import com.nc.util.ServerStatic;

public class MeasureDetail {
	public int id;
	public int measureId;
	public String strDate;
	public double actual;
	public float weight;
	public double planned;
	public double plannedbase;
	public double plannedbaseplus;
	public double baseplus;
	public double base;
	public double baselimitplus;
	public double baselimit;
	public double limitplus;
	public double limit;
	public String comments;
	public String frequency;
	public String trend;
	public String filePath;
	public String fileName;
	public String updater;
	
	public String plannedflag;
	
	/*	
	 * PLANNEDFLAG : KOPEC�� ��ǥ�� Ư����Ȳ����
	 * 	��ޱ��� : �ʰ�(O)
	 *  ��ޱ��� : �̻�(U)
	 * 
	 */
	
	public double upper;
	public double highplus;
	public double high;
	public double lowplus;
	public double low;
	public double lowerplus;
	public double lower;
	public double lowstplus;
	public double lowst;
	
	
	public String grade;
	public double grade_score;
	public double score;
	
	public double getScore(){
		try {
			
			//System.out.println("plannedflag : " + plannedflag);
			
			// -----------------------------------------------------------------------------
			// ��ޱ��� �ʰ��� ��� 
			//------------------------------------------------------------------------------	
			if ("O".equals(plannedflag)){
					if ("����".equals(trend)){
						if (actual>planned) {
							grade = "S";
							score = ServerStatic.UPPER;
						} else if (actual>plannedbase){
							grade = "A";
							score = ServerStatic.HIGH;
						} else if (actual>base){
							grade = "B";
							score = ServerStatic.LOW;
						} else if (actual>baselimit){
							grade = "C";
							score = ServerStatic.LOWER;
						} else if (actual<=limit){
							grade = "D";
							score = ServerStatic.LOWST;
						} else {
							grade = "";
							score = 0;
						}
						
						if ((planned==0)&&(plannedbase==0)&&(base==0)&&(baselimit==0)&&(limit==0)) score=0;
						grade_score = grade_score * weight / 100;
						return grade_score;
					} else {
						if (actual>limit) {
							grade = "D";
							score = ServerStatic.LOWST;
						} else if (actual>baselimit){
							grade = "C";
							score = ServerStatic.LOWER;
						} else if (actual>base){
							grade = "B";
							score = ServerStatic.LOW;
						} else if (actual>plannedbase){
							grade = "A";
							score = ServerStatic.HIGH;
						} else if (actual<=planned){
							grade = "S";
							score = ServerStatic.UPPER;
						} else {
							grade = "";
							score = 0;
						}
						
						if ((planned==0)&&(plannedbase==0)&&(base==0)&&(baselimit==0)&&(limit==0)) score=0;
						grade_score = score * weight / 100;
						return grade_score;
					}				
				
				
			} else { 
					// -----------------------------------------------------------------------------
					// 	// ��ޱ��� �̻��� ��� (�Ϲ����� ��Ȳ��)
					//------------------------------------------------------------------------------	
					if ("����".equals(trend)){
						if (actual>=planned) {
							grade = "S";
							score = ServerStatic.UPPER;
						} else if (actual>=plannedbase){
							grade = "A";
							score = ServerStatic.HIGH;
						} else if (actual>=base){
							grade = "B";
							score = ServerStatic.LOW;
						} else if (actual>=baselimit){
							grade = "C";
							score = ServerStatic.LOWER;
						} else if (actual<limit){
							grade = "D";
							score = ServerStatic.LOWST;
						} else {
							grade = "";
							score = 0;
						}
						
						if ((planned==0)&&(plannedbase==0)&&(base==0)&&(baselimit==0)&&(limit==0)) score=0;
						grade_score = grade_score * weight / 100;
						return grade_score;
					} else {
						if (actual>=limit) {
							grade = "D";
							score = ServerStatic.LOWST;
						} else if (actual>=baselimit){
							grade = "C";
							score = ServerStatic.LOWER;
						} else if (actual>=base){
							grade = "B";
							score = ServerStatic.LOW;
						} else if (actual>=plannedbase){
							grade = "A";
							score = ServerStatic.HIGH;
						} else if (actual<planned){
							grade = "S";
							score = ServerStatic.UPPER;
						} else {
							grade = "";
							score = 0;
						}
						
						if ((planned==0)&&(plannedbase==0)&&(base==0)&&(baselimit==0)&&(limit==0)) score=0;
						grade_score = score * weight / 100;
						return grade_score;
					}
			}	
		} catch (Exception e) {
			return -1;
		}
	}
	
	public double getScoreVariable(){
		try {
			//System.out.println("plannedflag : " + plannedflag);
			
			// -----------------------------------------------------------------------------
			// ��ޱ��� �ʰ��� ��� 
			//------------------------------------------------------------------------------	
			if ("O".equals(plannedflag)){
				
				if ("����".equals(trend)){
					if (actual        > planned) {
						
						grade = "S";
						score = this.upper;
						
					} else if (actual > plannedbaseplus){
						
						grade = "A+";
						score = this.highplus;
						
					} else if (actual > plannedbase){
						
						grade = "A";
						score = this.high;
						
					} else if (actual > baseplus){
						
						grade = "B+";
						score = this.lowplus;
						
					} else if (actual > base){
						
						grade = "B";
						score = this.low;
						
					} else if (actual > baselimitplus){
						
						grade = "C+";
						score = this.lowerplus;
						
					} else if (actual > baselimit){
						
						grade = "C";
						score = this.lower;
						
					} else if (actual > limitplus){
						
						grade = "D+";
						score = this.lowstplus;
						
					} else if (actual <= limit){
						
						grade = "D";
						score = this.lowst;
						
					} else {
						
						grade = "";
						score = 0;
						
					}
					
					grade_score = score * weight / 100;				
					return grade_score;
				} else {
					if (actual        < planned) {
						
						grade = "S";
						score = this.upper;
						
					} else if (actual < plannedbaseplus){
						
						grade = "A+";
						score = this.highplus;
						
					} else if (actual < plannedbase){
						
						grade = "A";
						score = this.high;
						
					} else if (actual < baseplus){
						
						grade = "B+";
						score = this.lowplus;
						
					} else if (actual < base){
						
						grade = "B";
						score = this.low;
						
					} else if (actual < baselimitplus){
						
						grade = "C+";
						score = this.lowerplus;
						
					} else if (actual < baselimit){
						
						grade = "C";
						score = this.lower;
						
					} else if (actual < limitplus){
						
						grade = "D+";
						score = this.lowstplus;
						
					} else if (actual <= limit){
						
						grade = "D";
						score = this.lowst;
						
					} else {
						
						grade = "";
						score = 0;
						
					}
					
					

					grade_score = score * weight / 100;				
					return grade_score;
				}
				
			}else {
			// -----------------------------------------------------------------------------
			// 	// ��ޱ��� �̻��� ��� (�Ϲ����� ��Ȳ��)
			//------------------------------------------------------------------------------	
					
				if ("����".equals(trend)){
					if (actual        >= planned) {
						
						grade = "S";
						score = this.upper;
						
					} else if (actual >= plannedbaseplus){
						
						grade = "A+";
						score = this.highplus;
						
					} else if (actual >= plannedbase){
						
						grade = "A";
						score = this.high;
						
					} else if (actual >= baseplus){
						
						grade = "B+";
						score = this.lowplus;
						
					} else if (actual >= base){
						
						grade = "B";
						score = this.low;
						
					} else if (actual >= baselimitplus){
						
						grade = "C+";
						score = this.lowerplus;
						
					} else if (actual >= baselimit){
						
						grade = "C";
						score = this.lower;
						
					} else if (actual >= limitplus){
						
						grade = "D+";
						score = this.lowstplus;
						
					} else if (actual < limit){
						
						grade = "D";
						score = this.lowst;
						
					} else {
						
						grade = "";
						score = 0;
						
					}
					
					grade_score = score * weight / 100;				
					return grade_score;
				} else {
					if (actual        <= planned) {
						
						grade = "S";
						score = this.upper;
						
					} else if (actual <= plannedbaseplus){
						
						grade = "A+";
						score = this.highplus;
						
					} else if (actual <= plannedbase){
						
						grade = "A";
						score = this.high;
						
					} else if (actual <= baseplus){
						
						grade = "B+";
						score = this.lowplus;
						
					} else if (actual <= base){
						
						grade = "B";
						score = this.low;
						
					} else if (actual <= baselimitplus){
						
						grade = "C+";
						score = this.lowerplus;
						
					} else if (actual <= baselimit){
						
						grade = "C";
						score = this.lower;
						
					} else if (actual <= limitplus){
						
						grade = "D+";
						score = this.lowstplus;
						
					} else if (actual < limit){
						
						grade = "D";
						score = this.lowst;
						
					} else {
						
						grade = "";
						score = 0;
						
					}
					grade_score = score * weight / 100;				
					return grade_score;
				}
			}	
		} catch (Exception e) {
			return -1;
		}
	}	
}
