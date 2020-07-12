package com.nc.util;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StrConvert 
{
	public StrConvert()
	{
		
	}
	/** 
	 	* java 코드에서 	 
	    * 문자열을 받아들여 문자열 각각의 첫줄에 : 를 붙인다. 
	    * 게시판에서 reply에 대한 글을 처리할 경우 사용된다. 
	    * @param msg 변경할 문자열 
	    * @return 변경된 문자열 
	    */ 
//	   public static void reContent(HttpServletRequest request, HttpServletResponse response)
	   public static String reConvert(String msg)
	   { 
//		  String msg = (String)request.getAttribute("str");   
//	     msg = convertChar(msg); 
	      StringBuffer sb = new StringBuffer(); 
//	      sb.append(":"); 
	      for(int i = 0; i < msg.length(); i++) 
	      { 
	         if(msg.charAt(i) == '&') //유니코드로 인코딩되면 & 로 시작해서 ; 로 끝나기 때문에 그 사이에 있는 문자열을 원래 문자열로 치환.
	         {
	        	 for(int j = i; j < msg.length(); j++)
	        	 {
	        		 if(msg.charAt(j) == ';')
	        		 {
	        			 if(msg.subSequence(i, j+1).equals("&amp;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
	        				 sb.append("&");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//만약 변환된 특수문자 유니코드가 &amp; 라면  &amp; <= 요놈 의 길이만큼 i 를 증가 시켜줘야 중복되지 않는다. 
		        			 
	        			 }
	        			 else if(msg.subSequence(i, j+1).equals("&nbsp;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&nbsp;", " "));
	        				 sb.append(" ");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//만약 변환된 특수문자 유니코드가 &amp; 라면  &amp; <= 요놈 의 길이만큼 i 를 증가 시켜줘야 중복되지 않는다. 
		        			 	        				 
	        			 }
	        		 }
	        	 }
	         }
	         else 
	         { 
	            sb.append(msg.charAt(i)); 
	         } 

	      }
//	      System.out.println(sb.toString());
//	      request.setAttribute("str", sb.toString());
	      return sb.toString(); 
	   } 

		/** 
	 	* 서블릿에서 	 
	    * 게시판에서 reply에 대한 글을 처리할 경우 사용된다. 
	    * @param msg 변경할 문자열 
	    * @return 변경된 문자열 
	    */ 
	   public static void reConvertServ(HttpServletRequest request, HttpServletResponse response)	//서블릿에서 사용시.
//	   public static String reContent(String msg)
	   { 
		  String msg = (String)request.getAttribute("str");   
//	     msg = convertChar(msg); 
	      StringBuffer sb = new StringBuffer(); 
//	      sb.append(":"); 
	      for(int i = 0; i < msg.length(); i++) 
	      { 
	         if(msg.charAt(i) == '&') //유니코드로 인코딩되면 & 로 시작해서 ; 로 끝나기 때문에 그 사이에 있는 문자열을 원래 문자열로 치환.
	         {
	        	 for(int j = i; j < msg.length(); j++)
	        	 {
	        		 if(msg.charAt(j) == ';')
	        		 {
	        			 if(msg.subSequence(i, j+1).equals("&amp;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
	        				 sb.append("&");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//만약 변환된 특수문자 유니코드가 &amp; 라면  &amp; <= 요놈 의 길이만큼 i 를 증가 시켜줘야 중복되지 않는다. 
		        			 
	        			 }
	        			 else if(msg.subSequence(i, j+1).equals("&nbsp;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&nbsp;", " "));
	        				 sb.append(" ");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//만약 변환된 특수문자 유니코드가 &amp; 라면  &amp; <= 요놈 의 길이만큼 i 를 증가 시켜줘야 중복되지 않는다. 
		        			 	        				 
	        			 }
	        			 else if(msg.subSequence(i, j+1).equals("&#145;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&#145;", "‘"));
	        				 sb.append("‘");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//만약 변환된 특수문자 유니코드가 &amp; 라면  &amp; <= 요놈 의 길이만큼 i 를 증가 시켜줘야 중복되지 않는다. 
	        			 }
	        			 else if(msg.subSequence(i, j+1).equals("&#147;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&#147;", "“"));
	        				 sb.append("“");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//만약 변환된 특수문자 유니코드가 &amp; 라면  &amp; <= 요놈 의 길이만큼 i 를 증가 시켜줘야 중복되지 않는다. 
	        			 }
	        		 }
	        	 }
	         }
	         else 
	         { 
	            sb.append(msg.charAt(i)); 
	         } 
	      }
//	      System.out.println(sb.toString());
	      request.setAttribute("Convstr", sb.toString());
//	      return sb.toString(); 
	   } 
	   
	   
	   /** 
	    * 문자열을 받아들여 &, ", \, <, > 등의 문자를 &amp;, &quot;, &#039, &lt; , &gt;로 변경한다. 
	    * @param msg 변경할 문자열 
	    * @return 변경된 문자열 
	    */ 
	   public static String convertChar(String msg){ 
	      StringBuffer sb = new StringBuffer(); 
	      for(int i = 0; i < msg.length(); i++) 
	      { 
	         if(msg.charAt(i) == '&') 
	         { 
	            sb.append("&amp;"); 
	         }
	         else if(msg.charAt(i) == '"')
	         { 
	            sb.append("&#147;"); 
	         }
	         else if(msg.charAt(i) == '\'')
	         { 
	            sb.append("&#145;"); 
	         }
	         else if(msg.charAt(i) == '<')
	         { 
	            sb.append("&lt;"); 
	         }
	         else if(msg.charAt(i) == '>')
	         { 
	            sb.append("&gt;"); 
	         } 
	         else if(msg.charAt(i) == ' ')
	         {
	        	 sb.append("&nbsp;"); 
	         }
	         else 
	            sb.append(msg.charAt(i)); 
	      } 
	      return sb.toString(); 
	   } 
//	   public static void main(String[] args)
//	   {
//		   String str = "aaa  aaa&";
//		   System.out.println("str     : " + str);
//		   String convStr = StrConvert.convertChar(str);
//		   System.out.println("convStr    : " + convStr);
//		   System.out.println("---------------------------------------------");
//		   
//		   System.out.println("deconvert    : " + StrConvert.reConvert(convStr));
//	   }
}


