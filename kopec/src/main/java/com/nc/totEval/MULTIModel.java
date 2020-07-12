package com.nc.totEval;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import com.nc.util.Common;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MULTIModel {
	public String command;

	public String year;

	public String halfYear;

	public String part;

	public String subpart;

	public String filename;

	public String FilePath;

	public String originalName;

	public String changeName;

	public String convertNameFile;

	MultipartRequest multi = null;

	public MULTIModel(HttpServletRequest objRequest, String FilePath)
			throws Exception {
		try {
			this.FilePath = FilePath;
			this.multi = new MultipartRequest(objRequest, FilePath,
					20 * 1024 * 1024, "euc-kr", new DefaultFileRenamePolicy());

			this.command = this.get(multi.getParameter("command"));
			this.year = this.get(multi.getParameter("year"));
			this.halfYear = this.get(multi.getParameter("semi"));
			this.part = this.get(multi.getParameter("part"));
			this.subpart = this.get(multi.getParameter("subpart"));
			this.filename = this.get(multi.getParameter("filename"));

		} catch (Exception e) {
			throw e;
		}
	}

	public void upLoad(String FilePath) throws Exception {
		try {
			this.FilePath = FilePath;

			File objFile = multi.getFile(multi.getParameter("filename"));
			this.originalName = multi.getOriginalFileName("filename");
			this.changeName = multi.getFilesystemName("filename");

		} catch (Exception e) {
			throw e;
		}
	}

	public void renameTo() throws Exception {
		try {
			this.convertNameFile = Common.getCurrentDate() + "_" + changeName;

			File oldNameFile = new File(FilePath + "/" + changeName);
			File newNameFile = new File(FilePath + "/" + convertNameFile);
			
			// 같은 이름의 파일이 존재하면 지운다.
			if (newNameFile.exists())
				newNameFile.delete();

			oldNameFile.renameTo(newNameFile);
		} catch (Exception e) {
			throw e;
		}
	}

	public void renameTo(String tag) throws Exception {
		try {
			this.convertNameFile = tag + "_" + Common.getCurrentDate() + "_"
					+ changeName;

			File oldNameFile = new File(FilePath + "/" + changeName);
			File newNameFile = new File(FilePath + "/" + convertNameFile);

			oldNameFile.renameTo(newNameFile);

		} catch (Exception e) {
			throw e;
		}
	}

	public String get(String key) {
		if (key == null)
			return "";
		else
			return key;
	}

	public String getParam(String key) {
		return get(multi.getParameter(key));
	}
}
