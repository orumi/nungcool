package com.nc.math;

import java.util.*;

public class Binary extends Expression {

    public Binary(Expression expression, int i, Expression expression1)
    {
        expr1 = expression; 
        op = i;
        expr2 = expression1;
    }

    public boolean evaluable(Hashtable hashtable)
    {
        return expr1.evaluable(hashtable) && expr2.evaluable(hashtable);
    }

    public Object evaluate(Hashtable hashtable)
    {
        Object obj = expr1.evaluate(hashtable);
        Object obj1 = expr2.evaluate(hashtable);
        if((obj instanceof Number) && (obj1 instanceof Number))
            return eval(((Number)obj).doubleValue(), ((Number)obj1).doubleValue());
        	
        if((obj instanceof Date) && (obj1 instanceof Date))
            return eval((Date)obj, (Date)obj1);
        
        if((obj instanceof String) || (obj1 instanceof String))
            return evalString(obj, obj1);
        else
            throw new IllegalArgumentException("Illegal argument for operator " + op);
    }

    protected Object eval(double d, double d1)
    {
        double d2 = 0.0D;
        switch(op)
        {
        case 9: // '\t'
            d2 = d - d1;
            break;

        case 8: // '\b'
            d2 = d + d1;
            break;

        case 3: // '\003'
            d2 = d * d1;
            break;

        case 2: // '\002'
            d2 = d / d1;
            if(String.valueOf(d2).equals("Infinity")) d2=0.0D;
            break;

        case 4: // '\004'
            d2 = d % d1;
            break;

        case 5: // '\005'
            d2 = d == 0.0D || d1 == 0.0D ? 0.0D : 1.0D;
            break;

        case 6: // '\006'
            d2 = d == 0.0D && d1 == 0.0D ? 0.0D : 1.0D;
            break;

        case 7: // '\007'
            d2 = (d != 0.0D) ^ (d1 != 0.0D) ? 1.0D : 0.0D;
            break;

        case 10: // '\n'
            d2 = d >= d1 ? 0.0D : 1.0D;
            break;

        case 11: // '\013'
            d2 = d > d1 ? 0.0D : 1.0D;
            break;

        case 12: // '\f'
            d2 = d <= d1 ? 0.0D : 1.0D;
            break;

        case 13: // '\r'
            d2 = d < d1 ? 0.0D : 1.0D;
            break;

        case 14: // '\016'
            d2 = d != d1 ? 0.0D : 1.0D;
            break;

        case 15: // '\017'
            d2 = d == d1 ? 0.0D : 1.0D;
            break;

        default:
            throw new IllegalArgumentException("Unknown binary operator " + op);
        }
        return new Double(d2);
    }

    protected Object eval(Date date, Date date1)
    {
        long l = date.getTime();
        long l1 = date1.getTime();
        switch(op)
        {
        case 9: // '\t'
            return new Double(l - l1);

        case 8: // '\b'
            return new Double(l + l1);

        case 3: // '\003'
            return new Double(l * l1);

        case 2: // '\002'
            return new Double(l / l1);

        case 4: // '\004'
            return new Double(l % l1);

        case 10: // '\n'
            return new Double(l >= l1 ? 0.0D : 1.0D);

        case 11: // '\013'
            return new Double(l > l1 ? 0.0D : 1.0D);

        case 12: // '\f'
            return new Double(l <= l1 ? 0.0D : 1.0D);

        case 13: // '\r'
            return new Double(l < l1 ? 0.0D : 1.0D);

        case 14: // '\016'
            return new Double(l != l1 ? 0.0D : 1.0D);

        case 15: // '\017'
            return new Double(l == l1 ? 0.0D : 1.0D);

        case 5: // '\005'
        case 6: // '\006'
        case 7: // '\007'
        default:
            throw new IllegalArgumentException("Unknown date operator " + op);
        }
    }

    protected Object evalString(Object obj, Object obj1)
    {
        String s;
        if(obj instanceof Date)
            s = ExpressionTokenizer.formatDate((Date)obj);
        else
            s = obj.toString();
        String s1;
        if(obj1 instanceof Date)
            s1 = ExpressionTokenizer.formatDate((Date)obj1);
        else
            s1 = obj1.toString();
        if(op == 8)
            return s + s1;
        int i = s.compareTo(s1);
        int j = 0;
        switch(op)
        {
        case 10: // '\n'
            j = i >= 0 ? 0 : 1;
            break;

        case 11: // '\013'
            j = i > 0 ? 0 : 1;
            break;

        case 12: // '\f'
            j = i <= 0 ? 0 : 1;
            break;

        case 13: // '\r'
            j = i < 0 ? 0 : 1;
            break;

        case 14: // '\016'
            j = i != 0 ? 0 : 1;
            break;

        case 15: // '\017'
            j = i == 0 ? 0 : 1;
            break;

        default:
            throw new IllegalArgumentException("Unknown String operator " + op);
        }
        return new Double(j);
    }

    public void addUnknowns(Vector vector)
    {
        expr1.addUnknowns(vector);
        expr2.addUnknowns(vector);
    }

    public String toString()
    {
        return "(" + expr1 + ") " + Token.opNames[op] + " (" + expr2 + ")";
    }

    Expression expr1;
    Expression expr2;
    int op;
}
