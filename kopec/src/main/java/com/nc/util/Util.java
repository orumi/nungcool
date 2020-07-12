package com.nc.util;

import java.io.*;
import java.math.BigDecimal;
import java.text.*;
import java.util.*;


public class Util {

  public Util() {
   }

   public static String format(Date date) {
       return _sdf_.format(date);
   }

   public static String formatTime(Date date) {
       return _stf_.format(date);
   }

   public static Date parse(String s) {
       Date date = null;
       try {
           date = _sdf_.parse(s);
       } catch(ParseException parseexception) {
           date = null;
       }
       return date;
   }

   public static Date parseTime(String s) {
       Date date = null;
       try {
           date = _stf_.parse(s);
       } catch(ParseException parseexception) {
           date = null;
       }
       return date;
   }

   public static Date parseTimeSchedule(String s){
       Date date = null;
       try {
           date = _stfs_.parse(s);
       } catch(ParseException parseexception) {
           date = null;
       }
       return date;
   }

   public static Calendar getCalendar() {
       return Calendar.getInstance();
   }

   public static Calendar getCalendar(Date date) {
       Calendar calendar = getCalendar();
       calendar.setTime(date);
       return calendar;
   }

   public static NumberFormat getNumberFormat(String s) {
       return new DecimalFormat(s);
   }

   public static SimpleDateFormat getDateFormat(String s) {
       SimpleDateFormat simpledateformat = new SimpleDateFormat(s);
       simpledateformat.setTimeZone(TimeZone.getDefault());
       return simpledateformat;
   }

   public static String getStrDate(Date date){
       SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyyMMdd");
       simpledateformat.setTimeZone(TimeZone.getDefault());
	   return simpledateformat.format(date)+"000000";
   }

   public static SimpleDateFormat getDateFormat(String s, Locale locale) {
       SimpleDateFormat simpledateformat = new SimpleDateFormat(s, locale);
       simpledateformat.setTimeZone(TimeZone.getDefault());
       return simpledateformat;
   }

   public static void setMonthMaximum(Calendar calendar)
   {
       calendar.getTime();
       calendar.set(5, 1);
       calendar.add(2, 1);
       calendar.add(5, -1);
   }

   public static String getLastMonth(String date){
       Calendar ca= Calendar.getInstance();
       ca.set(Integer.parseInt(date.substring(0,4)), Integer.parseInt(date.substring(4,6))-1,1);

       setMonthMaximum(ca);
       return getStrDate(ca.getTime());
   }



   public static String getToDay(){
	   Calendar ca = getCalendar();
	   Date da = ca.getTime();
	   return format(da);

	   //return da.toString();
   }

   public static String getToDayTime(){
	   Calendar ca = getCalendar();
	   Date da = ca.getTime();
	   return formatTime(da);
   }

   public static String getPrevQty(String strDate){
	   if (strDate==null) strDate = getToDay().substring(0,6);
	   String year = strDate.substring(0,4);
	   String month = strDate.substring(4,6);
	   int m = new Integer(month).intValue();

	   int rm = 0;
	   String strM="";
	   if (m<4){
		   rm=12;
		   int pyear = new Integer(year).intValue()-1;
		   year = String.valueOf(pyear);
	   } else if (m<7) {
		   rm=3;
	   } else if (m<10) {
		   rm=6;
	   } else {
		   rm=9;
	   }
	   if (rm<10){
		   strM="0"+rm;
	   } else {
		   strM = String.valueOf(rm);
	   }

	   return year+strM;
   }

   public static String getPrevQty2(String strDate){
	   if (strDate==null) strDate = getToDay().substring(0,6);
	   String year = strDate.substring(0,4);
	   String month = strDate.substring(4,6);
	   int m = new Integer(month).intValue();

	   int rm = 0;
	   String strM="";
	   if (m<4){
		   rm=9;
		   int pyear = new Integer(year).intValue()-1;
		   year = String.valueOf(pyear);
	   } else if (m<7) {
		   rm=12;
		   int pyear = new Integer(year).intValue()-1;
		   year = String.valueOf(pyear);
	   } else if (m<10) {
		   rm=3;
	   } else {
		   rm=6;
	   }
	   if (rm<10){
		   strM="0"+rm;
	   } else {
		   strM = String.valueOf(rm);
	   }

	   return year+strM;
   }

   public static String getPrevMonth(String strDate){
	   if (strDate==null) strDate = getToDay().substring(0,6);
	   String year = strDate.substring(0,4);
	   String month = strDate.substring(4,6);
	   int m = new Integer(month).intValue();

	   int rm = 0;
	   String strM="";
	   if (m==1){
		   rm=12;
		   int pyear = new Integer(year).intValue()-1;
		   year = String.valueOf(pyear);
	   } else {
		   rm=m-1;
	   }
	   if (rm<10){
		   strM="0"+rm;
	   } else {
		   strM = String.valueOf(rm);
	   }

	   return year+strM;
   }

	//intVal �� 10 ���� ������ "0"�� ä��� String ���� ��ȯ�Ͽ� return
	public static String fillMonth(int intVal)
	{
		String returnVal = "";
		if ( intVal < 10) returnVal = "0" + String.valueOf(intVal);
		else returnVal = String.valueOf(intVal);

		return returnVal;
	}

   public static String parseVar(String s, String as[]) {
       StringBuffer stringbuffer = new StringBuffer();
       boolean flag = false;
       int j = -1;
       do {
           int i = s.indexOf('%', j + 1);
           if(i < 0) {
               stringbuffer.append(s.substring(j + 1));
               break;
           }
           stringbuffer.append(s.substring(j + 1, i));
           j = s.indexOf('%', i + 1);
           if(j < 0)
               break;
           if(i + 1 == j) {
               stringbuffer.append('%');
           } else {
               String s1 = s.substring(i + 1, j);
               try {
                   s1 = as[Integer.parseInt(s1) - 1];
               } catch(Exception exception) {
                   s1 = null;
               }
               stringbuffer.append(s1);
           }
       } while(true);
       return stringbuffer.toString();
   }

   public static String parseVarHash(String s, Hashtable hashtable) {
       return parseVarHash(s, hashtable, '%');
   }

   public static String parseVarHash(String s, Hashtable hashtable, char c) {
       StringBuffer stringbuffer = new StringBuffer();
       boolean flag = false;
       int j = -1;
       do {
           int i = s.indexOf(c, j + 1);
           if(i < 0) {
               stringbuffer.append(s.substring(j + 1));
               break;
           }
           stringbuffer.append(s.substring(j + 1, i));
           j = s.indexOf(c, i + 1);
           if(j < 0)
               break;
           if(i + 1 == j) {
               stringbuffer.append(c);
           } else {
               String s1 = s.substring(i + 1, j);
               Object obj = hashtable.get(s1);
               if(obj == null)
                   return null;
               stringbuffer.append(obj);
           }
       } while(true);
       return stringbuffer.toString();
   }

   public static Vector getVarNames(String s) {
       return getVarNames(s, '%');
   }

   public static Vector getVarNames(String s, char c) {
       Vector vector = new Vector();
       boolean flag = false;
       int j = -1;
       do {
           int i = s.indexOf(c, j + 1);
           if(i < 0)
               break;
           j = s.indexOf(c, i + 1);
           if(j < 0)
               break;
           if(i + 1 != j)
               vector.addElement(s.substring(i + 1, j));
       } while(true);
       return vector;
   }

   public static String doubleToString(double d) {
       return doubleToString(d, 5);
   }

   public static String doubleToString(double d, int i) {
       return doubleToString(d, i, false);
   }

   public static String doubleToString(double d, int i, boolean flag) {
       BigDecimal bigdecimal = new BigDecimal(d);
       if(flag || bigdecimal.scale() > i)
           bigdecimal = bigdecimal.setScale(i, 4);
       String s = bigdecimal.toString();
       if(!flag && s.indexOf('.') >= 0) {
           int j;
           for(j = s.length() - 1; s.charAt(j) == '0'; j--);
           if(s.charAt(j) != '.')
               j++;
           s = s.substring(0, j);
       }
       return s;
   }

   public static String[] getChoiceParts(String s) {
       if(s == null)
           s = "";
       String as[] = new String[3];
       int i = s.indexOf('\t');
       if(i >= 0) {
           int j = s.indexOf('\t', i + 1);
           if(j >= 0) {
               as[2] = s.substring(j + 1);
               s = s.substring(0, j);
           }
           as[1] = s.substring(i + 1);
           s = s.substring(0, i);
       }
       as[0] = s;
       return as;
   }

   public static void writeObject(DataOutputStream dataoutputstream, Object obj)
       throws IOException {
       if(obj == null)
           dataoutputstream.writeInt(0);
       else
       if(obj instanceof Integer) {
           dataoutputstream.writeInt(4);
           dataoutputstream.writeInt(((Integer)obj).intValue());
       } else if(obj instanceof Double) {
           dataoutputstream.writeInt(8);
           dataoutputstream.writeDouble(((Double)obj).doubleValue());
       } else if(obj instanceof Date) {
           dataoutputstream.writeInt(91);
           writeDate(dataoutputstream, (Date)obj);
       } else if(obj instanceof Boolean) {
           dataoutputstream.writeInt(-7);
           dataoutputstream.writeBoolean(((Boolean)obj).booleanValue());
       } else if(obj instanceof String) {
           dataoutputstream.writeInt(12);
           dataoutputstream.writeUTF(obj != null ? (String)obj : "");
       } else if(obj instanceof String[]) {
           String as[] = (String[])obj;
           dataoutputstream.writeInt(0xf00002);
           dataoutputstream.writeInt(as.length);
           for(int i = 0; i < as.length; i++)
               dataoutputstream.writeUTF(as[i]);

       } else if(obj instanceof Object[]) {
           Object aobj[] = (Object[])obj;
           dataoutputstream.writeInt(0xf00001);
           dataoutputstream.writeInt(aobj.length);
           for(int j = 0; j < aobj.length; j++)
               writeObject(dataoutputstream, aobj[j]);

       } else {
           System.out.println("Unexpected type of object: " + obj);
       }
   }

   public static void writeDate(DataOutputStream dataoutputstream, Date date)
       throws IOException {
       dataoutputstream.writeBoolean(date != null);
       if(date != null)
           dataoutputstream.writeUTF(format(date));
   }

   public static Date readDate(DataInputStream datainputstream)
       throws IOException {
       return datainputstream.readBoolean() ? parse(datainputstream.readUTF()) : null;
   }

   public static void writeTime(DataOutputStream dataoutputstream, Date date)
       throws IOException {
       dataoutputstream.writeBoolean(date != null);
       if(date != null)
           dataoutputstream.writeUTF(formatTime(date));
   }

   public static Date readTime(DataInputStream datainputstream)
       throws IOException {
       return datainputstream.readBoolean() ? parseTime(datainputstream.readUTF()) : null;
   }

   public static Object readObject(DataInputStream datainputstream)
       throws IOException {
       return readObject(datainputstream, datainputstream.readInt());
   }

   public static Object readObject(DataInputStream datainputstream, int i)
       throws IOException {
       switch(i) {
       case 0: // '\0'
           return null;

       case -7:
           return new Boolean(datainputstream.readBoolean());

       case 4: // '\004'
           return new Integer(datainputstream.readInt());

       case 8: // '\b'
           return new Double(datainputstream.readDouble());

       case 91: // '['
           return readDate(datainputstream);

       case 12: // '\f'
           return datainputstream.readUTF();

       case 15728642:
           String as[] = new String[datainputstream.readInt()];
           for(int j = 0; j < as.length; j++)
               as[j] = datainputstream.readUTF();

           return as;

       case 15728641:
           Object aobj[] = new Object[datainputstream.readInt()];
           for(int k = 0; k < aobj.length; k++)
               aobj[k] = readObject(datainputstream);

           return ((Object) (aobj));
       }
       System.out.println("Unexpected type of object: " + i);
       return null;
   }

   public static String URLdecode(String s) {
       StringBuffer stringbuffer = new StringBuffer();
       int i = s.length();
       for(int j = 0; j < i; j++) {
           char c = s.charAt(j);
           if(c == '%')
               c = (char)Integer.parseInt("" + s.charAt(++j) + s.charAt(++j), 16);
           else if(c == '+')
               c = ' ';
           stringbuffer.append(c);
       }

       return stringbuffer.toString();
   }

   public static Properties URLParameters(String s) {
       StringTokenizer stringtokenizer = new StringTokenizer(s, "?&=");
       Properties properties = new Properties();
       properties.put("COMMAND", stringtokenizer.nextToken());
       String s1;
       String s2;
       for(; stringtokenizer.hasMoreTokens(); properties.put(s1.toUpperCase(), s2)) {
           s1 = stringtokenizer.nextToken();
           s2 = URLdecode(stringtokenizer.nextToken());
       }

       return properties;
   }

	public static Date getDate(String str){
        Calendar ca= Calendar.getInstance();
        ca.set(Integer.parseInt(str.substring(0,4)), Integer.parseInt(str.substring(4,6))-1, Integer.parseInt(str.substring(6,8)));

        return ca.getTime();
	}

	public static Date getDateStr(String str){
        Calendar ca= Calendar.getInstance();
        ca.set(Integer.parseInt(str.substring(0,4)), Integer.parseInt(str.substring(4,6))-1, Integer.parseInt(str.substring(6,8)));

        return ca.getTime();
	}

   public static int parseInt(String s) {
       try {
           return Integer.parseInt(s);
       } catch(Exception exception) {
           return 0;
       }
   }

   public static String replaceString(String s, String s1, String s2) {
       for(int i = 0; (i = s.indexOf(s1)) != -1;) {
           String s3 = s.substring(0, i);
           int j = (i + s1.length()) - 1;
           String s4 = s.length() - 1 <= j ? "" : s.substring(j + 1, s.length());
           s = s3 + s2 + s4;
       }

       return s;
   }

   public static String toText(String s) {
       if (s == null)
           return null;
       StringBuffer buf = new StringBuffer();
       char c[] = s.toCharArray();
       int len = c.length;
       for (int i = 0; i < len; i++){
           if (c[i] == '&')
               buf.append("&amp;");
           else
           if (c[i] == '<')
               buf.append("&lt;");
           else
           if (c[i] == '>')
               buf.append("&gt;");
           else
           if (c[i] == '"')
               buf.append("&quot;");
           else
           if (c[i] == '\'')
               buf.append("&#039;");
           else
               buf.append(c[i]);
       }
       //return buf.toString().replaceAll("\r\n","\r\r").replaceAll("\n","\r");
       return buf.toString().replaceAll("\r\n","''").replaceAll("\n","'");
   }

   /**
    * �÷����� ��ǥ���Ǽ��� �����͸� ��ȯ���ִ� �Լ�
    * @param s
    * @return
    */
   public static String toTextForFlexMeas(String s) {
       if (s == null)
           return null;
       StringBuffer buf = new StringBuffer();
       char c[] = s.toCharArray();
       int len = c.length;
       for (int i = 0; i < len; i++){
           if (c[i] == '&')
               buf.append("&amp;");
           else
           if (c[i] == '<')
               buf.append("&lt;");
           else
           if (c[i] == '>')
               buf.append("&gt;");
           else
           if (c[i] == '"')
               buf.append("&quot;");
           else
           if (c[i] == '\'')
               buf.append("&#039;");
           else
               buf.append(c[i]);
       }
       return buf.toString().replaceAll("\r\n","^").replaceAll("\n","^");
   }

   /**
    * toText�� �̿��� ��� ����Ʈ�� ��� ���๮�ڸ� ġȯ�ϴ� �� ������ ������ �Ǵ� ��찡 �־
    * toText���� ���๮�� ġȯ�κи� ������ �Լ�.
    * @param s
    * @return
    */
   public static String toTextForFlexList(String s) {
       if (s == null)
           return null;
       StringBuffer buf = new StringBuffer();
       char c[] = s.toCharArray();
       int len = c.length;
       for (int i = 0; i < len; i++)
           if (c[i] == '&')
               buf.append("&amp;");
           else
           if (c[i] == '<')
               buf.append("&lt;");
           else
           if (c[i] == '>')
               buf.append("&gt;");
           else
           if (c[i] == '"')
               buf.append("&quot;");
           else
           if (c[i] == '\'')
               buf.append("&#039;");
           else
               buf.append(c[i]);

       return buf.toString();
   }

   public static String getEUCKR(String s){
	   //return s;
	   String reval= null;
	   try {
		   	reval = new String(s.getBytes("8859_1"),"euc-kr");
		} catch (Exception e) {
			return "";
		}
		return reval;
   }

   public static String getUTF(String s) {
	   String reval= null;
	   try {
		   	reval = new String(s.getBytes("8859_1"),"utf-8");
		} catch (Exception e) {
			return "";
		}
		return reval;
   }

   public static String getEncode(String s) {

	   return s;     // ����
		/*
	   String reval= null;
	   try {
		   reval = new String(s.getBytes("8859_1"),"utf-8");	// pc���� �ϴ� ��
		} catch (Exception e) {
			return "";
		}
		return reval;
		*/
   }


   public static String setTestEncode(String s) {
	   String reval= null;
	   try {
		    System.out.println(s);

		   	reval = new String(s.getBytes("8859_1"),"euc-kr");
		   	System.out.println("8859_1 => euc-kr :"+reval);

		   	reval = new String(s.getBytes("8859_1"),"utf-8");
		   	System.out.println("8859_1 => utf-8 :"+reval);

		   	reval = new String(s.getBytes("euc-kr"),"8859_1");
		   	System.out.println("euc-kr => 8859_1 :"+reval);

		   	reval = new String(s.getBytes("euc-kr"),"utf-8");
		   	System.out.println("euc-kr => utf-8 :"+reval);

		   	reval = new String(s.getBytes("utf-8"),"euc-kr");
		   	System.out.println("utf-8 => euc-kr :"+reval);

		   	reval = new String(s.getBytes("utf-8"),"8859_1");
		   	System.out.println("utf-8 => 8859_1 :"+reval);

		} catch (Exception e) {
			System.out.println(e);
			return "";
		}
		return reval;
   }

   public static boolean isBriefItem(int i) {
       return i == 12 || i == 14;
   }

   static SimpleDateFormat _sdf_;
   static SimpleDateFormat _stf_;
   static SimpleDateFormat _stfs_;
   private static int days_in_month[] = {
       31, 28, 31, 30, 31, 30, 31, 31, 30, 31,
       30, 31
   };

   static {
       _sdf_ = getDateFormat("yyyyMMdd", Locale.KOREA);
       _stf_ = getDateFormat("yyyyMMddHHmmss", Locale.KOREA);
       _stfs_ = getDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
   }

   public static int periodDiff(Date date, Date date1, int i, ForDate foreigncalendar)
   {
       return periodDiff(getCalendar(date), getCalendar(date1), i, foreigncalendar);
   }

   public static int periodDiff(Calendar calendar, Calendar calendar1, int i, ForDate foreigncalendar)
   {
       if(foreigncalendar != null)
           return foreigncalendar.periodDiff(calendar, calendar1, i);
       byte byte0 = 0;
       byte byte1 = 1;
       char c = '\0';
       int j = calendar.get(1);
       int k = calendar1.get(1);
       int l = j - k;
       int i1 = 0;
       switch(i)
       {
       default:
           break;

       case 1: // '\001'
           byte0 = 6;
           c = '\u016D';
           for(int j1 = k; j1 < j; j1++)
               if(j1 % 4 == 0 && (j1 % 100 != 0 || j1 % 400 == 0))
                   i1++;

           break;

       case 2: // '\002'
           byte0 = 3;
           c = '4';
           break;

       case 3: // '\003'
           byte0 = 2;
           c = '\f';
           break;

       case 4: // '\004'
           byte0 = 2;
           byte1 = 3;
           c = '\004';
           break;

       case 5: // '\005'
           byte0 = 1;
           break;
       }
       return (calendar.get(byte0) - calendar1.get(byte0)) / byte1 + l * c + i1;
   }
   public static Calendar addPeriod(Calendar calendar, int i, int j, ForDate foreigncalendar)
   {
       if(foreigncalendar != null)
           return foreigncalendar.addPeriod(calendar, i, j);
       switch(j)
       {
       case 1: // '\001'
           calendar.add(6, i);
           break;

       case 2: // '\002'
           calendar.add(3, i);
           break;

       case 3: // '\003'
           calendar.set(5, 1);
           calendar.add(2, i);
           setMonthMaximum(calendar);
           break;

       case 4: // '\004'
           calendar.set(5, 1);
           calendar.add(2, 3 * i);
           setMonthMaximum(calendar);
           break;

       case 5:
    	   calendar.set(5,1);
    	   calendar.add(2,6*i);
    	   setMonthMaximum(calendar);
    	   break;

       case 6: // '\005'
           calendar.add(1, i);
           break;
       }
       return calendar;
   }

   public static Date addPeriod(Date date, int i, int j, ForDate foreigncalendar)
   {
       Calendar calendar = getCalendar(date);
       return addPeriod(calendar, i, j, foreigncalendar).getTime();
   }

   public static Date normalisePeriod(Date date, int i, TermsOptions periodoptions, ForDate foreigncalendar)
   {
       Calendar calendar = getCalendar(date);
       return normalisePeriod(calendar, i, periodoptions, foreigncalendar).getTime();
   }

   public static Calendar normalisePeriod(Calendar calendar, int i, TermsOptions periodoptions, ForDate foreigncalendar)
   {
       if(foreigncalendar != null)
           return foreigncalendar.normalisePeriod(calendar, i, periodoptions);
       switch(i)
       {
       case 1: // '\001'
           break;

       case 2: // '\002'
           int j = 7 - calendar.get(7);
           if(j < 0)
               j += 7;
           calendar.add(6, j);
           break;

       case 3: // '\003'
           setMonthMaximum(calendar);
           break;

       case 4: // '\004'
           double d = calendar.get(2) + 1;
           d = Math.ceil(d / 3D) * 3D;
           calendar.set(5, 1);
           calendar.set(2, (int)d - 1);
           setMonthMaximum(calendar);
           break;

       case 5: // '\005'
           double d1 = calendar.get(2) + 1;
           d1 = Math.ceil(d1 / 6D) * 6D;
           calendar.set(5, 1);
           calendar.set(2, (int)d1 - 1);
           setMonthMaximum(calendar);
           break;

       case 6: // '\006'
           //double d2 = calendar.get(2);
           //calendar.set(5, 1);
           //if((double)11 < d2)  // last Monthof Year
        	   //calendar.set(1, calendar.get(1) + 1);
           //calendar.set(2, 12);   // last Month of Year;

           double d2 = calendar.get(2);
           calendar.set(5, 1);
           if((double)11 < d2)
               calendar.set(1, calendar.get(1) + 1);
           calendar.set(2, 11);
           setMonthMaximum(calendar);

    	   setMonthMaximum(calendar);
           break;
       default:
           throw new RuntimeException("Non-existent period frequency constant: " + i);
       }
       calendar.set(11, 12);
       return calendar;
   }
   public static String getSemi(String str){
	   if (new Integer(str.substring(4,6)).intValue()<7)
		   return str.substring(0,4)+"06";
	   else
		   return str.substring(0,4)+"12";
   }

   public static boolean getBetween(int s,int e, int y, int q){
	   String cur = String.valueOf(y)+String.valueOf(q);
	   int t = Integer.parseInt(cur);
	   if ( (( (s) <= (t) ))&&(( (e)>=(t) )) ) {
		   return true;
	   } else {
		   return false;
	   }


   }

	/* json 처리 문자로 변환 ″
	 *
	 * @param title
	 * @return
	 */
	public static String ReplaceJson(String value)
	{
		if (value == null || value.equals("") || value.equals("null")) {
			return "";
		} else {
			value = Replace_String(value, "\n", "\\n");
			value = Replace_String(value, "\"", "″");
			value = Replace_String(value, "/", "\\/");
			value = Replace_String(value, "\t", "\\t");
			value = Replace_String(value, "\r", "\\r");


			return value;
		}
	}


	/**
	 * public String ReplaceCode(String title) : 데이터베이스에 저장할 때
	 * 주어진 문자열의 '\n'을 <br>로 바꿔준다.
	 * 주어진 문자열의 '를 ''로 바꿔준다.
	 * @param title
	 * @return
	 */
	public static String ReplaceCode(String title)
	{
		if (title == null || title.equals("") || title.equals("null")) {
			return "";
		} else {
			title = Replace_String(title, "\n", "<br>");
			title = Replace_String(title, "'", "''");
			return title;
		}
	}

	/**
	 * 주어진 문자열(line)의 oldString을 newString으로 바꾸어준다.
	 * @param line
	 * @param oldString
	 * @param newString
	 * @return
	 */
	public static String Replace_String(String line, String oldString , String newString)
	{
		int index = 0;

		while((index = line.indexOf(oldString, index)) >= 0) {
			// 기존의 문자열을 새로운 것으로 대체한다. (대소문자 구별을 함)
			line = line.substring(0, index) + newString + line.substring(index+ oldString.length());
			index +=newString.length();
		}

		return line;
	}
}


