package tems.com.common;

import java.util.*;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.*;
/**
 * @class StringUtils
 * @brief 문자열 처리 공통함수
 * @version 0.1
 * @author Gn
 */
public class StringUtils {
    /**
     * filePathBlackList
     * 문자열처리
     * @param      value   문자열객체
     * @return  
     */
    public static String filePathBlackList(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            return "";
        }

        returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
        returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

        return returnValue;
    }

    /**
     * hashMapValue
     * HashMap에서 콤보로된 값읽기 처리
     * @param      value   문자열객체
     * @return  
     */
    public static String hashMapValue(HashMap basMap,String key){
       String retValue="<option value=''></option>";
       try {
            retValue  =(String)basMap.get(key);
       } catch(Exception e){
          retValue="<option value=''></option>";
       }
       //System.out.println("##############  key ("+key+")###########::"+retValue);
       return retValue;
    }

    /**
     * nvl
     * null인경우 문자열처리
     * @param      value   문자열객체
     * @return  String
     */
    public static String nvl(String value, String changeValue) {
        return value==null?changeValue:value;
    }


    /**
     * notNull
     * null,space Check
     * @param      str   
     * @return     boolean
     */
    public static boolean notNull(String str){
        boolean flag = false;

        if(str != null && !"".equals(str)){
            flag = true;
        }

        return flag;
    }

    /**
     * notNull
     * null check
     * @param      str   
     * @return     boolean
     */
    public static boolean isNull(String str){
        boolean flag = false;

        if(str == null || "".equals(str)){
            flag = true;
        }

        return flag;
    }


    /**
     * changeEmpty
     * 마지막 공백 제거
     * @param      str   
     * @return     String
     */
    public static String changeEmpty(String str) {
        String tmpStr = str;
        if(tmpStr != null & !"".equals(tmpStr)){
            tmpStr = tmpStr.trim();
        }else{
            tmpStr = "";
        }

        return tmpStr;
    }

    /**
     * changeEmpty
     * str 공백이나 null 이면 DEFAULT str 로 대체
     * @param      str   
     * @return     String
     */
    public static String changeEmpty(String str, String def) {
        String tmpStr = str;
        String tmpDef = def;
        if(tmpStr != null & !"".equals(tmpStr)){
            tmpStr = tmpStr.trim();
        }else{
            tmpStr = tmpDef;
        }

        return tmpStr;
    }
    
    /**
     * GetTokenElement
     * str to Array Token
     * @param      str   
     * @return     String
     */
    public static String[] GetTokenElement(String rsStr,String flag){
        StringTokenizer stok    = new StringTokenizer(rsStr,flag);
        String[]        sTokens = new String[stok.countTokens()];
        for (int i = 0; stok.hasMoreElements();i++){
            sTokens[i] = ((String)stok.nextElement()).trim();
        }
        return sTokens;
    }



 
    /**
     * getOraErrMsg
     * str to Array Token
     * @param      str   
     * @return     String
     */
    public static String getMessageParsing(String rsStr){
        if(rsStr == null) return "Null Point Exception........";
        int nlastIndexOf = (rsStr).lastIndexOf("ORA-");
        
        String oraCd =  "";
        String oranm =  rsStr;
        if(nlastIndexOf>=0){
           oraCd =  (rsStr.substring(nlastIndexOf)).substring(0,10);
           oranm =  (rsStr.substring(nlastIndexOf)).substring(11);
        }
        oranm = oranm.replaceAll("java.lang.Exception:","");
        oranm = oranm.replaceAll("kr.go.kihelims.common.exception.GeneralException:","");
        oranm = oranm.replaceAll("kr.go.kihelims.common.exception.SprocException:","");
        oranm = oranm.replaceAll("kr.go.kihelims.common.exception.JsonException:","");
        oranm = oranm.replaceAll("java.io.IOException:","");
        oranm = oranm.replaceAll("org.apache.ibatis.exception:","");
        oranm = oranm.replaceAll("java.lang.IllegalArgumentException:","");
        oranm = oranm.replaceAll("org.apache.ibatis.exceptions.PersistenceException:","");
        return oranm.trim();
    }

    /**
     * isInt
     * 숫자 여부 확인
     * @param      str   
     * @return     boolean
     */
    public static boolean isInt(String str) {
        boolean result = true;
        try{
            Integer.parseInt(str);
        } catch (Exception e) {
            result = false;
        }
        return result;
    }
    public static String eng(String str) throws UnsupportedEncodingException {
        if(str == null) return null; 
        return new String(str.getBytes("UTF-8"), "8859_1");
    }

   /**
    *  long type의 숫자값을 받아서 콤마를 가진 String type의 값으로
    *  바꾸어서 그 값을 돌려주는 메서드이다.  
    <br>
    * Usage : UtilFormat.commaDecimal(1235556.987);
    <br> return value : 1,235,556.987 
    * @param  paramMoney 형태변환 하고자 하는 금액
      @return String 콤마를 추가한 숫자String
    */
   public static String commaDecimal(double paramMoney){
      NumberFormat dformat = NumberFormat.getInstance();  
      return(dformat.format(paramMoney));   
   }   



   /**
    *  입력받은 String을 원하는 길이만큼 원하는 문자로 오른쪽을 채워주는 함수
     @param 
     @return String value 를 반환한다.
   */
   public static  String RPAD(String str, int len, char pad) {
      String result = str;
      int templen = len - result.getBytes().length;
      for (int i = 0; i < templen; i++) {
          result = result + pad;
      }
      return result;
   }


   /**
    *  입력받은 String을 원하는 길이만큼 원하는 문자로 왼쪽을 채워주는 함수
     @param 
     @return String value 를 반환한다.
   */
   public static String LPAD(String str, int len, char pad) {
        String result = str;
        int templen = len - result.getBytes().length;

        for (int i = 0; i < templen; i++)
            result = pad + result;

        return result;
   }

   public static String cropByte(String str, int i, String trail) {
       if (str==null) return "";
       String tmp = str;
       int slen = 0, blen = 0;
       char c;
       try {
           if(tmp.getBytes("MS949").length>i) {
            while (blen+1 < i) {
             c = tmp.charAt(slen);
             blen++;
             slen++;
             if ( c  > 127 ) blen++;  //2-byte character..
            }
            tmp=tmp.substring(0,slen)+trail;
           }
          } catch(java.io.UnsupportedEncodingException e) {}
       return tmp;
    }

    /**
     * 숫자(<code>double</code>)를 주어진 format 문자열에 따라 formatting한다.
     *
     * <ul type="square">
     *  <li><code>java.text.DecimalFormat</code>의 Special Pattern Characters 참조</li>
     *  <li>예를 들어, formatNum(300.4, "##.00");는 300.40을 반환한다.</li>
     * </ul>
     *
     * @param   num   실수(<code>double</code>) 데이터
     * @param   formatStr   format 문자열
     * @return   formatting된 문자열
     */
    public static String formatNum(double num, String formatStr)
    {
        return new DecimalFormat(formatStr).format(num);
    }

    public static HashMap<String, Object> ConvertObjectToMap(Object obj) throws 
        IllegalAccessException, 
        IllegalArgumentException, 
        InvocationTargetException {
            Class<?> pomclass = obj.getClass();
            pomclass = obj.getClass();
            Method[] methods = obj.getClass().getMethods();


            HashMap<String, Object> map = new HashMap<String, Object>();
            for (Method m : methods) {
               if (m.getName().startsWith("get") && !m.getName().startsWith("getClass")) {
                  Object value = (Object) m.invoke(obj);
                  String types = m.getReturnType().toString();
                  if ((Object) value == null){
                     if(types.equals("java.lang.Boolean")){
                    	 map.put(m.getName().substring(3),false);
                     } else if(types.equals("java.lang.Double")){
                    	 map.put(m.getName().substring(3),0);
                     } else if(types.equals("java.lang.Float")){
                    	 map.put(m.getName().substring(3),0);
                     } else if(types.equals("java.lang.Integer")){
                    	 map.put(m.getName().substring(3),0);
                     } else if(types.equals("java.lang.Long")){
                    	 map.put(m.getName().substring(3),0);
                     } else if(types.equals("java.lang.Number")){
                    	 map.put(m.getName().substring(3),0);
                     } else {
                   	   map.put(m.getName().substring(3),"");
                     }
                  } else{
                    map.put(m.getName().substring(3), (Object) value);
                  }
                  ////System.out.println("Nmae:"+m.getName().substring(3)  +"  value:"+map.get(m.getName().substring(3)) );
               }
            }
        return map;
   }
    
    public static String ArrayToString(Object[] a) {
        if (a == null)
            return "null";
	int iMax = a.length - 1;
        if (iMax == -1)
            return "";

        StringBuilder b = new StringBuilder();
	
        for (int i = 0; ; i++) {
            b.append(String.valueOf(a[i]));
            if (i == iMax)
		return b.toString();
	    b.append(", ");
        }
    }
}
