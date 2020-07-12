package com.nc.cool.score;

import com.nc.util.Util;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

// Referenced classes of package com.corvu.rsc.score:
//            AbstractScoringMethod

public class ForwardEffectScoring extends AbstractScoringMethod {


	public void setPeriodOptions(PeriodOptions periodoptions) {
	}

	public List getCalculationDates(int i, int j) {
		return null;
	}

	public Date getScoreStartDate(int i, Date date, Date date1, int j) {
		return null;
	}

	public Date getScoreEndDate(int i, Date date, Date date1, int j) {
		return null;
	}

	public List getAffectedScorePeriods(Date date, int j){
		ArrayList arraylist = new ArrayList();
		switch(j){
		case 4:
			getQuarterly(arraylist, date);
			break;
		case 5:
			getSemester(arraylist, date);
			break;
		case 6:
			getYearly(arraylist, date);
			break;
		default :
			Calendar cal = Util.getCalendar(date);
			Util.setMonthMaximum(cal);
			arraylist.add(cal.getTime());
		}
		return arraylist;
	}
	
	protected void getYearly(ArrayList arraylist, Date date){
		Calendar cal = Util.getCalendar(date);

		for ( int i=0;i<12;i++){
			cal.set(Calendar.DATE,1);	
			cal.set(Calendar.MONTH, i);
			Util.setMonthMaximum(cal);
			arraylist.add(cal.getTime());
		}
		int year = cal.get(Calendar.YEAR);
		for (int i=0;i<11;i++){
			cal.set(Calendar.YEAR,year+1);
			cal.set(Calendar.DATE,1);	
			cal.set(Calendar.MONTH, i);
			Util.setMonthMaximum(cal);
			arraylist.add(cal.getTime());
		}
	}
	
	protected void getSemester(ArrayList arraylist, Date date){
		Calendar cal = Util.getCalendar(date);

		int month = cal.get(Calendar.MONTH);
		if ( month < 6){
			for ( int i=0;i<11;i++){
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}
		} else {
			for ( int i=6;i<12;i++){
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}
			int year = cal.get(Calendar.YEAR);
			for (int i=0;i<5;i++){
				cal.set(Calendar.YEAR,year+1);
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}
		}
	}
	
	protected void getQuarterly(ArrayList arraylist, Date date){
		Calendar cal = Util.getCalendar(date);

		int month = cal.get(Calendar.MONTH);
		if ((month == 0) || (month == 1) || (month == 2)){
			for ( int i=0;i<5;i++){
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}
		} else if ((month == 3) || (month == 4) || (month == 5)){
			for ( int i=3;i<8;i++){
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}			
		} else if ((month == 6)||(month == 7)||(month == 8)){
			for ( int i=6;i<11;i++){
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}			
		} else {
			for ( int i=9;i<12;i++){
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}
			int year = cal.get(Calendar.YEAR);
			for(int i=0;i<2;i++){
				cal.set(Calendar.YEAR,year+1);
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}
		}
	}
	
	public List getAffectedScorePeriods(int i, Date date, Date date1, int j) {
		return getAffectedScorePeriods(date, j);
	}

	public boolean periodAffectsScore(int i, Date date, Date date1, int j) {
		return false;
	}

	public void setConnection(Connection connection) {
		// TODO Auto-generated method stub
		
	}
}
