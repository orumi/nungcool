package com.nc.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Name			: FileDownload <br>
 * Summary		: ���� �ٿ�ε� <br>
 * Description	: ��ȯ�濡�� ���� �ٿ�ε� ����
 * 
 * @author 	KCC�������(��)
 * @version	1.0	2003/02/11
 * 
 */    
public class FileDownload 
{	  
	
	/**
	 * Method Name : flush <br>
	 * Method Description	: ��ȯ�濡�� ���� �ٿ�ε带 �����Ѵ� <br>
	 * 
	 * @param			HttpServletRequest
	 * @param			HttpServletResponse
	 * @param			�ٿ�ε�� ������ ������
	 * @throws			Exception
	 */
	public static void flush(HttpServletRequest objRequest, HttpServletResponse objResponse, String strFilePathName) throws Exception
	{		
			flush(objRequest, objResponse, strFilePathName, new File(strFilePathName).getName());	
	}
	
	
	
	/**
	 * Method Name : flush <br>
	 * Method Description	: ��ȯ�濡�� ���� �ٿ�ε带 �����Ѵ� <br>
	 * 
	 * @param			HttpServletRequest
	 * @param			HttpServletResponse
	 * @param			�ٿ�ε�� ������ ������
	 * @param			�ٿ�ε�� ������ ������ �̸�
	 * @throws			Exception
	 */
	public static void flush(HttpServletRequest objRequest, HttpServletResponse objResponse, String strFilePathName, String strFileName) throws Exception
	{			
		try
		{	
			if(strFileName == null || strFileName.trim().equals(""))
			{
				throw new Exception("�����̸��� ��ȿ���� �ʽ��ϴ�.");
			}
			
			String strBrowserVer  = objRequest.getHeader("user-agent"); 			
			String strEncFileName = new String(strFileName.trim().getBytes("euc-kr"), "ISO8859_1");
			//String strEncFileName = strFileName.trim();
			objResponse.setContentType("application/x-msdownload; charset=euc-kr");			
			
			if(strBrowserVer.indexOf("MSIE 5.5") != -1) 
			{  				
				objResponse.setHeader("Content-Disposition", "filename=" + strEncFileName + ";");
			} 
			else 
			{					
				objResponse.setHeader("Content-Disposition", "attachment;filename=" + strEncFileName + ";");
			} 
			
			File objFile = new File(strFilePathName);//���ϸ�����
			
			if(!objFile.isAbsolute())
		   	{
			    throw new Exception("���� ��ΰ� �ƴմϴ�.(����)");
		   	}
			else if(!objFile.exists())
			{
				throw new Exception("��� ������ �������� �ʽ��ϴ�.(����)");
			}
			else if(!objFile.isFile())
			{
				throw new Exception("������ �ƴմϴ�.(����)");
			}
			
			objResponse.setContentLength((int)objFile.length());
			objResponse.resetBuffer();
			
			byte[] aryByte  = new byte[(int)objFile.length()];

			if((int)objFile.length()>0 && objFile.isFile()) 
			{    
				BufferedInputStream objFileInput = new BufferedInputStream(new FileInputStream(objFile)); 
				BufferedOutputStream objResponseOutput = new BufferedOutputStream(objResponse.getOutputStream()); 
				int intRead = 0; 
				while ((intRead = objFileInput.read(aryByte)) != -1) 
				{ 
					objResponseOutput.write(aryByte, 0, intRead); 
				} 
	
				objResponseOutput.close(); 
				objFileInput.close(); 
				objResponseOutput.flush();
			}
		}
		catch (Exception objExcept)
		{			
			objExcept.printStackTrace();

			objResponse.setContentType("text/html;charset=euc-kr");
			objResponse.setHeader("Content-Disposition", "");
			
			throw objExcept;	
		} 
	}
}
