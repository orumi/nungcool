package com.oreilly.servlet.multipart;

import java.io.File;
import com.nc.util.Common_Data;
import com.nc.util.Util;

public class ByUserIdFileRenamePolicy implements FileRenamePolicy {
	
	private String strCode = ""; //�и��� code��
	private String newFileName = "";	// rename �� ���ο� ���ϸ�
	/**
	 * �⺻ ������
	 */
	public ByUserIdFileRenamePolicy()
	{
		this( new String(""));
	}
	
	/**
	 * ������
	 * @param v : �и��� (String ��) 
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
		
		// ���� ���翩�� check.
//		if (!f.exists()) {
//			return f;
//		}
		Common_Data cd = new Common_Data();
		
		String name = null;			// original ���ϸ� 
		String ext = null;			// Ȯ����
		String body = null;			// Ȯ���� ������ �����̸�
		
		name = f.getName().replaceAll("&", "");
		
		int dot = name.lastIndexOf(".");
		if (dot != -1) {
			ext = name.substring(dot); // includes "."
			body = name.substring(0, dot);
		}else{
			body = name;
			ext = "";
		}
		
		// "�ð�" + "_" + "original���ϸ�" + "_" + "�и��ڵ��" + ".Ȯ����"
		body = cd.ReplaceCode1(body);
		newFileName = Util.getToDayTime() + ext;
		f = new File(f.getParent(), newFileName);
		
		return f;
	}
}
