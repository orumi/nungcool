package com.nc.util;

import java.io.*;
import java.sql.*;
import java.util.Calendar;
import java.util.Locale;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.swing.JOptionPane;

public class Common_Data
{
	PrintWriter out;

/*****************************************************************************
public Common_Data() 
******************************************************************************/
	public Common_Data()
	{
		
	}

/*****************************************************************************
public Common_Data(PrintWriter o) : 출력변수를 초기화시켜준다.
******************************************************************************/
	public Common_Data(PrintWriter o)
	{
		out = o;
	}

/*****************************************************************************
public String getDate() : 날짜 중에서 년과 월과 일을 합해서 return 해준다.
******************************************************************************/
	public String getDate()
	{
		Calendar cal = Calendar.getInstance(Locale.KOREA);
		int dd = cal.get(Calendar.DATE);
		int yy = cal.get(Calendar.YEAR);
		String yy_s = String.valueOf(yy);
		int mm = cal.get(Calendar.MONTH) + 1;

		String mm_s = "", dd_s = "";

		if (mm < 10) {
			mm_s = "0" + String.valueOf(mm);
		} else {
			mm_s = String.valueOf(mm);
		}

		if (dd < 10) {
			dd_s = "0" + String.valueOf(dd);
		} else {
			dd_s = String.valueOf(dd);
		}

		String date_value = yy_s + "/" +  mm_s + "/" +  dd_s;

		return date_value;
	}
	
/*****************************************************************************
public String get_dateval() : 날짜 중에서 년과 월과 일을 합해서 return 해준다.
******************************************************************************/
	public String get_dateval()
	{
		Calendar cal = Calendar.getInstance(Locale.KOREA);
		int dd = cal.get(Calendar.DATE);
		int yy = cal.get(Calendar.YEAR);
		String yy_s = String.valueOf(yy);
		int mm = cal.get(Calendar.MONTH) + 1;

		String mm_s = "", dd_s = "";

		if (mm < 10) {
			mm_s = "0" + String.valueOf(mm);
		} else {
			mm_s = String.valueOf(mm);
		}

		if (dd < 10) {
			dd_s = "0" + String.valueOf(dd);
		} else {
			dd_s = String.valueOf(dd);
		}

		String date_value = yy_s + "/" +  mm_s + "/" +  dd_s;

		return date_value;
	}

/*****************************************************************************
public String getMinute() : 날짜 중에서 시간, 분을 구해준다.
******************************************************************************/
	public String getMinute()
	{
		Calendar cal = Calendar.getInstance(Locale.KOREA);
		int hh = cal.get(Calendar.HOUR_OF_DAY);
		String hh_s = String.valueOf(hh);
		int mi = cal.get(Calendar.MINUTE);
		String mi_s = String.valueOf(mi);

		if (mi < 10) {
			mi_s = "0" + String.valueOf(mi);
		} else {
			mi_s = String.valueOf(mi);
		}

		if (hh < 10) {
			hh_s = "0" + String.valueOf(hh);
		} else {
			hh_s = String.valueOf(hh);
		}

		String date_value = hh_s + ":" +  mi_s;

		return date_value;
	}

/*****************************************************************************
public int getYear(String Selected_Year) : 파라메타값 Selected_Year가 있으면 바로 숫자로 변경해서 넘겨주고
						만약에 없으면 오늘날짜 중에서 년도를 숫자로 변환해서 넘겨준다.
******************************************************************************/
	public int getYear(String Selected_Year)
	{
		Calendar cal = Calendar.getInstance();
		int return_year = 0;
		
		if (Selected_Year != null) {
			return_year = Integer.parseInt(Selected_Year);
		} else {
			return_year = cal.get(Calendar.YEAR);
		}
		
		return return_year;
	}
	
/*****************************************************************************
public int getMonth(String Selected_Month) : 파라메타값 Selected_Month 있으면 바로 숫자로 변경해서 넘겨주고
						만약에 없으면 오늘날짜 중에서 월을 숫자로 변환해서 넘겨준다.
******************************************************************************/
	public int getMonth(String Selected_Month)
	{
		Calendar cal = Calendar.getInstance();
		int return_month = 0;
		
		if (Selected_Month != null) {
			return_month = Integer.parseInt(Selected_Month);
		} else {
			return_month = cal.get(Calendar.MONTH);
		}
		
		return return_month;
	}
	
/*****************************************************************************
public int GetDate() : 오늘이 몇일인지 구한다.
******************************************************************************/
	public int GetDate()
	{
		Calendar cal = Calendar.getInstance();

		int return_date = cal.get(Calendar.DATE);

		return return_date; // 1~31
	}
	
/*****************************************************************************
public String Alert_Window(String message, int go_way, String link)
******************************************************************************/
	public String Alert_Window(String message, int go_way, String link)
	{
		StringBuffer sb = new StringBuffer();
		
		if (go_way == 1) {
			sb.append("<script language=JavaScript>");
			sb.append("	alert('" + message + "');");
			sb.append("	history.go(-1);	");
			sb.append("</script>		");
		} else if (go_way == 2) {
			sb.append("<script language=JavaScript>");
			sb.append("	alert('" + message + "');");
			sb.append("	location.href='" + link + "';");
			sb.append("</script>		");
		} else if (go_way == 3) {
			sb.append("<script language=JavaScript>");
			sb.append("	alert('" + message + "');");
			sb.append("	window.open(" + link + ");");
			sb.append("</script>		");
		} else if (go_way == 4) {
			sb.append("<script language=JavaScript>");
			sb.append(" function abc() {");
			sb.append("	location.href='" + link + "';");
			sb.append(" }");
			sb.append("abc();		");
			sb.append("</script>		");
		} else if (go_way == 5) {
			sb.append("<script language=JavaScript>");
			sb.append(" 	opener.location.href='" + link + "';");
			sb.append("</script>		");
		} else if (go_way == 6) {
			sb.append("<script language=JavaScript>");
			sb.append("	alert('" + message + "');");
			sb.append("	self.close();	");
			sb.append("</script>		");
		} else if (go_way == 7) {
			sb.append("<script language=JavaScript>");
			sb.append("	alert('" + message + "');");
			sb.append(" 	parent.location.href='" + link + "';");
			sb.append("</script>		");
		}
		
		return sb.toString();
	}
	
/*****************************************************************************
public int GetMonthRow(int[] Days_in_Month, int Year_val, int Month_val) : 지정된 년, 월에 몇 행이 있는지 알아낸다.
******************************************************************************/
	public int GetMonthRow(int[] Days_in_Month, int Year_val, int Month_val)
	{
		Calendar cal = Calendar.getInstance();
		cal.set(Year_val, Month_val,  1);  // 해당 월의 첫 날짜를 설정한다.
		int first_day = cal.get(Calendar.DAY_OF_WEEK) + 1;
		int return_row = 0;
		
		if (((Days_in_Month[Month_val] == 31) && (first_day >= 6)) || ((Days_in_Month[Month_val] == 30) && (first_day == 7))) {
			return_row = 6;
		} else if ((Days_in_Month[Month_val] == 28) && (first_day == 1)) {
			return_row = 4;
		} else {
			return_row = 5;
		}
		
		return return_row;
	}

/*****************************************************************************
public int GetFirstCol(int[] Days_in_Month, int Month_val) : 지정된 년, 월에 첫째날이 무슨요일인지 구한다.
******************************************************************************/
	public int GetFirstCol(int Year_val, int Month_val) 
	{
		Calendar cal = Calendar.getInstance();
		cal.set(Year_val, Month_val,  1);  // 해당 월의 첫 날짜를 설정한다.
		
		int return_col = cal.get(cal.DAY_OF_WEEK);

		return return_col; // 1 ~ 7 (일 ~ 토)
	}
	
/*****************************************************************************
public int GetLastCol(int[] Days_in_Month, int Month_val) : 지정된 년, 월에 마지막날이 무슨요일인지 구한다.
******************************************************************************/
	public int GetLastCol(int Year_val, int Month_val) 
	{
		Calendar cal = Calendar.getInstance();
		cal.set(Year_val, Month_val,  -1);  // 해당 월의 마지막 날짜를 설정한다.
		
		int return_col = cal.get(cal.DAY_OF_WEEK);

		return return_col; // 1 ~ 7 (일 ~ 토)
	}
	
/*****************************************************************************
public boolean Is_Leap(int Year_val, int Month_val) : 2월이 29일인지 확인
******************************************************************************/
	public boolean Is_Leap(int Year_val, int Month_val)
	{
		boolean leap_flag = false;
		
		if (Month_val == 1) {
			if ((Year_val % 400 == 0) || ((Year_val % 4 == 0) && (Year_val % 100 != 0))) {
				leap_flag = true;
			}
		}
		
		return leap_flag;
	}
	
/*****************************************************************************
public String date_calc(String date_val, int period) :
date_val 에서 period 만큼의 차이가 있는 날을 구함
******************************************************************************/
	public String date_calc(String date_val, int period)
	{
		Calendar start = Calendar.getInstance(); //시작일을 위한 calendar객체 
		Calendar end = Calendar.getInstance(); //시작일을 위한 calendar객체 
		
		//시작일을 년월일로 parsing 
		String syear = date_val.substring(0,4); 
		String smonth = date_val.substring(5,7); 
		String sday = date_val.substring(8); 
		
		// 각 calendar의 일자를 setting : 월은 0 - 11까지입니다. 
		start.set(Integer.parseInt(syear), Integer.parseInt(smonth)-1, Integer.parseInt(sday)); 
		start.add(Calendar.DATE, period); 
		start.add(Calendar.MONTH, 1); 
		
		String return_val = start.get(Calendar.YEAR)+"/"+start.get(Calendar.MONTH)+"/"+start.get(Calendar.DATE);

		if (return_val.substring(6, 7).equals("/")) {
			return_val = return_val.substring(0, 5) + "0" + return_val.substring(5, 6) + "/" + return_val.substring(7);
		} 

		if (return_val.length() == 9) {
			return_val = return_val.substring(0, 8) + "0" + return_val.substring(8);
		} 

		return return_val;
	}

/*****************************************************************************
public long date_operation(String s_date, String e_date) :
s_date와 e_date의 차이를 계산하는 프로그램
******************************************************************************/
	public long date_operation(String s_date, String e_date) 
	{
		Calendar start = Calendar.getInstance(); //시작일을 위한 calendar객체 
		Calendar end   = Calendar.getInstance(); //종료일을 위한 calendar객체 
		
		//시작일을 년월일로 parsing 
		String syear = s_date.substring(0,4); 
		String smonth = s_date.substring(5,7); 
		String sday = s_date.substring(8); 
		
		//종료일을 년월일로 parsing 
		String eyear = e_date.substring(0,4); 
		String emonth = e_date.substring(5,7); 
		String eday = e_date.substring(8); 
		
		// 각 calendar의 일자를 setting : 월은 0 - 11까지입니다. 
		start.set(Integer.parseInt(syear), Integer.parseInt(smonth)-1, 
		Integer.parseInt(sday)); 
		
		end.set(Integer.parseInt(eyear), Integer.parseInt(emonth)-1, 
		Integer.parseInt(eday)); 
		
		java.util.Date sdate = (java.util.Date)start.getTime(); 
		java.util.Date edate = (java.util.Date)end.getTime(); 
		
		long stime = sdate.getTime(); //1970년부터 시작일까지의 밀리초 
		long etime = edate.getTime(); //1970년부터 종료일까지의 밀리초 
		long rtime = etime - stime;   //종료일 - 시작일 
		long rday = (rtime/(1000*60*60*24)); //계산결과를 일로 바꿈 
		
		return rday;
	}

/*****************************************************************************
public String k2o(String str) : 한글타입의 데이터를 넘겨줄때 사용된다.
톰켓에서는 Cp1252 타입으로 변환을 해야 인코딩이 제대로 된다.
******************************************************************************/
	public String k2o(String str)
	{
		try {
			if (str == null)
				return null;

			return new String(str.getBytes("KSC5601"), "ISO-8859-1");
		} catch(UnsupportedEncodingException ex) {
			ex.printStackTrace();
			return "";
		}
	}
	
/*****************************************************************************
public static String o2k(String str) : 한글타입으로 데이터를 받을 때 사용된다.
톰켓에서는 Cp1252 타입을 변환을 해야 디코딩이 제대로 된다.
******************************************************************************/
	public static String o2k(String str)
	{
		try {
			if (str == null)
				return null;
			
			return new String(str.getBytes("ISO-8859-1"), "KSC5601");
		} catch(UnsupportedEncodingException ex) {
			ex.printStackTrace();
			return "";
		}
	}

/*****************************************************************************
public String ReplaceCode(String title) : 데이터베이스에 저장할 때
주어진 문자열의 '\n'을 <br>로 바꿔준다.
주어진 문자열의 '를 ''로 바꿔준다.
******************************************************************************/
	public String ReplaceCode(String title)
	{
		if (title == null || title.equals("") || title.equals("null")) {
			return "";
		} else {
			title = Replace_String(title, "\n", "<br>");
			//title = Replace_String(title, "'", "''");
			return title;
		}
	}
/*****************************************************************************
public String ReplaceCode1(String title) : 데이터베이스에 저장할 때
	주어진 문자열의 '을 삭제 바꿔해준다.
******************************************************************************/
	public String ReplaceCode1(String title)
	{
		if (title == null || title.equals("") || title.equals("null")) {
			return "";
		} else {
			title = Replace_String(title, "'", "");
			return title;
		}
	}
	/*****************************************************************************
	public String ReplaceCode(String title) : 데이터베이스에 저장할 때
	주어진 문자열의 '<'을 &lt로 바꿔준다.
	주어진 문자열의 '>'를 &gt로 바꿔준다.
	******************************************************************************/
		public String ReplaceCode3(String title)
		{
			if (title == null || title.equals("") || title.equals("null")) {
				return "";
			} else {
				title = Replace_String(title, "<", "&lt;");
				title = Replace_String(title, ">", "&gt;");
				return title;
			}
		}

/*****************************************************************************
public String Replace_String(String line, String oldString , String newString)
	주어진 문자열(line)의 oldString을 newString으로 바꾸어준다.
******************************************************************************/
	public String Replace_String(String line, String oldString , String newString)
	{
		int index = 0;

		while((index = line.indexOf(oldString, index)) >= 0) {
			// 기존의 문자열을 새로운 것으로 대체한다. (대소문자 구별을 함)
			line = line.substring(0, index) + newString + line.substring(index+ oldString.length());
			index +=newString.length();
		}

		return line;
	}

/*****************************************************************************
public String ReplaceBack(String line) : 화면에 데이터를 뿌려줄때
주어진 문자열의 '<br>'을 '\n'으로 바꿔준다.
******************************************************************************/
	public String ReplaceBack(String line)
	{
		if (line == null) {
			return "";
		} else {
			int index = 0;
			String oldString = "<br>", newString = "\n";

			while((index = line.indexOf(oldString, index)) >= 0) {
				// 기존의 문자열을 새로운 것으로 대체한다. (대소문자 구별을 함)
				line = line.substring(0, index) + newString + line.substring(index+ oldString.length());
				index +=newString.length();
			}

			return line;
		}
	}

/*****************************************************************************
public String Null_Check(String target) : target이 null인지를 판별해준다.
******************************************************************************/
	public static String Null_Check(String target) {
		if (target == null || target.equals("") || target.equals("null")) {
			return "&nbsp;";
		} else {
			return target;
		}
	}
	
/*****************************************************************************
public String Null_Return(String target) : target이 null인지를 판별해준다.
******************************************************************************/
	public static String Null_Return(String target)
	{
		if (target == null || target.equals("") || target.equals("null")) {
			return "";
		} else {
			return target;
		}
	}
	
/*****************************************************************************
public String Session_Check(HttpServletRequest req) : 세션이 있는지 확인한다(없으면 재로그인)
******************************************************************************/
	public String Session_Check(HttpServletRequest req)
	{
		HttpSession session = req.getSession(true);
		String u_id = "";

		if (session.isNew()) {
			session.invalidate();
			u_id = "";
		} else {
			u_id = (String) session.getValue("u_id");
		}

		return u_id;
	}
	

/*****************************************************************************
public String showAlert(String message) : 메시지를 뿌려주고 이전 페이지로 돌아간다.
******************************************************************************/
	public String showAlert(String message)
	{
		StringBuffer sb = new StringBuffer();
		sb.append("<script language=JavaScript>\n");
		sb.append("	alert(\" ").append(message).append(" \")\n");
		sb.append("	history.go(-1)");
		sb.append("</script>");

		return sb.toString();
	}
	
/*****************************************************************************
public String showAlert_target(String message, String url_val, String target) : 메시지를 뿌려주고 다른창으로 넘어가게 한다
******************************************************************************/
	public String showAlert_target(String message, String url_val, String target)
	{
		StringBuffer sb = new StringBuffer();
		sb.append("<script language=JavaScript>\n");
		sb.append("	alert(\" ").append(message).append(" \")\n");
		sb.append("	window.open('" + url_val + "', '" + target + "', 'width=300,height=400,scrollbars=no, status=no');");
		sb.append("</script>");

		return sb.toString();
	}
	
/*****************************************************************************
public String Location_Modify(String url_val) : 주어진 url로 이동한다.
******************************************************************************/
	public String Location_Modify(String url_val)
	{
		StringBuffer sb = new StringBuffer();
		sb.append("<script language=JavaScript>\n");
		sb.append("	location.href='" + url_val + "';");
		sb.append("</script>");

		return sb.toString();
	}
	
}