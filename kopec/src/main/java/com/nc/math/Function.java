package com.nc.math;

import java.lang.reflect.Method;
import java.util.Hashtable;
import java.util.Vector;

public class Function extends Expression
{

    public static boolean IsFunction(String s)
    {
        s = s.toUpperCase();
        for(int i = 0; i < func_list.length; i++)
            if(func_list[i].equals(s))
                return true;

        return false;  
    }

    public Function(String s)
    {
        name = s;
        params = new Vector();
    }

    public boolean evaluable(Hashtable hashtable)
    {
        for(int i = params.size() - 1; i >= 0; i--)
        {
            Expression expression = (Expression)params.elementAt(i);
            if(!expression.evaluable(hashtable))
                return false;
        }

        String s = name.toUpperCase();
        if(s.equals("MIN") || s.equals("MAX") || s.equals("AVERAGE") || s.equals("SUM") || s.equals("PRODUCT") || s.equals("VALUEOF"))
            return params.size() > 0;
        if(s.equals("RAND"))
            return params.size() == 0;
        else
            return true;
    }

    public Object evaluate(Hashtable hashtable)
    {
        int i = params.size();
        Object aobj[] = new Object[i];
        for(int j = 0; j < i; j++)
        {
            Expression expression = (Expression)params.elementAt(j);
            aobj[j] = expression.evaluate(hashtable);
        }

        int k = name.lastIndexOf('.');
        Object obj = null;
        if(k >= 0)
        {
            String s = name.substring(0, k);
            String s2 = name.substring(k + 1);
            try
            {
                Class class1 = Class.forName(s);
                Class aclass[] = new Class[i];
                for(int l = 0; l < i; l++)
                    aclass[l] = Double.TYPE;

                Method method = class1.getMethod(s2, aclass);
                obj = method.invoke(null, aobj);
            }
            catch(Exception exception)
            {
                exception.printStackTrace();
                throw new IllegalArgumentException("Failed on call to math func " + name);
            }
        } else
        {
            String s1 = name.toUpperCase();
            double d = 0.0D;
            Library funclib = new Library();
            if(s1.equals("VALUEOF"))
            {
                d = funclib.valueOf(aobj); 
            } else
            {
                double ad[] = new double[i];
                for(int i1 = 0; i1 < i; i1++)
                    ad[i1] = ((Double)aobj[i1]).doubleValue();

                if(s1.equals("MIN"))
                    d = funclib.min(ad);
                else
                if(s1.equals("MAX"))
                    d = funclib.max(ad);
                else
                if(s1.equals("AVERAGE"))
                    d = funclib.average(ad);
                else
                if(s1.equals("SUM"))
                    d = funclib.sum(ad);
                else
                if(s1.equals("PRODUCT"))
                    d = funclib.product(ad);
                else
                if(s1.equals("RAND"))
                    d = funclib.random();
                else
                    throw new IllegalArgumentException("Unknown function " + s1);
            }
            obj = new Double(d);
        }
        return obj;
    }

    public void addUnknowns(Vector vector)
    {
        int i = 0;
        for(int j = params.size(); i < j; i++)
        {
            Expression expression = (Expression)params.elementAt(i);
            expression.addUnknowns(vector);
        }

    }

    public void addParam(Expression expression)
    {
        params.addElement(expression);
    }

    public String toString()
    {
        return name + "(" + params + ")";
    }

    public static String func_list[] = {
        "MIN", "MAX", "AVERAGE", "PRODUCT", "RAND", "VALUEOF"
    };
    public static int parm_list[] = {
        -1, -1, -1, -1, -1, -1
    };
    String name;
    Vector params;

}
