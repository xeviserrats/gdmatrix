
package org.santfeliu.misc.mapviewer.expr;

import java.util.HashMap;

/**
 *
 * @author realor
 */
public class CQLExpression
{
  final static HashMap<String, Operator> binaryCQLOperators = 
    new HashMap<String, Operator>();
  final static HashMap<String, Operator> unaryCQLOperators = 
    new HashMap<String, Operator>();
  final static HashMap<String, Operator> binaryNativeOperators = 
    new HashMap<String, Operator>();
  final static HashMap<String, Operator> unaryNativeOperators = 
    new HashMap<String, Operator>();
  
  static
  {
    binaryOperator("OR", Function.OR, 9, Literal.BOOLEAN);
    binaryOperator("AND", Function.AND, 8, Literal.BOOLEAN);
    binaryOperator("<", Function.LESS_THAN, 6, -1);
    binaryOperator(">", Function.GREATER_THAN, 6, -1);
    binaryOperator("<=", Function.LESS_EQUAL_THAN, 6, -1);
    binaryOperator(">=", Function.GREATER_EQUAL_THAN, 6, -1);
    binaryOperator("<>", Function.NOT_EQUAL_TO, 6, -1);
    binaryOperator("=", Function.EQUAL_TO, 6, -1);
    binaryOperator("IS", Function.IS_NULL, 4, -1);
    binaryOperator("IS NOT", Function.IS_NOT_NULL, 4, -1);
    binaryOperator("LIKE", Function.LIKE, 4, Literal.STRING);
    binaryOperator("NOT LIKE", Function.NOT_LIKE, 4, Literal.STRING);
    binaryOperator("ILIKE", Function.ILIKE, 4, Literal.STRING);
    binaryOperator("NOT ILIKE", Function.NOT_ILIKE, 4, Literal.STRING);
    binaryOperator("BETWEEN", Function.BETWEEN, 4, -1);
    binaryOperator("NOT BETWEEN", Function.NOT_BETWEEN, 4, -1);
    binaryOperator("IN", Function.IN, 4, -1);
    binaryOperator("NOT IN", Function.NOT_IN, 4, -1);
    binaryOperator("+", Function.ADD, 3, Literal.NUMBER);
    binaryOperator("-", Function.SUB, 3, Literal.NUMBER);
    binaryOperator("*", Function.MUL, 2, Literal.NUMBER);
    binaryOperator("/", Function.DIV, 2, Literal.NUMBER);
        
    unaryOperator("NOT", Function.NOT, 5, Literal.BOOLEAN);
    unaryOperator("-", Function.NEGATE, 0, Literal.NUMBER);
    unaryOperator("+", null, 0, Literal.NUMBER);
  }
  
  public static class Operator
  {
    private String symbol;
    private String function;
    private int precedence;
    private int type;
    
    Operator(String symbol, String function, int precedence, int type)
    {
      this.symbol = symbol;
      this.function = function;
      this.precedence = precedence;
      this.type = type;
    }

    public String getSymbol()
    {
      return symbol;
    }

    public String getFunction()
    {
      return function;
    }

    public int getPrecedence()
    {
      return precedence;
    }
    
    public boolean isCompound()
    {
      return symbol.indexOf(" ") != -1;
    }
    
    public int getType()
    {
      return type;
    }
  }
  
  static void binaryOperator(String symbol, String function,
     int precedence, int type)
  {
    Operator operator = new Operator(symbol, function, precedence, type);
    binaryCQLOperators.put(symbol, operator);
    binaryNativeOperators.put(function, operator);
  }

  static void unaryOperator(String symbol, String function, 
     int precedence, int type)
  {
    Operator operator = new Operator(symbol, function, precedence, type);
    unaryCQLOperators.put(symbol, operator);
    unaryNativeOperators.put(function, operator);
  }
  
  public static Operator getBinaryCQLOperator(String operator)
  {
    return binaryCQLOperators.get(operator);
  }
  
  public static Operator getUnaryCQLOperator(String operator)
  {
    return unaryCQLOperators.get(operator);
  }

  public static Operator getBinaryNativeOperator(String operator)
  {
    return binaryNativeOperators.get(operator);
  }
  
  public static Operator getUnaryNativeOperator(String operator)
  {
    return unaryNativeOperators.get(operator);
  }
}
