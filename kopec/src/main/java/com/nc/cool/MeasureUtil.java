package com.nc.cool;

import com.nc.cool.score.PeriodOptions;
import com.nc.sql.CoolConnection;
import com.nc.util.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.*;

public class MeasureUtil {

    public MeasureUtil() { 
    }
    
    public static int getVarMeasureId(String s) throws Exception{
    	if (s.startsWith("ID"))
    		try {
				return Integer.parseInt(s.substring(2));
			} catch (Exception e) {
				throw new Exception("There is no Id");
			}
			
		return -1;
    }
    
    public static String getMeasureDescription(CoolConnection coolconnection, int i)
        throws SQLException
    {
        ResultSet resultset = coolconnection.executeQuery("SELECT c.Shortname FROM tblMeasureDefine a, tblMeasure c WHERE a.MeasureId=c.Id AND a.Id=" + i);
        if(resultset.next())
            return ServerUtil.getString(resultset, 1);
        else
            return null;
    }

    public static Object getMeasureField(DBObject dbobject, int i, String s)
        throws SQLException
    {
        ResultSet resultset = dbobject.executeQuery("SELECT " + s + " FROM tblMeasureDefine WHERE id=" + i);
        if(resultset.next())
            return ServerUtil.getObject(resultset, 1);
        else
            return null;
    }

    public static int getMeasureFrequency(DBObject dbobject, int i)
        throws SQLException, Exception
    {
        String s = (String)getMeasureField(dbobject, i, "Frequency");
        return ServerUtil.getMeasurePeriodFrequency(s);
    }

    public static int deleteMeasureScores(CoolConnection coolconnection, int i, Date adate[])
        throws SQLException
    {
        StringBuffer stringbuffer = new StringBuffer();
        stringbuffer.append("DELETE FROM tblMeasureScore WHERE MeasureId=");
        stringbuffer.append(i);
        stringbuffer.append(" AND EffectiveDate IN (");
        for(int j = 0; j < adate.length; j++)
        {
            if(j > 0)
                stringbuffer.append(", ");
            stringbuffer.append((adate[j]));
        }

        stringbuffer.append(")");
        return coolconnection.executeUpdate(stringbuffer.toString());
    }


    public static Date getNextDate(CoolConnection coolconnection, Date date, int i)
        throws SQLException
    {
        String s = "SELECT MIN(EffectiveDate) FROM tblMeasureDetail  WHERE MeasureId=" + i + " AND EffectiveDate > " + date;
        java.sql.Date date1 = null;
        ResultSet resultset = coolconnection.executeQuery(s);
        if(resultset.next())
            date1 = resultset.getDate(1);
        return date1;
    }

    public static Date getNextDateInclusive(CoolConnection coolconnection, Date date, int i)
        throws SQLException
    {
        String s = "SELECT MIN(EffectiveDate) FROM tblMeasureDetail  WHERE MeasureId=" + i + " AND EffectiveDate >= " +(date);
        java.sql.Date date1 = null;
        ResultSet resultset = coolconnection.executeQuery(s);
        if(resultset.next())
            date1 = resultset.getDate(1);
        return date1;
    }

    public static Date getLatestDateToPeriod(CoolConnection coolconnection, Date date, int i)
        throws SQLException
    {
        String s = "SELECT MAX(EffectiveDate) FROM tblMeasureDetail  WHERE MeasureId=" + i + " AND EffectiveDate <= " + (date);
        ResultSet resultset = coolconnection.executeQuery(s);
        return resultset.next() ? resultset.getDate(1) : null;
    }

    public static Date getLatestDateFromPeriod(CoolConnection coolconnection, Date date, int i)
        throws SQLException
    {
        String s = "SELECT MAX(EffectiveDate) FROM tblMeasureDetail  WHERE MeasureId=" + i + " AND EffectiveDate >= " + (date);
        ResultSet resultset = coolconnection.executeQuery(s);
        return resultset.next() ? resultset.getDate(1) : null;
    }

    public static Date getLatestDateInRange(DBObject dbobject, Date date, Date date1, int i)
        throws SQLException
    {
        //QueryMaker querymaker = coolconnection.getQueryMaker();
        //String s = "SELECT MAX(EffectiveDate) FROM a_MeasureDetail  WHERE MeasureId=" + i + " AND EffectiveDate > " + querymaker.getSQLDate(date) + " AND EffectiveDate <= " + querymaker.getSQLDate(date1);
    	
    	String s = "SELECT MAX(strDate) FROM tblMeasureDetail  WHERE MeasureId=" + i + " AND strDate > '" +Util.getStrDate(date) + "' AND strDate <='" + Util.getStrDate(date1)+"'";
        ResultSet resultset = dbobject.executeQuery(s);
        return resultset.next() ? Util.getDateStr(resultset.getString(1)) : null;
    }
    
    public static List getDependentDataDates(CoolConnection coolconnection, int i)
        throws SQLException
    {
        String s = "SELECT DISTINCT EffectiveDate FROM tblMeasureDetail WHERE MeasureId IN (SELECT ChildId FROM MeasureDependent WHERE ParentId=" + i + ")";
        ResultSet resultset = coolconnection.executeQuery(s);
        ArrayList arraylist = new ArrayList();
        for(; resultset.next(); arraylist.add(resultset.getDate(1)));
        return arraylist;
    }

    
    public static List getDependentDataPeriods(DBObject dbobject, int i)
        throws SQLException   {
        //String s = "SELECT DISTINCT a.Frequency, d.EffectiveDate FROM a_MeasureDetail d, a_Measure a WHERE d.MeasureId=a.Id and a.Id IN (SELECT ChildId FROM MeasureDependent WHERE ParentId=" + i + ")";
        String s= "select distinct a.frequency, d.strDate from tblMeasureDetail d, tblMeasureDefine a where d.measureid=a.id and a.id In(select childId from tblMeasureDependent where  ParentId=" + i + ") order by d.strDate";
    	ResultSet resultset = dbobject.executeQuery(s);
        ArrayList arraylist = new ArrayList();
        int j;
        try{
	        Calendar ca;
	        for(; resultset.next(); arraylist.add(new Period(ca, j)))  {
	            String per = ServerUtil.getString(resultset, 1);
	            j = ServerUtil.getMeasurePeriodFrequency(per);
	            String strDate = resultset.getString(2);
	            
	            ca= Calendar.getInstance();
	            ca.set(Integer.parseInt(strDate.substring(0,4)), Integer.parseInt(strDate.substring(4,6))-1, Integer.parseInt(strDate.substring(6,8)));
	            
	    		//date = Util.getDateFormat("yyyyMMdd").parse(resultset.getString(2));
	            //date = resultset.getDate(2);
	            //cal = Calendar.getInstance();
	    		
	    		//cal.set(Integer.parseInt(strDate.substring(0,4)), Integer.parseInt(strDate.substring(4,6)), Integer.parseInt(strDate.substring(6,8)));
	        }

        } catch (Exception e){
        	
        }
        return arraylist;
    }

    public static Date[] getDependentDataDateRange(CoolConnection coolconnection, int i)
        throws SQLException
    {
        String s = "SELECT MIN(EffectiveDate), MAX(EffectiveDate) FROM tblMeasureDetail WHERE MeasureId IN (SELECT ChildId FROM MeasureDependent WHERE ParentId=" + i + ")";
        ResultSet resultset = coolconnection.executeQuery(s);
        ArrayList arraylist = new ArrayList();
        if(!resultset.next())
            return null;
        else
            return (new Date[] {
                resultset.getDate(1), resultset.getDate(2)
            });
    }
}
