package com.nc.cool.score;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.nc.util.Util;

public class BackwardEffectScoring extends AbstractScoringMethod {

	public void setPeriodOptions(PeriodOptions periodoptions) {
		// TODO Auto-generated method stub
		
	}

	public List getCalculationDates(int i, int j) {
		// TODO Auto-generated method stub
		return null;
	}

	public Date getScoreStartDate(int i, Date date, Date date1, int j) {
		// TODO Auto-generated method stub
		return null;
	}

	public Date getScoreEndDate(int i, Date date, Date date1, int j) {
		// TODO Auto-generated method stub
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
	}
	
	protected void getSemester(ArrayList arraylist, Date date){
		Calendar cal = Util.getCalendar(date);

		int month = cal.get(Calendar.MONTH);
		if ( month < 6){
			for ( int i=0;i<6;i++){
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
		}
	}
	
	protected void getQuarterly(ArrayList arraylist, Date date){
		Calendar cal = Util.getCalendar(date);

		int month = cal.get(Calendar.MONTH);
		if ((month == 0) || (month == 1) || (month == 2)){
			for ( int i=0;i<3;i++){
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}
		} else if ((month == 3) || (month == 4) || (month == 5)){
			for ( int i=3;i<6;i++){
				cal.set(Calendar.DATE,1);	
				cal.set(Calendar.MONTH, i);
				Util.setMonthMaximum(cal);
				arraylist.add(cal.getTime());
			}			
		} else if ((month == 6)||(month == 7)||(month == 8)){
			for ( int i=6;i<9;i++){
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
		}
	}
	
	public List getAffectedScorePeriods(int i, Date date, Date date1, int j) {
		return getAffectedScorePeriods(date, j);
	}

	public boolean periodAffectsScore(int i, Date date, Date date1, int j) {
		return false;
	}
/*
    public BackwardEffectScoring()
    {
    }

    public Date getScoreStartDate(int i, Date date, Date date1, int j)
    {
        if(DateUtil.hasLargerInterval(j, super.frequency))
        {
            date = Util.addPeriod(date, -1, j, super.foreignCalendar);
            date = Util.addPeriod(date, 1, 1, super.foreignCalendar);
        }
        return Util.normalisePeriod(date, super.frequency, super.periodOptions, super.foreignCalendar);
    }

    public Date getScoreEndDate(int i, Date date, Date date1, int j)
    {
        return Util.normalisePeriod(date, super.frequency, super.periodOptions, super.foreignCalendar);
    }
    
    */

	public void setConnection(Connection connection) {
		// TODO Auto-generated method stub
		
	}
}
