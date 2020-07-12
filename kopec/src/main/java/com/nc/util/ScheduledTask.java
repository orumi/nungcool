/*
 * Created on 2005. 3. 18
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.nc.util;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

import java.util.TimerTask;

public abstract class ScheduledTask extends TimerTask{

    public ScheduledTask(){
    }

    public void schedule(long l, long l1){
        Scheduler.schedule(this, l, l1);
    }

    public void schedule(long l) {
        Scheduler.schedule(this, l);
    }
}
