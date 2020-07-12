package com.nc.util;

import java.util.Date;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Scheduler {

	private static Timer timer;

	static {
//		init();
	}

	public Scheduler(){

	}

	public static void init(){
		timer = new Timer(true);
	}

	public static void stop(){
		if(timer != null){
			timer.cancel();
			timer = null;
		}
	}

	public static void restart(){
//		stop();
//		init();
	}

	public static long getTimeMillis(String s){
		s = s.trim();
		int i = s.indexOf(' ');
		String s1 = null;
		String s2 = null;
		if(i<0){
			s1= s;
			s2="SECOND";
		} else {
			s1 = s.substring(0,i);
			s2 = s.substring(i+1).trim();
		}
		long l = 0L;
		if(s2.startsWith("SECOND"))
			l= 1000L;
		else if (s2.startsWith("MINUTE"))
			l=60000L;
		else if (s2.startsWith("HOUR"))
			l=0x36ee80L;
		else if (s2.startsWith("DAY"))
			l= 0x5265c00L;
		else
			;
		return l*Long.valueOf(s1).longValue();
	}

	public static void scheduleUserTasks(Properties properties){
		int i = 0;
		do{
label0:
{
		    String s = properties.getProperty("SCHEDULER.USER[" + i + "].CLASS");
		    String s1 = properties.getProperty("SCHEDULER.USER[" + i + "].COMMAND");
		    if(s1 == null && s == null)
		        return;
		    String s2 = properties.getProperty("SCHEDULER.USER[" + i + "].DELAY");
		    String s3 = properties.getProperty("SCHEDULER.USER[" + i + "].PERIOD");
		    long l = 0L;
		    long l1 = 0L;
		    if(s2 != null && s2.length() > 0)
		        l = getTimeMillis(s2);
		    if(s3 != null && s3.length() > 0)
		        l1 = getTimeMillis(s3);
		    USTask userscheduledtask;
		    if(s != null)
		        try {
		            userscheduledtask = (USTask)Class.forName(s).newInstance();
		        } catch(Exception exception){
		            //Log.error("Scheduler.scheduleUserTasks", "Failed to schedule task: SCHEDULER.USER[" + i + "].CLASS", exception);
		            break label0;
		        }
		    else
		    userscheduledtask = new USTask();
		    userscheduledtask.setCommand(s1);
		    schedule(userscheduledtask, l, l1);
}
		i++;
		}while(true); 
	}

	public static boolean hasSchedule(Properties properties, String s){
		String s1 = properties.getProperty("SCHEDULER."+s+".DELAY");
		String s2 = properties.getProperty("SCHEDULER."+s+".PERIOD");
		return s1 != null || s2 != null;
	}
   public static void schedule(TimerTask timertask, Properties properties, String s, long l, long l1){
        long l2 = l;
        long l3 = l1;
        String d = properties.getProperty("SCHEDULER." + s + ".STARTDATE");
        String s1 = properties.getProperty("SCHEDULER." + s + ".DELAY");
        String s2 = properties.getProperty("SCHEDULER." + s + ".PERIOD");
        Date startDate = null;
        try{
        	if(d != null && d.length() > 0)
        		startDate = Util.parseTimeSchedule(d);
        	else if(s1 != null && s1.length() > 0)
                l2 = getTimeMillis(s1);
            if(s2 != null && s2.length() > 0)
                l3 = getTimeMillis(s2);
        }catch(Exception exception){
            //Log.error("Scheduler.schedule", "Failed to parse " + s1 + " / " + s2, exception);
        }
        if (startDate != null)
        	schedule(timertask, startDate, l3);
        else
        	schedule(timertask, l2, l3);
    }

   public static void schedule(TimerTask timertask, Date d, long l){
	   if(timer != null)
		   timer.schedule(timertask,d,l);
   }
   
    public static void schedule(TimerTask timertask, long l, long l1){
        //if(l1 > 0L);
            //Log.info("Scheduler.schedule", "Schedule " + timertask.getClass().getName() + ", delay=" + l / 1000L + "s period=" + l1 / 1000L + "s");
        //else
            //Log.info("Scheduler.schedule", "Schedule " + timertask.getClass().getName() + ", delay=" + l / 1000L + "s");
        
        if(timer != null)
            if(l1 <= 0L)
                timer.schedule(timertask, l);
            else
                timer.schedule(timertask, l, l1);
    }

    public static void schedule(TimerTask timertask, long l){
//        schedule(timertask, l, 0L);
    }
}
