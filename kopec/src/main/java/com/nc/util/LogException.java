package com.nc.util;

/**
 * <pre>
 * <li>Program Name : BizException.java 
 * <li>Exception Object
 * <li>Date : 2004/06/14
 * <li>History :  2004/06/14 �ۼ��� �����ۼ�, 07/02 �ۼ��� ����
 * <li>��������� Exception ���� �� ó��
 * </pre>
 * @author �ۼ���
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
