package com.nc.math;

import java.util.Hashtable;
import java.util.Vector;

public abstract class Expression
{

    public Expression() { 
    }

    public boolean evaluable(Hashtable hashtable) {
        return false;
    }

    public abstract Object evaluate(Hashtable hashtable);

    public void addUnknowns(Vector vector) {
    }

    public static final int SINGLE = 1;
    public static final int DOUBLE = 2;
    public static final int FUNC = 3;
    public static final int IDENT = 4;
    public static final int CONST = 5;
}
