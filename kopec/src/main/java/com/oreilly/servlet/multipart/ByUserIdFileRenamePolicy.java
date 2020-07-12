package com.oreilly.servlet.multipart;

import java.io.File;
import com.nc.util.Common_Data;
import com.nc.util.Util;

public class ByUserIdFileRenamePolicy implements FileRenamePolicy {
	
	private String strCode = ""; //분리자 code명
	private String newFileName = "";	// rename 된 새로운 파일명
	/**
	 * 기본 생성자
	 */
	public ByUserIdFileRenamePolicy()
	{
		this( new String(""));
	}
	
	/**
	 * 생성자
	 * @param v : 분리자 (String 형) 
	 */
	public ByUserIdFileRenamePolicy(String v)
	{
		if ( v.length() < 1){
			this.strCode = "_";
		}else{
			this.strCode = v;
		}
		
	}
	
	public String getNewFileName(){
		return this.newFileName;
	}
	
	public File rename(File f) {
		
		// 파일 존재여부 check.
//		if (!f.exists()) {
//			return f;
//		}
		Common_Data cd = new Common_Data();
		
		String name = null;			// original 파일명 
		String ext = null;			// 확장자
		String body = null;			// 확장자 제외한 파일이름
		
		name = f.getName().replaceAll("&", "");
		
		int dot = name.lastIndexOf(".");
		if (dot != -1) {
			ext = name.substring(dot); // includes "."
			body = name.substring(0, dot);
		}else{
			body = name;
			ext = "";
		}
		
		// "시간" + "_" + "original파일명" + "_" + "분리코드명" + ".확장자"
		body = cd.ReplaceCode1(body);
		newFileName = Util.getToDayTime() + ext;
		f = new File(f.getParent(), newFileName);
		
		return f;
	}
}
