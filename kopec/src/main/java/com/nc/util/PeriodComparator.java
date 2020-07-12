package com.nc.util;

import java.util.Comparator;


public class PeriodComparator
    implements Comparator
{

    public PeriodComparator()
    {
    }

    public int compare(Object obj, Object obj1)
    {
        if(obj == null || !(obj instanceof Period))
            return -1;
        if(obj1 == null || !(obj1 instanceof Period))
            return 1;
        int i = ((Period)obj1).frequency - ((Period)obj).frequency;
        if(i != 0)
            return i;
        else
            return Util.periodDiff(((Period)obj).cal, ((Period)obj1).cal, ((Period)obj1).frequency, ((Period)obj1).fcal);
    }

    public boolean equals(Object obj)
    {
        return obj != null && (obj instanceof PeriodComparator);
    }
}
