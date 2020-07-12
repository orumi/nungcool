
package com.nc.util;
import java.util.*;
import java.text.DecimalFormat;
import javax.servlet.http.*;


/**
*기능 : 일반적인 공통모듈     <br>
*@author
*@version   1.0.0  2000.07
*/


public class Common {

	/**
	 * <pre>
	 * <li> 입력된 날짜를  "HH:MI:SS"로 포맷하여 리턴
	 * </pre>
	 * @param   value  "YYYYMMDD" 형태 날짜값
	 * @return  String  "YYYY-MM-DD" 형태 날짜값
	 * @author  송세준
	 */
	public static String formatTime(String value){
	   if(value == null || value.trim().equals("") || value.trim().length() != 6){
		   return value;
	   }else{
		   String time = value.substring(0,2)+":"+value.substring(2,4)+":"+value.substring(4,6);
		   return time;
	   }
	}
	/**
	 * <pre>
	 * <li> 입력된 년,월의 마지막 날짜를 리턴
	 * </pre>
	 */
	public static String getMaxDayOfMonth(String value){
		Calendar now = Calendar.getInstance();
		now.set(Integer.parseInt(value.substring(0,4)),Integer.parseInt(value.substring(4,6))-1,1);
		String date = String.valueOf(now.getActualMaximum(Calendar.DATE));
		return date;
	}

	/**
	 * <pre>
	 * <li> 입력된 날짜를  "HH:MI:SS"로 포맷하여 리턴
	 * </pre>
	 * @param   value  "YYYYMMDD" 형태 날짜값
	 * @return  String  "YYYY-MM-DD" 형태 날짜값
	 * @author  송세준
	 */
    public static String getYear(String value){
        String getYear = null;
        if(value == null || value.trim().equals("") || value.trim().length() != 10){
            getYear = value;
           // return getYear;
	    }else if(value.indexOf("-")!=-1){
	        value = value.substring(0,4);

	    }
        return getYear;
	}
	/**
	 * <pre>
	 * <li> 주민번호 를  "720222-3333333"로 포맷하여 리턴
	 * </pre>
	 * @param   value  "7202223333333" 형태 날짜값
	 * @return  String  "720222-3333333" 형태 날짜값
	 * @author  송세준
	 */
	public static String formatJumin(String value){
		String jumin = null;

		if(value != null && (value.trim().length() == 13 || value.trim().length() == 10)) {
			if(value.length() ==10){
				jumin = value.substring(0,2)+"-"+value.substring(2,5)+"-"+value.substring(5,10);
			}else{
				jumin = value.substring(0,6)+"-"+value.substring(6,13);
			}

		}else{
			jumin = value;
		}
		return jumin;
	}
	/**
	 * <pre>
	 * <li> 입력된 날짜를  "YYYY-MM-DD"로 포맷하여 리턴
	 * </pre>
	 * @param   value  "YYYYMMDD" 형태 날짜값
	 * @return  String  "YYYY-MM-DD" 형태 날짜값
	 * @author 송세준
	 */
	public static String formatDate(String value){
		if(value == null || value.trim().equals("") || value.trim().length() != 8){
			return value;
		}else{
			String date = value.substring(0,4)+"-"+value.substring(4,6)+"-"+value.substring(6,8);
			return date;
		}
	}

	/**
	* 기능 : Null 문자열인 경우 공백문자열로 변환
	*@return String
	*/
	public static String filter(String str) {
		if (str==null) {
			str ="";
		}
		return str;
	}
	/**
	* 기능 : Null OBJECT인 경우 공백문자열로 변환
	*@return String
	*/
	public static String nvl(Object obj) {
		if (obj==null) {
			obj ="";
		}
		return obj.toString();
	}
	/**
	* 기능 : Null 문자열인 경우 0 로 변환
	*@return String
	*/
	public static String numfilter(String str) {
		if (str==null||("").equals(str)) {
			str ="0.0";
		}
		return str;
	}

	/**
	* 기능 : 토큰을 통해 문자열 나누어 GET하기
	*@return String
	*/
	public static String[] getToken(String str) {
		StringTokenizer st = null;
		String[] returnValue = new String[2];
		returnValue[0] = "";
		returnValue[1] = "";
		if (str == null) {
			str = "";
		}
		else {
			st = new StringTokenizer(str, ".");
			int i=0;
			while(st.hasMoreTokens()) {
				String token = st.nextToken();
				returnValue[i] = (token != null) ? token : "";
				i++;
			}
		}
		return returnValue;
	}

	/**
	* 기능 : 현재 날짜를 FORMAT에 맞게 String으로 리턴
	*@return String
	*/
	public synchronized static String getCurrentDate() {

		Calendar calendar = Calendar.getInstance(new Locale("KOREAN", "KOREA"));
		String year = "" + calendar.get(Calendar.YEAR);
		String month = (calendar.get(Calendar.MONTH) + 1) < 10 ? "0" + (calendar.get(Calendar.MONTH) + 1) : "" + (calendar.get(Calendar.MONTH) + 1);
		String date = calendar.get(Calendar.DATE) < 10 ? "0" + calendar.get(Calendar.DATE) : "" + calendar.get(Calendar.DATE);
		return year + month + date;
	}
	/**
	* 기능 : 현재 날짜를 FORMAT에 맞게 String으로 리턴
	*@return String
	*/
	public synchronized static String getCurrentDate(String sep) {

		Calendar calendar = Calendar.getInstance(new Locale("KOREAN", "KOREA"));
		String year = "" + calendar.get(Calendar.YEAR);
		String month = (calendar.get(Calendar.MONTH) + 1) < 10 ? "0" + (calendar.get(Calendar.MONTH) + 1) : "" + (calendar.get(Calendar.MONTH) + 1);
		String date = calendar.get(Calendar.DATE) < 10 ? "0" + calendar.get(Calendar.DATE) : "" + calendar.get(Calendar.DATE);
		return year + sep +  month + sep + date;
	}


	public static String line(String src) {
		int len = src.length();
		int linenum=0,i=0;
		for (i=0; i < len; i++) {
			if (src.charAt(i) == '\n') {
				linenum++;
			}
		}
		StringBuffer dest = new StringBuffer(len+linenum*3);
		for (i=0; i < len; i++) {
			if (src.charAt(i) == '\n') {
				dest.append("<br>");
			}
			else {
				dest.append(src.charAt(i));
			}

		}
		return dest.toString();
	}

	/**
	 *기능 : 문자열을 정해진 크기로 잘라서 Vector에 SET(한/영 처리)
	 *@param
	 *@return
	 */
	public static Vector toVector(String str, int len) {
			String content = replaceString(str);
			System.out.println(content);
			int size = content.length();
			String res = "";

			int cur_length=0;
			int ch_len=0;
			int cur_kor_len=0;
			Vector vt = new Vector();

			for (int i=0;i<size;i++) {
				char ch = content.charAt(i);

				if (((short)(ch/128)) != 0) {
					ch_len = 2;
					cur_kor_len += 2;
				}
				else {
					ch_len = 1;
				}

				cur_length += ch_len;

				if(cur_kor_len == 6) {
					cur_length --;
					cur_kor_len=0;
				}

				if(cur_length > len){
					res += "";
					vt.addElement(filter((String)res).trim());
					res = "";
					cur_length = ch_len;
				}
				res += ch;
			}
			vt.addElement(filter((String)res).trim());
			return vt;
	}


	/**
	 *기능 : 지정한 문자열 길이에 맞게 Contents 출력
	 *@param
	 *@return
	 */
	public static String wrapString(String content, int length){

			// 우선 무시하는 함수
			if (content == null) {
				content = "";
			}
			return content;
	}
	/**
	 *기능 : TextArea에 내용 뿌림
	 *@param
	 *@return
	 */
	public static String wrapContent(String str) {
		return replace(replace(str,  "<br>", "\n"), "&nbsp;", " ");
	}

	/**
	 *기능 : 제목 뿌림.
	 *@param
	 *@return
	 */
	public  static String wrapTitle(String title, int length) {

			int size = title.length();
			String res = "";

			int cur_length=0;
			int ch_len=0;
			int cur_kor_len=0;

			for(int i=0;i<size;i++){
				char ch = title.charAt(i);

				if(((short)(ch/128)) != 0){ cur_length += 2;cur_kor_len += 2; }
				else cur_length += 1;

				if(cur_kor_len == 6){ cur_length --; cur_kor_len=0; }
				if(cur_length > length) return res+"..";

				res += ch;
			}
			return res;
	}

	/**
	 *기능 :  문자열내 이전 문자 및 문자열을 새로운 문자 및 문자열로 변환
	 *@param
	 *@return
	 */
	public static String replace(String src, String oldstr, String newstr) {
		if (src == null)
			return null;

		StringBuffer dest = new StringBuffer("");
		int  len = oldstr.length();
		int  srclen = src.length();
		int  pos = 0;
		int  oldpos = 0;

		while ((pos = src.indexOf(oldstr, oldpos)) >= 0) {
			dest.append(src.substring(oldpos, pos));
			dest.append(newstr);
			oldpos = pos + len;
		}
		if (oldpos < srclen) {
			dest.append(src.substring(oldpos, srclen));
		}
		return dest.toString();
	}

	/**
	 *기능 :  문자열을 고정크기에 맞게 오른쪽에 공백 INPUT
	 *@param
	 *@return
	 */
	public static String RSpace(String str, int fixedCnt) {

		String cont1 = "";
		String cont2 = str + "";

		if (cont2.length() >= fixedCnt) return cont2;

		for(int i=0; i < (fixedCnt-cont2.length()); i++)	{
			cont1 = cont1 + " ";
		}
		cont1 = cont2 + cont1;
		return cont1;
	}

	/**
	 *기능 :  문자열을 고정크기에 맞게 왼쪽에 공백 INPUT
	 *@param
	 *@return
	 */
	public static String LSpace(String str, int fixedCnt) {

		String cont1 = "";
		String cont2 = str + "";

		if(cont2.length() >= fixedCnt) return cont2;

		for(int i=0; i < (fixedCnt-cont2.length()); i++) {
			cont1 = cont1 + " ";
		}
		cont1 = cont1 + cont2;
		return cont1;
	}
	/**
	 *기능 :  문자열을 고정크기에 맞게 왼쪽에 공백 INPUT
	 *@param
	 *@return
	 */
	public static String LSpaceZero(String str, int fixedCnt) {

		String cont1 = "";
		String cont2 = str + "";

		if(cont2.length() >= fixedCnt) return cont2;

		for(int i=0; i < (fixedCnt-cont2.length()); i++) {
			cont1 = cont1 + "0";
		}
		cont1 = cont1 + cont2;
		return cont1;
	}


	/**
	 * string의 값에 html tag 을 붙인다.
	 *@param
	 *@return
	 */
	public static String replaceString(String content) {

		String tempStr = "";
		byte cmpChar = 0x0d;

		for(int i = 0; i < content.length(); i++) {
			if((byte)content.charAt(i) == cmpChar) {
				if((byte)content.charAt(++i) == 0x0a) {
					tempStr = tempStr + "<br>";
				 } else {
				  --i;
				 }
			}
			else if (content.charAt(i) == '\'') {
				tempStr = tempStr + "\"";
			}
			else if (content.charAt(i) == '\n') {
				tempStr = tempStr + "<br>";
			}
			else if (content.charAt(i) == '¶') {
				tempStr = tempStr + "<br>";
			}
			else if (content.charAt(i) == '▶') {
				tempStr = tempStr + "<br>";
			}
			else if (content.charAt(i) == ' ') {
				tempStr = tempStr + "&nbsp;";
			}
			else {
				 tempStr = tempStr + String.valueOf(content.charAt(i));
			}
		}
		return tempStr;
	 }


	/**
	 *기능 : 웹에서 받은 데이타를 encoding 8859_1 -> KSC5601    <br>
	 *@param     str     browser의 string(8859_1)
	 *@return            KSC5601 type의 String
	 */

	public static String uni2Ksc(String str)  {
		String retstr=null;
		if (str != null) {
			try {
				retstr = new String(str.getBytes("8859_1"), "KSC5601");
			 }
			catch(Exception e){}
			return retstr;
		}
		else
			return "";
	}


	/**
	 *기능 : 데이타를 encoding KSC5601 -> 8859_1   <br>
	 *@param     str     string(KSC5601)
	 *@return            8859_1 type의 String
	 */

	public static String ksc2Uni(String str)  {
		String retstr=null;
		if(str != null)
		{
			try {
				retstr = new String(str.getBytes("KSC5601"), "8859_1");
			 }
			catch(Exception e){}
			return retstr;
		}
		else
			return "";
	}


	/**
	 *기능 : 주민번호로 나이계산하기.   <br>
	 *@param     jumin_id    주민번호
	 *@return                나이
	 */

	public static int getAgeCal(String jumin_id) {

		int datechk = 0;
		int calYear = 0;
		int calMonth = 0;
		int calDay = 0;

		int currYear = Calendar.getInstance(TimeZone.getTimeZone("JST")).get(Calendar.YEAR);
		// java에서 Month는 0부터 시작한다.
		// currYear = Integer.parseInt(String.valueOf(currYear).substring(2,4));
		int currMonth = Calendar.getInstance(TimeZone.getTimeZone("JST")).get(Calendar.MONTH) + 1;
		int currDay = Calendar.getInstance(TimeZone.getTimeZone("JST")).get(Calendar.DATE);

		int juYear = Integer.parseInt(jumin_id.substring(0,2));

		int sex = Integer.parseInt(jumin_id.substring(6,7));

		if(sex<3 || sex>6)

			juYear = juYear + 1900;
		else
			juYear = juYear + 2000;

		int juMonth = Integer.parseInt(jumin_id.substring(2,4));
		int juDay = Integer.parseInt(jumin_id.substring(4,6));

		int yun_flag = 0;
		if ((currYear-(currYear/400)*400) == 0) yun_flag = 1;
		if ((currYear-(currYear/100)*100) == 0) yun_flag = 0;
		if ((currYear-(currYear/4)*4) == 0) yun_flag = 1;

		if(
		   ((currMonth == 1) || (currMonth == 3) || (currMonth == 5) || (currMonth == 7) || (currMonth == 8) || (currMonth == 10) || (currMonth == 12) && (currDay == 31)) ||
		   (((currMonth == 4) || (currMonth == 6) || (currMonth == 9) || (currMonth == 11)) && (currDay == 30)) ||
		   ((yun_flag == 0) && (currMonth == 2) && (currDay == 28)) || ((yun_flag == 1) && (currMonth == 2) && (currDay == 29))
		 )
		 datechk = 1;

		calDay = currDay - juDay;
		if(calDay < 0 && datechk == 0)
			currMonth -- ;
		calMonth = currMonth - juMonth;
		if(calMonth < 0)
		{
			currYear --;
			calMonth = calMonth + 12;
		}
		calYear = currYear - juYear;
		if(calMonth > 5)
			calYear ++;

		return calYear;

	}

	/**
	 *기능 : string에서 특정문자를 없앤다.   <br>
	 *@param     str      string
	 *@param     _char    string
	 *@return    새로운   string
	 */

	public static String trimChar(String str,char _char){

		StringBuffer tempStr = new StringBuffer();

		for(int i=0; i<str.length();i++)
		{
			if(str.charAt(i) != _char)
				tempStr = tempStr.append(str.charAt(i));
		}
		return new String(tempStr);
	 }


	/**
	 *기능 : string에서 뒷쪽 공백을 없앤다  <br>
	 *@param     str      string
	 *@return    새로운   string
	 */

	public static String trimSpace(String str){


		String newStr = str.trim();

		byte b[] = newStr.getBytes();
		int nSize = b.length;

		for( int i=(nSize-1) ; i>=0 ; i--)
		{
			if( i > 0 &&
				( (b[i-1] == 0xffffffa1 && b[i] == 0xffffffa1 ) ||
				  (b[i-1] == 0xffffffe1 && b[i] == 0xffffffe1 ) ||
				  (b[i-1] == 0xffffffa1 && b[i] == 0xffffffe1 ) ))
			{
				b[i]   = 0x20;
				b[i-1] = 0x20;
			}

		}

		//한글반쪽처리
		for( int i=0 ; i<=(nSize-1) ; i++){
			if( i%2 != 0 ) {
				if( ( b[i-1]>0xffffff80 && b[i-1] != 0x20)  && b[i]==0x20) 	{
					b[i] = 0xffffffa1;

				}
			}

		}

		return (new String(b)).trim();

	 }


	/**
	 *기능 : string에서 특정문자를 다른문자로 바꾼다.  <br>
	 *@param     str      string
	 *@param     c1       바꾸고자하는 문자
	 *@param     c2       바꿀문자
	 *@return    새로운   string
	*/

	public static String replaceChar(String str,char c1,char c2){

		StringBuffer tempStr = new StringBuffer();

		for(int i=0; i<str.length();i++) {
			if(str.charAt(i) != c1)
				tempStr = tempStr.append(str.charAt(i));
			else
				tempStr = tempStr.append(c2);
		}
		return new String(tempStr);
	 }


	/**
	 *기능 : 받은 값을 #,###,###,### 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@return            #,###,###,###
	 */

	public static String dformat(String str)  {
		DecimalFormat df = new DecimalFormat("###,###,###,###,###,##0");
		String retstr=null;
		try {
		    //if(str == null || str.equals("")) return str;
		    retstr = df.format(Double.parseDouble(str));
		    if ( retstr.substring(0,1).equals(".") ) retstr = "0"+retstr;
			return retstr;
		}
		catch(NumberFormatException nfe) {
			try {
				retstr = df.format(Float.valueOf(str).floatValue());
				return retstr;
			}catch(Exception ee) {
				return "0";
			}
		}catch(Exception e)
		{
			return "0";
		}
	}
	/**
	 * <pre>
	 * <li> 입력된 숫자값을  "#,###,###,##0"로 포맷하여 리턴
	 * </pre>
	 * @param   value  number값
	 * @return  String   true: 권한있음, false:권한없음
	 */
	public static String insComma(double value){
		DecimalFormat df = new DecimalFormat("#,###,###,##0");
		return df.format(value);
	}

	/**
	 *기능 : 받은 값 * double 값을 하여 #,###,###,### 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@param     i       곱할값
	 *@return            #,###,###,###
	 */

	public static String dformat(String str,double i)  {
		DecimalFormat df = new DecimalFormat("###,###,###,###,###,##0");
		String retstr=null;
		try
		{
			retstr = df.format(Integer.parseInt(str) * i);
			return retstr;
		}catch(NumberFormatException nfe)
		{
			try
			{
				retstr = df.format(Float.valueOf(str).floatValue() * i);
				return retstr;
			}catch(Exception ee)
			{
				return "0";
			}
		}catch(Exception e)
		{
			return "0";
		}
	}
	/**
	 *기능 : 받은 값을  idx자릿수만큼 반올림한다.    <br>
	 *@param     num     value값
	 *@return            #,###,###,###
	 */
	public static String numRound(String num,int idx) {
		//String aa = "34.576";
		java.math.BigDecimal bd = new java.math.BigDecimal(num);
		bd = bd.setScale(idx, java.math.BigDecimal.ROUND_UP);

		return bd.toString();


	}


	/**
	 *기능 : 받은 값을 #,###,###,##0.0 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@return            #,###,###,###
	 */

	public static String fformat(String str)  {
		DecimalFormat df = new DecimalFormat("###,###,###,###,###,###,###,###,##0.00");
		String retstr=null;
		try
		{
		    if(str == null) return "";
		    else if(str.equals("NaN")) str="0.00";
			retstr = df.format(Integer.parseInt(str));
			return retstr;
		}catch(NumberFormatException nfe)
		{
			try
			{
				retstr = df.format(Float.valueOf(str).floatValue());
				return retstr;
			}catch(Exception ee)
			{
				return "0.00";
			}
		}catch(Exception e)
		{
			return "0.00";
		}
	}

	/**
	 *기능 : 받은 값을 #,###,###,##0.0 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@return            #,###,###,###
	 */

	public static String nullformat(String str)  {
		DecimalFormat df = new DecimalFormat("###,###,###,###,###,###,###,###,##0.000");
		String retstr=null;
		try
		{
		    if(str == null||str.equals(""))  str="";
			retstr = df.format(Integer.parseInt(str));
			return retstr;
		}catch(NumberFormatException nfe)
		{
			try
			{
				retstr = df.format(Float.valueOf(str).floatValue());
				return retstr;
			}catch(Exception ee)
			{
				return "0";
			}
		}catch(Exception e)
		{
			return "0";
		}
	}
	public static String zeroformat(String str)  {

		try
		{
		    if(str == null||str.equals(""))  str="0";

			return str;
		}catch(Exception e)
		{
			return "0";
		}
	}
	/**
	 *기능 : 받은 값을 #,###,###,##0.0 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@return            #,###,###,###
	 */

	public static String Blankformat(String str)  {
		DecimalFormat df = new DecimalFormat("#,###,###,##0.000");
		String retstr=null;
		try
		{
		    if(str == null||str.equals("")) return str="";
			retstr = df.format(Integer.parseInt(str));
			return retstr;
		}catch(NumberFormatException nfe)
		{
			try
			{
				retstr = df.format(Float.valueOf(str).floatValue());
				return retstr;
			}catch(Exception ee)
			{
				return "0";
			}
		}catch(Exception e)
		{
			return "0";
		}
	}
	/**
	 *기능 : 받은값 * double 값을 하여 #,###,###,##0.00 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@param     i       곱할값
	 *@return            #,###,###,###
	 */

	public static String fformat(String str, double i)  {
		DecimalFormat df = new DecimalFormat("###,###,###,###,###,###,###,###,##0.00");
		String retstr=null;
		try
		{
			retstr = df.format(Integer.parseInt(str) * i);
			return retstr;
		}catch(NumberFormatException nfe)
		{
			try
			{
				retstr = df.format(Float.valueOf(str).floatValue() * i);
				return retstr;
			}catch(Exception ee)
			{
				return "";
			}
		}catch(Exception e)
		{
			return "";
		}
	}

	/**
	 *기능 : 뒤에서 자리까지 특정문자로 채우기
	 *@return  			변환된 문자열
	 *       				ex) 111-222-333,'X',4 ==> 1111-222XXXX
	 */
	public static String rightFillChar(String Source,char Fillchar,int Fillcnt)
	{
		int Xpos,j=0;
		String TempStr = "";
		char szBuf = 0x00;
		Xpos=0;

		try{

		   String str = "";
		   if (str != null)
			str = Source.trim();
		   if (str.length()>0 && str.length() >= Fillcnt){
			   TempStr = Source.substring(0,str.length()-Fillcnt);
			   for(int k=0;k<Fillcnt;k++) {
					TempStr = TempStr+Fillchar;
			   }
		   }
		}catch(Exception e){
			TempStr = "";
		}

		return TempStr;
	}

	/**
	 * 기능 : 금액단위문자표기
	 *@return  			단위가 표기된 문자열
	 */
	public static String AddMoneyUnit(String Source)
	{
		String output = "";
		String szBuf = trimChar(Source,' ');
		if (szBuf.length() == 0)
			output = output + " 원";
		else
			output = output + "&nbsp;";
			return output;
	}

	/**
	 * 기능 : '0' 으로 모두 채워진 문자열을 null로 바꾸어줌.
	 *@param 	str		입력 문자열
	 *@return  			변경된 문자열
	 */
	public static String allZeroToNull(String str)
	{
		if (str == null) {
			return "";
		}
		else {
			StringBuffer sb = new StringBuffer();
			for(int i=0;i<str.length();i++)
			{
				sb.append('0');
			}
			String newStr = new String(sb);

			if(str.equals(newStr))
				return "";
			else
				return str;
		}
	}

	/**
	 * 기능 : '0'으로 모두 채워진 문자열을 &nbsp로 바꾸어줌.
	 *@param 	str		입력 문자열
	 *@return  			변경된 문자열
	 */
	public static String allZeroToNbsp(String str)
	{
		if (str == null)
		{
			return "&nbsp";
		}else
		{
			StringBuffer sb = new StringBuffer();
			for(int i=0;i<str.length();i++)
			{
				sb.append('0');
			}
			String newStr = new String(sb);

			if(str.equals(newStr))
				return "&nbsp";
			else
				return str;
		}
	}

	/**
	 * 기능 : null 문자를 대체함
	 *@param 	str		입력 문자열
	 *@return  			변경된 문자열
	 */
	public static String convertNull(String str)
	{
		if(str == null || str.equals("null"))
			return "";
		else
			return str;
	}


	/**
	 * 기능 : null 문자를 대체함
	 *@param 	str		입력 문자열
	 *@return  			변경된 문자열
	 */
	public static int parseInt(String str)  {
		int retstr=0;
		try {
			retstr = Integer.parseInt(str);
		}catch(NumberFormatException nfe)
		{
			retstr = 0;
		}catch(Exception e)
		{
			retstr = 0;
		}
		return retstr;

	}

	/**
	 * 기능 : 쿠키정보만들기
	 *@param 	res		   HttpServletResponse
	 *@param   	fieldName  이름
	 *@param    fieldValue 값
	 */
	public static void makeCookie(HttpServletResponse res, String fieldName, String fieldValue)
	{
		Cookie c = null;
		try{
			c = new Cookie(fieldName, fieldValue);
		}catch(java.lang.Exception ex){
			ex.printStackTrace();
		}
			res.addCookie(c);
	}

	/**
	 * 기능 : 쿠키정보 읽어오기
	 *@param 	req		   HttpServletRequest
	 *@param   	fieldName  이름
	 *@return  	해당쿠키값
	 */
	public static String getCookieValue(HttpServletRequest req, String fieldName){
	   String retVal = null;
	   Cookie[] c = req.getCookies();
	   for(int i=0; i < c.length; i++) {
		   if(fieldName.equalsIgnoreCase(c[i].getName())) {
			   retVal = c[i].getValue();
		   }
	   }
	   return retVal;
	}


	/**
	 * @return void
	 * @param res javax.servlet.http.HttpServletResponse
	 * @param cookieName String
	 * @param cookieValue String
	 */
	public static void addCookie(HttpServletResponse res, String cookieName, String cookieValue)
	{
		if (cookieName != null && cookieValue != null) {
			Cookie cookie = new Cookie(cookieName,cookieValue);
			res.addCookie(cookie);     // must call addCookie method before calling getWriter
		}
	}

	/**
	 * @return cookieValue String
	 * @param req javax.servlet.http.HttpServletRequest
	 * @param cookieName String
	 */
	public static String getCookie(HttpServletRequest req, String cookieName)
	{
		Cookie[] cookies = req.getCookies();

		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];

			if (thisCookie.getName().equals(cookieName))
				return thisCookie.getValue();
		}

		return null;
	}


	/**
	 * #.# 로 오는 string 값을 #.# float 값으로 변환
	 * (소수점 첫자리까지 display하는 경우에 유용)
	 */
	public static float fnfStringToFloat(String str) {
		float fTmp;

		try {
			fTmp = Float.valueOf(str).floatValue();
		}
		catch(Exception e) {
			fTmp = 0;
		}

		return fTmp;
	}

	/**
	 * 난수 생성
	 * input - int num: 0 ~ num 사이로 난수의 폭을 규정
	 * output - int : 생성된 난수
	 */
	public static int random(int num)
	{
		 if (num <= 0) return -1;

		 try{
			int gan=0;
			for(int i=0;i<2;i++){
				gan = (int)(Math.random()*num);
				System.out.println("random result[1] : "+gan + " loop=["+i+"]");
				if (gan > 0){
					System.out.println("random result[2] : "+gan);
					return gan;
				}
			}
		 }catch(Exception e){
			System.out.println("random error");
			return -1;
		 }
		 return 1;
	}

	/**
	 * 구분자에 따라 문자열 분리
	 * input - String str   : 분리할 문자열
	 *         int    nData : 분리할 갯수
	 *         char   _char : 구분자
	 * output - String[] : 분리된 문자열 배열
	 */
	public static String[] getData(String str, int nData, char _char)
	{
		String tempbuf;
		String rtnbuf[] = new String[nData];

		int j=0;
		tempbuf = str ;
		rtnbuf[0]="";
		for(int i=0;i<str.length();i++){
			if(tempbuf.charAt(i) == _char)	{
				j++;
				rtnbuf[j]="";
			}
			else
				rtnbuf[j] =  rtnbuf[j]+String.valueOf(tempbuf.charAt(i));
		}
		return rtnbuf;
	}

	/**
	 * 문자열길이 Byte로 처리
	 * input - String str   : 체크할 문자열
	 * output - int : 문자열 길이
	 */

	/**
	 * 한글인경우에 정확하지 않음. 아래의 메소드 사용
	 * date : 2005-08-05
	 * author: SI.rain
	public static int getLength(String str)
	{
	   if(str== null || str.equals("null") ){
			return 0;
	   }

	   byte b[] = str.getBytes();
	   int nSize = b.length;
	   return nSize;
	}
	*/
	public static int CharLen(String xxx){
	    int strlen = 0;

	    for(int j = 0; j<xxx.length(); j++){
	      char c = xxx.charAt(j);
	      if ( c  <  0xac00 || 0xd7a3 < c ) strlen++;
	      else  strlen+=2;  //한글이다..
	    }
	    return strlen;
	}



	public static long remainDate(int cyy,int cmm, int cdd, int sang_yy, int sang_mm, int sang_dd)
	{
		long return_day = 0;
		final int DAY = 86400000;

		Date date1 = new Date(cyy-1900,cmm-1,cdd);
		Date date2 = new Date(sang_yy-1900,sang_mm-1,sang_dd);

		long mills = date2.getTime() - date1.getTime();
		return_day = mills/DAY;

		return return_day;
	}

/*******************************************************************************
* Source 	String, separator String 으로 나눠 String[] 에 담아 리턴한다.
*
* @author 	feelhouse@orgio.net
* @param 	String source
* @param 	String separator
* @return 	String[]	- source == null : String[0] 에 ""값, separator == null : return String[0] 에 source값;
*******************************************************************************/
	public static String[] strSplit(String source, String separator){
		String[]	rtn 	= 	null;
		ArrayList	arrList	=	new ArrayList();

		// check null
		if(source == null || separator == null || separator.length() == 0) {
			rtn = new String[1];
			rtn[0] = "" + source;
			return rtn;
		}

		int p 	= 0;		// index(Starting point of separator)
		int i 	= 0;		// index(Slice Starting point)

		// slicing and storing
		while(true){
			p = source.indexOf(separator);
			if(p != -1){
				arrList.add(source.substring(0, p));
				source = source.substring(p + separator.length());
				if(i >= source.length()) break;
			}else{
				arrList.add(source);
				break;
			}
		}

		// Make String[]
		rtn = new String[arrList.size()];
		for(int j=0; j<arrList.size(); j++){
			rtn[j] = (String)arrList.get(j);
		}
		return rtn;
	}

	/**
	 * <pre>
	 * <li> 문자열을 substring하여 리턴, String.substring(int beginIndex, int endIndex)과 같은 기능이나
	 * 문자열위치 index는 byte단위 기준
	 * </pre>
	 * @param   inStr  문자열
	 * @param   beginIndex  the beginning index, inclusive
	 * @param   endIndex  the ending index, exclusive
	 * @return  String  substring 결과 문자열
	 * ex) substrB("홍길동abc123", 4, 10) returns "동abc1"
	 * @author 방성요
	 */
	public static String substrB(String inStr, int beginIndex, int endIndex){
		byte[] inBt = inStr.getBytes();
		byte[] outBt;
		String outStr = null;
		int length = endIndex - beginIndex;

		outBt = new byte[length];
		for(int i=0; i<length; i++){
			outBt[i] = inBt[beginIndex+i];
		}
		outStr = new String(outBt);
		return outStr;
	}



	/**
	 * <pre>
	 * <li> 전각 문자 ===> 반각 문자
	 * @param   string 전각 문자
	 * @return  String 반각 문자
	 * </pre>
	 * @author 방성요
	 */
	public static String fullToHalf( String string ) {
		int strLength = string.length();
		if( strLength > 0 ) {
			char[] chars = new char[strLength];
			string.getChars(0, strLength, chars, 0 );
			for( int i=0; i<strLength; i++ ) {
				if( chars[i] > 0xff00 && chars[i] <= 0xff5e ) {
					chars[i] -= 0xfee0;
				}
				else if( chars[i] == 0x3000 ) chars[i] = 0x20;
			 }
			 string = new String( chars );
		 }
		 return string;
	}


	/**
	* 기능 : 현재 시간를 FORMAT에 맞게 String으로 리턴
	*@return String  'HHMISS'
	* @author 송세준
	*/
	public synchronized static String getCurrentTime() {

		Calendar calendar = Calendar.getInstance(new Locale("KOREAN", "KOREA"));
		String hour = (calendar.get(Calendar.HOUR_OF_DAY)) < 10 ? "0" + calendar.get(Calendar.HOUR_OF_DAY) : "" + calendar.get(Calendar.HOUR_OF_DAY);
		String minute = (calendar.get(Calendar.MINUTE)) < 10 ? "0" + calendar.get(Calendar.MINUTE) : "" + calendar.get(Calendar.MINUTE);
		String second = calendar.get(Calendar.SECOND) < 10 ? "0" + calendar.get(Calendar.SECOND) : "" + calendar.get(Calendar.SECOND);
		return hour + minute + second;
	}

	/**
	* 기능 : 보관문서이관내역조회에서  문서명세스트림값을 리턴한다.
	*@return String  '2-1,2-2'
	* @author 송세준
	*/
	public static String docFormat(int qbook) {
		String docFormat = "";
		for(int i = 1 ; i <= qbook ; i++){
			docFormat = docFormat + qbook + "-" + i;
			if(i != qbook){
				docFormat = docFormat + ",";
			}
		}


		return docFormat;
	}
	/**
	 *기능 : 점수를받아서 레벨을 리턴해준다. <br>
	 *@param     str     점수값
	 *@return           레벨
	 */

	public static String getLevel(String str)  {

		String level = null;
		double range = 0.0;

	    if(str == null || str.equals("")) return "";
	    range = Double.parseDouble(str);
		if(range > 95.053 && range <= 100) 			level="A<sup>+</sup>";
		else if(range > 88.072 && range <= 95.053) 	level="A<sup>o</sup>";
		else if(range > 76.027 && range <= 88.072) 	level="B<sup>+</sup>";
		else if(range > 59.318 && range <= 76.072) 	level="B<sup>o</sup>";
		else if(range > 40.682 && range <= 59.318) 	level="C<sup>o</sup>";
		else if(range > 23.973 && range <= 40.682) 	level="D<sup>+</sup>";
		else if(range > 11.928 && range <= 23.973)	level="D<sup>o</sup>";
		else if(range > 4.947  && range <= 11.928) 	level="E<sup>+</sup>";
		else if(range >=     0 && range <= 4.947) 	level="E<sup>o</sup>";
		else if(range > 100) level="A<sup>+</sup>";
		else level="";
		return level;
	}
	/******************************************************
	 * 신상우 추가부
	 * *************************************************
	/**
	* 기능 : 이전 월을 FORMAT에 맞게 String 으로 리턴
	*@return String
	*/
	public synchronized static String getBeforeMonth() {

		Calendar calendar = Calendar.getInstance(new Locale("KOREAN", "KOREA"));
		String year, month,date = "";
		int tempMonth = calendar.get(Calendar.MONTH);
		if (tempMonth == 0 )
		{ // 현재 월이 1월인경우
			year = "" + (calendar.get(Calendar.YEAR) -1);
			month = "12";
			date = calendar.get(Calendar.DATE) < 10 ? "0" + calendar.get(Calendar.DATE) : "" + calendar.get(Calendar.DATE);
		} else { // 그 이외의 경우
			year = "" + calendar.get(Calendar.YEAR);
			month = (calendar.get(Calendar.MONTH)) < 10 ? "0" + (calendar.get(Calendar.MONTH)) : "" + (calendar.get(Calendar.MONTH));
			date = calendar.get(Calendar.DATE) < 10 ? "0" + calendar.get(Calendar.DATE) : "" + calendar.get(Calendar.DATE);
		}

		return year + month + date;
	}

	/**
	* 기능 : 이전 월을 FORMAT에 맞게 String 으로 리턴
	*@return String
	*/
	public synchronized static String getBeforeMonth(String currDate) {

		Calendar calendar = Calendar.getInstance(new Locale("KOREAN", "KOREA"));
		String year, month, date = "";
		int tempMonth = Integer.parseInt(currDate);
		if (tempMonth == 0 )
		{ // 현재 월이 1월인경우
			year = "" + (calendar.get(Calendar.YEAR) -1);
			month = "12";
			date = calendar.get(Calendar.DATE) < 10 ? "0" + calendar.get(Calendar.DATE) : "" + calendar.get(Calendar.DATE);
		} else { // 그 이외의 경우
			year = "" + calendar.get(Calendar.YEAR);
			month = (calendar.get(Calendar.MONTH) + 1) < 10 ? "0" + (calendar.get(Calendar.MONTH) + 1) : "" + (calendar.get(Calendar.MONTH) + 1);
			date = calendar.get(Calendar.DATE) < 10 ? "0" + calendar.get(Calendar.DATE) : "" + calendar.get(Calendar.DATE);
		}

		return year + month + date;
	}

	/**
	* 기능 : 이전 월을 FORMAT에 맞게 String 으로 리턴
	*@return String
	*/
	public synchronized static String getPeriodBeforeMonth(int period,String year,String month) {

		Calendar calendar = Calendar.getInstance(new Locale("KOREAN", "KOREA"));

		String strYear = "";
		String strMonth= "";

		int tempYear = Integer.parseInt(year);
		int tempMonth = Integer.parseInt(month);
        calendar.set(tempYear,tempMonth-(period-1),1);
		tempYear = calendar.get(Calendar.YEAR);
		tempMonth= calendar.get(Calendar.MONTH);

		if(tempMonth==0){
			strYear = String.valueOf((calendar.get(Calendar.YEAR) -1));
			strMonth= "12";
		}else{
			strYear = String.valueOf(calendar.get(Calendar.YEAR));
			strMonth= String.valueOf(Common.fillMonth(calendar.get(Calendar.MONTH)));
		}

		return strYear+"-"+strMonth;
	}


	/**
	* 기능 : 현재년 - period 만큼의 년을 FORMAT에 맞게 String 으로 리턴
	*@return String
	*/
	public synchronized static String getBeforeYear(int period, String currYear) {

		Calendar calendar = Calendar.getInstance(new Locale("KOREAN", "KOREA"));
		int tempYear = 0;
		String year = "";
		if ( currYear == null || currYear.equals("")) tempYear = calendar.get(Calendar.YEAR);
		else tempYear = Integer.parseInt(currYear);

		for ( int i = 0; i <= period; i++)
		{
			if ( i == 0 ) year = currYear;
			else year += "" + (tempYear - i);
		}

		return year;
	}
	//intVal 이 10 보다 작으면 "0"을 채우고 String 으로 변환하여 return
	public static String fillMonth(int intVal)
	{
		String returnVal = "";
		if ( intVal < 10) returnVal = "0" + String.valueOf(intVal);
		else returnVal = String.valueOf(intVal);

		return returnVal;
	}
	/**
	 * 입력한 날짜(YYYYMMDD)의 해당 연도와 해당 월의 일수를 반환
	 * @param strDate 날짜 String
	 * @return java.lang.String
	 */
	final private static int[] intLastDayOfMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	public static String getLastdayOfMonth(String strDate)
	{
		int intMonth = Integer.parseInt(strDate.substring(5,7));
		if ( intMonth == 2 && isLeapYear(strDate))
			return String.valueOf(intLastDayOfMonth[intMonth-1] + 1);
		else
			return String.valueOf(intLastDayOfMonth[intMonth-1]);
	}

	/**
	* 입력한 날짜(YYYYMMDD)의 해당 연도가 윤년인지를 반환
	* @param strDate 날짜 String
	* @return boolean 윤년이면 true / 평년이면 false;
	*/
	final public static boolean isLeapYear(String strDate)
	{
		int intYear = Integer.parseInt(strDate.substring(0,4));

		if ( intYear % 4 == 0 )
		{
			if ( intYear % 400 == 0 )
				return true;
			else if ( intYear % 100 == 0 )
				return false;
			else
				return true;
		}
		else
			return false;
	}


	/*기능 : 산식의 text 값을 반환한다..    <br>
	 *@param     num     value값
	 *@return            #,###,###,###
	 */
	public static String getCalcName(String calc_type) {
		String returnVal = "";
		if ( calc_type.equals("PC") ) returnVal = "(편람)";
		else if ( calc_type.equals("PE") ) returnVal = "ETL";
		else if ( calc_type.equals("PI") ) returnVal = "사용자입력";
		else if ( calc_type.equals("PX") ) returnVal = "엑셀";
		else if ( calc_type.equals("PO") ) returnVal = "평가단평가";
		else if ( calc_type.equals("PR") ) returnVal = "설문지평가";
		else if ( calc_type.equals("PT") ) returnVal = "(편람)";
		else if ( calc_type.equals("PM") ) returnVal = "(편람)";
		else if ( calc_type.equals("CO") ) returnVal = "공통코드항목";
		else if ( calc_type.equals("C1") ) returnVal = "1인당평균인건비";
		else if ( calc_type.equals("GA") ) returnVal = "철도공사득점";
		else if ( calc_type.equals("GM") ) returnVal = "14개공사평균득점";
		else if ( calc_type.equals("GC") ) returnVal = "공사점수중기준점수";
		else if ( calc_type.equals("AB") ) returnVal = "(편람)";
		else if ( calc_type.equals("FX") ) returnVal = "(편람)";
		else if ( calc_type.equals("CX") ) returnVal = "전년도항목실적";
		else if ( calc_type.equals("T1") ) returnVal = "특정항목값";
		else if ( calc_type.equals("T2") ) returnVal = "특정항목값";
		else if ( calc_type.equals("T3") ) returnVal = "특정항목값";

		return returnVal;
	}

	/*기능 : 산식의 text 값을 반환한다..    <br>
	 *@param     num     value값
	 *@return            #,###,###,###
	 */
	public static String getClassName(String calc_type) {
		String returnVal = "";
		if ( calc_type.equals("LE") ) returnVal = "엑셀";
		else if ( calc_type.equals("LJ") ) returnVal = "전자조달";
		else if ( calc_type.equals("LA") ) returnVal = "정부";
		else if ( calc_type.equals("LB") ) returnVal = "엑셀";
		else if ( calc_type.equals("LD") ) returnVal = "DW";
		else if ( calc_type.equals("LI") ) returnVal = "IRIS";
		else if ( calc_type.equals("LK") ) returnVal = "KRIFIS";
		else if ( calc_type.equals("LT") ) returnVal = "TAIS";
		else if ( calc_type.equals("LR") ) returnVal = "KROIS";

		return returnVal;
	}

	//==========================================
	/**
	* 기능 : 현재월 - period 만큼의 월을 FORMAT에 맞게 String 으로 리턴
	*@return String
	*/
	public synchronized static String getBeforeMonth(int period, String currYear, String currMonth) {

		Calendar calendar = Calendar.getInstance(new Locale("KOREAN", "KOREA"));
		boolean lastYear = false;
		String month = "";
		String year = "";
		int tempMonth = 0;

		if ( currYear == null || currMonth.trim().equals(""))
		{
			year = getBeforeMonth().substring(0,4) + "-";

		}else{
			year = currYear + "-";

		}


		if ( currMonth == null || currMonth.equals(""))
		{
			tempMonth = Integer.parseInt(getBeforeMonth().substring(4,6)); //전월.
		} else {
			tempMonth = Integer.parseInt(currMonth);
			if ( tempMonth == 0)
			{
				tempMonth = 12;
			}
		}

		for ( int i = 0; i < period; i++)
		{
			if ( i == 0)
			{
				if ( lastYear ) month += (Integer.parseInt(year.substring(0,4))-1)+ "-" + fillMonth(tempMonth) + "-" + getLastdayOfMonth(year+ fillMonth(tempMonth)) + ":";
				else month += year + fillMonth(tempMonth) + "-" + getLastdayOfMonth(year+ fillMonth(tempMonth)) + ":";

			} else {
				if ( tempMonth == 0)
				{
					month += (Integer.parseInt(year.substring(0,4))-1) + "-12-31:";
					year = String.valueOf(Integer.parseInt(year.substring(0,4))-1)+"-";
					tempMonth = 12;
					lastYear = true;
				} else {
					month += year + fillMonth(tempMonth) + "-" + getLastdayOfMonth(year+fillMonth(tempMonth)) + ":";
				}
			}
			tempMonth-=1;

		}
		return month;
	}
	/**
    * 입력된 데이터가 숫자이면 true / 아니면 false
    * @param strSource 입력데이터 String
    * @return java.lang.String
    */
    public static boolean isNumber(String strSource)
    {	boolean chk = false;
        try
        {
    		double douSource = Double.parseDouble(strSource);
            return true;
            }
        catch(NumberFormatException nfe)
        {
            return false;
        }
    }
	/**
	 *기능 : 받은 값을 #,###,###,##0.0 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@return            #,###,###,###
	 */

	public static String nullformat1(String str)  {
		DecimalFormat df = new DecimalFormat("###,###,###,###,###,###,###,###,###,###,###,##0.0");
		String retstr=null;
		String tempStr = null;
		try
		{

		    //Expression calculater 	= new Expression();

			if(str == null||str.equals("")){
			    tempStr="";
			    return tempStr;
			}
		    else {
		    	tempStr = str;
		    }
			retstr = df.format(Double.parseDouble(tempStr));
		    if ( retstr.substring(0,1).equals(".") ) retstr = "0"+retstr;
			return retstr;
		}catch(NumberFormatException nfe)
		{
			try
			{
				//Expression calculater 	= new Expression();
				if(str == null||str.equals(""))  tempStr="";
				else {
					tempStr = str;
				}
				retstr = df.format(Float.parseFloat(tempStr));
				if ( retstr.substring(0,1).equals(".") ) retstr = "0"+retstr;
				return retstr;
			}catch(Exception ee)
			{
				return "";
			}
		}catch(Exception e)
		{
			return "";
		}
	}
	/**
	 *기능 : 받은 값을 #,###,###,##0.0 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@return            #,###,###,###
	 */

	public static String[][] getBetaLevel(double Y , double S)  {
	    String actual[][] = new String[9][4];
		try
		{


			actual[0][0] = String.valueOf(Y + 1.65 * S) ;
			actual[0][1] = " " ;
			actual[0][2] = "A<sup>+</sup>";
			actual[0][3] = "P<sub>95.053</sub>";

			actual[1][0] = String.valueOf(Y + 1.179 * S);
			actual[1][1] = String.valueOf(Y + 1.65 * S) ;
			actual[1][2] = "A<sup>o</sup>";
			actual[1][3] = "P<sub>88.072</sub>";

			actual[2][0] = String.valueOf(Y + 0.707 * S);
			actual[2][1] = String.valueOf(Y + 1.179 * S);
			actual[2][2] = "B<sup>+</sup>";
			actual[2][3] = "P<sub>76.077</sub>";

			actual[3][0] = String.valueOf(Y + 0.236 * S) ;
			actual[3][1] = String.valueOf(Y + 0.707 * S);
			actual[3][2] = "B<sup>o</sup>";
			actual[3][3] = "P<sub>59.318</sub>";

			actual[4][0] = String.valueOf(Y - 0.236 * S) ;
			actual[4][1] = String.valueOf(Y + 0.236 * S) ;
			actual[4][2] = "C<sup>o</sup>";
			actual[4][3] = "P<sub>40.682</sub>";

			actual[5][0] = String.valueOf(Y - 0.707 * S) ;
			actual[5][1] = String.valueOf(Y - 0.236 * S) ;
			actual[5][2] = "D<sup>+</sup>";
			actual[5][3] = "P<sub>23.973</sub>";

			actual[6][0] = String.valueOf(Y - 1.179 * S) ;
			actual[6][1] = String.valueOf(Y - 0.707 * S) ;
			actual[6][2] = "D<sup>o</sup>";
			actual[6][3] = "P<sub>11.928</sub>";

			actual[7][0] = String.valueOf(Y - 1.65 * S) ;
			actual[7][1] = String.valueOf(Y - 1.179 * S) ;
			actual[7][2] = "E<sup>+</sup>";
			actual[7][3] = "P<sub>4.947</sub>";

			actual[8][0] = " " ;
			actual[8][1] = String.valueOf(Y - 1.65 * S) ;
			actual[8][2] = "E<sup>o</sup>";
			actual[8][3] = "이하";

		}catch(NumberFormatException nfe){

		}
		return actual;
	}
	/**
	 *기능 : 받은 값을 #,###,###,##0.0 형식으로 바꿈    <br>
	 *@param     str     core로 부터 받은 값
	 *@return            #,###,###,###
	 */

	public static String[][] get15Level(double Y , double S)  {
	    String actual[][] = new String[9][4];
		try
		{


			actual[0][0] = String.valueOf(Y - 1.65 * S) ;
			actual[0][1] = " " ;
			actual[0][2] = "A<sup>+</sup>";
			actual[0][3] = "P<sub>95.053</sub>";

			actual[1][0] = String.valueOf(Y - 1.179 * S);
			actual[1][1] = String.valueOf(Y - 1.65 * S) ;
			actual[1][2] = "A<sup>o</sup>";
			actual[1][3] = "P<sub>88.072</sub>";

			actual[2][0] = String.valueOf(Y - 0.707 * S);
			actual[2][1] = String.valueOf(Y - 1.179 * S);
			actual[2][2] = "B<sup>+</sup>";
			actual[2][3] = "P<sub>76.077</sub>";

			actual[3][0] = String.valueOf(Y - 0.236 * S) ;
			actual[3][1] = String.valueOf(Y - 0.707 * S);
			actual[3][2] = "B<sup>o</sup>";
			actual[3][3] = "P<sub>59.318</sub>";

			actual[4][0] = String.valueOf(Y + 0.236 * S) ;
			actual[4][1] = String.valueOf(Y - 0.236 * S) ;
			actual[4][2] = "C<sup>o</sup>";
			actual[4][3] = "P<sub>40.682</sub>";

			actual[5][0] = String.valueOf(Y + 0.707 * S) ;
			actual[5][1] = String.valueOf(Y + 0.236 * S) ;
			actual[5][2] = "D<sup>+</sup>";
			actual[5][3] = "P<sub>23.973</sub>";

			actual[6][0] = String.valueOf(Y + 1.179 * S) ;
			actual[6][1] = String.valueOf(Y + 0.707 * S) ;
			actual[6][2] = "D<sup>o</sup>";
			actual[6][3] = "P<sub>11.928</sub>";

			actual[7][0] = String.valueOf(Y + 1.65 * S) ;
			actual[7][1] = String.valueOf(Y + 1.179 * S) ;
			actual[7][2] = "E<sup>+</sup>";
			actual[7][3] = "P<sub>4.947</sub>";

			actual[8][0] = " " ;
			actual[8][1] = String.valueOf(Y + 1.65 * S) ;
			actual[8][2] = "E<sup>o</sup>";
			actual[8][3] = "이하";

		}catch(NumberFormatException nfe){

		}
		return actual;
	}

	public static double round(double val, int len) {
        double d = 1;
        for(int i=0; i<len; i++) d = d*10;
        return (double) Math.round(val*d)/d;
    }

    public static String toText(String s) {
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
}

