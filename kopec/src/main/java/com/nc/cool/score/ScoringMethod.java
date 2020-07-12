// Decompiled by Jad v1.5.8d. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ScoringMethod.java

package com.nc.cool.score;

import com.nc.sql.CoolConnection;
//import com.nungcool.util.Period;
import java.sql.Connection;
import java.util.Date;
import java.util.List;

// Referenced classes of package com.corvu.rsc.score:
//            NodeInfo

public interface ScoringMethod
{

    public abstract void setFrequency(int i);

    public abstract int getFrequency();

    public abstract void setPeriodOptions(PeriodOptions periodoptions);

    //public abstract void setForeignCalendar(ForeignCalendar foreigncalendar);

    public abstract void setConnection(Connection connection);

    //public abstract void addParentCalculationPeriod(List list, Period period, int i);

    //public abstract Date getChildCalculationPeriod(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period);

    public abstract void addChildUpdatePeriod(NodeInfo nodeinfo, Date date);

    public abstract List getCalculationDates(int i, int j);

    public abstract Date getScoreStartDate(int i, Date date, Date date1, int j);

    public abstract Date getScoreEndDate(int i, Date date, Date date1, int j);

    public abstract List getAffectedScorePeriods(int i, Date date, Date date1, int j);
    
    public abstract List getAffectedScorePeriods(Date date, int j);

    public abstract boolean periodAffectsScore(int i, Date date, Date date1, int j);

    public abstract void recalcuteScores(int i, int j, List list);

    public abstract void addParentMeasureUpdatePeriod(NodeInfo nodeinfo, NodeInfo nodeinfo1);

    public abstract List getAffectedCalcPeriods(NodeInfo nodeinfo, NodeInfo anodeinfo[]);
}
