package com.nc.cool;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.nc.actual.ActualUtil;
import com.nc.actual.MeasureDetail;
import com.nc.cool.score.*;
import com.nc.math.Expression;
import com.nc.util.*;


public class ExpressionUtil extends DBObject{

	public ExpressionUtil(Connection connection) {
		super(connection);
	}

    public void updateMeasuresWithDates(Map map) throws SQLException,Exception {
        GraphInfo graphinfo = buildEquationGraph(map, false);
        if(graphinfo == null) {
            return;
        } else {
            updateMeasuresWithDatesGraph(graphinfo);
            return;
        }
    }
    
    private void updateMeasuresWithDatesGraph(GraphInfo graphinfo)
    throws SQLException {
	    int i = graphinfo.maxLevel;
	    for(int j = 0; j < i; j++) {
	        for(Iterator iterator = graphinfo.nodes.values().iterator(); iterator.hasNext();) {
	            NodeInfo nodeinfo = (NodeInfo)iterator.next();
	            if(j == nodeinfo.level)
	                updateSingleMeasure(graphinfo, nodeinfo);
	        }
	    }
	}
    
    private void updateSingleMeasure(GraphInfo graphinfo, NodeInfo nodeinfo)
    throws SQLException {
		try {
	        int i = nodeinfo.measId.intValue();
	        if(nodeinfo.eqn == null)
	            return;
	        Expression expression = nodeinfo.getExpression();
	        Vector vector = new Vector();
	        expression.addUnknowns(vector);
	        int j = vector.size();
	        Hashtable hashtable = null;

	        
	
	        Object obj = null;
	        NodeInfo anodeinfo[] = null;
	        if(j > 0) {
	            anodeinfo = new NodeInfo[j];
	            for(int k = 0; k < j; k++) {
	                String s = (String)vector.get(k);
	                int l = MeasureUtil.getVarMeasureId(s);
	                NodeInfo nodeinfo1 = (NodeInfo)graphinfo.nodes.get(new Integer(l));
	                if(nodeinfo1 == null)
	                    throw new Exception("Failed to find child measure ");
	                anodeinfo[k] = nodeinfo1;
	                addParentMeasureUpdatePeriod(nodeinfo, nodeinfo1);
	            }
	
	        }
	
	        List list = getAffectedCalcPeriods(nodeinfo, anodeinfo);
	        int i1 = list.size();
	        HashSet hashset = new HashSet();
	        for(int j1 = 0; j1 < i1; j1++){
	            Period period = (Period)list.get(j1);
	            Date date = period.getDate();
	            if(hashset.contains(date)) {
	                //Log.debug("ExpressionUtil.updateSingleMeasure", "Period " + date +" already calculated");
	            } else {
	                hashset.add(date);
	                int k1 = 0;
	                if(j > 0) {
	                    hashtable = new Hashtable();

	                    for(int l1 = 0; l1 < j; l1++) {
	                        String s1 = (String)vector.get(l1);
	                        Date date1 = getChildCalculationPeriod(nodeinfo, anodeinfo[l1], period);
	                        if(date1 != null) {
	                            StringBuffer stringbuffer = new StringBuffer();
	                            stringbuffer.append("SELECT Actual");

	                            stringbuffer.append(" FROM ");
	                            stringbuffer.append("a_measuredetail");
	                            stringbuffer.append(" WHERE to_char(effectivedate, 'YYYYMMDDHH24MISS')='");
	                            stringbuffer.append(Util.getStrDate(date1));
	                            stringbuffer.append("' AND measureId=");
	                            stringbuffer.append(anodeinfo[l1].measId);
	                            stringbuffer.append(" AND Actual IS NOT NULL");
	                            ResultSet resultset = executeQuery(stringbuffer.toString());
	                            if(resultset.next()) {
	                                double d = resultset.getDouble(1);

	                                hashtable.put(s1, new Double(d));
	                                k1++;
	                            }
	                        }
	                    }
	
	                }
	                if(j == k1)
	                    try {
	                        MeasureDetail md = null;//ScorecardUtil.getMeasureDetail(this, i, date);
	                        if (md == null){
	                        	md = new MeasureDetail();
	                        	md.measureId = i;
	                        	md.strDate = Util.getStrDate(date);
	                        }
	                        if (md != null){
		                        md.actual =  ((Double)expression.evaluate(hashtable)).doubleValue();
		                        md.comments = "Auto generated";
		                        //ActualUtil.updateMeasureDetail(this,md);
	                        	//ScorecardUtil.updateDetailedMeasure(this, measuredetail, false);
	                        }
	                    } catch(Exception exception) {
	                        //Log.info("ExpressionUtil.updateSingleMeasure", "Failed to evaluate: vars=" + hashtable, exception);
	                    }
	                //else if(!"true".equals(service.getProperty("NO_DEL_CALC_MEAS")))
	                    //ScorecardUtil.deleteDetailedMeasure(this, i, date, nodeinfo.frequency); 
	            }
	        }
		} catch (Exception e) {
			System.out.println(e);
		}
	
	}
    
    public Date getChildCalculationPeriod(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period) throws Exception{
        Date date;
        if(nodeinfo.frequency == nodeinfo1.frequency)
            date = period.getDate();
        else if(DateUtil.hasSmallerInterval(nodeinfo1.frequency, nodeinfo.frequency))
            date = getChildCalcPeriodSmallerFreq(nodeinfo, nodeinfo1, period);
        else
            date = getChildCalcPeriodLargerFreq(nodeinfo, nodeinfo1, period);
        return date;
    }
    
    protected Date getChildCalcPeriodSmallerFreq(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period) throws Exception
    {
        try
        {
            Date date = period.getDate();
            Date date1 = period.copyPeriod().shiftPeriod(-1).getDate();
            return MeasureUtil.getLatestDateInRange(this, date1, date, nodeinfo1.measId.intValue());
        }
        catch(SQLException sqlexception)
        {
            throw new Exception("ServerConstants.LANG_ASM_MEAS_DATE_FAIL, nodeinfo1.measId");
        }
    }
    public void addParentCalculationPeriod(List list, Period period, int i)  {
        int j = period.getFrequency();
        if(j == i)
            addParentCalcPeriodSameFreq(list, period);
        else
        if(DateUtil.hasSmallerInterval(j, i))
            addParentCalcPeriodSmallerFreq(list, period, i);
        else
            addParentCalcPeriodLargerFreq(list, period, i);
    }
    protected void addParentCalcPeriodLargerFreq(List list, Period period, int i)  {
        Period period1 = period.copyPeriod().shiftPeriod(-1);
        Util.addPeriod(period1.getCalendar(), 1, 1, null);
        period1.convertToFrequency(i);
        for(Calendar calendar = period.getCalendar(); DateUtil.compareDay(period1.getCalendar(), calendar) <= 0; period1.shiftPeriod(1))
            list.add(period1.copyPeriod());

    }
    protected void addParentCalcPeriodSameFreq(List list, Period period)  {
        list.add(period);
    }
    protected void addParentCalcPeriodSmallerFreq(List list, Period period, int i) {
        list.add(period.getPeriod(i));
    }
    protected Date getChildCalcPeriodLargerFreq(NodeInfo nodeinfo, NodeInfo nodeinfo1, Period period)
    {
        Date date = period.getDate();
        period = period.getPeriod(nodeinfo1.frequency);
        return period.getDate();
    }
    
    public void addParentMeasureUpdatePeriod(NodeInfo nodeinfo, NodeInfo nodeinfo1)  {
        nodeinfo.dirtyPeriods.addAll(nodeinfo1.dirtyPeriods);
    }
    
    public List getAffectedCalcPeriods(NodeInfo nodeinfo, NodeInfo anodeinfo[])  {
        ArrayList arraylist = new ArrayList(nodeinfo.dirtyPeriods.size());
        Period period;
        for(Iterator iterator = nodeinfo.dirtyPeriods.iterator(); iterator.hasNext(); addParentCalculationPeriod(arraylist, period, nodeinfo.frequency))
            period = (Period)iterator.next();

        Collections.sort(arraylist, new PeriodComparator());
        Collections.reverse(arraylist);
        return arraylist;
    }
    
    public GraphInfo buildEquationGraph(Map map, boolean flag)
    throws SQLException, Exception   {
	    GraphInfo graphinfo = new GraphInfo();
	    HashMap hashmap = graphinfo.nodes;
	    SQLListArray sqllistarray = new SQLListArray(100);
	    boolean flag1 = false;
	    for(Iterator iterator = map.keySet().iterator(); iterator.hasNext();)   {
	        Integer integer = (Integer)iterator.next();
	        if(integer != null)   {
	            sqllistarray.add(integer.intValue());
	            ResultSet resultset = executeQuery("SELECT Frequency, Equation FROM a_Measure WHERE Id=" + integer);
	            resultset.next();
	            String s = ServerUtil.getString(resultset, 1);
	            int i = ServerUtil.getMeasurePeriodFrequency(s); 
	            String s1 = ServerUtil.getString(resultset, 2);
	            NodeInfo nodeinfo = new NodeInfo(integer, flag ? s1 : null, 0, i);
	            hashmap.put(integer, nodeinfo);
	            Date adate[] = (Date[])map.get(integer);
	            for(int j = 0; j < adate.length; j++)
	                addChildUpdatePeriod(nodeinfo, adate[j]);
	
	            flag1 = true;
	        }
	    }
	
	    if(!flag1)  {
	        return null;
	    } else {
	        //Log.debug("ExpressionUtil.updateMeasures", "Updating calculated measure values.");
	        sqllistarray.complete();
	        graphinfo.maxLevel = buildGraphLevels(map, graphinfo, sqllistarray, 1, flag);
	        return graphinfo;
	    }
	}
    public void addChildUpdatePeriod(NodeInfo nodeinfo, Date date) {
        Period period = new Period(date, nodeinfo.frequency);
        nodeinfo.dirtyPeriods.add(period);
    }
    
    private int buildGraphLevels(Map map, GraphInfo graphinfo, SQLListArray sqllistarray, int i, boolean flag)
    throws SQLException,Exception   {
    HashMap hashmap = graphinfo.nodes;
    ArrayList arraylist = graphinfo.edgeList;
    boolean flag1 = true;
    SQLListArray sqllistarray1 = new SQLListArray(100);
    int j = sqllistarray.size();
    for(int k = 0; k < j; k++)
    {
        StringBuffer stringbuffer = new StringBuffer();
        stringbuffer.append("SELECT DISTINCT d2.ChildId, d2.ParentId, mp.Equation, mp.Frequency, mc.Frequency FROM ");
        stringbuffer.append("a_measure");
        stringbuffer.append(" mp, ");
        stringbuffer.append("a_measure");
        stringbuffer.append(" mc, ");
        if(flag)
            stringbuffer.append("measuredependent d1, measuredependent d2 WHERE d1.ParentId IN (");
        else
            stringbuffer.append("measuredependent d1, measuredependent d2 WHERE d1.ChildId IN (");
        stringbuffer.append(sqllistarray.getSQLList(k));
        stringbuffer.append(")");
        stringbuffer.append(" AND d1.ParentId=d2.ParentId AND mp.Id=d2.ParentId AND mc.id=d2.ChildId");
        for(ResultSet resultset = executeQuery(stringbuffer.toString()); resultset.next();)
        {
            int l = resultset.getInt(1);
            Integer integer = new Integer(l);
            int i1 = resultset.getInt(2);
            Integer integer1 = new Integer(i1);
            String s = ServerUtil.getString(resultset, 3);
            String s1 = ServerUtil.getString(resultset, 4);
            String s2 = ServerUtil.getString(resultset, 5);
            int j1 = ServerUtil.getMeasurePeriodFrequency(s1);
            int k1 = ServerUtil.getMeasurePeriodFrequency(s2);
            
            arraylist.add(new EdgeInfo(l, i1));
            NodeInfo nodeinfo = (NodeInfo)hashmap.get(integer1);
            if(nodeinfo != null)
            {
                nodeinfo.eqn = s;
                nodeinfo.level = i;
            } else
            {
                NodeInfo nodeinfo1 = new NodeInfo(integer1, s, i, j1);
                hashmap.put(integer1, nodeinfo1);
                sqllistarray1.add(i1);
                flag1 = false;
            }
            NodeInfo nodeinfo2 = (NodeInfo)hashmap.get(integer);
            if(nodeinfo2 == null)
            {
                NodeInfo nodeinfo3 = new NodeInfo(integer, null, 0, k1);
                hashmap.put(integer, nodeinfo3);
            }
        }

    }

    if(!flag1)
    {
        sqllistarray1.complete();
        return buildGraphLevels(map, graphinfo, sqllistarray1, i + 1, false);
    } else
    {
        return i + 1;
    }
}

}
