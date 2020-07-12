package com.nc.cool;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import com.nc.util.ServerStatic;
import com.nc.util.Util;

public class ReqUtil {
	HttpServletRequest req;

	/**
	 * 클래스 생성자
	 * @param request
	 */
	public ReqUtil(HttpServletRequest request){
		req = request;
	}

	/**
	 * request.getParameter 대체 함수
	 * @param paramName  파라메터명
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
	 */
    public String getParam(String paramName) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = req.getParameter(paramName)!=null?(String)encode(req.getParameter(paramName)):"";
		return s;
	}


	/**
	 * request.getParameter 대체 함수
	 * @param paramName  파라메터명
	 * @param nullStr    파라메터가 널일 경우 대체 문자
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
	 */
    public String getParam(String paramName, String nullStr) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = req.getParameter(paramName)!=null?(String)encode(req.getParameter(paramName)):nullStr;
		return s;
	}

    /**
     * 스트링을 받아서 system.properties의 설정에 맞춰 인코딩한 후 넘겨줌
     * @param s
     * @return
     * @throws UnsupportedEncodingException
     */
    static public String encode(String s) throws UnsupportedEncodingException{
		return getEncodingKr(s);
    }

    /**
     * 엔코딩의 타입을 구한다.
     * new String(s.getBytes("8859_1"),"utf-8") 나 new String(s.getBytes("8859_1"),"euc-kr")로 한글을 인코딩하는 경우
     * ????처럼 물음표로만 인코딩되는 경우와  제대로 한글이 나오는 경우 등 두가지 경우가 있다.
     * 그래서 먼저 값에서 ?를 소거한 뒤  new String(s.getBytes("8859_1"),"utf-8")나 new String(s.getBytes("8859_1"),"euc-kr")로
     * 인코딩해서 ?가 없다면 new String(s.getBytes("8859_1"),"utf-8") 나 new String(s.getBytes("8859_1"),"euc-kr")로 하는 것이 맞고
     * ?가 있다면 new String(s.getBytes("8859_1"),"utf-8") 나 new String(s.getBytes("8859_1"),"euc-kr")로 인코딩하기 전의 문자열이 한글이라는 뜻이다.
     * @param s
     * @return
     * @throws UnsupportedEncodingException
     */
    static public String getEncodingKr(String s) throws UnsupportedEncodingException{
    	String propValue = ServerStatic.WEB_CHARSET; //WEB_CHASET 값

    	String sTmp = s.replaceAll("\\?",""); //값에 ?값이 있을 수 있으므로 일단 소거한다.
    	sTmp= new String(sTmp.getBytes("8859_1"),propValue);  //?를 소거한 값을 인코딩한다.

    	if(sTmp.indexOf("?") > -1){    //물음표가 없으면 인코딩 안 한것을 넘기고
    		sTmp = s;
    	}else{							//물음표가 있으면 인코딩 한 것을 넘긴다.
    		sTmp= new String(s.getBytes("8859_1"),propValue);
    	}

    	return sTmp;

    }

    /**
     * 엔코딩의 타입을 구한다.
     * new String(s.getBytes("8859_1"),"utf-8") 나 new String(s.getBytes("8859_1"),"euc-kr")로 한글을 인코딩하는 경우
     * ????처럼 물음표로만 인코딩되는 경우와  제대로 한글이 나오는 경우 등 두가지 경우가 있다.
     * 그래서 먼저 값에서 ?를 소거한 뒤  new String(s.getBytes("8859_1"),"utf-8")나 new String(s.getBytes("8859_1"),"euc-kr")로
     * 인코딩해서 ?가 없다면 new String(s.getBytes("8859_1"),"utf-8") 나 new String(s.getBytes("8859_1"),"euc-kr")로 하는 것이 맞고
     * ?가 있다면 new String(s.getBytes("8859_1"),"utf-8") 나 new String(s.getBytes("8859_1"),"euc-kr")로 인코딩하기 전의 문자열이 한글이라는 뜻이다.
     * @param s
     * @param charset 변환할 문자 캐릭터셋
     * @return
     * @throws UnsupportedEncodingException
     */
    static public String getEncodingKrByCharSet(String s, String charset) throws UnsupportedEncodingException{
    	String sTmp = s.replaceAll("\\?",""); //값에 ?값이 있을 수 있으므로 일단 소거한다.
    	sTmp= new String(sTmp.getBytes("8859_1"),charset);  //?를 소거한 값을 인코딩한다.
    	if(sTmp.indexOf("?") > -1){    //물음표가 없으면 인코딩 안 한것을 넘기고
    		sTmp = s;
    	}else{							//물음표가 있으면 인코딩 한 것을 넘긴다.
    		sTmp= new String(s.getBytes("8859_1"),charset);
    	}

    	return sTmp;

    }

    /**
     * request.getParameter 대체 함수 static형
	 * @param request    request
	 * @param paramName  파라메터명
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
     */
    static public String getParam(HttpServletRequest request, String paramName) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null?(String)encode(request.getParameter(paramName)):"";
		return s;
	}

    /**
	 * request.getParameter 대체 함수 static형
	 * @param request    request
	 * @param paramName  파라메터명
	 * @param nullStr    파라메터가 널일 경우 대체 문자
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
	 */
    static public String getParam(HttpServletRequest request, String paramName, String nullStr) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null?(String)encode(request.getParameter(paramName)):nullStr;
		return s;
	}

    /**
     * getSession 대체 함수 static형
     * @param request    request
	 * @param paramName  세션명
	 * @param nullStr    세션가 널일 경우 대체 문자
	 * @return           세션값
     * @throws UnsupportedEncodingException
     */
    static public String getSession(HttpServletRequest request, String paramName, String nullStr) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = (request.getSession().getAttribute(paramName)!=null)?(String)encode(request.getSession().getAttribute(paramName).toString()):nullStr;
		return s;
	}

    /**
     * request.getParameter 대체 함수 static형, 변환할 문자 캐릭터셋 지정.
	 * @param request    request
	 * @param paramName  파라메터명
	 * @param charset    변환할 문자 캐릭터셋
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
     */
    static public String getParamc(HttpServletRequest request, String paramName, String charset) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null?(String)getEncodingKrByCharSet(request.getParameter(paramName), charset):"";
		return s;
	}

    /**
	 * request.getParameter 대체 함수 static형, 변환할 문자 캐릭터셋 지정.
	 * @param request    request
	 * @param paramName  파라메터명
	 * @param nullStr    파라메터가 널일 경우 대체 문자
	 * @param charset    변환할 문자 캐릭터셋
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
	 */
    static public String getParamc(HttpServletRequest request, String paramName, String nullStr, String charset) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null?(String)getEncodingKrByCharSet(request.getParameter(paramName), charset):nullStr;
		return s;
	}

    /**
     * request.getParameter 대체 함수 static형, 변환할 문자 캐릭터셋 UTF-8로 고정.
	 * @param request    request
	 * @param paramName  파라메터명
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
     */
    static public String getParamu(HttpServletRequest request, String paramName) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null?(String)getEncodingKrByCharSet(request.getParameter(paramName), "EUC-KR"):"";
		return s;
	}

    /**
	 * request.getParameter 대체 함수 static형, 변환할 문자 캐릭터셋 UTF-8로 고정.
	 * @param request    request
	 * @param paramName  파라메터명
	 * @param nullStr    파라메터가 널일 경우 대체 문자
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
	 */
    static public String getParamu(HttpServletRequest request, String paramName, String nullStr) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null? getEncodingKrByCharSet(request.getParameter(paramName) , "EUC-KR") :nullStr;

		return s;
	}

    static public String getNXSS(String value){

    	value = value.replaceAll("& lt;","<" ).replaceAll("& gt;",">" );
        value = value.replaceAll("& #40;","\\(").replaceAll("& #41;","\\)");
        value = value.replaceAll("& #39;","'");
        return value;
    }



    /**
	 * request.getParameter 대체 함수 static형, 변환할 문자 캐릭터셋 UTF-8로 고정.
	 * @param request    request
	 * @param paramName  파라메터명
	 * @param nullStr    파라메터가 널일 경우 대체 문자
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
	 */
    static public String getParamUTF(HttpServletRequest request, String paramName, String nullStr) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null?(String)getEncodingKrByCharSet(request.getParameter(paramName), "UTF-8"):nullStr;
		return s;
	}

    /**
     * request.getParameter 대체 함수 static형, 변환할 문자 캐릭터셋 EUC-KR 고정.
	 * @param request    request
	 * @param paramName  파라메터명
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
     */
    static public String getParame(HttpServletRequest request, String paramName) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null?(String)getEncodingKrByCharSet(request.getParameter(paramName), "EUC-KR"):"";
		return s;
	}

    /**
	 * request.getParameter 대체 함수 static형, 변환할 문자 캐릭터셋 EUC-KR로 고정.
	 * @param request    request
	 * @param paramName  파라메터명
	 * @param nullStr    파라메터가 널일 경우 대체 문자
	 * @return           파라메터값
	 * @throws UnsupportedEncodingException
	 */
    static public String getParame(HttpServletRequest request, String paramName, String nullStr) throws UnsupportedEncodingException{

    	//파라메터값 받기
    	paramName = paramName.trim();
		String s = request.getParameter(paramName)!=null?(String)getEncodingKrByCharSet(request.getParameter(paramName), "EUC-KR"):nullStr;
		return s;
	}


}
