package com.nc.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Name			: FileDownload <br>
 * Summary		: 파일 다운로드 <br>
 * Description	: 웹환경에서 파일 다운로드 지원
 * 
 * @author 	KCC정보통신(주)
 * @version	1.0	2003/02/11
 * 
 */    
public class FileDownload 
{	  
	
	/**
	 * Method Name : flush <br>
	 * Method Description	: 웹환경에서 파일 다운로드를 지원한다 <br>
	 * 
	 * @param			HttpServletRequest
	 * @param			HttpServletResponse
	 * @param			다운로드될 파일의 절대경로
	 * @throws			Exception
	 */
	public static void flush(HttpServletRequest objRequest, HttpServletResponse objResponse, String strFilePathName) throws Exception
	{		
			flush(objRequest, objResponse, strFilePathName, new File(strFilePathName).getName());	
	}
	
	
	
	/**
	 * Method Name : flush <br>
	 * Method Description	: 웹환경에서 파일 다운로드를 지원한다 <br>
	 * 
	 * @param			HttpServletRequest
	 * @param			HttpServletResponse
	 * @param			다운로드될 파일의 절대경로
	 * @param			다운로드시 보여질 파일의 이름
	 * @throws			Exception
	 */
	public static void flush(HttpServletRequest objRequest, HttpServletResponse objResponse, String strFilePathName, String strFileName) throws Exception
	{			
		try
		{	
			if(strFileName == null || strFileName.trim().equals(""))
			{
				throw new Exception("파일이름이 유효하지 않습니다.");
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
			
			File objFile = new File(strFilePathName);//파일명포함
			
			if(!objFile.isAbsolute())
		   	{
			    throw new Exception("절대 경로가 아닙니다.(공통)");
		   	}
			else if(!objFile.exists())
			{
				throw new Exception("대상 파일이 존재하지 않습니다.(공통)");
			}
			else if(!objFile.isFile())
			{
				throw new Exception("파일이 아닙니다.(공통)");
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
