package com.nc.math;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ExpressionTokenizer
{

    public ExpressionTokenizer(String s)
    {
        if(s != null)
        {
            str = s;
            length = str.length();
        } else
        {
            throw new IllegalArgumentException("Cannot create ExpressionTokenizer with a null expression");
        }
    }

    public String remainders()
    {
        return str.substring(pos);
    }

    public boolean hasToken()
    {
        for(int i = pos; i < length; i++)
            if(!Character.isWhitespace(str.charAt(i)))
                return true;

        return false;
    }

    public Token nextToken()
    {
        char c;
        do
            c = nextChar();
        while(Character.isWhitespace(c));
        pushLast();
        lastPos = pos;
        Token token = null;
        switch(getFirstCharType(c))
        {
        case 3: // '\003'
            token = getConstToken();
            break;

        case 1: // '\001'
            token = getOperatorToken();
            break;

        case 2: // '\002'
            token = getSymbolToken();
            break;

        case 4: // '\004'
            token = getIdentifierToken();
            break;

        case 5: // '\005'
            token = getReferenceToken();
            break;

        case 6: // '\006'
            token = getVariableToken(c);
            break;

        default:
            throw new IllegalArgumentException("Unrecognised token " + c);
        }
        return token;
    }

    public int getFirstCharType(char c)
    {
        //if(Character.isDigit(c) || c == '#' || c == '"')
        if(Character.isDigit(c) || c=='"')
            return 3;
        if(Token.isOperatorStart(c))
            return 1;
        if(Token.isSymbolStart(c))
            return 2;
        if(Character.isLetter(c))
            return 4;
        if(Token.isVariableStart(c))
            return 6;
        return !Token.isReference(c) ? 0 : 5;
    }

    public Token getConstToken()
    {
        StringBuffer stringbuffer = new StringBuffer();
        boolean flag = false;
        char c = nextChar();
        Object obj = null;
        if(c == '#')
            do
            {
                c = nextChar();
                if(c == '#')
                {
                    obj = parseDate(stringbuffer.toString());
                    break;
                }
                stringbuffer.append(c);
            } while(true);
        else
        if(c == '"')
            do
            {
                c = nextChar();
                if(c == '\\')
                {
                    c = nextChar();
                    switch(c)
                    {
                    case 110: // 'n'
                        c = '\n';
                        break;

                    case 114: // 'r'
                        c = '\r';
                        break;

                    case 116: // 't'
                        c = '\t';
                        break;

                    case 98: // 'b'
                        c = '\b';
                        break;

                    case 39: // '\''
                        c = '\'';
                        break;

                    case 34: // '"'
                        c = '"';
                        break;

                    case 117: // 'u'
                        c = (char)Integer.parseInt(str.substring(pos, pos + 4), 16);
                        pos += 4;
                        break;

                    default:
                        throw new IllegalArgumentException("Unrecognised string escape :" + c);
                    }
                } else
                if(c == '"')
                {
                    obj = stringbuffer.toString();
                    break;
                }
                stringbuffer.append(c);
            } while(true);
        else
            do
            {
                if(Character.isDigit(c))
                    stringbuffer.append(c);
                else
                if(c == '.' && !flag)
                {
                    flag = true;
                    stringbuffer.append(c);
                } else
                {
                    pushLast();
                    obj = new Double(stringbuffer.toString());
                    break;
                }
                c = nextChar();
            } while(true);
        return new Token(3, obj);
    }

    public Token getSymbolToken()
    {
        return new Token(2, nextChar());
    }

    public Token getOperatorToken()
    {
        String s = "";
        int i = 0;
        do
        {
            s = s + nextChar();
            int j = Token.getOperator(s);
            if(j == 0)
            {
                pushLast();
                return new Token(1, i);
            }
            i = j;
        } while(true);
    }

    public Token getReferenceToken()
    {
        StringBuffer stringbuffer = new StringBuffer();
        char c = nextChar();
        if((c = nextChar()) != '(')
            return new Token(5, "");
        while((c = nextChar()) != ')') 
            stringbuffer.append(c);
        return new Token(5, stringbuffer.toString());
    }

    public String getIdentifierValue()
    {
        StringBuffer stringbuffer = new StringBuffer();
        boolean flag = true;
        do
        {
            char c = nextChar();
            if(Character.isLetter(c))
                stringbuffer.append(c);
            else
            if(!flag && Character.isDigit(c))
                stringbuffer.append(c);
            else
            if(!flag && (c == '_' || c == '.' || c=='#'))  //// name 
            {
                stringbuffer.append(c);
            } else
            {
                pushLast();
                return stringbuffer.toString();
            }
            flag = false;
        } while(true);
    }

    public Token getIdentifierToken()
    {
        return new Token(4, getIdentifierValue());
    }

    public Token getVariableToken(char c)
    {
        String s;
        if(c == '[')
        {
            nextChar();
            StringBuffer stringbuffer = new StringBuffer();
            char c1;
            while((c1 = nextChar()) != ']') 
                stringbuffer.append(c1);
            s = stringbuffer.toString();
        } else
        {
            s = getIdentifierValue();
        }
        return new Token(6, s);
    }

    public char lastChar()
    {
        return str.charAt(pos);
    }

    public char nextChar()
    {
        if(pos == length)
        {
            pos++;
            return ' ';
        }
        if(pos > length)
            throw new IllegalArgumentException("Unexpected end in expression string: " + str);
        else
            return str.charAt(pos++);
    }

    public char lookAheadChar()
    {
        return str.charAt(pos + 1);
    }

    public void pushLast()
    {
        pos--;
    }

    public void pushLastToken()
    {
        pos = lastPos;
    }

    public static Date parseDate(String s)
    {
        if(dateFormat == null)
            dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        try
        {
            if(s.equalsIgnoreCase("TODAY"))
                s = formatDate(new Date());
            return dateFormat.parse(s);
        }
        catch(Exception exception)
        {
            throw new IllegalArgumentException("Failed to parse Date constant: " + s);
        }
    }

    public static String formatDate(Date date)
    {
        if(dateFormat == null)
            dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        return dateFormat.format(date);
    }

    String str;
    int pos;
    int length;
    int lastPos;
    static DateFormat dateFormat;
}
