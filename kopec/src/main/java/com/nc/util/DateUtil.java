//Decompiled by Jad v1.5.8d. Copyright 2001 Pavel Kouznetsov.
//Jad home page: http://www.geocities.com/kpdus/jad.html
//Decompiler options: packimports(3) 
//Source File Name:   DateUtil.java

package com.nc.util;

 

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class DateUtil
{

 public DateUtil()
 {
 }

 public static boolean hasSmallerInterval(int i, int j)
 {
     return i < j;
 }
 public static int compareDay(Calendar calendar, Calendar calendar1)
 {
     int i = calendar.get(1);
     int j = calendar1.get(1);
     if(i < j)
         return -1;
     if(i > j)
         return 1;
     int k = calendar.get(2);
     int l = calendar1.get(2);
     if(k < l)
         return -1;
     if(k > l)
     {
         return 1;
     } else
     {
         int i1 = calendar.get(5);
         int j1 = calendar1.get(5);
         return i1 - j1;
     }
 }

 public static String getDate()
 {
     SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
     Date currentdate = new Date();
     return formatter.format(currentdate);
 }

 public static String getNoon(String str)
 {
     if(str == null)
         return str;
     if(str.length() != 4)
         return str;
     int noon = Integer.parseInt(str);
     if(noon < 1200)
         return "\uC624\uC804";
     else
         return "\uC624\uD6C4";
 }

 public static String date(String str, String sep)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 8)
         return str;
     if(str.equals("00000000") || str.equals("       0") || str.equals("        "))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 4))))).append(sep).append(str.substring(4, 6)).append(sep).append(str.substring(6, 8))));
         return temp;
     }
 }

 public static String date2(String str, String sep)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 6)
         return str;
     if(str.equals("000000") || str.equals("     0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 2))))).append(sep).append(str.substring(2, 4)).append(sep).append(str.substring(4, 6))));
         return temp;
     }
 }

 public static String dotDate(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 8)
         return str;
     if(str.equals("00000000") || str.equals("       0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 4))))).append(".").append(str.substring(4, 6)).append(".").append(str.substring(6, 8))));
         return temp;
     }
 }

 public static String dotMM(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 4)
         return str;
     if(str.equals("0000") || str.equals("   0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 2))))).append(".").append(str.substring(2, 4))));
         return temp;
     }
 }

 public static String dotDateTime(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 14)
         return str;
     if(str.equals("00000000") || str.equals("       0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 4))))).append(".").append(str.substring(4, 6)).append(".").append(str.substring(6, 8)).append(" ").append(str.substring(8, 10)).append(":").append(str.substring(10, 12)).append(":").append(str.substring(12, 14))));
         return temp;
     }
 }

 public static String dotYM(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 6)
         return str;
     if(str.equals("000000") || str.equals("     0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 4))))).append(".").append(str.substring(4, 6))));
         return temp;
     }
 }

 public static String dashDate(String str)
 {
     String temp = null;
     if(str == null)
         str = "";
     int len = str.length();
     if(len != 8 || str.equals("        "))
         return str;
     if(str.equals("00000000") || str.equals("       0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 4))))).append("-").append(str.substring(4, 6)).append("-").append(str.substring(6, 8))));
         return temp;
     }
 }

 public static String dashYM(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 6)
         return str;
     if(str.equals("000000") || str.equals("     0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 4))))).append("-").append(str.substring(4, 6))));
         return temp;
     }
 }

 public static String hanDate(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 8)
         return str;
     if(str.equals("00000000") || str.equals("       0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 4))))).append("\uB144 ").append(Integer.parseInt(str.substring(4, 6))).append("\uC6D4 ").append(Integer.parseInt(str.substring(6, 8))).append("\uC77C")));
         return temp;
     }
 }

 public static String hanDate2(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 6)
         return str;
     if(str.equals("000000") || str.equals("     0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 2))))).append("\uB144 ").append(Integer.parseInt(str.substring(2, 4))).append("\uC6D4 ").append(Integer.parseInt(str.substring(4, 6))).append("\uC77C")));
         return temp;
     }
 }

 public static String hanYM(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 6)
         return str;
     if(str.equals("000000") || str.equals("     0"))
     {
         return "";
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 4))))).append("\uB144 ").append(Integer.parseInt(str.substring(4, 6))).append("\uC6D4")));
         return temp;
     }
 }

 public static String dotTime(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 6)
     {
         return str;
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 2))))).append(":").append(str.substring(2, 4)).append(":").append(str.substring(4, 6))));
         return temp;
     }
 }

 public static String dotHM(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len < 4)
     {
         return str;
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(str.substring(0, 2))))).append(":").append(str.substring(2, 4))));
         return temp;
     }
 }

 public static String hanHM(String str)
 {
     String temp = null;
     if(str == null)
         return "";
     int len = str.length();
     if(len != 4)
     {
         return str;
     } else
     {
         temp = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(Integer.parseInt(str.substring(0, 2)))))).append("\uC2DC ").append(Integer.parseInt(str.substring(2, 4))).append("\uBD84")));
         return temp;
     }
 }

 public static String fixDate(int y, int m, int d)
 {
     String mm = null;
     String dd = null;
     mm = "".concat(String.valueOf(String.valueOf(m)));
     dd = "".concat(String.valueOf(String.valueOf(d)));
     if(m < 10)
         mm = "0".concat(String.valueOf(String.valueOf(mm)));
     if(d < 10)
         dd = "0".concat(String.valueOf(String.valueOf(dd)));
     return String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(y)))).append(mm).append(dd)));
 }

 public static String date(String date)
     throws Exception
 {
     return date(date, 1);
 }

 public static String date(String date, int lang)
     throws Exception
 {
     try
     {
         String language = null;
         String country = null;
         String result = null;
         Locale locale = null;
         DateFormat f = null;
         SimpleDateFormat sdf = null;
         if(date == null)
         {
             String s = "";
             return s;
         }
         date = date.trim();
         if(date.equals(""))
         {
             String s1 = "";
             return s1;
         }
         if(date.length() != 8)
             throw new Exception(String.valueOf(String.valueOf((new StringBuffer("[DateUtil.date] \uB0A0\uC9DC(")).append(date).append(")\uAC00 8\uC790\uB9AC\uAC00 \uC544\uB2D9\uB2C8\uB2E4"))));
         switch(lang)
         {
         case 1: // '\001'
             language = "ko";
             country = "KR";
             break;

         case 2: // '\002'
             language = "en";
             country = "US";
             break;
         }
         sdf = new SimpleDateFormat("yyyyMMdd");
         locale = new Locale(language, country);
         f = DateFormat.getDateInstance(2, locale);
         result = f.format(new Date(sdf.parse(date).getTime()));
         String s2 = result;
         return s2;
     }
     catch(Exception e)
     {
         throw new Exception();
     }
 }

 public static String date(Date d)
 {
     Calendar cal = Calendar.getInstance();
     cal.setTime(d);
     int yy = cal.get(1);
     int mo = cal.get(2) + 1;
     int dd = cal.get(5);
     String yyy = null;
     String mmo = null;
     String ddd = null;
     yyy = "".concat(String.valueOf(String.valueOf(yy)));
     if(mo < 10)
         mmo = "0".concat(String.valueOf(String.valueOf(mo)));
     else
         mmo = "".concat(String.valueOf(String.valueOf(mo)));
     if(dd < 10)
         ddd = "0".concat(String.valueOf(String.valueOf(dd)));
     else
         ddd = "".concat(String.valueOf(String.valueOf(dd)));
     String addDate = String.valueOf(String.valueOf((new StringBuffer("")).append(yyy).append(mmo).append(ddd)));
     return addDate;
 }

 public static String dateForSQL(String date)
     throws Exception
 {
     if(date == null)
         return "";
     if(date.length() != 8)
     {
         return "";
     } else
     {
         String tempDate = "";
         tempDate = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(date.substring(4, 6))))).append("-").append(date.substring(6, 8)).append("-").append(date.substring(0, 4))));
         return tempDate;
     }
 }

 public static String time(String time)
     throws Exception
 {
     return time(time, 1);
 }

 public static String time(String time, int lang)
     throws Exception
 {
     try
     {
         String language = null;
         String country = null;
         String result = null;
         Locale locale = null;
         DateFormat f = null;
         SimpleDateFormat sdf = null;
         if(time == null)
         {
             String s = "";
             return s;
         }
         if(time.length() != 6)
             throw new Exception();
         switch(lang)
         {
         case 1: // '\001'
             language = "ko";
             country = "KR";
             break;

         case 2: // '\002'
             language = "en";
             country = "US";
             break;
         }
         sdf = new SimpleDateFormat("hhmmss");
         locale = new Locale(language, country);
         f = DateFormat.getTimeInstance(2, locale);
         result = f.format(new Date(sdf.parse(time).getTime()));
         String s1 = result;
         return s1;
     }
     catch(Exception e)
     {
         throw new Exception();
     }
 }

 public static java.sql.Date convertDateType(String date)
     throws Exception
 {
     java.sql.Date convertedDate = null;
     SimpleDateFormat sdf = null;
     if(date == null || date.length() != 8)
         throw new Exception();
     sdf = new SimpleDateFormat("yyyyMMdd");
     try
     {
         convertedDate = new java.sql.Date(sdf.parse(date).getTime());
     }
     catch(ParseException pe)
     {
         throw new Exception();
     }
     return convertedDate;
 }

 public static Calendar convertCalendarType(String date)
     throws Exception
 {
     Calendar convertedDate = null;
     SimpleDateFormat sdf = null;
     if(date == null || date.length() != 8)
         throw new Exception();
     sdf = new SimpleDateFormat("yyyyMMdd");
     try
     {
         convertedDate = Calendar.getInstance();
         convertedDate.setTime(sdf.parse(date));
     }
     catch(ParseException pe)
     {
         throw new Exception();
     }
     return convertedDate;
 }

 public static String addDays(String s, int day)
     throws ParseException
 {
     return addDays(s, day, "yyyyMMdd");
 }

 public static String addDays(String s, int day, String format)
     throws ParseException
 {
     SimpleDateFormat formatter = new SimpleDateFormat(format, Locale.KOREA);
     Date date = check(s, format);
     date.setTime(date.getTime() + (long)day * (long)1000 * (long)60 * (long)60 * (long)24);
     return formatter.format(date);
 }

 public static Date check(String s)
     throws ParseException
 {
     return check(s, "yyyyMMdd");
 }

 public static Date check(String s, String format)
     throws ParseException
 {
     if(s == null)
         throw new ParseException("date string to check is null", 0);
     if(format == null)
         throw new ParseException("format string to check date is null", 0);
     SimpleDateFormat formatter = new SimpleDateFormat(format, Locale.KOREA);
     Date date = null;
     try
     {
         date = formatter.parse(s);
     }
     catch(ParseException e)
     {
         throw new ParseException(String.valueOf(String.valueOf((new StringBuffer(" wrong date:\"")).append(s).append("\" with format \"").append(format).append("\""))), 0);
     }
     if(!formatter.format(date).equals(s))
         throw new ParseException(String.valueOf(String.valueOf((new StringBuffer("Out of bound date:\"")).append(s).append("\" with format \"").append(format).append("\""))), 0);
     else
         return date;
 }

 public static int getDayOfWeek(String datestr)
 {
     int yyyy = Integer.parseInt(datestr.substring(0, 4));
     int mm = Integer.parseInt(datestr.substring(4, 6)) - 1;
     int dd = Integer.parseInt(datestr.substring(6, 8));
     Calendar cal = Calendar.getInstance();
     cal.set(yyyy, mm, dd);
     return cal.get(7);
 }

 public static boolean checkDate(String date)
 {
     return checkDate(date, "yyyyMMdd");
 }

 public static boolean checkDate(String date, String format)
 {
     try
     {
         check(date, format);
         boolean flag = true;
         return flag;
     }
     catch(Exception e)
     {
         boolean flag1 = false;
         return flag1;
     }
 }
 /*
  *  날짜 에서 "-" 없애주는 클래스 
  * 
  */
 public static String convertFormat(String date) throws Exception {
  	String returnVal = "";
  	if ( date == null || date.length() != 10) throw new Exception();
  	returnVal = date.substring(0,4) + date.substring(5,7) + date.substring(8,10);
  	return returnVal;
  }

 public static void main(String args[])
 {
     try
     {
         System.out.println(checkDate("20033727"));
     }
     catch(Exception e)
     {
         e.printStackTrace();
     }
 }
	 	/* 신상우 추가부분  
	 	 * 
	 	 */
 	  
  
 	 /*
       *  날짜 에서 "-" 없애주는 클래스 
       * 
       */
      
      /*
       *  "YYYY-MM-DD" 형태로 바꿔주는 클래스
       * 
       */
      public static String convertDFormat(String date) throws Exception {
       	String returnVal = "";
       	if ( date == null || date.length() != 8) throw new Exception();
       	returnVal = date.substring(0,4) +"-"+ date.substring(4,6) +"-"+ date.substring(6,8);
       	return returnVal;
       }
}
