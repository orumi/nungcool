package com.nc.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * ���󿡼� �ٿ�ε� �۾��� �����ϴ� ��ƿ��Ƽ
 * 
 * @author �ձǳ� 
 * @author ������ �߰�
 * @since 2008.06.26
 * @see �ַ�ǿ� �ִ� �ٿ�ε� ó�� ���� ���� ���� ó���� �־ ����. 
 */
public class DownloadUtil {

  /** �ٿ�ε� ���� ũ�� */
  private static final int BUFFER_SIZE = 8192; // 8kb

  /** ���� ���ڵ� */
  private static final String CHARSET = "euc-kr";

  /**
   * ������ - ��ü ���� �Ұ�
   */
  private DownloadUtil() {
    // do nothing;
  }

  /**
   * ������ ������ �ٿ�ε� �Ѵ�. �ٿ�ε� �� �����Ѵ�.
   * 
   * @param request
   * @param response
   * @param file
   *            �ٿ�ε��� ����
   * 
   * @throws ServletException
   * @throws IOException
   */
  public static void download(HttpServletRequest request, HttpServletResponse response, File file)
      throws ServletException, IOException {

    String mimetype = request.getSession().getServletContext().getMimeType(file.getName());

    if (file == null || !file.exists() || file.length() < 0 || file.isDirectory()) {
      throw new IOException("���� ��ü�� Null Ȥ�� �������� �ʰų� ���̰� 0, Ȥ�� ������ �ƴ� ���丮�̴�.");
    }

    InputStream is = null;

    try {
      is = new FileInputStream(file);
      download(request, response, is, file.getName(), file.length(), mimetype);
    } finally {
      try {
        is.close();
      } catch (Exception ex) {
      }
      file.delete();
    }
  }
  
  

  /**
   * �ش� �Է� ��Ʈ�����κ��� ���� �����͸� �ٿ�ε� �Ѵ�.
   * 
   * @param request
   * @param response
   * @param is
   *            �Է� ��Ʈ��
   * @param filename
   *            ���� �̸�
   * @param filesize
   *            ���� ũ��
   * @param mimetype
   *            MIME Ÿ�� ����
   * @throws ServletException
   * @throws IOException
   */
  public static void download(HttpServletRequest request, HttpServletResponse response, InputStream is,
      String filename, long filesize, String mimetype) throws ServletException, IOException {
    String mime = mimetype;

    if (mimetype == null || mimetype.length() == 0) {
      mime = "application/octet-stream;";
    }
    

    byte[] buffer = new byte[BUFFER_SIZE];

    response.setContentType(mime + "; charset=" + CHARSET);

    // �Ʒ� �κп��� euc-kr �� utf-8 �� �ٲٰų� URLEncoding�� ���ϰų� ���� �׽�Ʈ��
    // �ؼ� �ѱ��� ���������� �ٿ�ε� �Ǵ� ������ �����Ѵ�.
    
    String userAgent = request.getHeader("User-Agent");


    
    if (userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 ����
      response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(filename, "UTF-8") + ";");
    } else if (userAgent.indexOf("MSIE") > -1) { // MS IE (������ 6.x �̻� ����)
      response.setHeader("Content-Disposition", "attachment; filename="
          + java.net.URLEncoder.encode(filename, "UTF-8") + ";");
    } else { // ������ �����
      response.setHeader("Content-Disposition", "attachment; filename="
          + new String(filename.getBytes(CHARSET), "latin1") + ";");
    }
    

    // ���� ����� ��Ȯ���� �������� �ƿ� �������� �ʴ´�.
    if (filesize > 0) {
      response.setHeader("Content-Length", "" + filesize);
    }
    
    BufferedInputStream fin = null;
    BufferedOutputStream outs = null;
    
    try {
      fin = new BufferedInputStream(is);
      outs = new BufferedOutputStream(response.getOutputStream());
      int read = 0;

      while ((read = fin.read(buffer)) != -1) {
        outs.write(buffer, 0, read);
      }
    } finally {
      try {
        outs.close();
      } catch (Exception ex1) {
      }

      try {
        fin.close();
      } catch (Exception ex2) {

      }
    } // end of try/catch
  }

  /**
   * ������ ������ �ٿ�ε� �Ѵ�. �ٿ�ε� �� ������ ���� �ʴ´�.
   * 
   * @param request
   * @param response
   * @param file
   *            �ٿ�ε��� ����
   * 
   * @throws ServletException
   * @throws IOException
   */
  public static void downloadNotDelete(HttpServletRequest request, HttpServletResponse response, File file)
      throws ServletException, IOException {

    String mimetype = request.getSession().getServletContext().getMimeType(file.getName());

    if (file == null || !file.exists() || file.length() < 0 || file.isDirectory()) {
      throw new IOException("���� ��ü�� Null Ȥ�� �������� �ʰų� ���̰� 0, Ȥ�� ������ �ƴ� ���丮�̴�.");
    }

    InputStream is = null;

    try {
      is = new FileInputStream(file);
      download(request, response, is, file.getName(), file.length(), mimetype);
    } finally {
      try {
        is.close();
      } catch (Exception ex) {
      }
    }
  }
}