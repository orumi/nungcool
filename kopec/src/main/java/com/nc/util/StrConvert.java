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
	 	* java �ڵ忡�� 	 
	    * ���ڿ��� �޾Ƶ鿩 ���ڿ� ������ ù�ٿ� : �� ���δ�. 
	    * �Խ��ǿ��� reply�� ���� ���� ó���� ��� ���ȴ�. 
	    * @param msg ������ ���ڿ� 
	    * @return ����� ���ڿ� 
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
	         if(msg.charAt(i) == '&') //�����ڵ�� ���ڵ��Ǹ� & �� �����ؼ� ; �� ������ ������ �� ���̿� �ִ� ���ڿ��� ���� ���ڿ��� ġȯ.
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
		        			 i=+j;	//���� ��ȯ�� Ư������ �����ڵ尡 &amp; ���  &amp; <= ��� �� ���̸�ŭ i �� ���� ������� �ߺ����� �ʴ´�. 
		        			 
	        			 }
	        			 else if(msg.subSequence(i, j+1).equals("&nbsp;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&nbsp;", " "));
	        				 sb.append(" ");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//���� ��ȯ�� Ư������ �����ڵ尡 &amp; ���  &amp; <= ��� �� ���̸�ŭ i �� ���� ������� �ߺ����� �ʴ´�. 
		        			 	        				 
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
	 	* �������� 	 
	    * �Խ��ǿ��� reply�� ���� ���� ó���� ��� ���ȴ�. 
	    * @param msg ������ ���ڿ� 
	    * @return ����� ���ڿ� 
	    */ 
	   public static void reConvertServ(HttpServletRequest request, HttpServletResponse response)	//�������� ����.
//	   public static String reContent(String msg)
	   { 
		  String msg = (String)request.getAttribute("str");   
//	     msg = convertChar(msg); 
	      StringBuffer sb = new StringBuffer(); 
//	      sb.append(":"); 
	      for(int i = 0; i < msg.length(); i++) 
	      { 
	         if(msg.charAt(i) == '&') //�����ڵ�� ���ڵ��Ǹ� & �� �����ؼ� ; �� ������ ������ �� ���̿� �ִ� ���ڿ��� ���� ���ڿ��� ġȯ.
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
		        			 i=+j;	//���� ��ȯ�� Ư������ �����ڵ尡 &amp; ���  &amp; <= ��� �� ���̸�ŭ i �� ���� ������� �ߺ����� �ʴ´�. 
		        			 
	        			 }
	        			 else if(msg.subSequence(i, j+1).equals("&nbsp;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&nbsp;", " "));
	        				 sb.append(" ");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//���� ��ȯ�� Ư������ �����ڵ尡 &amp; ���  &amp; <= ��� �� ���̸�ŭ i �� ���� ������� �ߺ����� �ʴ´�. 
		        			 	        				 
	        			 }
	        			 else if(msg.subSequence(i, j+1).equals("&#145;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&#145;", "��"));
	        				 sb.append("��");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//���� ��ȯ�� Ư������ �����ڵ尡 &amp; ���  &amp; <= ��� �� ���̸�ŭ i �� ���� ������� �ߺ����� �ʴ´�. 
	        			 }
	        			 else if(msg.subSequence(i, j+1).equals("&#147;"))
	        			 {
	        				 System.out.println(msg.subSequence(i, j+1).toString().replaceAll("&#147;", "��"));
	        				 sb.append("��");
	        				 
//		        			 sb.append(msg.subSequence(i, j+1).toString().replaceAll("&amp;", "&"));
		        			 i=+j;	//���� ��ȯ�� Ư������ �����ڵ尡 &amp; ���  &amp; <= ��� �� ���̸�ŭ i �� ���� ������� �ߺ����� �ʴ´�. 
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
	    * ���ڿ��� �޾Ƶ鿩 &, ", \, <, > ���� ���ڸ� &amp;, &quot;, &#039, &lt; , &gt;�� �����Ѵ�. 
	    * @param msg ������ ���ڿ� 
	    * @return ����� ���ڿ� 
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


