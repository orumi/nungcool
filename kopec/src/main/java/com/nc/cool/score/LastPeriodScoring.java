package com.nc.cool.score;

import java.util.Date;
import java.util.List;

public class LastPeriodScoring extends ForwardEffectScoring
{

    public LastPeriodScoring()
    {
    }
/*
    protected void addParentCalcPeriodLargerFreq(List list, Period period, int i)
    {

    }

    protected Date getChildCalcPeriodLargerFreq(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period)
    {
        Date date = period.getDate();
        period = period.getPeriod(nodeinfo1.frequency);
        Date date1 = period.getDate();
        if(date1.after(date))
            date1 = period.shiftPeriod(-1).getDate();
        return date1;
    }
   */
}
