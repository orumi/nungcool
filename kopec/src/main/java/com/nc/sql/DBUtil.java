package com.nc.sql;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

public class DBUtil {
  public DBUtil() {
  }
  public static String getType(int i){
      switch(i) {
      case -5:
          return "BIGINT";

      case -2:
          return "BINARY";

      case -7:
          return "BIT";

      case 1: // '\001'
          return "CHAR";

      case 91: // '['
          return "DATE";

      case 3: // '\003'
          return "DECIMAL";

      case 8: // '\b'
          return "DOUBLE";

      case 6: // '\006'
          return "FLOAT";

      case 4: // '\004'
          return "INTEGER";

      case -4:
          return "LONGVARBINARY";

      case -1:
          return "LONGVARCHAR";

      case 0: // '\0'
          return "NULL";

      case 2: // '\002'
          return "NUMERIC";

      case 1111:
          return "OTHER";

      case 7: // '\007'
          return "REAL";

      case 5: // '\005'
          return "SMALLINT";

      case 92: // '\\'
          return "TIME";

      case 93: // ']'
          return "TIMESTAMP";

      case -6:
          return "TINYINT";

      case -3:
          return "VARBINARY";

      case 12: // '\f'
          return "VARCHAR";
      }
      return "UNKNOWN";
  }

  public static String getType(int i, int j){
      String s = getType(i);
      if(j > 0)
          s = s + "(" + j + ")";
      return s;
  }

  public static int insertWithIdReturn(Connection connection, String s, String s1, int i)
      throws SQLException, Exception{
	  PreparedStatement pstmt = connection.prepareStatement(s1);
	  pstmt.executeUpdate();
      s1 = "SELECT id FROM " + s + " WHERE ConcurrencyId=" + i;
      ResultSet resultset = pstmt.executeQuery(s1);
      if(!resultset.next())
          throw new Exception("No Id returned from insert. ConcurrencyId in bad state.");
      int j = resultset.getInt(1);
      if(resultset.next()) {
          throw new Exception("Multiple Ids returned from insert. ConcurrencyId in bad state.");
      } else {
          s1 = "UPDATE " + s + " SET ConcurrencyId=0 WHERE ConcurrencyId=" + i;
          pstmt.executeUpdate(s1);
          return j;
      }
  }

  public static String toSQLList(int ai[]) {
      StringBuffer stringbuffer = new StringBuffer();
      int i = ai.length;
      stringbuffer.append('(');
      for(int j = 0; j < i; j++) {
          if(j > 0)
              stringbuffer.append(',');
          stringbuffer.append(ai[j]);
      }

      stringbuffer.append(')');
      return stringbuffer.toString();
  }

  public static String toSQLList(Object aobj[]){
      StringBuffer stringbuffer = new StringBuffer();
      int i = aobj.length;
      stringbuffer.append('(');
      for(int j = 0; j < i; j++) {
          if(j > 0)
              stringbuffer.append(',');
          stringbuffer.append(aobj[j]);
      }

      stringbuffer.append(')');
      return stringbuffer.toString();
  }

  public static String toSQLList(List list) {
      StringBuffer stringbuffer = new StringBuffer();
      int i = list.size();
      stringbuffer.append('(');
      for(int j = 0; j < i; j++) {
          if(j > 0)
              stringbuffer.append(',');
          stringbuffer.append(list.get(j));
      }

      stringbuffer.append(')');
      return stringbuffer.toString();
  }
}
