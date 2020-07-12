
package com.nc.util;

import java.io.*;
import java.text.*;
import java.util.*;

public class ForDate {
  private Vector foreignDates;
  private Vector gregorDates;
  private Vector monthNames;
  private Vector shortDays;
  private Vector longDays;
  String dateFormatString;
  private SimpleDateFormat fileDateFormat;

  public class ForeignDate{

     public int year;
     public int month;
     public int date;

     public ForeignDate()
     {
     }

     public ForeignDate(String s)
     {
         StringTokenizer stringtokenizer = new StringTokenizer(s, "/ \t");
         try
         {
             date = Integer.parseInt(stringtokenizer.nextToken());
             month = Integer.parseInt(stringtokenizer.nextToken());
             year = Integer.parseInt(stringtokenizer.nextToken());
         }
         catch(Exception exception)
         {
             throw new RuntimeException("");
         }
     }
 }


 private ForDate(String s)
 {
     foreignDates = new Vector();
     gregorDates = new Vector();
     monthNames = new Vector();
     shortDays = new Vector();
     longDays = new Vector();
     dateFormatString = null;
     dateFormatString = s;
     fileDateFormat = Util.getDateFormat("dd/MM/yyyy");
 }


 private void loadFromFile(File file)
     throws IOException
 {
     if(!file.exists())
         throw new IOException("");
     BufferedReader bufferedreader = new BufferedReader(new FileReader(file));
     String s = null;
     boolean flag = false;
     s = bufferedreader.readLine();
     for(StringTokenizer stringtokenizer = new StringTokenizer(s, ","); stringtokenizer.hasMoreTokens(); monthNames.addElement(stringtokenizer.nextToken()));
     s = bufferedreader.readLine();
     for(StringTokenizer stringtokenizer1 = new StringTokenizer(s, ","); stringtokenizer1.hasMoreTokens(); shortDays.addElement(stringtokenizer1.nextToken()));
     s = bufferedreader.readLine();
     for(StringTokenizer stringtokenizer2 = new StringTokenizer(s, ","); stringtokenizer2.hasMoreTokens(); longDays.addElement(stringtokenizer2.nextToken()));
     while((s = bufferedreader.readLine()) != null)
     {
         int i = s.indexOf(',');
         foreignDates.addElement(s.substring(0, i));
         gregorDates.addElement(s.substring(i + 1, s.length()));
     }
 }

 public Vector getMonthNames()
 {
     return monthNames;
 }

 public Vector getShortDays()
 {
     return shortDays;
 }

 public Vector getLongDays()
 {
     return longDays;
 }

 public ForeignDate toForeignDate(Date date)
 {
     Calendar calendar = Calendar.getInstance();
     calendar.setTime(date);
     int i = getDateVectorIndex(gregorDates, calendar.get(5), calendar.get(2) + 1, calendar.get(1));
     Date date1 = getGregorDate(i);
     int j = Util.periodDiff(date, date1, 1, null);
     ForeignDate foreigndate = new ForeignDate((String)foreignDates.elementAt(i));
     foreigndate.date += j;
     return foreigndate;
 }

 public Date toGregDate(ForeignDate foreigndate)
 {
     int i = getDateVectorIndex(foreignDates, foreigndate.date, foreigndate.month, foreigndate.year);
     ForeignDate foreigndate1 = new ForeignDate((String)foreignDates.elementAt(i));
     int j = foreigndate.date - foreigndate1.date;
     Date date = getGregorDate(i);
     date = Util.addPeriod(date, j, 1, null);
     Calendar calendar = Calendar.getInstance();
     calendar.clear();
     calendar.setTime(date);
     calendar.set(11, 12);
     return calendar.getTime();
 }

 public Date toGregDate(int i, int j, int k)
 {
     ForeignDate foreigndate = new ForeignDate();
     foreigndate.year = i;
     foreigndate.month = j;
     foreigndate.date = k;
     return toGregDate(foreigndate);
 }

 private Date getGregorDate(int i)
 {
     String s = (String)gregorDates.elementAt(i);
     Date date = null;
     try
     {
         date = fileDateFormat.parse(s);
     }
     catch(ParseException parseexception)
     {
         throw new RuntimeException("");
     }
     return date;
 }

 private int getDateVectorIndex(Vector vector, int i, int j, int k)
 {
     int l = 0;
     int i1 = vector.size() - 1;
     ForeignDate foreigndate = new ForeignDate();
     foreigndate.date = i;
     foreigndate.month = j;
     foreigndate.year = k;
     while(i1 - l > 1)
     {
         int j1 = i1 - l;
         int k1 = j1 / 2;
         int l1 = l + k1;
         ForeignDate foreigndate1 = new ForeignDate((String)vector.elementAt(l1));
         if(dateGreaterThanEqualTo(foreigndate, foreigndate1))
             l = l1;
         else
             i1 = l1;
     }
     return l;
 }

 private boolean dateGreaterThanEqualTo(ForeignDate foreigndate, ForeignDate foreigndate1)
 {
     if(foreigndate.year > foreigndate1.year)
         return true;
     if(foreigndate.year < foreigndate1.year)
         return false;
     if(foreigndate.month > foreigndate1.month)
         return true;
     if(foreigndate.month < foreigndate1.month)
         return false;
     else
         return foreigndate.date >= foreigndate1.date;
 }

 public String periodFormat(Date date)
 {
     if(date == null)
     {
         return null;
     } else
     {
         ForeignDate foreigndate = toForeignDate(date);
         return (foreigndate.month >= 10 ? "" : "0") + foreigndate.month + "-" + foreigndate.year;
     }
 }

 public String dateFormat(Date date)
 {
     if(date == null)
         return null;
     if(dateFormatString.startsWith("F("))
     {
         String s = dateFormatString.substring(2, dateFormatString.length() - 1);
         return dateFormat(date, s);
     } else
     {
         SimpleDateFormat simpledateformat = new SimpleDateFormat(dateFormatString);
         return simpledateformat.format(date);
     }
 }

 public String dateFormat(Date date, String s)
 {
     if(date == null)
     {
         return null;
     } else
     {
         ForeignDate foreigndate = toForeignDate(date);
         int i = foreigndate.month - 1;
         String s1 = (String)monthNames.elementAt(i);
         String s2 = (foreigndate.date >= 10 ? "" : "0") + foreigndate.date;
         String s3 = (foreigndate.month >= 10 ? "" : "0") + foreigndate.month;
         String s4 = "" + foreigndate.year;
         String s5 = s4.length() <= 2 ? s4 : s4.substring(2, s4.length());
         s = Util.replaceString(s, "MMMMM", "XXXXX");
         s = Util.replaceString(s, "MM", s3);
         s = Util.replaceString(s, "dd", s2);
         s = Util.replaceString(s, "yyyy", s4);
         s = Util.replaceString(s, "yy", s5);
         s = Util.replaceString(s, "XXXXX", s1);
         return s;
     }
 }

 public Date dateParse(String s)
     throws ParseException
 {
     if(s == null || s.trim().equals(""))
         throw new ParseException("", 0);
     if(dateFormatString.startsWith("F("))
     {
         int i = -1;
         int j = -1;
         int k = -1;
         byte byte0 = -1;
         int i1 = 0;
         Object obj = null;
         try
         {
             String s2 = Util.replaceString(dateFormatString, "MMMMM", "XXXXX");
             s2 = Util.replaceString(s2, "yyyy", "ZZZZ");
             s2 = s2.substring(2, s2.length() - 1);
             int j1 = s2.indexOf("XXXXX");
             int l = j1;
             byte byte1 = -1;
             if(j1 != -1)
             {
                 int l1 = s2.length() - (j1 + 5);
                 String s1 = s.substring(j1, s.length() - l1);
                 j = getMonthIndex(s1) + 1;
                 i1 = s1.length() - 5;
             } else
             {
                 j1 = s2.indexOf("MM");
                 if(j1 != -1)
                     j = Integer.parseInt(s.substring(j1, j1 + 2));
             }
             j1 = s2.indexOf("dd");
             if(j1 != -1)
             {
                 if(l != -1 && j1 > l)
                     j1 += i1;
                 i = Integer.parseInt(s.substring(j1, j1 + 2));
             }
             j1 = s2.indexOf("ZZZZ");
             if(j1 != -1)
             {
                 if(l != -1 && j1 > l)
                     j1 += i1;
                 k = Integer.parseInt(s.substring(j1, j1 + 4));
             } else
             {
                 int k1 = s2.indexOf("yy");
                 if(k1 != -1)
                 {
                     if(l != -1 && k1 > l)
                         k1 += i1;
                     k = Integer.parseInt(s.substring(k1, k1 + 2)) + 2000;
                 }
             }
             if(i == -1 || j == -1 || k == -1)
             {
                 throw new ParseException("", 0);
             } else
             {
                 ForeignDate foreigndate = new ForeignDate();
                 foreigndate.date = i;
                 foreigndate.month = j;
                 foreigndate.year = k;
                 return toGregDate(foreigndate);
             }
         }
         catch(Exception exception)
         {
             exception.printStackTrace();
             if(exception instanceof ParseException)
                 throw (ParseException)exception;
             else
                 throw new ParseException("", 0);
         }
     } else
     {
         SimpleDateFormat simpledateformat = new SimpleDateFormat(dateFormatString);
         return simpledateformat.parse(s);
     }
 }

 private int getMonthIndex(String s)
 {
     for(int i = 0; i < monthNames.size(); i++)
         if(monthNames.elementAt(i).equals(s))
             return i;

     return -1;
 }

 public Calendar addPeriod(Calendar calendar, int i, int j)
 {
     ForeignDate foreigndate = null;
     Object obj = null;
     switch(j)
     {
     default:
         break;

     case 2: // '\002'
         i *= 7;
         // fall through

     case 1: // '\001'
         calendar.add(6, i);
         break;

     case 4: // '\004'
         foreigndate = toForeignDate(calendar.getTime());
         i *= 3;
         if(monthNames.size() == 13)
         {
             int k = ((foreigndate.month - 1) + i) / 12;
             if((foreigndate.month - 1) + i < 1)
                 k--;
             i += k;
         }
         // fall through

     case 3: // '\003'
         if(foreigndate == null)
             foreigndate = toForeignDate(calendar.getTime());
         foreigndate.month += i;
         int l = (foreigndate.month - 1) / monthNames.size();
         if(foreigndate.month - 1 < 0)
             l--;
         foreigndate.year += l;
         int i1 = foreigndate.month % monthNames.size();
         if(i1 <= 0)
             foreigndate.month = monthNames.size() + i1;
         else
             foreigndate.month = i1;
         foreigndate.date = getMonthMax(foreigndate.year, foreigndate.month);
         Date date = toGregDate(foreigndate);
         calendar.setTime(date);
         break;

     case 5: // '\005'
         ForeignDate foreigndate1 = toForeignDate(calendar.getTime());
         foreigndate1.year += i;
         foreigndate1.date = getMonthMax(foreigndate1.year, foreigndate1.month);
         Date date1 = toGregDate(foreigndate1);
         calendar.setTime(date1);
         break;
     }
     return calendar;
 }

 public int periodDiff(Calendar calendar, Calendar calendar1, int i)
 {
     int j = 0;
     ForeignDate foreigndate = toForeignDate(calendar.getTime());
     ForeignDate foreigndate1 = toForeignDate(calendar1.getTime());
     switch(i)
     {
     default:
         break;

     case 1: // '\001'
         calendar.set(11, 12);
         calendar1.set(11, 12);
         long l = calendar.getTime().getTime();
         long l1 = calendar1.getTime().getTime();
         long l2 = 0x5265c00L;
         long l3 = l - l1;
         j = (int)(l3 / l2);
         break;

     case 2: // '\002'
         calendar.set(11, 12);
         calendar1.set(11, 12);
         long l4 = calendar.getTime().getTime();
         long l5 = calendar1.getTime().getTime();
         long l6 = 0x240c8400L;
         long l7 = l4 - l5;
         j = (int)(l7 / l6);
         break;

     case 3: // '\003'
         int k = foreigndate.year - foreigndate1.year;
         j = (foreigndate.month - foreigndate1.month) + k * monthNames.size();
         break;

     case 4: // '\004'
         int i1 = foreigndate.year - foreigndate1.year;
         if(monthNames.size() == 13)
             j = ((foreigndate.month - foreigndate1.month) + i1 * 12) / 3;
         j = ((foreigndate.month - foreigndate1.month) + i1 * monthNames.size()) / 3;
         break;

     case 5: // '\005'
         j = foreigndate.year - foreigndate1.year;
         break;
     }
     return j;
 }

 public Calendar normalisePeriod(Calendar calendar, int i, TermsOptions Terms)
 {
     calendar.set(11, 12);
     Object obj = null;
     switch(i)
     {
     case 1: // '\001'
         break;

     case 2: // '\002'
         int j = Terms.lastDayOfWeek - calendar.get(7);
         if(j < 0)
             j += 7;
         calendar.add(6, j);
         break;

     case 3: // '\003'
         ForeignDate foreigndate = toForeignDate(calendar.getTime());
         foreigndate.date = getMonthMax(foreigndate.year, foreigndate.month);
         calendar.setTime(toGregDate(foreigndate));
         break;

     case 4: // '\004'
         ForeignDate foreigndate1 = toForeignDate(calendar.getTime());
         foreigndate1.month = (int)(Math.ceil((double)foreigndate1.month / 3D) * 3D);
         if(monthNames.size() == 13 && foreigndate1.month == 15)
         {
             foreigndate1.month = 3;
             foreigndate1.year++;
         }
         foreigndate1.date = getMonthMax(foreigndate1.year, foreigndate1.month);
         calendar.setTime(toGregDate(foreigndate1));
         break;

     case 5: // '\005'
         ForeignDate foreigndate2 = toForeignDate(calendar.getTime());
         if(Terms.lastMonthOfYear + 1 < foreigndate2.month)
             foreigndate2.year++;
         foreigndate2.month = Terms.lastMonthOfYear + 1;
         foreigndate2.date = getMonthMax(foreigndate2.year, foreigndate2.month);
         calendar.setTime(toGregDate(foreigndate2));
         break;

     default:
         throw new RuntimeException("Non-existent period frequency constant: " + i);
     }
     return calendar;
 }

 public boolean isLastDayOfMonth(Date date)
 {
     ForeignDate foreigndate = toForeignDate(date);
     return foreigndate.date == getMonthMax(foreigndate.year, foreigndate.month);
 }

 public int getMonthMax(int i, int j)
 {
     int k = getDateVectorIndex(foreignDates, 1, j, i);
     Date date = getGregorDate(k);
     Date date1 = getGregorDate(k + 1);
     int l = Util.periodDiff(date1, date, 1, null);
     return l;
 }

 public void write(DataOutputStream dataoutputstream)
     throws IOException
 {
     dataoutputstream.writeBoolean(dateFormatString != null);
     if(dateFormatString != null)
         dataoutputstream.writeUTF(dateFormatString);
     dataoutputstream.writeInt(monthNames.size());
     for(int i = 0; i < monthNames.size(); i++)
         dataoutputstream.writeUTF((String)monthNames.elementAt(i));

     dataoutputstream.writeInt(foreignDates.size());
     for(int j = 0; j < foreignDates.size(); j++)
         dataoutputstream.writeUTF((String)foreignDates.elementAt(j));

     for(int k = 0; k < gregorDates.size(); k++)
         dataoutputstream.writeUTF((String)gregorDates.elementAt(k));

     for(int l = 0; l < 7; l++)
         dataoutputstream.writeUTF((String)shortDays.elementAt(l));

     for(int i1 = 0; i1 < 7; i1++)
         dataoutputstream.writeUTF((String)longDays.elementAt(i1));

 }

 public void read(DataInputStream datainputstream)
     throws IOException
 {
     if(datainputstream.readBoolean())
         dateFormatString = datainputstream.readUTF();
     int i = datainputstream.readInt();
     monthNames = new Vector();
     for(int j = 0; j < i; j++)
         monthNames.addElement(datainputstream.readUTF());

     int k = datainputstream.readInt();
     foreignDates = new Vector();
     for(int l = 0; l < k; l++)
         foreignDates.addElement(datainputstream.readUTF());

     gregorDates = new Vector();
     for(int i1 = 0; i1 < k; i1++)
         gregorDates.addElement(datainputstream.readUTF());

     shortDays = new Vector();
     for(int j1 = 0; j1 < 7; j1++)
         shortDays.addElement(datainputstream.readUTF());

     longDays = new Vector();
     for(int k1 = 0; k1 < 7; k1++)
         longDays.addElement(datainputstream.readUTF());

 }
}



