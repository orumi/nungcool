package com.nc.cool;

import java.io.*;
import java.util.*;
import java.util.zip.GZIPOutputStream;

import javax.servlet.*;
import javax.servlet.http.*;

import com.nc.etl.myETLTask;
import com.nc.sql.DBService;
import com.nc.util.Scheduler;
import com.nc.util.ServerStatic;

public class CoolServer extends HttpServlet {
	public static ServletConfig sysConfig;
	public static Config systemConfig;
	public static Properties systemProp;
	public static DBService dbservice;

  public CoolServer(){

  }

  public void init(ServletConfig servletconfig) throws ServletException {
    super.init(servletconfig);
    sysConfig = servletconfig;
    setContext();
    initSystem();

  }

  /**
   * setContext
   */
  private void setContext() {
    ServletContext servletcontext = sysConfig.getServletContext();
    File file = new File(servletcontext.getRealPath("/"));
    try {
       ServerStatic.REAL_CONTEXT_ROOT = file.getCanonicalPath();
    } catch(IOException ioexception) {
       ServerStatic.REAL_CONTEXT_ROOT = file.getAbsolutePath();
    }
    ServerStatic.WEB_INF = ServerStatic.REAL_CONTEXT_ROOT + File.separator + "WEB-INF";
    ServerStatic.SERVLET_ENGINE = servletcontext.getServerInfo();

    System.out.println("BSCManager.CoolCard System Starting... " );
  }

  private void initSystem() {
	    String s = System.getProperty("Cool_CONFIG", "system.properties");
	    systemConfig = new Config(s);
	    try {
	        systemConfig.load();
	        systemProp = systemConfig.getProperties();
	        /*
	        ServerStatic.UPPER = new Integer(systemProp.getProperty("UPPER","100")).intValue();
	        ServerStatic.HIGH = new Integer(systemProp.getProperty("HIGH","95")).intValue();
	        ServerStatic.LOW = new Integer(systemProp.getProperty("LOW","90")).intValue();
	        ServerStatic.LOWER = new Integer(systemProp.getProperty("LOWER","85")).intValue();
	        ServerStatic.LOWST = new Integer(systemProp.getProperty("LOWST","80")).intValue();
	         */
	        /**/
			ServerStatic.UPPER = 100;
	        ServerStatic.HIGH = 95;
	        ServerStatic.LOW = 90;
	        ServerStatic.LOWER = 85;
	        ServerStatic.LOWST = 80;
	        /**/

	        ServerStatic.COLOR01 = systemProp.getProperty("COLOR01","24FF2A");
	        ServerStatic.COLOR02 = systemProp.getProperty("COLOR02","FFFF00");
	        ServerStatic.COLOR03 = systemProp.getProperty("COLOR03","FF1701");
	        ServerStatic.DEFAULTCOLOR = systemProp.getProperty("DEFAULTCOLOR","D0D0D0");

	         //startScheduler();
	        ServerStatic.REAL_CONTEXT_ROOT = systemProp.getProperty("REALPATH","");

	        System.out.println("BSCManager.CoolCard System Starting... "+s );
	    } catch(Exception exception) {
	        System.err.println("Config.getDefaultConfig Error loading " + s + " : " + exception);
	    }


  }

  //Process the HTTP Get request
	  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  response.setContentType("application/html");
		  response.setContentType("text/html");
	      PrintWriter printwriter = response.getWriter();
	      printwriter.println("<html><body>");

	    try {
	    	printwriter.println("You Have Wrong Connection !");

		} catch (Exception e) {
			System.out.println(e);
		} finally {

		}
	    //printwriter.println("</body></html>");
	  }

  //Process the HTTP Post request
	  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  response.setContentType("application/html");
		  response.setContentType("text/html");
	      PrintWriter printwriter = response.getWriter();
	      printwriter.println("<html><body>");

	    try {
	    	printwriter.println("You Have Wrong Connection !");

		} catch (Exception e) {
			System.out.println(e);
		} finally {

		}
	  }

	  private void startScheduler() {
		 	//Scheduler.schedule(new myETLTask(), systemProp, "myETL" ,0L, 0x36ee80L); // 1min 60000L ; 1hour 0x36ee80L;
		    //Scheduler.schedule(new LogCheckerTask(), sysProp, "LOG", 60000L, 0x5265c00L);
		    //Scheduler.schedule(new SessionCheckerTask(), sysProp, "SESSION", 0x927c0L, 0x927c0L);
	  }


	  public static DBService getDBService(){
		  if (dbservice == null) dbservice = new DBService();
		  return dbservice;
	  }
	  public static Config getConfig() {
	      return systemConfig;
	  }

	  public static Properties getProperties() {
	      return systemProp;
	  }

	  public static String getProperty(String s) {
	      return systemProp.getProperty(s);
	  }

	  public static String getProperty(String s, String s1) {
	      return systemProp.getProperty(s, s1);
	  }

	  public static void setProperty(String s, String s1) {
		  systemProp.setProperty(s, s1);
	  }

}
