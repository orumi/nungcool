package com.nc.math;

import java.util.Hashtable;
import java.util.Vector;

public class Uniary extends Expression
{

    public Uniary(int i, Expression expression)
    {
        op = i;
        expr = expression; 
    }

    public boolean evaluable(Hashtable hashtable)
    {
        return expr.evaluable(hashtable);
    }

    public Object evaluate(Hashtable hashtable)
    {
        Number number = (Number)expr.evaluate(hashtable);
        switch(op)
        {
        case 9: // '\t'
            return new Double(-number.doubleValue());

        case 1: // '\001'
            return new Double(number.doubleValue() == 0.0D ? 1.0D : 0.0D);
        }
        throw new IllegalArgumentException("Unary Operator unknown: " + op);
    }

    public String toString()
    {
        return Token.opNames[op] + "(" + expr + ")";
    }

    public void addUnknowns(Vector vector)
    {
        expr.addUnknowns(vector);
    }

    Expression expr;
    int op;
}
