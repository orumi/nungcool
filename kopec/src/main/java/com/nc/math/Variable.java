package com.nc.math;

import java.util.Hashtable;
import java.util.Vector;


public class Variable extends Expression
{

    public Variable(String s)
    {
        name = s.toUpperCase();
    }

    public String toString()
    {
        return "$" + name;
    }

    public boolean evaluable(Hashtable hashtable)
    {
        return hashtable.containsKey(name);
    }

    public Object evaluate(Hashtable hashtable)
    {
        Object obj = hashtable.get(name);
        if(obj == null)
            throw new NullPointerException(name);
        else
            return obj;
    }

    public void addUnknowns(Vector vector)
    {
        for(int i = vector.size() - 1; i >= 0; i--)
            if(name.equals((String)vector.elementAt(i)))
                return;

        vector.addElement(name);
    }

    String name;
}
