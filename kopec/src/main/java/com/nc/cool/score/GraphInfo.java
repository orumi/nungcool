package com.nc.cool.score;

import com.nc.util.Util;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.HashMap;

public class GraphInfo
{

    public GraphInfo() 
    {
        edgeList = new ArrayList();
        nodes = new HashMap();
        //periodFormat = Util.getDateFormat(ServerUtil.getPeriodFormat());
    }

    public void printGraph()
    {
    }

    public ArrayList edgeList;
    public HashMap nodes;
    public int maxLevel;
    public DateFormat periodFormat;
}
