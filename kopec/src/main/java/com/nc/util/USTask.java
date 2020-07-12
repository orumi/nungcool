/*
 * Created on 2005. 3. 18
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.nc.util;

import java.io.*;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class USTask extends ScheduledTask{

    public USTask(String s){
        cmd = s;
    }

    public USTask(){
    }

    public void setCommand(String s){
        cmd = s;
    }

    public String getCommand(){
        return cmd;
    }

    public void run(){
        try{
            Runtime runtime = Runtime.getRuntime();
            Process process = runtime.exec(cmd);
            int i = process.waitFor();
            String s1 = System.getProperty("line.separator");
            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(new BufferedInputStream(process.getInputStream())));
            StringBuffer stringbuffer = new StringBuffer();
            stringbuffer.append("Return value ");
            stringbuffer.append(i);
            stringbuffer.append(s1);
            stringbuffer.append(s1);
            stringbuffer.append("*** process output ***");
            stringbuffer.append(s1);
            String s;
            while((s = bufferedreader.readLine()) != null){
                stringbuffer.append(s);
                stringbuffer.append(s1);
            }
            stringbuffer.append("*** output end ***");
            stringbuffer.append(s1);
        }catch(Exception exception){
        }
    }

    String cmd;
}
