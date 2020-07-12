package com.nc.math;

import java.util.Hashtable;


public class Constant extends Expression
{

    public Constant(Object obj)
    {
        value = obj;
    }

    public boolean evaluable(Hashtable hashtable)
    {
        return true;
    }

    public Object evaluate(Hashtable hashtable)
    {
        return value;
    }

    public String toString()
    {
        return value.toString();
    }

    Object value;
}
