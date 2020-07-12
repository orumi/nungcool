package com.nc.cool.score;

import com.nc.math.Expression;
import com.nc.math.ExpressionParser;
import java.util.AbstractCollection;
import java.util.HashSet;

public class NodeInfo
{

    public NodeInfo(Integer integer, String s, int i, int j)
    {
        dirtyPeriods = new HashSet();
        measId = integer;
        eqn = s;
        level = i;
        frequency = j;
    }

    public Expression getExpression(){
        if(eqn == null)
            return null;
        if(expr == null) {
            ExpressionParser expressionparser = new ExpressionParser(eqn);
            expr = expressionparser.getCompleteExpression();
        }
        return expr;
    }

    public void addDirtyPeriodsFrom(NodeInfo nodeinfo)
    {
        dirtyPeriods.addAll(nodeinfo.dirtyPeriods);
    }

    public String toString()
    {
        return desc == null ? "id=" + measId : desc;
    }

    public Integer measId;
    public String eqn;
    public Expression expr;
    public String desc;
    public int frequency;
    public int level;
    public HashSet dirtyPeriods;
    public boolean unbounded;
}
