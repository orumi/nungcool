package com.nc.math;

import java.io.PrintStream;
import java.lang.reflect.Method;
import java.util.Hashtable;
import java.util.Vector;

public class Reference extends Function
{

    public Reference(String s, String s1)
    {
        super(s1);
        key_string = "";
        key_string = s;
    }

    public Reference(int i, String s)
    {
        super(s);
        key_string = "";
        key_string = "" + i;
    }

    public void setFuncName(String s)
    {
        super.name = s;
    }

    public boolean evaluable(Hashtable hashtable)
    {
        try
        {
            Object obj = hashtable.get(key_string);
            if(obj == null)
            {
                System.out.println("cannot find object");
                return false;
            }
            Class class1 = obj.getClass();
            Method method = null;
            Method amethod[] = class1.getMethods();
            for(int i = 0; i < amethod.length; i++)
            {
                if(!amethod[i].getName().equals(super.name) || amethod[i].getParameterTypes().length != super.params.size())
                    continue;
                method = amethod[i];
                break;
            }

            return method != null && super.evaluable(hashtable);
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return false;
    }

    public Object evaluate(Hashtable hashtable)
    {
        try
        {
            Object obj = hashtable.get(key_string);
            Class class1 = obj.getClass();
            Method method = null;
            Method amethod[] = class1.getMethods();
            for(int i = 0; i < amethod.length; i++)
            {
                Class aclass[] = amethod[i].getParameterTypes();
                if(!amethod[i].getName().equals(super.name) || aclass.length != super.params.size())
                    continue;
                method = amethod[i];
                break;
            }

            if(method != null)
            {
                Double double1 = null;
                Object aobj[] = new Object[super.params.size()];
                Class aclass1[] = method.getParameterTypes();
                for(int j = 0; j < aobj.length; j++)
                {
                    Expression expression = (Expression)super.params.elementAt(j);
                    Object obj1 = expression.evaluate(hashtable);
                    if(obj1 instanceof Double)
                        double1 = (Double)obj1;
                    if(aclass1[j].equals(Boolean.TYPE))
                        aobj[j] = new Boolean(double1 == null ? !obj1.equals("0.0") : double1.intValue() != 0);
                    else
                    if(aclass1[j].equals(Integer.TYPE))
                        aobj[j] = new Integer(double1 == null ? 0 : double1.intValue());
                    else
                    if(aclass1[j].equals(Double.TYPE))
                        aobj[j] = double1 == null ? ((Object) (new Double(0.0D))) : ((Object) (double1));
                    else
                    if(aclass1[j].equals((new String("")).getClass()))
                        aobj[j] = obj1.toString();
                    else
                        aobj[j] = obj1;
                }

                if(method.getReturnType().equals(Void.TYPE))
                {
                    method.invoke(obj, aobj);
                    return new Double(1.0D);
                } else
                {
                    return method.invoke(obj, aobj);
                }
            } else
            {
                return new Double(0.0D);
            }
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return new Double(0.0D);
    }

    public String toString()
    {
        return "$(" + key_string + ")." + super.toString();
    }

    protected String key_string;
}
