package com.nc.cool.score;

import java.io.*;
import java.util.Hashtable;
import java.util.Properties;

public class PeriodOptions
{

    public PeriodOptions(Properties properties)
    {
        lastDayOfWeek = Integer.parseInt(properties.getProperty("LAST_DAY_OF_WEEK"));
        lastMonthOfYear = Integer.parseInt(properties.getProperty("LAST_MONTH_OF_YEAR"));
    }

    public PeriodOptions(DataInputStream datainputstream)
        throws IOException
    {
        read(datainputstream);
    }

    public void setLastDayOfWeek(Properties properties, int i)
    {
        lastDayOfWeek = i;
        properties.put("LAST_DAY_OF_WEEK", Integer.toString(i));
    }

    public void setLastMonthOfYear(Properties properties, int i)
    {
        lastMonthOfYear = i;
        properties.put("LAST_MONTH_OF_YEAR", Integer.toString(i));
    }

    public void write(DataOutputStream dataoutputstream)
        throws IOException
    {
        dataoutputstream.writeInt(lastDayOfWeek);
        dataoutputstream.writeInt(lastMonthOfYear);
    }

    public void read(DataInputStream datainputstream)
        throws IOException
    {
        lastDayOfWeek = datainputstream.readInt();
        lastMonthOfYear = datainputstream.readInt();
    }

    public int lastDayOfWeek;
    public int lastMonthOfYear;
}
