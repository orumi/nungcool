package com.nc.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import java.util.ArrayList;

public class SQLListArray {
  int capacity;
  int size;
  ArrayList list;
  StringBuffer buf;
  boolean completed;

  public SQLListArray(int i){
      capacity = i;
      list = new ArrayList();
      buf = new StringBuffer();
  }

  public SQLListArray(SQLListArray sqllistarray, boolean flag){
      this(sqllistarray.capacity);
      int i = sqllistarray.list.size();
      for(int j = 0; j < i; j++)
          list.add(sqllistarray.list.get(j));

      buf.append(sqllistarray.buf);
      size = sqllistarray.size;
      if(flag)
          completed = sqllistarray.completed;
  }

  public void empty(){
      list.clear();
      size = 0;
      buf = new StringBuffer(); 
      completed = false;
  }

  protected void newList(){
      list.add(buf.toString());
      size = 0;
      buf = new StringBuffer();
  }

  protected void check(){
      if(completed)
          throw new RuntimeException("This list was completed, it must be emptied before continuing");
      if(size == capacity)
          newList();
      else
      if(size > 0)
          buf.append(",");
  }

  public void add(ArrayList arraylist) {
      int i = arraylist.size();
      for(int j = 0; j < i; j++)
          add(((Number)arraylist.get(j)).intValue());

  }

  public void add(int i) {
      check();
      buf.append(i);
      size++;
  }

  public void complete() {
      if(size > 0) {
          list.add(buf.toString());
          size = 0;
      }
      completed = true;
  }

  public String getSQLList(int i){
      if(!completed)
          throw new RuntimeException("complete() must be called before getSQLList()");
      else
          return (String)list.get(i);
  }

  public int size(){
      if(!completed)
          throw new RuntimeException("complete() must be called before size()");
      else
          return list.size();
  }


}
