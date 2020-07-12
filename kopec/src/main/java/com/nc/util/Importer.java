package com.nc.util;

import java.io.IOException;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.util.Date;
import java.util.Properties;

public interface Importer {

 public abstract void setProperties(Properties properties);

 public abstract void setSource(String s);

 public abstract void load()
     throws IOException;

 public abstract int getColumnCount();

 public abstract int getRowCount();

 public abstract String[] getRow(int i);

 public abstract int getColumnIndex(String s);

 public abstract String getColumnName(int i);

 public abstract String getSourceName();

 public abstract void resetCursor();

 public abstract int getCursor();

 public abstract boolean next();

 public abstract String getString(String s);

 public abstract String getString(String s, String s1);

 public abstract String getString(int i);

 public abstract NumberFormat getNumberFormat();

 public abstract Number getNumber(String s);

 public abstract Number getNumber(int i);

 public abstract void setDateFormat(DateFormat dateformat);

 public abstract Date getDate(String s);

 public abstract Date getDate(int i);

 //public abstract void setImportListener(ImportListener importlistener);
 
 
}
