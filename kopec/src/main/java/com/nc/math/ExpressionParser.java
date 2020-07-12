package com.nc.math;

public class ExpressionParser {

    public ExpressionParser(String s) {
        tokenizer = new ExpressionTokenizer(s);
        
        //System.out.println("ExpressionTokenizer  : " +tokenizer.str );
    }

    public Expression getExpression(Expression expression, int i) {
        if(!tokenizer.hasToken())
            return expression;
        Object obj = null;
        Object obj1 = null;
        Token token ;
        Expression expression3;
        if(i == 0) {
            token = tokenizer.nextToken();
            Object obj2 = token.getValue();
            if(token.isSymbol()) {
                int j = token.getSymbol();
                if(j == 40) {
                    Expression expression1 = getExpression();
                    if(!expectSymbol(41))
                        throw new IllegalArgumentException("Missing ')' at position " + tokenizer.lastPos);
                    else
                        return expression1;
                }
                if(j == 36) {
                    Variable varexpr = new Variable((String)expect(4).getValue());
                    return varexpr;
                } else {
                    throw new IllegalArgumentException("Symbol " + j + " unexpected");
                }
            }
            if(token.isOperator() && token.isUnaryOperator()) {
                int k = token.getOperator();
                Expression expression2 = getExpression(expression, 0);
                return new Uniary(k, expression2);
            }
            if(token.isConst())
                return new Constant(obj2);
            if(token.isVariable())
                return new Variable((String)obj2);
            if(token.isIdentifier()) {
                Function funcexpr = new Function((String)obj2);
                if(!expectSymbol(40))
                    throw new IllegalArgumentException("Expected '(' after function " + obj2);
                getFuncParams(funcexpr);
                if(!expectSymbol(41))
                    throw new IllegalArgumentException("Expected ')' after function " + obj2);
                else
                    return funcexpr;
            }
            //Expression expression3;
            if(token.isReference())
            {
                Reference refexpr = new Reference(token.getReference(), "");
                if(!expectSymbol(46))
                    throw new IllegalArgumentException("Expected '.' after reference object" + obj2);
                refexpr.setFuncName((String)expect(4).getValue());
                if(!expectSymbol(40))
                    throw new IllegalArgumentException("Expected '(' after function " + obj2);
                getFuncParams(refexpr);
                if(!expectSymbol(41))
                    throw new IllegalArgumentException("Expected ')' after function " + obj2);
                else
                    return refexpr;
            } else
            {
                throw new IllegalArgumentException("Failed to parse postion " + tokenizer.pos);
            }
        }
        if(expression == null)
            expression = getExpression(null, i - 1);
        if(!tokenizer.hasToken())
            return expression;
        token = tokenizer.nextToken();
        if(!token.isOperator() || token.getOpLevel() > i)
        {
            tokenizer.pushLastToken();
            return expression;
        } else
        {
            expression3 = getExpression(null, i - 1);
            return getExpression(((Expression) (new Binary(expression, token.getOperator(), expression3))), i);
        }
    }

    public void getFuncParams(Function funcexpr)
    {
        Token token = tokenizer.nextToken();
        tokenizer.pushLastToken();
        if(token.isSymbol() && token.getSymbol() == 41)
            return;
        Expression expression = getExpression();
        funcexpr.addParam(expression);
        token = tokenizer.nextToken();
        if(token.isSymbol() && token.getSymbol() == 44)
            getFuncParams(funcexpr);
        else
            tokenizer.pushLastToken();
    }

    public Expression getExpression()
    {
        return getExpression(null, 4);
    }

    public Expression getCompleteExpression()
    {
        Expression expression = getExpression();
        if(tokenizer.hasToken())
            throw new IllegalArgumentException("Failed to parse rest of string: " + tokenizer.remainders());
        else
            return expression;
    }

    public Token expect(int i)
    {
        Token token = tokenizer.nextToken();
        if(token.getType() != i)
            throw new IllegalArgumentException("Token type " + i + " was expected but not found");
        else
            return token;
    }

    public boolean expectSymbol(int i)
    {
        Token token = tokenizer.nextToken();
        return token.isSymbol() && token.getSymbol() == i;
    }

    ExpressionTokenizer tokenizer;
}
