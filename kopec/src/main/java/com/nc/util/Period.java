package com.nc.util;

import java.util.Calendar;
import java.util.Date;

public class Period implements Cloneable{
    int frequency;
    Calendar cal;
    TermsOptions option;
    ForDate fcal;
    Date date;
    public boolean isLastPeriod;

	public Period(Date date1, int i){
		cal = Util.getCalendar(date1);
		frequency = i;
	}
	
	public Period(Calendar calendar, int i){
		cal= calendar;
		frequency = i;
	}
    public Period(Date date1, int i, TermsOptions periodoptions, ForDate foreigncalendar)
    {
        cal = Util.getCalendar(date1);
        frequency = i;
        option = periodoptions;
        //cal = foreigncalendar;
        normaliseCalendar();
    }

    public Period(Calendar calendar, int i, TermsOptions periodoptions, ForDate foreigncalendar)
    {
        cal = calendar;
        frequency = i;
        option = periodoptions;
        fcal = foreigncalendar;
    }
    
    public void normaliseCalendar()
    {
        cal = Util.normalisePeriod(cal, frequency, option, null);
    }
    public boolean before(Period period){
        return cal.before(period.cal);
    }

    public boolean after(Period period){
        return cal.after(period.cal);
    }
    
    public Period getPeriod(int i)
    {
        if(frequency == i)
        {
            return this;
        } else
        {
            Calendar calendar = convertFrequencyCalendar(i);
            return new Period(calendar, i, option, fcal);
        }
    }
    private Calendar convertFrequencyCalendar(int i)
    {
        return Util.normalisePeriod((Calendar)cal.clone(), i, option, fcal);
    }
    public Date getDate(){
        if(date == null)
            date = cal.getTime();
        return date;
    }

    public Calendar getCalendar(){
        return cal;
    }

    public int getFrequency(){
        return frequency;
    }

    public void convertToFrequency(int i){
        frequency = i;
    }

    public int hashCode()
    {
        int i = cal.get(1);
        int j = cal.get(2);
        int k = cal.get(5);
        return (i - 1900) * 10000 + j * 500 + k * 10 + frequency;
    }

    public Period copyPeriod(){
        return new Period((Calendar)cal.clone(), frequency, option, fcal);
    }
    
    public Period shiftPeriod(int i)
    {
        cal = Util.addPeriod(cal, i, frequency, fcal);
        date = null;
        return this;
    }
}
