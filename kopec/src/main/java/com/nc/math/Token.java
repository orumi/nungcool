package com.nc.math;


public class Token
{

    public static int getOperator(String s)
    {
        if(s.length() > 2)
            return 0;
        for(int i = 0; i < opNames.length; i++)
            if(s.equals(opNames[i]))
                return i;

        return 0; 
    }
    
    public static boolean isOperatorStart(char c)
    {
        return "-!/*%&|^+-<>=".indexOf(c) >= 0;
    }

    public static boolean isSymbolStart(char c)
    {
        return "$(),.".indexOf(c) >= 0;
    }

    public static boolean isVariableStart(char c)
    {
        return c == '[' || c == '$';
    }

    public static boolean isReference(char c)
    {
        return "@".indexOf(c) >= 0;
    }

    public Token(int i, Object obj)
    {
        type = i;
        value = obj;
    }

    public Token(int i, int j)
    {
        type = i;
        ivalue = j;
        switch(i)
        {
        case 1: // '\001'
            value = opNames[j];
            break;

        default:
            value = String.valueOf(j);
            break;
        }
    }

    public int getType()
    {
        return type;
    }

    public Object getValue()
    {
        return value;
    }

    public boolean isConst()
    {
        return type == 3;
    }

    public boolean isOperator()
    {
        return type == 1;
    }

    public boolean isVariable()
    {
        return type == 6;
    }

    public boolean isUnaryOperator()
    {
        return ivalue == 9 || ivalue == 1;
    }

    public boolean isSymbol()
    {
        return type == 2;
    }

    public boolean isIdentifier()
    {
        return type == 4;
    }

    public boolean isReference()
    {
        return type == 5;
    }

    public int getOperator()
    {
        return ivalue;
    }

    public int getOpLevel()
    {
        return opLevel[ivalue];
    }

    public int getSymbol()
    {
        return ivalue;
    }

    public String getReference()
    {
        return (String)value;
    }

    public String toString()
    {
        return "TOKEN(" + value + ")";
    }

    public static final String OPER_LIST = "-!/*%&|^+-<>=";
    public static final String SYMBOL_LIST = "$(),.";
    public static final String REF_LIST = "@";
    public static final int OP_LEVELS = 4;
    public static final char DATE_ESC = 35;
    public static final char STRING_ESC = 34;
    public static final int UNKNOWN = 0;
    public static final int OPERATOR = 1;
    public static final int SYMBOL = 2;
    public static final int CONST = 3;
    public static final int IDENTIFIER = 4;
    public static final int REFERENCE = 5;
    public static final int VARIABLE = 6;
    public static final int SYM_LBRACKET = 40;
    public static final int SYM_RBRACKET = 41;
    public static final int SYM_VAR = 36;
    public static final int SYM_COMMA = 44;
    public static final int SYM_MEMBER = 46;
    public static final int OP_UNKNOWN = 0;
    public static final int OP_NOT = 1;
    public static final int OP_DIV = 2;
    public static final int OP_MUL = 3;
    public static final int OP_MOD = 4;
    public static final int OP_AND = 5;
    public static final int OP_OR = 6;
    public static final int OP_XOR = 7;
    public static final int OP_ADD = 8;
    public static final int OP_SUB = 9;
    public static final int OP_LT = 10;
    public static final int OP_LTE = 11;
    public static final int OP_GT = 12;
    public static final int OP_GTE = 13;
    public static final int OP_EQ = 14;
    public static final int OP_NEQ = 15;
    public static final int opLevel[] = {
        0, 0, 1, 1, 1, 4, 4, 4, 2, 2, 
        3, 3, 3, 3, 3, 3
    };
    public static final String opNames[] = {
        "?", "!", "/", "*", "%", "&", "|", "^", "+", "-", 
        "<", "<=", ">", ">=", "=", "!="
    };
    public static final String symbolsList[] = {
        "$", "(", ")", ","
    };
    int type;
    Object value;
    int ivalue;

}
