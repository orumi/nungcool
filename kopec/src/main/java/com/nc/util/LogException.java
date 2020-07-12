package com.nc.util;

/**
 * <pre>
 * <li>Program Name : BizException.java 
 * <li>Exception Object
 * <li>Date : 2004/06/14
 * <li>History :  2004/06/14 송세준 최초작성, 07/02 송세준 수정
 * <li>사용자정의 Exception 생성 및 처리
 * </pre>
 * @author 송세준
 * @see 
 */ 
public class LogException extends Exception
{  
 
	/**
	 * 
	 */
	public LogException() {
		super();
	}

	/**
	 * @param s java.lang.String
	 */
	public LogException(String s) {
		super(s);
	}
}
