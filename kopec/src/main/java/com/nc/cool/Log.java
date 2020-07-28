package com.nc.cool;

import org.apache.log4j.*;

public class Log {
	private static final Category cat = Category.getInstance("ncLog.txt");

    /**
     * 테스트 로그
     * @param str
     */
	public static void testlog(String str){
    	cat.debug("Just testing a log message with priority set to DEBUG");
    	cat.info ("Just testing a log message with priority set to INFO" );
    	cat.warn ("Just testing a log message with priority set to WARN" );
    	cat.error("Just testing a log message with priority set to ERROR");
    	cat.fatal("Just testing a log message with priority set to FATAL");
    	cat.info(str);
    }

	/**
	 * println : 기존 system.out.println에 익숙한 사람을 위한 배려...ㅎㅎㅎ
	 * @param str log 메시지
	 */
    public static void println(String str){
    	println(null, str);
    }

    //logLevel : DEBUG(1), INFO(2), WARN(3), ERROR(4), FATAL(5)
	public static void println(String mode, String s ){
		if (mode == null || "debug".equals(mode)||"1".equals(mode)){
			cat.debug(s);
		}else if ("info".equals(mode)||"2".equals(mode)){
			cat.info(s);
		}else if ("warn".equals(mode)||"3".equals(mode)){
			cat.warn(s);
		}else if ("error".equals(mode)||"4".equals(mode)){
			cat.error(s);
		}else if ("fatal".equals(mode)||"5".equals(mode)){
			cat.fatal(s);
		}else {
			cat.info(s);
		}
	}

	/**
	 * debug 개발하거나 디버그시에 체크 수준의 로그
	 * @param str log 메시지
	 */
    public static void debug(String str){ cat.debug(str); }

    /**
	 * info : 알림 수준의 로그
	 * @param str log 메시지
	 */
    public static void info(String str){ cat.info(str); }

    /**
	 * warn : 에러는 있지만 어플리케이션 구동에 문제가 없을때
	 * @param str log 메시지
	 */
    public static void warn(String str){ cat.warn(str); }

    /**
	 * error : 에러 발생시
	 * @param str log 메시지
	 */
    public static void error(String str){ cat.error(str); }

    /**
	 * fatal : 치명적인 에러
	 * @param str log 메시지
	 */
    public static void fatal(String str){ cat.fatal(str); }

}