package com.nc.cool.score;

import com.nc.sql.CoolConnection;
import java.util.*;

// Referenced classes of package com.corvu.rsc.score:
//            ScoringMethod, NodeInfo

public abstract class AbstractScoringMethod
    implements ScoringMethod {

    int frequency;
    PeriodOptions periodOptions;
    //ForeignCalendar foreignCalendar;
    CoolConnection con;
 
	public AbstractScoringMethod()
    {
    }

    public void setFrequency(int i)
    {
        frequency = i;
    }

    public int getFrequency()
    {
        return frequency;
    }


    public void setConnection(CoolConnection coolconnection)
    {
        con = coolconnection;
    }
/*
    public void addParentCalculationPeriod(List list, Period period, int i)
    {
        int j = period.getFrequency();
        if(j == i)
            addParentCalcPeriodSameFreq(list, period);
        else
        if(DateUtil.hasSmallerInterval(j, i))
            addParentCalcPeriodSmallerFreq(list, period, i);
        else
            addParentCalcPeriodLargerFreq(list, period, i);
    }

    protected void addParentCalcPeriodSameFreq(List list, Period period)
    {
        list.add(period);
    }

    protected void addParentCalcPeriodSmallerFreq(List list, Period period, int i)
    {
        list.add(period.getPeriod(i));
    }

    protected void addParentCalcPeriodLargerFreq(List list, Period period, int i)
    {
        Period period1 = period.copyPeriod().shiftPeriod(-1);
        Util.addPeriod(period1.getCalendar(), 1, 1, null);
        period1.convertToFrequency(i);
        for(Calendar calendar = period.getCalendar(); DateUtil.compareDay(period1.getCalendar(), calendar) <= 0; period1.shiftPeriod(1))
            list.add(period1.copyPeriod());

    }

    public Date getChildCalculationPeriod(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period)
    {
        Date date;
        if(nodeinfo.frequency == nodeinfo1.frequency)
            date = getChildCalcPeriodSameFreq(nodeinfo, nodeinfo1, period);
        else
        if(DateUtil.hasSmallerInterval(nodeinfo1.frequency, nodeinfo.frequency))
            date = getChildCalcPeriodSmallerFreq(nodeinfo, nodeinfo1, period);
        else
            date = getChildCalcPeriodLargerFreq(nodeinfo, nodeinfo1, period);
        return date;
    }

    protected Date getChildCalcPeriodSameFreq(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period)
    {
        return period.getDate();
    }

    protected Date getChildCalcPeriodSmallerFreq(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period)
    {
        try
        {
            Date date = period.getDate();
            Date date1 = period.copyPeriod().shiftPeriod(-1).getDate();
            return MeasureUtil.getLatestDateInRange(con, date1, date, nodeinfo1.measId.intValue());
        }
        catch(SQLException sqlexception)
        {
            throw new RSCException(RSCServer.resource.getString(ServerConstants.LANG_ASM_MEAS_DATE_FAIL, nodeinfo1.measId.toString()));
        }
    }

    protected Date getChildCalcPeriodLargerFreq(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period)
    {
        Date date = period.getDate();
        period = period.getPeriod(nodeinfo1.frequency);
        return period.getDate();
    }

    public List getCalculationDates(int i, int j)
    {
        List list;
        try
        {
            list = MeasureUtil.getDependentDataPeriods(con, strProd, periodOptions, foreignCalendar, i);
        }
        catch(SQLException sqlexception)
        {
            throw new RSCException(RSCServer.resource.getString(ServerConstants.LANG_ASM_MEAS_DEP_FAIL, Integer.toString(i)));
        }
        if(list == null)
            return null;
        ArrayList arraylist = new ArrayList();
        Collections.sort(arraylist, new PeriodComparator());
        int k = list.size();
        for(int l = 0; l < k; l++)
        {
            Period period = (Period)list.get(l);
            addParentCalculationPeriod(arraylist, period, j);
        }

        Iterator iterator = arraylist.iterator();
        arraylist = new ArrayList();
        Period period1;
        for(; iterator.hasNext(); arraylist.add(period1.getDate()))
            period1 = (Period)iterator.next();

        return arraylist;
    }

    public abstract Date getScoreStartDate(int i, Date date, Date date1, int j);

    public abstract Date getScoreEndDate(int i, Date date, Date date1, int j);

    public List getAffectedScorePeriods(int i, Date date, Date date1, int j)
    {
        ArrayList arraylist = new ArrayList();
        Date date2 = getScoreStartDate(i, date, date1, j);
        Date date3 = getScoreEndDate(i, date, date1, j);
        if(date3 == null)
            return arraylist;
        Calendar calendar = Util.getCalendar(date2);
        Calendar calendar1 = Util.getCalendar(date3);
        do
        {
            Date date4 = calendar.getTime();
            if(periodAffectsScore(i, date, date4, j))
                arraylist.add(date4);
            calendar = Util.addPeriod(calendar, 1, frequency, foreignCalendar);
        } while(DateUtil.compareDay(calendar, calendar1) <= 0);
        return arraylist;
    }

    public boolean periodAffectsScore(int i, Date date, Date date1, int j)
    {
        Date date2;
        try
        {
            date2 = MeasureUtil.getNextDate(con, date, i);
        }
        catch(SQLException sqlexception)
        {
            Log.error("BackwardEffectScoring.periodAffectsScore", "measure=" + i);
            throw new RSCException(RSCServer.resource.getString(ServerConstants.LANG_ASM_NEXT_DATE_FAIL, Integer.toString(i)));
        }
        if(date2 == null)
            return true;
        else
            return date2.after(date1);
    }
*/
    public void recalcuteScores(int i, int j, List list)
    {
        Date date;
        for(Iterator iterator = list.iterator(); iterator.hasNext(); recalcuteMeasureScore(i, j, date))
            date = (Date)iterator.next();

    }

    public void recalcuteMeasureScore(int i, int j, Date date)
    {
    }

    public void addChildUpdatePeriod(NodeInfo nodeinfo, Date date)
    {
        //Period period = new Period(date, nodeinfo.frequency, periodOptions, foreignCalendar);
        //nodeinfo.dirtyPeriods.add(period);
    }

    public void addParentMeasureUpdatePeriod(NodeInfo nodeinfo, NodeInfo nodeinfo1)
    {
        nodeinfo.dirtyPeriods.addAll(nodeinfo1.dirtyPeriods);
    }

    public List getAffectedCalcPeriods(NodeInfo nodeinfo, NodeInfo anodeinfo[])
    {
        ArrayList arraylist = new ArrayList(nodeinfo.dirtyPeriods.size());
        //Period period;
        //for(Iterator iterator = nodeinfo.dirtyPeriods.iterator(); iterator.hasNext(); addParentCalculationPeriod(arraylist, period, nodeinfo.frequency))
            //period = (Period)iterator.next();

        //Collections.sort(arraylist, new PeriodComparator());
        Collections.reverse(arraylist);
        return arraylist;
    }

}
