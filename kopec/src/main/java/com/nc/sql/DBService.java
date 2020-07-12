package com.nc.sql;

import java.util.Properties;

import com.nc.cool.CoolServer;
import com.nc.sql.ConnectionManager;

public class DBService {
	  ConnectionManager conManager;
	  private boolean loaded;
	  private boolean loading;
	  
    public ConnectionManager getConnectionManager() {
        checkLoaded();
        return conManager;
    }
    public void checkLoaded() {
        if(!loaded)
            load();
    }
    private synchronized void load() {
        if(loading)
            return;
        loading = true;
        try {
            Properties pro = CoolServer.systemProp;

            if(conManager == null) {
                Properties properties = new Properties();
                properties.putAll(pro);
                properties.setProperty("DB_PASSWORD", pro.getProperty("DB_PASSWORD"));
                conManager = new ConnectionManager("", properties);
            }
             loaded = true;
             

        } catch(Exception exception) {
            System.out.println(exception);
        } finally {
            loading = false;
        }
    }
}
